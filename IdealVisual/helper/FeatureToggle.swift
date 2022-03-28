//
//  FeatureToggle.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 28.03.2022.
//

import Foundation
import Alamofire

protocol FeatureToggleDescription: AnyObject {
    static var internetConnection: Bool { get set }
    static var offline: Bool { get set }
}

final class FeatureToggle: FeatureToggleDescription {
    private static let networkManager = NetworkReachabilityManager()

    static var internetConnection: Bool = false {
        didSet(newValue) {
            guard let manager = networkManager else { return }
            internetConnection = manager.isReachable
        }
    }

   static var offline: Bool = false {
        didSet(newValue) {
           offline = newValue
        }
    }
}
