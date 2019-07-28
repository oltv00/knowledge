import UIKit

final class CardView: UIView {

    // MARK: - UI properties

    private lazy var imageView = UIImageView()

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
        setupImageView()
        setupPanGesture()
    }

    private func setupImageView() {
        addSubview(imageView)
        imageView.fillSuperview()
        imageView.image = .colored(.green)
    }

    private func setupPanGesture() {
        addGestureRecognizer(panGesture)
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
        case .changed: handlePanStateChanged(sender)
        case .ended: handlePanStateEnded(sender)
        default: break
        }
    }

    private func handlePanStateChanged(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: nil)
        let degrees: CGFloat = translation.x / 20
        let rotationAngle = degrees * .pi / 180
        let rotationTransform = CGAffineTransform(rotationAngle: rotationAngle)
        let translatedTransform = rotationTransform.translatedBy(x: translation.x, y: translation.y)
        transform = translatedTransform
    }

    private func handlePanStateEnded(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: nil)
        let direction: CGFloat = translation.x > 0 ? 1000 : -1000
        let shouldDismissCard = abs(translation.x) > 80

        UIView.animate(
            withDuration: 0.75,
            delay: 0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.5,
            options: .curveEaseOut,
            animations: {

                if shouldDismissCard {
                    self.frame = CGRect(
                        x: direction,
                        y: 0,
                        width: self.frame.width,
                        height: self.frame.height
                    )
                } else {
                    self.transform = .identity
                }
            },
            completion: { _ in

                self.transform = .identity
                self.frame = CGRect(
                    x: 0,
                    y: 0,
                    width: self.superview!.frame.width,
                    height: self.superview!.frame.height
                )
            })
    }
}

// TODO: Delete if unused
extension UIImage {
    fileprivate static func colored(_ color: UIColor) -> UIImage {

        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else {
            assertionFailure("Can't get graphic context")
            return UIImage()
        }

        context.setFillColor(color.cgColor)
        context.fill(rect)

        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            assertionFailure("Can't get image from context")
            return UIImage()
        }

        return image
    }
}
