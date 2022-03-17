//
//  PhotoStrings.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 15.03.2022.
//

import Foundation

enum PhotoStrings: Localizable {
    case camera
    case gallery
    case haventCamera
    case wrongGallery
    case wrongSavedPhoto

    var prefix: String? {
        "photo"
    }

    var localized: String {
        return self.rawValue.localized(prefix: prefix, value: self.rawValue.string)
    }
}
