//
//  NavigationController.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 02.02.2022.
//

import Foundation
import UIKit

final class NavigationController: UINavigationController {
    func applyTheme() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = AppTheme.shared.colorsComponents.background
    }
}
