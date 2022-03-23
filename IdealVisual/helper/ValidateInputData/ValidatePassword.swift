//
//  ValidatePassword.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 22.03.2022.
//

import Foundation

enum ValidatePasswordErrors {
    case empty
    case wrongFormat
    case invalidPair
}

protocol PasswordValidatorProtocol: AnyObject {
    func validate(field: SingleLineField) -> ValidatePasswordErrors?
    func validatePair(_ field1: SingleLineField, _ field2: SingleLineField) -> ValidatePasswordErrors?
}

final class ValidatePasssword: PasswordValidatorProtocol {
    func validate(field: SingleLineField) -> ValidatePasswordErrors? {
        if checkEmptyField(field) {
            return .empty
        }

        guard let text = field.textField.text else { return .empty }
        if text.count < 8 {
            return .wrongFormat
        }

        return nil
    }

    func validatePair(_ field1: SingleLineField, _ field2: SingleLineField) -> ValidatePasswordErrors? {
        if checkEmptyField(field1) || checkEmptyField(field2) {
            return .empty
        }

        guard let text1 = field1.textField.text,
              let text2 = field2.textField.text
        else { return .empty }
        if text1 != text2 {
            return .invalidPair
        }

        return nil
    }

    private func checkEmptyField(_ field: SingleLineField) -> Bool {
        guard let text = field.textField.text else { return false }
        return text.isEmpty && text.count == 0
    }
}
