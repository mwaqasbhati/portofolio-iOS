//
//  Localization.swift
//  baraka-iOS
//
//  Created by Muhammad Waqas on 26/06/2025.
//
/// Handles runtime language selection and localized strings.
//
import UIKit
import Foundation

enum Language: String {
    case en
    case ar

    mutating func toggle() {
        self = self == .en ? .ar : .en
    }

    var semantic: UISemanticContentAttribute {
        switch self {
        case .en: return .forceLeftToRight
        case .ar: return .forceRightToLeft
        }
    }
}

struct Localization {
    private static let key = "appLanguage"

    static var current: Language {
        get {
            if let value = UserDefaults.standard.string(forKey: key),
               let lang = Language(rawValue: value) {
                return lang
            }
            return .en
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: key)
        }
    }

    static func toggleLanguage() {
        var lang = current
        lang.toggle()
        current = lang
    }

    static func setLanguage(_ language: Language) {
        current = language
    }

    static var buttonTitle: String {
        switch current {
        case .en: return "AR"
        case .ar: return "EN"
        }
    }

    static var netValueText: String {
        switch current {
        case .en: return "Net Value"
        case .ar: return "القيمة الصافية"
        }
    }

    static var pnlText: String {
        switch current {
        case .en: return "PnL"
        case .ar: return "الأرباح والخسائر"
        }
    }

    static var pnlWithPercentageText: String {
        switch current {
        case .en: return "PnL (PnL %)"
        case .ar: return "الأرباح والخسائر (% الأرباح والخسائر)"
        }
    }

    static var errorTitle: String {
        switch current {
        case .en: return "Error"
        case .ar: return "خطأ"
        }
    }

    static var okText: String {
        switch current {
        case .en: return "OK"
        case .ar: return "حسناً"
        }
    }

    static var networkError: String {
        switch current {
        case .en: return "A network error occurred."
        case .ar: return "حدث خطأ في الشبكة."
        }
    }

    static var parsingError: String {
        switch current {
        case .en: return "Failed to parse response."
        case .ar: return "فشل في معالجة البيانات."
        }
    }

    static var noInternetError: String {
        switch current {
        case .en: return "No internet connection."
        case .ar: return "لا يوجد اتصال بالإنترنت."
        }
    }

    static var unknownError: String {
        switch current {
        case .en: return "An unknown error occurred."
        case .ar: return "حدث خطأ غير معروف."
        }
    }
}

