//
//  CustomTextfield.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 29/05/25.
//

import Foundation
import UIKit

@IBDesignable
class PaddedTextField: UITextField {

    // MARK: - Padding
    @IBInspectable var paddingLeft: CGFloat = 10
    @IBInspectable var paddingRight: CGFloat = 10

    // MARK: - Styling
    @IBInspectable var cornerRadius: CGFloat = 10
    @IBInspectable var borderWidth: CGFloat = 1
    @IBInspectable var borderColor: UIColor = UIColor.systemGray4

    // MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
        applyStyling()
        font = UIFont(name: "Poppins-Regular", size: 14)
        addDoneButtonOnKeyboard()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        applyStyling()
    }

    private func applyStyling() {
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        layer.masksToBounds = true
    }

    // MARK: - Padding Implementation
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: paddingLeft, bottom: 0, right: paddingRight))
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    private func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar()
        doneToolbar.sizeToFit()

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))

        doneToolbar.items = [flexSpace, doneButton]
        self.inputAccessoryView = doneToolbar
    }

    @objc private func doneButtonTapped() {
        self.resignFirstResponder()
    }
}


import Foundation
import UIKit

@IBDesignable
class TextfieldWithImage: UITextField {

    // MARK: - Padding
    @IBInspectable var paddingLeft: CGFloat = 10
    @IBInspectable var paddingRight: CGFloat = 10

    // MARK: - Styling
    @IBInspectable var cornerRadius: CGFloat = 10
    @IBInspectable var borderWidth: CGFloat = 1
    @IBInspectable var borderColor: UIColor = UIColor.systemGray4

    // MARK: - Right Image
    @IBInspectable var rightImage: UIImage? {
        didSet {
            updateRightView()
        }
    }

    @IBInspectable var rightImagePadding: CGFloat = 8

    // MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
        applyStyling()
        updateRightView()
        font = UIFont(name: "Poppins-Regular", size: 14)
        addDoneButtonOnKeyboard()
        
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        applyStyling()
        updateRightView()
    }

    private func applyStyling() {
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        layer.masksToBounds = true
    }

    private func updateRightView() {
        guard let image = rightImage else {
            rightView = nil
            rightViewMode = .never
            return
        }

        // Use template rendering to apply tint color
        let imageView = UIImageView(image: image.withRenderingMode(.alwaysTemplate))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemBlue // Make it gray

        let imageSize: CGFloat = 16 // Smaller size
        let containerSize: CGFloat = imageSize + rightImagePadding * 2

        imageView.frame = CGRect(x: rightImagePadding, y: 0, width: imageSize, height: imageSize)

        let container = UIView(frame: CGRect(x: 0, y: 0, width: containerSize, height: containerSize))
        container.addSubview(imageView)

        // Center image inside container
        imageView.center = CGPoint(x: container.bounds.midX, y: container.bounds.midY)

        rightView = container
        rightViewMode = .always
    }


    // MARK: - Padding Implementation
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rightInset = rightView != nil ? (rightView!.frame.width + paddingRight) : paddingRight
        return bounds.inset(by: UIEdgeInsets(top: 0, left: paddingLeft, bottom: 0, right: rightInset))
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    private func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar()
        doneToolbar.sizeToFit()

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))

        doneToolbar.items = [flexSpace, doneButton]
        self.inputAccessoryView = doneToolbar
    }

    @objc private func doneButtonTapped() {
        self.resignFirstResponder()
    }
}


import UIKit

class ExpandableTextView: UITextView {

    // MARK: - Placeholder Label
    private let placeholderLabel: UILabel = UILabel()

    @IBInspectable var placeholder: String = "" {
        didSet {
            placeholderLabel.text = placeholder
        }
    }

    override var text: String! {
        didSet {
            textDidChange()
        }
    }

    override var font: UIFont? {
        didSet {
            placeholderLabel.font = font
        }
    }

    // MARK: - Initialization

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    private func setup() {
        isScrollEnabled = false
        font = UIFont(name: "Poppins-Regular", size: 14)

        // Styling
        layer.borderColor = UIColor.systemGray4.cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 8
        clipsToBounds = true
        textContainerInset = UIEdgeInsets(top: 8, left: 5, bottom: 8, right: 5)

        // Placeholder setup
        placeholderLabel.textColor = .lightGray
        placeholderLabel.font = font
        placeholderLabel.numberOfLines = 0
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(placeholderLabel)

        NSLayoutConstraint.activate([
            placeholderLabel.topAnchor.constraint(equalTo: topAnchor, constant: textContainerInset.top),
            placeholderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: textContainerInset.left + 5),
            placeholderLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(textContainerInset.right + 5))
        ])

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(textDidChange),
            name: UITextView.textDidChangeNotification,
            object: self
        )
    }

    // MARK: - Placeholder Visibility
    @objc private func textDidChange() {
        placeholderLabel.isHidden = !text.isEmpty
    }

    // MARK: - Auto Expanding Height
    override var intrinsicContentSize: CGSize {
        let height = max(contentSize.height, 40)
        return CGSize(width: UIView.noIntrinsicMetric, height: height)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        invalidateIntrinsicContentSize()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}


