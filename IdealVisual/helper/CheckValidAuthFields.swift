//
//  CheckValidAuthFields.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 19.12.2021.
//

import Foundation
import UIKit

typealias Validator = (SingleLineField, UILabel) -> Bool

func checkNotEmpty(field: SingleLineField, mistake: UILabel, message: String = "") -> Bool {
    let isValid = field.textField.text?.count != 0
    if isValid {
        field.setValidationState(isValid: true)
        mistake.isHidden = true
    } else {
        field.setValidationState(isValid: false)
        mistake.text = message
        mistake.isHidden = false
    }

    return isValid
}

func checkValidUsername(field: SingleLineField, mistake: UILabel) -> Bool {
    return checkNotEmpty(field: field, mistake: mistake, message: "Имя пользователя не может быть пустым")
}

func checkValidEmail(field: SingleLineField, mistake: UILabel) -> Bool {
    if !checkNotEmpty(field: field, mistake: mistake, message: "Электронная почта не может быть пустой") {
        return false
    }

    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)

    let isEmail = emailPred.evaluate(with: field.textField.text)
    if isEmail {
        field.setValidationState(isValid: true)
        mistake.isHidden = true
    } else {
        field.setValidationState(isValid: false)
        mistake.text = "Неверный формат почты"
        mistake.isHidden = false
    }

    return isEmail
}

func checkValidPassword(field: SingleLineField, mistake: UILabel) -> Bool {
    return checkNotEmpty(field: field, mistake: mistake, message: "Некорректный пароль")
}

func checkValidPasswordPair(field: SingleLineField, fieldRepeat: SingleLineField) -> Bool {
    var passwordsAreValid = true
    if field.textField.text != fieldRepeat.textField.text {
        passwordsAreValid = false

        if field.textField.text!.count < 8 {
            field.mistakeLabel.text = "Слабый пароль, пароли не совпадают"
        } else {
            field.mistakeLabel.text = "Пароли не совпадают"
        }
        if fieldRepeat.textField.text!.count < 8 {
            fieldRepeat.mistakeLabel.text = "Слабый пароль, пароли не совпадают"
        } else {
            fieldRepeat.mistakeLabel.text = "Пароли не совпадают"
        }

    } else if field.textField.text!.count < 8 && fieldRepeat.textField.text!.count < 8 {
        passwordsAreValid = false

        field.mistakeLabel.text = "Слабый пароль"
        fieldRepeat.mistakeLabel.text = "Слабый пароль"
    }

    [field, fieldRepeat].forEach {
        if passwordsAreValid {
            $0.setValidationState(isValid: true)
        } else {
            $0.setValidationState(isValid: false)
        }
    }
    [field.mistakeLabel, fieldRepeat.mistakeLabel].forEach {
        if passwordsAreValid {
            $0.isHidden = true
        } else {
            $0.isHidden = false
        }
    }

    return passwordsAreValid
}
