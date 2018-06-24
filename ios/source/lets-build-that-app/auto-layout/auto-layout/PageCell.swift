import UIKit

class PageCell: UICollectionViewCell {

    // MARK: - Public
    var page: Page? {
        didSet {
            guard let page = page else { return }
            imageView.image = UIImage(named: page.imageName)

            let headerText = page.headerText
            let headerAttributes = [
                NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 18),
            ]
            let attributedText = NSMutableAttributedString(string: headerText,
                                                           attributes: headerAttributes)
            let bodyText = "\n\n\n" + page.bodyText
            let bodyAttributes = [
                NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13),
                NSAttributedStringKey.foregroundColor: UIColor.gray,
            ]
            let bodyAttributedString = NSMutableAttributedString(string: bodyText,
                                                                 attributes: bodyAttributes)
            attributedText.append(bodyAttributedString)
            descriptionTextView.attributedText = attributedText
            descriptionTextView.textAlignment = .center
        }
    }

    // MARK: - Private
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "bear_first"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false

        let headerText = "Join us today in our fun and games!"
        let headerAttributes = [
            NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 18),
        ]

        let attributedText = NSMutableAttributedString(string: headerText,
                                                       attributes: headerAttributes)

        let bodyText = "\n\n\nAre you ready for loads and loads of fun? Don't wait any longer! We hope to see you in our stores soon."
        let bodyAttributes = [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13),
            NSAttributedStringKey.foregroundColor: UIColor.gray,
        ]
        let bodyAttributedString = NSMutableAttributedString(string: bodyText,
                                                             attributes: bodyAttributes)

        attributedText.append(bodyAttributedString)
        textView.attributedText = attributedText

        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()

    private let topImageContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Initializers
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
        setupConstraints()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }

    // MARK: - Managing view
    private func setupView() {
        [
            descriptionTextView,
            topImageContainerView,
//            bottomControlsStackView,
        ].forEach(addSubview)

        [
            imageView,
        ].forEach(topImageContainerView.addSubview)

//        [
//            previousButton,
//            pageControl,
//            nextButton,
//        ].forEach(bottomControlsStackView.addArrangedSubview)
    }

    private func setupConstraints() {
        let constraints = [
            topImageContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            topImageContainerView.topAnchor.constraint(equalTo: topAnchor),
            topImageContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topImageContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),

            imageView.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor),
            imageView.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 0.5),

            descriptionTextView.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor),
            descriptionTextView.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            descriptionTextView.rightAnchor.constraint(equalTo: rightAnchor, constant: -24),
            descriptionTextView.bottomAnchor.constraint(equalTo: bottomAnchor),

//            bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50),
//            bottomControlsStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
//            bottomControlsStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
//            bottomControlsStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

// MARK: - ReusableCell
extension PageCell: Identifier {
    private(set) static var identifier: String = "PageCellIdentifier"
}
