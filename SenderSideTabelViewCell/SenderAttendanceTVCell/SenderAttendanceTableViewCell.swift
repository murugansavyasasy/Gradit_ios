//
//  SenderAttendanceTableViewCell.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 27/02/23.
//

import UIKit

class SenderAttendanceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var leaveTypeLbl: UILabel!
    
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var numbOfDays: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    
    @IBOutlet weak var studentNameLabel: UILabel!
    @IBOutlet weak var leaveAppiedType: UILabel!
    
    @IBOutlet weak var approvedLabel: UILabel!
    
    @IBOutlet weak var rejectView: UIViewX!
    
    @IBOutlet weak var leaveReasonLabel: UILabel!
    @IBOutlet weak var CourseLabel: UILabel!
    @IBOutlet weak var fromDate: UILabel!
    
    @IBOutlet weak var approvelView: UIViewX!
    
    @IBOutlet weak var toDateLabel: UILabel!
    
    @IBOutlet weak var sectionLabel: UILabel!
    
    @IBOutlet weak var yearLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
