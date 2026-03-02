//
//  TextMessageTableViewCell.swift
//  Vs_GradItCollege
//
//  Created by admin on 11/02/24.
//

import UIKit

class TextMessageTableViewCell: UITableViewCell {

    @IBOutlet weak var TextImgView: UIImageView!
    
    @IBOutlet weak var sendByView: UIViewX!
    @IBOutlet weak var arrowImage: UIImageView!
    @IBOutlet weak var redDotImgView: UIImageView!
    
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var MsgContentLbl: UILabel!
    
    @IBOutlet weak var SendByLbl: UILabel!
    
    @IBOutlet weak var discreptionsLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
