//
//  OTPView.swift
//  Vs_GradItCollege
//
//  Created by Chandhru on 21/08/26.
//
import Foundation
import UIKit

@objc public protocol OTPFieldViewDelegate: AnyObject {
    
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool
    func enteredOTP(otp: String)
    func hasEnteredAllOTP(hasEnteredAll: Bool) -> Bool
   
}

@objc public enum DisplayType: Int {
    case circular
    case roundedCorner
    case square
    case diamond
    case underlinedBottom
}

/// Different input type for OTP fields.
@objc public enum KeyboardType: Int {
    case numeric
    case alphabet
    case alphaNumeric
}

@objc public class OTPFieldView: UIView {
    
    public var displayType: DisplayType = .roundedCorner
    public var fieldsCount: Int = 4
    public var otpInputType: KeyboardType = .numeric
    public var fieldFont: UIFont = UIFont.systemFont(ofSize: 24)
    public var secureEntry: Bool = false
    public var hideEnteredText: Bool = false
    public var cleartext: Bool = false
    public var requireCursor: Bool = true
    public var cursorColor: UIColor = UIColor.blue
    public var fieldSize: CGFloat = 65
    public var separatorSpace: CGFloat = 8
    public var fieldBorderWidth: CGFloat = 2
    public var shouldAllowIntermediateEditing: Bool = true
    public var defaultBackgroundColor: UIColor = UIColor.clear
    public var filledBackgroundColor: UIColor = UIColor.white
    public var defaultBorderColor: UIColor = UIColor.systemGray3
    public var filledBorderColor: UIColor = UIColor.blue
    public var errorBorderColor: UIColor?
    
    public weak var delegate: OTPFieldViewDelegate?
    
    fileprivate var secureEntryData = [String]()
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        initializeUI()
    }
    
    public func initializeUI() {
        layer.masksToBounds = true
        layoutIfNeeded()
        
        initializeOTPFields()
        layoutIfNeeded()
        (viewWithTag(1) as? OTPTextField)?.becomeFirstResponder()
        
    }
    
    func clearOtp() {
        secureEntryData.removeAll()
        initializeUI()
        layoutIfNeeded()
    }
    
    fileprivate func initializeOTPFields() {
        secureEntryData.removeAll()
        
        for index in stride(from: 0, to: fieldsCount, by: 1) {
            let oldOtpField = viewWithTag(index + 1) as? OTPTextField
            oldOtpField?.removeFromSuperview()
            
            let otpField = getOTPField(forIndex: index)
            addSubview(otpField)
            
            secureEntryData.append("")
        }
    }
    
    fileprivate func getOTPField(forIndex index: Int) -> OTPTextField {

        let totalSpacing = CGFloat(fieldsCount - 1) * separatorSpace
        let availableWidth = bounds.width - totalSpacing

        let calculatedFieldSize = min(
            fieldSize,
            availableWidth / CGFloat(fieldsCount)
        )

        let totalWidth =
            (CGFloat(fieldsCount) * calculatedFieldSize) + totalSpacing

        let startX = (bounds.width - totalWidth) / 2

        let fieldFrame = CGRect(
            x: startX + CGFloat(index) * (calculatedFieldSize + separatorSpace),
            y: (bounds.height - calculatedFieldSize) / 2,
            width: calculatedFieldSize,
            height: calculatedFieldSize
        )

        let otpField = OTPTextField(frame: fieldFrame)

        otpField.delegate = self
        otpField.tag = index + 1
        otpField.font = fieldFont

        if #available(iOS 12.0, *) {
            otpField.textContentType = .oneTimeCode
        } else {
            otpField.autocorrectionType = .yes
        }

        switch otpInputType {
        case .numeric:
            otpField.keyboardType = .numberPad

        case .alphabet:
            otpField.keyboardType = .alphabet

        case .alphaNumeric:
            otpField.keyboardType = .namePhonePad
        }

        otpField.otpBorderColor = defaultBorderColor
        otpField.otpBorderWidth = fieldBorderWidth

        if requireCursor {
            otpField.tintColor = cursorColor
            otpField.placeholder = "0"
        } else {
            otpField.tintColor = .clear
        }

        otpField.backgroundColor = defaultBackgroundColor
        otpField.initalizeUI(forFieldType: displayType)

        return otpField
    }
    
    fileprivate func isPreviousFieldsEntered(forTextField textField: UITextField) -> Bool {
        var isTextFilled = true
        var nextOTPField: UITextField?
        if !shouldAllowIntermediateEditing {
            for index in stride(from: 1, to: fieldsCount + 1, by: 1) {
                let tempNextOTPField = viewWithTag(index) as? UITextField
                
                if let tempNextOTPFieldText = tempNextOTPField?.text, tempNextOTPFieldText.isEmpty {
                    nextOTPField = tempNextOTPField
                    
                    break
                }
            }
            
            if let nextOTPField = nextOTPField {
                isTextFilled = (nextOTPField == textField || (textField.tag) == (nextOTPField.tag - 1))
            }
        }
        
        return isTextFilled
    }
    
    // Helper function to get the OTP String entered
    fileprivate func calculateEnteredOTPSTring(isDeleted: Bool) {
        if isDeleted {
            _ = delegate?.hasEnteredAllOTP(hasEnteredAll: false)
            for index in stride(from: 0, to: fieldsCount, by: 1) {
                var otpField = viewWithTag(index + 1) as? OTPTextField
                
                if otpField == nil {
                    otpField = getOTPField(forIndex: index)
                }
                
                let fieldBackgroundColor = (otpField?.text ?? "").isEmpty ? defaultBackgroundColor : filledBackgroundColor
                let fieldBorderColor = (otpField?.text ?? "").isEmpty ? defaultBorderColor : filledBorderColor
                otpField?.backgroundColor = fieldBackgroundColor
                otpField?.layer.borderColor = fieldBorderColor.cgColor
            }
        }
        else {
            var enteredOTPString = ""
            for index in stride(from: 0, to: secureEntryData.count, by: 1) {
                if !secureEntryData[index].isEmpty {
                    enteredOTPString.append(secureEntryData[index])
                }
            }
            
            if enteredOTPString.count == fieldsCount {
                delegate?.enteredOTP(otp: enteredOTPString)
                let isValid = delegate?.hasEnteredAllOTP(hasEnteredAll: (enteredOTPString.count == fieldsCount)) ?? false
                for index in stride(from: 0, to: fieldsCount, by: 1) {
                    var otpField = viewWithTag(index + 1) as? OTPTextField
                    
                    if otpField == nil {
                        otpField = getOTPField(forIndex: index)
                    }
                    
                    if !isValid {
                        otpField?.layer.borderColor = (errorBorderColor ?? filledBorderColor).cgColor
                    }
                    else {
                        otpField?.layer.borderColor = filledBorderColor.cgColor
                    }
                }
            }
        }
    }
}

