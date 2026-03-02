//
//  SpecifyStudentTableViewCell.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 14/03/23.
//

import UIKit

class SpecifyStudentTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var selectedViewAttendance: UIView!
    @IBOutlet weak var imageViewAttendance: UIImageView!
    @IBOutlet weak var SpecifyStudentChck: CheckBoxTwo!
    @IBOutlet weak var StudentLabel: UILabel!
    @IBOutlet weak var RollNoLbl: UILabel!
    @IBOutlet weak var StackView: UIStackView!
    @IBOutlet weak var AttenanceLetterView: UIView!
    @IBOutlet weak var AttendanceAlphabet: UILabel!
    @IBOutlet weak var Switch: UISwitch!
    @IBOutlet weak var onDutyView: UIView!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var onLeaveView: UIView!
    @IBOutlet weak var onLeaveSwitch: UISwitch!
    @IBOutlet weak var separatorView2: UIView!
    @IBOutlet weak var admissionNoLbl: UILabel!
    
    
    var onAttendanceTap: (() -> Void)?
    var onDutyTap: (() -> Void)?
    var onLeaveTap: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        AttenanceLetterView.layer.cornerRadius = AttenanceLetterView.frame.width / 2
        Switch.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        onLeaveSwitch.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        
//        selectedViewAttendance.layer.cornerRadius = 10
//        selectedViewAttendance.layer.shadowColor = UIColor.black.cgColor
//        selectedViewAttendance.layer.shadowOpacity = 0.2
//        selectedViewAttendance.layer.shadowOffset = CGSize(width: 0, height: 2)
//        selectedViewAttendance.layer.shadowRadius = 2
//        selectedViewAttendance.layer.masksToBounds = false
        
        let attendanceTap = UITapGestureRecognizer(target: self, action: #selector(handleAttendanceTap))
        selectedViewAttendance.isUserInteractionEnabled = true
        selectedViewAttendance.addGestureRecognizer(attendanceTap)
        
        let dutyTap = UITapGestureRecognizer(target: self, action: #selector(handleDutyTap))
        onDutyView.isUserInteractionEnabled = true
        onDutyView.addGestureRecognizer(dutyTap)
        
        let LeaveTap = UITapGestureRecognizer(target: self, action: #selector(handleLeaveTap))
        onLeaveView.isUserInteractionEnabled = true
        onLeaveView.addGestureRecognizer(LeaveTap)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @objc private func handleAttendanceTap() {
        onAttendanceTap?()
    }
    
    @objc private func handleDutyTap() {
        onDutyTap?()
    }
    
    @objc private func handleLeaveTap() {
        onLeaveTap?()
    }
}
