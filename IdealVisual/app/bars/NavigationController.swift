//
//  NavigationController.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 27.11.2021.
//

import Foundation
import UIKit

final class DarkFontNavigationController: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    override var childForStatusBarStyle: UIViewController? {
        topViewController
    }
}
