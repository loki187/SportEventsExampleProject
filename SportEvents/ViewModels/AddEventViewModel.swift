//
//  AddEventViewModel.swift
//  SportEvents
//
//  Created by Lukeš Andrej on 07/01/2022.
//

import Foundation
import Combine

class AddEventViewModel: ObservableObject {
    
    // MARK: - Public properties
    
    @Published var event: SportEvent
    @Published var modified = false
    
    // MARK: - Internal properties
    
    private var remoteRepo: SportEventRepository
    private var localRepo: SportEventRepository
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    
    init(remoteRepo: SportEventRepository,
         localRepo: SportEventRepository,
         event: SportEvent = SportEvent(id: UUID().uuidString, name: "", address: "", duration: 0)) {
        
        self.remoteRepo = remoteRepo
        self.localRepo = localRepo
        
        self.event = event
        self.$event
            .dropFirst()
            .sink { [weak self] event in
                self?.modified = event.name != "" && event.address != "" && event.duration > 0
            }
            .store(in: &self.cancellables)
    }
    
    func addNewEvent(storeInRemote: Bool, successCallback: () -> Void, errorCallback: (String) -> Void) {
        if storeInRemote {
            event.storageType = .remote
            let result = remoteRepo.create(item: event)
            switch result {
                case .success: successCallback()
                case .failure(_): errorCallback("Something went wrong")
            }
        } else {
            event.storageType = .local
            let result = localRepo.create(item: event)
            switch result {
                case .success: successCallback()
                case .failure(_): errorCallback("Something went wrong")
            }
        }
    }
}