extension OTPFieldView: UITextFieldDelegate {
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let shouldBeginEditing = delegate?.shouldBecomeFirstResponderForOTP(otpTextFieldIndex: (textField.tag - 1)) ?? true
        if shouldBeginEditing {
            return isPreviousFieldsEntered(forTextField: textField)
        }
        
        return shouldBeginEditing
    }
   
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let replacedText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
        if !replacedText.isEmpty && otpInputType == .alphabet && replacedText.rangeOfCharacter(from: .letters) == nil {
            return false
        }
        let aSet = NSCharacterSet(charactersIn: "0123456789").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")

        if replacedText.count >= 1 && string == numberFiltered {
            secureEntryData[textField.tag - 1] = string
            
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            
            if hideEnteredText {
                textField.text = " "
            }
            else {
                if secureEntry {
                    textField.text = "•"
                }
                else {
                    textField.text = string
                }
            }
            textField.backgroundColor = filledBackgroundColor
            textField.layer.borderColor = filledBorderColor.cgColor
            
            let nextOTPField = viewWithTag(textField.tag + 1)
            
            if let nextOTPField = nextOTPField {
                nextOTPField.becomeFirstResponder()
            }
            else {
                textField.resignFirstResponder()
            }
            calculateEnteredOTPSTring(isDeleted: false)
        }
        else {
            let currentText = textField.text ?? ""
            
            if textField.tag > 1 && currentText.isEmpty {
                if let prevOTPField = viewWithTag(textField.tag - 1) as? UITextField {
                    deleteText(in: prevOTPField)
                }
            } else {
                deleteText(in: textField)
                if textField.tag > 1 {
                    if let prevOTPField = viewWithTag(textField.tag - 1) as? UITextField {
                        prevOTPField.becomeFirstResponder()
                    }
                }
            }
        }
        
        return false
    }
    
    private func deleteText(in textField: UITextField) {
        // If deleting the text, then move to previous text field if present
        secureEntryData[textField.tag - 1] = ""
        textField.text = ""
        
        // displayType always .square
        textField.backgroundColor = defaultBackgroundColor
        textField.layer.borderColor = defaultBorderColor.cgColor
        
        textField.becomeFirstResponder()
        
        // Get the entered string
        calculateEnteredOTPSTring(isDeleted: true)
    }
    
}
class RoundedBackBtn: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()

        setupGlassEffect()
    }

    private func setupGlassEffect() {

        layer.borderWidth = 1
        layer.backgroundColor = UIColor.white.withAlphaComponent(0.27).cgColor
        layer.borderColor = UIColor.white.withAlphaComponent(0.27).cgColor

        layer.cornerRadius = bounds.height / 2
        clipsToBounds = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }
}
