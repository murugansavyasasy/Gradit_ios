//
//  SetFontStyle.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 29/05/25.
//

import Foundation
import UIKit

extension UILabel {
    enum LabelStyle {
        case light
        case thin
        case regular
        case medium
        case semibold
        case bold
    }

    func setFont(style: LabelStyle, size: CGFloat? = nil) {
        let fontSize = size ?? self.font.pointSize
        let fontName: String

        switch style {
        case .light:
            fontName = "Poppins-Light"
        case .thin:
            fontName = "Poppins-Thin"
        case .regular:
            fontName = "Poppins-Regular"
        case .medium:
            fontName = "Poppins-Medium"
        case .semibold:
            fontName = "Poppins-SemiBold"
        case .bold:
            fontName = "Poppins-Bold"
        }

        if let customFont = UIFont(name: fontName, size: fontSize) {
            self.font = customFont
        } else {
            // Fallback to system font with matching weight
            let systemWeight: UIFont.Weight
            switch style {
            case .light:
                systemWeight = .light
            case .thin:
                systemWeight = .thin
            case .regular:
                systemWeight = .regular
            case .medium:
                systemWeight = .medium
            case .semibold:
                systemWeight = .semibold
            case .bold:
                systemWeight = .bold
            }
            self.font = UIFont.systemFont(ofSize: fontSize, weight: systemWeight)
            print("⚠️ Font '\(fontName)' not available. Using system font instead.")
        }
    }
}

extension UIButton {
    enum ButtonStyle {
        case light
        case thin
        case regular
        case medium
        case semibold
        case bold
    }

    func setTitleFont(style: ButtonStyle, size: CGFloat? = nil) {
        let fontSize = size ?? self.titleLabel?.font.pointSize ?? 17
        let fontName: String

        switch style {
        case .light:
            fontName = "Poppins-Light"
        case .thin:
            fontName = "Poppins-Thin"
        case .regular:
            fontName = "Poppins-Regular"
        case .medium:
            fontName = "Poppins-Medium"
        case .semibold:
            fontName = "Poppins-SemiBold"
        case .bold:
            fontName = "Poppins-Bold"
        }

        if let customFont = UIFont(name: fontName, size: fontSize) {
            self.titleLabel?.font = customFont
        } else {
            // Fallback to system font with matching weight
            let systemWeight: UIFont.Weight
            switch style {
            case .light:
                systemWeight = .light
            case .thin:
                systemWeight = .thin
            case .regular:
                systemWeight = .regular
            case .medium:
                systemWeight = .medium
            case .semibold:
                systemWeight = .semibold
            case .bold:
                systemWeight = .bold
            }
            self.titleLabel?.font = UIFont.systemFont(ofSize: fontSize, weight: systemWeight)
            print("⚠️ Font '\(fontName)' not found. Using system font instead.")
        }
    }
}

struct FontSize {
    static let header: CGFloat = 16
    static let title: CGFloat = 14
    static let body: CGFloat = 12
}

