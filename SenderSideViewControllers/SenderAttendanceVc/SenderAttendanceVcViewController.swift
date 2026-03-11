//
//  SenderAttendanceVcViewController.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 27/02/23.
//

import UIKit
import FSCalendar
import ObjectMapper
import KRProgressHUD

@available(iOS 16.0, *)
class SenderAttendanceVcViewController: UIViewController,FSCalendarDataSource, FSCalendarDelegate,UITableViewDelegate,UITableViewDataSource, UIGestureRecognizerDelegate{
    
    @IBOutlet weak var reusee: ReuseView!
    @IBOutlet weak var attendaceCountLbl: UILabel!
    @IBOutlet weak var attendaneLblCount: UILabel!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    
    @IBOutlet weak var calendarHeight: NSLayoutConstraint!
    @IBOutlet weak var tapBarView: UIViewX!
    
    @IBOutlet weak var noDataLabel: UILabel!
    
    
    @IBOutlet weak var attendanceTV: UITableView!
    
    @IBOutlet weak var noDataView: UIView!
    
    @IBOutlet weak var fullView: UIView!
    
    @IBOutlet weak var clanderView: FSCalendar!
    
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
    
    
    @IBOutlet weak var redirectLoginView: UIViewX!
    
    
    @IBOutlet weak var helpView: UIView!
    
    
    
    @IBOutlet weak var termsAndConditionView: UIView!
    
    
    @IBOutlet weak var changePasswordView: UIView!
    
    @IBOutlet weak var swipeMenuHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var calendarImgView: UIView!
    
  
    @IBOutlet weak var Attendanceheights: NSLayoutConstraint!
    
  
    
    
    @IBOutlet weak var bigImg: UIImageView!
    @IBOutlet weak var adView: UIView!
    @IBOutlet weak var segmentName: UISegmentedControl!
    
    @IBOutlet weak var smallImg: UIImageView!
    
    
    @IBOutlet weak var swipeImg: UIImageView!
    var  identifers  = "SenderAttendanceTableViewCell"
    let menuIdentifier = "MenuCollectionViewCell"
    
    var  identifers2 = "attendanceSubjectTableViewCell"
    var MenuRefName :[menuApiDataDetails] = []
    var LeaveRefName : [ getLeaveApplicationDataDetails] = []
    var loginDatas : [datalogin]!
    var logindataprinci :[datalogin]!
    var addapiRef : [AddDataDeatils] = []
    var leaveApprovelAndReject : mangaeLeaveModal!
    var isAllowedToLimitFutureDates = true
    var ParticalStaffRef : [particualrDataDetails] = []
    var leaveId : String!
    
    var maxValidFutureDateAsString : String!
    //
    var calendar: FSCalendar!
    
    var HomepageLeaveHistoryId : String!
    var str : [String] = []
    
    var strName : [String] = []
    
    var is_read_enabled = ""
    var is_write_enabled = ""
    
    
    var NoticeBoardId = "1"
    var videoId = "2"
    var EventId = "3"
    var communicationId = "4"
    var imagePdfId = "5"
    var Assigment = "6"
    
    
    //
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
    
    var datessString : String!
    
    var password : String!
    
    var selectedCell:IndexPath?
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
    
    
    
