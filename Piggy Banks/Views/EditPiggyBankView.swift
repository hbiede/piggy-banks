//
//  EditPiggyBankView.swift
//  Piggy Banks
//
//  Created by Elijah Biede on 10/7/24.
//  Copyright © 2024 Empower. All rights reserved.
//

import SwiftUI

struct EditPiggyBankView: View {
    var account: Account
    
    var bank: PiggyBank?
    
    var amount: Decimal?
    var name: String?
    
    @State private var nameInput: String = ""
    @State private var monthlySavingsRate: Decimal?
    @State private var goal: Decimal?
    
    init(account: Account, bank: PiggyBank) {
        self.account = account
        self.bank = bank
    }
    
    init(account: Account, name: String? = nil, amount: Decimal? = nil) {
        self.account = account
        self.name = name
        self.amount = amount
    }
    
    var body: some View {
        VStack {
            Text("Title")
                .frame(maxWidth: .infinity, alignment: .leading)
            TextField("", text: $nameInput)
                .textFieldStyle(.roundedBorder)
                .autocapitalization(.words)
                .padding(.bottom)
            
            Text("Monthly savings rate")
                .frame(maxWidth: .infinity, alignment: .leading)
            TextField("", value: $monthlySavingsRate, format: .currency(code: "USD"))
                .textFieldStyle(.roundedBorder)
                .keyboardType(.decimalPad)
                .padding(.bottom)
            
            Text("Goal")
                .frame(maxWidth: .infinity, alignment: .leading)
            TextField("", value: $goal, format: .currency(code: "USD"))
                .textFieldStyle(.roundedBorder)
                .keyboardType(.decimalPad)
            
            Spacer()
            
            if let bank = bank {
                HStack {
                    Button(action: onDelete) {
                        Text("Delete")
                            .foregroundStyle(Color.white)
                            .padding(16)
                            .background(.red)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    .padding(.bottom)
                    
                    Button(action: onSave) {
                        Text("Save")
                            .foregroundStyle(Color.white)
                            .padding(16)
                            .background(.accent)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    .padding(.bottom)
                    .onAppear() {
                        nameInput = bank.name
                        monthlySavingsRate = bank.monthlyAmount
                        goal = bank.goal
                    }
                }
            } else {
                Button(action: onSubmit) {
                    Text("Submit")
                        .foregroundStyle(Color.white)
                        .padding(16)
                        .background(.accent)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding(.bottom)
                .onAppear() {
                    nameInput = name ?? ""
                    goal = amount
                }
            }
        }
        .padding(.horizontal, 36)
    }
    
    private func onDelete() {
        guard let bank = bank else { return }
        
        account.deletePiggyBank(with: bank.id)
    }
    
    private func onSave() {
        guard let bank = bank else { return }
        
        bank.name = nameInput
        bank.monthlyAmount = monthlySavingsRate
        bank.goal = goal
    }
    
    private func onSubmit() {
        account.addPiggyBank(name: nameInput, goal: goal, monthlyAmount: monthlySavingsRate)
    }
}

#if DEBUG
import SwiftData

#Preview(traits: .sampleData) {
    @Previewable @Query var accounts: [Account] = [Account]()
    
    EditPiggyBankView(account: accounts.first!)
}
#endif
