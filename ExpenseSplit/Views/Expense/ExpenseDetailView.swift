//
//  ExpenseDetailView.swift
//  ExpenseSplit
//
//  Created by Pablo Penalva on 23/1/23.
//

import SwiftUI

struct ExpenseDetailView: View {
    
    @Binding var expense: PartyInfo.Expense
    
    @State private var dataExpense = PartyInfo.Expense.Data()
    
    @State private var isPresentingPayersView = false
    @State private var isPresentingEnjoyersView = false
    @State private var isPresentingExpenseDetailEditView = false
    
    var body: some View {
        List {
            Section(header: Text(" Transaction Info")) {
                Text( expense.description)
                Text(String(format: "%.2f",expense.totalValue))
            }
            
            Section(header: Text("Payers")) {
                ForEach(expense.payers) {payer in
                    if (payer.isOn) {
                        HStack {
                            Text(payer.payerName)
                            Spacer()
                            Text(String(format: "%.2f",payer.exceptionAmount))
                            Spacer()
                            Text(String(format: "%.2f", calculatePayerAmount(payer: payer)))
                        }
                    }
                }
            }
            Section(header: Text("Enjoyers")) {
                ForEach(expense.enjoyers) {enjoyer in
                    if (enjoyer.isOn) {
                        HStack {
                            Text(enjoyer.enjoyerName)
                            Spacer()
                            Text(String(format: "%.2f",enjoyer.exceptionAmount))
                            Spacer()
                            Text(String(format: "%.2f", calculateEnjoyerAmount(enjoyer: enjoyer)))
                        }
                    }
                }
            }
        }
    
        
        .toolbar {
            Button("Edit") {
                isPresentingExpenseDetailEditView = true
                dataExpense = expense.data
            }
        }
        .navigationTitle(dataExpense.description)
        .sheet(isPresented: $isPresentingExpenseDetailEditView) {
            NavigationView {
                ExpenseDetailEditView (expenseData: $dataExpense)
                    .navigationTitle(expense.description)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingExpenseDetailEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Confirm") {
                                expense.update(from: dataExpense )
                                isPresentingExpenseDetailEditView = false
                            }
                        }
                    }
            }
        }
    }
    func calculatePayerAmount (payer: PartyInfo.Expense.Payer ) -> Double {
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
    
    func calculateEnjoyerAmount (enjoyer: PartyInfo.Expense.Enjoyer ) -> Double {
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
