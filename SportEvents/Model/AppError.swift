//
//  AppError.swift
//  SportEvents
//
//  Created by Andrej Lukes on 11/01/2022.
//

import Foundation

enum AppError: Error, Equatable {
    case eventAddFailed(description: String)
    case eventDeleteFailed(description: String)
    case eventNotFound(description: String)
    case realmInitFailed(description: String)
    case network(description: String)

    var description: String {
        switch self {
        case .eventAddFailed(let value):
            return value
        case .eventDeleteFailed(let value):
            return value
        case .eventNotFound(let value):
            return value
        case .realmInitFailed(let value):
            return value
        case .network(let value):
            return value
        }
    }
}
