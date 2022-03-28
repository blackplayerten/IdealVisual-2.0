//
//  BaseRouterDescription.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 28.03.2022.
//

import UIKit

protocol BaseRouterDescriprion: AnyObject {
    func push(viewController: Presentable)
    func addChild(viewController: Presentable, for parent: Presentable)
    func removeChild(viewController: Presentable)
    func closeApp()
}
