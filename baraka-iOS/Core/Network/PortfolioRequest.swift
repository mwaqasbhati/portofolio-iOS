//
//  PortfolioRequest.swift
//  baraka-iOS
//
//  Created by Muhammad Waqas on 26/06/2025.
//
/// API request describing how to fetch the portfolio.
//
import Foundation

/// Request object to fetch the user's portfolio.
struct PortfolioRequest: APIRequest {
    typealias Response = PortfolioResponse

    let baseURL: URL
    let path = "/c/60b7-70a6-4ee3-bae8"

    init(baseURL: URL) {
        self.baseURL = baseURL
    }
}
