//
//  Piggy_Bank_Widget.swift
//  Piggy Banks
//
//  Created by Elijah Biede on 10/7/24.
//  Copyright © 2024 Empower. All rights reserved.
//

import WidgetKit
import SwiftUI

extension Account: TimelineEntry {
    var date: Date {
        Date()
    }
}

struct Provider: TimelineProvider {
    typealias Entry = Account
    
    static func placeholder() -> Account {
        Account(piggyBanks: [PiggyBank(name: "My Piggy Bank", balance: 100)], transactions: [Transaction(date: Date(), amount: 100)])
    }
    
    func placeholder(in context: Context) -> Account {
        Provider.placeholder()
    }

    func getSnapshot(in context: Context, completion: @escaping (Account) -> ()) {
        completion(placeholder(in: context))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        completion(Timeline(entries: [placeholder(in: context)], policy: .atEnd))
    }
}

struct Piggy_Bank_WidgetEntryView : View {
    
    @Environment(\.widgetFamily)
    var widgetFamily
    
    var entry: Provider.Entry

    var body: some View {
        SummaryHeader(account: entry, short: widgetFamily == .systemSmall)
    }
}

struct Piggy_Bank_Widget: Widget {
    let kind: String = "Piggy_Bank_Widget"
    
    var supportedFamilies: [WidgetFamily] = [.systemSmall, .systemMedium]

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                Piggy_Bank_WidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                Piggy_Bank_WidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Piggy Bank Widget")
        .description("See your savings rate.")
    }
}

@main
struct Piggy_Bank_WidgetBundle: WidgetBundle {
    var body: some Widget {
        Piggy_Bank_Widget()
    }
}

#if DEBUG
#Preview(as: .systemSmall) {
    Piggy_Bank_Widget()
} timeline: {
    Provider.placeholder()
}
#endif
