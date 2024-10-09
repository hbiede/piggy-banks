//
//  AccountLandingView.swift
//  Piggy Banks
//
//  Created by Elijah Biede on 10/7/24.
//  Copyright © 2024 Empower. All rights reserved.
//

import SwiftUI

struct AccountLandingView: View {
    
    var account: Account
    
    var body: some View {
        ScrollView {
            VStack {
                SummaryHeader(account: account)
                
                // Piggy Banks
                HStack {
                    Text("Piggy banks")
                        .bold()
                        .font(.callout)
                    Spacer()
                    Text(account.piggyBankBalance.shortCurrencyString)
                        .multilineTextAlignment(.trailing)
                        .bold()
                        .font(.callout)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical)
                
                if !account.piggyBanks.isEmpty {
                    VStack {
                        ForEach(Array(account.piggyBanks.enumerated()), id: \.element.id) { index, bank in
                            if index > 0 {
                                Divider()
                            }
                            
                            AccountLandingPiggyBankView(piggyBank: bank)
                        }
                    }
                    .padding()
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(.gray2, lineWidth: 2))
                    
                    Spacer()
                }
                
                // CTA
                NavigationLink(destination: {
                    TransferView(account: account)
                }, label: {
                    Text("Transfer funds")
                        .foregroundStyle(Color.white)
                        .padding(16)
                        .background(.accent)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                })
                .padding(.vertical)
                
                // Other options
                NavigationLink(destination: {
                    RecommendationView(account: account)
                }, label: {
                    HStack {
                        Image(systemName: "plus")
                            .foregroundStyle(.link)
                        Text("Create piggy bank")
                            .foregroundStyle(.link)
                            .font(.subheadline)
                            .underline()
                    }
                })
            }
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        }
        .navigationTitle("Personal Cash account")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#if DEBUG
import SwiftData

#Preview(traits: .sampleData) {
    @Previewable @Query var accounts: [Account] = [Account]()
    
    AccountLandingView(account: accounts.first!)
        .modelContainer(for: Account.self, inMemory: true)
}
#endif
