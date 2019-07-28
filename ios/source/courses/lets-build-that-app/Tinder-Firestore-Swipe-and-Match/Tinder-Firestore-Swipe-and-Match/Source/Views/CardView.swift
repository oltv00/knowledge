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

        func handleChanged() {
            let translation = sender.translation(in: nil)
            transform = CGAffineTransform(
                translationX: translation.x,
                y: translation.y
            )
        }

        func handleEnded() {
            UIView.animate(
                withDuration: 0.75,
                delay: 0,
                usingSpringWithDamping: 0.5,
                initialSpringVelocity: 0.5,
                options: .curveEaseOut,
                animations: { self.transform = .identity })
        }

        switch sender.state {
        case .changed: handleChanged()
        case .ended: handleEnded()
        default: break
        }
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
