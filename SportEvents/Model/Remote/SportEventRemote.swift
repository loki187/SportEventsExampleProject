//
//  SportEventRemote.swift
//  SportEvents
//
//  Created by Lukeš Andrej on 07/01/2022.
//

import Foundation
import FirebaseFirestoreSwift
import SwiftUI

struct SportEventRemote: Codable {
    @DocumentID var id: String?
    var name: String
    var address: String
    var duration: Double
}
