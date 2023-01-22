//
//  PartyView.swift
//  ExpenseSplit
//
//  Created by Pablo Penalva on 21/1/23.
//

import SwiftUI

struct PartyView: View {
    
    @Binding var party: PartyInfo
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(party.title)
                .font(.headline)
            Spacer()
            HStack {
                Label("\(party.participants.count)", systemImage: "person.3")
                    .padding(.trailing, 20)
            }
            .font(.caption)
        }
        .padding()
        .foregroundColor(party.theme.accentColor)
    }
}
