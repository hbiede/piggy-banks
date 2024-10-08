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
                
                // CTA
                NavigationLink(destination: {
                    Text("Placeholder")
                }, label: {
                    Text("Transfer funds")
                        .foregroundStyle(Color.white)
                        .padding(16)
                        .background(.accent)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                })
                .padding(.vertical)
                
                // Other options
                ViewThatFits(in: .horizontal) {
                    HStack {
                        NavigationLink(destination: {
                            EditPiggyBankView(account: account)
                        }, label: {
                            Text("\(Image(systemName: "plus")) Create piggy bank")
                                .foregroundStyle(.link)
                                .font(.subheadline)
                        })
                        
                        NavigationLink(destination: {
                            RecommendationView(account: account)
                        }, label: {
                            Text("\(Image(systemName: "info.circle")) Get recomendations")
                                .foregroundStyle(.link)
                                .font(.subheadline)
                        })
                    }
                    
                    VStack {
                        NavigationLink(destination: {
                            EditPiggyBankView(account: account)
                        }, label: {
                            Text("\(Image(systemName: "plus")) Create piggy bank")
                                .foregroundStyle(.link)
                                .font(.subheadline)
                        })
                        
                        NavigationLink(destination: {
                            RecommendationView(account: account)
                        }, label: {
                            Text("\(Image(systemName: "info.circle")) Get recomendations")
                                .foregroundStyle(.link)
                                .font(.subheadline)
                        })
                    }
                }
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
