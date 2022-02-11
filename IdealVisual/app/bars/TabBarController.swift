//
//  TabBarController.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 27.11.2021.
//

import Foundation
import UIKit

final class TabBarController: UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        tabBar.isTranslucent = false
        tabBar.barTintColor = AppTheme.shared.colorsComponents.background
        tabBar.clipsToBounds = true
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        let feedViewController = FeedViewController()

        let image = UIImage(named: "add_tabbar")?.withRenderingMode(.alwaysOriginal)
        feedViewController.tabBarItem = UITabBarItem(title: nil, image: image, tag: 0)
        feedViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)

        viewControllers = [
            NavigationController(rootViewController: feedViewController)
        ]
    }
}
