//
//  AppViewControllers.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 28.03.2022.
//

import Foundation
import UIKit

protocol Presentable: AnyObject {
    var present: UIViewController { get set }
}

protocol AppViewControllersDescription: AnyObject {
    func configureLaunch() -> Presentable & LaunchViewInput
    func configureAuth() -> Presentable & AuthViewInput
}

final class AppViewControllers: AppViewControllersDescription {
    static let shared = AppViewControllers()

    func configureLaunch() -> Presentable & LaunchViewInput {
        let viewModel = LaunchViewModel()
        return LaunchViewController(viewModel: viewModel)
    }

    func configureAuth() -> Presentable & AuthViewInput {
        let director = SingleLineFieldBuilderBoss()
        return AuthViewController(director: director)
    }
}
