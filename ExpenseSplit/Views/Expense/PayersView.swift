//
//  PayersView.swift
//  ExpenseSplit
//
//  Created by Pablo Penalva on 22/1/23.
//

import SwiftUI

struct PayersView: View {
    
    @Binding var dataExpense: PartyInfo.Expense.Data
    
    var body: some View {
        
        ForEach ( $dataExpense.payers) { $payer in
            HStack {
                Text(payer.payerName)
                TextField("Amount", value: $payer.amountPayed, format: .number)
            }
        }
    }
}
