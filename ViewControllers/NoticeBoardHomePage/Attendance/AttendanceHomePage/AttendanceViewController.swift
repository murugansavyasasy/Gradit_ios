//
//  AttendanceViewController.swift
//  GraditAttendance
//
//  Created by MACBOOKPRO on 15/11/22.
//

import UIKit
import WebKit
import FSCalendar
import ObjectMapper
import KRProgressHUD

@available(iOS 16.0, *)
class AttendanceViewController: UIViewController,FSCalendarDataSource, FSCalendarDelegate, UITableViewDelegate,UITableViewDataSource, UIGestureRecognizerDelegate{



@IBOutlet weak var reusee: ReuseView!
@IBOutlet weak var topNameview: UIView!
@IBOutlet weak var tapBarView: UIViewX!
@IBOutlet weak var attendaneLblCount: UILabel!
@IBOutlet weak var redirectLoginView: UIViewX!
@IBOutlet weak var Tv: UITableView!
@IBOutlet weak var logoutView: UIView!
@IBOutlet weak var changeRolesView: UIView!
@IBOutlet weak var profileView: UIView!
@IBOutlet weak var topLabels: UILabel!
@IBOutlet weak var clgLogoImg: UIImageView!
@IBOutlet weak var notificationView: UIView!
@IBOutlet weak var privacyPolicyView: UIView!
@IBOutlet weak var topMemberLabel: UILabel!
@IBOutlet weak var faqView: UIView!
@IBOutlet weak var refreshView: UIView!
@IBOutlet weak var viewTap: UIView!
@IBOutlet weak var sideMenuView: UIView!
@IBOutlet weak var helpView: UIView!
@IBOutlet weak var termsAndConditionView: UIView!
@IBOutlet weak var changePasswordView: UIView!
@IBOutlet weak var swipeMenuHeight: NSLayoutConstraint!
@IBOutlet weak var pluPageView: UIView!
@IBOutlet weak var bigImg: UIImageView!
@IBOutlet weak var segmentName: UISegmentedControl!
@IBOutlet weak var smallImg: UIImageView!
@IBOutlet weak var tvTop: NSLayoutConstraint!
    @IBOutlet weak var noDataLabel: UILabel!
    
var indentifer2 = "AttendancesTVTableViewCell"
var  identifers  = "AttendanceMenuTableViewCell"
let menuIdentifier = "MenuCollectionViewCell"

var MenuRefName :[menuApiDataDetails] = []
var LeaveRefName : [ leaveDataDetails] = []

var addapiRef : [AddDataDeatils] = []

var adttendanceRef : [attendanceAbesentDataDetails] = []
var loginDatas : [datalogin]!
var logindataprinci :[datalogin]!
var isAllowedToLimitFutureDates = true

var maxValidFutureDateAsString : String!
//
var calendar: FSCalendar!

var calendarHeightConstraint: NSLayoutConstraint!
var StatusDetail : Int!
var types = ""
var collegeid : String!
var userid    : String!
var priority   : String!
var sectionId : String!
var departmentId : String!
var imageRef : [String] = []
var loginType : String!

var memberName : String!

var colgImg : String!

var MobileNumber : String!

var appreadId : String!

var datess : String!

var password : String!
var selectedCell:IndexPath?

var is_read_enabled = ""
var is_write_enabled = ""



func maximumDate(for calendar: FSCalendar) -> Date {
    return Date()
}


var PreviousAddId  : Int = 0


var str : [String] = []

var strName : [String] = []

var backGroundAddImageView : String!
var smallImageAddImageView : String!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        PreviousAddId = PreviousAddId+1
        attendaneLblCount.layer.cornerRadius = 13
        attendaneLblCount.layer.masksToBounds = true
        
        overrideUserInterfaceStyle = .light
        
        sideMenuView.isHidden = true
        
        pluPageView.isHidden = true
        
        let defaults =  UserDefaults.standard
        
