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
    
    let saveAction: ()->Void
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        
            .onChange(of: scenePhase) { phase in
                if phase == .inactive { saveAction() }
            }
    }
}
