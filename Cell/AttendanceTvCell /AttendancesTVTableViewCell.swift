//
//  AttendancesTVTableViewCell.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 02/04/23.
//

import UIKit

class AttendancesTVTableViewCell: UITableViewCell {


@IBOutlet weak var persentageLbl: UILabel!
@IBOutlet weak var progressView: UIProgressView!
@IBOutlet weak var subjectNamLbl: UILabel!

@IBOutlet weak var gifArrowImage: UIImageView!
@IBOutlet weak var staffNameLbl: UILabel!

@IBOutlet weak var progressbarHeight: NSLayoutConstraint!
@IBOutlet weak var absentHourLbl: UILabel!

@IBOutlet weak var AttendanceHourLbl: UILabel!

@IBOutlet weak var persentageLblBottom: NSLayoutConstraint!

var isRed = false
var progressBarTimer : String!
var isRunning = false
override func awakeFromNib() {
    super.awakeFromNib()
    
    
    
    
    
}

override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    
}









}
