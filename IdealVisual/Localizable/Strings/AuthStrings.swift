//
//  AuthStrings.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 19.12.2021.
//

enum AuthStrings: Localizable {
    case signin
    case signup
    case email
    case username
    case password
    case repeatPassword
    case haventAccount
    case haveAccount

    var prefix: String? {
        "auth"
    }

    var localized: String {
        return self.rawValue.localized(prefix: prefix, value: self.rawValue.string)
    }
}

enum WrongAuthStrings: Localizable {
    case usernameAlreadyExists
    case usernameLengthIsWrong
    case emailAlreadyExists
    case emailFormatIsWrong
    case passwordLengthIsWrong

    var prefix: String? {
        "wrongAuth"
    }

    var localized: String {
        return self.rawValue.localized(prefix: prefix, value: self.rawValue.string)
    }
}
