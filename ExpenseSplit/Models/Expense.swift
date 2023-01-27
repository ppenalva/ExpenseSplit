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
        var enjoyers: [Enjoyer] = []
        
        init(id: UUID = UUID(), description: String, totalValue: Double, payers: [Payer], enjoyers: [Enjoyer]) {
            self.id = id
            self.description = description
            self.totalValue = totalValue
            self.payers = payers
            self.enjoyers = enjoyers
        }
    }
}
extension PartyInfo.Expense {
    struct Payer: Identifiable, Codable {
        let id: UUID
        var isOn: Bool
        var payerName: String
        var exceptionAmount: Double
        
        init(id: UUID = UUID(), isOn: Bool, payerName: String, exceptionAmount: Double) {
            self.id = id
            self.isOn = isOn
            self.payerName = payerName
            self.exceptionAmount = exceptionAmount
        }
    }
}

extension PartyInfo.Expense {
    struct Enjoyer: Identifiable, Codable {
        let id: UUID
        var isOn: Bool
        var enjoyerName: String
        var exceptionAmount: Double
        
        init(id: UUID = UUID(), isOn: Bool, enjoyerName: String, exceptionAmount: Double) {
            self.id = id
            self.isOn = isOn
            self.enjoyerName = enjoyerName
            self.exceptionAmount = exceptionAmount
        }
    }
}


extension PartyInfo.Expense {
    struct Data {
        var description: String = ""
        var totalValue: Double = 0.0
        var payers: [Payer] = []
        var enjoyers: [Enjoyer] = []
    }
        
    var data: Data {
        Data(description: description, totalValue: totalValue, payers: payers, enjoyers: enjoyers)
    }
    mutating func update(from data: Data) {
        description = data.description
        totalValue = data.totalValue
        payers = data.payers
        enjoyers = data.enjoyers
    }
    init(data: Data) {
        id = UUID()
        description = data.description
        totalValue = data.totalValue
        payers = data.payers
        enjoyers = data.enjoyers
    }
    
}

extension PartyInfo.Expense.Payer{
    struct Data {
        var isOn: Bool = false
        var payerName: String = ""
        var exceptionAmount: Double = 0.0
    }
        
    var data: Data {
        Data(isOn: isOn, payerName: payerName, exceptionAmount: exceptionAmount)
    }
    mutating func update(from data: Data) {
        isOn = data.isOn
        payerName = data.payerName
        exceptionAmount = data.exceptionAmount
    }
    init(data: Data) {
        id = UUID()
        isOn = data.isOn
        payerName = data.payerName
        exceptionAmount = data.exceptionAmount
    }
}

extension PartyInfo.Expense.Enjoyer{
    struct Data {
        var isOn: Bool = false
        var enjoyerName: String = ""
        var exceptionAmount: Double = 0.0
    }
        
    var data: Data {
        Data(isOn: isOn, enjoyerName: enjoyerName, exceptionAmount: exceptionAmount)
    }
    mutating func update(from data: Data) {
        isOn = data.isOn
        enjoyerName = data.enjoyerName
        exceptionAmount = data.exceptionAmount
    }
    init(data: Data) {
        id = UUID()
        isOn = data.isOn
        enjoyerName = data.enjoyerName
        exceptionAmount = data.exceptionAmount
    }
}

