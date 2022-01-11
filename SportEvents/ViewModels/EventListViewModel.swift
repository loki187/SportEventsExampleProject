//
//  EventListViewModel.swift
//  SportEvents
//
//  Created by Lukeš Andrej on 07/01/2022.
//

import Foundation
import Combine
import SwiftUI

class EventListViewModel: ObservableObject {
    
    // MARK: - Public properties
    
    @Published var events: [SportEvent] = []
    
    var remoteRepo: SportEventRepository
    var localRepo: SportEventRepository
    
    // MARK: - Private properties
    
    private var remoteEvents: [SportEvent] = []
    private var localEvents: [SportEvent] = []
    
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Init
    
    init(remoteRepo: SportEventRepository = FirebaseSportEventRepository(),
         localRepo: SportEventRepository = LocalSportEventRepository()) {
        
        self.remoteRepo = remoteRepo
        self.localRepo = localRepo
        
        prepareSelectedSubscriber(type: .remote)
        loadData(type: .remote)
    }
    
    // MARK: - Public methods
    
    func loadData(type: StorageType) {
        switch type {
        case .remote: remoteRepo.getAll()
        case .local: localRepo.getAll()
        case .all: prepareAllSubscribers()
        }
    }
    
    func prepareSelectedSubscriber(type: StorageType) {
        switch type {
        case .remote: prepareRemoteSubscriber()
        case .local: prepareLocaleSubscriber()
        case .all: prepareAllSubscribers()
        }
    }
    
    func delete(at offsets: IndexSet) {
        self.events.remove(atOffsets: offsets)
    }
    
    // MARK: - Private methods
    
    private func prepareRemoteSubscriber() {
        self.remoteRepo.$events
            .assign(to: \.events, on: self)
            .store(in: &cancellables)
        print("model events in repo \(self.remoteRepo.events.count)")
    }
    
    private func prepareLocaleSubscriber() {
        self.localRepo.$events
            .assign(to: \.events, on: self)
            .store(in: &cancellables)
    }
    
    private func prepareAllSubscribers() {
        self.remoteRepo.$events
            .assign(to: \.remoteEvents, on: self)
            .store(in: &cancellables)
        self.localRepo.$events
            .assign(to: \.localEvents, on: self)
            .store(in: &cancellables)
        self.events = remoteEvents + localEvents
    }
}
