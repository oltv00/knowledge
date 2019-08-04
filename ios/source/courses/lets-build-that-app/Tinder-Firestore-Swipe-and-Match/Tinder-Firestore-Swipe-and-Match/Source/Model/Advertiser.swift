import UIKit

struct Advertiser {
    let title: String
    let brandName: String
    let posterPhotoName: String
}

// MARK: - CardViewModelCreatable

extension Advertiser: CardViewModelCreatable {
    func toCardViewModel() -> CardViewModel {
        return CardViewModel(
            imageNames: [posterPhotoName],
            attributedString: makeAttributedString(self),
            textAlignment: .center
        )
    }
}

private func makeAttributedString(_ advertiser: Advertiser) -> NSAttributedString {
    let titleString = NSMutableAttributedString(
        string: advertiser.title,
        attributes: [.font: UIFont.systemFont(ofSize: 34, weight: .heavy)]
    )
    let brandName = NSAttributedString(
        string: "\n\(advertiser.brandName)",
        attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .bold)]
    )

    let resultString = NSMutableAttributedString()
    [
        titleString,
        brandName,
    ].forEach(resultString.append)

    return resultString
}
