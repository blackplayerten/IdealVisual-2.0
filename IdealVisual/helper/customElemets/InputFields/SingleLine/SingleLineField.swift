//
//  SingleLineField.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 19.12.2021.
//

import UIKit

final class SingleLineField: UIView, InputFieldBuilder {
    private struct UIConstants {
        static let width: CGFloat = 300.0
        static let height: CGFloat = 60.0
        static let iconPadding: CGFloat = 10.0
        static let iconSize: CGSize = .init(width: 30.0, height: 30.0)
        static let textFieldHeight: CGFloat = 30.0
        static let textFieldPadding: CGFloat = 20.0
        static let countSymbolsLabelPadding: UIEdgeInsets = .init(top: 0.0, left: 10.0, bottom: 0.0, right: 20.0)
        static let countSymbolsLabelHeight: CGFloat = 30.0
        static let mistakeLabelPadding: CGFloat = 5.0
    }

    //MARK: - elements
    private(set) var parentView = UIView()
    private let iconImageView = UIImageView(image: nil)
    private let icon = UIImage()
    private let textField = UITextField()
    private let countSymbolsLabel = UILabel()

    let mistakeLabel = UILabel()
    var validator: Validator?

    private weak var singleLineDelegate: InputFieldDelegate?
    var frameInput: CGRect = .zero

    //MARK: - configure builder elements
    init(superView: UIView) {
        parentView = superView
        super.init(frame: .zero)
    }

    func configure() {
        snp.makeConstraints {
            $0.width.equalTo(UIConstants.width)
            $0.height.equalTo(UIConstants.height)
        }
        backgroundColor = AppTheme.shared.colorsComponents.background
    }

    func configureIcon(image: UIImage) {
        addSubview(iconImageView)
        iconImageView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(UIConstants.iconPadding)
            $0.height.width.equalTo(UIConstants.iconSize)
            $0.centerY.equalToSuperview()
        }
        iconImageView.image = image
        iconImageView.layer.masksToBounds = true
    }

    func configureInput(placeholder: String) {
        addSubview(textField)
        textField.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.height.equalTo(UIConstants.textFieldHeight)
            $0.left.equalTo(iconImageView.snp.right).offset(UIConstants.textFieldPadding)
            $0.right.lessThanOrEqualTo(self.snp.right).inset(UIConstants.textFieldPadding)
        }
        textField.textAlignment = .left
        textField.font = UIFont(name: UIFont.Names.system, size: UIFont.Sizes.medium)
        textField.placeholder = placeholder
        let attrPlaceholder = NSAttributedString(string: placeholder,
                                                 attributes: [
                                                    NSAttributedString.Key.foregroundColor:
                                                        AppTheme.shared.colorsComponents.inputFiledPlaceholder,
                                                    NSAttributedString.Key.font:
                                                        UIFont(name: UIFont.Names.system, size: UIFont.Sizes.small)!])
        textField.attributedPlaceholder = attrPlaceholder
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.delegate = self
    }

    func configureCountSymbolsLabel() {
        addSubview(countSymbolsLabel)
        countSymbolsLabel.snp.makeConstraints {
            $0.left.equalTo(textField.snp.right).offset(UIConstants.countSymbolsLabelPadding.left).priority(.low)
            $0.right.equalToSuperview().inset(UIConstants.countSymbolsLabelPadding.right).priority(.high)
            $0.height.equalTo(UIConstants.countSymbolsLabelHeight)
            $0.centerY.equalToSuperview()
        }
        countSymbolsLabel.text = "2/200"

        countSymbolsLabel.textColor = AppTheme.shared.colorsComponents.secondaryText
        countSymbolsLabel.font = UIFont(name: UIFont.Names.system, size: UIFont.Sizes.small)
    }

    func configureBottomObject() {
        addSubview(mistakeLabel)
        mistakeLabel.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom)
            $0.left.equalToSuperview().inset(UIConstants.mistakeLabelPadding)
            $0.right.equalToSuperview().offset(UIConstants.mistakeLabelPadding)
            $0.bottom.equalToSuperview()
        }
    }

    func setDelegate<T>(_with delegate: inout T) {
        guard let delegate = delegate as? InputFieldDelegate else { return Logger.log("invalid single delegate") }
        self.singleLineDelegate = delegate
    }

    //MARK: - configure oher elements
    func setSecutityField(withContentType contentType: UITextContentType, withKeyboardType keyboardType: UIKeyboardType) {
        textField.textContentType = contentType
        textField.keyboardType = keyboardType
        if contentType == .password || contentType == .newPassword {
            textField.isSecureTextEntry = true
        }
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
    }
    
    func setValidator(validator: @escaping Validator) {
        self.validator = validator
    }

    //MARK: - functions
    func setEditFields(state: Bool) {
        if state {
            layer.borderColor = AppTheme.shared.colorsComponents.loadingIndicator.cgColor
        } else {
            layer.borderColor = AppTheme.shared.colorsComponents.secondaryText.cgColor
        }
        countSymbolsLabel.isHidden = !state
        textField.isUserInteractionEnabled = state
    }

    func setError(text: String) {
        mistakeLabel.text = text
        mistakeLabel.isHidden = false
    }

    func isValid() -> Bool {
        guard let validator = validator else { Logger.log("invalid sigleLineInput validator"); return false }
        return validator(self, mistakeLabel)
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
            self.countSymbolsLabel.text = "\(text.count)"
        } else {
            self.countSymbolsLabel.text = String(50)
        }
        mistakeLabel.isHidden = true
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

//MARK: - text field delegate
extension SingleLineField: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        singleLineDelegate?.setActiveField(self)
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTextFieldTag = tag + 1
        if let nextTextField = (superview?.viewWithTag(nextTextFieldTag) as? SingleLineField)?.textField {
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
            self.countSymbolsLabel.text = "\(newLength)"
            return true
        } else {
            return false
        }
    }
}
