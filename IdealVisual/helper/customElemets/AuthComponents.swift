//
//  AuthComponents.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 19.03.2022.
//

import UIKit

protocol AuthComponentsProtocol: AnyObject {
    func configureAuthComponents()
    func setupAuthComponents()
}

enum AuthButtons {
    case enter
    case unEnter
}

final class AuthComponents: AuthComponentsProtocol {
    // MARK: - constants
    struct UIConstants {
        static let spacingTop = 5.0
        static let enterButtonTop = 20.0
        static let enterButtonLeftRight = 60.0
        static let enterButtonHeight = 50.0
        static let unEnterStackViewHeight = 60.0
        static let unEnterStackViewLeftRight = 80.0
    }

    // MARK - ui elements
    let enterButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(AppTheme.shared.colorsComponents.titleText, for: .normal)
        button.titleLabel?.font = UIFont(name: UIFont.Names.system, size: UIFont.Sizes.large)
        button.backgroundColor = AppTheme.shared.colorsComponents.buttonBackground
        button.layer.cornerRadius = 15
        return button
    }()

    let havingAccountLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppTheme.shared.colorsComponents.secondaryText
        label.font = UIFont(name: UIFont.Names.system, size: UIFont.Sizes.small)
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    let unEnterButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(AppTheme.shared.colorsComponents.titleText, for: .normal)
        button.titleLabel?.font = UIFont(name: UIFont.Names.system, size: UIFont.Sizes.small)
        return button
    }()

    // MARK: - func
    func configure(for button: AuthButtons, title: String, target: Any, action: Selector) {
        switch button {
        case .enter:
            enterButton.setTitle(title, for: .normal)
            enterButton.addTarget(target, action: action, for: .touchUpInside)
        case .unEnter:
            unEnterButton.setTitle(title, for: .normal)
            unEnterButton.addTarget(target, action: action, for: .touchUpInside)
        }
    }

    func configureHavingAccountLabel(text: String) {
        havingAccountLabel.text = text
    }

    func configureAuthComponents() {}

    func setupAuthComponents() {}
}
