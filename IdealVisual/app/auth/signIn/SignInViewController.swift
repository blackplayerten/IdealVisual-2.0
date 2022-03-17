//
//  SignInViewController.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 27.11.2021.
//

import Foundation
import UIKit

final class SignInViewController: UIViewController {
    // MARK: - constants
    private struct UIConstants {
        static let fieldTop = 5.0
        static let loginButtonTop = 20.0
        static let loginButtonLeftRight = 60.0
        static let loginButtonHeight = 50.0
        static let signUpStackViewHeight = 60.0
        static let signUpStackViewLeftRight = 80.0
    }

    // MARK: - ui elements
    private let scroll = UIScrollView()
    private let contentView = UIView()

    private var director: SingleLineTypesFieldBuilderBoss
    private var emailField: SingleLineField?
    private var passwordField: SingleLineField?
    private var activeField: InputFieldBuilder?

    private var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle(AuthStrings.signin.localized, for: .normal)
        button.setTitleColor(AppTheme.shared.colorsComponents.titleText, for: .normal)
        button.titleLabel?.font = UIFont(name: UIFont.Names.system, size: UIFont.Sizes.large)
        button.backgroundColor = AppTheme.shared.colorsComponents.buttonBackground
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        return button
    }()

    private var haventAccountLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppTheme.shared.colorsComponents.secondaryText
        label.font = UIFont(name: UIFont.Names.system, size: UIFont.Sizes.small)
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    private var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle(AuthStrings.signup.localized, for: .normal)
        button.setTitleColor(AppTheme.shared.colorsComponents.titleText, for: .normal)
        button.titleLabel?.font = UIFont(name: UIFont.Names.system, size: UIFont.Sizes.small)
        button.addTarget(self, action: #selector(showSignUp), for: .touchUpInside)
        return button
    }()

    // MARK: - data
    private var viewModel: SignInViewModelProtocol? {
        didSet {
           
        }
    }
    weak var delegate: AuthViewControllerDelegate?

    init(director: SingleLineTypesFieldBuilderBoss, delegate: AuthViewControllerDelegate) {
        self.director = director
        self.delegate = delegate
        super.init(nibName: nil, bundle: .main)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        setupScroll()
        configureFields(director: director)
        setupFields()
        setupLoginButton()
        setupSignUpStackView()
    }

    // MARK: - private func
    private func setupScroll() {
        view.addSubview(scroll)
        scroll.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        scroll.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
            $0.width.height.equalTo(view)
        }
        scroll.contentSize = contentView.frame.size
    }

    private func configureFields(director: SingleLineTypesFieldBuilderBoss) {
        let builder = SingleLineFieldBuilder(parentView: contentView)
        director.update(builder: builder, delegate: self)
        director.buildEmailField()
        emailField = builder.combineSingleField()
        builder.reset()
        director.buildPasswordField(repeat: false)
        passwordField = builder.combineSingleField()
        builder.reset()
    }

    private func setupFields() {
        guard let emailField = emailField,
              let passwordField = passwordField else {
            Logger.log("no field")
            return
        }
        [emailField, passwordField].forEach {
            contentView.addSubview($0)
            $0.snp.makeConstraints {
                $0.centerX.equalToSuperview()
            }
        }
        emailField.snp.makeConstraints {
            $0.top.equalToSuperview()
        }
        passwordField.snp.makeConstraints {
            $0.top.equalTo(emailField.snp.bottom)
        }
    }

    private func setupLoginButton() {
        guard let passwordField = passwordField else { return }
        contentView.addSubview(loginButton)
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordField.snp.bottom).offset(UIConstants.loginButtonTop)
            $0.left.equalToSuperview().offset(UIConstants.loginButtonLeftRight)
            $0.right.equalToSuperview().inset(UIConstants.loginButtonLeftRight)
            $0.height.equalTo(UIConstants.loginButtonHeight)
            $0.centerX.equalToSuperview()
        }
    }

    private func setupSignUpStackView() {
        let stackView = UIStackView(arrangedSubviews: [haventAccountLabel, signUpButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(UIConstants.fieldTop)
            $0.left.equalToSuperview().offset(UIConstants.signUpStackViewLeftRight)
            $0.right.equalToSuperview().inset(UIConstants.signUpStackViewLeftRight)
            $0.height.equalTo(UIConstants.signUpStackViewHeight)
        }
        haventAccountLabel.text = AuthStrings.haventAccount.localized
    }

    // MARK: - actions
    @objc
    private func login() {
        guard let viewModel = viewModel else { return Logger.log("no view model") }
        viewModel.login()
    }

    @objc
    private func showSignUp() {
        guard let delegate = delegate else {
            Logger.log("no auth delegate")
            return
        }
        delegate.navigateAuthVC(type: .signUp, from: self)
    }
}

// MARK: - extension
extension SignInViewController: InputFieldDelegate {
    func setActiveField(_ field: InputFieldBuilder) {
        activeField = field
    }
}

extension SignInViewController {
    // MARK: - keyboard
    @objc
    func keyboardWillShow(_ notification: Notification) {
        let info = notification.userInfo!
        guard let rect: CGRect = info[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let keyboardSize = rect.size
        let visiblePartScreenWithoutKeyboard = scroll.bounds.height - keyboardSize.height
    
        let tr = scroll.convert(haventAccountLabel.frame, to: nil)

        if tr.origin.y > visiblePartScreenWithoutKeyboard {
            let insets = UIEdgeInsets(top: 0, left: 0, bottom: haventAccountLabel.frame.height, right: 0)
            scroll.contentInset = insets
            scroll.scrollIndicatorInsets = insets
        }
    }

    @objc
    func keyboardWillHide(_ notification: Notification) {
        scroll.contentInset = .zero
        scroll.scrollIndicatorInsets = .zero
    }
}
