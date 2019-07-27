import UIKit

extension UIImage {

    static var star: UIImage {
        return named("star").withRenderingMode(.alwaysOriginal)
    }

    static var lightning: UIImage {
        return named("lightning").withRenderingMode(.alwaysOriginal)
    }

    static var heart: UIImage {
        return named("heart").withRenderingMode(.alwaysOriginal)
    }

    static var cross: UIImage {
        return named("cross").withRenderingMode(.alwaysOriginal)
    }

    static var backward: UIImage {
        return named("backward").withRenderingMode(.alwaysOriginal)
    }

    static var flame: UIImage {
        return named("flame").withRenderingMode(.alwaysOriginal)
    }

    static var messages: UIImage {
        return named("messages").withRenderingMode(.alwaysOriginal)
    }

    static var profile: UIImage {
        return named("profile").withRenderingMode(.alwaysOriginal)
    }

    static func named(_ name: String) -> UIImage {
        guard let image = UIImage(named: name) else {
            assertionFailure("Can't load image \(name)")
            return UIImage()
        }
        return image
    }
}
