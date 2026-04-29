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
    @IBOutlet weak var studentMessageView: UIView!
    @IBOutlet weak var staffMessageView: UIViewX!
    @IBOutlet weak var StudentNameLbl: UILabel!
    @IBOutlet weak var studentMessageLbl: UILabel!
    @IBOutlet weak var studentMsgDateLbl: UILabel!
    @IBOutlet weak var OptionsPopupView: UIView!
    @IBOutlet weak var replyBtn: UIButton!
    @IBOutlet weak var blockbtn: UIButton!
    @IBOutlet weak var staffMessageStack: UIStackView!
    
    var onReply: (() -> Void)?
    var onBlock: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
        studentMessageView.layer.cornerRadius = 8
        studentMessageView.layer.shadowColor = UIColor.black.cgColor
        studentMessageView.layer.shadowOpacity = 0.5
        studentMessageView.layer.shadowOffset = CGSize(width: 2, height: 2)
        studentMessageView.layer.shadowRadius = 4
        
        staffMessageView.layer.cornerRadius = 8
        staffMessageView.layer.shadowColor = UIColor.black.cgColor
        staffMessageView.layer.shadowOpacity = 0.5
        staffMessageView.layer.shadowOffset = CGSize(width: 2, height: 2)
        staffMessageView.layer.shadowRadius = 4
        
        OptionsPopupView.isHidden = true
        OptionsPopupView.layer.cornerRadius = 8
        OptionsPopupView.layer.shadowColor = UIColor.black.cgColor
        OptionsPopupView.layer.shadowOpacity = 0.5
        OptionsPopupView.layer.shadowOffset = CGSize(width: 2, height: 2)
        OptionsPopupView.layer.shadowRadius = 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func optionsBtnAct(_ sender: Any) {
        
        OptionsPopupView.isHidden.toggle()
    }
    
    
    @IBAction func replyBtnAct(_ sender: Any) {
        onReply?()
    }
    
    @IBAction func blockBtnAct(_ sender: Any) {
        onBlock?()
    }
    
}
