//
//  ImageScrollCollectionViewCell.swift
//  Vs_GradIt
//
//  Created by APPLE on 26/09/22.
//

import UIKit

class ImageScrollCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var attachementView: UIView!
    @IBOutlet weak var dateLbl: UILabel!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var timeLbl: UILabel!
    
    
    @IBOutlet weak var descLbl: UILabel!
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
