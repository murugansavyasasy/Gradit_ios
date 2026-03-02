//
//  NoticeBoardScrollCollectionViewCell.swift
//  Vs_GradIt
//
//  Created by APPLE on 26/09/22.
//

import UIKit

class NoticeBoardScrollCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var headingLbl: UILabel!
    
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    
    
    
    @IBOutlet weak var noticeCvFullv: UIView!
    
    
    @IBOutlet weak var dateLbl: UILabel!
    
    
    @IBOutlet weak var noteImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        
    }

}
