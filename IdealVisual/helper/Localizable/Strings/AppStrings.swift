//
//  AppStrings.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 27.11.2021.
//

enum Locate: Localizable {
    case rus
    case en

    var prefix: String? {
        "language"
    }

    var localized: String {
        return self.rawValue.localized(prefix: prefix, value: self.rawValue.string)
    }
}

enum AppStrings: Localizable {
    case load

    var prefix: String? {
        "launch"
    }

    var localized: String {
        return self.rawValue.localized(prefix: prefix, value: self.rawValue.string)
    }
}
