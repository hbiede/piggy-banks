//
//  TransferView.swift
//  Piggy Banks
//
//  Created by Elijah Biede on 10/8/24.
//  Copyright © 2024 Empower. All rights reserved.
//

import SwiftUI

private enum TransferType {
    case deposit
    case withdraw
}

struct TransferView: View {
    var account: Account
    var piggyBank: PiggyBank?
    
    @State private var amount: Decimal = .zero
    @State private var selectedTransferType = TransferType.deposit
    @State private var selectedBankAccount = BankAccounts.wellsChecking
    @State private var selectedPiggyBank: Int? = 0
    @State private var transferDate = Date()
    
    init(account: Account, piggyBank: PiggyBank? = nil) {
        self.account = account
        self.piggyBank = piggyBank
    }
    
    var body: some View {
        Form {
            HStack {
                Text("Amount")
                
                Spacer()
                
                TextField("", value: $amount, format: .currency(code: "USD"))
                    .multilineTextAlignment(.trailing)
            }
            
            Picker(selection: $selectedTransferType, content: {
                Text("Deposit").tag(TransferType.deposit)
                Text("Withdraw").tag(TransferType.withdraw)
            }, label: {
                Text("Transfer Type")
            })
            .pickerStyle(.segmented)
            
            Picker(selection: $selectedBankAccount, content: {
                ForEach(BankAccounts.allCases, id: \.rawValue) { a in
                    Text(a.rawValue).tag(a)
                }
            }, label: {
                Text(selectedTransferType == .deposit ? "Source" : "Destination")
            })
            
            if !account.piggyBanks.isEmpty {
                Picker(selection: $selectedPiggyBank, content: {
                    ForEach(account.piggyBanks.indices, id: \.self) { index in
                        Text(account.piggyBanks[index].name).tag(index)
                    }
                }, label: {
                    Text("Piggy Bank")
                })
                .onAppear() {
                    selectedPiggyBank = account.piggyBanks.firstIndex(where: { $0.id == piggyBank?.id })
                }
            }
            
            DatePicker("Transfer on",
                       selection: $transferDate,
//                       in: Date.now...,
                       displayedComponents: .date)
            
            Section {
                Button(action: onSave) {
                    Text("Transfer")
                }
                .disabled(
                    amount <= .zero ||
                    (selectedTransferType == .withdraw &&
                      amount > (piggyBank?.balance ?? .zero)) ||
//                    (transferDate < Calendar.autoupdatingCurrent.startOfDay(for: Date.now)) ||
                    (!account.piggyBanks.isEmpty &&
                     (selectedPiggyBank == nil || !(0..<account.piggyBanks.count).contains(selectedPiggyBank!)))
                )
            }
        }
    }
    
    private func onSave() {
        account.addTransaction(amount: selectedTransferType == .deposit ? amount : -amount,
                               date: transferDate,
                               otherAccount: selectedBankAccount.rawValue,
                               piggyBank: selectedPiggyBank == nil ? nil : account.piggyBanks[selectedPiggyBank!])
    }
}

#if DEBUG
import SwiftData

#Preview(traits: .sampleData) {
    @Previewable @Query var accounts: [Account] = [Account]()
    
    TransferView(account: accounts.first!, piggyBank: accounts.first?.piggyBanks.first)
        .modelContainer(for: Account.self, inMemory: true)
}
#endif
