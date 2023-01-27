//
//  SummaryView.swift
//  ExpenseSplit
//
//  Created by Pablo Penalva on 26/1/23.
//

import SwiftUI

struct SummaryView: View {
    
    @Binding var party: PartyInfo

    var body: some View {
        List {
            HStack{
                Text("Party: ")
                Text(party.title)
            }
            Section(header:
                        Text("Participants")) {
                ForEach(party.participants) { participant in
                    let a = calculateParticipantPaidAmount(participant: participant.name)
                    let b = calculateParticipantEnjoyedAmount(participant: participant.name)
                    let c = a - b
                    HStack {
                        Text(participant.name)
                        Spacer()
                        Text(String(format: "%.2f", a))
                        Text(String(format: "%.2f", b))
                        Text(String(format: "%.2f", c))
                    }
                }
            }
            
            Section(header:
                        Text("Transactions")){
                ForEach($party.expenses) { $expense in
                    HStack{
                        Text(" Transaction: ")
                        Text(expense.description)
                        Spacer()
                        Text(String(format: "%.2f",expense.totalValue))
                    }
                    Section(header:
                                Text("Payers")) {
                        ForEach(expense.payers) {payer in
                            if (payer.isOn) {
                                HStack {
                                    Text(payer.payerName)
                                    Spacer()
                                    Text(String(format: "%.2f",payer.exceptionAmount))
                                    Spacer()
                                    Text(String(format: "%.2f", calculatePayerAmount(expense: expense, payer: payer)))
                                }
                            }
                        }
                    }
                    Section(header:
                                Text("Enjoyers")) {
                        ForEach(expense.enjoyers) {enjoyer in
                            if (enjoyer.isOn) {
                                HStack {
                                    Text(enjoyer.enjoyerName)
                                    Spacer()
                                    Text(String(format: "%.2f",enjoyer.exceptionAmount))
                                    Spacer()
                                    Text(String(format: "%.2f", calculateEnjoyerAmount(expense: expense,enjoyer: enjoyer)))
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    func calculateParticipantPaidAmount (participant: String ) -> Double {
        var totalParticipantPaid = 0.0
        for (expense) in party.expenses {
            for payer in expense.payers {
                if (payer.payerName == participant && payer.isOn) {
                    if (payer.exceptionAmount != 0) {
                        totalParticipantPaid += payer.exceptionAmount
                    } else {
                        var totalExceptionValue = 0.0
                        var counter = 0.0
                        for (expensePayer) in expense.payers {
                            totalExceptionValue += expensePayer.exceptionAmount
                            if (expensePayer.isOn && expensePayer.exceptionAmount == 0.0) {
                                counter += 1.0
                            }
                        }
                        
                            totalParticipantPaid += (expense.totalValue - totalExceptionValue) / counter
                        
                    }
                }
            }
        }
        return totalParticipantPaid
    }
    
    func calculateParticipantEnjoyedAmount (participant: String ) -> Double {
        var totalParticipantEnjoyed = 0.0
        for (expense) in party.expenses {
            for enjoyer in expense.enjoyers {
                if (enjoyer.enjoyerName == participant && enjoyer.isOn) {
                    if (enjoyer.exceptionAmount != 0) {
                        totalParticipantEnjoyed += enjoyer.exceptionAmount
                    } else {
                        var totalExceptionValue = 0.0
                        var counter = 0.0
                        for (expenseEnjoyer) in expense.enjoyers {
                            totalExceptionValue += expenseEnjoyer.exceptionAmount
                            if (expenseEnjoyer.isOn && expenseEnjoyer.exceptionAmount == 0.0) {
                                counter += 1.0
                            }
                        }
                        
                            totalParticipantEnjoyed += (expense.totalValue - totalExceptionValue) / counter
                        
                    }
                }
            }
        }
        return totalParticipantEnjoyed
    }
    func calculatePayerAmount (expense: PartyInfo.Expense, payer: PartyInfo.Expense.Payer ) -> Double {
        if (payer.exceptionAmount != 0) {
            return payer.exceptionAmount
        } else {
            var totalExceptionValue = 0.0
            var counter = 0.0
            for (expensePayer) in expense.payers {
                totalExceptionValue += expensePayer.exceptionAmount
                if (expensePayer.isOn && expensePayer.exceptionAmount == 0.0) {
                    counter += 1.0
                }
            }
            return (expense.totalValue - totalExceptionValue) / counter
        }
    }
    
    func calculateEnjoyerAmount (expense: PartyInfo.Expense,enjoyer: PartyInfo.Expense.Enjoyer ) -> Double {
        if (enjoyer.exceptionAmount != 0) {
            return enjoyer.exceptionAmount
        } else {
            var totalExceptionValue = 0.0
            var counter = 0.0
            for (expenseEnjoyer) in expense.enjoyers {
                totalExceptionValue += expenseEnjoyer.exceptionAmount
                if (expenseEnjoyer.isOn && expenseEnjoyer.exceptionAmount == 0.0) {
                    counter += 1.0
                }
            }
            return (expense.totalValue - totalExceptionValue) / counter
        }
    }
}

