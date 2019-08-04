import UIKit

final class TopNavigationStackView: UIStackView {

    // MARK: - Observers

    var profileButtonObserver: (() -> Void)?

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    // MARK: - UI properties

    private lazy var profileButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setImage(.profile, for: .normal)
        button.addTarget(self,
                         action: #selector(profileButtonDidPress(_:)),
                         for: .touchUpInside)
        return button
    }()

    // MARK: - Setup UI

    private func setupView() {
        setupStackView()
        setupButtons()
    }

    private func setupStackView() {
        distribution = .equalCentering
        isLayoutMarginsRelativeArrangement = true
        directionalLayoutMargins = .init(top: 0, leading: 16, bottom: 0, trailing: 16)

        let constraints = [
            heightAnchor.constraint(equalToConstant: 80),
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func setupButtons() {
        var buttons: [UIView] = [
            profileButton,
        ]

        let images: [UIImage] = [
            UIImage(),
            .flame,
            UIImage(),
            .messages,
        ]

        buttons += images.map { (image) -> UIView in
            let button = UIButton(type: .system)
            button.backgroundColor = .clear
            button.setImage(image, for: .normal)
            return button
        }

        buttons.forEach { addArrangedSubview($0) }
    }

    // MARK: - Actions

    @objc
    private func profileButtonDidPress(_ sender: UIButton) {
        profileButtonObserver?()
    }
}
