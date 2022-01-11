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
    
    func create(item: SportEvent) -> Result<Void, AppError> {
        do {
            try realm?.write {
                realm?.add(item.toDB())
            }
            self.events.append(item)
            return .success(())
        } catch let error {
            print(error.localizedDescription)
            return .failure(AppError.eventAddFailed(description: error.localizedDescription))
        }
    }
    
    func delete(id: String?) -> Result<Void, AppError> {
        do {
            guard let id = id else {
                return .failure(AppError.eventNotFound(description: "Not found"))
            }
            try realm?.write {
                if let o = realm?.objects(SportEventDB.self).filter("id=%@",id) {
                    realm?.delete(o)
                }
            }
            if let firstIndex = self.events.firstIndex(where: { $0.id == id }) {
                events.remove(at: firstIndex)
            }
            return .success(())
        } catch let error {
            print(error.localizedDescription)
            return .failure(AppError.eventDeleteFailed(description: error.localizedDescription))
        }
    }
}
