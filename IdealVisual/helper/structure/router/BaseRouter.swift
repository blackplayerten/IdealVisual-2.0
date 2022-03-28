//
//  BaseRouter.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 26.03.2022.
//

import UIKit

final class BaseRouter: BaseRouterDescriprion {
    var navigationController: NavigationController

    init(navigationController: NavigationController) {
        self.navigationController = navigationController
    }

    func push(viewController: Presentable) {
        navigationController.pushViewController(viewController.present, animated: true)
    }

    func addChild(viewController: Presentable, for parent: Presentable) {
        let rootViewController = viewController.present
        rootViewController.view.backgroundColor = AppTheme.shared.colorsComponents.background
        parent.present.view.addSubview(rootViewController.view)
        rootViewController.view.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
        parent.present.addChild(rootViewController)
        rootViewController.didMove(toParent: parent.present)
    }

    func removeChild(viewController: Presentable) {
        viewController.present.view.removeFromSuperview()
        viewController.present.removeFromParent()
    }

    func closeApp() {
        exit(-1)
    }
}
