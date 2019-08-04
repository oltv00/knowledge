import UIKit

final class RegistrationController: UIViewController {

    // MARK: - UI properties

    private lazy var contentStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 8
        return view
    }()

    private lazy var selectPhotoButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Select Photo", for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 34, weight: .heavy)
        view.backgroundColor = .white
        view.setTitleColor(.black, for: .normal)
        view.heightAnchor.constraint(equalToConstant: 275).isActive = true
        view.layer.cornerRadius = 16
        return view
    }()

    private lazy var fullNameTextField: RegistrationTextField = {
        let view = RegistrationTextField(
            padding: Constants.registrationTextFieldPadding
        )
        view.placeholder = "Enter full name"
        view.backgroundColor = .white
        return view
    }()

    private lazy var emailTextField: RegistrationTextField = {
        let view = RegistrationTextField(
            padding: Constants.registrationTextFieldPadding
        )
        view.placeholder = "Enter email"
        view.keyboardType = .emailAddress
        view.backgroundColor = .white
        return view
    }()

    private lazy var passwordTextField: RegistrationTextField = {
        let view = RegistrationTextField(
            padding: Constants.registrationTextFieldPadding
        )
        view.placeholder = "Enter password"
        view.isSecureTextEntry = true
        view.backgroundColor = .white
        return view
    }()

    // MARK: Layers

    private lazy var gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [
            Constants.Colors.topGradient.cgColor,
            Constants.Colors.bottomGradient.cgColor,
        ]
        layer.locations = [0, 1]
        return layer
    }()

    // MARK: - Managing the View

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = view.bounds
    }

    // MARK: - Setup view

    private func setupView() {
        setupGradientLayer()
        setupContentStackView()
    }

    private func setupContentStackView() {
        [
            selectPhotoButton,
            fullNameTextField,
            emailTextField,
            passwordTextField,
        ].forEach(contentStackView.addArrangedSubview)

        view.addSubview(contentStackView)
        contentStackView.anchor(
            top: nil,
            leading: view.leadingAnchor,
            bottom: nil,
            trailing: view.trailingAnchor,
            padding: .init(top: 0, left: 48, bottom: 0, right: 48)
        )
        contentStackView.centerYAnchor
            .constraint(equalTo: view.centerYAnchor).isActive = true
    }

    private func setupGradientLayer() {
        view.layer.addSublayer(gradientLayer)
    }

    // MARK: - Constants

    private enum Constants {
        static let registrationTextFieldPadding: CGFloat = 16

        enum Colors {
            static let topGradient = UIColor(red: 250 / 255, green: 87 / 255, blue: 83 / 255, alpha: 1)
            static let bottomGradient = UIColor(red: 220 / 255, green: 27 / 255, blue: 104 / 255, alpha: 1)
        }
    }
}
