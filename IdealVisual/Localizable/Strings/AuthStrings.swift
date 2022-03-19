//
//  AuthStrings.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 19.12.2021.
//

enum AuthStrings: Localizable {
    case signin = "signin"
    case signup = "signup"
    case email = "email"
    case username = "username"
    case password = "password"
    case repeatPassword = "repeatPassword"
    case haventAccount = "haventAccount"

    var prefix: String? {
        "auth"
    }

    var localized: String {
        return self.rawValue.localized(prefix: prefix, value: self.rawValue.string)
    }
}

enum WrongAuthStrings: Localizable {
    case usernameAlreadyExists = "usernameAlreadyExists"
    case usernameLengthIsWrong = "usernameLengthIsWrong"
    case emailAlreadyExists = "emailAlreadyExists"
    case emailFormatIsWrong = "emailFormatIsWrong"
    case passwordLengthIsWrong = "passwordLengthIsWrong"

    var prefix: String? {
        "wrongAuth"
    }

    var localized: String {
        return self.rawValue.localized(prefix: prefix, value: self.rawValue.string)
    }
}
