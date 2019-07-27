import UIKit

final class TopNavigationStackView: UIStackView {

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

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
        let images: [UIImage] = [
            .profile,
            UIImage(),
            .flame,
            UIImage(),
            .messages,
        ]

        let buttons = images.map { (image) -> UIView in
            let button = UIButton(type: .system)
            button.backgroundColor = .white
            button.setImage(image, for: .normal)
            return button
        }

        buttons.forEach { addArrangedSubview($0) }
    }
}
