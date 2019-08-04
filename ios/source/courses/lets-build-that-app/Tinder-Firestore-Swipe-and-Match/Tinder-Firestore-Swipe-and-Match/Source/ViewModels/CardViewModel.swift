import UIKit

protocol CardViewModelCreatable {
    func toCardViewModel() -> CardViewModel
}

class CardViewModel {

    // MARK: - Initialize

    let imageNames: [String]
    let attributedString: NSAttributedString
    let textAlignment: NSTextAlignment

    init(imageNames: [String],
         attributedString: NSAttributedString,
         textAlignment: NSTextAlignment) {
        self.imageNames = imageNames
        self.attributedString = attributedString
        self.textAlignment = textAlignment
    }

    // MARK: - Observers

    var imageIndexObserver: ((Int, UIImage?) -> Void)?

    // MARK: - Observable

    private var imageIndex = 0 {
        didSet {
            let imageName = imageNames[imageIndex]
            let image = UIImage(named: imageName)
            imageIndexObserver?(imageIndex, image)
        }
    }

    // MARK: - Interacts

    func advanceToNextPhoto() {
        imageIndex = min(imageIndex + 1, imageNames.count - 1)
    }

    func goToPreviousPhoto() {
        imageIndex = max(0, imageIndex - 1)
    }
}
