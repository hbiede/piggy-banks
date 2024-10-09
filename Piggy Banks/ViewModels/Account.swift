//
//  Account.swift
//  Piggy Banks
//
//  Created by Elijah Biede on 10/7/24.
//  Copyright © 2024 Empower. All rights reserved.
//

import Foundation
import SwiftData

@Model
final class Account {
    @Relationship(deleteRule: .cascade)
    var piggyBanks: [PiggyBank]
    
    @Relationship(deleteRule: .cascade)
    var transactions: [Transaction]
    
    var piggyBankBalance: Decimal {
        piggyBanks.reduce(.zero) { $0 + $1.balance }
    }
    
    var savedThisWeek: Decimal {
        saved(since: Date().addingTimeInterval(-604800))
    }
    
    var savedThisMonth: Decimal {
        saved(since: Date().addingTimeInterval(-2592000))
    }
    
    var totalSavingsBalance: Decimal {
        transactions.reduce(.zero) { $0 + $1.amount }
    }
    
    init(piggyBanks: [PiggyBank] = [], transactions: [Transaction] = []) {
        self.piggyBanks = piggyBanks
        self.transactions = transactions
    }
    
    func saved(since: Date) -> Decimal {
        transactions.filter { $0.date > since }.reduce(.zero) { $0 + $1.amount }
    }
    
    // MARK: Model CRUD
    
    func addPiggyBank(name: String, balance: Decimal = .zero, goal: Decimal? = nil, monthlyAmount: Decimal? = nil) {
        let piggyBank = PiggyBank(name: name, balance: balance, goal: goal, monthlyAmount: monthlyAmount)
        modelContext?.insert(piggyBank)
        piggyBanks.append(piggyBank)
    }
    
    func addTransaction(amount: Decimal, date: Date = Date(), otherAccount: String, piggyBank: PiggyBank? = nil) {
        let transaction = Transaction(date: date, amount: amount, otherAccount: otherAccount, piggyBank: piggyBank)
        modelContext?.insert(transaction)
        transactions.append(transaction)
        
        piggyBank?.balance += amount
    }
    
    func deletePiggyBank(with id: PersistentIdentifier) {
        if let index = piggyBanks.firstIndex(where: { $0.id == id }) {
            piggyBanks.remove(at: index)
        }
    }
}
