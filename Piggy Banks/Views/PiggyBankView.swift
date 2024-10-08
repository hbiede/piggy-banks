//
//  PiggyBankView.swift
//  Piggy Banks
//
//  Created by Elijah Biede on 10/7/24.
//  Copyright © 2024 Empower. All rights reserved.
//

import SwiftUI

struct PiggyBankView: View {
    var piggyBank: PiggyBank
    
    var body: some View {
        if let account = piggyBank.account {
            PiggyBankHeaderView(piggyBank: piggyBank)
                .padding(.horizontal)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: EditPiggyBankView(account: account, bank: piggyBank)) {
                            Image(systemName: "pencil")
                                .bold()
                        }
                    }
                }
        } else {
            PiggyBankHeaderView(piggyBank: piggyBank)
                .padding(.horizontal)
        }
        
        List {
            ForEach(piggyBank.transactions, id: \.id) { tran in
                HStack {
                    Text(tran.date.formatted(date: .numeric, time: .omitted))
                    Spacer()
                    Text(tran.amount.currencyString)
                }
            }
        }
    }
}

#if DEBUG
import SwiftData

#Preview(traits: .sampleData) {
    @Previewable @Query var piggyBanks: [PiggyBank] = [PiggyBank]()
    
    PiggyBankView(piggyBank: piggyBanks.first!)
}
#endif
