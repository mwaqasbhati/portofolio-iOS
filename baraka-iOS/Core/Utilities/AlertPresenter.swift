//
//  AlertPresenter.swift
//  baraka-iOS
//
//  Created by Muhammad Waqas on 26/06/2025.
//
/// Utility to present localized error alerts.
//
import UIKit

struct AlertPresenter {
    static func present(message: String, from viewController: UIViewController) {
        let alert = UIAlertController(title: Localization.errorTitle,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Localization.okText, style: .default))
        viewController.present(alert, animated: true)
    }

    static func present(error: PortfolioError, from viewController: UIViewController) {
        let message: String
        switch error {
        case .network:
            message = Localization.networkError
        case .parsing:
            message = Localization.parsingError
        case .noInternet:
            message = Localization.noInternetError
        case .unknown:
            message = Localization.unknownError
        }
        present(message: message, from: viewController)
    }
}
