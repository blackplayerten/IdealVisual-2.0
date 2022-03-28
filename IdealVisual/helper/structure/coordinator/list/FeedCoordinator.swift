//
//  FeedCoordinator.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 26.03.2022.
//

import Foundation

protocol FeedCoordinatorDescription: AnyObject {
    
}

final class FeedCoordinator: CoordinatorDescription, FeedCoordinatorDescription {
    var router: BaseRouterDescriprion

    var onFinish: () -> Void = {}

    init(with router: BaseRouterDescriprion) {
        self.router = router
    }

    func start() {
        
    }
}
