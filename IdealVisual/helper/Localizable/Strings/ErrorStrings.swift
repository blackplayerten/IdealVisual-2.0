//
//  ErrorStrings.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 19.12.2021.
//

enum ErrorStrings: Localizable {
    case unknown
    case noInternetConnection
    case emptyData
    case unauthorized
    case access
    case unavailable
    case warning

    var prefix: String? {
        "error"
    }

    var localized: String {
        return self.rawValue.localized(prefix: prefix, value: self.rawValue.string)
    }
}
