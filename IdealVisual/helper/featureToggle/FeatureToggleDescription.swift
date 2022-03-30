//
//  FeatureToggleDescription.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 30.03.2022.
//

protocol FeatureToggleDescription: AnyObject {
    static var internetConnection: Bool { get set }
    static var offline: Bool { get set }
}
