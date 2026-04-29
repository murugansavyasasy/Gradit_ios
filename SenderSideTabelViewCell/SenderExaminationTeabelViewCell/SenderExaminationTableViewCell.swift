//
//  SenderExaminationTableViewCell.swift
//  GraditSenderExaminationMenu
//
//  Created by MACBOOKPRO on 03/12/22.
//

import UIKit

class SenderExaminationTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var arrowImageVIew: UIImageView!
    @IBOutlet weak var editView: UIViewX!
    
    @IBOutlet weak var endDate: UILabel!
    
    @IBOutlet weak var sendByView: UIViewX!
    @IBOutlet weak var endDefaultLabel: UILabel!
    @IBOutlet weak var startDate: UILabel!
    
    @IBOutlet weak var startDfaultLabel: UILabel!
    
    
    @IBOutlet weak var cellExamDate: UILabel!
    
    @IBOutlet weak var cellExamName: UILabel!
    
    
    
    @IBOutlet weak var syllabusColonLabel: UILabel!
    
    
    
    @IBOutlet weak var deleteView: UIViewX!
    
    @IBOutlet weak var VenuColonLabel: UILabel!
    
    @IBOutlet weak var nextView: UIViewX!
    @IBOutlet weak var cellSendByLabel: UILabel!
    
    @IBOutlet weak var editDeleteStack: UIStackView!
    @IBOutlet weak var StartDateStack: UIStackView!
    @IBOutlet weak var endDateStack: UIStackView!
    @IBOutlet weak var SendByStack: UIStackView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        startDate.isHidden = true
        
        endDate.isHidden = true
        VenuColonLabel.isHidden = true
        cellSendByLabel.isHidden = true
        startDfaultLabel.isHidden = true
        deleteView.isHidden = true
        editView.isHidden = true
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
