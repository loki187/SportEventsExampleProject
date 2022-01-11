//
//  SportEventDB.swift
//  SportEvents
//
//  Created by Andrej Lukes on 10/01/2022.
//

import Foundation
import RealmSwift

class SportEventDB: Object {
    
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var address = ""
    @objc dynamic var duration = 0.0
    
    override static func primaryKey() -> String? {
        "id"
    }
    
    convenience init(id: String, name: String, address: String, duration: Double) {
        self.init()
        self.id = id
        self.name = name
        self.address = address
        self.duration = duration
    }
}
