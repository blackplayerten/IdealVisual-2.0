//
//  TabBarController.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 27.11.2021.
//

import UIKit

final class TabBarController: UITabBarController {
    let TabBarItems: [UITabBarItem] = [
        UITabBarItem(title: nil, image: UIImage(named: "ideas")?.withRenderingMode(.alwaysOriginal), tag: 0),
        UITabBarItem(title: nil, image: UIImage(named: "add_post")?.withRenderingMode(.alwaysOriginal), tag: 1)
    ]
    //MARK: - view Controllers
    private lazy var feedViewController: FeedViewController = {
        let feedViewController = FeedViewController()
        feedViewController.tabBarItem = TabBarItems[0]
        feedViewController.tabBarItem = TabBarItems[1]
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
        tabBar.backgroundColor = AppTheme.shared.colorsComponents.background
        tabBar.itemPositioning = .centered
        setupViewControllers()
    }

    private func setupViewControllers() {
        viewControllers = [
            NavigationController(rootViewController: feedViewController)
        ]
    }
}

extension TabBarController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 0:
            break
        case 1:
            feedViewController.addPost()
        default:
            break
        }
    }
}
