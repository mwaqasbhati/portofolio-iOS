//
//  PortfolioModels.swift
//  baraka-iOS
//
//  Created by Muhammad Waqas on 26/06/2025.
//
/// Defines model structures for the portfolio feature.
//
import Foundation

struct PortfolioResponse: Codable {
    let portfolio: Portfolio
}

struct Portfolio: Codable {
    let balance: Balance
    let positions: [Position]
}

struct Balance: Codable {
    let netValue: Double
    let pnl: Double
    let pnlPercentage: Double
}

struct Position: Codable {
    let instrument: Instrument
    let quantity: Double
    let averagePrice: Double
    let cost: Double
    let marketValue: Double
    let pnl: Double
    let pnlPercentage: Double
}

struct Instrument: Codable {
    let ticker: String
    let name: String
    let exchange: String
    let currency: String
    let lastTradedPrice: Double
}
