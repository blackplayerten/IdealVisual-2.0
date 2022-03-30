//
//  Coordinators.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 26.03.2022.
//

import Foundation

final class ListCoordinator: ListCoordinatoorDescription {
    static let shared = ListCoordinator()

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
