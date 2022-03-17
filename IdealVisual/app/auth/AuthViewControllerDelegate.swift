//
//  AuthViewControllerDelegate.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 14.03.2022.
//

import Foundation
import UIKit

protocol AuthViewControllerDelegate: AnyObject {
    func updateHeader(type: AuthViewControllerType)
    func navigateAuthVC(type: AuthViewControllerType, from: UIViewController)
}

enum AuthViewControllerType {
    case signIn
    case signUp
}
