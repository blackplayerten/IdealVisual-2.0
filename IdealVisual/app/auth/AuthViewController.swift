//
//  AuthViewController.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 10.03.2022.
//

import Foundation
import UIKit
import SnapKit

final class AuthViewController: UIViewController {
    // MARK: - constants
    private struct UIConstants {
        static let headerMarginTop = 10.0
        static let headerMarginLeft = 40.0
        static let headerHeight = 80.0
    }

    // MARK: - ui elements
    private let director = SingleLineFieldBuilderBoss()
    let mask = BackgroundMaskViewController(height: .large, cornerRadusMask: .large, positionCornerRadius: .top)
    private let type: AuthViewControllerType
    var headerView: UILabel = {
        let label = UILabel()
        label.textColor = AppTheme.shared.colorsComponents.titleText
        label.font = UIFont(name: UIFont.Names.system, size: UIFont.Sizes.large)
        return label
    }()

    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        applyTheme()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addMask()
        setupHeader()
        navigateAuthVC(type: type, from: self)
    }

    // MARK: func
    init(type: AuthViewControllerType) {
        self.type = type
        super.init(nibName: nil, bundle: .main)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - private func
    private func applyTheme() {
        let backgroundImage = UIImageView(image: UIImage(named: "background-feed")?.withRenderingMode(.alwaysOriginal))
        backgroundImage.contentMode = .scaleAspectFill
        view.insertSubview(backgroundImage, at: 0)
        view.backgroundColor = AppTheme.shared.colorsComponents.background
    }

    private func setupHeader() {
        mask.contentView.addSubview(headerView)
        headerView.snp.makeConstraints {
            $0.left.right.equalToSuperview().offset(UIConstants.headerMarginLeft)
            $0.top.equalToSuperview().offset(UIConstants.headerMarginTop)
            $0.height.equalTo(UIConstants.headerHeight)
        }
    }

    private func addMask() {
        mask.modalPresentationStyle = .overCurrentContext
        mask.makeRounded = true
        mask.addImage = true
        mask.setImage(image: UIImage(named: "mask_hello")!)
        present(mask, animated: false)
    }
}

// MARK: - extension
extension AuthViewController: AuthViewControllerDelegate {
    func updateHeader(type: AuthViewControllerType) {
        switch type {
        case .signIn:
            headerView.text = AuthStrings.signin.localized
        case .signUp:
            headerView.text = AuthStrings.signup.localized
        }
    }

    func navigateAuthVC(type: AuthViewControllerType, from vc: UIViewController) {
        var rootVC = vc
        switch type {
        case .signIn:
            rootVC = SignInViewController(director: director, delegate: self)
        case .signUp:
            rootVC = SignUpViewController(director: director, delegate: self)
        }
        rootVC.view.backgroundColor = AppTheme.shared.colorsComponents.background
        mask.contentView.addSubview(rootVC.view)
        rootVC.view.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
        mask.addChild(rootVC)
        rootVC.didMove(toParent: mask)
        updateHeader(type: type)
        guard let _ = vc as? AuthViewController else {
            removePrevChildFromParent(vc: vc)
            return
        }
        
    }

    private func removePrevChildFromParent(vc: UIViewController) {
        vc.view.removeFromSuperview()
        vc.removeFromParent()
    }
}
