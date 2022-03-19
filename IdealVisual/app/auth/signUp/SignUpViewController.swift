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
    private let avatarView = AvatarViewController(image: .init(named: "camera")!)

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
        listenKeyboard()
        setupScroll()
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

    private func setupAvatarView() {
        contentView.addSubview(avatarView.view)
        avatarView.view.snp.makeConstraints {
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
        guard let emailField = emailField,
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
            $0.top.equalTo(avatarView.view.snp.bottom)
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
        contentView.addSubview(enterButton)
        enterButton.snp.makeConstraints {
            $0.top.equalTo(repeatPasswordField.snp.bottom).offset(AuthComponents.UIConstants.enterButtonTop)
            $0.left.equalToSuperview().offset(AuthComponents.UIConstants.enterButtonLeftRight)
            $0.right.equalToSuperview().inset(AuthComponents.UIConstants.enterButtonLeftRight)
            $0.height.equalTo(AuthComponents.UIConstants.enterButtonHeight)
        }
    }

    private func setupSignInStackView() {
        let stackView = UIStackView(arrangedSubviews: [havingAccountLabel, unEnterButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalTo(enterButton.snp.bottom).offset(AuthComponents.UIConstants.spacingTop)
            $0.left.equalToSuperview().offset(AuthComponents.UIConstants.unEnterStackViewLeftRight)
            $0.right.equalToSuperview().inset(AuthComponents.UIConstants.unEnterStackViewLeftRight)
            $0.height.equalTo(AuthComponents.UIConstants.unEnterStackViewHeight)
        }
    }

    private func bind() {
        guard let viewModel = viewModel else { return Logger.log("no view model") }
        viewModel.bind = { self.showFeed() }
    }

    @objc
    private func signUp() {
        guard let viewModel = viewModel else { return Logger.log("no view model") }
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
    var enterButton: UIButton { authComponents.enterButton }
    var unEnterButton: UIButton { authComponents.unEnterButton }
    var havingAccountLabel: UILabel { authComponents.havingAccountLabel }

    func configureAuthComponents() {
        authComponents.configure(for: .enter, title: AuthStrings.signup.localized,
                                target: self, action: #selector(signUp))
        authComponents.configure(for: .unEnter, title: AuthStrings.signin.localized,
                                target: self, action: #selector(showSignIn))
        authComponents.configureHavingAccountLabel(text: AuthStrings.haventAccount.localized)
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
        let info = notification.userInfo!
        guard let rect: CGRect = info[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let keyboardSize = rect.size
        let visiblePartScreenWithoutKeyboard = scroll.bounds.height - keyboardSize.height
    
        let tr = scroll.convert(enterButton.frame, to: nil)

        if tr.origin.y > visiblePartScreenWithoutKeyboard {
            guard let repeatPassword = repeatPasswordField else { return }
            let bottom = enterButton.frame.height * 2 + havingAccountLabel.frame.height + repeatPassword.frame.height +
            AuthComponents.UIConstants.spacingTop * 2
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
