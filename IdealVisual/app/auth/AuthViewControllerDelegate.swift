//
//  AuthViewControllerDelegate.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 14.03.2022.
//

import UIKit

protocol AuthViewControllerDelegate: AnyObject {
    func updateHeader(type: AuthViewControllerType)
}
