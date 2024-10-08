//
//  TextColor.swift
//  Piggy Banks
//
//  Created by Elijah Biede on 10/7/24.
//  Copyright © 2024 Empower. All rights reserved.
//

import SwiftUI

func currencyColor(for amount: Decimal) -> Color? {
    if amount == .zero {
        return nil
    }
    
    return amount < 0 ? .red : .basil
}
