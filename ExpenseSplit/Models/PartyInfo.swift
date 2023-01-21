//
//  PartyInfo.swift
//  ExpenseSplit
//
//  Created by Pablo Penalva on 20/1/23.
//

import Foundation

struct PartyInfo: Identifiable {
    let id: UUID
    var title: String
    var participants: [Participant]
    var theme: Theme
    var expenses: [Expense]
    //    var payments: [Payment]
    
    init(id: UUID = UUID(), title: String, participants: [String], theme: Theme, expenses: [Expense] ) {
        self.id = id
        self.title = title
        self.participants = participants.map { Participant(name: $0) }
        self.theme = theme
        self.expenses = expenses.map { Expense(description: $0.description, totalValue: $0.totalValue, payers: $0.payers.map {PartyInfo.Expense.Payer(payerName: $0.payerName, amountPayed: $0.amountPayed)})
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
        Data(title: title, participants: participants, theme: theme)
    }
}



extension PartyInfo {
    static var partyData: [PartyInfo] =
    [
        PartyInfo(title: "Año Nuevo 2023", participants: ["Pablo","Juan"], theme: .yellow, expenses: [Expense(description: "Factura 1", totalValue: 130.0, payers: [Expense.Payer(payerName: "Pablo", amountPayed: 130)])])
    ]
}

