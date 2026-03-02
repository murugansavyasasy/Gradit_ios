//
//  HomeScreenLeaveRequestTableViewCell.swift
//  Vs_GradItCollege
//
//  Created by Apple on 25/04/23.
//

import UIKit
import ObjectMapper

class HomeScreenLeaveRequestTableViewCell: UITableViewCell {
    
    
    
    
    
    @IBOutlet weak var OverAllView: UIViewX!
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var lineViewssss: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var numberOfDaysLbl: UILabel!
    
    @IBOutlet weak var fromLbl: UILabel!
    
    @IBOutlet weak var toLbl: UILabel!
    
    @IBOutlet weak var departmentnameLbl: UILabel!
    @IBOutlet weak var coursenameLbl: UILabel!
    
    
    @IBOutlet weak var approvalView: UIViewX!
    
    @IBOutlet weak var rejectView: UIViewX!
    @IBOutlet weak var noRecordsFoundLabl: UILabel!
    @IBOutlet weak var reasonLabel: UILabel!
    @IBOutlet weak var leaveStatusLabel: UILabel!
    
    @IBOutlet weak var line2: UILabel!
    @IBOutlet weak var line1: UILabel!
    @IBOutlet weak var sectionnameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
//        rejectView.isHidden = true
//        approvalView.isHidden = true
        
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
    
 