        collegeid = defaults.string(forKey: DefaultsKeys.collegeid)
        userid = defaults.string(forKey: DefaultsKeys.memberid)
        priority = defaults.string(forKey:DefaultsKeys.priority)
        sectionId = defaults.string(forKey: DefaultsKeys.sectionid)
        departmentId = defaults.string(forKey: DefaultsKeys.deptid)
        loginType = defaults.string(forKey: DefaultsKeys.loginAsType)
        memberName = defaults.string(forKey: DefaultsKeys.memberName)
        colgImg = defaults.string(forKey: DefaultsKeys.colglogo)
        clgLogoImg.sd_setImage(with: URL(string:  colgImg), placeholderImage: UIImage(named: "person.fill"))
        
        topMemberLabel.text = memberName
        
        MobileNumber = defaults.string(forKey: DefaultsKeys.mobileNumber)
        
        password = defaults.string(forKey: DefaultsKeys.Password)
        addApi()
        
        
        if priority == "p1"{
            topLabels.text = "Principal"
            view.backgroundColor = UIColor(named: "Principal" )
            reusee.menuImg.image = UIImage(named: "principalBigMenu")
        } else if priority == "p4"{
            tapBarView.backgroundColor = UIColor(named: "StudentParent" )
            view.backgroundColor = UIColor(named: "studentViewColors")
            reusee.menuImg.image = UIImage(named: "studentSwipeImage")
            topLabels.text = "Student"
        }else if priority == "p2" || priority == "p3"{
            topLabels.text = "Teacher"
            view.backgroundColor = UIColor(named: "Teaching Staff")
            reusee.menuImg.image = UIImage(named: "HodImage")
        }else if priority == "p5"{
            tapBarView.backgroundColor = UIColor(named: "FatherColor" )
            topLabels.text = "Father"
            view.backgroundColor = UIColor(named: "FatherColor")
            reusee.menuImg.image = UIImage(named: "StaffBigMenu")
        }
        
        swipeMenuHeight.constant = 150
        reusee.call_back = { [self]
            (val) in
            
            self.swipeMenuHeight.constant =  reusee.callid
            
            print("AttendanceViewController",reusee.callid)
        }
        
        
        let rownib = UINib(nibName: identifers, bundle: nil)
        Tv.register(rownib, forCellReuseIdentifier: identifers)
        
        let rownib1 = UINib(nibName: indentifer2, bundle: nil)
        Tv.register(rownib1, forCellReuseIdentifier: indentifer2)
        
        Tv.delegate = self
        Tv.dataSource = self
        
        Attendance()
        
        // tap Bar UiTapGuster.
        let loginRediectGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        redirectLoginView.addGestureRecognizer(loginRediectGesture)
        
