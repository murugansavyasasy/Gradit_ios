//
//  SenderAssigmentTableViewCell.swift
//  GraditSenderAssigment
//
//  Created by MACBOOKPRO on 01/12/22.
//

import UIKit

class SenderAssigmentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var notSubLBL: UILabel!
    @IBOutlet weak var sentByDefaultLbl: UILabel!
    @IBOutlet weak var notSubmittedView: UIViewX!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var plusOneCountLabel: UILabel!
    @IBOutlet weak var submissionView: UIViewX!
    @IBOutlet weak var forwardView: UIViewX!
    @IBOutlet weak var PlusOneView: UIViewX!
    @IBOutlet weak var readDotImageView: UIImageView!
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var cellArrowImage: UIImageView!
    @IBOutlet weak var creatonLabel: UILabel!
    @IBOutlet weak var AttchmentView: UIViewX!
    @IBOutlet weak var SubmissonHorizontalStack: UIStackView!
    @IBOutlet weak var detailsStack: UIStackView!
    @IBOutlet weak var attachmentStack: UIStackView!
    @IBOutlet weak var dueDateBtn: UIButton!
    @IBOutlet weak var submissionCountLbl: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        forwardView.layer.cornerRadius = forwardView.frame.height/2
        
        submissionView.layer.cornerRadius = 15
        submissionView.borderColor = .systemGreen
        submissionView.borderWidth = 1
        submissionView.backgroundColor = .systemGreen.withAlphaComponent(0.1)
        
        notSubmittedView.layer.cornerRadius = 15
        notSubmittedView.borderColor = .systemRed
        notSubmittedView.borderWidth = 1
        notSubmittedView.backgroundColor = .systemRed.withAlphaComponent(0.1)
        
        readDotImageView.isHidden = true
        forwardView.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
