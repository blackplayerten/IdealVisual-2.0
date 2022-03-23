//
//  NavigationController.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 02.02.2022.
//

import UIKit

final class NavigationController: UINavigationController {
    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        applyTheme()
    }

    // MARK: - func
    func applyTheme() {
        navigationBar.isTranslucent = false
        navigationBar.tintColor = AppTheme.shared.colorsComponents.background
    }
}