        let plusPage = UITapGestureRecognizer(target: self, action: #selector(PlusPageVc))
        pluPageView.addGestureRecognizer(plusPage)
        
        let menuGestureHide = UITapGestureRecognizer(target: self, action: #selector(menu))
        viewTap.addGestureRecognizer(menuGestureHide)
        
        let notificationGesture = UITapGestureRecognizer(target: self, action: #selector(notificationVc))
        notificationView.addGestureRecognizer(notificationGesture)
        
        let refreshGesture = UITapGestureRecognizer(target: self, action: #selector(refreshVc))
        refreshView.addGestureRecognizer(refreshGesture)
        
        let faqGesture = UITapGestureRecognizer(target: self, action: #selector(faqRedirect))
        faqView.addGestureRecognizer(faqGesture)
        
        let helpGesture = UITapGestureRecognizer(target: self, action: #selector(helpRedirect))
        helpView.addGestureRecognizer(helpGesture)
        
        let privacyPolicyGesture = UITapGestureRecognizer(target: self, action: #selector(privacyPolicyRedirect))
        privacyPolicyView.addGestureRecognizer(privacyPolicyGesture)
        
        let termsAndConditionGesture = UITapGestureRecognizer(target: self, action: #selector(termsAndCondition))
        termsAndConditionView.addGestureRecognizer(termsAndConditionGesture)
        
        let profileGesture = UITapGestureRecognizer(target: self, action: #selector(profileRedirect))
        profileView.addGestureRecognizer(profileGesture)
        
        let changeRolesGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        changeRolesView.addGestureRecognizer(changeRolesGesture)
        
        let tapvoe = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        topNameview.addGestureRecognizer(tapvoe)
        
        let logoutGesture = UITapGestureRecognizer(target: self, action: #selector(logoutPressed))
        logoutView.addGestureRecognizer(logoutGesture)
        
        let chagePassword = UITapGestureRecognizer(target: self, action: #selector(changePassowrdVC))
        changePasswordView.addGestureRecognizer(chagePassword)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        leaveApi()
    }


@objc func dismissKeyboards() {
    
    sideMenuView.isHidden = true
    view.endEditing(true)
    
}



func leaveApi(){
    
    var  leave = leaveRequestModal()
    
    leave.collegeid = collegeid
    leave.staffid = userid
    
    APiCallManager.shared.callApi(url: APIEndpoints.GetLeaveApplicationListForReceiverApp, httpMethod: .post, queryParam: nil, requestBody: leave) {[weak self] (result:Result<leaveResponce, Error>)  in
        
        guard let self = self else {return}
        
        switch result {
        case .success(let success):
           
            LeaveRefName = success.data ?? []
            noDataLabel.text = success.Message
            if segmentName.selectedSegmentIndex == 1{
                noDataLabel.isHidden = !LeaveRefName.isEmpty
            }
            attendaneLblCount.text = String(LeaveRefName.count)
            Tv.isHidden = false
            Tv.isScrollEnabled = true
            
        case .failure(let Error):
            LeaveRefName =  []
            noDataLabel.text = Error.localizedDescription
            if segmentName.selectedSegmentIndex == 1{
                noDataLabel.isHidden = false
            }
            attendaneLblCount.text = String(LeaveRefName.count)
            Tv.isHidden = false
            Tv.isScrollEnabled = true
            print(Error.localizedDescription)
        }
        Tv.reloadData()
    }
}


@IBAction func PlusPageVc(){
    
    let vc = plusPageViewController(nibName: nil, bundle: nil)
    vc.PreviousAddId = PreviousAddId
    vc.types = "1"
    vc.modalPresentationStyle = .fullScreen
    present(vc, animated: true,completion: nil)
}





@IBAction func segmentActions(_ sender: Any) {
    
    
    
    
    
    if segmentName.selectedSegmentIndex == 0{
        
        let cells = self.Tv.isHidden = true
        Tv.isScrollEnabled = false
        
        Attendance()
        
        pluPageView.isHidden = true
        
        
        
     
    }
    
    
    else {
        
        
        let cells = self.Tv.isHidden = true
        pluPageView.isHidden = false
        
        Tv.isScrollEnabled = false
        leaveApi()
        
        
        
        
        
    }
    
    
    
    
    
    
}


func Attendance() {
    
    var  attendance = attendanceAbesentModal()
    
    attendance.userid = Int(userid)
    attendance.priority = priority
    attendance.appid = 2
    
    APiCallManager.shared.callApi(url: APIEndpoints.GetStudentWiseAttendanceSummary, httpMethod: .post, queryParam: nil, requestBody: attendance) {[weak self] (result:Result<attendanceAbsentResponce,Error>) in
        
        guard let self = self else {return}
        
        switch result {
        case .success(let success):
            adttendanceRef = success.data ?? []
            noDataLabel.text = success.Message
            if segmentName.selectedSegmentIndex == 0 {
                noDataLabel.isHidden = !adttendanceRef.isEmpty
            }
            Tv.isHidden = false
            Tv.isScrollEnabled = true
            Tv.reloadData()
           
        case .failure(let failure):
            print(failure.localizedDescription)
            adttendanceRef = []
            noDataLabel.text = failure.localizedDescription
            if segmentName.selectedSegmentIndex == 0 {
                noDataLabel.isHidden = false
            }
            Tv.isHidden = false
            Tv.isScrollEnabled = true
            Tv.reloadData()
        }
    }
}



func addApi(){
    
    var add = AddApiModal()
    
    let defaults = UserDefaults.standard
    var deviceToken = defaults.string(forKey:DefaultsKeys.DeviceToken )
    add.device_token = deviceToken
    add.member_id = userid
    add.mobile_no = MobileNumber
    add.priority = priority
    add.college_id = collegeid
    add.previous_add_id = PreviousAddId
    
    APiCallManager.shared.callApi(url: APIEndpoints.GetAddsForCollege, httpMethod: .post, queryParam: nil, requestBody: add
    ) {[weak self] (result:Result<AddApiResponce,Error>) in
        
        guard let self = self else {return}
        
        switch result {
        case .success(let success):
            if success.Status == 1 {
                addapiRef = success.data ?? []
                
                for i in addapiRef{
                  
                    bigImg.sd_setImage(with: URL(string: i.background_image ?? ""), placeholderImage: UIImage(named: "ic_white"))
                    
                    smallImg.sd_setImage(with: URL(string: i.add_image ?? ""), placeholderImage: UIImage(named: "ic_white"))
                    
                    let singleTap = adds(target: self, action: #selector(adLoad))
                    singleTap.url = i.add_url
                    bigImg.isUserInteractionEnabled = true
                    bigImg.addGestureRecognizer(singleTap)
                }
            }
            
        case .failure(let failure):
            print(failure.localizedDescription)
        }
    }
    
}



@IBAction func adLoad(gesture : addvertisement) {
    
    let vc = ShowExaminationAddViewController(nibName: nil, bundle: nil)
    
    vc.addString = gesture.url
    print("adssdedd",gesture.url)
    vc.modalPresentationStyle = .fullScreen
    present(vc, animated: true,completion: nil)
}




func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    print("attendancestr5")
    if segmentName.selectedSegmentIndex == 0{
        
        print("attendancestr6")
        
        return adttendanceRef.count
        
    }
    
    else{
        
        return LeaveRefName.count
    }
    
    
    
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    
    print("attendancestr7")
    if segmentName.selectedSegmentIndex == 0 {
        
    
        let  cell = tableView.dequeueReusableCell(withIdentifier: indentifer2, for: indexPath) as!
        
        AttendancesTVTableViewCell
        
        let attendance : attendanceAbesentDataDetails = adttendanceRef[indexPath.row]
        
        cell.AttendanceHourLbl.text = attendance.attended_hour
        cell.absentHourLbl.text = attendance.absent_hour
        cell.staffNameLbl.text = ":" + "  " + (attendance.staff_name ?? "")
        cell.subjectNamLbl.text = ":" + "  " + (attendance.subjectname ?? "")
        
      
        
        print(" cell.progressbarHeight.constant", cell.progressbarHeight.constant)
        print("  cell.persentageLblBottom",  cell.persentageLblBottom.constant)
        
        if attendance.total_hour == 0 {
            
            cell.progressView.isHidden = true
            cell.persentageLbl.isHidden = true
            cell.progressbarHeight.constant = 0
            cell.persentageLblBottom.constant = -10
        }
        else{
            
            cell.progressbarHeight.constant = 20
            cell.persentageLblBottom.constant = 21
            cell.progressView.isHidden = false
            cell.persentageLbl.isHidden = false
            cell.progressView.layer.cornerRadius = 10
            cell.progressView.clipsToBounds = true
//            cell.progressView.layer.sublayers![1].cornerRadius = 10
//            cell.progressView.subviews[1].clipsToBounds = true
//            
            
            cell.progressView.progress  = Float(attendance.percentage ?? "")!/Float(100)
            
            cell.persentageLbl.text = " Attendance Percentage  :  " +  " "+String(attendance.percentage ?? "") + " % "
            
        }
    
        return cell
        
    }
    
    else {
        
        
        let  cell = tableView.dequeueReusableCell(withIdentifier: identifers, for: indexPath) as!
        
        AttendanceMenuTableViewCell
     
        let leaveApi : leaveDataDetails = LeaveRefName[indexPath.row]
        
        cell.reasonLabel.isHidden = true
        cell.EditView.isHidden = true
        cell.deleteView.isHidden = true
        
        
        if let selectedCell = selectedCell, selectedCell == indexPath {
            
            
            cell.reasonLabel.isHidden = false
            
            if leaveApi.leavestatus == "WaitingForApproval"{
                
                cell.approvedLabel.textColor = UIColor(named: "ViewLineColor")
               
                cell.EditView.isHidden = false
                cell.deleteView.isHidden = false
            }
           
            print("on")
            
        }
        
        
        cell.dateLabel.text = leaveApi.createdon
        cell.fromDate.text = leaveApi.leavefromdate
        cell.leaveAppiedType.text = leaveApi.leaveapplicationtype
        cell.numbOfDays.text = leaveApi.numofdays
        cell.toDateLabel.text = leaveApi.leavetodate
        cell.approvedLabel.text = leaveApi.leavestatus
        cell.reasonLabel.text = leaveApi.leavereason
        
        
        
        let delets = deleteClick(target: self, action: #selector(deletesVc))
        
        delets.fromdate = leaveApi.leavefromdate
        delets.reason  = leaveApi.leavereason
        delets.numberofDays = leaveApi.numofdays
        delets.todate = leaveApi.leavetodate
        delets.headerId = leaveApi.applicationid
        delets.memberId = leaveApi.leaveapplicationtype
        cell.deleteView.addGestureRecognizer(delets)
        
        let edit = deleteClick(target: self, action: #selector(EditVc))
        
        edit.fromdate = leaveApi.leavefromdate
        edit.reason  = leaveApi.leavereason
        edit.numberofDays = leaveApi.numofdays
        edit.todate = leaveApi.leavetodate
        edit.headerId = leaveApi.applicationid
        
        edit.leaveTyp = leaveApi.leaveapplicationtype
        cell.EditView.addGestureRecognizer(edit)
        
        
        if leaveApi.leavestatus == "Approved"{
        
            cell.approvedLabel.textColor = UIColor(named: "ConfirmColor")
          
            
        }
        
        else if leaveApi.leavestatus == "WaitingForApproval"{
            
            cell.approvedLabel.textColor = UIColor(named: "ViewLineColor")
           
        
            
            
        }
        
        
        else{
        
          
            
            cell.approvedLabel.textColor = UIColor(named: "CountColor")
            
        }
    
        return cell
     
    }

}

func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    if segmentName.selectedSegmentIndex == 0 {
        
        let attendance : attendanceAbesentDataDetails = adttendanceRef[indexPath.row]
        
        let vc = AttendanceDetailsViewController(nibName: nil, bundle: nil)
        vc.StaffId = attendance.staff_id
        vc.subjectId = attendance.subject_id
        vc.SubjctName = attendance.subjectname
        vc.staffName = attendance.staff_name
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
  
    }
  
    else {
     
        if let selectedCells = selectedCell, selectedCells == indexPath {
           
            selectedCell = nil
            
        } else {
            
            selectedCell = indexPath
            
        }

    }
    
    Tv.beginUpdates()
    
    Tv.endUpdates()
    
    Tv.reloadData()
}




func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    if segmentName.selectedSegmentIndex == 0  {
        
       
        return UITableView.automaticDimension
        
   
        
    }
    
    else {
        
   
        if let selectedCell = selectedCell, selectedCell == indexPath {
            
            return UITableView.automaticDimension
            
        } else  {
            
            return 200
            
        }
        
    }

    
}





@IBAction func EditVc( gesture : deleteClick){
    
    let vc = plusPageViewController(nibName: nil, bundle: nil)
    vc.PreviousAddId = PreviousAddId
    vc.types = "2"
    vc.fromDateString = gesture.fromdate
    vc.toDateString = gesture.todate
    vc.headerId = gesture.headerId
    vc.reasonss = gesture.reason
    vc.leaveType = gesture.leaveTyp
    vc.modalPresentationStyle = .fullScreen
    present(vc, animated: true,completion: nil)
}

@IBAction func deletesVc( gesture : deleteClick){
    
    
    let refreshAlert = UIAlertController(title: "", message: "Once done can't be changed", preferredStyle: UIAlertController.Style.alert)
    
    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in
   
        var mangeLeave = manageLeaveModal()
        
        mangeLeave.leavetypeid = gesture.memberId
        
        mangeLeave.applicationid = gesture.headerId
        mangeLeave.clgsectionid = sectionId
        mangeLeave.colgid = collegeid
        mangeLeave.leavefromdate = gesture.fromdate
        mangeLeave.leavereason = gesture.reason
        mangeLeave.leavetodate = gesture.todate
        mangeLeave.memberid = userid
        mangeLeave.numofdays = gesture.numberofDays
        mangeLeave.processtype = "delete"
        
        APiCallManager.shared.callApi(
                url: APIEndpoints.ManageLeaveapplication,
                httpMethod: .post,
                queryParam: nil,
                requestBody: mangeLeave
            ) {[weak self] (result:Result<manageLeaveResponce, Error>) in
                    
                guard let self = self else { return }
                
                switch result {
                case .success(let success):
                    
                    let refreshAlert = UIAlertController(title: "", message: success.Message, preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in
                   
                        self.Tv.delegate = self
                        self.Tv.dataSource = self
                        self.Tv.reloadData()
                     
                        self.leaveApi()
                        
                        
                    }))
                  
                    present(refreshAlert, animated: true, completion: nil)
                    
                    
                case .failure(let failure):
                     print("Error:",failure.localizedDescription)
                    let refreshAlert = UIAlertController(title: "", message: failure.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        
                    }))
                  
                    present(refreshAlert, animated: true, completion: nil)
                }
                
                }
        
    }))
    
    
    refreshAlert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: { (action: UIAlertAction!) in
        print("Handle Cancel Logic here")
    }))
    
    present(refreshAlert, animated: true, completion: nil)
    
}



// Tab Bar Nagivation



@IBAction func helpRedirect() {
    
    let vc = HelpViewController(nibName: nil, bundle: nil)
    vc.modalPresentationStyle = .fullScreen
    present(vc, animated: true, completion: nil)
    
    
}


@IBAction func termsAndCondition() {
    
    let vc = MenuTermsViewController(nibName: nil, bundle: nil)
    vc.modalPresentationStyle = .fullScreen
    present(vc, animated: true, completion: nil)
    
}

@IBAction func logoutPressed() {
    
    
    
    
    let refreshAlert = UIAlertController(title: "", message: "Are you sure do you want to logout", preferredStyle: UIAlertController.Style.alert)
    
    refreshAlert.addAction(UIAlertAction(title: "YES", style: .default, handler: { (action: UIAlertAction!) in
        
        
        UserDefaults.standard.removeObject(forKey: DefaultsKeys.mobileNumber)
        
        let vc = LoginNewViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc, animated: true, completion: nil)
        
        
    }))
    
    
    refreshAlert.addAction(UIAlertAction(title: "NO", style: .cancel, handler: { (action: UIAlertAction!) in
        print("Handle Cancel Logic here")
    }))
    
    present(refreshAlert, animated: true, completion: nil)
    
}


@IBAction func faqRedirect() {
    print("faqRedirect")
    let vc = FaqViewController(nibName: nil, bundle: nil)
    vc.modalPresentationStyle = .fullScreen
    present(vc, animated: true, completion: nil)
    
}

@IBAction func privacyPolicyRedirect() {
    
    let vc = PrivacyPolicyViewController(nibName: nil, bundle: nil)
    vc.modalPresentationStyle = .fullScreen
    present(vc, animated: true, completion: nil)
    
}





@IBAction func refreshVc() {
    
    print("refreshVcWork")
    KRProgressHUD.show()
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        
        KRProgressHUD.dismiss()
        
    }
    
    
}


