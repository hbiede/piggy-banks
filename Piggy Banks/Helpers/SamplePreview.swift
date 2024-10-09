//
//  SamplePreview.swift
//  Piggy Banks
//
//  Created by Elijah Biede on 10/7/24.
//  Copyright © 2024 Empower. All rights reserved.
//

import SwiftUI
import SwiftData


struct SampleData: PreviewModifier {
    static func generateGenericData(in context: ModelContext) {
        let emergency = PiggyBank(name: "Emergency Fund", balance: 2500, goal: 10000)
        let holidays = PiggyBank(name: "Holiday Gifts", balance: 800, goal: 750)
        let car = PiggyBank(name: "Car Down Payment", balance: 8000, goal: 10000)
        
        context.insert(emergency)
        context.insert(holidays)
        context.insert(car)
        
        var transactions = [Transaction]()
        let withdrawal = Transaction(date: Date(timeIntervalSinceNow: TimeInterval(-86400 * 7)),
                                      amount: -100,
                                     otherAccount: BankAccounts.wellsChecking.rawValue,
                                      piggyBank: emergency)
        context.insert(withdrawal)
        transactions.append(withdrawal)
        emergency.__transactions.append(withdrawal)
        for i in 0..<26 {
            let transaction = Transaction(date: Date(timeIntervalSinceNow: TimeInterval(-86400 * 14 * i + Int.random(in: -20000...20000))),
                                          amount: 100,
                                          otherAccount: BankAccounts.wellsSavings.rawValue,
                                          piggyBank: emergency)
            context.insert(transaction)
            transactions.append(transaction)
            emergency.__transactions.append(transaction)
        }
        for i in 1...4 {
            let transaction = Transaction(date: Date(timeIntervalSinceNow: TimeInterval(-86400 * 14 * i + Int.random(in: -20000...20000))),
                                          amount: 200,
                                          otherAccount: BankAccounts.chaseSavings.rawValue,
                                          piggyBank: holidays)
            context.insert(transaction)
            transactions.append(transaction)
            holidays.__transactions.append(transaction)
        }
        for i in 1...20 {
            let transaction = Transaction(date: Date(timeIntervalSinceNow: TimeInterval(-86400 * 14 * i + Int.random(in: -20000...20000))),
                                          amount: 400,
                                          otherAccount: BankAccounts.wellsSavings.rawValue,
                                          piggyBank: car)
            context.insert(transaction)
            transactions.append(transaction)
            car.__transactions.append(transaction)
        }
        
        let account = Account(piggyBanks: [emergency, holidays, car], transactions: transactions)
        
        context.insert(account)
    }
    
    static func makeSharedContext() throws -> ModelContainer {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Account.self, configurations: config)
        
        generateGenericData(in: container.mainContext)
        
        return container
    }
    
    func body(content: Content, context: ModelContainer) -> some View {
        content.modelContainer(context)
    }
}

extension PreviewTrait where T == Preview.ViewTraits {
    @MainActor static var sampleData: Self = .modifier(SampleData())
}
