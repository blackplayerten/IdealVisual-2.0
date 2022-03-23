//
//  ValidateEmail.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 22.03.2022.
//

import Foundation

enum ValidateEmailErrors {
    case empty
    case wrongFormat
}

protocol EmailValidatorProtocol: AnyObject {
    func validate(field: SingleLineField) -> ValidateEmailErrors?
}

final class EmailValidator: EmailValidatorProtocol {
    func validate(field: SingleLineField) -> ValidateEmailErrors? {
        if checkEmptyField(field) {
            return .empty
        }

        guard let text = field.textField.text else { return .empty }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        if !emailPred.evaluate(with: text) {
            return .wrongFormat
        }

        return nil
    }

    private func checkEmptyField(_ field: SingleLineField) -> Bool {
        guard let text = field.textField.text else { return false }
        return text.isEmpty && text.count == 0
    }
}
