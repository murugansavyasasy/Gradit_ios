//
//  SenderAttendanceTableViewCell.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 27/02/23.
//

import UIKit

class SenderAttendanceTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var leaveStatusBaseview: UIView!
    @IBOutlet weak var cellview: UIView!
    @IBOutlet weak var leaveTypeLbl: UILabel!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var numbOfDays: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    
    @IBOutlet weak var studentNameLabel: UILabel!
    @IBOutlet weak var approvedLabel: UILabel!
    
    @IBOutlet weak var rejectView: UIViewX!
    
    @IBOutlet weak var leaveReasonLabel: UILabel!
    @IBOutlet weak var CourseLabel: UILabel!
    @IBOutlet weak var fromDate: UILabel!
    
    @IBOutlet weak var approvelView: UIViewX!
    
    @IBOutlet weak var toDateLabel: UILabel!
    
    @IBOutlet weak var sectionLabel: UILabel!
    
    @IBOutlet weak var yearLabel: UILabel!
    
    @IBOutlet weak var fromDateView: UIView!
    @IBOutlet weak var toDateView: UIView!
    @IBOutlet weak var reasonStack: UIStackView!
    @IBOutlet weak var approveRejectStack: UIStackView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellview.layer.cornerRadius = 10
        cellview.layer.shadowColor = UIColor.black.cgColor
        cellview.layer.shadowOpacity = 0.5
        cellview.layer.shadowOffset = .init(width: 0.5, height: 1.5)
        cellview.layer.shadowRadius = 3
        cellview.layer.borderWidth = 0.3
        cellview.layer.borderColor = UIColor.systemGray5.cgColor
        
        fromDateView.layer.cornerRadius = 8
        fromDateView.layer.borderWidth = 0.3
        fromDateView.layer.borderColor = UIColor.systemBlue.withAlphaComponent(0.1).cgColor
        fromDateView.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.15)
        
        toDateView.layer.cornerRadius = 8
        toDateView.layer.borderWidth = 0.5
        toDateView.layer.borderColor = UIColor.systemBlue.withAlphaComponent(0.1).cgColor
        toDateView.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.15)
        
        leaveStatusBaseview.layer.borderWidth = 1.5
        leaveStatusBaseview.layer.cornerRadius = 17
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
