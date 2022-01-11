//
//  Event.swift
//  SportEvents
//
//  Created by Andrej Lukes on 08/01/2022.
//

import Foundation
import SwiftUI
import FirebaseFirestoreSwift
import RealmSwift

struct SportEvent: Identifiable {
    var id: String = UUID().uuidString
    var name: String
    var address: String
    var duration: Double
    var storageType: EventStorageType?
    
    var color: Color {
        get {
            switch storageType {
            case .remote: return Color.blue.opacity(0.5)
            case .local: return Color.red.opacity(0.5)
            default: return Color.white
            }
        }
    }
}

extension SportEvent {
    enum EventStorageType: Int, Codable {
        case remote, local
    }
}

// MARK: Convenience init
extension SportEvent {
    init(sportEventDB: SportEventDB) {
        id = sportEventDB.id
        name = sportEventDB.name
        address = sportEventDB.address
        duration = sportEventDB.duration
        storageType = .local
    }
    
    init(sportEventRemote: SportEventRemote) {
        id = sportEventRemote.id ?? UUID().uuidString
        name = sportEventRemote.name
        address = sportEventRemote.address
        duration = sportEventRemote.duration
        storageType = .remote
    }
}

extension SportEvent {
    func toRemote() -> SportEventRemote {
        return SportEventRemote(name: self.name, address: self.address, duration: self.duration)
    }
    
    func toDB() -> SportEventDB {
        return SportEventDB(id: self.id,
                            name: self.name,
                            address: self.address,
                            duration: self.duration)
    }
}

#if DEBUG

extension SportEvent {
    
    static let mockedData: [SportEvent] = [
        SportEvent(id: "1", name: "Test event 1", address: "Address 1", duration: 4.0, storageType: .local),
        SportEvent(id: "2", name: "Test event 2", address: "Address 2", duration: 4.0, storageType: .remote),
        SportEvent(id: "3", name: "Test event 3", address: "Address 3", duration: 4.0, storageType: .local)
    ]
}

#endif
