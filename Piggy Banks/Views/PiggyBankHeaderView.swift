//
//  PiggyBankHeaderView.swift
//  Piggy Banks
//
//  Created by Elijah Biede on 10/7/24.
//  Copyright © 2024 Empower. All rights reserved.
//

import SwiftUI

struct PiggyBankHeaderView: View {
    var piggyBank: PiggyBank
    
    var body: some View {
        VStack {
            HStack {
                Text("\(piggyBank.name):")
                    .bold()
                
                Spacer()
                
                Text(piggyBank.balance.shortCurrencyString)
                    .bold()
            }
            
            if let goal = piggyBank.goal {
                let metGoal = piggyBank.balance.doubleValue > goal.doubleValue
                HStack {
                    ProgressView(value: metGoal ? goal.doubleValue : piggyBank.balance.doubleValue,
                                 total: goal.doubleValue)
                        .tint(metGoal ? Color.basil : Color.accentColor)
                        .padding(.trailing)
                    
                    if metGoal {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundStyle(.basil)
                    } else {
                        Text(piggyBank.balance.doubleValue / goal.doubleValue, format: .percent.precision(.fractionLength(0)))
                    }
                }
                
                HStack {
                    Text("Savings goal:")
                        .foregroundStyle(.secondary)
                    Text(goal.shortCurrencyString)
                        .foregroundStyle(.secondary)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
    }
}

#if DEBUG
import SwiftData

#Preview(traits: .sampleData) {
    @Previewable @Query var piggyBanks: [PiggyBank] = [PiggyBank]()
    
    PiggyBankHeaderView(piggyBank: piggyBanks.first!)
}
#endif
