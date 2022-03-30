//
//  LaunchViewModelDescription.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 30.03.2022.
//

protocol LaunchViewModelProtocol: AnyObject { }

protocol LaunchViewModelInput: AnyObject {
    func configureWarning(type: ConnectionWarningType)
}

protocol LaunchViewModelOutput: AnyObject {
    var alertUpdatedMessage: String { get }
    var bindAlertMessage: (() -> Void) { get set }
}
