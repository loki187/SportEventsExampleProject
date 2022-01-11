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

extension Resolver.Name {
    static let remote = Self("Remote")
    static let local = Self("Local")
}

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        
        register(name: .remote) { FirebaseSportEventRepository() as SportEventRepository }.scope(.application)
        register(name: .local) { LocalSportEventRepository() as SportEventRepository }.scope(.application)
    }
}
