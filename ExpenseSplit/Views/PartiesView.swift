//
//  PartiesView.swift
//  ExpenseSplit
//
//  Created by Pablo Penalva on 21/1/23.
//

import SwiftUI

struct PartiesView: View {
    
    @Binding var parties: [PartyInfo]
    
    @Environment(\.scenePhase) private var scenePhase
    
    @State private var newPartyData = PartyInfo.Data()
    
    @State private var isPresentingNewPartyView = false
    
    let saveAction: ()->Void
    
    var body: some View {
        
        List {
            ForEach($parties) { $party in
                NavigationLink(destination: PartyDetailView(party: $party)) {
                    PartyView(party: $party)
                        .listRowBackground(party.theme.mainColor)
                }
            }
            
        }
        .navigationTitle("Parties")
        .toolbar {
            Button(action: {
                newPartyData = PartyInfo.Data()
                isPresentingNewPartyView = true}) {
                    Image(systemName: "plus")
                }
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
        .sheet(isPresented: $isPresentingNewPartyView) {
            NavigationView {
                PartyDetailEditView( dataParty: $newPartyData)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Dismiss") {
                                isPresentingNewPartyView = false
                                newPartyData = PartyInfo.Data()
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Add") {
                                let newParty = PartyInfo(data: newPartyData)
                                parties.append(newParty)
                                isPresentingNewPartyView = false
                                newPartyData = PartyInfo.Data()
                            }
                        }
                    }
            }
            
        }
    }
       
}
