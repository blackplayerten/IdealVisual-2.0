//
//  SignUpViewModel.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 27.11.2021.
//

protocol SignUpViewModelProtocol: AnyObject {
    var bind: (() -> ()) { get set }
    func validateEmail(for field: SingleLineField) -> ValidateEmailErrors?
    func validatePassword(for field: SingleLineField) -> ValidatePasswordErrors?
    func validatePasswordPair(for field1: SingleLineField, field2: SingleLineField) -> ValidatePasswordErrors?
    func signup()
}

final class SignUpViewModel: SignUpViewModelProtocol {
    private let validateEmail = EmailValidator()
    private let validatePassword = ValidatePasssword()

    var bind: (() -> ()) = {}

    func validateEmail(for field: SingleLineField) -> ValidateEmailErrors? {
        validateEmail.validate(field: field)
    }

    func validatePassword(for field: SingleLineField) -> ValidatePasswordErrors? {
        validatePassword.validate(field: field)
    }

    func validatePasswordPair(for field1: SingleLineField, field2: SingleLineField) -> ValidatePasswordErrors? {
        validatePassword.validatePair(field1, field2)
    }

    func signup() {
        
    }
}
