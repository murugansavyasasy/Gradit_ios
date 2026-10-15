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


    @IBOutlet weak var tapBarView: CustomTabBar!
    @IBOutlet weak var attendaneLblCount: UILabel!
    @IBOutlet weak var Tv: UITableView!
    @IBOutlet weak var logoutView: UIView!
    @IBOutlet weak var changeRolesView: UIView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var privacyPolicyView: UIView!
    @IBOutlet weak var faqView: UIView!
    @IBOutlet weak var sideMenuView: UIView!
    @IBOutlet weak var helpView: UIView!
    @IBOutlet weak var termsAndConditionView: UIView!
    @IBOutlet weak var changePasswordView: UIView!
    @IBOutlet weak var pluPageView: UIView!
    @IBOutlet weak var bigImg: UIImageView!
    @IBOutlet weak var segmentName: UISegmentedControl!
    @IBOutlet weak var smallImg: UIImageView!
    @IBOutlet weak var noDataLabel: UILabel!
    
    var indentifer2 = "AttendancesTVTableViewCell"
    var  identifers  = "AttendanceMenuTableViewCell"
    
    var LeaveRefName : [ leaveDataDetails] = []
    var addapiRef : [AddDataDeatils] = []
    var adttendanceRef : [attendanceAbesentDataDetails] = []
    var calendar: FSCalendar!
    var types = ""
    var collegeid : String!
    var userid    : String!
    var priority   : String!
    var sectionId : String!
    var memberName : String!
    var colgImg : String!
    var MobileNumber : String!
    var selectedCell:IndexPath?
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
    var PreviousAddId  : Int = 0
    let defaults =  UserDefaults.standard
    var str : [String] = []
    var strName : [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PreviousAddId = PreviousAddId+1
        attendaneLblCount.layer.cornerRadius = 13
        attendaneLblCount.layer.masksToBounds = true
        overrideUserInterfaceStyle = .light
        tapBarView.delegate = self
        sideMenuView.isHidden = true
        pluPageView.isHidden = true
        collegeid = defaults.string(forKey: DefaultsKeys.collegeid)
        userid = defaults.string(forKey: DefaultsKeys.memberid)
        priority = defaults.string(forKey:DefaultsKeys.priority)
        sectionId = defaults.string(forKey: DefaultsKeys.sectionid)
       
        MobileNumber = defaults.string(forKey: DefaultsKeys.mobileNumber)
        addApi()
        view.backgroundColor = .priorityColor
        
        let rownib = UINib(nibName: identifers, bundle: nil)
        Tv.register(rownib, forCellReuseIdentifier: identifers)
        
        let rownib1 = UINib(nibName: indentifer2, bundle: nil)
        Tv.register(rownib1, forCellReuseIdentifier: indentifer2)
        
        Tv.delegate = self
        Tv.dataSource = self
        
        Attendance()
        let plusPage = UITapGestureRecognizer(target: self, action: #selector(PlusPageVc))
        pluPageView.addGestureRecognizer(plusPage)
        
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
                
            case .failure(let Error):
                LeaveRefName =  []
                noDataLabel.text = Error.localizedDescription
                if segmentName.selectedSegmentIndex == 1{
                    noDataLabel.isHidden = false
                }
                attendaneLblCount.text = String(LeaveRefName.count)
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
            Attendance()
            pluPageView.isHidden = true
        }else {
            pluPageView.isHidden = false
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
                Tv.reloadData()
                
            case .failure(let failure):
                print(failure.localizedDescription)
                adttendanceRef = []
                noDataLabel.text = failure.localizedDescription
                if segmentName.selectedSegmentIndex == 0 {
                    noDataLabel.isHidden = false
                }
                Tv.reloadData()
            }
        }
    }
    
    
    
    func addApi(){
        
        var add = AddApiModal()
        let defaults = UserDefaults.standard
        var deviceToken = defaults.string(forKey:DefaultsKeys.DeviceToken)
        add.device_token = deviceToken
        add.member_id = Int(userid)
        add.mobile_no = MobileNumber
        add.priority = priority
        add.college_id = Int(collegeid)
        add.previous_add_id = PreviousAddId
        
        APiCallManager.shared.callApi(url: APIEndpoints.GetAddsForCollege, httpMethod: .post, queryParam: nil, requestBody: add
        ) {[weak self] (result:Result<AddApiResponce,Error>) in
            
            guard let self = self else {return}
            
            switch result {
            case .success(let success):
         
                    addapiRef = success.data ?? []
                    
                    let ad = addapiRef.first
                  
                    bigImg.setAdImage(
                        imageURL: ad?.background_image,
                        adURL: ad?.add_url,
                        from: self
                    )

                    smallImg.setAdImage(
                        imageURL: ad?.add_image,
                        adURL: ad?.add_url,
                        placeholder: UIImage(named: "Default_Ad_small"),
                        from: self
                    )
                
                
            case .failure(let failure):
                print(failure.localizedDescription)
                
                bigImg.setAdImage(
                    imageURL: "",
                    adURL: "",
                    from: self
                )

                smallImg.setAdImage(
                    imageURL:"",
                    adURL: "",
                    placeholder: UIImage(named: "Default_Ad_small"),
                    from: self
                )
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return segmentName.selectedSegmentIndex == 0 ? adttendanceRef.count:LeaveRefName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if segmentName.selectedSegmentIndex == 0 {
            let  cell = tableView.dequeueReusableCell(withIdentifier: indentifer2, for: indexPath) as! AttendancesTVTableViewCell
            cell.confic(attendance: adttendanceRef[indexPath.row])
            return cell
            
        }else {
            
            let  cell = tableView.dequeueReusableCell(withIdentifier: identifers, for: indexPath) as! AttendanceMenuTableViewCell
            
            let leaveApi : leaveDataDetails = LeaveRefName[indexPath.row]
            
            cell.confic(leaveApi: leaveApi, isSeletcted: leaveApi.isSelect ?? false)
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
            return cell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if segmentName.selectedSegmentIndex == 0 {

            let attendance = adttendanceRef[indexPath.row]
            let vc = AttendanceDetailsViewController(nibName: nil, bundle: nil)
            vc.StaffId = attendance.staff_id
            vc.subjectId = attendance.subject_id
            vc.SubjctName = attendance.subjectname
            vc.staffName = attendance.staff_name
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)

        } else {
            for index in LeaveRefName.indices {
                LeaveRefName[index].isSelect = index == indexPath.row ? LeaveRefName[indexPath.row].isSelect ?? false : false
            }
            LeaveRefName[indexPath.row].isSelect?.toggle()
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        
    }
    
    @IBAction func EditVc( gesture : deleteClick){
        
        let vc = plusPageViewController(nibName: nil, bundle: nil)
        vc.PreviousAddId = PreviousAddId
        vc.types = "2"
        vc.fromDateString = gesture.fromdate
        vc.toDateString = gesture.todate
        vc.headerId = gesture.headerId
        vc.reasonss = gesture.reason
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
    }
    
    @IBAction func deletesVc( gesture : deleteClick){
        
        AlertHelper.showOKCancelAlert(on: self, title: "", message: "Once done can't be change",okTitle: "OK", cancelTitle: "Cancel", cancelAction: {
            var mangeLeave = manageLeaveModal()
            mangeLeave.leavetypeid = gesture.memberId
            mangeLeave.applicationid = gesture.headerId
            mangeLeave.clgsectionid = self.sectionId
            mangeLeave.colgid = self.collegeid
            mangeLeave.leavefromdate = gesture.fromdate
            mangeLeave.leavereason = gesture.reason
            mangeLeave.leavetodate = gesture.todate
            mangeLeave.memberid = self.userid
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
                    AlertHelper.showOKAlert(on: self, title: "", message: failure.localizedDescription)
                    
                }
            }
        })
    }
    
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
        AlertHelper.showOKCancelAlert(on: self, title: "", message: "Are you sure do you want to logout",okTitle: "YES", cancelTitle: "NO", okAction: {
            UserDefaults.standard.removeObject(forKey: DefaultsKeys.mobileNumber)
            let vc = LoginVc(nibName: nil, bundle: nil)
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        })
    }
    
    
    @IBAction func faqRedirect() {
        let vc = FaqViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func privacyPolicyRedirect() {
        let vc = PrivacyPolicyViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func changePassowrdVC(){
        
        let vc = ChangePasswordVC(nibName: nil, bundle: nil)
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
        let vc = PriorityScreenVC(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
    }
    
}
@available(iOS 16.0, *)
extension AttendanceViewController :CustomTabBarDelegate{
    func didTapSearch() {}
    
    func didTapSideMenu() {
        sideMenuView.isHidden.toggle()
    }
    
    
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
