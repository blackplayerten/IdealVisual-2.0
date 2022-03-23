//
//  TabBarController.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 27.11.2021.
//

import UIKit

final class TabBarController: UITabBarController, UITabBarControllerDelegate {
    //MARK: - view Controllers
    private lazy var feedViewController: FeedViewController = {
        let feedViewController = FeedViewController()
        let image = UIImage(named: "add_tabbar")?.withRenderingMode(.alwaysOriginal)
        feedViewController.tabBarItem = UITabBarItem(title: nil, image: image, tag: 0)
        feedViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        feedViewController.view.backgroundColor = AppTheme.shared.colorsComponents.background
        return feedViewController
    }()

    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    // MARK: - private func
    private func setup() {
        tabBar.isTranslucent = false
        tabBar.barTintColor = AppTheme.shared.colorsComponents.background
        tabBar.clipsToBounds = true
        setupViewControllers()
    }

    private func setupViewControllers() {
        viewControllers = [
            NavigationController(rootViewController: feedViewController)
        ]
    }
}
