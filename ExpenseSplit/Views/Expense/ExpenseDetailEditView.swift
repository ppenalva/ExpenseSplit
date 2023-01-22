//
//  ExpenseDetailEditView.swift
//  ExpenseSplit
//
//  Created by Pablo Penalva on 21/1/23.
//

import SwiftUI

struct ExpenseDetailEditView: View {
    
    @Binding var party: PartyInfo
    @Binding var dataExpense: PartyInfo.Expense.Data
    
    @State private var isPresentingPayersView = false
    @State private var isPresentingEnjoyersView = false
    
    var body: some View {
        List {
            Section(header: Text(" Expense Info")) {
                TextField("Description",text: $dataExpense.description)
                TextField("Amount", value: $dataExpense.totalValue, format: .number)
            }
            HStack {
                Button ("Payers") {
                   
                    var newPayment = PartyInfo.Expense.Payer(payerName: "", amountPayed: 0.0)
                    for participant in party.participants {
                        newPayment.payerName = participant.name
                        newPayment.amountPayed = 0.0
                        dataExpense.payers.append (newPayment)
                    }
                    
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
                ForEach(dataExpense.payers) {payer in
                    
                }
            }
        }
        .sheet(isPresented: $isPresentingPayersView) {
            NavigationView {
                PayersView(dataExpense: $dataExpense)
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
    }
}
