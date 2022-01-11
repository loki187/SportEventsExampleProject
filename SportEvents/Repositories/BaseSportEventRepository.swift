//
//  BaseSportEventRepository.swift
//  SportEvents
//
//  Created by Andrej Lukes on 08/01/2022.
//

import Foundation
import SwiftUI

class BaseSportEventRepository {
  @Published var events = [SportEvent]()
}

protocol SportEventRepository: BaseSportEventRepository {
    func getAll()
    func create(item: SportEvent) -> Result<Void, AppError>
}
