//
//  PercentageFormatter.swift
//  baraka-iOS
//
//  Created by Muhammad Waqas on 27/06/2025.
//
import Foundation

enum PercentageFormatter {
    static let shared: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 0
        formatter.minimumFractionDigits = 0
        formatter.positivePrefix = "+" // adds "+" for positive numbers
        formatter.negativePrefix = "-" // just to be explicit
        formatter.multiplier = 1       // we already provide percentage like 10.0, not 0.1
        return formatter
    }()

    static func format(_ value: Double) -> String {
        guard let formatted = shared.string(from: NSNumber(value: value)) else {
            return "(\(value)%)"
        }
        return "(\(formatted))"
    }
}
