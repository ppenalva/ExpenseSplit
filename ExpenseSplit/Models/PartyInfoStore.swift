//
//  PartyInfoStore.swift
//  ExpenseSplit
//
//  Created by Pablo Penalva on 21/1/23.
//

import Foundation
import SwiftUI

class PartyInfoStore: ObservableObject {
    @Published var parties: [PartyInfo] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("parties.data")
    }
    static func load(completion: @escaping (Result<[PartyInfo], Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    return
                }
                let parties = try JSONDecoder().decode([PartyInfo].self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(parties))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    static func save(parties: [PartyInfo], completion: @escaping (Result<Int, Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(parties)
                let outfile = try fileURL()
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(parties.count))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
