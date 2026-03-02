//
//  TeacherSidePlusPageViewController.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 27/03/23.
//

import UIKit
import ObjectMapper
import KRProgressHUD

@available(iOS 16.0, *)
class TeacherSidePlusPageViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    
    @IBOutlet weak var tapBarView: UIViewX!
    @IBOutlet weak var examNameTextField: UITextField!
    @IBOutlet weak var fromDateLabel: UILabel!
    
    @IBOutlet weak var todateLabel: UILabel!
    
    @IBOutlet weak var calanderTopHeight: NSLayoutConstraint!
    @IBOutlet weak var TodateView: UIViewX!
    @IBOutlet weak var fromDateView: UIViewX!
    @IBOutlet weak var redirectLoginView: UIViewX!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var getSelectionView: UIView!
    
    @IBOutlet weak var logoutView: UIView!
    
    @IBOutlet weak var calandViewss: UIView!
    @IBOutlet weak var changeRolesView: UIView!
    
    @IBOutlet weak var topLabels: UILabel!
    
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var clgLogoImg: UIImageView!
    @IBOutlet weak var changePasswordView: UIView!
    
    
    @IBOutlet weak var topMessageLabel: UILabel!
    
    @IBOutlet weak var termsAndConditionView: UIView!
    
    
    
    @IBOutlet weak var helpView: UIView!
    
    
    
    
    @IBOutlet weak var sideMenuView: UIView!
    
    
    @IBOutlet weak var viewTap: UIView!
    
    @IBOutlet weak var refreshView: UIView!
    
    
    
    @IBOutlet weak var faqView: UIView!
    
    @IBOutlet weak var privacyPolicyView: UIView!
    
    
    @IBOutlet weak var profileView: UIView!
    
    @IBOutlet weak var smallImg: UIImageView!
    @IBOutlet weak var bigImg: UIImageView!
    var addImageBackGroundurl : String!
    var imageWebUrl : String!
    var smallImageUrl  : String!
    
    var selectedCell : IndexPath?
    
    @IBOutlet weak var tv: UITableView!
    
    var identifier = "HodRespienTableViewCell"
    
    var ParticalStaffRef : [particualrDataDetails] = []
    var facultyDropDownRef : [dropDownDataDetails] = []
    var nameString : String!
    var resiverId : [String] = []
    var memberId : String!
    var clgId : String!
    var colgImg :String!
    
    var priority : String!
    
    var loginDatas : [datalogin]!
    var logindataprinci :[datalogin]!
    
    var MobileNumber : String!
    
    var display_date : String!
    
    var url_date : String!
    var password : String!
    var str : [String] = []
    
    var strName : [String] = []
    
    var departsss : String!
    var sectionID : String!
    
    
    var deptid : String!
    
    var courseId : String!
    
    var yearId : String!
    
    var SelectedIDString : String!
    
    var SubjectId : String!
    
    var semesterId : String!
    var is_read_enabled = ""
    var is_write_enabled = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        fromDateLabel.text = "DD/MM/YYY"
        todateLabel.text = "DD/MM/YYY"
        
        sideMenuView.isHidden = true
        datePicker.isHidden = true
        calandViewss.isHidden = true
        
        bigImg.sd_setImage(with: URL(string: addImageBackGroundurl), placeholderImage: UIImage(named: "ic_white"))
        smallImg.sd_setImage(with: URL(string: smallImageUrl ), placeholderImage: UIImage(named: "ic_white"))
        
        
        let defaults = UserDefaults.standard
        
        memberId = defaults.string(forKey: DefaultsKeys.memberid)
        clgId = defaults.string(forKey: DefaultsKeys.collegeid)
        priority = defaults.string(forKey: DefaultsKeys.priority)
        topMessageLabel.text = defaults.string(forKey: DefaultsKeys.memberName)
        colgImg = defaults.string(forKey: DefaultsKeys.colglogo)
        clgLogoImg.sd_setImage(with: URL(string:  colgImg), placeholderImage: UIImage(named: "person.fill"))
        MobileNumber = defaults.string(forKey: DefaultsKeys.mobileNumber)
        
        password = defaults.string(forKey: DefaultsKeys.Password)
        
        subject()
        
        let rownib = UINib(nibName: identifier, bundle: nil)
        tv.register(rownib, forCellReuseIdentifier: identifier)
        
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
            
            topLabels.text = "NonTeaching"
            
        }
        
        examNameTextField.returnKeyType = .done
        examNameTextField.delegate = self
        let fromDate = UITapGestureRecognizer(target: self, action: #selector(FromDateVc))
        fromDateView.addGestureRecognizer(fromDate)
        
        let todate = UITapGestureRecognizer(target: self, action: #selector(todateClick))
        TodateView.addGestureRecognizer(todate)
        
        
        
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
        
        
        
        let chagePassword = UITapGestureRecognizer(target: self, action: #selector(changePassowrdVC))
        changePasswordView.addGestureRecognizer(chagePassword)
        
        let changeRol = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        changeRolesView.addGestureRecognizer(changeRol)
        
        
        let loginRediectGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        redirectLoginView.addGestureRecognizer(loginRediectGesture)
        
        
        let logoutGesture = UITapGestureRecognizer(target: self, action: #selector(logoutPressed))
        logoutView.addGestureRecognizer(logoutGesture)
        
        
    }
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        examNameTextField.resignFirstResponder()
        return true
    }
    
    
    
    
    
    
    @IBAction func FromDateVc(){
        todateLabel.text = "DD/MM/YYY"
        FromDate_Action()
        
        
        
    }
    
    
    
    @IBAction func todateClick(){
        
        
        datePicker.isHidden = false
        calandViewss.isHidden = false
        calanderTopHeight.constant = 328
        Todate()
        
        
        
        
        
        
    }
    
    
    func FromDate_Action(){
        
        
        
        RPicker.selectDate(title: "Select Date", cancelText: "Cancel", datePickerMode: .date, style: .Inline, didSelectDate: {[weak self] (today_date) in
            
            
            
            self?.display_date = today_date.dateString("dd/M/yyyy")
            
            self?.url_date = today_date.dateString("yyyy/M/dd")
            
            self?.fromDateLabel.text = self!.display_date
            
        })
        
    }
    
    func Todate(){
        
        
        
        
        
        let dateFormater: DateFormatter = DateFormatter()
        dateFormater.dateFormat = "dd/M/yyyy"
        let currentDate = fromDateLabel.text
        let date = dateFormater.date(from:currentDate!)!
        var dt : Date!
        dt = date
        
        
        datePicker.minimumDate = dt
        
        
        let selectedDate = dateFormater.string(from: datePicker.date)
        print("selectedDate",selectedDate)
        
        
        
        
    }
    
    
    @IBAction func dte(_ sender: UIDatePicker) {
        print("print \(sender.date)")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/M/yyyy"
        let somedateString = dateFormatter.string(from: sender.date)
        
        
        todateLabel.text = somedateString
     
          print(somedateString)
   }
    
    
    
    
    
    
    
    
    @IBAction func getSelectionVc(gesture : yearIdClick){
        
        
        print("nameeee",nameString)
        
        if examNameTextField.text == ""{
            
            
            
            
            
            let refreshAlert = UIAlertController(title: "", message: "Please Enter Exam Name ", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
                
                
                
            }))
            
            
            
            present(refreshAlert, animated: true, completion: nil)
            
            
            
        }
        
        else if fromDateLabel.text == "DD/MM/YYY"{
            
            
            
            
            let refreshAlert = UIAlertController(title: "", message: "Please Enter From Date ", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
                
                
                
            }))
            
            
            
            present(refreshAlert, animated: true, completion: nil)
            
        }
        
        else if todateLabel.text == "DD/MM/YYY"{
            
            
            
            
            
            
            let refreshAlert = UIAlertController(title: "", message: "Please Enter To Date ", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
                
                
                
            }))
            
            
            
            present(refreshAlert, animated: true, completion: nil)
            
            
        }
        
        
        
        else if nameString == nil{
            
            
            
            
            let refreshAlert = UIAlertController(title: "", message: "Please Select Course  ", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
                
                
                
            }))
            
            
            
            present(refreshAlert, animated: true, completion: nil)
            
            
            
        }
        
        
        else{
            if nameString == nil{
                
                
                
                
                let refreshAlert = UIAlertController(title: "", message: "Please Select Onely One Deparment ", preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    
                    
                    
                    
                }))
                
                
                
                present(refreshAlert, animated: true, completion: nil)
                
                
                
                
                
            }
            
            
            else {
                
                
                
                
                
                
                
                
                
                
                let addExm = exameMainDetail()
                
                addExm.examname = examNameTextField.text
                addExm.enddate = todateLabel.text
                addExm.startdate = fromDateLabel.text
               
                
                
                let vc =  GetSectionAndViewController(nibName: nil, bundle: nil)
                
               
                
                vc.semsterID = semesterId
                vc.sectionId = nameString
                vc.clgDepartId = departsss
                vc.addImageBackGroundurl =  addImageBackGroundurl
                vc.smallImageUrl = smallImageUrl
                vc.exameName = examNameTextField.text
                vc.startDate = fromDateLabel.text
                vc.endDate = todateLabel.text
                vc.exameName = examNameTextField.text
                vc.examCre.append(addExm)
                
                
                vc.EndDateEdit = todateLabel.text
                vc.StartDateEdit = fromDateLabel.text
                vc.addImageBackGroundurl = addImageBackGroundurl
                
                vc.smallImageUrl = addImageBackGroundurl
                
                vc.imageWebUrl = imageWebUrl
                vc.strName = strName
                vc.str = str
                
                
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.modalPresentationStyle = .fullScreen
                
                present(vc, animated: true,completion: nil)
                
            }
            
            
        }
        
    }
    
    
    
    @IBAction func backBtn(_ sender: Any) {
        
        dismiss(animated: true)
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ParticalStaffRef.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as!
        
        HodRespienTableViewCell
        
        
        
        
        
        
        
        let subject : particualrDataDetails = ParticalStaffRef[indexPath.row]
        
        
        cell.checkBoxView.isHidden = true
        cell.CheckImageView.isHidden = true
        
        
        if(SelectedIDString == subject.subjectid){
            
            
            
            
            cell.CellFullView.backgroundColor = UIColor(named: "eventdashcolorr")
            
        }
        
        else{
            
            cell.CellFullView.backgroundColor = UIColor(named: "MarkTableViewColor")
            
            
            
        }
        cell.SecLabel.text = subject.sectionname
        cell.SemesterLabel.text = subject.semestername
        cell.SubjectNameLabel.text = subject.subjectname
        cell.courseNameLabel.text = subject.coursename
        cell.yearLabel.text = subject.yearname
        
        
        
        let getSelection = yearIdClick(target: self, action: #selector(getSelectionVc))
        getSelection.yearId = subject.yearid
        
        getSelectionView.addGestureRecognizer(getSelection)
        
        
        
        
        return cell
    }
    
    
    
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let currentCell = tableView.cellForRow(at: indexPath) as! HodRespienTableViewCell
        
        
        
        
        
        
        
        
        
        
        let subject : particualrDataDetails = ParticalStaffRef[indexPath.row]
        
        print("Selectedcountry",subject.sectionid)
        
        currentCell.CheckImageView.isHidden = false
        currentCell.CellFullView.backgroundColor = UIColor(named: "eventdashcolorr")
        nameString = subject.sectionid
        
        semesterId = subject.semesterid
        SelectedIDString = subject.subjectid
        courseId = subject.courseid
        yearId = subject.yearid
        sectionID = subject.sectionid
        SubjectId = subject.subjectid
        departsss = subject.departmentid
        
        
        
        tv.reloadData()
        
    }
    
    
    
    
    
    
    
    
    
    
    @IBAction func sbjectVc(gestur : CheckBoxGests){
        
        
        
        if gestur.checkBoxss.isChecked == true{
            
            
            gestur.checkBoxss.isChecked = false
            
            print("unchecked")
            
            gestur.checkBoxss.setImage(UIImage.init(named: "checkboxs"), for: .normal)
            
            resiverId.removeLast()
            
        }else{
            
            gestur.checkBoxss.isChecked = true
            
            gestur.checkBoxss.setImage(UIImage.init(named: "done"), for: .normal)
            
            
            resiverId.append(gestur.semesterID)
            
            sectionID = gestur.sectionID
            departsss = gestur.departsss
            
            nameString =  gestur.semesterID  // this is  importent
            
            
            
            print("resiverId.append(gestur.memberName)0897654",resiverId)
            
            
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 130
    }
    
    
    
    func subject(){
        
        
        let subj = ParticularStaffModal()
        
        subj.collegeid = clgId
        subj.staffid = memberId
        
        let subjectstr = subj.toJSONString()
        SubjectRequests.call_request(param: subjectstr!){ [self]
            
            (res) in
            //
            //
            //
            let subje : particularStaffResponce  = Mapper<particularStaffResponce>().map(JSONString: res)!
            
            if subje.Status == 1{
                
                ParticalStaffRef = subje.data
                
                
                
                
                tv.delegate = self
                tv.dataSource = self
                tv.reloadData()
                
            }
            
            
            else{
                
                let refreshAlert = UIAlertController(title: "", message: subje.Message, preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    
                    
                    
                }))
                
                
                
                present(refreshAlert, animated: true, completion: nil)
                
                
                
                
                
                tv.delegate = self
                tv.dataSource = self
                tv.reloadData()
            }
            
        }
        
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
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true, completion: nil)
        
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
    
    
    
    
    @IBAction func priorityVc() {
        
        
        
        
        
        
        let login = LoginModal ()
        login.mobilenumber = MobileNumber
        login.Password = password
        print("passsdded", login.Password)
        
        
        let loginStr = login.toJSONString()
        
        loginRequest.call_request(param: loginStr!){ [self]
            
            (res) in
            
            
            let loginResponse : LoginResponse =
            Mapper<LoginResponse>().map(JSONString: res)!
            
            loginDatas = loginResponse.data
            print("ctrss",loginDatas.count)
            if (loginResponse.data.count >= 1){
                
                
                
                let vc = PriorityViewController(nibName: nil, bundle: nil)
                for i in loginResponse.data{
                    
                    
                    if i.priority == "p3"{
                        vc.IdentfierLabel = "STAFF"
                        vc.loginPrincipal.append(i)
                        
                    }
                    
                    else if i.priority == "p4"{
                        vc.loginStudent.append(i)
                        
                    }
                    
                    
                    else if i.priority == "p2"{
                        
                        vc.IdentfierLabel = "HOD"
                        vc.loginPrincipal.append(i)
                        
                    }
                    
                    else if i.priority == "p1"{
                        
                        vc.IdentfierLabel = "PRINCIPAL"
                        vc.loginPrincipal.append(i)
                    }
                    
                    else if i.priority == "p5"{
                        vc.IdentfierLabel = "PARENT"
                        vc.loginPrincipal.append(i)
                        
                        
                    }
                    
                    else if i.priority == "p6"{
                        
                        vc.IdentfierLabel = "NON TEACHING"
                        vc.loginPrincipal.append(i)
                    }
                    
                    
                }
                vc.modalPresentationStyle = .fullScreen
                
                present(vc, animated: true,completion: nil)
                
                
                
            }
        }
        
        
        
    }
    
    
    @IBAction func doneBtn(_ sender: Any) {
        
        print("click")
        calandViewss.isHidden = true
        calanderTopHeight.constant = 0
    }
    
    
    
}


class CheckBoxGests : UITapGestureRecognizer {
    
    var pos : Int!
    
    var semesterID : String!
    
    var sectionID : String!
    var departsss : String!
    
    var checkBoxss : CheckBoxTwo!
    
    
}

class yearIdClick : UITapGestureRecognizer {
    
    var yearId : String!
    
    var semesterID : String!
    
    var sectionID : String!
    var departsss : String!
}
