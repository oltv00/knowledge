import UIKit

final class HomeController: UIViewController {

    // MARK: - UI properties

    private lazy var contentStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.isLayoutMarginsRelativeArrangement = true
        return view
    }()

    private lazy var cardsDeckView = UIView()
    private lazy var topStackView = TopNavigationStackView()
    private lazy var bottomStackView = HomeBottomControlsStackView()

    // MARK: - Data

    private let users = [
        User(name: "Kelly", age: 23, profession: "Music DJ", imageName: "1"),
        User(name: "Jane", age: 18, profession: "Teacher", imageName: "2"),
        User(name: "Maria", age: 25, profession: "Developer", imageName: "3"),
    ]

    // MARK: - Managing the View

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubviews()
    }

    // MARK: - Setup UI

    private func setupSubviews() {
        setupContentStackView()
        setupCardsDeckView()
    }

    private func setupContentStackView() {
        view.addSubview(contentStackView)
        contentStackView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.leadingAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            trailing: view.trailingAnchor
        )

        contentStackView.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)

        [
            topStackView,
            cardsDeckView,
            bottomStackView,
        ].forEach { contentStackView.addArrangedSubview($0) }
        contentStackView.bringSubviewToFront(cardsDeckView)
    }

    private func setupCardsDeckView() {
        users.forEach { user in
            let cardView = CardView()
            cardView.image = UIImage(named: user.imageName)
            cardView.attributedInformation = makeAttributedInformation(user)

            cardsDeckView.addSubview(cardView)
            cardView.fillSuperview()
        }
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
