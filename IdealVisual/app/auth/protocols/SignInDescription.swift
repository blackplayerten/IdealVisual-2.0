//
//  SignInDescription.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 30.03.2022.
//

protocol SignInViewModelProtocol: AnyObject {
    var bind: (() -> Void) { get set }
    func validateEmail(for field: SingleLineField) -> ValidateEmailErrors?
    func validatePassword(for field: SingleLineField) -> ValidatePasswordErrors?
    func login()
}
