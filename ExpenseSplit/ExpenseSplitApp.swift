//
//  ExpenseSplitApp.swift
//  ExpenseSplit
//
//  Created by Pablo Penalva on 20/1/23.
//

import SwiftUI

@main
struct ExpenseSplitApp: App {
    
    @StateObject private var storePartyInfo = PartyInfoStore()
    
    var body: some Scene {
        
        WindowGroup {
            
            NavigationView {
                
                PartiesView(parties: $storePartyInfo.parties) {
                    PartyInfoStore.save(parties: storePartyInfo.parties) { result in
                        if case .failure(let error) = result {
                            fatalError(error.localizedDescription)
                        }
                    }
                }
                
            }
            .onAppear {
                PartyInfoStore.load { result in
                    switch result {
                    case .failure(let error):
                        fatalError(error.localizedDescription)
                    case .success(let parties):
                        storePartyInfo.parties = parties
                    }
                }
            }
        }
    }
}
