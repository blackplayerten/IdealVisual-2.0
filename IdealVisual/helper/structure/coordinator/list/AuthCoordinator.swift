//
//  AuthCoordinator.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 26.03.2022.
//

protocol AuthCoordinatorDescription: AnyObject {
    var type: AuthViewControllerType? { get set }
}

final class AuthCoordinator: BaseCoordinator, CoordinatorDescription, AuthCoordinatorDescription {
    var router: BaseRouterDescriprion
    var onFinish: (() -> Void) = {}

    var type: AuthViewControllerType?

    init(router: BaseRouterDescriprion) {
        self.router = router
    }

    func start() {
        sign()
    }

    private func sign() {
        guard let type = type else { return }
        let authViewController = AppViewControllers.shared.configureAuth()
        authViewController.type = type
        router.push(viewController: authViewController)
    }
}
