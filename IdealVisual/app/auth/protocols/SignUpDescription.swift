//
//  SignUpDescription.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 30.03.2022.
//

protocol SignUpViewModelProtocol: AnyObject {
    var bind: (() -> ()) { get set }
    func validateEmail(for field: SingleLineField) -> ValidateEmailErrors?
    func validatePassword(for field: SingleLineField) -> ValidatePasswordErrors?
    func validatePasswordPair(for field1: SingleLineField, field2: SingleLineField) -> ValidatePasswordErrors?
    func signup()
}
