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
                .minimumScaleFactor(0.2)
            Text(short ? account.totalSavingsBalance.shortCurrencyString : account.totalSavingsBalance.currencyString)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.largeTitle)
                .bold()
                .minimumScaleFactor(0.4)
            Text("\(account.savedThisMonth.shortCurrencyString) This Month")
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(currencyColor(for: account.savedThisWeek))
                .tintable(false)
                .bold()
                .minimumScaleFactor(0.2)
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