    fileprivate lazy var scopeGesture: UIPanGestureRecognizer = {
        [unowned self] in
        let panGesture = UIPanGestureRecognizer(target: self.clanderView, action: #selector(self.clanderView.handleScopeGesture(_:)))
        panGesture.delegate = self
        
        print("12345cale")
        panGesture.minimumNumberOfTouches = 1
        panGesture.maximumNumberOfTouches = 2
        
        return panGesture
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        
        attendaneLblCount.layer.cornerRadius = 13
        attendaneLblCount.layer.masksToBounds = true
        
        
        
        datessString = Date().today(format: "dd/MM/yyyy")
        
        clanderView.delegate = self
      
        noDataLabel.isHidden = true
        sideMenuView.isHidden = true
        calendarImgView.isHidden = true
        
        Tv.isHidden = true
        
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
        password = defaults.string(forKey: DefaultsKeys.Password)
        MobileNumber = defaults.string(forKey: DefaultsKeys.mobileNumber)
        
        Tv.delegate = self
        Tv.dataSource = self
        
        addApi()
        
        
        if is_read_enabled == "1"{
            attendance()
            subject()
            
        }else{
            
            
            
        }
        
        
        
        leaveApi(id : "1")
        
        print("LeaveRefName",LeaveRefName.count)
        
        
        
        clanderView.dataSource = self
        if priority == "p1"{
            tapBarView.backgroundColor = UIColor(named: "Principal" )
            topLabels.text = "Principal"
            
        }
        
        else if priority == "p4"{
            
            topLabels.text = "Student"
            
        }
        
        else if priority == "p2" {
            
            tapBarView.backgroundColor = UIColor(named: "Teaching Staff" )
            topLabels.text = "Hod"
            
        }
        
        else if priority == "p5"{
            
            
            topLabels.text = "Father"
            
            
            
        }
        
        else if priority == "p3"{
            tapBarView.backgroundColor = UIColor(named: "Teaching Staff" )
            topLabels.text = "Teacher"
            
        }
        
        
        else if priority == "p6"{
            tapBarView.backgroundColor = UIColor(named: "Teaching Staff" )
            topLabels.text = "Non Teaching"
            
            
            
        }
        if priority == "p1" {
            
            
            print("PrincipalVieewwColor")
            view.backgroundColor = UIColor(named: "Principal" )
            
                reusee.menuImg.image = UIImage(named: "principalBigMenu")
            
        }else if priority == "p4" {
            
            print("StudentVieewwColor")
            view.backgroundColor = UIColor(named: "studentViewColors")
            
            
            reusee.menuImg.image = UIImage(named: "studentSwipeImage")
            
        } else if priority == "p3" ||  priority == "p2" {
            
            print("HooodddVieewwColor")
            view.backgroundColor = UIColor(named: "Teaching Staff")
            
            reusee.menuImg.image = UIImage(named: "HodImage")
            
        }
        else if priority == "p5"{
            
            
            
            view.backgroundColor = UIColor(named: "FatherColor")
            
            reusee.menuImg.image = UIImage(named: "StaffBigMenu")
            
            
        }
        
        
        else if priority == "p6"{
            
            
            
            view.backgroundColor = UIColor(named: "Teaching Staff")
            
            reusee.menuImg.image = UIImage(named: "HodImage")
            
            
        }
        
        
        //
        calendarHeight.constant = 350
        
        self.clanderView.select(Date())
        
        self.clanderView.addGestureRecognizer(self.scopeGesture)
        self.clanderView.addGestureRecognizer(self.scopeGesture)
        self.clanderView.scope = .week
        
        
        
        
        swipeMenuHeight.constant = 150
                reusee.call_back = { [self]
                    (val) in
                  
                    
                        self.swipeMenuHeight.constant =  reusee.callid
                   
                    print("SenderFacultyViewController",reusee.callid)
                    
               
                }
     
        
     
        let loginRediectGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        redirectLoginView.addGestureRecognizer(loginRediectGesture)
        
        
        
        attendanceTV.delegate = self
        attendanceTV.dataSource  = self
        
        
        let rownib = UINib(nibName: identifers, bundle: nil)
        Tv.register(rownib, forCellReuseIdentifier: identifers)
        
        
        let attendanceTVrownib = UINib(nibName: identifers2, bundle: nil)
        attendanceTV.register(attendanceTVrownib, forCellReuseIdentifier: identifers2)
        
        
        
        
        // tap Bar UiTapGuster.
        
        
        
        
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
        //
        
        let privacyPolicyGesture = UITapGestureRecognizer(target: self, action: #selector(privacyPolicyRedirect))
        privacyPolicyView.addGestureRecognizer(privacyPolicyGesture)
        
        let termsAndConditionGesture = UITapGestureRecognizer(target: self, action: #selector(termsAndCondition))
        termsAndConditionView.addGestureRecognizer(termsAndConditionGesture)
        
        
        
        let changeRolesGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        changeRolesView.addGestureRecognizer(changeRolesGesture)
        
        
        let logoutGesture = UITapGestureRecognizer(target: self, action: #selector(logoutPressed))
        logoutView.addGestureRecognizer(logoutGesture)
        
        
        
        let chagePassword = UITapGestureRecognizer(target: self, action: #selector(changePassowrdVC))
        changePasswordView.addGestureRecognizer(chagePassword)
        
        
        
        
    }
    
    
    @objc func dismissKeyboards() {
        
        sideMenuView.isHidden = true
        view.endEditing(true)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
        //  FromDate_Action()
        
        
        print("viewWillAppear")
        
    }
    
    
    func leaveApi(id : String){
        
        var  leave = leaveRequestModal()
        leave.collegeid = collegeid
        leave.staffid = userid
        
        APiCallManager.shared.callApi(url: APIEndpoints.GetLeaveApplicationListForSenderApp, httpMethod: .post, queryParam: nil, requestBody: leave) {[weak self] (result:Result<getLeaveTypeForSenderResponce, Error>) in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let success):
                
                LeaveRefName = success.data ?? []
                if success.Status == 1 {
                    attendaneLblCount.text = String(LeaveRefName.count)
                    noDataLabel.isHidden = true
                }else{
                    noDataLabel.isHidden = false
                    noDataLabel.text = success.Message
                }
                
                Tv.reloadData()
                
            case .failure(let failure):
                LeaveRefName = []
                noDataLabel.isHidden = false
                noDataLabel.text = failure.localizedDescription
                Tv.reloadData()
            }
        }
    }
    
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        // Handle the selected date
        print("Selected date: \(date)")
        
        
      
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        let selectedDate = date // Replace with your selected date
        let dateString = dateFormatter.string(from: selectedDate)
        
        print("Selected datedfghjk: \(dateString)")
        
        datessString = dateString
        subject()
        
        
        
        
        
        
    }
    
    
 
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calendarHeight.constant = bounds.height
        
        
        print("boundingRectWillChange",bounds.height)
        
        
        
        
        swipeImg.isHidden = false
        
        
        if self.calendarHeight.constant == 350 {
            
            swipeImg.isHidden = true
            
            calendarImgView.isHidden = true
        }
        
        self.view.layoutIfNeeded()
    }
    
    
    func subject(){
        
        print(" attendanceTV.isHidden",attendanceTV.isHidden)
        
        
        let subj = ParticularStaffModal()
        
        subj.collegeid = collegeid
        subj.staffid = userid
        subj.date = datessString
        let subjectstr = subj.toJSONString()
        ParticularStaffRequest.call_request(param: subjectstr!){ [self]
            
            (res) in
            
            let subje : particularStaffResponce  = Mapper<particularStaffResponce>().map(JSONString: res)!
            
            
            
            
            //
            
            if subje.Status == 1 {
                
                
                ParticalStaffRef = subje.data
                
                
                var counts = String(subje.data.count)
                
                
                
                attendaceCountLbl.text = counts
                
                
                calendarImgView.isHidden = true
                
                
                
                if self.calendarHeight.constant == 350 {
                    self.calendarHeight.constant = 127
                    
                    calendarImgView.isHidden = true
                    self.clanderView.scope = .week
                    
                    
                }
                
                
                
                attendanceTV.isHidden = false
                attendanceTV.reloadData()
                
                
                
            }
            
            
            else{
                print("12calendarHeight.constant")
                attendanceTV.isHidden = true
                attendaceCountLbl.text = "0"
                if calendarHeight.constant == 127.08333333333334 {
                    
                    calendarImgView.isHidden = false
                    self.clanderView.scope = .week
                    
                }
                
                calendarImgView.isHidden = false
                
                if self.calendarHeight.constant == 350 {
                    self.calendarHeight.constant = 127
                    
                    calendarImgView.isHidden = false
                    self.clanderView.scope = .week
                    
                    
                }
                
            }
            
            
            
        }
        
    }
    
    
    
    
    
    @IBAction func segmentActions(_ sender: Any) {
        
        
        if is_read_enabled == "1"{
            
            
            if segmentName.selectedSegmentIndex == 0{
                
                attendance()
                subject()
                clanderView.isHidden = false
                Tv.isHidden = true
                attendanceTV.isHidden = false
                
                noDataLabel.isHidden = true
                swipeImg.isHidden = false
                
            }
            
            
            else if segmentName.selectedSegmentIndex == 1 {
                
                
                
                
                leaveApi(id : "0")
                calendarImgView.isHidden = true
                clanderView.isHidden = true
                Tv.isHidden = false
                attendanceTV.isHidden = true
                swipeImg.isHidden = true
                
            }
            
        }else{}
        
    }
    
    
    
    
    
    
    func attendance(){
        
      
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        let result = formatter.string(from: date)
        print("minits",result)
        
        
        
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
        add.previous_add_id = 2
        
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
    
    
    
    @IBAction func adLoad(gesture : AttendAdd) {
        
        
        
        let vc = AttendanceAddViewController(nibName: nil, bundle: nil)
        
        
        vc.addString = gesture.url
        print("adssdedd",gesture.url)
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true,completion: nil)
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentName.selectedSegmentIndex == 0{
            if  tableView == self.attendanceTV{
                
                return ParticalStaffRef.count
            }
        }
        
        else if segmentName.selectedSegmentIndex == 1{
            if  tableView == self.Tv{
                return LeaveRefName.count
            }
        }
        
        
        return 0
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        
        
        
        
        if  tableView == self.attendanceTV{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: identifers2,for: indexPath) as!
            
            
            
            attendanceSubjectTableViewCell
            
            
            let subject : particualrDataDetails =  ParticalStaffRef[indexPath.row]
            
            cell.classTeacherLabel.text = subject.subjectname
            cell.departmentLabel.text = subject.coursename
            cell.sectionLabel.text = subject.sectionname
            cell.yearLabel.text = subject.yearname
            
            print("JOPPPP",subject.semestername)
            cell.semLabel.text = subject.semestername
            
            
            
            if subject.isedit == "1"{
                
                cell.editAttendanceView.isHidden = false
               
            }else{
                
                cell.editAttendanceView.isHidden = true
               
            }
            
            let takeAttwndance = TakeAttendance(target: self, action: #selector(TakeAttendanceVc))
            
            takeAttwndance.sectionId = subject.sectionid
            takeAttwndance.courseId = subject.courseid
            takeAttwndance.departmentId = subject.departmentid
            
            takeAttwndance.yearId = subject.yearid
            takeAttwndance.subjectId = subject.subjectid
            takeAttwndance.SectionNamw = subject.sectionname
            takeAttwndance.SemesterName = subject.semestername
            takeAttwndance.departmentName = subject.coursename
            takeAttwndance.YearName = subject.yearname
            takeAttwndance.editId = subject.isedit
            
            
            for i in subject.add_hours{
                
                takeAttwndance.attendasEdit.append(i.hour)
            }
            
            
            cell.takeAttendanceView.addGestureRecognizer(takeAttwndance)
            
            
            
            
            let editAttndace = TakeAttendance(target: self, action: #selector(EditAttendes))
            
            editAttndace.sectionId = subject.sectionid
            editAttndace.courseId = subject.courseid
            editAttndace.departmentId = subject.departmentid
            
            editAttndace.yearId = subject.yearid
            editAttndace.subjectId = subject.subjectid
            editAttndace.SectionNamw = subject.sectionname
            editAttndace.SemesterName = subject.semestername
            editAttndace.departmentName = subject.coursename
            editAttndace.YearName = subject.yearname
            editAttndace.editId = subject.isedit
            editAttndace.edit_hours = subject.edit_hours
            
            for i in subject.edit_hours{
                
                editAttndace.attendasEdit.append(i.hour)
            }
            
           
            cell.editAttendanceView.addGestureRecognizer(editAttndace)
            
            
            return cell
        }
        
        
        
        
        
        
        
        
        
        
        
        else{
            
            let  cell = tableView.dequeueReusableCell(withIdentifier: identifers, for: indexPath) as!
            
            SenderAttendanceTableViewCell
            if let selectedCell = selectedCell, selectedCell == indexPath {
                cell.lineView.isHidden = false
                print("on")
                
            } else {
                cell.lineView.isHidden = true
                
            }
            
            
            
            let leaveApi : getLeaveApplicationDataDetails = LeaveRefName[indexPath.row]
            
            cell.dateLabel.text = leaveApi.createdon
            cell.fromDate.text = leaveApi.leavefromdate
            cell.leaveTypeLbl.text = leaveApi.leaveapplicationtype
            cell.numbOfDays.text = leaveApi.numofdays
            cell.toDateLabel.text = leaveApi.leavetodate
            cell.approvedLabel.text = leaveApi.leavestatus
            cell.studentNameLabel.text = leaveApi.studentname
            cell.CourseLabel.text = leaveApi.coursename
            cell.yearLabel.text = leaveApi.yearname
            cell.sectionLabel.text = leaveApi.sectionname
            cell.leaveReasonLabel.text = leaveApi.leavereason
            
            let aprovel = approve(target: self, action: #selector(approveVc))
            leaveId = "1"
            aprovel.Leaveid = leaveApi.applicationid
            cell.approvelView.addGestureRecognizer(aprovel)
            
            let reject = approve(target: self, action: #selector(RejectVc))
            leaveId = "2"
            reject.Leaveid = leaveApi.applicationid
            cell.rejectView.addGestureRecognizer(reject)
            
            
            if leaveApi.leavestatus == "WaitingForApproval"{
                
                cell.approvedLabel.textColor = UIColor.blue
                
                cell.rejectView.isHidden = false
                cell.approvelView.isHidden = false
                
                
                
                
                
            }
            
            
            else if leaveApi.leavestatus == "Approved"{
                
                
                cell.approvedLabel.textColor = UIColor.green
                cell.rejectView.isHidden = true
                cell.approvelView.isHidden = true
                
                
            }
            
            if leaveApi.leavestatus == "Rejected"{
                
                cell.approvedLabel.textColor = UIColor.red
                
                cell.rejectView.isHidden = true
                cell.approvelView.isHidden = true
                
                
                
                
                
            }
            return cell
            
        }
        
        
        
        
        
        
        
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if segmentName.selectedSegmentIndex == 0 {
            
            if  tableView == self.attendanceTV{
                
                
            }
            
            
            
        }
        
        
        else    if segmentName.selectedSegmentIndex == 1 {
            
            if  tableView == self.Tv{
                
                
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
    }
    
    
    
    @IBAction func EditAttendes( gesture : TakeAttendance){
        
        
        print("countttttttt",gesture.attendasEdit)
        
        let numbers = gesture.attendasEdit
        var uniqueNumbers = [Int]()
        for number in numbers {
            if !uniqueNumbers.contains(number) {
                uniqueNumbers.append(number)
            }
        }
        
        let vc = SpecificStudentViewController(nibName: nil, bundle: nil)
        
        vc.MenuType = "10"
        vc.sectionId = gesture.sectionId
        vc.strs = str
        vc.strName = strName
        vc.departmentId = gesture.departmentId
        vc.courseId = gesture.courseId
        vc.YearId = gesture.yearId
        vc.subjectID = gesture.subjectId
        vc.AttendancessSectionNamw = gesture.SectionNamw
        vc.is_read_enabled = is_read_enabled
        vc.is_write_enabled = is_write_enabled
        vc.subjectIdForStuddent = gesture.subjectId
        vc.AttendancessdepartmentName = gesture.departmentName
        vc.AttendancessYearName = gesture.YearName
        vc.AttendancessSemesterName = gesture.SemesterName
        vc.attendanceDate = datessString
        vc.attendanceHourDropRef = uniqueNumbers
        vc.edit_hours = gesture.edit_hours
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true,completion: nil)
        
    }
    
    @IBAction func TakeAttendanceVc( gesture : TakeAttendance){
        
        
        
        
        
        
        
        
        
        let vc = SpecificStudentViewController(nibName: nil, bundle: nil)
        print("countttttttt",gesture.attendasEdit)
        let numbers = gesture.attendasEdit
        var uniqueNumbers = [Int]()
        for number in numbers {
            if !uniqueNumbers.contains(number) {
                uniqueNumbers.append(number)
            }
        }
        vc.MenuType = "9"
        vc.sectionId = gesture.sectionId
        vc.departmentId = gesture.departmentId
        vc.courseId = gesture.courseId
        vc.YearId = gesture.yearId
        vc.subjectID = gesture.subjectId
        vc.subjectIdForStuddent = gesture.subjectId
        vc.attendanceDate = datessString
        vc.AttendancessSectionNamw = gesture.SectionNamw
        vc.is_read_enabled = is_read_enabled
        vc.is_write_enabled = is_write_enabled
        
        vc.AttendancessdepartmentName = gesture.departmentName
        vc.AttendancessYearName = gesture.YearName
        vc.AttendancessSemesterName = gesture.SemesterName
        vc.strs = str
        vc.strName = strName
        vc.attendanceHourDropRef = uniqueNumbers
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true,completion: nil)
        
        attendanceTV.reloadData()
        
    }
    
    @IBAction func approveVc(gesture : approve){
        
        
        let refreshAlert = UIAlertController(title: "Approved Leave", message: "Once Done can't be changed", preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in
            
            
            let leaveAprovel = mangaeLeaveModal()
            
            leaveAprovel.leaveid = gesture.Leaveid
            
            print("thidddsdsdcscx",gesture.Leaveid)
            leaveAprovel.userid = userid
            leaveAprovel.processtype = "1"
            
            
            
            let leaveApprovestr = leaveAprovel.toJSONString()
            
            
            manageLeaveRequests.call_request(param: leaveApprovestr!){ [self]
                
                (res) in
                
                
                
                let addApis : manageLeaveResponces = Mapper<manageLeaveResponces>().map(JSONString: res)!
                
                
                if addApis.Status == 1{
                    
                    
                    
                    let refreshAlert = UIAlertController(title: "", message: addApis.Message, preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        
                        
                        
                    }))
                    
                    
                    present(refreshAlert, animated: true, completion: nil)
                    
                    Tv.reloadData()
                    
                    leaveApi(id : "0")
                    
                }
                
                else{
                    
                    
                    let refreshAlert = UIAlertController(title: "", message: addApis.Message, preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        
                        
                        
                    }))
                    
                    
                    present(refreshAlert, animated: true, completion: nil)
                    
                    Tv.reloadData()
                    
                    
                    
                    
                }
                
                
            }
            
            
        }))
        
        
        refreshAlert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        present(refreshAlert, animated: true, completion: nil)
        
        
        
        
        
        
    }
    
    
    
    
    @IBAction func RejectVc(gesture : approve){
        
        
        
        let refreshAlert = UIAlertController(title: "Reject Leave", message: "Once Done can't be changed", preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in
            
            
            let leaveAprovel = mangaeLeaveModal()
            
            leaveAprovel.leaveid = gesture.Leaveid
            
            print("thidddsdsdcscx",gesture.Leaveid)
            leaveAprovel.userid = userid
            leaveAprovel.processtype = "2"
            
            
            
            let leaveApprovestr = leaveAprovel.toJSONString()
            
            
            manageLeaveRequests.call_request(param: leaveApprovestr!){ [self]
                
                (res) in
                
                
                
                let addApis : manageLeaveResponces = Mapper<manageLeaveResponces>().map(JSONString: res)!
                
                
                if addApis.Status == 1{
                    
                    
                    let refreshAlert = UIAlertController(title: "", message: addApis.Message, preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        
                        
                        
                    }))
                    
                    
                    present(refreshAlert, animated: true, completion: nil)
                    
                    Tv.reloadData()
                    
                    leaveApi(id : "0")
                    
                }
                
                else{
                    
                    
                    
                    let refreshAlert = UIAlertController(title: "", message: addApis.Message, preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        
                        
                        
                    }))
                    
                    
                    present(refreshAlert, animated: true, completion: nil)
                    Tv.reloadData()
                    
                    
                    
                    
                }
                
                
            }
            
        }))
        
        
        refreshAlert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        present(refreshAlert, animated: true, completion: nil)
        
        
        
        
        
        
        
        
        
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        if segmentName.selectedSegmentIndex == 0  {
            
            if  tableView == self.attendanceTV{
                
                return UITableView.automaticDimension
            }
            
            
            
        }
        
        else if segmentName.selectedSegmentIndex == 1{
            
            if  tableView == self.Tv{
                if let selectedCell = selectedCell, selectedCell == indexPath {
                    
                    return 310
                    
                } else  {
                    
                    return 210
                    
                }
            }
        }
        
        
        return 0
        
        
    }
    
    
    
    
    
    
    // this part bottom swipe view .
    
    
    
    
    
    
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
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func priorityVc() {
        
        let vc = PriorityViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
    }
    
}

class AttendAdd : UITapGestureRecognizer{
    
    var url : String!
    
    
    
    
}


class approve : UITapGestureRecognizer{
    
    var Leaveid : String!
    
    
    
    
}


class TakeAttendance : UITapGestureRecognizer{
    
    var courseId : String!
    var departmentId : String!
    var yearId : String!
    var sectionId : String!
    var subjectId : String!
    var dateLabel : String!
    var departmentName : String!
    var YearName : String!
    var SemesterName : String!
    var SectionNamw : String!
    var editId : String!
    var attendasEdit : [Int] = []
    var edit_hours : [editHoursdataDEtaild] = []
    
    
}


extension Date {
    func today(format : String = "dd/MM/yyyy") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
