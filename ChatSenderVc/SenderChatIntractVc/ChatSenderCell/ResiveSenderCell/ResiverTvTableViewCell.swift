//
//  ResiverTvTableViewCell.swift
//  Vs_GradItCollege
//
//  Created by admin on 04/04/24.
//

import UIKit

class ResiverTvTableViewCell: UITableViewCell {

    @IBOutlet weak var blockLabelName: UILabel!
    @IBOutlet weak var changeReplyLabl: UILabel!
    @IBOutlet weak var dotSelectView: UIView!
    @IBOutlet weak var blockStudView: UIView!
    @IBOutlet weak var replyView: UIView!
    @IBOutlet weak var dotSelView: UIViewX!
    @IBOutlet weak var timeAndDateLbl: UILabel!
    @IBOutlet weak var messageContentLbl: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
//    replyView
//    blockStudView
//    dotSelectView
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        dotSelView.isHidden = true
        
//        ReplySideView.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
