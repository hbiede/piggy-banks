//
//  ContentView.swift
//  Piggy Banks
//
//  Created by Elijah Biede on 10/7/24.
//  Copyright © 2024 Empower. All rights reserved.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var accounts: [Account] = [Account]()

    var body: some View {
        NavigationView {
            if let account = accounts.first {
                AccountLandingView(account: account)
            }
        }
    }
}

#if DEBUG
import SwiftData

#Preview(traits: .sampleData) {
    ContentView()
        .modelContainer(for: Account.self, inMemory: true)
}
#endif
