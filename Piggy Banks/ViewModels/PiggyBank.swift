//
//  PiggyBank.swift
//  Piggy Banks
//
//  Created by Elijah Biede on 10/7/24.
//  Copyright © 2024 Empower. All rights reserved.
//

import Foundation
import SwiftData

@Model
final class PiggyBank: ObservableObject {
    #Index<PiggyBank>([\.name])
    
    @Relationship(inverse: \Account.piggyBanks)
    var account: Account?
    
    @Relationship(deleteRule: .nullify)
    var __transactions: [Transaction] = [Transaction]()
    
    var transactions: [Transaction] {
        __transactions.sorted(by: { $0.date > $1.date })
    }
    
    var name: String
    var balance: Decimal
    var goal: Decimal?
    var monthlyAmount: Decimal?
    
    init(name: String, balance: Decimal = .zero, goal: Decimal? = nil, monthlyAmount: Decimal? = nil) {
        self.name = name
        self.balance = balance
        self.goal = goal
        self.monthlyAmount = monthlyAmount
    }
}
