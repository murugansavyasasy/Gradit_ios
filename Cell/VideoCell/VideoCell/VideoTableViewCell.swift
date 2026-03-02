//
//  VideoTableViewCell.swift
//  VideoGradit
//
//  Created by MACBOOKPRO on 23/10/22.
//

import UIKit

class VideoTableViewCell: UITableViewCell {

    
    @IBOutlet weak var redDotImageView: UIImageView!
    
    @IBOutlet weak var titleLableCell: UILabel!
    
    
    @IBOutlet weak var sendbyWidth: NSLayoutConstraint!
    @IBOutlet weak var sendByview: UIViewX!
    @IBOutlet weak var downArrowImage: UIImageView!
    
    @IBOutlet weak var sentByLableCell: UILabel!
    
    @IBOutlet weak var dateTimeLabelCell: UILabel!
    
    @IBOutlet weak var descriptionLableCell: UILabel!
    
   
    
    @IBOutlet weak var playView: UIViewX!
    
    
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        descriptionLableCell.isHidden = true
    
        redDotImageView.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
  
}
