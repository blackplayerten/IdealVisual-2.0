//
//  InputFieldsDelegate.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 19.12.2021.
//

import Foundation
import UIKit

protocol InputFieldDelegate: AnyObject {
    func setActiveField(_ field: InputFieldBuilder)
}

protocol BlockProtocol: AnyObject {
    func updateBlock(from: MultiLineField)

    func textViewShouldBeginEditing(block: MultiLineField)
    func textViewShouldEndEditing(block: MultiLineField)
}