@IBAction func notificationVc() {
    print("NotificationViewController")
    let vc = NotificationViewController(nibName: nil, bundle: nil)
    vc.str = str
    vc.strName = strName
    vc.modalPresentationStyle = .fullScreen
    present(vc, animated: false, completion: nil)
    
    
    
}




@IBAction func menu() {
    
    if sideMenuView.isHidden == true{
        
        sideMenuView.isHidden = false
        //
        
        print("menuVisble")
    }
    
    else{
        
        sideMenuView.isHidden = true
        
        print("mddffenuVisble")
    }
    
    
}


@IBAction func changePassowrdVC(){
    
    let vc = ChangePasswordViewController(nibName: nil, bundle: nil)
    vc.modalPresentationStyle = .fullScreen
    present(vc, animated: true, completion: nil)
    
    
    
}


@IBAction func profileRedirect() {
    
    let vc = ProfileViewController(nibName: nil, bundle: nil)
    vc.str = str
    vc.strName = strName
    vc.modalPresentationStyle = .fullScreen
    present(vc, animated: true, completion: nil)
    
}

    @IBAction func priorityVc() {
        let vc = PriorityViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
    }

}

class addvertisement : UITapGestureRecognizer{

var url : String!




}



class deleteClick : UITapGestureRecognizer{



var headerId : String!

var fromdate : String!

var todate : String!

var reason : String!

var numberofDays : String!

var memberId : String!

var leaveTyp : String!

}
