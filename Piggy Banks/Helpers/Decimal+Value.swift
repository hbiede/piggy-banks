//
//  Decimal+Value.swift
//  Piggy Banks
//
//  Created by Elijah Biede on 10/7/24.
//  Copyright © 2024 Empower. All rights reserved.
//

import Foundation

extension Decimal {
    var currencyString: String {
        self.formatted(.currency(code: "USD"))
    }
    var shortCurrencyString: String {
        self.formatted(.currency(code: "USD").precision(.fractionLength(0)))
    }
    
    var doubleValue: Double {
        NSDecimalNumber(decimal: self).doubleValue
    }
    var intValue: Int {
        NSDecimalNumber(decimal: self).intValue
    }
}
