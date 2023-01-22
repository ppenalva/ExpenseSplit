//
//  PartyDetailEditView.swift
//  ExpenseSplit
//
//  Created by Pablo Penalva on 21/1/23.
//

import SwiftUI

struct PartyDetailEditView: View {
    
    @Binding var dataParty
    :PartyInfo.Data
    
    @State private var newParticipantName = ""
    
    var body: some View {
        List {
            Section(header: Text(" PARTY INFO")) {
                
                TextField("Title",text: $dataParty.title)
            
                    ThemePicker(selection: $dataParty.theme)
            
            }
            Section(header: Text("PARTICIPANTS")) {
                ForEach(dataParty.participants) { participant in
                    Text(participant.name)
                }
                .onDelete { indices in
                    dataParty.participants.remove(atOffsets: indices)
                }
                HStack {
                    TextField("New Participant", text: $newParticipantName)
                    Button(action: {
                        withAnimation {
                            let participant = PartyInfo.Participant(name: newParticipantName)
                            dataParty  .participants.append(participant)
                            newParticipantName = ""
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                    }
                    .disabled(newParticipantName.isEmpty)
                }
            }
        }
    }
}
