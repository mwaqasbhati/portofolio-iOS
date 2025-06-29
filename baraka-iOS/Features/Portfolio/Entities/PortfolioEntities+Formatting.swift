//
//  PortfolioModels+Formatting.swift
//  baraka-iOS
//
//  Created by Muhammad Waqas on 26/06/2025.
//
/// Extensions for formatting portfolio DTO values.
//
import Foundation

extension BalanceEntity {
    var isProfit: Bool { pnl >= 0 }
    var pnlDisplay: String { "\(PriceFormatter.format(pnl)) \(PercentageFormatter.format(pnlPercentage))" }
    var pnlValueDisplay: String { PriceFormatter.format(pnl) }
    var pnlPercentageDisplay: String { PercentageFormatter.format(pnlPercentage) }
    var netValueDisplay: String { PriceFormatter.format(netValue) }
}

extension PositionEntity {
    var isProfit: Bool { pnl >= 0 }
    var pnlDisplay: String { "\(PriceFormatter.format(pnl)) \(PercentageFormatter.format(pnlPercentage))" }
    var pnlValueDisplay: String { PriceFormatter.format(pnl) }
    var pnlPercentageDisplay: String { PercentageFormatter.format(pnlPercentage) }
    var lastPriceDisplay: String { "\(instrument.currency) \(PriceFormatter.format(instrument.lastTradedPrice))" }
    var quantityCostDisplay: String {
        "\(quantity) x \(PriceFormatter.format(averagePrice)) = \(PriceFormatter.format(cost))"
    }
    var marketValueDisplay: String { PriceFormatter.format(marketValue) }
}
