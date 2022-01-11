//
//  FirebaseEventRepository.swift
//  SportEvents
//
//  Created by Andrej Lukes on 08/01/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class FirebaseEventRepository: BaseSportEventRepository, SportEventRepository, ObservableObject {
    
    private let path: String = "events"
    private let store = Firestore.firestore()
        
    func getAll() {
        print("Getting all events from remote...")
        store.collection(path).getDocuments { querySnapshot, error in
            if let error = error {
                print("Error getting events: \(error.localizedDescription)")
                return
            }
            self.events = querySnapshot?.documents.compactMap { document in
                return try? document.data(as: SportEventRemote.self).map(SportEvent.init)
            } ?? []
        }
    }
    
    func create(item: SportEvent) -> Result<Void, Error> {
        do {
            let _ = try store.collection(path).addDocument(from: item.toRemote())
            self.events.append(item)
            return .success(())
        } catch {
            //TODO: improve error handling
            print("Unable to add event: \(error.localizedDescription).")
            return .failure(error)
        }
    }
    
//        func delete(item: SportEvent) -> Result<Void, Error> {
//            guard let id = item.id else {
//                return .failure()
//            }
//            do {
//                _ = try store.collection(path).document("\(id)").delete()
//                let index = self.events.firstIndex(where: $0.id == item.id)
//                self.events.remove(at: index)
//                return .success(())
//            } catch {
//                print("Unable to remove event: \(error.localizedDescription).")
//                return .failure(error)
//            }
//        }
}