import UIKit

class AlertHelper {
    
    /// Shows an alert with a single OK button.
    static func showOKAlert(on viewController: UIViewController,
                             title: String?,
                             message: String?,
                             okTitle: String? = "OK",
                             okAction: (() -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: okTitle, style: .default) { _ in
            okAction?()
        }
        alert.addAction(ok)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    /// Shows an alert with OK and Cancel buttons.
    static func showOKCancelAlert(on viewController: UIViewController,
                                   title: String?,
                                   message: String?,
                                   okTitle: String? = "OK",
                                   cancelTitle: String? = "Cancel",
                                   okAction: (() -> Void)? = nil,
                                   cancelAction: (() -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: okTitle, style: .default) { _ in
            okAction?()
        }
        alert.addAction(ok)
        
        let cancel = UIAlertAction(title: cancelTitle, style: .cancel) { _ in
            cancelAction?()
        }
        alert.addAction(cancel)
        
        viewController.present(alert, animated: true, completion: nil)
    }
}


import UIKit

class AutoGrowingTextView: UITextView {

    // MARK: - Public properties
    var minHeight: CGFloat = 40
    var placeholder: String = "Enter" {
        didSet {
            placeholderLabel.text = placeholder
        }
    }

    // MARK: - Private
    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .placeholderText
        label.font = UIFont(name: "Poppins-Regular", size: 14) ?? UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        resize()
        placeholderLabel.isHidden = !text.isEmpty
    }

    // MARK: - Setup
    private func setupView() {
        isScrollEnabled = false
        clipsToBounds = true

        // Font
        font = UIFont(name: "Poppins-Regular", size: 14) ?? UIFont.systemFont(ofSize: 14)

        // Placeholder
        addSubview(placeholderLabel)
        NSLayoutConstraint.activate([
            placeholderLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            placeholderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            placeholderLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
        ])

        // Border
        layer.borderColor = UIColor.systemGray4.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 10

        // Done Button Toolbar
        addDoneButtonOnKeyboard()

        // Text change observer
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(textDidChangeNotification),
            name: UITextView.textDidChangeNotification,
            object: self
        )
    }

    @objc private func textDidChangeNotification() {
        placeholderLabel.isHidden = !text.isEmpty
        resize()

        if let tableView = self.superview(of: UITableView.self) {
            UIView.setAnimationsEnabled(false)
            tableView.beginUpdates()
            tableView.endUpdates()
            UIView.setAnimationsEnabled(true)
        }
    }

    // MARK: - Done Button Toolbar
    private func addDoneButtonOnKeyboard() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        ]
        inputAccessoryView = toolbar
    }

    @objc private func doneButtonTapped() {
        resignFirstResponder()
    }

    // MARK: - Auto Resize
    private func resize() {
        let fittingSize = CGSize(width: bounds.width, height: .greatestFiniteMagnitude)
        let calculatedHeight = sizeThatFits(fittingSize).height
        let finalHeight = max(calculatedHeight, minHeight)

        if let heightConstraint = constraints.first(where: { $0.firstAttribute == .height }) {
            heightConstraint.constant = finalHeight
        } else {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        let fittingSize = CGSize(width: bounds.width, height: .greatestFiniteMagnitude)
        let height = max(sizeThatFits(fittingSize).height, minHeight)
        return CGSize(width: UIView.noIntrinsicMetric, height: height)
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}


extension UIButton {
    func setGradientBackground(colors: [UIColor], cornerRadius: CGFloat = 8.0) {
        layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.cornerRadius = cornerRadius

        layer.insertSublayer(gradientLayer, at: 0)
    }
}


extension String {
    func formattedDate(from inputFormat: String = "dd-MM-yyyy", to outputFormat: String = "dd MMM yyyy") -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = inputFormat

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = outputFormat

        guard let date = inputFormatter.date(from: self) else {
            return nil
        }

        return outputFormatter.string(from: date)
    }
}


import UIKit


import UIKit

extension UIView {

    func addDoneBtn(title: String = "Done") {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        let flexSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )

        let done = UIBarButtonItem(
            title: title,
            style: .done,
            target: self,
            action: #selector(dismissKeyboard)
        )

        toolbar.items = [flexSpace, done]

        switch self {
        case let textField as UITextField:
            textField.inputAccessoryView = toolbar

        case let textView as UITextView:
            textView.inputAccessoryView = toolbar

        case let searchBar as UISearchBar:
            searchBar.searchTextField.inputAccessoryView = toolbar

        default:
            break
        }
    }

    @objc private func dismissKeyboard() {
        self.endEditing(true)
    }
}
