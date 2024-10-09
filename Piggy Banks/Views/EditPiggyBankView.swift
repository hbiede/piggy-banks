//
//  EditPiggyBankView.swift
//  Piggy Banks
//
//  Created by Elijah Biede on 10/7/24.
//  Copyright © 2024 Empower. All rights reserved.
//

import SwiftUI

struct MaterialTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.gray4, lineWidth: 1)
            )
    }
}

struct EditPiggyBankView: View {
    @Environment(\.dismiss) var dismiss
    
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
            Text("Goal name")
                .frame(maxWidth: .infinity, alignment: .leading)
            TextField("Insert title", text: $nameInput)
                .textFieldStyle(MaterialTextFieldStyle())
                .autocapitalization(.words)
            Text("Name of piggy bank")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(.secondary)
                .font(.caption)
                .padding(.bottom)
            
            Text("Monthly savings rate")
                .frame(maxWidth: .infinity, alignment: .leading)
            TextField("Insert monthly savings rate", value: $monthlySavingsRate, format: .currency(code: "USD"))
                .textFieldStyle(MaterialTextFieldStyle())
                .keyboardType(.decimalPad)
            Text("Dollar amount (eg, $50.00)")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(.secondary)
                .font(.caption)
                .padding(.bottom)
            
            Text("Total savings goal")
                .frame(maxWidth: .infinity, alignment: .leading)
            TextField("Insert goal", value: $goal, format: .currency(code: "USD"))
                .textFieldStyle(MaterialTextFieldStyle())
            Text("Dollar amount (eg, $1,000.00)")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(.secondary)
                .font(.caption)
                .keyboardType(.decimalPad)
            
            NavigationLink(destination: {
                Text("Placeholder")
            }, label: {
                HStack {
                    Image(systemName: "info.circle")
                        .foregroundStyle(.link)
                    Text("Get recomendations")
                        .foregroundStyle(.link)
                        .font(.subheadline)
                        .underline()
                }
            })
            .padding(.top, 32)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            Text("\"Users with multiple goals save more.\"")
            Text("- Teresa Manago")
                .font(.caption)
                .foregroundStyle(.secondary)
                .padding(.bottom, 48)
            
            if let bank = bank {
                let disabled = nameInput.isEmpty ||
                    monthlySavingsRate == nil ||
                    monthlySavingsRate == 0 ||
                    goal == nil ||
                    goal == 0 ||
                    (nameInput == bank.name &&
                    monthlySavingsRate == bank.monthlyAmount &&
                    goal == bank.goal)
                
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
                            .background(disabled ? .accent.opacity(0.5) : .accent)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .disabled(disabled)
                    }
                    .padding(.bottom)
                    .onAppear() {
                        nameInput = bank.name
                        monthlySavingsRate = bank.monthlyAmount
                        goal = bank.goal
                    }
                }
            } else {
                let disabled = nameInput.isEmpty ||
                    monthlySavingsRate == nil ||
                    monthlySavingsRate == 0 ||
                    goal == nil ||
                    goal == 0
                Button(action: onSubmit) {
                    Text("Submit")
                        .foregroundStyle(Color.white)
                        .padding(16)
                        .background(disabled ? .accent.opacity(0.5) : .accent)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .disabled(disabled)
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
        
        dismiss()
    }
    
    private func onSubmit() {
        account.addPiggyBank(name: nameInput, goal: goal, monthlyAmount: monthlySavingsRate)
        
        dismiss()
    }
}

#if DEBUG
import SwiftData

#Preview(traits: .sampleData) {
    @Previewable @Query var accounts: [Account] = [Account]()
    
    EditPiggyBankView(account: accounts.first!)
}
#endif
