import UIKit

final class CardView: UIView {

    // MARK: - CardViewModel

    var cardViewModel: CardViewModel! {
        didSet {
            updateUI()
            updateBarsStackView()
            setupObserving()
        }
    }

    private func updateUI() {
        let imageName = cardViewModel.imageNames.first ?? ""
        imageView.image = UIImage(named: imageName)
        informationLabel.attributedText = cardViewModel.attributedString
        informationLabel.textAlignment = cardViewModel.textAlignment
    }

    private func updateBarsStackView() {
        (0..<cardViewModel.imageNames.count).forEach { _ in
            let view = UIView()
            view.backgroundColor = Constants.deselectedBarColor
            barsStackView.addArrangedSubview(view)
        }
        barsStackView.arrangedSubviews.first?.backgroundColor = Constants.selectedBarColor
    }

    private func setupObserving() {
        cardViewModel.imageIndexObserver = { [weak self] (index, image) in
            guard let self = self else { return }

            self.imageView.image = image

            self.barsStackView
                .arrangedSubviews.forEach {
                $0.backgroundColor = Constants.deselectedBarColor
            }
            self.barsStackView
                .arrangedSubviews[index]
                .backgroundColor = Constants.selectedBarColor
        }
    }

    // MARK: - UI properties

    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()

    private let informationLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = .systemFont(ofSize: 34, weight: .heavy)
        view.numberOfLines = 0
        return view
    }()

    private let barsStackView: UIStackView = {
        let view = UIStackView()
        view.spacing = 4
        view.distribution = .fillEqually
        return view
    }()

    // MARK: - Gestures

    private lazy var panGesture: UIPanGestureRecognizer = {
        let gesture = UIPanGestureRecognizer(
            target: self,
            action: #selector(panGestureHandler(_:))
        )
        return gesture
    }()

    private lazy var tapGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer(
            target: self,
            action: #selector(tapGestureHandler(_:))
        )
        return gesture
    }()

    // MARK: - Layers

    private let gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [
            UIColor.clear.cgColor,
            UIColor.black.cgColor,
        ]
        layer.locations = [0.5, 1.1]
        return layer
    }()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    // MARK: - Setup UI

    private func setupView() {
        setupSubviews()
        setupGestures()
        setupBarsStackView()
    }

    private func setupSubviews() {
        addSubview(imageView)
        layer.addSublayer(gradientLayer)
        addSubview(informationLabel)

        imageView.fillSuperview()
        informationLabel.anchor(
            top: nil,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            padding: .init(top: 0, left: 16, bottom: 16, right: 16)
        )
    }

    private func setupGestures() {
        addGestureRecognizer(panGesture)
        addGestureRecognizer(tapGesture)
    }

    private func setupBarsStackView() {
        addSubview(barsStackView)
        barsStackView.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing: trailingAnchor,
            padding: .init(top: 8, left: 8, bottom: 0, right: 8),
            size: .init(width: 0, height: 4)
        )
    }

    // MARK: - Laying out Subviews

    override func layoutSubviews() {
        super.layoutSubviews()
        setupCornerRadius()
        gradientLayer.frame = bounds
    }

    private func setupCornerRadius() {
        let mask = CAShapeLayer()
        let path = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: 10
        )
        mask.path = path.cgPath
        layer.mask = mask
    }
}

// MARK: - Gesture handlers

private extension CardView {

    // MARK: - Tap gesture

    @objc
    private func tapGestureHandler(_ sender: UITapGestureRecognizer) {
        let tapLocation = sender.location(in: nil)
        let shouldAdvanceNextPhoto = tapLocation.x > bounds.width / 2
            ? true
            : false

        if shouldAdvanceNextPhoto {
            cardViewModel.advanceToNextPhoto()
        } else {
            cardViewModel.goToPreviousPhoto()
        }
    }

    // MARK: - Pan gesture

    @objc
    private func panGestureHandler(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began: handleBeganPanState(sender)
        case .changed: handleChangedPanState(sender)
        case .ended: handleEndedPanState(sender)
        case .cancelled: handleCancelPanState(sender)
        default: break
        }
    }

    private func handleBeganPanState(_ sender: UIPanGestureRecognizer) {
        superview?.subviews.forEach { $0.layer.removeAllAnimations() }
    }

    private func handleChangedPanState(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: nil)
        let degrees: CGFloat = translation.x / 20
        let rotationAngle = degrees * .pi / 180
        let rotationTransform = CGAffineTransform(rotationAngle: rotationAngle)
        let translatedTransform = rotationTransform.translatedBy(x: translation.x, y: translation.y)
        transform = translatedTransform
    }

    private func handleEndedPanState(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: nil)
        let direction: CGFloat = translation.x > 0 ? 1 : -1
        let shouldDismissCard = abs(translation.x) > 80

        animateCard(animations: {
            if shouldDismissCard {
                self.frame = CGRect(
                    x: 1000 * direction,
                    y: 0,
                    width: self.frame.width,
                    height: self.frame.height
                )
            } else {
                self.transform = .identity
            }
        }, completion: { _ in
            self.transform = .identity

            if shouldDismissCard {
                self.removeFromSuperview()
            }
        })
    }

    private func handleCancelPanState(_ sender: UIPanGestureRecognizer) {
        animateCard(animations: {
            self.transform = .identity
        })
    }

    private func animateCard(animations: @escaping () -> Void,
                             completion: ((Bool) -> Void)? = nil) {
        UIView.animate(
            withDuration: 0.75,
            delay: 0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.5,
            options: .curveEaseOut,
            animations: animations,
            completion: completion)
    }
}

// MARK: - Constants

private extension CardView {
    enum Constants {
        static let deselectedBarColor = UIColor(white: 0, alpha: 0.1)
        static let selectedBarColor = UIColor.white
    }
}
