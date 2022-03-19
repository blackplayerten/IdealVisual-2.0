//
//  SignInViewController.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 27.11.2021.
//

import UIKit

final class SignInViewController: UIViewController {
    // MARK: - ui elements
    private let scroll = UIScrollView()
    private let contentView = UIView()

    private var director: SingleLineTypesFieldBuilderBoss
    private var emailField: SingleLineField?
    private var passwordField: SingleLineField?
    private var activeField: InputFieldBuilder?

    private let authComponents = AuthComponents()

    // MARK: - data
    private var viewModel: SignInViewModelProtocol? {
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
        viewModel = SignInViewModel()
        listenKeyboard()
        setupScroll()
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
        contentView.addSubview(authComponents.enterButton)
        authComponents.enterButton.snp.makeConstraints {
            $0.top.equalTo(passwordField.snp.bottom).offset(AuthComponents.UIConstants.enterButtonTop)
            $0.left.equalToSuperview().offset(AuthComponents.UIConstants.enterButtonLeftRight)
            $0.right.equalToSuperview().inset(AuthComponents.UIConstants.enterButtonLeftRight)
            $0.height.equalTo(AuthComponents.UIConstants.enterButtonHeight)
        }
    }

    private func setupSignUpStackView() {
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

    @objc
    private func showFeed() {
        let feed = FeedViewController()
        present(feed, animated: true)
    }
}

// MARK: - extension
extension SignInViewController: AuthComponentsProtocol {
    func configureAuthComponents() {
        authComponents.configure(for: .enter, title: AuthStrings.signin.localized,
                                target: self, action: #selector(login))
        authComponents.configure(for: .unEnter, title: AuthStrings.signup.localized,
                                target: self, action: #selector(self.showSignUp))
        authComponents.configureHavingAccountLabel(text: AuthStrings.haventAccount.localized)
    }

    func setupAuthComponents() {
        setupLoginButton()
        setupSignUpStackView()
    }
}

extension SignInViewController: InputFieldDelegate {
    func setActiveField(_ field: InputFieldBuilder) {
        activeField = field
    }
}

extension SignInViewController {
    // MARK: - keyboard
    @objc
    func keyboardWillShow(_ notification: Notification) {
        guard let info = notification.userInfo else { return }
        guard let rect: CGRect = info[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let keyboardSize = rect.size
        let visiblePartScreenWithoutKeyboard = scroll.bounds.height - keyboardSize.height
    
        let tr = scroll.convert(authComponents.havingAccountLabel.frame, to: nil)

        if tr.origin.y > visiblePartScreenWithoutKeyboard {
            let insets = UIEdgeInsets(top: 0, left: 0, bottom: authComponents.havingAccountLabel.frame.height, right: 0)
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
