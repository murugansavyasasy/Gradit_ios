//
//  AcademicCvcell.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 04/07/25.
//

import UIKit

class AcademicCvcell: UICollectionViewCell {

    @IBOutlet weak var ClassLbl: UILabel!
    @IBOutlet weak var MarkBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ClassLbl.setFont(style: .regular, size: FontSize.body)
        MarkBtn.setTitleFont(style: .semibold, size: FontSize.body)
        
        MarkBtn.layer.cornerRadius = 8
    }
    
    func configure(with percentageString: String) {
          // MarkBtn.setTitle(percentageString, for: .normal)

        guard let percentage = Double(percentageString) else {
            MarkBtn.backgroundColor = .clear
            MarkBtn.titleLabel?.textColor = .black
                return
            }

            // Color based on percentage
            switch percentage {
            case 0..<30:
                MarkBtn.backgroundColor = .systemRed
            case 30..<70:
                MarkBtn.backgroundColor = .systemOrange
            case 70...100:
                MarkBtn.backgroundColor = .systemGreen
            default:
                MarkBtn.backgroundColor = .clear
                MarkBtn.titleLabel?.textColor = .black
            }
        }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
            setNeedsLayout()
            layoutIfNeeded()
            
            let size = contentView.systemLayoutSizeFitting(
                layoutAttributes.size,
                withHorizontalFittingPriority: .required,
                verticalFittingPriority: .fittingSizeLevel
            )
            var newFrame = layoutAttributes.frame
            newFrame.size.height = size.height
            layoutAttributes.frame = newFrame
            return layoutAttributes
        }
}
