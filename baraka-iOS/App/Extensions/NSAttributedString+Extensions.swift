//
//  NSAttributedString+ext.swift
//  baraka-iOS
//
//  Created by Muhammad Waqas on 27/06/2025.
//

import UIKit

extension NSAttributedString {
    static func coloredPercentageValueOnly(fullText: String, isProfit: Bool) -> NSAttributedString {
        let attributed = NSMutableAttributedString(string: fullText)
        let color: UIColor = isProfit ? Theme.Colors.profit : Theme.Colors.loss

        if let openParenIndex = fullText.firstIndex(of: "("),
           let closeParenIndex = fullText.firstIndex(of: ")") {
            let percentageStart = fullText.index(after: openParenIndex)
            let percentageEnd = closeParenIndex
            let range = NSRange(percentageStart..<percentageEnd, in: fullText)

            attributed.addAttribute(.foregroundColor, value: color, range: range)
        }

        return attributed
    }
}


