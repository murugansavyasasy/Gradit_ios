//
//  ChatSenderTvTableViewCell.swift
//  Vs_GradItCollege
//
//  Created by admin on 04/04/24.
//

import UIKit

class ChatSenderTvTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var ansLbl: UILabel!
    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var studentName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
