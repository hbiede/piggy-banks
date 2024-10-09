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
        ScrollView {
            VStack {
                Text("Make it easy for you to manage your financial life with this online saving feature.\nWhat would you like to do?")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.gray7)
                    .padding(.horizontal)
                    .padding(.top)
                
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
            }
            .padding(.horizontal)
        }
        .navigationTitle("Recommendations")
    }
    
    private func cell(for option: Option) -> some View {
        VStack {
            option.image
                .resizable(resizingMode: .stretch)
                .scaledToFit()
                .aspectRatio(1, contentMode: .fit)
            NavigationLink(destination: {
                EditPiggyBankView(account: account, name: option.name, amount: option.amount)
            }, label: {
                Text(option.shortName ?? option.name)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 16)
                    .foregroundStyle(Color.white)
                    .background(.accent)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.horizontal)
            })
        }
        .frame(width: 150, height: 150)
        .padding(.vertical)
    }
}

#if DEBUG
import SwiftData

#Preview(traits: .sampleData) {
    @Previewable @Query var accounts: [Account] = [Account]()
    
    RecommendationView(account: accounts.first!)
}
#endif
