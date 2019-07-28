import UIKit

final class CardView: UIView {

    // MARK: - Public properties

    var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
        }
    }

    var attributedInformation: NSAttributedString? {
        get {
            return informationLabel.attributedText
        }
        set {
            informationLabel.attributedText = newValue
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

    // MARK: - Gestures

    private lazy var panGesture: UIPanGestureRecognizer = {
        let gesture = UIPanGestureRecognizer(
            target: self,
            action: #selector(panGestureHandler(_:))
        )
        return gesture
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
        addGestureRecognizer(panGesture)

        [
            imageView,
            informationLabel,
        ].forEach(addSubview)

        imageView.fillSuperview()
        informationLabel.anchor(
            top: nil,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            padding: .init(top: 0, left: 16, bottom: 16, right: 16)
        )
    }

    // MARK: - Laying out Subviews

    override func layoutSubviews() {
        super.layoutSubviews()
        setupCornerRadius()
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

    @objc func panGestureHandler(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .changed: handleChangedPanState(sender)
        case .ended: handleEndedPanState(sender)
        case .cancelled: handleCancelPanState(sender)
        default: break
        }
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
