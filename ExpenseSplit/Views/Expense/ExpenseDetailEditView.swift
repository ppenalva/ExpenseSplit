//
//  ExpenseDetailEditView.swift
//  ExpenseSplit
//
//  Created by Pablo Penalva on 21/1/23.
//

import SwiftUI

struct ExpenseDetailEditView: View {
    
    @Binding var party: PartyInfo
    
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
                
                    Text(payer.payerName)
                    
                    
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
    }
}
