//
//  SoftSkillCV.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 11/07/25.
//

import UIKit

class SoftSkillCV: UICollectionViewCell {

    @IBOutlet weak var CellView: UIView!
    @IBOutlet weak var OptionBtn: UIButton!
    
    var isSelectedItem = false
    var onSelectionChanged: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        OptionBtn.titleLabel?.numberOfLines = 0  // Allow unlimited lines
        OptionBtn.titleLabel?.lineBreakMode = .byWordWrapping
        OptionBtn.setTitleFont(style: .medium, size: FontSize.title)
    }

    func configure(skill: String, isSelected: Bool) {
            OptionBtn.setTitle(skill, for: .normal)
        if isSelected{
            OptionBtn.imageView?.image = UIImage(systemName: "checkmark.square")
            OptionBtn.tintColor = UIColor(named: "IndigoColour")
        }else {
            
            OptionBtn.imageView?.image = UIImage(systemName: "square")
            OptionBtn.tintColor = .systemGray4
        }
        }
    
    func configure2(title: String, isSelected: Bool) {
           OptionBtn.setTitle(title, for: .normal)
            isSelectedItem = isSelected
            updateAppearance()
        }
    
    func configure3(title: String, date: String, isSelected: Bool) {
        let titleFont = UIFont(name: "Poppins-SemiBold", size: 14) ?? UIFont.systemFont(ofSize: 16, weight: .semibold)
        let dateFont = UIFont(name: "Poppins-Regular", size: 12) ?? UIFont.systemFont(ofSize: 12)

        let fullText = "\(title)\n\(date)"
        let attributedText = NSMutableAttributedString(string: fullText)

        // Apply font to title
        attributedText.addAttribute(.font, value: titleFont, range: NSRange(location: 0, length: title.count))

        // Apply font to date
        let dateRange = NSRange(location: title.count + 1, length: date.count)
        attributedText.addAttribute(.font, value: dateFont, range: dateRange)
        attributedText.addAttribute(.foregroundColor, value: UIColor.systemGray, range: dateRange)

        OptionBtn.setAttributedTitle(attributedText, for: .normal)

        isSelectedItem = isSelected
        updateAppearance()
    }


        @IBAction func didTapButton(_ sender: UIButton) {
            isSelectedItem.toggle()
            updateAppearance()
            onSelectionChanged?()
        }

        private func updateAppearance() {
            let image = isSelectedItem ? UIImage(systemName: "checkmark.square") : UIImage(systemName: "square")
            OptionBtn.setImage(image, for: .normal)
            OptionBtn.tintColor = isSelectedItem ?  UIColor(named: "IndigoColour") : .systemGray4
        }
}
