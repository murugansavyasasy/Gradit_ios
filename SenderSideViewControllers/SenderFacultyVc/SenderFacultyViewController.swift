//
//  SenderFacultyViewController.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 20/03/23.
//

import UIKit
import ObjectMapper
import KRProgressHUD
import DropDown

@available(iOS 16.0, *)
class SenderFacultyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var topNameview: UIView!
    @IBOutlet weak var tapBarView: UIViewX!
    @IBOutlet weak var redirectLoginView: UIViewX!
    @IBOutlet weak var courseDropDownLabel: UILabel!
    @IBOutlet weak var divisionDropDownLabel: UILabel!
    @IBOutlet weak var logoutView: UIView!
    @IBOutlet weak var changeRolesView: UIView!
    @IBOutlet weak var topLabels: UILabel!
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var topMessageLabel: UILabel!
    @IBOutlet weak var clgLogoImg: UIImageView!
    @IBOutlet weak var changePasswordView: UIView!
    @IBOutlet weak var termsAndConditionView: UIView!
    @IBOutlet weak var helpView: UIView!
    @IBOutlet weak var sideMenuView: UIView!
    @IBOutlet weak var viewTap: UIView!
    @IBOutlet weak var refreshView: UIView!
    @IBOutlet weak var faqView: UIView!
    @IBOutlet weak var privacyPolicyView: UIView!
    @IBOutlet weak var smallImg: UIImageView!
    @IBOutlet weak var bigImg: UIImageView!
    @IBOutlet weak var noDataLabel: UILabel!
    @IBOutlet weak var noDataTextView: UIView!
    @IBOutlet weak var selectDivisionDropDown: UIView!
    @IBOutlet weak var selectCourseDropDown: UIView!
    @IBOutlet weak var tv: UITableView!
    
    var identifers = "FacultyTableViewCell"
    var deparmentRefName: [RepienceDeparmentDataDetails] = []
    var devisionRefName: [getDivisonDataDetails] = []
    var facultyList: [facultySenderDataDetails] = []
    var addapiRef: [AddDataDeatils] = []
    var colgId: String!
    var memberId: String!
    var priority: String!
    var memberName: String!
    var colgImg: String!
    var MobileNumber: String!
    let dropDown = DropDown()
    var password: String!
    var PreviousAddId: Int = 0
    var departmentId: String!
    var str: [String] = []
    var strName: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        
        noDataLabel.text = "No Data Found"
        
        selectDivisionDropDown.layer.cornerRadius = 10
        selectDivisionDropDown.layer.borderWidth = 1
        selectDivisionDropDown.layer.borderColor = UIColor.systemGray5.cgColor
        
        selectCourseDropDown.layer.cornerRadius = 10
        selectCourseDropDown.layer.borderWidth = 1
        selectCourseDropDown.layer.borderColor = UIColor.systemGray5.cgColor
        
        sideMenuView.isHidden = true
        
        let defaults = UserDefaults.standard
      
        colgId = defaults.string(forKey: DefaultsKeys.collegeid)
        memberId = defaults.string(forKey: DefaultsKeys.memberid)
        priority = defaults.string(forKey: DefaultsKeys.priority)
        memberName = defaults.string(forKey: DefaultsKeys.memberName)
        departmentId = defaults.string(forKey: DefaultsKeys.deptid)
        colgImg = defaults.string(forKey: DefaultsKeys.colglogo)
        MobileNumber = defaults.string(forKey: DefaultsKeys.mobileNumber)
        password = defaults.string(forKey: DefaultsKeys.Password)
        
        clgLogoImg.sd_setImage(with: URL(string: colgImg), placeholderImage: UIImage(named: "EmptyCollegeIcon"))

        
        topMessageLabel.text = memberName
        
        addApi()
        
        noDataTextView.isHidden = true
        
        tv.delegate = self
        tv.dataSource = self
        
      if priority == "p2" || priority == "p3"{
            
            selectDivisionDropDown.isHidden = true
            selectCourseDropDown.isHidden = true
            getStaffHodList()
        }
        
        topLabels.text = .priorityRole
        view.backgroundColor = .priorityColor
        tapBarView.backgroundColor = .priorityColor
        
        let rowNib = UINib(nibName: identifers, bundle: nil)
        tv.register(rowNib, forCellReuseIdentifier: identifers)
        
        let selectDivision = UITapGestureRecognizer(target: self, action: #selector(DropDwonVc))
        selectDivisionDropDown.addGestureRecognizer(selectDivision)
        
        let CourseDivision = UITapGestureRecognizer(target: self, action: #selector(CourseDropDwonVc))
        selectCourseDropDown.addGestureRecognizer(CourseDivision)
        
        let changeRolesGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        changeRolesView.addGestureRecognizer(changeRolesGesture)
        
        let topname = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        topNameview.addGestureRecognizer(topname)
        
        let logoutGesture = UITapGestureRecognizer(target: self, action: #selector(logoutPressed))
        logoutView.addGestureRecognizer(logoutGesture)
        
        let loginRediectGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        redirectLoginView.addGestureRecognizer(loginRediectGesture)
        
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
        
        let chagePassword = UITapGestureRecognizer(target: self, action: #selector(changePassowrdVC))
        changePasswordView.addGestureRecognizer(chagePassword)
    }
    
    override func viewDidAppear(_ animated: Bool) {
     
        PreviousAddId = PreviousAddId + 1
    }
    
    @objc func dismissKeyboards() {
        
        sideMenuView.isHidden = true
        view.endEditing(true)
    }
    
    @IBAction func CourseDropDwonVc() {
        
        dropDown.show()
    }
    
    @IBAction func DropDwonVc() {
        
        var devisions = getDivisionModal()
        
        devisions.college_id = colgId
        devisions.user_id = memberId
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.GetDivisions,
            httpMethod: .post,
            queryParam: nil,
            requestBody: devisions,
            showLoader: false
        ) { [weak self] (result: Result<GetDivisionResponce, Error>) in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let success):
                
                devisionRefName = success.data ?? []
                
               let myArray = devisionRefName.map { $0.division_name ?? ""}
                
                dropDown.dataSource = myArray
                dropDown.anchorView = selectDivisionDropDown
                dropDown.bottomOffset = CGPoint(x: 0, y: (dropDown.anchorView?.plainView.bounds.height)!)
                dropDown.direction = .bottom
                DropDown.appearance().backgroundColor = UIColor.white
                dropDown.show()
            
                dropDown.selectionAction = { [weak self] (index: Int, item: String) in
                    
                    self?.divisionDropDownLabel.text = item
                    let divisionId = self?.devisionRefName[index].division_id ?? ""
                    self?.Get_departmentList(divisionId: divisionId)
                }
                
            case .failure(let failure):
                print("Error:", failure.localizedDescription)
            }
        }
    }
        
    func Get_departmentList(divisionId: String) {
        
        var deparment = DepartmentModal()
        
        deparment.user_id = self.memberId
        deparment.college_id = self.colgId
        deparment.div_id = divisionId
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.GetDepartmentsbyDivision,
            httpMethod: .post,
            queryParam: nil,
            requestBody: deparment
        ) { [weak self] (result: Result<RepienceDeparmentResponce, Error>) in
            
            guard let self = self else { return }
            
            switch result {
                
            case .success(let success):
                
                self.deparmentRefName = success.data ?? []
                
                let departmentName = self.deparmentRefName.map{$0.department_name ?? ""}
                
                self.dropDown.dataSource = departmentName
                self.dropDown.anchorView = self.selectCourseDropDown
                self.dropDown.bottomOffset = CGPoint(x: 0, y: (self.dropDown.anchorView?.plainView.bounds.height)!)
                self.dropDown.direction = .bottom
                DropDown.appearance().backgroundColor = UIColor.white
                self.dropDown.show()
                
                self.dropDown.selectionAction = { [weak self] (index: Int, item: String) in
                    self?.courseDropDownLabel.text = item
                    let departmentId = self?.deparmentRefName[index].department_id ?? ""
                    self?.Get_FacultyList(departmentId: departmentId)
                }
                case .failure(let failure):
                    print("Error:", failure.localizedDescription)
            }
        }
    }
    
    func Get_FacultyList(departmentId: String) {
        
        var faculty = FacultyListSenderApp()
        
        faculty.userid = self.memberId
        faculty.appid = "2"
        faculty.priority = self.priority
        faculty.deptid = departmentId
      //faculty.courseid = idArray[index]
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.FacultyListforPrincipalLoginSenderApp,
            httpMethod: .post,
            queryParam: nil,
            requestBody: faculty
        ) { [weak self] (result: Result<FacultyResponce, Error>) in
            
            guard let self = self else { return }
            
            switch result {
                
            case .success(let facultyResp):
                
                if facultyResp.Status == 1 {
                    
                    self.facultyList = facultyResp.data ?? []
                    
                    self.noDataTextView.alpha = 0
                    self.noDataLabel.alpha = 0
                    self.tv.reloadData()
                    
                } else {
                    self.facultyList = facultyResp.data ?? []
                    self.noDataTextView.alpha = 1
                    self.noDataLabel.alpha = 1
                    self.noDataTextView.isHidden = false
                    self.tv.reloadData()
                    
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                
                self.facultyList = []
                self.noDataTextView.alpha = 1
                self.noDataLabel.alpha = 1
                self.noDataTextView.isHidden = false
                self.tv.reloadData()
            }
        }
    }
        
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return facultyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifers, for: indexPath) as! FacultyTableViewCell
        
        let faculty = facultyList[indexPath.row]
        
        cell.cellStafName.text = faculty.staffname
        cell.cellStafType.text = faculty.stafftype
        cell.imageProfileView.sd_setImage(with: URL(string: faculty.facultyphoto ?? ""), placeholderImage: UIImage(named: "FacultyPencil"))
        cell.intractview.isHidden = true
        cell.separatorView.isHidden = true
        cell.subjectStack.isHidden = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    @IBAction func adLoad(gesture: FacultyAddsss) {
        
        let vc = SenderExamAddVcViewController(nibName: nil, bundle: nil)
        
        vc.AddWebUrl = gesture.addUrls
        
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    func getStaffHodList() {
        
        var staffHod = FacultyListSenderApp()
        
        staffHod.userid = memberId
        staffHod.appid = String(2)
        staffHod.priority = priority
        staffHod.deptid = departmentId
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.FacultyListForSenderApp,
            httpMethod: .post,
            queryParam: nil,
            requestBody: staffHod
        ) { [weak self] (result: Result<FacultyResponce, Error>) in
            
            guard let self = self else { return }
            
            switch result {
                
            case .success(let staffHodRess):
                
                self.facultyList = staffHodRess.data ?? []
                
                if staffHodRess.Status == 1 {
                    
                    self.noDataTextView.isHidden = true
                    self.tv.reloadData()
                    
                }else {
                    
                    self.noDataTextView.isHidden = false
                    self.noDataLabel.text = staffHodRess.Message
                    self.tv.reloadData()
                }
                
            case .failure(let error):
                print("API Error:", error.localizedDescription)
            }
        }
    }
    
    func addApi() {
        
        var add = AddApiModal()
        
        let defaults = UserDefaults.standard
        var deviceToken = defaults.string(forKey: DefaultsKeys.DeviceToken)
        add.device_token = deviceToken
        add.member_id = Int(memberId)
        add.mobile_no = MobileNumber
        add.priority = priority
        add.college_id = Int(colgId)
        add.previous_add_id = PreviousAddId
        
        APiCallManager.shared.callApi(url: APIEndpoints.GetAddsForCollege, httpMethod: .post, queryParam: nil, requestBody: add
        ) { [weak self] (result: Result<AddApiResponce, Error>) in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let success):
                if success.Status == 1 {
                    addapiRef = success.data ?? []
                    
                    for i in addapiRef {
                        
                        bigImg.sd_setImage(with: URL(string: i.background_image ?? ""), placeholderImage: UIImage(named: "Default_Ad"))
                        
                        smallImg.sd_setImage(with: URL(string: i.add_image ?? ""), placeholderImage: UIImage(named: "Default_Ad"))
                        
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
            
            let vc = LoginVc(nibName: nil, bundle: nil)
            vc.modalPresentationStyle = .fullScreen
            
            self.present(vc, animated: true, completion: nil)
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "NO", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        present(refreshAlert, animated: true, completion: nil)
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
    
    @IBAction func refreshVc() {
    
        KRProgressHUD.show()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            KRProgressHUD.dismiss()
        }
    }
    
    @IBAction func notificationVc() {
        let vc = NotificationViewController(nibName: nil, bundle: nil)
        vc.str = str
        vc.strName = strName
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false, completion: nil)
    }
    
    @IBAction func menu() {
       sideMenuView.isHidden.toggle()
    }
    
    @IBAction func changePassowrdVC() {
        
        let vc = ChangePasswordVC(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func profileRedirect() {
        
        let vc = ProfileViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }

    @IBAction func priorityVc() {
        
        let vc = PriorityScreenVC(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}

class FacultyAddsss: UITapGestureRecognizer {
    
    var addUrls: String!
}
