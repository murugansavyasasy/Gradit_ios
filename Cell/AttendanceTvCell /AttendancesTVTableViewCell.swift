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
    
    var isRed = false
    var progressBarTimer : String!
    var isRunning = false
    override func awakeFromNib() {
        super.awakeFromNib()
        progressbarHeight.constant = 10
    }
    func confic(attendance:attendanceAbesentDataDetails){
        
        AttendanceHourLbl.text = attendance.attended_hour
        absentHourLbl.text = attendance.absent_hour
        staffNameLbl.text = "Staff Name: \(attendance.staff_name ?? "")"
        subjectNamLbl.text = attendance.subjectname ?? ""
        progressView.isHidden = attendance.total_hour == 0
        persentageLbl.isHidden = attendance.total_hour == 0
        progressView.layer.cornerRadius = progressView.frame.height/2
        progressView.clipsToBounds = true
        progressView.progress  = Float(attendance.percentage ?? "")!/Float(100)
        persentageLbl.text = " Attendance Percentage  :  " +  " "+String(attendance.percentage ?? "") + " % "
    }
}
