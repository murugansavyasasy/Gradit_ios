//
//  AttendDetailTableViewCell.swift
//  Vs_GradItCollege
//
//  Created by admin on 19/02/24.
//

import UIKit

class AttendDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var attendanceabstHorslbl: UILabel!
    @IBOutlet weak var attendanceHoursLbl: UILabel!
    @IBOutlet weak var DateLbl: UILabel!
    @IBOutlet weak var SNNumberLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
