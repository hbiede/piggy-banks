//
//  RecommendationView.swift
//  Piggy Banks
//
//  Created by Elijah Biede on 10/7/24.
//  Copyright © 2024 Empower. All rights reserved.
//

import SwiftUI

typealias Option = (name: String, shortName: String?, amount: Decimal?, image: Image)

private let options: [Option] = [
    // 6 months of $4000 expenses
    ("Emergency Fund", "Emergency", 24000, Image("emergency")),
    ("Travel", nil, nil, Image("travel")),
    ("Debt", nil, nil, Image("debt")),
    ("New Home", "New home", nil, Image("home")),
    ("Other", nil, nil, Image("other"))
]

struct RecommendationView: View {
    var account: Account
    
    var body: some View {
        VStack {
            Text("What would you like to do?")
            
            Spacer()
            
            LazyVGrid(columns: [GridItem(), GridItem()]) {
                ForEach(options.dropLast(options.count % 2), id: \.0, content: cell)
            }
            .padding(.top, 0)
            if options.count % 2 == 1, let last = options.last {
                LazyHStack {
                    cell(for: last)
                }
                .fixedSize(horizontal: false, vertical: true)
            }
            
            Spacer()
            
            Text("\"Users with multiple goals save more.\"")
            Text("- anonymous")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .navigationTitle("Recommendations")
    }
    
    private func cell(for option: Option) -> some View {
        VStack {
            option.image
            NavigationLink(destination: {
                EditPiggyBankView(account: account, name: option.name, amount: option.amount)
            }, label: {
                Text(option.shortName ?? option.name)
                    .padding(12)
                    .foregroundStyle(Color.white)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            })
        }
        .frame(width: 140, height: 140)
        .padding(.vertical)
    }
}

#if DEBUG
import SwiftData

#Preview {
    @Previewable @Query var accounts: [Account] = [Account]()
    
    RecommendationView(account: accounts.first!)
}
#endif
