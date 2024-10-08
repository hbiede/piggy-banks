//
//  SummaryHeader.swift
//  Piggy Banks
//
//  Created by Elijah Biede on 10/7/24.
//  Copyright © 2024 Empower. All rights reserved.
//

import SwiftUI

struct SummaryHeader: View {
    
    var account: Account
    
    var short = false
    
    var body: some View {
        VStack {
            Text("Savings goal")
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .tintable()
            Text(short ? account.totalSavingsGoal.shortCurrencyString : account.totalSavingsGoal.currencyString)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.largeTitle)
                .bold()
            Text("\(account.savedThisWeek.shortCurrencyString) This Week")
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(currencyColor(for: account.savedThisWeek))
                .tintable(false)
                .bold()
        }
    }
}
#if DEBUG
import SwiftData

#Preview(traits: .sampleData) {
    @Previewable @Query var accounts: [Account] = [Account]()
    
    SummaryHeader(account: accounts.first!)
        .modelContainer(for: Account.self, inMemory: true)
}
#endif
