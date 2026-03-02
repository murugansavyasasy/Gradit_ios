//
//  attendanceSubjectTableViewCell.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 04/04/23.
//

import UIKit

class attendanceSubjectTableViewCell: UITableViewCell {

    
    
    
    @IBOutlet weak var takeAttendanceView: UIViewX!
    @IBOutlet weak var departmentLabel: UILabel!
    
    
    @IBOutlet weak var sectionLabel: UILabel!
    
    
    @IBOutlet weak var editAttendanceView: UIViewX!
    @IBOutlet weak var yearLabel: UILabel!
    
    
    @IBOutlet weak var semLabel: UILabel!
    
    @IBOutlet weak var classTeacherLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
