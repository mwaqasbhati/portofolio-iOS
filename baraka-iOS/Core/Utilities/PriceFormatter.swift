//
//  PriceFormatter.swift
//  baraka-iOS
//
//  Created by Muhammad Waqas on 26/06/2025.
//
/// Helper for formatting numeric prices.
//
import Foundation

struct PriceFormatter {
    static func format(_ value: Double) -> String {
        String(format: "%.2f", value)
    }
}
