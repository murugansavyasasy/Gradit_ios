//
//  AttendanceMenuTableViewCell.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 23/02/23.
//

import UIKit

class AttendanceMenuTableViewCell: UITableViewCell {

    
    @IBOutlet weak var deleteView: UIViewX!
    
    @IBOutlet weak var EditView: UIViewX!
    @IBOutlet weak var reasonLabel: UILabel!
    @IBOutlet weak var numbOfDays: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    
    @IBOutlet weak var leaveAppiedType: UILabel!
    
    @IBOutlet weak var approvedLabel: UILabel!
    
    
    @IBOutlet weak var fromDate: UILabel!
    
    
    @IBOutlet weak var toDateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
