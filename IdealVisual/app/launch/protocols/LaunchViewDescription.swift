//
//  LaunchViewDescription.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 30.03.2022.
//


protocol LaunchViewInput: AnyObject {
    var warningType: ConnectionWarningType? { get set }
}

protocol LaunchViewOutput: AnyObject { }
