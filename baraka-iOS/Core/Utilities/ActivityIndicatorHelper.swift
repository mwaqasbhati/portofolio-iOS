//
//  ActivityIndicatorHelper.swift
//  baraka-iOS
//
//  Created by Muhammad Waqas on 26/06/2025.
//
//  Utility for configuring and adding a UIActivityIndicatorView to a view.
//
import UIKit

struct ActivityIndicatorHelper {
    /// Creates an activity indicator, adds it to the provided view and centers it
    /// using Auto Layout. The indicator hides when stopped.
    /// - Parameters:
    ///   - view: The parent view that will host the indicator.
    ///   - style: The style of the indicator. Default is `.large`.
    /// - Returns: The configured `UIActivityIndicatorView` instance.
    static func add(to view: UIView,
                    style: UIActivityIndicatorView.Style = .large) -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: style)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        view.addSubview(indicator)
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        return indicator
    }
}

