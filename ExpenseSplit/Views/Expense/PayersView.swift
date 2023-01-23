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
