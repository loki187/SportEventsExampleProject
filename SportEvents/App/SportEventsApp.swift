//
//  SportEventsApp.swift
//  SportEvents
//
//  Created by Lukeš Andrej on 07/01/2022.
//

import SwiftUI
import Firebase

@main
struct SportEventsApp: App {
    let persistenceController = PersistenceController.shared
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            EventListView()
            //ContentView()
            //    .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
