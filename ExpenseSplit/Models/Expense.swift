//
//  Expense.swift
//  ExpenseSplit
//
//  Created by Pablo Penalva on 20/1/23.
//

import Foundation

extension PartyInfo {
    struct Expense: Identifiable, Codable  {
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
    struct Payer: Identifiable, Codable {
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
extension PartyInfo.Expense {
    struct Data {
        var description: String = ""
        var totalValue: Double = 0.0
        var payers: [Payer] = []
    }
        
    var data: Data {
    Data(description: description, totalValue: totalValue, payers: payers)
    }
    mutating func update(from data: Data) {
        description = data.description
        totalValue = data.totalValue
        payers = data.payers
    }
    init(data: Data) {
        id = UUID()
        description = data.description
        totalValue = data.totalValue
        payers = data.payers
    }
    
}

extension PartyInfo.Expense.Payer{
    struct Data {
        var payerName: String = ""
        var amountPayed: Double = 0.0
    }
        
    var data: Data {
    Data(payerName: payerName, amountPayed: amountPayed)
    }
    mutating func update(from data: Data) {
        payerName = data.payerName
        amountPayed = data.amountPayed
    }
    init(data: Data) {
        id = UUID()
        payerName = data.payerName
        amountPayed = data.amountPayed
    }
}

