//
//  AttendanceDetailsTVTableViewCell.swift
//  Vs_GradItCollege
//
//  Created by admin on 19/02/24.
//

import UIKit

class AttendanceDetailsTVTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var persentageLbl: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var subjectNamLbl: UILabel!
    
    @IBOutlet weak var staffNameLbl: UILabel!
    
    @IBOutlet weak var absentHourLbl: UILabel!
    
    @IBOutlet weak var AttendanceHourLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
