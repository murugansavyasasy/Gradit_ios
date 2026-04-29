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
    @IBOutlet weak var TodateView: UIViewX!
    @IBOutlet weak var fromDateView: UIViewX!
    @IBOutlet weak var redirectLoginView: UIViewX!
    @IBOutlet weak var getSelectionView: UIView!
    @IBOutlet weak var logoutView: UIView!
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
    @IBOutlet weak var smallImg: UIImageView!
    @IBOutlet weak var bigImg: UIImageView!
    @IBOutlet weak var tv: UITableView!
    
    var addImageBackGroundurl : String!
    var imageWebUrl : String!
    var smallImageUrl  : String!
    var selectedCell : IndexPath?
    var identifier = "HodRespienTableViewCell"
    var ParticalStaffRef : [particualrDataDetails] = []
    var facultyDropDownRef : [dropDownDataDetails] = []
    var resiverId : [String] = []
    var memberId : String!
    var clgId : String!
    var colgImg :String!
    var priority : String!
    var MobileNumber : String!
    var display_date : String!
    var url_date : String!
    var password : String!
    var str : [String] = []
    var strName : [String] = []
    var sectionID : String!
    var deptid : String!
    var courseId : String!
    var yearId : String!
    var SelectedIndex : IndexPath?
    var SubjectId : String!
    var is_read_enabled = ""
    var is_write_enabled = ""
    var activeDateField: String?   // "from" or "to"
    var fromDate: Date?
    var toDate: Date?
    var selectedClass: particualrDataDetails?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        fromDateLabel.text = "DD/MM/YYY"
        todateLabel.text = "DD/MM/YYY"
        
        sideMenuView.isHidden = true
        
        bigImg.sd_setImage(with: URL(string: addImageBackGroundurl), placeholderImage: UIImage(named: "ic_white"))
        smallImg.sd_setImage(with: URL(string: smallImageUrl ), placeholderImage: UIImage(named: "ic_white"))
        
        
        let defaults = UserDefaults.standard
        
        memberId = defaults.string(forKey: DefaultsKeys.memberid)
        clgId = defaults.string(forKey: DefaultsKeys.collegeid)
        priority = defaults.string(forKey: DefaultsKeys.priority)
        topMessageLabel.text = defaults.string(forKey: DefaultsKeys.memberName)
        colgImg = defaults.string(forKey: DefaultsKeys.colglogo)
        clgLogoImg.sd_setImage(with: URL(string:  colgImg), placeholderImage: UIImage(named: "EmptyCollegeIcon"))
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
        
        let getSelection = UITapGestureRecognizer(target: self, action: #selector(getSelectionVc))
        getSelectionView.addGestureRecognizer(getSelection)
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
        
        // 🚫 Block if From Date not selected
        guard let start = fromDate else {
            let alert = UIAlertController(title: "",
                                          message: "Select from date first",
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        activeDateField = "to"
        
        RPicker.selectDate(title: "Select To Date",
                           cancelText: "Cancel",
                           datePickerMode: .date,
                           minDate: start,   // ✅ key logic
                           style: .Inline,
                           didSelectDate: { [weak self] selectedDate in
            
            guard let self = self else { return }
            
            self.toDate = selectedDate
            
            let display = selectedDate.dateString("dd/MM/yyyy")
            let api = selectedDate.dateString("yyyy-M-dd")
            
            self.todateLabel.text = display
        })
        
    }
    
    
    func FromDate_Action(){
        
        activeDateField = "from"
        
        RPicker.selectDate(title: "Select From Date",
                           cancelText: "Cancel",
                           datePickerMode: .date,
                           minDate: Date(),   // or Date() if you want only future
                           style: .Inline,
                           didSelectDate: { [weak self] selectedDate in
            
            guard let self = self else { return }
            
            self.fromDate = selectedDate
            self.toDate = nil   // 🔥 reset To Date when From Date changes
            
            let display = selectedDate.dateString("dd/MM/yyyy")
            let api = selectedDate.dateString("yyyy-M-dd")
            
            self.fromDateLabel.text = display
            
        })
        
    }
    
    
    @IBAction func getSelectionVc(){
        
        if examNameTextField.text == ""{
            
            let refreshAlert = UIAlertController(title: "", message: "Please Enter Exam Name ", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
               
            }))
            
            present(refreshAlert, animated: true, completion: nil)
            
        } else if fromDateLabel.text == "DD/MM/YYY"{
           
            let refreshAlert = UIAlertController(title: "", message: "Please Enter From Date ", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
            }))
            present(refreshAlert, animated: true, completion: nil)
            
        } else if todateLabel.text == "DD/MM/YYY"{
            
            let refreshAlert = UIAlertController(title: "", message: "Please Enter To Date ", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                  
            }))
            
            present(refreshAlert, animated: true, completion: nil)
            
        } else if selectedClass == nil{
            
            let refreshAlert = UIAlertController(title: "", message: "Please Select Course  ", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
            }))
            
            present(refreshAlert, animated: true, completion: nil)
        }else {
               
                let vc =  GetSectionAndViewController(nibName: nil, bundle: nil)
                
                var subject = getSectionDatasDetails()
                subject.subjectid = selectedClass?.subjectid
                subject.subjectname = selectedClass?.subjectname
                
                var sectionData = getSubjectWiseDataDetails()
                sectionData.sectionid = selectedClass?.sectionid
                sectionData.sectionname = selectedClass?.sectionname
                sectionData.subjectdetails = [subject]
                vc.getSection = [sectionData]
                vc.isStaff = true
                vc.semsterID = selectedClass?.semesterid
                vc.examName = examNameTextField.text
                vc.startDate = fromDateLabel.text
                vc.endDate = todateLabel.text
                vc.departmentId = selectedClass?.departmentid
                vc.addImageBackGroundurl = addImageBackGroundurl
                vc.strName = strName
                vc.str = str
                vc.smallImageUrl = addImageBackGroundurl
                vc.imageWebUrl = imageWebUrl
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.modalPresentationStyle = .fullScreen
                
                present(vc, animated: true,completion: nil)
                
            }
    }
    
    
    
    @IBAction func backBtn(_ sender: Any) {
        
        dismiss(animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ParticalStaffRef.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! HodRespienTableViewCell
        
        let subject : particualrDataDetails = ParticalStaffRef[indexPath.row]
        
        cell.checkBoxView.isHidden = true
        cell.CheckImageView.isHidden = true
        
        
        if(indexPath == SelectedIndex){
            
            cell.CellFullView.backgroundColor = UIColor(named: "eventdashcolorr")
        } else{
            
            cell.CellFullView.backgroundColor = UIColor(named: "MarkTableViewColor")
        }
        
        cell.SecLabel.text = subject.sectionname
        cell.SemesterLabel.text = subject.semestername
        cell.SubjectNameLabel.text = subject.subjectname
        cell.courseNameLabel.text = subject.coursename
        cell.yearLabel.text = subject.yearname
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        SelectedIndex = indexPath
        selectedClass = ParticalStaffRef[indexPath.row]
        tv.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 130
    }
    
    
    
    func subject(){
        
        
        var subj = ParticularStaffModal()
        
        subj.collegeid = clgId
        subj.staffid = memberId
        
        APiCallManager.shared.callApi(
                url: APIEndpoints.GetSubjectListforparticularstaff,
                httpMethod: .post,
                queryParam: nil,
                requestBody: subj
            ) {[weak self] (result:Result<particularStaffResponce, Error>) in
                    
                guard let self = self else { return }
                
                switch result {
                case .success(let success):
                    
                    if success.Status == 1{
                        
                        ParticalStaffRef = success.data ?? []
                        
                        tv.delegate = self
                        tv.dataSource = self
                        tv.reloadData()
                    }else{
                        
                        let refreshAlert = UIAlertController(title: "", message: success.Message, preferredStyle: UIAlertController.Style.alert)
                        
                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                             
                        }))
                        
                        present(refreshAlert, animated: true, completion: nil)
                        
                        tv.delegate = self
                        tv.dataSource = self
                        tv.reloadData()
                    }
                    
                case .failure(let failure):
                     print("Error:",failure.localizedDescription)
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
        let vc = PriorityViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
    }
    
}

