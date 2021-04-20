import UIKit

public enum ColorsCoin {
    case greenCoin
    case grayCoin
    case blackCoin
}

extension ColorsCoin {
     public var value: UIColor {
        get {
            switch self {
            case .greenCoin:
                return UIColor(red: 0.5490196078, green: 0.6, blue: 0.3568627451, alpha: 1)
            case .grayCoin:
                return UIColor(red: 0.4196078431, green: 0.4156862745, blue: 0.4196078431, alpha: 1)
            case .blackCoin:
                return UIColor(red: 0.1725490196, green: 0.1607843137, blue: 0.1843137255, alpha: 1)
            }
        }
    }
}

// ColorsCoin.grayCoin.value


//@available(iOS 9.1, *)
//public let star = UIApplicationShortcutIcon.IconType.favorite
