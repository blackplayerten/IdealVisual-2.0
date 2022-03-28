//
//  AppCoordinator.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 26.03.2022.
//

import Darwin

protocol AppCoordinatorProtocol: AnyObject { }

final class AppCoordinator: BaseCoordinator, CoordinatorDescription, AppCoordinatorProtocol {
    var router: BaseRouterDescriprion
    var onFinish: () -> Void = {}

    init(router: BaseRouterDescriprion) {
        self.router = router
    }

    func start() {
        checkOperationMode()
    }

    private func checkOperationMode() {
        let launchCoordinator = Coordinators.shared.configureLaunchCoordinator(with: router)
        launchCoordinator.onFinish = { [weak self, weak launchCoordinator] in
            guard let self = self,
                  let coordinator = launchCoordinator
            else { return }
            self.removeDependency(coordinator)
            self.start()
        }
        if !FeatureToggle.internetConnection {
            if FeatureToggle.offline {
                launchCoordinator.showWarning(with: .connection)
            } else {
                launchCoordinator.showWarning(with: .unavaliable)
                launchCoordinator.onFinish()
                self.router.closeApp()
            }
        }
        addDependency(launchCoordinator)
        launchCoordinator.start()
    }
}
