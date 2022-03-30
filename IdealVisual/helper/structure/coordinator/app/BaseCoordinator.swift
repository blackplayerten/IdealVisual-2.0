//
//  BaseCoordinator.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 26.03.2022.
//

class BaseCoordinator: BaseCoordinatorProtocol {
    var childCoordinators: [CoordinatorDescription] = []

    func addDependency(_ coordinator: CoordinatorDescription) {
        add(coordinator)
    }

    func removeDependency(_ coordinator: CoordinatorDescription?) {
        remove(coordinator)
    }

    private func add(_ coordinator: CoordinatorDescription) {
        childCoordinators.forEach { if $0 === coordinator { return } }
        childCoordinators.append(coordinator)
    }

    private func remove(_ coordinator: CoordinatorDescription?) {
        guard !childCoordinators.isEmpty, let coordinator = coordinator else { return }

        for (index, element) in childCoordinators.enumerated() {
            if element === coordinator {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}
