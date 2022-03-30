//
//  Localizable.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 27.11.2021.
//

import Foundation

struct Localizable: ExpressibleByStringLiteral, Equatable {
    let string: String

    init(key: String) {
        self.string = NSLocalizedString(key, comment: "")
    }
    init(localized: String) {
        self.string = localized
    }
    init(stringLiteral value:String) {
        self.init(key: value)
    }
    init(extendedGraphemeClusterLiteral value: String) {
        self.init(key: value)
    }
    init(unicodeScalarLiteral value: String) {
        self.init(key: value)
    }
    
    func localized(prefix: String?, value: String) -> String {
        let key = prefix == nil ? value : "\(prefix!).\(value)"

        let result = Bundle.main.localizedString(forKey: key,
                                                 value: "**\(key)**",
                                                 table: nil)
        return result
    }
}

func ==(lhs: Localizable, rhs: Localizable) -> Bool {
    return lhs.string == rhs.string
}
