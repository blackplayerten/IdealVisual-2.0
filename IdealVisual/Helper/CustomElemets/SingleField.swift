//
//  SingleField.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 19.12.2021.
//

import Foundation
import UIKit
import SnapKit

protocol SingleFieldDelegate: AnyObject {
    func setActiveField(singleField: SingleField)
}

final class SingleField: UIView, UITextFieldDelegate {
    let blockView = UIView()

    let textField = UITextField()
    let labelMode = UILabel()
    let labelImage = UIImage()

    let mistakeLabel = CheckMistakeLabel()
    private let validator: Validator?

    private weak var singleDelegate: SingleFieldDelegate?

    init(tag: Int, labelImage: UIImage? = nil, text: String? = nil, placeholder: String? = nil,
         textContentType: UITextContentType? = nil, keyboardType: UIKeyboardType = .default,
         validator: Validator? = nil,
         inputDelegate: SingleFieldDelegate? = nil) {

        self.validator = validator
        self.singleDelegate = inputDelegate

        super.init(frame: .zero)
        self.tag = tag

        addSubview(blockView)
        blockView.translatesAutoresizingMaskIntoConstraints = false
        blockView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        blockView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        blockView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        blockView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true

        [textField, labelMode].forEach {
            blockView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        layer.borderWidth = 0.5
        layer.cornerRadius = 10

        let font1 = UIFont(name: "PingFang-SC-SemiBold", size: 14)
        let font2 = UIFont(name: "PingFang-SC-Regular", size: 14)

        textField.delegate = self
        textField.text = text
        textField.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        textField.font = font2
        textField.textAlignment = .left
        textField.setContentHuggingPriority(UILayoutPriority(rawValue: 1), for: .horizontal)
        textField.placeholder = placeholder
        let attrPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: [
            NSAttributedString.Key.foregroundColor: AppTheme.shared.colorsComponents.inputFiledPlaceholder,
            NSAttributedString.Key.font: font1 as Any
        ])
        textField.attributedPlaceholder = attrPlaceholder

        textField.textContentType = textContentType
        textField.keyboardType = keyboardType
        if textContentType == .password || textContentType == .newPassword {
            textField.isSecureTextEntry = true
        }
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none

        labelMode.leftAnchor.constraint(equalTo: textField.rightAnchor, constant: 10).isActive = true
        labelMode.text = ""
        labelMode.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        labelMode.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        labelMode.heightAnchor.constraint(equalToConstant: 30).isActive = true
        labelMode.textColor = AppTheme.shared.colorsComponents.secondaryText
        labelMode.font = font2
        labelMode.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 2000), for: .horizontal)

        addSubview(mistakeLabel)
        mistakeLabel.translatesAutoresizingMaskIntoConstraints = false

        mistakeLabel.topAnchor.constraint(equalTo: bottomAnchor).isActive = true
        mistakeLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true

        let labelIV = UIImageView()
        addSubview(labelIV)
        labelIV.translatesAutoresizingMaskIntoConstraints = false
        labelIV.image = labelImage
        labelIV.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        labelIV.rightAnchor.constraint(equalTo: textField.leftAnchor, constant: -30).isActive = true
        labelIV.layer.masksToBounds = true
        labelIV.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        labelIV.heightAnchor.constraint(equalToConstant: 20).isActive = true
        labelIV.widthAnchor.constraint(equalToConstant: 20).isActive = true
        labelIV.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 2000), for: .horizontal)
    }

    func setError(text: String) {
        mistakeLabel.text = text
        mistakeLabel.isHidden = false
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        singleDelegate?.setActiveField(singleField: self)
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTextFieldTag = tag + 1

        if let nextTextField = (superview?.viewWithTag(nextTextFieldTag) as? SingleField)?.textField {
            nextTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if let text = textField.text {
            let currentString: NSString = text as NSString
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString

            textField.text = newString as String

            _ = isValid()

            textField.text = currentString as String
        }

        let newLength = (textField.text!.count + string.count) - range.length
        if newLength <= 50 {
            self.labelMode.text = "\(newLength)"
            return true
        } else {
            return false
        }
    }

    func isValid() -> Bool {
        var success = true
        if let validator = validator {
            success = validator(self, mistakeLabel)
        }

        return success
    }

    func setEditFields(state: Bool) {
        if state {
            layer.borderColor = AppTheme.shared.colorsComponents.loadingIndicator.cgColor
        } else {
            layer.borderColor = AppTheme.shared.colorsComponents.secondaryText.cgColor
        }
        labelMode.isHidden = !state
        textField.isUserInteractionEnabled = state
    }

    func setValidationState(isValid: Bool) {
        if isValid {
            layer.borderColor = AppTheme.shared.colorsComponents.loadingIndicator.cgColor
        } else {
            layer.borderColor = UIColor.red.cgColor
        }
    }

    func clearState() {
        if let text = textField.text {
            self.labelMode.text = "\(text.count)"
        } else {
            self.labelMode.text = String(50)
        }
        mistakeLabel.isHidden = true
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

// MARK: - mistakes on text field
final class CheckMistakeLabel: UILabel {
    init(text: String? = nil) {
        super.init(frame: .zero)
        heightAnchor.constraint(equalToConstant: 20).isActive = true
        widthAnchor.constraint(equalToConstant: 300).isActive = true
        self.text = text
        font = UIFont(name: "PingFang-SC-SemiBold", size: 12)
        textColor = .red
        textAlignment = .left
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
