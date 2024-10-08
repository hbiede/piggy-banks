//
//  AccountLandingPiggyBankView.swift
//  Piggy Banks
//
//  Created by Elijah Biede on 10/7/24.
//  Copyright © 2024 Empower. All rights reserved.
//

import SwiftUI

struct AccountLandingPiggyBankView: View {
    var piggyBank: PiggyBank
    
    var body: some View {
        NavigationLink(destination: {
            PiggyBankView(piggyBank: piggyBank)
        }, label: {
            PiggyBankHeaderView(piggyBank: piggyBank)
                .padding(.vertical)
        })
        .buttonStyle(.plain)
    }
}

#if DEBUG
import SwiftData

#Preview(traits: .sampleData) {
    @Previewable @Query var piggyBanks: [PiggyBank] = [PiggyBank]()
    
    AccountLandingPiggyBankView(piggyBank: piggyBanks.first!)
}
#endif
