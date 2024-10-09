//
//  TransactionDetailView.swift
//  Piggy Banks
//
//  Created by Elijah Biede on 10/8/24.
//  Copyright © 2024 Empower. All rights reserved.
//

import SwiftUI

struct TransactionDetailView: View {
    
    var transaction: Transaction
    
    var body: some View {
        List {
            HStack {
                Text("Date")
                Spacer()
                Text(transaction.date.formatted(date: .abbreviated, time: .shortened))
            }
            HStack {
                Text("Amount")
                Spacer()
                Text(transaction.amount.magnitude.formatted(.currency(code: "USD")))
            }
            HStack {
                Text("Type")
                Spacer()
                Text(transaction.amount > 0 ? "Deposit" : "Withdrawal")
            }
            HStack {
                Text(transaction.amount > 0 ? "Source" : "Destination")
                Spacer()
                Text(transaction.otherAccount)
            }
            HStack {
                Text("Piggy Bank")
                Spacer()
                if let piggyBank = transaction.piggyBank {
                    Text(piggyBank.name)
                } else {
                    Text("None")
                }
            }
        }
        .listRowSeparator(.hidden)
        .navigationTitle("Transaction")
    }
}

#Preview {
}

#if DEBUG
import SwiftData

#Preview(traits: .sampleData) {
    @Previewable @Query var accounts: [Account] = [Account]()
    
    TransactionDetailView(transaction: accounts.first!.transactions.first!)
}
#endif
