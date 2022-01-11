//
//  LocalSportEventRepository.swift
//  SportEvents
//
//  Created by Andrej Lukes on 08/01/2022.
//

import Foundation
import SwiftUI
import RealmSwift

class LocalSportEventRepository: BaseSportEventRepository, SportEventRepository, ObservableObject {
    
    private let realm = try? Realm()
    
    func getAll() {
        print("Getting all events from local...")
        self.events = realm?.objects(SportEventDB.self).map(SportEvent.init) ?? []
    }
    
    func create(item: SportEvent) -> Result<Void, Error> {
        do {
            //let realm = try Realm()
            try realm?.write {
                realm?.add(item.toDB())
                self.events.append(item)
            }
            return .success(())
        } catch let error {
            print(error.localizedDescription)
            return .failure(error)
        }
    }
        
//    func delete() {
//        let object = realm.object(ofType: SportEventDB.self, forPrimaryKey: SportEventDB.self.primaryKey()).filter("id == %@", "1")
//        try! realm.write {
//            realm.delete(object)
//        }
//    }
}
