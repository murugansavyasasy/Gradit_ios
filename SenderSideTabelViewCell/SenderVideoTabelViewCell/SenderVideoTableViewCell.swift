//
//  SenderVideoTableViewCell.swift
//  GraditSenderVideoMenu
//
//  Created by MACBOOKPRO on 04/12/22.
//

import UIKit

class SenderVideoTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLableCell: UILabel!
    
    
    @IBOutlet weak var redDotImageView: UIImageView!
    @IBOutlet weak var sendView: UIViewX!
    @IBOutlet weak var playView: UIViewX!
    @IBOutlet weak var descriptionLableCell: UILabel!
    
    @IBOutlet weak var downArrowImage: UIImageView!
    
    @IBOutlet weak var sentByLableCell: UILabel!
    @IBOutlet weak var dateTimeLabelCell: UILabel!
    
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        descriptionLableCell.isHidden = true
    
        redDotImageView.isHidden = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}
