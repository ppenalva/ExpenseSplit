//
//  ExpenseDetailView.swift
//  ExpenseSplit
//
//  Created by Pablo Penalva on 23/1/23.
//

import SwiftUI

struct ExpenseDetailView: View {
    
    @Binding var expense: PartyInfo.Expense
    
    @State private var isPresentingPayersView = false
    @State private var isPresentingEnjoyersView = false
    
    var body: some View {
        List {
            Section(header: Text(" Expense Info")) {
                Text( expense.description)
                Text(String(format: "%.2f",expense.totalValue))
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
                ForEach(expense.payers) {payer in
                
                    Text(payer.payerName)
                    
                    
                }
            }
        }
    }
}
