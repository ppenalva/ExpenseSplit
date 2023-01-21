//
//  Expense.swift
//  ExpenseSplit
//
//  Created by Pablo Penalva on 20/1/23.
//

import Foundation

extension PartyInfo {
    struct Expense: Identifiable  {
        let id: UUID
        var description: String
        var totalValue: Double
        var payers: [Payer]
//        var enjoyers: [Enjoyer] = []
        
        init(id: UUID = UUID(), description: String, totalValue: Double, payers: [Payer]) {
            self.id = id
            self.description = description
            self.totalValue = totalValue
            self.payers = payers
        }
    }
}
extension PartyInfo.Expense {
    struct Payer: Identifiable {
        let id: UUID
        var payerName: String
        var amountPayed: Double
        
        init(id: UUID = UUID(), payerName: String, amountPayed: Double) {
            self.id = id
            self.payerName = payerName
            self.amountPayed = amountPayed  
        }
    }
}
