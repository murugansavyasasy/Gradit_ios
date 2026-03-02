//
//  AttendanceDetailsViewController.swift
//  Vs_GradItCollege
//
//  Created by admin on 19/02/24.
//

import UIKit
import ObjectMapper

class AttendanceDetailsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {




@IBOutlet weak var subjectLbl: UILabel!



@IBOutlet weak var staffLbl: UILabel!


@IBOutlet weak var tv: UITableView!


var adttendaceDetailData : [attendanceDataDetails] = []
var subjectId : Int!
var StaffId : Int!

var priority : String!
var userId : String!
var identifers = "AttendDetailTableViewCell"

var staffName : String!
var SubjctName : String!
override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    
    
    let defaults =  UserDefaults.standard
    
    
    
    priority = defaults.string(forKey:DefaultsKeys.priority)
    userId = defaults.string(forKey:DefaultsKeys.memberid)
    let rownib = UINib(nibName: identifers, bundle: nil)
    tv.register(rownib, forCellReuseIdentifier: identifers)
    
    staffLbl.text = staffName
    subjectLbl.text = SubjctName
    
    AttendanceDetails()
}

@IBAction func bckBtn(_ sender: Any) {
    
    dismiss(animated: true)
    
}





func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    adttendaceDetailData.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let  cell = tableView.dequeueReusableCell(withIdentifier: identifers, for: indexPath) as!
    
    AttendDetailTableViewCell
    
    
    let attend  : attendanceDataDetails  = adttendaceDetailData[indexPath.row]
    
    cell.SNNumberLbl.text = String(indexPath.row+1)
    cell.DateLbl.text = attend.attended_date
    cell.attendanceHoursLbl.text = String(attend.attended_hour_no)
    cell.attendanceabstHorslbl.text = String(attend.absent_hour_no)
    
    return cell
}

func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 50
}
func AttendanceDetails(){
    
    
    let AttendaceDetails = attenanceDetailsModal()
    
    AttendaceDetails.appid = 2
    AttendaceDetails.priority = priority
    AttendaceDetails.staffid = String(StaffId)
    AttendaceDetails.subjectid = subjectId
    AttendaceDetails.userid = Int(userId)
    
    
    
    let attendancestr = AttendaceDetails.toJSONString()
    print("attendancestr \(attendancestr)")
    
    attendanceDetalReq.call_request(param: attendancestr!){ [self]
        
        (res) in
        
        
        
        let attendances : attendanceDetailResponce = Mapper<attendanceDetailResponce>().map(JSONString: res)!
        
        
        if attendances.Status == 1 {
            
            
            adttendaceDetailData = attendances.data
            
            tv.dataSource = self
            tv.delegate = self
            tv.reloadData()
        }
        
        else{
            
            
            
        }
        
    }
}


}
