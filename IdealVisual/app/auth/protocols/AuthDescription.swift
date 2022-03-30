//
//  AuthProtocols.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 30.03.2022.
//

import Foundation

protocol AuthViewControllerDelegate: AnyObject {
    func updateHeader(type: AuthViewControllerType)
}

protocol AuthViewInput: AnyObject {
    var type: AuthViewControllerType? { get set }
}

protocol AuthModelServiceDescription: AnyObject {
    
}

