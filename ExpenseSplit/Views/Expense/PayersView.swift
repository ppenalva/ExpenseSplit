//
//  PayersView.swift
//  ExpenseSplit
//
//  Created by Pablo Penalva on 22/1/23.
//

import SwiftUI

struct PayersView: View {
    
    @Binding var expenseData: PartyInfo.Expense.Data
    
    var body: some View {
        List {
        HStack {
            Button ("Deselect All") {
                for i in 0..<expenseData.payers.count {
                    expenseData.payers[i].isOn = false
                }
            }
            .buttonStyle(BorderlessButtonStyle())
            Spacer()
            Button ("Select All") {
                for i in 0..<expenseData.payers.count {
                    expenseData.payers[i].isOn = true
                }
            }
            .buttonStyle(BorderlessButtonStyle())
            
        }
      
            ForEach ( $expenseData.payers) { $payer in
            HStack{
                Toggle(isOn: $payer.isOn){}
                Text(payer.payerName)
                TextField("Amount", value: $payer.exceptionAmount, format: .number)
            }
            }
        }
    }
}
