//
//  CoordinatorDescription.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 30.03.2022.
//

import Foundation

protocol CoordinatorDescription: AnyObject {
    var router: BaseRouterDescriprion { get set }
    var onFinish: () -> Void { get set }

    func start()
}
