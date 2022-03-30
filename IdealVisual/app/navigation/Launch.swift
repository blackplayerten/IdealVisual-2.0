//
//  Launch.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 28.03.2022.
//

import UIKit

extension LaunchCoordinator: LaunchDescription {
    func configureWarning(with type: ConnectionWarningType) {
        initWarning(with: type)
    }

    private func initWarning(with type: ConnectionWarningType) {
        let launchViewController = AppViewControllers.shared.configureLaunch()
        launchViewController.warningType = type
        router.push(viewController: launchViewController)
    }
}
