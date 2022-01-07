//
//  EventListViewModel.swift
//  SportEvents
//
//  Created by Lukeš Andrej on 07/01/2022.
//

import Foundation

class EventListViewModel: ObservableObject {
    
    @Published var events: [SportEvent] = []
    
    func loadEvents() {
        events.append(SportEvent(name: "A", address: "B", duration: 3))
        events.append(SportEvent(name: "B", address: "C", duration: 4))
    }
    
}
