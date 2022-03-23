//
//  SignUpViewController.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 27.11.2021.
//

import UIKit

final class SignUpViewController: UIViewController {
    // MARK: - ui constants
    private struct UIConstants {
        static let avatarViewSize: CGSize = .init(width: 100.0, height: 100.0)
    }

    // MARK: - ui elements
    private let scroll = UIScrollView()
    private let contentView = UIView()
    private var avatar: AvatarViewController?

    private var director: SingleLineTypesFieldBuilderBoss
    private var emailField: SingleLineField?
    private var passwordField: SingleLineField?
    private var repeatPasswordField: SingleLineField?
    private var activeField: InputFieldBuilder?

    private let authComponents = AuthComponents()

    // MARK: - data
    private var viewModel: SignUpViewModelProtocol? {
        didSet {
            bind()
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
        viewModel = SignUpViewModel()
        listenKeyboard()
        setupScroll()
        configureAvatar()
        setupAvatarView()
        configureFields(director: director)
        setupFields()
        configureAuthComponents()
        setupAuthComponents()
    }

    // MARK: - private func
    private func listenKeyboard() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

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

    private func configureAvatar() {
        var image: UIImage
        switch AppTheme.shared.mode {
        case .light:
            image = UIImage(named: "camera_light")!
        case .dark:
            image = UIImage(named: "camera_dark")!
        }
        avatar = AvatarViewController(image: image)
    }

    private func setupAvatarView() {
        guard let avatar = avatar else {
            return
        }
        contentView.addSubview(avatar.view)
        avatar.view.snp.makeConstraints {
            $0.top.centerX.equalToSuperview()
            $0.size.equalTo(UIConstants.avatarViewSize)
        }
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
        director.buildPasswordField(repeat: true)
        repeatPasswordField = builder.combineSingleField()
        builder.reset()
    }

    private func setupFields() {
        guard let avatar = avatar,
              let emailField = emailField,
              let passwordField = passwordField,
              let repeatPasswordField = repeatPasswordField
        else {
            Logger.log("no field")
            return
        }
        [emailField, passwordField, repeatPasswordField].forEach {
            contentView.addSubview($0)
            $0.snp.makeConstraints {
                $0.centerX.equalToSuperview()
            }
        }
        emailField.snp.makeConstraints {
            $0.top.equalTo(avatar.view.snp.bottom)
        }
        passwordField.snp.makeConstraints {
            $0.top.equalTo(emailField.snp.bottom)
        }
        repeatPasswordField.snp.makeConstraints {
            $0.top.equalTo(passwordField.snp.bottom)
        }
    }

    private func setupSignUpButton() {
        guard let repeatPasswordField = repeatPasswordField else { return }
        contentView.addSubview(authComponents.enterButton)
        authComponents.enterButton.snp.makeConstraints {
            $0.top.equalTo(repeatPasswordField.snp.bottom).offset(AuthComponents.UIConstants.enterButtonTop)
            $0.left.equalToSuperview().offset(AuthComponents.UIConstants.enterButtonLeftRight)
            $0.right.equalToSuperview().inset(AuthComponents.UIConstants.enterButtonLeftRight)
            $0.height.equalTo(AuthComponents.UIConstants.enterButtonHeight)
        }
    }

    private func setupSignInStackView() {
        let stackView = UIStackView(arrangedSubviews: [authComponents.havingAccountLabel, authComponents.unEnterButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalTo(authComponents.enterButton.snp.bottom).offset(AuthComponents.UIConstants.spacingTop)
            $0.left.equalToSuperview().offset(AuthComponents.UIConstants.unEnterStackViewLeftRight)
            $0.right.equalToSuperview().inset(AuthComponents.UIConstants.unEnterStackViewLeftRight)
            $0.height.equalTo(AuthComponents.UIConstants.unEnterStackViewHeight)
        }
    }

    private func bind() {
        guard let viewModel = viewModel else { return Logger.log("no view model") }
        viewModel.bind = { self.showFeed() }
    }

    // MARK: - actions 
    @objc
    private func validateInputData() {
        guard let viewModel = viewModel,
              let emailField = emailField,
              let passwordField = passwordField,
              let repeatPasswordField = repeatPasswordField
        else { return Logger.log("no view model") }

        if let validateState = viewModel.validateEmail(for: emailField) {
            switch validateState {
            case .empty:
                emailField.setError(text: WrongAuthStrings.emailEmpty.localized)
            case .wrongFormat:
                emailField.setError(text: WrongAuthStrings.emailFormat.localized)
            }
        } else {
            emailField.hideError()
        }

        if let validateState = viewModel.validatePassword(for: passwordField) {
            switch validateState {
            case .empty:
                passwordField.setError(text: WrongAuthStrings.passwordEmpty.localized)
            case .wrongFormat, .invalidPair:
                passwordField.setError(text: WrongAuthStrings.passwordLength.localized)
            }
        } else {
            passwordField.hideError()
        }

        if let validateState = viewModel.validatePasswordPair(for: passwordField, field2: repeatPasswordField) {
            switch validateState {
            case .invalidPair:
                return passwordField.setError(text: WrongAuthStrings.passwordPair.localized)
            case .empty, .wrongFormat:
                return
            }
        } else {
            passwordField.hideError()
        }

        viewModel.signup()
    }

    @objc
    private func showSignIn() {
        guard let delegate = delegate else {
            Logger.log("no auth delegate")
            return
        }
        delegate.navigateAuthVC(type: .signIn, from: self)
    }

    @objc
    private func showFeed() {
        let feed = FeedViewController()
        present(feed, animated: true)
    }
}

// MARK: - extension
extension SignUpViewController: AuthComponentsProtocol {
    func configureAuthComponents() {
        authComponents.configure(for: .enter, title: AuthStrings.signup.localized,
                                target: self, action: #selector(validateInputData))
        authComponents.configure(for: .unEnter, title: AuthStrings.signin.localized,
                                target: self, action: #selector(showSignIn))
        authComponents.configureHavingAccountLabel(text: AuthStrings.haveAccount.localized)
    }
    
    func setupAuthComponents() {
        setupSignUpButton()
        setupSignInStackView()
    }
}

extension SignUpViewController: InputFieldDelegate {
    func setActiveField(_ field: InputFieldBuilder) {
        self.activeField = field
    }
}

extension SignUpViewController {
    // MARK: - keyboard
    @objc
    func keyboardWillShow(_ notification: Notification) {
        guard let info = notification.userInfo else { return }
        guard let rect: CGRect = info[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let keyboardSize = rect.size
        let visiblePartScreenWithoutKeyboard = scroll.bounds.height - keyboardSize.height
    
        let tr = scroll.convert(authComponents.enterButton.frame, to: nil)

        if tr.origin.y > visiblePartScreenWithoutKeyboard {
            guard let repeatPassword = repeatPasswordField else { return }
            let bottom = authComponents.enterButton.frame.height * 2 + authComponents.havingAccountLabel.frame.height +
            repeatPassword.frame.height + AuthComponents.UIConstants.spacingTop * 2
            let insets = UIEdgeInsets(top: 0, left: 0, bottom: bottom, right: 0)
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
