import UIKit

struct User {
    let name: String
    let age: Int
    let profession: String
    let imageName: String

    func toCardViewModel() -> CardViewModel {
        return CardViewModel(
            imageName: imageName,
            attributedString: makeAttributedInformation(self),
            textAlignment: .left
        )
    }
}

private func makeAttributedInformation(_ user: User) -> NSAttributedString {
    let nameString = NSMutableAttributedString(
        string: user.name,
        attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)]
    )
    let ageString = NSAttributedString(
        string: "  \(user.age)",
        attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .medium)]
    )
    let professionString = NSAttributedString(
        string: "\n\(user.profession)",
        attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .medium)]
    )

    let resultString = NSMutableAttributedString()
    [
        nameString,
        ageString,
        professionString,
    ].forEach(resultString.append)

    return resultString
}
