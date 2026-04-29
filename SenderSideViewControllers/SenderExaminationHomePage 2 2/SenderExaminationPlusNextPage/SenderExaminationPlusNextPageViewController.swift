//
//  SenderExaminationPlusNextPageViewController.swift
//  GraditSenderExaminationMenu
//
//  Created by MACBOOKPRO on 03/12/22.
//

import UIKit
import KRProgressHUD
import ObjectMapper
import DropDown

@available(iOS 16.0, *)
class SenderExaminationPlusNextPageViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var vtopNameview: UIView!
    @IBOutlet weak var tapBarView: UIViewX!
    
    @IBOutlet weak var clearCacheView: UIView!
    @IBOutlet weak var redirectLoginView: UIViewX!
    @IBOutlet weak var examNameTextField: UITextField!
    
    @IBOutlet weak var getSubAndSecView: UIView!
    
    @IBOutlet weak var semesterLabel: UILabel!
    
    @IBOutlet weak var yearLabel: UILabel!
    
    @IBOutlet weak var courseNameLabel: UILabel!
    
    @IBOutlet weak var departmentLabel: UILabel!
    @IBOutlet weak var divisionSelectedLabel: UILabel!
    @IBOutlet weak var selectYearDropDown: UIViewX!
    
    @IBOutlet weak var selectCourseDropDown: UIViewX!
    @IBOutlet weak var selectDepartDropDown: UIViewX!
    @IBOutlet weak var selectDivisionDropDown: UIViewX!
    @IBOutlet weak var fromDateLabel: UILabel!
    
    @IBOutlet weak var toDateLabel: UILabel!
    @IBOutlet weak var TodateView: UIViewX!
    
    @IBOutlet weak var calanderView: UIViewX!
    
    @IBOutlet weak var loginView: UIView!
    
    @IBOutlet weak var logoutView: UIView!
    
    @IBOutlet weak var changeRolesView: UIView!
    
    @IBOutlet weak var topLabels: UILabel!
    
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var clgLogoImg: UIImageView!
    @IBOutlet weak var changePasswordView: UIView!
    
    @IBOutlet weak var topMessageLabel: UILabel!
    
    @IBOutlet weak var termsAndConditionView: UIView!
    
    
    
    @IBOutlet weak var helpView: UIView!
    
    
    
    @IBOutlet weak var selectSemesterDropDown: UIViewX!
    
    @IBOutlet weak var sideMenuView: UIView!
    
    
    @IBOutlet weak var viewTap: UIView!
    
    @IBOutlet weak var refreshView: UIView!
    
    
    
    @IBOutlet weak var faqView: UIView!
    
    @IBOutlet weak var privacyPolicyView: UIView!
    
    @IBOutlet weak var smallImg: UIImageView!
    @IBOutlet weak var bigImg: UIImageView!
    
    var addImageBackGroundurl : String?
    var imageWebUrl : String!
    var smallImageUrl  : String!
    
    
    let dropDown = DropDown()
    var courseRefName : [getCourseDataDetails] = []
    var devisionRefName : [getDivisonDataDetails] = []
    var deparmentRefName : [RepienceDeparmentDataDetails] = []
    var yearRef : [getYearListDataDetails] = []
    var facultyDropDownRef : [dropDownDataDetails] = []
    var courseTypeId : String! = ""
    
    var display_date : String!
    var memberName : String!
    var url_date : String!
    var colgImg : String!
    var priority : String!
    var colgId : String!
    var memberID : String!
    
    var departsss : String! = ""
    var sectionID : String! = ""
    var yearIdsew : String! = ""
    
    var MobileNumber : String!
    var password : String!
    
    var loginDatas : [datalogin]!
    var logindataprinci :[datalogin]!
    
