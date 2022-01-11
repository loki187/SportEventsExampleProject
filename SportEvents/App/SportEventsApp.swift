//
//  SportEventsApp.swift
//  SportEvents
//
//  Created by Lukeš Andrej on 07/01/2022.
//

import SwiftUI
import Firebase
import Resolver

@main
struct SportEventsApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            EventListView()
        }
    }
}

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        
        register { EventListViewModel(remoteRepo: resolve(), localRepo: resolve()) }
        register { AddEventViewModel(remoteRepo: resolve(), localRepo: resolve(), event: SportEvent.empty()) }
        
        register { FirebaseSportEventRepository() as SportEventRepository }.scope(.application)
        register { LocalSportEventRepository() as SportEventRepository}.scope(.application)
    }
}
