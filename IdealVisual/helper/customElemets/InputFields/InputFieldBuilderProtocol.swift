//
//  InputFieldBuilderProtocol.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 20.12.2021.
//

import Foundation
import UIKit

protocol InputFieldBuilder: AnyObject {
    func configure()
    func configureIcon(image: UIImage)
    func configureInput(placeholder: String)
    func configureCountSymbolsLabel()
    func configureBottomObject()
    func setDelegate<T>(_with delegate: inout T)
}