//    var examsectionRef : [SectiondetailRef]!
    var semid : String!
    
    var activeDateField: String?   // "from" or "to"
    var fromDate: Date?
    var toDate: Date?
    
    var str : [String] = []
    var strName : [String] = []
    var is_read_enabled = ""
    var is_write_enabled = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("sert5",smallImageUrl)
        
        bigImg.sd_setImage(with: URL(string: addImageBackGroundurl ?? ""), placeholderImage: UIImage(named: "ic_white"))
        smallImg.sd_setImage(with: URL(string: smallImageUrl ), placeholderImage: UIImage(named: "ic_white"))
        
        
        fromDateLabel.text = "-SelectDate-"
        toDateLabel.text = "-SelectDate-"
        
        sideMenuView.isHidden = true

        let defaults = UserDefaults.standard
        memberName = defaults.string(forKey: DefaultsKeys.memberName)
        priority = defaults.string(forKey: DefaultsKeys.priority)
        colgId = defaults.string(forKey: DefaultsKeys.collegeid)
        memberID = defaults.string(forKey: DefaultsKeys.memberid)
        colgImg = defaults.string(forKey: DefaultsKeys.colglogo)
        clgLogoImg.sd_setImage(with: URL(string:  colgImg), placeholderImage: UIImage(named: "EmptyCollegeIcon"))
        
        topMessageLabel.text = memberName
        
        
        MobileNumber = defaults.string(forKey: DefaultsKeys.mobileNumber)
        
        password  = defaults.string(forKey: DefaultsKeys.Password)
        
        if priority == "p1"{
            tapBarView.backgroundColor = UIColor(named: "Principal" )
            topLabels.text = "Principal"
            
        }
        
        else if priority == "p4"{
            
            topLabels.text = "Student"
            
        }
        
        else if priority == "p2" || priority == "p3"{
            
            tapBarView.backgroundColor = UIColor(named: "Teaching Staff" )
            topLabels.text = "Teacher"
            
        }
        
        else if priority == "p5"{
            
            
            topLabels.text = "Father"
            
            
            
        }
        examNameTextField.returnKeyType = .done
        examNameTextField.delegate = self
        
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(adLoad))
        
        bigImg.isUserInteractionEnabled = true
        bigImg.addGestureRecognizer(singleTap)
        
        let departMentDropDown = UITapGestureRecognizer(target: self, action: #selector(departmentDropDownVc))
        
        
        selectDepartDropDown.addGestureRecognizer(departMentDropDown)
        
        
        let DevisionDown = UITapGestureRecognizer(target: self, action: #selector(devisionVc))
        
        
        selectDivisionDropDown.addGestureRecognizer(DevisionDown)
        
        
        let getSectionView = UITapGestureRecognizer(target: self, action: #selector(getSubAndSecVc))
        
        
        getSubAndSecView.addGestureRecognizer(getSectionView)
        
        
        
        let CourseDown = UITapGestureRecognizer(target: self, action: #selector(CourseDropDownVc))
        
        
        selectCourseDropDown.addGestureRecognizer(CourseDown)
        
        
        
        let YearDown = UITapGestureRecognizer(target: self, action: #selector(YearDropDownVc))
        
        
        selectYearDropDown.addGestureRecognizer(YearDown)
        
        
        
        let SemesterDown = UITapGestureRecognizer(target: self, action: #selector(semesterDropDownVc))
        
        
        selectSemesterDropDown.addGestureRecognizer(SemesterDown)
        
        
        // tap Bar UiTapGuster.
        
        
        let menuGestureHide = UITapGestureRecognizer(target: self, action: #selector(menu))
        viewTap.addGestureRecognizer(menuGestureHide)
        
        
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
        
        let loginRediectGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        redirectLoginView.addGestureRecognizer(loginRediectGesture)
        
        let chagePassword = UITapGestureRecognizer(target: self, action: #selector(changePassowrdVC))
        changePasswordView.addGestureRecognizer(chagePassword)
        
        let changeRol = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        changeRolesView.addGestureRecognizer(changeRol)
        
        
        let topname = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        vtopNameview.addGestureRecognizer(topname)
        
        
        let logoutGesture = UITapGestureRecognizer(target: self, action: #selector(logoutPressed))
        loginView.addGestureRecognizer(logoutGesture)
        
        
        let calanderViewclick = UITapGestureRecognizer(target: self, action: #selector(calanderClickVc))
        calanderView.addGestureRecognizer(calanderViewclick)
        
        let todateClick = UITapGestureRecognizer(target: self, action: #selector(todateClick))
        TodateView.addGestureRecognizer(todateClick)
        
        
    }
    
    
    func getCurrentViewController() -> UIViewController? {
        
        if let rootController = UIApplication.shared.keyWindow?.rootViewController {
            var currentController: UIViewController! = rootController
            while( currentController.presentedViewController != nil ) {
                currentController = currentController.presentedViewController
            }
            return currentController
        }
        return nil
        
    }
    
    
    
    
    @IBAction func getSubAndSecVc(){
        
        if examNameTextField.text == ""{
            
            let refreshAlert = UIAlertController(title: "", message: "Please Enter ExamName", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
            }))
            
            present(refreshAlert, animated: true, completion: nil)
            
        }else if fromDateLabel.text == "-SelectDate-"{
            
            let refreshAlert = UIAlertController(title: "", message: "Please Select FromDate", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
                
            }))
            
            present(refreshAlert, animated: true, completion: nil)
            
        }else if toDateLabel.text == "-SelectDate-"{
            
            let refreshAlert = UIAlertController(title: "", message: "Please Select FromDate", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
            }))
            
            
            present(refreshAlert, animated: true, completion: nil)
            
        } else if divisionSelectedLabel.text == "Select Division"{
            
            let refreshAlert = UIAlertController(title: "", message: "Please Select Division", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
                
            }))
            
            present(refreshAlert, animated: true, completion: nil)
            
        }else if departmentLabel.text == "Select Department"{
            
            let refreshAlert = UIAlertController(title: "", message: "Please Select Department", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
            }))
            
            
            present(refreshAlert, animated: true, completion: nil)
            
        }else if courseNameLabel.text == "Select Courrse"{
            
            let refreshAlert = UIAlertController(title: "", message: "Please Select Courrs", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
            }))
            
            
            present(refreshAlert, animated: true, completion: nil)
            
        } else if yearLabel.text == "Select Year"{
            
            let refreshAlert = UIAlertController(title: "", message: "Please Select Year", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
            }))
            
            present(refreshAlert, animated: true, completion: nil)
        } else if semesterLabel.text == "Select Semester"{
            
            let refreshAlert = UIAlertController(title: "", message: "Please Select Semester", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
            }))
            
            present(refreshAlert, animated: true, completion: nil)
            
        }else{
           
            let vc = GetSectionAndViewController(nibName: nil, bundle: nil)
            vc.semsterID = semid
            vc.examName = examNameTextField.text
            vc.startDate = fromDateLabel.text
            vc.endDate = toDateLabel.text
            vc.departmentId = departsss
            vc.addImageBackGroundurl = addImageBackGroundurl
            vc.strName = strName
            vc.str = str
            vc.smallImageUrl = addImageBackGroundurl
            vc.imageWebUrl = imageWebUrl
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true,completion: nil)
            
        }
    }
    
    @IBAction func semesterDropDownVc(){
        
        
        dropDown.show()
        
    }
    
    
    
    
    
    @IBAction func departmentDropDownVc(){
        
        
        dropDown.show()
        
    }
    
    
    @IBAction func YearDropDownVc(){
        
        
        dropDown.show()
        
    }
    
    @IBAction func CourseDropDownVc(){
        
        
        dropDown.show()
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        examNameTextField.resignFirstResponder()
        return true
    }
    
    
    func dropDowns() {

        var divisionsRequest = getDivisionModal()
        divisionsRequest.college_id = colgId
        divisionsRequest.user_id = memberID

        APiCallManager.shared.callApi(
            url: APIEndpoints.GetDivisions,
            httpMethod: .post,
            queryParam: nil,
            requestBody: divisionsRequest,
            showLoader: false
        ) { [weak self] (result: Result<GetDivisionResponce, Error>) in

            guard let self = self else { return }

            switch result {

            case .success(let response):

                self.devisionRefName = response.data ?? []

                let divisionNames = self.devisionRefName.map { $0.division_name ?? "" }
                let divisionIds   = self.devisionRefName.map { $0.division_id ?? "" }

                    self.configureDropDown(
                        data: divisionNames,
                        anchor: self.selectDivisionDropDown
                    )
                

                self.dropDown.selectionAction = { [unowned self] index, item in

                    self.divisionSelectedLabel.text = item
                    let selectedDivisionId = divisionIds[index]
                    self.courseTypeId = selectedDivisionId

                    var departmentRequest = DepartmentModal()
                    departmentRequest.user_id = self.memberID
                    departmentRequest.college_id = self.colgId
                    departmentRequest.div_id = selectedDivisionId

                    self.fetchDepartments(request: departmentRequest)
                }

            case .failure(let error):
                print("Error:", error.localizedDescription)
            }
        }
    }

    // MARK: - Departments
    private func fetchDepartments(request: DepartmentModal) {

        APiCallManager.shared.callApi(
            url: APIEndpoints.GetDepartmentsbyDivision,
            httpMethod: .post,
            queryParam: nil,
            requestBody: request,
            showLoader: false
        ) { [weak self] (result: Result<RepienceDeparmentResponce, Error>) in

            guard let self = self else { return }

            switch result {

            case .success(let response):

                self.deparmentRefName = response.data ?? []

                let departmentNames = self.deparmentRefName.map { $0.department_name ?? "" }
                let departmentIds   = self.deparmentRefName.map { $0.department_id ?? "" }

                self.configureDropDown(
                    data: departmentNames,
                    anchor: self.selectDepartDropDown
                )

                self.dropDown.selectionAction = { [unowned self] index, item in

                    self.departmentLabel.text = item
                    let selectedDeptId = departmentIds[index]
                    self.departsss = selectedDeptId

                    var courseRequest = getCourseModal()
                    courseRequest.user_id = self.memberID
                    courseRequest.college_id = self.colgId
                    courseRequest.dept_id = selectedDeptId

                    self.fetchCourses(request: courseRequest)
                }

            case .failure(let error):
                print("Error:", error.localizedDescription)
            }
        }
    }

    // MARK: - Courses
    private func fetchCourses(request: getCourseModal) {

        APiCallManager.shared.callApi(
            url: APIEndpoints.GetCoursesByDepartment,
            httpMethod: .post,
            queryParam: nil,
            requestBody: request
        ) { [weak self] (result: Result<getCourseResponce, Error>) in

            guard let self = self else { return }

            switch result {

            case .success(let response):

                self.courseRefName = response.data ?? []

                let courseNames = self.courseRefName.map { $0.course_name ?? "" }
                let courseIds   = self.courseRefName.map { $0.course_id ?? "" }

                self.configureDropDown(
                    data: courseNames,
                    anchor: self.selectCourseDropDown
                )

                self.dropDown.selectionAction = { [unowned self] index, item in

                    self.courseNameLabel.text = item

                    var yearRequest = getYearListModal()
                    yearRequest.idcollege = self.colgId
                    yearRequest.clgprocessby = self.memberID
                    yearRequest.idcourse = courseIds[index]
                    yearRequest.iddept = self.departsss

                    self.fetchYears(request: yearRequest)
                }

            case .failure(let error):
                print("Error:", error.localizedDescription)
            }
        }
    }

    // MARK: - Years
    private func fetchYears(request: getYearListModal) {

        APiCallManager.shared.callApi(
            url: APIEndpoints.GetYearListforApp,
            httpMethod: .post,
            queryParam: nil,
            requestBody: request,
            showLoader: false
        ) { [weak self] (result: Result<getYearListResponce, Error>) in

            guard let self = self else { return }

            switch result {

            case .success(let response):

                self.yearRef = response.data ?? []

                let yearNames = self.yearRef.map { $0.yearname ?? "" }
                let yearIds   = self.yearRef.map { $0.yearid ?? 0 }

                self.configureDropDown(
                    data: yearNames,
                    anchor: self.selectYearDropDown
                )

                self.dropDown.selectionAction = { [unowned self] index, item in

                    self.yearLabel.text = item

                    var semesterRequest = dropDownModal()
                    semesterRequest.yearid = String(yearIds[index])

                    self.fetchSemesters(request: semesterRequest)
                }

            case .failure(let error):
                print("Error:", error.localizedDescription)
            }
        }
    }

    // MARK: - Semesters
    private func fetchSemesters(request: dropDownModal) {

        APiCallManager.shared.callApi(
            url: APIEndpoints.semesterandsectionListforApp,
            httpMethod: .post,
            queryParam: nil,
            requestBody: request,
            showLoader: false
        ) { [weak self] (result: Result<dropDownResponce, Error>) in

            guard let self = self else { return }

            switch result {

            case .success(let response):

                self.facultyDropDownRef = response.data ?? []

                let semesterNames = self.facultyDropDownRef.map {
                    $0.semestername ?? ""
                }
                
              
                    
                    self.configureDropDown(
                        data: semesterNames,
                        anchor: self.selectSemesterDropDown
                    )

                

                
                self.dropDown.selectionAction = { [unowned self] index, item in

                    self.semesterLabel.text = item

                    for semester in response.data ?? [] {
                        self.semid = semester.clgsemesterid

                        for section in semester.sectiondetails ?? [] {
                            self.sectionID = section.sectionid
                        }
                    }
                }

            case .failure(let error):
                print("Error:", error.localizedDescription)
            }
        }
    }

    // MARK: - Common Dropdown Config
    private func configureDropDown(data: [String], anchor: UIView) {

        dropDown.dataSource = data
        dropDown.anchorView = anchor
        dropDown.bottomOffset = CGPoint(
            x: 0,
            y: anchor.bounds.height
        )
        dropDown.direction = .bottom
        DropDown.appearance().backgroundColor = .white
        dropDown.show()
    }
    
    
    
    @IBAction func devisionVc(){
        
        dropDowns()
    }
    
    @IBAction func adLoad(){
        
        
        
        let vc = TotalAddLoadPageViewController(nibName: nil, bundle: nil)
        
        vc.AddWebUrl = imageWebUrl
        
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
        
        
    }
    
    
    
    @IBAction func calanderClickVc(){
        toDateLabel.text = "DD/MM/YYY"
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
            
            self.toDateLabel.text = display
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
    
    
    @IBAction func dte(_ sender: UIDatePicker) {
        print("print \(sender.date)")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/M/yyyy"
        let somedateString = dateFormatter.string(from: sender.date)
        
        
        toDateLabel.text = somedateString
        print(somedateString)
    }
    
    
    
    
    @IBAction func backbtn(_ sender: Any) {
        
        dismiss(animated: true)
        
    }
    
    
    // Tab Bar Nagivation
    
    
    
    @IBAction func helpRedirect() {
        
        let vc = HelpViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        let currentController = self.getCurrentViewController()
        currentController?.present(vc, animated: true, completion: nil)
        
        
    }
    
    
    @IBAction func termsAndCondition() {
        
        let vc = MenuTermsViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        let currentController = self.getCurrentViewController()
        currentController?.present(vc, animated: true, completion: nil)
        
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
        let currentController = self.getCurrentViewController()
        currentController?.present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func privacyPolicyRedirect() {
        
        let vc = PrivacyPolicyViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        let currentController = self.getCurrentViewController()
        currentController?.present(vc, animated: true, completion: nil)
        
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
        let currentController = self.getCurrentViewController()
        currentController?.present(vc, animated: false, completion: nil)
        
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
        let currentController = self.getCurrentViewController()
        currentController?.present(vc, animated: true, completion: nil)
        
        
    }
    
    
    @IBAction func priorityVc() {
        let vc = PriorityViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
    }
    
}
