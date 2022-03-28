//
//  LaunchCoordinator.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 28.03.2022.
//

import Foundation

protocol LaunchDescription: AnyObject {
    func showWarning(with type: ConnectionWarningType)
}

final class LaunchCoordinator: BaseCoordinator, CoordinatorDescription {
    var router: BaseRouterDescriprion
    var onFinish: () -> Void = {}

    init(router: BaseRouterDescriprion) {
        self.router = router
    }

    func start() {
        // check user defaults data
        configureUnAuthorizedZone()
    }

    private func configureAuthorizedZone() {
        let feedCoordinator = Coordinators.shared.configureFeedCoordinator(with: router)
        feedCoordinator.onFinish = { [weak self, weak feedCoordinator] in
            guard let self = self,
                  let coordinator = feedCoordinator
            else { return }
            self.removeDependency(coordinator)
            self.start()
        }
        addDependency(feedCoordinator)
        feedCoordinator.start()
    }

    private func configureUnAuthorizedZone() {
        let authCoordinator = Coordinators.shared.configureAuthCoordinator(with: router)
        authCoordinator.onFinish = { [weak self, weak authCoordinator] in
            guard let self = self,
                  let coordinator = authCoordinator
            else { return }
            self.removeDependency(coordinator)
            self.start()
        }
        addDependency(authCoordinator)
        authCoordinator.start()
    }
}
