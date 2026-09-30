//
//  VideoTableViewCell.swift
//  VideoGradit
//
//  Created by MACBOOKPRO on 23/10/22.
//

import UIKit

class VideoTableViewCell: UITableViewCell {

    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var redDotImageView: UIImageView!
    @IBOutlet weak var titleLableCell: UILabel!
    @IBOutlet weak var sendByview: UIViewX!
    @IBOutlet weak var downArrowImage: UIImageView!
    @IBOutlet weak var sentByLableCell: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descriptionLableCell: UILabel!
    @IBOutlet weak var playView: UIViewX!
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellView.layer.cornerRadius = 10
        cellView.layer.shadowColor = UIColor.black.cgColor
        cellView.layer.shadowOffset = CGSize(width: 0.3, height: 1)
        cellView.layer.shadowRadius = 2
        cellView.layer.shadowOpacity = 0.2
        cellView.layer.borderColor = UIColor.systemGray5.cgColor
        cellView.layer.borderWidth = 0.3
        
        descriptionLableCell.isHidden = true
        redDotImageView.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
  
}
