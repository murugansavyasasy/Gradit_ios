//
//  AttandanceTableViewCell.swift
//  Vs_GradItCollege
//
//  Created by APPLE on 01/11/22.
//

import UIKit
import ObjectMapper

class AttandanceTableViewCell: UITableViewCell,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var viewAllClick: UIViewX!
    @IBOutlet weak var tv: UITableView!
    @IBOutlet weak var sideIndecator: UILabel!
    
    var identifer = "AttandanceTableCell"
    var attend : [AttendanceDashType] = []
    var dash : [DashBoardData] = []
    var dashtypes : String!
    var colgId : String!
    var memberId : String!
    var loginAsType : String!
    var priority : String!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let defaults = UserDefaults.standard
        colgId = defaults.string(forKey: DefaultsKeys.collegeid)
        memberId = defaults.string(forKey: DefaultsKeys.memberid)
        loginAsType = defaults.string(forKey: DefaultsKeys.loginAsType)
        priority = defaults.string(forKey: DefaultsKeys.priority)
        tv.dataSource  = self
        tv.delegate = self
        let rowNib = UINib(nibName: identifer, bundle: nil)
        tv.register(rowNib, forCellReuseIdentifier: identifer)
        sideIndecator.clipsToBounds = true
        sideIndecator.layer.cornerRadius = sideIndecator.frame.width/2
        viewAllClick.layer.borderColor = UIColor.tintColor.withAlphaComponent(0.13).cgColor
        viewAllClick.layer.borderWidth = 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return attend.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifer, for: indexPath) as!
        AttandanceTableCell
        
        
        cell.selectionStyle = .none
        let atte : AttendanceDashType = attend[indexPath.row]
        cell.subjectNamLbl.text =  atte.subjectname

        if  atte.message != nil{
//            cell.notYetLabel.text = atte.message
            cell.overAllCellView.isHidden = true
        }else{
            cell.overAllCellView.isHidden = false
            cell.dateLabel.text = atte.attendancedate?.dateFormater()
            cell.messageLabel.text = atte.attendancetype
            if  atte.attendancetype == "Present"{
                cell.presentView.isHidden = false
                cell.presentView.backgroundColor = UIColor(named: "ConfirmColor")
//                cell.notYetLabel.isHidden = true
                cell.dateView.isHidden = false
                cell.messageLabel.text = atte.attendancetype
            }else if  atte.attendancetype == "Absent"{
                cell.presentView.isHidden = false
                cell.presentView.backgroundColor = UIColor.red
//                cell.notYetLabel.isHidden = true
                cell.dateView.isHidden = false
                cell.messageLabel.text = atte.attendancetype
            }
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
