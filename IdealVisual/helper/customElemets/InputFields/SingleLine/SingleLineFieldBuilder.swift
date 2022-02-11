//
//  SingleLineFieldBuilder.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 20.12.2021.
//

import Foundation
import UIKit

protocol SingleLineTypesFieldBuilderBoss: AnyObject {
    func update(builder: InputFieldBuilder)
    func buildEmailField()
    func buildPasswordField()
}

final class SingleLineFieldBuilderBoss: SingleLineTypesFieldBuilderBoss {
    private var builder: InputFieldBuilder?

    func update(builder: InputFieldBuilder) {
        self.builder = builder
    }

    func buildEmailField() {
        
    }

    func buildPasswordField() {
        
    }
}

final class SingleLineFieldBuilder: InputFieldBuilder {
    private var singleField = SingleLineField()

    func configure() {
        singleField.configure()
    }

    func configureIcon(image: UIImage) {
        singleField.configureIcon(image: image)
    }

    func configureInput(placeholder: String) {
        singleField.configureInput(placeholder: placeholder)
    }

    func configureCountSymbolsLabel() {
        singleField.configureCountSymbolsLabel()
    }

    func configureBottomObject() {
        singleField.configureBottomObject()
    }

    func setDelegate<T>(_with delegate: inout T) {
        singleField.setDelegate(_with: &delegate)
    }
    
    func combineSingleField() -> SingleLineField {
        singleField
    }
}
