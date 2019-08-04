import UIKit

final class HomeController: UIViewController {

    // MARK: - UI properties

    private lazy var contentStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
        return view
    }()

    private lazy var cardsDeckView = UIView()
    private lazy var topStackView = TopNavigationStackView()
    private lazy var bottomStackView = HomeBottomControlsStackView()

    // MARK: - Data

    private lazy var models: [CardViewModelCreatable] = [
        User(name: "Kelly", age: 23, profession: "Music DJ", imageNames: ["k_1", "k_2", "k_3", "k_4"]),
//        User(name: "Kelly", age: 23, profession: "Music DJ", imageNames: ["1"]),
        User(name: "Jane", age: 18, profession: "Teacher", imageNames: ["j_1", "j_2", "j_3"]),
//        User(name: "Jane", age: 18, profession: "Teacher", imageNames: ["2"]),
        User(name: "Maria", age: 25, profession: "Developer", imageNames: ["3"]),
        Advertiser(title: "Shutter Stock", brandName: "MXT 515", posterPhotoName: "advertiser"),
    ]

    // MARK: - View models

    private lazy var viewModels = models.map { $0.toCardViewModel() }

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

        [
            topStackView,
            cardsDeckView,
            bottomStackView,
        ].forEach { contentStackView.addArrangedSubview($0) }
        contentStackView.bringSubviewToFront(cardsDeckView)
    }

    private func setupCardsDeckView() {
        viewModels.forEach { viewModel in
            let cardView = CardView()
            cardView.cardViewModel = viewModel

            cardsDeckView.insertSubview(cardView, at: 0)
            cardView.fillSuperview()
        }
    }
}
