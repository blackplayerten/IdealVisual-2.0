//
//  ListCoordinatorDescription.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 30.03.2022.
//

import Foundation

protocol ListCoordinatoorDescription: AnyObject {
    func configureLaunchCoordinator(with router: BaseRouterDescriprion) -> CoordinatorDescription & LaunchDescription
    func configureAuthCoordinator(with router: BaseRouterDescriprion) -> CoordinatorDescription & AuthCoordinatorDescription
}

protocol AuthCoordinatorDescription: AnyObject {
    var type: AuthViewControllerType? { get set }
}

protocol FeedCoordinatorDescription: AnyObject {
    
}

protocol LaunchDescription: AnyObject {
    func configureWarning(with type: ConnectionWarningType)
}
