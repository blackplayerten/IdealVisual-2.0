//
//  SingleLineFieldBuilder.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 20.12.2021.
//

import UIKit

protocol SingleLineTypesFieldBuilderBoss: AnyObject {
    func update(builder: SingleLineFieldBuilder, delegate: InputFieldDelegate)
    func buildEmailField()
    func buildPasswordField(repeat repeatPassword: Bool)
}

final class SingleLineFieldBuilderBoss: SingleLineTypesFieldBuilderBoss {
    private var builder: SingleLineFieldBuilder?
    private var delegate: InputFieldDelegate?

    func update(builder: SingleLineFieldBuilder, delegate: InputFieldDelegate) {
        self.builder = builder
        self.delegate = delegate
    }

    func buildEmailField() {
        guard let builder = builder else { Logger.log("no builder for email field"); return }
        builder.configure()

        switch AppTheme.shared.mode {
        case .light:
            if let image = UIImage(named: "email_light") {
                builder.configureIcon(image: image.withRenderingMode(.alwaysOriginal))
            }
        case .dark:
            if let image = UIImage(named: "email_dark") {
                builder.configureIcon(image: image.withRenderingMode(.alwaysOriginal))
            }
        }
        builder.configureInput(placeholder: AuthStrings.email.localized)
        builder.setInputMode(withContentType: .emailAddress, withKeyboardType: .emailAddress)
        builder.configureCountSymbolsLabel()
        builder.configureBottomObject()
        builder.setDelegate(_with: &delegate)
    }

    func buildPasswordField(repeat repeatPassword: Bool) {
        guard let builder = builder else { Logger.log("no builder for email field"); return }
        builder.configure()

        switch AppTheme.shared.mode {
        case .light:
            if let image = UIImage(named: "password_light") {
                builder.configureIcon(image: image.withRenderingMode(.alwaysOriginal))
            }
        case .dark:
            if let image = UIImage(named: "password_dark") {
                builder.configureIcon(image: image.withRenderingMode(.alwaysOriginal))
            }
        }
        var placeholder: String
        repeatPassword ? (placeholder = AuthStrings.repeatPassword.localized) :
                         (placeholder = AuthStrings.password.localized)
        builder.configureInput(placeholder: placeholder)
        repeatPassword ? (builder.setInputMode(withContentType: .newPassword, withKeyboardType: .default)) :
                         (builder.setInputMode(withContentType: .password, withKeyboardType: .default))
        builder.configureCountSymbolsLabel()
        builder.configureBottomObject()
        builder.setDelegate(_with: &delegate)
    }
}

final class SingleLineFieldBuilder: InputFieldBuilder {
    var frameInput: CGRect
    
    private var singleField: SingleLineField

    init(parentView: UIView) {
        singleField = SingleLineField(superView: parentView)
        frameInput = singleField.frame
    }

    func configure() {
        singleField.configure()
    }

    func configureIcon(image: UIImage) {
        singleField.configureIcon(image: image)
    }

    func configureInput(placeholder: String) {
        singleField.configureInput(placeholder: placeholder)
    }

    func setInputMode(withContentType contentType: UITextContentType, withKeyboardType keyboardType: UIKeyboardType) {
        singleField.setSecutityField(withContentType: contentType, withKeyboardType: keyboardType)
    }

    func configureCountSymbolsLabel() {
        singleField.configureCountSymbolsLabel()
    }

    func configureBottomObject() {
        singleField.configureBottomObject()
    }

    func setDelegate<T>(_with delegate: inout T) {
        singleField.setDelegate(_with: &delegate)
    }

    func reset() {
        singleField = SingleLineField(superView: .init())
    }

    func combineSingleField() -> SingleLineField {
        singleField
    }
}
