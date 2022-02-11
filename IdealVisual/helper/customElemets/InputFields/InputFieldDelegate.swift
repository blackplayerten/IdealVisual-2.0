//
//  InputFieldsDelegate.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 19.12.2021.
//

import Foundation

protocol SingleLineFieldDelegate: AnyObject {
    func setActiveField(singleLineField: SingleLineField)
}

protocol BlockProtocol: AnyObject {
    func updateBlock(from: MultiLineField)

    func textViewShouldBeginEditing(block: MultiLineField)
    func textViewShouldEndEditing(block: MultiLineField)
}
