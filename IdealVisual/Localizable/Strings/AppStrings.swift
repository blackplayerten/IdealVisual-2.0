//
//  AppStrings.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 27.11.2021.
//

import Foundation

enum Locate: Localizable {
    case rus = "rus"
    case en = "en"

    var prefix: String? {
        "language"
    }

    var localized: String {
        return self.rawValue.localized(prefix: prefix, value: self.rawValue.string)
    }
}

enum AppLoaderStrings: Localizable {
    case alert = "alert"
    
    var prefix: String? {
        "loader"
    }

    var localized: String {
        return self.rawValue.localized(prefix: prefix, value: self.rawValue.string)
    }
}

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
