//
//  BaseCoordinatorDescription.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 30.03.2022.
//

protocol BaseCoordinatorProtocol: AnyObject {
    var childCoordinators: [CoordinatorDescription] { get set }

    func addDependency(_ coordinator: CoordinatorDescription)
    func removeDependency(_ coordinator: CoordinatorDescription?)
}
