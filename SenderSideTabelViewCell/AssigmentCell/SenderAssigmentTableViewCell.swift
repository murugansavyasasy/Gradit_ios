//
//  SenderAssigmentTableViewCell.swift
//  GraditSenderAssigment
//
//  Created by MACBOOKPRO on 01/12/22.
//

import UIKit

class SenderAssigmentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var submutionDateFullView: UIViewX!
    @IBOutlet weak var submissionDefaultlbl: UILabel!
    @IBOutlet weak var notSubLBL: UILabel!
    @IBOutlet weak var sentByDefaultLbl: UILabel!
    
    @IBOutlet weak var attachImg: UIImageView!
    @IBOutlet weak var subLblView: UIViewX!
    @IBOutlet weak var sendByWidth: NSLayoutConstraint!
    @IBOutlet weak var forwardLeadings: NSLayoutConstraint!
    
    @IBOutlet weak var notSubmittedView: UIViewX!
    @IBOutlet weak var notSubmited: UIViewX!
    @IBOutlet weak var sndByview: UIViewX!
    @IBOutlet weak var submisonDfaltLbl: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var deleteLeading: NSLayoutConstraint!
    
    @IBOutlet weak var FileNamelabel: UILabel!
    
    @IBOutlet weak var plusOneCountLabel: UILabel!
    
    @IBOutlet weak var submissionView: UIViewX!
    @IBOutlet weak var forwardView: UIViewX!
    
    @IBOutlet weak var deleteView: UIViewX!
    
    @IBOutlet weak var PlusOneView: UIViewX!
    
    @IBOutlet weak var readDotImageView: UIImageView!
    @IBOutlet weak var topicLabel: UILabel!
    
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    @IBOutlet weak var submitionDateLabel: UILabel!
    
    
    @IBOutlet weak var dateTimeLabel: UILabel!
    
    @IBOutlet weak var cellArrowImage: UIImageView!
    
    @IBOutlet weak var creatonLabel: UILabel!
    
    
    
    @IBOutlet weak var AttchmentView: UIViewX!
    @IBOutlet weak var SubmissonHorizontalStack: UIStackView!
    
    @IBOutlet weak var SubmissonHorizontalStackHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        readDotImageView.isHidden = true
        
//        deleteView.isHidden = true
        
        forwardView.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
