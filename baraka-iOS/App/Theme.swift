import UIKit

struct Theme {
    struct Fonts {
        static let largeTitle = UIFont.boldSystemFont(ofSize: 20)
        static let title = UIFont.systemFont(ofSize: 20)
        static let bodyBold = UIFont.boldSystemFont(ofSize: 16)
        static let body = UIFont.systemFont(ofSize: 16)
        static let caption = UIFont.systemFont(ofSize: 12)
        static let captionBold = UIFont.boldSystemFont(ofSize: 12)
    }

    struct Colors {
        static let accent = UIColor.systemBlue
        static let profit = UIColor.systemGreen
        static let loss = UIColor.systemRed
    }
}
