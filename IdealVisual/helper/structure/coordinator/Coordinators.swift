//
//  Coordinators.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 26.03.2022.
//

import Foundation

protocol CoordinatorDescription: AnyObject {
    var router: BaseRouterDescriprion { get set }
    var onFinish: () -> Void { get set }

    func start()
}

protocol CoordinatorsProtocol: AnyObject {
    func configureLaunchCoordinator(with router: BaseRouterDescriprion) -> CoordinatorDescription & LaunchDescription
    func configureAuthCoordinator(with router: BaseRouterDescriprion) -> CoordinatorDescription & AuthCoordinatorDescription
}

final class Coordinators: CoordinatorsProtocol {
    static let shared = Coordinators()

    func configureLaunchCoordinator(with router: BaseRouterDescriprion) -> CoordinatorDescription & LaunchDescription {
        LaunchCoordinator(router: router)
    }

    func configureAuthCoordinator(with router: BaseRouterDescriprion) -> CoordinatorDescription & AuthCoordinatorDescription {
        AuthCoordinator(router: router)
    }

    func configureFeedCoordinator(with router: BaseRouterDescriprion) -> CoordinatorDescription & FeedCoordinatorDescription {
        FeedCoordinator(with: router)
    }
}
