import UIKit

class ViewController: UIViewController {

    // MARK: - UI properties

    private lazy var contentStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.isLayoutMarginsRelativeArrangement = true
        return view
    }()

    private lazy var cardsDeckView = UIView()
    private lazy var cardView = CardView()
    private lazy var topStackView = TopNavigationStackView()
    private lazy var bottomStackView = HomeBottomControlsStackView()

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
        cardsDeckView.addSubview(cardView)
        cardView.fillSuperview()
    }
}
