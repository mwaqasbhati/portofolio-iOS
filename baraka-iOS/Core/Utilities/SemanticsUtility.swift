//
//  SemanticsUtility.swift
//  baraka-iOS
//
//  Created by Muhammad Waqas on 26/06/2025.
//
/// Utility for recursively setting semantic content attributes.
//
import UIKit

struct SemanticsUtility {
    /// Recursively updates the `semanticContentAttribute` of the provided view
    /// and all of its subviews.
    static func updateSemantics(for view: UIView,
                                semantic: UISemanticContentAttribute) {
        view.semanticContentAttribute = semantic
        for subview in view.subviews {
            updateSemantics(for: subview, semantic: semantic)
        }
        if let stackView = view as? UIStackView {
            for arranged in stackView.arrangedSubviews {
                updateSemantics(for: arranged, semantic: semantic)
            }
        }
    }
}
