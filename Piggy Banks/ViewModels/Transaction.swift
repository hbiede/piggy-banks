//
//  Transaction.swift
//  Piggy Banks
//
//  Created by Elijah Biede on 10/7/24.
//  Copyright © 2024 Empower. All rights reserved.
//

import Foundation
import SwiftData

@Model
final class Transaction {
    var date: Date
    var amount: Decimal
    
    @Relationship(inverse: \PiggyBank.__transactions)
    var piggyBank: PiggyBank?
    
    init(date: Date, amount: Decimal, piggyBank: PiggyBank? = nil) {
        self.date = date
        self.amount = amount
        self.piggyBank = piggyBank
    }
}
