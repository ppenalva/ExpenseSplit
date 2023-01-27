//
//  PartyInfo.swift
//  ExpenseSplit
//
//  Created by Pablo Penalva on 20/1/23.
//

import Foundation

struct PartyInfo: Identifiable, Codable {
    var id: UUID
    var title: String
    var participants: [Participant]
    var theme: Theme
    var expenses: [Expense]
    //    var payments: [Payment]
    
    init(id: UUID = UUID(), title: String, participants: [Participant], theme: Theme, expenses: [Expense] ) {
        self.id = id
        self.title = title
        self.participants = participants.map { Participant(name: $0.name) }
        self.theme = theme
        self.expenses = expenses.map { Expense(description: $0.description, totalValue: $0.totalValue, payers: $0.payers.map {PartyInfo.Expense.Payer(isOn: $0.isOn, payerName: $0.payerName, exceptionAmount: $0.exceptionAmount)},enjoyers: $0.enjoyers.map {PartyInfo.Expense.Enjoyer(isOn: $0.isOn, enjoyerName: $0.enjoyerName, exceptionAmount: $0.exceptionAmount)})
        }
    }
}

extension PartyInfo {
    struct Data {
        var title: String = ""
        var participants: [Participant] = []
        var theme: Theme = .seafoam
        var expenses: [Expense] = []
    }
    var data: Data {
        Data(title: title, participants: participants, theme: theme, expenses: expenses)
    }
    
    mutating func update(from data: Data) {
        title = data.title
        participants = data.participants
        theme = data.theme
        expenses = data.expenses
    }
    
    init(data: Data) {
        id = UUID()
        title = data.title
        participants = data.participants
        theme = data.theme
        expenses = data.expenses
    }
}



extension PartyInfo {
    static var partyData: [PartyInfo] =
    [
        PartyInfo(title: "Año Nuevo 2023", participants: [Participant(name:"Pablo"),Participant(name:"Juan")], theme: .yellow, expenses: [Expense(description: "Factura 1", totalValue: 130.0, payers: [Expense.Payer(isOn: false,payerName: "Pablo", exceptionAmount: 130)],enjoyers: [Expense.Enjoyer(isOn: false,enjoyerName: "Pablo", exceptionAmount: 130)])])
                 
                                                                                                
    ]
}

