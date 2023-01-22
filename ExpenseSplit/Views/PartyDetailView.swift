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
    @State private var isPresentingPartyEditView = false
    
    @State private var newExpenseData = PartyInfo.Expense.Data()
    @State private var isPresentingNewExpenseView = false
   
    @State private var isPresentingNewPaymentView = false
    
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
                Button ("New Expense") {
                    
                    newExpenseData.description = ""
                    newExpenseData.totalValue = 0.0
                    newExpenseData.payers = []
                    
                    isPresentingNewExpenseView = true
                   
                }
                .buttonStyle(BorderlessButtonStyle())
               Spacer()
               Button ("New Payment") {
                    isPresentingNewPaymentView = true
               }
               .buttonStyle(BorderlessButtonStyle())
            }
            
            Section(header: Text("Participants")) {
                ForEach(party.participants) { participant in
                    HStack {
                        Label(participant.name, systemImage: "person")
                    }
                }
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
                ExpenseDetailEditView(party: $party, dataExpense: $newExpenseData)
                    .navigationTitle("Expenses")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Dismiss") {
                                isPresentingNewExpenseView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Add") {
                                let newExpense = PartyInfo.Expense(data: newExpenseData)
                                party.expenses.append(newExpense)
                            isPresentingNewExpenseView = false
                                
                            }
                        }
                    }
            }
        }
        .sheet(isPresented: $isPresentingNewPaymentView) {
            NavigationView {
                PaymentDetailEditView()
                    .navigationTitle("Payments")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Dismiss") {
                                isPresentingNewPaymentView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Add") {
                                
                                isPresentingNewPaymentView = false
                                
                            }
                        }
                    }
            }
            .navigationTitle("Mi pantalla otra")
        }
    }
}


