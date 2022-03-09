//
//  ErrorStrings.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 19.12.2021.
//

import Foundation

enum ErrorStrings: Localizable {
    case unknown = "unknown"
    case noInternetConnection = "noInternetConnection"
    case emptyData = "emptyData"
    case unauthorized = "unauthorized"
    case access = "access"
    case unavaliable = "unavalaible"

    var prefix: String? {
        "error"
    }

    var localized: String {
        return self.rawValue.localized(prefix: prefix, value: self.rawValue.string)
    }
}
