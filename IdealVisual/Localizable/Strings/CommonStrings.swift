//
//  CommonStrings.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 15.03.2022.
//

import Foundation

enum CommonStrings: Localizable {
    case cancel
    case ok

    var prefix: String? {
        "common"
    }

    var localized: String {
        return self.rawValue.localized(prefix: prefix, value: self.rawValue.string)
    }
}
