//
//  FacultyHomePageViewController.swift
//  GraditFaculty
//
//  Created by MACBOOKPRO on 09/11/22.
//

import UIKit
import ObjectMapper
import DropDown
import WebKit
import KRProgressHUD

@available(iOS 16.0, *)
class FacultyHomePageViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var tapNameview: UIView!
    @IBOutlet weak var tapBarView: UIViewX!
    @IBOutlet weak var redirectLoginView: UIViewX!
    @IBOutlet weak var sectionDropDownLabel: UILabel!
    @IBOutlet weak var sectionDropDownView: UIView!
    @IBOutlet weak var logoutView: UIView!
    @IBOutlet weak var profileView: UIView!
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
    @IBOutlet weak var adView: UIView!
    @IBOutlet weak var bigImg: UIImageView!
    @IBOutlet weak var noDataLabel: UILabel!
    @IBOutlet weak var noDataTextView: UIView!
    @IBOutlet weak var SemesterDropDownView: UIView!
    @IBOutlet weak var facultyTabelViews: UITableView!
    @IBOutlet weak var facultyLabel: UILabel!
    
    let dropDown = DropDown()
    var identifers = "FacultyTableViewCell"
    var addapiRef : [AddDataDeatils] = []
    var facultyDropDownRef : [dropDownDataDetails] = []
    var SelectedSemesterData : dropDownDataDetails?
    var facultyRef  : [facultyDataDetails] = []
    var yearid : Int!
    var colgId   : String!
    var memberId  : String!
    var priority  : String!
    var memberName : String!
    var colgImg  : String!
    var MobileNumber : String!
    var prevoiusAdId : Int = 1
    var password : String!
    var str : [String] = []
    var strName : [String] = []
    var is_read_enabled = ""
    var is_write_enabled = ""
    
    override func viewDidAppear(_ animated: Bool) {
        
        prevoiusAdId = prevoiusAdId+1
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noDataLabel.text = "No data found"
        
        sideMenuView.isHidden = true
        
        SemesterDropDownView.layer.cornerRadius = 10
        SemesterDropDownView.layer.borderWidth = 1
        SemesterDropDownView.layer.borderColor = UIColor.systemGray5.cgColor
        
        sectionDropDownView.layer.cornerRadius = 10
        sectionDropDownView.layer.borderWidth = 1
        sectionDropDownView.layer.borderColor = UIColor.systemGray5.cgColor
        
        facultyTabelViews.showsVerticalScrollIndicator = false
        facultyTabelViews.showsHorizontalScrollIndicator = false
        
        let defaults = UserDefaults.standard
        
        yearid = defaults.integer(forKey: DefaultsKeys.yearid)
        colgId = defaults.string(forKey: DefaultsKeys.collegeid)
        memberId = defaults.string(forKey: DefaultsKeys.memberid)
        priority = defaults.string(forKey: DefaultsKeys.priority)
        memberName = defaults.string(forKey: DefaultsKeys.memberName)
        colgImg = defaults.string(forKey: DefaultsKeys.colglogo)
        clgLogoImg.sd_setImage(with: URL(string:  colgImg), placeholderImage: UIImage(named: "EmptyCollegeIcon"))
        
        topMessageLabel.text = memberName
        
        MobileNumber = defaults.string(forKey: DefaultsKeys.mobileNumber)
        
        password = defaults.string(forKey: DefaultsKeys.Password)
        addApi()
        
        topLabels.text = .priorityRole
        tapBarView.backgroundColor = .priorityColor
        view.backgroundColor = .priorityColor
        
        let rowNib = UINib(nibName: identifers, bundle: nil)
        facultyTabelViews.register(rowNib, forCellReuseIdentifier: identifers)
        
        let  selectSemester = UITapGestureRecognizer(target: self, action: #selector(open_url))
        SemesterDropDownView.addGestureRecognizer(selectSemester)
        
        let  SectionDrowdown = UITapGestureRecognizer(target: self, action: #selector(SectionDropDownVc))
        sectionDropDownView.addGestureRecognizer(SectionDrowdown)
        
        
        let profileGesture = UITapGestureRecognizer(target: self, action: #selector(profileRedirect))
        profileView.addGestureRecognizer(profileGesture)
        
        let loginRediectGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        redirectLoginView.addGestureRecognizer(loginRediectGesture)
        let changeRolesGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        changeRolesView.addGestureRecognizer(changeRolesGesture)
        
        
        let tops = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        tapNameview.addGestureRecognizer(tops)
        
        let logoutGesture = UITapGestureRecognizer(target: self, action: #selector(logoutPressed))
        logoutView.addGestureRecognizer(logoutGesture)
        
        
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
        
        facultyTabelViews.delegate = self
        facultyTabelViews.dataSource = self
        
    }
    
    
    @objc func dismissKeyboards() {
        
        sideMenuView.isHidden = true
        view.endEditing(true)
        
    }
    
    func addApi(){
        
        var add = AddApiModal()
        
        let defaults = UserDefaults.standard
        let deviceToken = defaults.string(forKey:DefaultsKeys.DeviceToken )
        add.device_token = deviceToken
        add.member_id = Int(memberId)
        add.mobile_no = MobileNumber
        add.priority = priority
        add.college_id = Int(colgId)
        add.previous_add_id = prevoiusAdId
        
        APiCallManager.shared.callApi(url: APIEndpoints.GetAddsForCollege, httpMethod: .post, queryParam: nil, requestBody: add
        ) {[weak self] (result:Result<AddApiResponce,Error>) in
            
            guard let self = self else {return}
            
            switch result {
            case .success(let success):
                if success.Status == 1 {
                    addapiRef = success.data ?? []
                    
                    for i in addapiRef{
                        
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
    
    @IBAction func open_url(){
        
        if facultyDropDownRef.isEmpty {
            Get_SemesterAndSection_List()
        }else {
            showSemesterDropDown()
        }
    }
    
    @IBAction func SectionDropDownVc(){
        
        let sectionList = SelectedSemesterData?.sectiondetails?.map{$0.sectionname ?? ""} ?? []
        
        dropDown.dataSource = sectionList
        dropDown.anchorView = sectionDropDownView
        dropDown.bottomOffset = CGPoint(x: 0, y:(self.dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.direction = .bottom
        DropDown.appearance().backgroundColor = UIColor.white
        dropDown.show()
        
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            
            self?.sectionDropDownLabel.text = item
            let sectionid = self?.SelectedSemesterData?.sectiondetails?[index].sectionid
            self?.Get_Faculty_List(sectionId: sectionid ?? "")
            
        }
    }
    
    func showSemesterDropDown() {
        
        let myArray: [String] = self.facultyDropDownRef.map{$0.semestername ?? ""}
        
        self.dropDown.anchorView = self.SemesterDropDownView
        self.dropDown.dataSource = myArray
        self.dropDown.bottomOffset = CGPoint(x: 0, y:(self.dropDown.anchorView?.plainView.bounds.height)!)
        self.dropDown.direction = .top
        DropDown.appearance().backgroundColor = UIColor.white
        self.dropDown.show()
        
        self.dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            
            self?.facultyLabel.text = item
            self?.SelectedSemesterData = self?.facultyDropDownRef[index]
            self?.sectionDropDownLabel.text = "Select Section"
            self?.facultyRef = []
            self?.noDataLabel.isHidden = false
            self?.noDataTextView.isHidden = false
            self?.noDataLabel.text = "No records found"
            self?.facultyTabelViews.reloadData()
        }
    }
    
    func Get_SemesterAndSection_List() {
        
        var faculDrops = dropDownModal()
        faculDrops.yearid = String(yearid)
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.semesterandsectionListforApp,
            httpMethod: .post,
            queryParam: nil,
            requestBody: faculDrops,
            showLoader: false
        ) { [weak self] (result: Result<dropDownResponce, Error>) in
            
            guard let self = self else { return }
            
            switch result {
                
            case .success(let facultyResp):
                
                if facultyResp.Status == 1{
                    
                    self.facultyDropDownRef = facultyResp.data ?? []
                    showSemesterDropDown()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func Get_Faculty_List(sectionId: String) {
        
        var faculty = facultyModal()
        
        faculty.userid = self.memberId
        faculty.appid = "2"
        faculty.priority = self.priority
        faculty.sectionid = sectionId
        faculty.semesterid = SelectedSemesterData?.clgsemesterid
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.FacultyList,
            httpMethod: .post,
            queryParam: nil,
            requestBody: faculty
        ) { [weak self] (result: Result<facultyResponce, Error>) in
            
            guard let self = self else { return }
            
            switch result {
                
            case .success(let facultyResp):
                
                self.facultyRef = facultyResp.data ?? []
                self.noDataLabel.isHidden = !self.facultyRef.isEmpty
                self.noDataTextView.isHidden = !self.facultyRef.isEmpty
                self.noDataLabel.text = facultyResp.Message
                self.facultyTabelViews.reloadData()
                
            case .failure(let error):
                print(error.localizedDescription)
                self.facultyRef = []
                self.noDataLabel.isHidden = false
                self.noDataTextView.isHidden = false
                self.noDataLabel.text = error.localizedDescription
                self.facultyTabelViews.reloadData()
            }
        }
    }
    
    @IBAction func adLoad(gesture : addClick) {
        
        let vc = FacultyVcViewController(nibName: nil, bundle: nil)
        vc.AddImageView = gesture.url
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return facultyRef.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifers, for: indexPath) as!
        FacultyTableViewCell
        
        let faculty : facultyDataDetails = facultyRef[indexPath.row]
        
        cell.cellStafName.text = faculty.staffname
        cell.cellStafType.text = faculty.stafftype
        cell.cellSubjectName.text = faculty.subjectname
        cell.cellSubjectName.isHidden = false
        cell.intractview.isHidden = false
        
        let intract = UITapGestureRecognizer(target: self, action: #selector(intract))
        cell.intractview.addGestureRecognizer(intract)
        
        cell.imageProfileView.sd_setImage(with: URL(string:  faculty.facultyphoto ?? ""), placeholderImage: UIImage(named: "FacultyPencil"))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    @IBAction func intract(){
        
        let vc = ChatHomePageViewController(nibName: nil, bundle: nil)
        vc.strName = strName
        vc.str = str
        vc.is_read_enabled = is_read_enabled
        vc.is_write_enabled = is_write_enabled
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
        
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
        
        sideMenuView.isHidden.toggle()
        
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

class addClick : UITapGestureRecognizer {
    
    var url : String!
}
