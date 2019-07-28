import UIKit

final class HomeBottomControlsStackView: UIStackView {

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
        distribution = .fillEqually

        let constraints = [
            heightAnchor.constraint(equalToConstant: 80),
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func setupButtons() {
        let images: [UIImage] = [
            .backward,
            .cross,
            .star,
            .heart,
            .lightning
        ]

        let buttons = images.map { (image) -> UIView in
            let button = UIButton(type: .system)
            button.backgroundColor = .clear
            button.setImage(image, for: .normal)
            return button
        }

        buttons.forEach { addArrangedSubview($0) }
    }
}
