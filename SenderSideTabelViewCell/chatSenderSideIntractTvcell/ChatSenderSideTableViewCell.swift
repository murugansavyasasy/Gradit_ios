//
//  ChatSenderSideTableViewCell.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 17/04/23.
//

import UIKit

class ChatSenderSideTableViewCell: UITableViewCell {


   
    @IBOutlet weak var dateLabless: UILabel!
    @IBOutlet weak var changeReplyLabl: UILabel!
    @IBOutlet weak var replyLabel: UILabel!
    @IBOutlet weak var blockLabelName: UILabel!
    @IBOutlet weak var ReplyDaysAgoLabl: UILabel!
    
    
    
    @IBOutlet weak var DotLeading: NSLayoutConstraint!
    @IBOutlet weak var dotSelView: UIView!

    
    @IBOutlet weak var alredyLabl: UILabel!
    @IBOutlet weak var rplyStudentLabl: UILabel!
    
    
    @IBOutlet weak var ReplySideView: UIViewX!
    

    @IBOutlet weak var blockStudView: UIView!

    

    @IBOutlet weak var replyView: UIView!

    

    @IBOutlet weak var dotSelectView: UIView!

    @IBOutlet weak var dateLbl: UILabel!

    @IBOutlet weak var studNameLbl: UILabel!

    

    

    

    @IBOutlet weak var questionLbl: UILabel!

    

    

    override func awakeFromNib() {

        super.awakeFromNib()

        

        dotSelView.isHidden = true
        
        ReplySideView.isHidden = true

        // Initialization code

    }



    override func setSelected(_ selected: Bool, animated: Bool) {

        super.setSelected(selected, animated: animated)



        // Configure the view for the selected state

    }

    

}
