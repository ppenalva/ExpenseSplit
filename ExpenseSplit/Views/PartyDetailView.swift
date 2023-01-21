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
    
    var body: some View {
        List {
            Section(header: Text(" Party Info")) {
                HStack {
                    Label("Theme", systemImage: "paintpalette")
                    Text(party.theme.name)
                        .padding(4)
                        .foregroundColor(party.theme.accentColor)
                        .background(party.theme.mainColor)
                        .cornerRadius(4)
                }
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
            .navigationTitle(party.title)
        }
    }
}

