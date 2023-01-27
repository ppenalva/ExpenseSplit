//
//  EnjoyersView.swift
//  ExpenseSplit
//
//  Created by Pablo Penalva on 22/1/23.
//

import SwiftUI

struct EnjoyersView: View {
    
    @Binding var expenseData: PartyInfo.Expense.Data
    
    var body: some View {
        List {
            
            HStack {
                Button ("Deselect All") {
                    for i in 0..<expenseData.enjoyers.count {
                        expenseData.enjoyers[i].isOn = false
                    }
                }
                .buttonStyle(BorderlessButtonStyle())
                Spacer()
                Button ("Select All") {
                    for i in 0..<expenseData.enjoyers.count {
                        expenseData.enjoyers[i].isOn = true
                    }
                }
                .buttonStyle(BorderlessButtonStyle())
                
            }
            
            ForEach ( $expenseData.enjoyers) { $enjoyer in
            HStack{
                Toggle(isOn: $enjoyer.isOn){}
                Text(enjoyer.enjoyerName)
                TextField("Amount", value: $enjoyer.exceptionAmount, format: .number)
            }
            }
        }
    }
}
