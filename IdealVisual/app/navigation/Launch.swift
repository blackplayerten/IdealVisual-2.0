//
//  Launch.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 28.03.2022.
//

import UIKit

extension LaunchCoordinator {

    func showWarning(with type: ConnectionWarningType) {
        configureWarning(with: type)
    }

    private func configureWarning(with type: ConnectionWarningType) {
        let launchViewController = AppViewControllers.shared.configureLaunch()
        launchViewController.setupWarningType(type: type)
        router.push(viewController: launchViewController)
    }
}
