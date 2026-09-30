//
//  AttendanceMenuTableViewCell.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 23/02/23.
//

import UIKit

class AttendanceMenuTableViewCell: UITableViewCell {

    @IBOutlet weak var editStack: UIStackView!
    @IBOutlet weak var statusView: UIView!
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
        editStack.isHidden = true
        statusView.layer.cornerRadius = statusView.frame.height/2
    }
    
    func confic(leaveApi:leaveDataDetails,isSeletcted:Bool?){
        if leaveApi.leavestatus == "WaitingForApproval" && isSeletcted ?? false{
            approvedLabel.textColor = UIColor(named: "ViewLineColor")
            editStack.isHidden = !(isSeletcted ?? true)
        }
        dateLabel.text = leaveApi.createdon
        fromDate.text = leaveApi.leavefromdate
        leaveAppiedType.text = leaveApi.leaveapplicationtype
        let firstText = "No Of Days: "
        let secondText = leaveApi.numofdays ?? ""
        let attributedText = NSMutableAttributedString(string:firstText + secondText)
        attributedText.addAttributes([
            .font: UIFont.systemFont(ofSize: 14, weight: .regular),
            .foregroundColor: UIColor.gray
        ], range: NSRange(
            location: 0,
            length: (firstText as NSString).length
        ))
        attributedText.addAttributes([
            .font: UIFont.systemFont(ofSize: 15, weight: .bold),
            .foregroundColor: UIColor.black
        ], range: NSRange(
            location: (firstText as NSString).length,
            length: (secondText as NSString).length
        ))

        numbOfDays.attributedText = attributedText
        toDateLabel.text = leaveApi.leavetodate
        approvedLabel.text = leaveApi.leavestatus
        reasonLabel.text = leaveApi.leavereason
        
        let color:UIColor!
        switch leaveApi.leavestatus{
        case "Approved":
            color = UIColor(named: "ConfirmColor")
        case "WaitingForApproval":
            color = UIColor(named: "ViewLineColor")
        default:
            color = UIColor(named: "CountColor")
        }
        approvedLabel.textColor = color
        statusView.backgroundColor = color.withAlphaComponent(0.12)
        statusView.layer.borderColor = color.cgColor
        statusView.layer.borderWidth = 1
    }
}
