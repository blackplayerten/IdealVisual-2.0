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
        static let headerMarginTop = 10.0
        static let headerMarginLeft = 40.0
        static let headerHeight = 80.0
        static let loginButtonTop = 20.0
    }

    // MARK: - ui elements
    private var maskView = UIView()
    private var headerView: UILabel = {
        let label = UILabel()
        label.text = AuthStrings.signin.localized
        label.font = UIFont(name: UIFont.Names.system, size: UIFont.Sizes.large)
        return label
    }()

    private var director: SingleLineTypesFieldBuilderBoss
    private var emailField: SingleLineField?
    private var passwordField: SingleLineField?
    private var activeField: InputFieldBuilder?

    private var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle(AuthStrings.signin.localized, for: .normal)
        button.titleLabel?.font = UIFont(name: UIFont.Names.system, size: UIFont.Sizes.large)
        button.backgroundColor = AppTheme.shared.colorsComponents.saveButtonBackground
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        return button
    }()

    // MARK: - data
    private var viewModel: SignInViewModelProtocol? {
        didSet {
           
        }
    }

    init(director: SingleLineTypesFieldBuilderBoss) {
        self.director = director
        super.init(nibName: nil, bundle: .main)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        applyTheme()
        configureFields(director: director)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addMask()
        setupHeader()
        setupFields()
        setupLoginButton()
    }

    // MARK: func

    // MARK: - private func
    private func applyTheme() {
        let backgroundImage = UIImageView(image: UIImage(named: "background-feed")?.withRenderingMode(.alwaysOriginal))
        backgroundImage.contentMode = .scaleAspectFill
        view.insertSubview(backgroundImage, at: 0)
        view.backgroundColor = AppTheme.shared.colorsComponents.background
    }

    private func configureFields(director: SingleLineTypesFieldBuilderBoss) {
        let builder = SingleLineFieldBuilder(parentView: maskView)
        director.update(builder: builder, delegate: self)
        director.buildEmailField()
        emailField = builder.combineSingleField()
        builder.reset()
        director.buildPasswordField(repeat: false)
        passwordField = builder.combineSingleField()
        builder.reset()
    }

    private func addMask() {
        let mask = BackgroundMaskViewController(height: .large, cornerRadusMask: .large, positionCornerRadius: .top)
        mask.modalPresentationStyle = .overCurrentContext
        mask.makeRounded = true
        mask.addImage = true
        maskView = mask.backgroundMaskView
        present(mask, animated: false)
    }

    private func setupHeader() {
        maskView.addSubview(headerView)
        headerView.snp.makeConstraints {
            $0.left.right.equalToSuperview().offset(UIConstants.headerMarginLeft)
            $0.top.equalToSuperview().offset(UIConstants.headerMarginTop)
            $0.height.equalTo(UIConstants.headerHeight)
        }
    }

    private func setupFields() {
        guard let emailField = emailField,
              let passwordField = passwordField else {
            Logger.log("no field")
            return
        }
        [emailField, passwordField].forEach {
            maskView.addSubview($0)
            $0.snp.makeConstraints {
                $0.centerX.equalToSuperview()
            }
        }
        emailField.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
        }
        passwordField.snp.makeConstraints {
            $0.top.equalTo(emailField.snp.bottom)
        }
    }

    private func setupLoginButton() {
        guard let passwordField = passwordField else { return }
        maskView.addSubview(loginButton)
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordField.snp.bottom).offset(UIConstants.loginButtonTop)
            $0.left.equalToSuperview().offset(UIConstants.headerMarginLeft)
            $0.left.equalToSuperview().inset(UIConstants.headerMarginLeft)
            $0.centerX.equalToSuperview()
        }
    }

    @objc
    private func login() {
        guard let viewModel = viewModel else { return Logger.log("no view model") }
        viewModel.login()
    }
}

// MARK: - extension
extension SignInViewController: InputFieldDelegate {
    func setActiveField(_ field: InputFieldBuilder) {
        activeField = field
    }
}
