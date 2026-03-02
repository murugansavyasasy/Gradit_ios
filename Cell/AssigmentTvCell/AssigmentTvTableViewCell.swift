//
//  AssigmentTvTableViewCell.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 18/02/23.
//

import UIKit

class AssigmentTvTableViewCell: UITableViewCell {

    @IBOutlet weak var sendByLbl: UILabel!
    @IBOutlet weak var topicLblHeight: NSLayoutConstraint!
    @IBOutlet weak var ReadDotImageView: UIImageView!
    
    @IBOutlet weak var subDateView: UIViewX!
    
    @IBOutlet weak var submissiondefaultLbl: UILabel!
    @IBOutlet weak var attachFileLabel: UILabel!
    @IBOutlet weak var cellArrowImage: UIImageView!
    @IBOutlet weak var topicLabel: UILabel!
    
    @IBOutlet weak var plusOneView: UIViewX!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var plusoneLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    
    @IBOutlet weak var submitionView: UIViewX!
    
    @IBOutlet weak var prevSubmissionView: UIViewX!
    @IBOutlet weak var attchmentView: UIViewX!
    @IBOutlet weak var submitionDateLabel: UILabel!
    
    @IBOutlet weak var dotHeight: NSLayoutConstraint!
    @IBOutlet weak var creatonLabel: UILabel!
    
    @IBOutlet weak var PreviousSubmissionHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        topicLabel.isHidden = false
   
//
//        plusOneView.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
