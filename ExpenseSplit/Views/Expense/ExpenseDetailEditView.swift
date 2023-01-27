//
//  ExpenseDetailEditView.swift
//  ExpenseSplit
//
//  Created by Pablo Penalva on 21/1/23.
//

import SwiftUI

struct ExpenseDetailEditView: View {
    
    @Binding var expenseData: PartyInfo.Expense.Data

    @State var payersData = PartyInfo.Expense.Payer.Data()
    
    @State var newPayerData =  PartyInfo.Expense.Payer.Data()
   
    
    @State private var isPresentingPayersView = false
    @State private var isPresentingEnjoyersView = false
    
    var body: some View {
        List {
            Section(header: Text(" Expense Info")) {
                TextField("Description",text: $expenseData.description)
                TextField("Amount", value: $expenseData.totalValue, format: .number)
            }
            HStack {
                Button ("Payers") {
                      
                    isPresentingPayersView = true
                }
                .buttonStyle(BorderlessButtonStyle())
               Spacer()
               Button ("Enjoiyers") {
                  
                    isPresentingEnjoyersView = true
               }
               .buttonStyle(BorderlessButtonStyle())
            }
            
            
            Section(header: Text("Payers")) {
                ForEach(expenseData.payers) {payer in
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
                ForEach(expenseData.enjoyers) {enjoyer in
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
        .sheet(isPresented: $isPresentingPayersView) {
            NavigationView {
                PayersView( expenseData: $expenseData)
                    .navigationTitle("Payers")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Dismiss") {
                                isPresentingPayersView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Add") {
                                isPresentingPayersView = false
                                
                            }
                        }
                    }
            }
            .navigationTitle("Mi pantalla otra")
        }
        .sheet(isPresented: $isPresentingEnjoyersView) {
            NavigationView {
                EnjoyersView( expenseData: $expenseData)
                    .navigationTitle("Enjoyers")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Dismiss") {
                                isPresentingEnjoyersView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Add") {
                                isPresentingEnjoyersView = false
                                
                            }
                        }
                    }
            }
            .navigationTitle("Mi pantalla otra")
        }
        
        
    }
    func calculatePayerAmount (payer: PartyInfo.Expense.Payer ) -> Double {
        if (payer.exceptionAmount != 0) {
            return payer.exceptionAmount
        } else {
            var totalExceptionValue = 0.0
            var counter = 0.0
            for (expensePayer) in expenseData.payers {
                totalExceptionValue += expensePayer.exceptionAmount
                if (expensePayer.isOn && expensePayer.exceptionAmount == 0.0) {
                    counter += 1.0
                }
            }
            return (expenseData.totalValue - totalExceptionValue) / counter
        }
    }
    func calculateEnjoyerAmount (enjoyer: PartyInfo.Expense.Enjoyer ) -> Double {
        if (enjoyer.exceptionAmount != 0) {
            return enjoyer.exceptionAmount
        } else {
            var totalExceptionValue = 0.0
            var counter = 0.0
            for (expenseEnjoyer) in expenseData.enjoyers {
                totalExceptionValue += expenseEnjoyer.exceptionAmount
                if (expenseEnjoyer.isOn && expenseEnjoyer.exceptionAmount == 0.0) {
                    counter += 1.0
                }
            }
            return (expenseData.totalValue - totalExceptionValue) / counter
        }
    }
}
