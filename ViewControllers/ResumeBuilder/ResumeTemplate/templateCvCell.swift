//
//  templateCvCell.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 30/05/25.
//

import UIKit

class templateCvCell: UICollectionViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var TitleLbl: UILabel!
    @IBOutlet weak var TemplateImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        TitleLbl.setFont(style: .medium, size: 14)
        TemplateImage.layer.cornerRadius = 12
        TemplateImage.layer.borderWidth = 1
        TemplateImage.layer.borderColor = UIColor.systemGray.cgColor
    }

}
