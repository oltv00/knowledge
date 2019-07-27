import UIKit

class ViewController: UIViewController {

    // MARK: - UI properties

    private lazy var contentStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        return view
    }()

    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()

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
        view.addSubview(contentStackView)
        contentStackView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.leadingAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            trailing: view.trailingAnchor
        )

        [
            topStackView,
            contentView,
            bottomStackView,
        ].forEach { contentStackView.addArrangedSubview($0) }
    }
}
