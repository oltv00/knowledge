import UIKit

protocol CardViewModelCreatable {
    func toCardViewModel() -> CardViewModel
}

struct CardViewModel {
    let imageNames: [String]
    let attributedString: NSAttributedString
    let textAlignment: NSTextAlignment
}
