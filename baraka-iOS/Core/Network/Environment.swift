//
//  Environment.swift
//  baraka-iOS
//
//  Created by Muhammad Waqas on 26/06/2025.
//
/// Provides environment-specific configuration values.
//
import Foundation

enum Environment {
    case development
    case production

    static var current: Environment {
#if DEBUG
        return .development
#else
        return .production
#endif
    }

    var baseURL: URL {
        switch self {
        case .development:
            guard let url = URL(string: "https://dummyjson.com") else {
                preconditionFailure("Invalid base URL")
            }

            return url
        case .production:
            guard let url = URL(string: "https://dummyjson.com") else {
                preconditionFailure("Invalid base URL")
            }

            return url
        }
    }
}
