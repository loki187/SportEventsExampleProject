//
//  EventListViewModel.swift
//  SportEvents
//
//  Created by Lukeš Andrej on 07/01/2022.
//

import Foundation
import Combine
import SwiftUI
import Resolver

class EventListViewModel: ObservableObject {
    
    // MARK: - Public properties
    
    @Published var selectedStorageType: StorageType = .remote
    @Published var events: [SportEvent] = []
    
    // MARK: - Private properties
    
    private var remoteRepo: SportEventRepository = Resolver.resolve(name: .remote)
    private var localRepo: SportEventRepository = Resolver.resolve(name: .local)
    
    private var remoteEvents: [SportEvent] = []
    private var localEvents: [SportEvent] = []
    
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Init
    
    init() {
        
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
        if selectedStorageType == .remote {
            if let firstIndex = offsets.first {
                let _ = remoteRepo.delete(id: self.events[firstIndex].id)
                //TODO: handle result nicely
            }
        } else {
            if let firstIndex = offsets.first {
                let _ = localRepo.delete(id: self.events[firstIndex].id)
                //TODO: handle result nicely
            }
        }
    }
    
    // MARK: - Private methods
    
    private func prepareRemoteSubscriber() {
        self.remoteRepo.$events
            .assign(to: \.events, on: self)
            .store(in: &cancellables)
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
