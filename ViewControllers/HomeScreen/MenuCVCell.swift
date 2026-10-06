//
//  MenuCVCell.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 05/08/26.
//

import UIKit

class MenuCVCell: UICollectionViewCell {

    @IBOutlet weak var imageBaseView: UIView!
    @IBOutlet weak var iconImageview: UIImageView!
    @IBOutlet weak var menuNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageBaseView.layer.cornerRadius = imageBaseView.frame.height/2
        imageBaseView.layer.borderWidth = 1.5
        let color: UIColor = .priorityColor.withAlphaComponent(0.1)
        imageBaseView.layer.borderColor = color.cgColor
        
//        imageBaseView.layer.cornerRadius = imageBaseView.frame.height/2
//        imageBaseView.layer.shadowColor = UIColor.black.cgColor
//        imageBaseView.layer.shadowOpacity = 0.15
//        imageBaseView.layer.shadowRadius = 4
//        imageBaseView.layer.shadowOffset = CGSize(width: 0, height: 2)
    }

}
