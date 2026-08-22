//
//  OTPTextField.swift
//  Vs_GradItCollege
//
//  Created by Chandhru on 21/08/26.
//

import Foundation
import UIKit


@objc class OTPTextField: UITextField {
    /// Border color info for field
    public var otpBorderColor: UIColor = UIColor.systemGray5
    
    /// Border width info for field
    public var otpBorderWidth: CGFloat = 2
    
    public var shapeLayer: CAShapeLayer!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func initalizeUI(forFieldType type: DisplayType) {
        // Square shape only
        
        layer.borderColor = otpBorderColor.cgColor
        layer.borderWidth = otpBorderWidth
        switch type{
        case.circular:
            layer.cornerRadius = bounds.size.width / 2
        case.roundedCorner:
            layer.cornerRadius = 10
        case.square:
            layer.cornerRadius = 0
        case .diamond:
            layer.cornerRadius = 0
        case .underlinedBottom:
            layer.cornerRadius = 0
        }
        autocorrectionType = .no
        textAlignment = .center
        if #available(iOS 12.0, *) {
            textContentType = .oneTimeCode
        }
    }
    
    override func deleteBackward() {
        super.deleteBackward()
        
        _ = delegate?.textField?(self, shouldChangeCharactersIn: NSMakeRange(0, 0), replacementString: "")
    }
    
    override open func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return action == #selector(UIResponderStandardEditActions.paste(_:)) ?
            false : super.canPerformAction(action, withSender: sender)
    }
}
