//
//  SportEvent.swift
//  SportEvents
//
//  Created by Lukeš Andrej on 07/01/2022.
//

import Foundation

struct SportEvent: Hashable {
    
    var name: String
    var address: String
    var duration: Double
    
}

//
//struct SportEvent: Codable, Identifiable {
//    var name: String? = nil
//    var address: String? = nil
//    var duration: int? = nil
//
//
//    // local variable
//    var id: String? = nil
//}
