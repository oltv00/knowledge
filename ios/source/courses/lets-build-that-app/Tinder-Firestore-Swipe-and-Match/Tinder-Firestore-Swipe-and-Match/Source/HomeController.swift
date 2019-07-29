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

    private let cardViewModels = [
        User(name: "Kelly", age: 23, profession: "Music DJ", imageName: "1").toCardViewModel(),
        User(name: "Jane", age: 18, profession: "Teacher", imageName: "2").toCardViewModel(),
        User(name: "Maria", age: 25, profession: "Developer", imageName: "3").toCardViewModel(),
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
        cardViewModels.forEach { viewModel in
            let cardView = CardView()
            cardView.image = UIImage(named: viewModel.imageName)
            cardView.attributedInformation = viewModel.attributedString
            cardView.informationAlignment = viewModel.textAlignment

            cardsDeckView.addSubview(cardView)
            cardView.fillSuperview()
        }
    }
}
