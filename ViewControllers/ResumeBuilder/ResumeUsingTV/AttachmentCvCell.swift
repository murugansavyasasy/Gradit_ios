//
//  AttachmentCvCell.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 24/12/25.
//

import UIKit

class AttachmentCvCell: UICollectionViewCell {

    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var fileNameLbl: UILabel!
    @IBOutlet weak var fileIconBtn: UIButton!
    @IBOutlet weak var fileTypeSizeLbl: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    
    var onRemove: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        fileIconBtn.layer.cornerRadius = 8
        outerView.layer.cornerRadius = 8
        outerView.layer.borderWidth = 0.3
        outerView.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        outerView.backgroundColor = UIColor.systemGray6
        fileTypeSizeLbl.isHidden = true
//        deleteBtn.layer.cornerRadius = deleteBtn.frame.width/2
//        deleteBtn.layer.borderWidth = 1
//        deleteBtn.layer.borderColor = UIColor.red.cgColor
    }

    @IBAction func deleteBtn(_ sender: UIButton) {
        onRemove?()
    }
    
}
