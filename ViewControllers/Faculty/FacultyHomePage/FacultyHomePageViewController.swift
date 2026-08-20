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
    @IBOutlet weak var sectionNameDropDown: UIViewX!
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
    @IBOutlet weak var facultyDropDownView: UIViewX!
    @IBOutlet weak var facultyTabelViews: UITableView!
    @IBOutlet weak var facultyLabel: UILabel!
    
    
    let dropDown = DropDown()
    var loginDatas : [datalogin]!
    var logindataprinci :[datalogin]!
    var identifers = "FacultyTableViewCell"
    var addapiRef : [AddDataDeatils] = []
    var facultyDropDownRef : [dropDownDataDetails] = []
    var facultyRef  : [facultyDataDetails] = []
    var facultyssss : [dropDownSectionDetails] = []
    let menuIdentifier = "MenuCollectionViewCell"
    var MenuRefName :[menuApiDataDetails] = []
    var facultyee : [dropDownSectionDetails] = []
    var values : String!
    var yearid : Int!
    var sectionid : String!
    var semesterid : String!
    var  colgId   : String!
    var memberId  : String!
    var priority  : String!
    var loginType : String!
    var memberName : String!
    var colgImg  : String!
    var MobileNumber : String!
    var dropType = ""
    var prevoiusAdId : Int = 1
    var password : String!
    var str : [String] = []
    var strName : [String] = []
    var is_read_enabled = ""
    var is_write_enabled = ""
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        print("kljjjjjjjjj")
        prevoiusAdId = prevoiusAdId+1
        print("jkkkkkkk",prevoiusAdId)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        overrideUserInterfaceStyle = .light
        
        noDataLabel.text = "No data found"
        
        sideMenuView.isHidden = true
        
        let defaults = UserDefaults.standard
        
        yearid     = defaults.integer(forKey: DefaultsKeys.yearid)
        sectionid  = defaults.string(forKey: DefaultsKeys.sectionid)
        colgId = defaults.string(forKey: DefaultsKeys.collegeid)
        memberId = defaults.string(forKey: DefaultsKeys.memberid)
        semesterid  = defaults.string(forKey: DefaultsKeys.semesterid)
        priority = defaults.string(forKey: DefaultsKeys.priority)
        loginType = defaults.string(forKey: DefaultsKeys.loginAsType)
        memberName = defaults.string(forKey: DefaultsKeys.memberName)
        colgImg = defaults.string(forKey: DefaultsKeys.colglogo)
        clgLogoImg.sd_setImage(with: URL(string:  colgImg), placeholderImage: UIImage(named: "EmptyCollegeIcon"))
        
        topMessageLabel.text = memberName
        
        MobileNumber = defaults.string(forKey: DefaultsKeys.mobileNumber)
        
        password = defaults.string(forKey: DefaultsKeys.Password)
        addApi()
        
        
        if priority == "p1"{
            
            topLabels.text = "Principal"
            
        }
        
        else if priority == "p4"{
            tapBarView.backgroundColor = UIColor(named: "StudentParent" )
            topLabels.text = "Student"
            
        }
        
        else if priority == "p2" || priority == "p3"{
            
            
            topLabels.text = "Teacher"
            
        }
        
        else if priority == "p5"{
            
            tapBarView.backgroundColor = UIColor(named: "FatherColor" )
            topLabels.text = "Father"
            
        }
        
        if priority == "p1" {
            
            
            print("PrincipalVieewwColor")
            view.backgroundColor = UIColor(named: "Principal" )
            
            
        }else if priority == "p4" {
            
            print("StudentVieewwColor")
            view.backgroundColor = UIColor(named: "studentViewColors")
            
            
            
        } else if priority == "p3" ||  priority == "p2" {
            
            print("HooodddVieewwColor")
            view.backgroundColor = UIColor(named: "Teaching Staff")
            
            
        }
        else if priority == "p5"{
            
            
            
            view.backgroundColor = UIColor(named: "FatherColor")
            
        }
       
        let rowNib = UINib(nibName: identifers, bundle: nil)
        facultyTabelViews.register(rowNib, forCellReuseIdentifier: identifers)
        
        
        let  selectFaculty = UITapGestureRecognizer(target: self, action: #selector(open_url))
        facultyDropDownView.addGestureRecognizer(selectFaculty)
        
        
        let  SectionDrowdown = UITapGestureRecognizer(target: self, action: #selector(SectionDropDownVc))
        sectionNameDropDown.addGestureRecognizer(SectionDrowdown)
        
        
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
        
    }
    
    
    @objc func dismissKeyboards() {
        
        sideMenuView.isHidden = true
        view.endEditing(true)
        
    }
    
    
    @IBAction func SectionDropDownVc(){
        
        dropDown.show()
        
    }
    
    
    func addApi(){
        
        
        var add = AddApiModal()
        
        let defaults = UserDefaults.standard
        var deviceToken = defaults.string(forKey:DefaultsKeys.DeviceToken )
        add.device_token = deviceToken
        print("EventDefaultsKeys.DeviceToken",deviceToken)
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
    
    @IBAction func open_url(){
        
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
                    
                    for i in facultyResp.data ?? []{
                        
                        self.facultyssss = i.sectiondetails ?? []
                    }
                    
                    var myArray: [String] = [ ]
                    var idArry : [String] = []
                    var semId : [String] = []
                    var sectionids : [String] = []
                    
                    self.facultyDropDownRef.forEach {(arrType)  in
                        myArray.append((arrType.semestername ?? ""))
                    }
                    
                    
                    self.facultyLabel.text = "--Selected Category--"
                    self.dropDown.anchorView = self.facultyDropDownView
                    self.dropDown.dataSource = myArray
                    
                    self.dropDown.bottomOffset = CGPoint(x: 0, y:(self.dropDown.anchorView?.plainView.bounds.height)!)
                    self.dropDown.direction = .top
                    DropDown.appearance().backgroundColor = UIColor.white
                    self.dropDown.show()
                    
                    
                    self.dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                        print("Selected item: \(item) at index: \(index)")
                        print("myArray",myArray)
                        
                        self.facultyLabel.text = item
                        
                        facultyResp.data?.forEach {(arrType)  in
                            
                            for i in arrType.sectiondetails ?? []{
                                
                                if item  ==  arrType.semestername{
                                    semId.append(arrType.clgsemesterid ?? "")
                                    idArry.append(i.sectionname ?? "")
                                    sectionids.append(i.sectionid ?? "")
                                }
                            }
                        }
                        
                        print("idArry",idArry.count)
                        
                        
                        self.sectionDropDownLabel.text = "--Selected Category--"
                        self.dropDown.anchorView = self.sectionNameDropDown
                        self.dropDown.dataSource = idArry
                        
                        self.dropDown.bottomOffset = CGPoint(x: 0, y:(self.dropDown.anchorView?.plainView.bounds.height)!)
                        self.dropDown.direction = .top
                        DropDown.appearance().backgroundColor = UIColor.white
                        
                        self.dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                            print("Selected item: \(item) at index: \(index)")
                            print("myArray",myArray)
                            
                            self.sectionDropDownLabel.text = item
                            
                            var faculty = facultyModal()
                            
                            faculty.userid = self.memberId
                            faculty.appid = "2"
                            faculty.priority = self.priority
                            
                            faculty.sectionid = sectionids[index]
                            
                            faculty.semesterid = semId[index]
                            
                            print("jjj",faculty)
                            
                            APiCallManager.shared.callApi(
                                url: APIEndpoints.FacultyList,
                                httpMethod: .post,
                                queryParam: nil,
                                requestBody: faculty
                            ) { [weak self] (result: Result<facultyResponce, Error>) in
                                
                                guard let self = self else { return }
                                
                                switch result {
                                    
                                case .success(let facultyResp):
                                    
                                    if facultyResp.Status == 1{
                                        
                                        self.facultyRef = facultyResp.data ?? []
                                        
                                        self.noDataLabel.isHidden = true
                                        self.noDataTextView.isHidden = true
                                        self.facultyTabelViews.isHidden = false
                                        self.facultyTabelViews.delegate = self
                                        self.facultyTabelViews.dataSource = self
                                        self.facultyTabelViews.reloadData()
                                        
                                    } else{
                                        
                                        self.noDataLabel.isHidden = false
                                        self.noDataTextView.isHidden = false
                                        self.facultyTabelViews.isHidden = true
                                        self.noDataLabel.text = facultyResp.Message
                                        
                                        self.facultyTabelViews.delegate = self
                                        self.facultyTabelViews.dataSource = self
                                        self.facultyTabelViews.reloadData()
                                    }
                                    
                                case .failure(let error):
                                    print(error.localizedDescription)
                                }
                            }
                        }
                    }
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    @IBAction func adLoad(gesture : addClick) {
        
        let vc = FacultyVcViewController(nibName: nil, bundle: nil)
        vc.AddImageView = gesture.url
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
        
    }
    
    
    func facultyDrop(){
        
        
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
        
        if priority == "p1"{
            
            
            cell.cellSubjectName.isHidden = true
            cell.intractview.isHidden = true
            
            
        }
        
        else if priority == "p4"{
            
            
            
            cell.cellSubjectName.isHidden = false
            cell.cellSubjectName.text = faculty.subjectname
            cell.intractview.isHidden = false
            
            
        }
        
        
        
        let intract = UITapGestureRecognizer(target: self, action: #selector(intract))
        
        cell.intractview.addGestureRecognizer(intract)
        
        
        if faculty.facultyphoto == ""{
            
            cell.imageProfileView.image = UIImage(named: "FacultyPencil")
            
        }
        
        
        
        else{
            
            
            
            cell.imageProfileView.sd_setImage(with: URL(string:  faculty.facultyphoto ?? ""), placeholderImage: UIImage(named: "person.fill"))
            
        }
        
        
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

class addClick : UITapGestureRecognizer {
    
    var url : String!
    
    
}
