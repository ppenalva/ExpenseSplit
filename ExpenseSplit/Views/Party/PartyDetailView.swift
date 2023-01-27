//
//  PartyDetailView.swift
//  ExpenseSplit
//
//  Created by Pablo Penalva on 21/1/23.
//

import SwiftUI

struct PartyDetailView: View {
    
    @Binding var party: PartyInfo
    
    @State private var dataParty = PartyInfo.Data()
   
    @State private var newExpenseData = PartyInfo.Expense.Data()
    @State private var newPayerData = PartyInfo.Expense.Payer.Data()
    @State private var newEnjoyerData = PartyInfo.Expense.Enjoyer.Data()
    
    @State private var isPresentingPartyEditView = false
    @State private var isPresentingNewExpenseView = false
    @State private var isPresentingSummaryView = false
    
    var body: some View {
        
        List {
            Section(header: Text(" Party Info")) {
                HStack {
                    Label("Theme", systemImage: "paintpalette")
                    Spacer()
                    Text(party.theme.name)
                        .padding(4)
                        .foregroundColor(party.theme.accentColor)
                        .background(party.theme.mainColor)
                        .cornerRadius(4)
                }
            }
            HStack {
                Button ("New Transaction") {
                    
                    newExpenseData.description = ""
                    newExpenseData.totalValue = 0.0
                    for participant in party.participants {
                        newPayerData.payerName = participant.name
                        newPayerData.exceptionAmount = 0.0
                        newEnjoyerData.enjoyerName = participant.name
                        newPayerData.exceptionAmount = 0.0
                        
                        let newPayer = PartyInfo.Expense.Payer(data: newPayerData)
                        newExpenseData.payers.append(newPayer)
                        let newEnjoyer = PartyInfo.Expense.Enjoyer(data: newEnjoyerData)
                        newExpenseData.enjoyers.append(newEnjoyer)
                    }
                    isPresentingNewExpenseView = true
                    
                }
                .buttonStyle(BorderlessButtonStyle())
                Spacer()
                Button ("Summary") {
                    isPresentingSummaryView = true
                }
                .buttonStyle(BorderlessButtonStyle())
                
            }
            
            Section(header: Text("Participants")) {
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
            
            Section(header: Text("Transactions")) {
                ForEach($party.expenses) { $expense in
                    NavigationLink(destination: ExpenseDetailView(expense: $expense)) {
                        HStack {
                            Label(expense.description, systemImage: "r.circle")
                        }
                    }
                    .isDetailLink(false)
                }
                .onDelete(perform: deleteExpense)
                .onMove(perform: moveExpense)
            }
        }
    
        
        .navigationTitle(party.title)
        .toolbar {
            Button("Edit") {
                isPresentingPartyEditView = true
                dataParty = party.data
            }
        }
        .sheet(isPresented: $isPresentingPartyEditView) {
            NavigationView {
                PartyDetailEditView (dataParty: $dataParty)
                    .navigationTitle(party.title)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingPartyEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Confirm") {
                                party.update(from: dataParty )
                                isPresentingPartyEditView = false
                            }
                        }
                    }
            }
        }
        .sheet(isPresented: $isPresentingNewExpenseView) {
            NavigationView {
                ExpenseDetailEditView(expenseData: $newExpenseData)
                    .navigationTitle("Expenses")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Dismiss") {
                                isPresentingNewExpenseView = false
                                newExpenseData = PartyInfo.Expense.Data()
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Add") {
                                let newExpense = PartyInfo.Expense(data: newExpenseData)
                                party.expenses.append(newExpense)
                                isPresentingNewExpenseView = false
                                newExpenseData = PartyInfo.Expense.Data()
                                
                            }
                        }
                    }
            }
        }
        .sheet(isPresented: $isPresentingSummaryView) {
            NavigationView {
                SummaryView(party: $party)
                    .navigationTitle("Summary")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Back") {
                                isPresentingSummaryView = false
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
    func deleteExpense( at offsets: IndexSet) {
        party.expenses.remove(atOffsets: offsets)
        }
    
func moveExpense( from source: IndexSet, to destination: Int) {
    party.expenses.move(fromOffsets: source, toOffset: destination)
}
}


