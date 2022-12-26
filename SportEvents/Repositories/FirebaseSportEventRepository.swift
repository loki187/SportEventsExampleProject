//
//  FirebaseSportEventRepository.swift
//  SportEvents
//
//  Created by Andrej Lukes on 08/01/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class FirebaseSportEventRepository: BaseSportEventRepository, SportEventRepository, ObservableObject {
    
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
    
    func create(item: SportEvent) -> Result<Void, AppError> {
        do {
            let reference = try store.collection(path).addDocument(from: item.toRemote())
            var itemCopy = item
            itemCopy.id = reference.documentID
            self.events.append(itemCopy)
            return .success(())
        } catch {
            //TODO: improve error handling
            print("Unable to add event: \(error.localizedDescription).")
            return .failure(AppError.eventAddFailed(description: error.localizedDescription))
        }
    }
    
    func delete(id: String?) -> Result<Void, AppError> {
        guard let id = id else {
            return .failure(AppError.eventNotFound(description: "Not found"))
        }
        
        store.collection(path).document("\(id)").delete()
        if let firstIndex = self.events.firstIndex(where: { $0.id == id }) {
            events.remove(at: firstIndex)
        }
        return .success(())
    }
}
