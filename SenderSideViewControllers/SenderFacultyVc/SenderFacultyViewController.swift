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
    
    @IBOutlet weak var reusee: ReuseView!
    
    
    
    @IBOutlet weak var tabelviewtop: NSLayoutConstraint!
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
    @IBOutlet weak var adView: UIView!
    
    @IBOutlet weak var bigImg: UIImageView!
    
    @IBOutlet weak var noDataLabel: UILabel!
    @IBOutlet weak var noDataTextView: UIView!
    
    
    
    @IBOutlet weak var swipeMenuHeight: NSLayoutConstraint!
    
 
    
    @IBOutlet weak var selectDivisionDropDown: UIViewX!
    
    @IBOutlet weak var selectCourseDropDown: UIViewX!
    
    @IBOutlet weak var tv: UITableView!
    
    let menuIdentifier = "MenuCollectionViewCell"
    var identifers = "FacultyTableViewCell"
    var MenuRefName :[menuApiDataDetails] = []
    var deparmentRefName : [RepienceDeparmentDataDetails] = []
    var devisionRefName : [getDivisonDataDetails] = []
    var facultyForSenderRef : [facultySenderDataDetails] = []
    var addapiRef : [AddDataDeatils] = []
    
    var loginDatas : [datalogin]!
    var logindataprinci :[datalogin]!
    var yearid : String!
    var sectionid : String!
    var semesterid : String!
    var  colgId   : String!
    var memberId  : String!
    var priority  : String!
    var loginType : String!
    var memberName : String!
    var colgImg  : String!
    var MobileNumber : String!
    let dropDown = DropDown()
    var courseTypeId = ""
    var mobileNumber : String!
    var password : String!
    var PreviousAddId : Int = 0
    var hodAndTeachingRef : [StaffHodFacultyResponseData] = []
    var departmentId : String!
    var NoticeBoardId = "1"
    var videoId = "2"
    var EventId = "3"
    var communicationId = "4"
    var imagePdfId = "5"
    var Assigment = "6"
    
    var str : [String] = []
    
    var strName : [String] = []
    
    var is_read_enabled = ""
    var is_write_enabled = ""
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        print("kljjjjjjjjj")
        
        
        PreviousAddId = PreviousAddId+1
        
        //        addApi()
        
        print("jkkkkkkk",PreviousAddId)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        
        noDataLabel.text = "No Data Found"
        
        
        sideMenuView.isHidden = true
        let defaults = UserDefaults.standard
        
        yearid     = defaults.string(forKey: DefaultsKeys.yearid)
        sectionid  = defaults.string(forKey: DefaultsKeys.sectionid)
        colgId = defaults.string(forKey: DefaultsKeys.collegeid)
        memberId = defaults.string(forKey: DefaultsKeys.memberid)
        semesterid  = defaults.string(forKey: DefaultsKeys.semesterid)
        priority = defaults.string(forKey: DefaultsKeys.priority)
        loginType = defaults.string(forKey: DefaultsKeys.loginAsType)
        memberName = defaults.string(forKey: DefaultsKeys.memberName)
        departmentId = defaults.string(forKey: DefaultsKeys.deptid)
        colgImg = defaults.string(forKey: DefaultsKeys.colglogo)
        clgLogoImg.sd_setImage(with: URL(string:  colgImg), placeholderImage: UIImage(named: "person.fill"))
        MobileNumber = defaults.string(forKey: DefaultsKeys.mobileNumber)
        
        password = defaults.string(forKey: DefaultsKeys.Password)
        
        topMessageLabel.text = memberName
        
        
        
        
        addApi()
        
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
            
            
            selectDivisionDropDown.isHidden = true
            selectCourseDropDown.isHidden = true
            tabelviewtop.constant = -100
            noDataTextView.isHidden = true
            getStaffHodList()
            
        }
        
        else if  priority == "p3" {
            
            tapBarView.backgroundColor = UIColor(named: "Teaching Staff" )
            
            topLabels.text = "Teacher"
            
            selectDivisionDropDown.isHidden = true
            selectCourseDropDown.isHidden = true
            tabelviewtop.constant = -100
            noDataTextView.isHidden = true
            getStaffHodList()
            
            
        }
        else if priority == "p5"{
            
            
            topLabels.text = "Father"
            
            
            
        }
        
        else if priority == "p6"{
            
            tapBarView.backgroundColor = UIColor(named: "Teaching Staff" )
            
            topLabels.text = "Non Teaching"
            
            
            
            
        }
        else if priority == "p7"{
            
            tapBarView.backgroundColor = UIColor(named: "univercityColorCod" )
            
            topLabels.text = "University Head"
            
            
            
            
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
            
            
            
            print("non")
            view.backgroundColor = UIColor(named: "Teaching Staff")
            
            reusee.menuImg.image = UIImage(named: "HodImage")
            
            
        }
        
        else if priority == "p7"{
            
            
            
            print("non")
            view.backgroundColor = UIColor(named: "univercityColorCod")
            
            reusee.menuImg.image = UIImage(named: "UnivercityHead")
            
            
        }
        
        
        swipeMenuHeight.constant = 150
                reusee.call_back = { [self]
                    (val) in
                  
                    
                        self.swipeMenuHeight.constant =  reusee.callid
                   
                    print("SenderFacultyViewController",reusee.callid)
                    
               
                }
     
        
        
        
        let rowNib = UINib(nibName: identifers, bundle: nil)
        tv.register(rowNib, forCellReuseIdentifier: identifers)
        
        let  selectDivision = UITapGestureRecognizer(target: self, action: #selector(DropDwonVc))
        selectDivisionDropDown.addGestureRecognizer(selectDivision)
        
        
        let  CourseDivision = UITapGestureRecognizer(target: self, action: #selector(CourseDropDwonVc))
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
    
    @IBAction func CourseDropDwonVc() {
        
        dropDown.show()
        
    }
    
    @IBAction func DropDwonVc() {
        
        
        
        let devisions = getDivisionModal()
        
        devisions.college_id = colgId
        devisions.user_id =  memberId
        
        let devisionstr = devisions.toJSONString()
        
        
        DivisionRequest.call_request(param: devisionstr!){ [self]
            
            (res) in
            
            
            
            let devisin : GetDivisionResponce  = Mapper<GetDivisionResponce>().map(JSONString: res)!
            
            devisionRefName = devisin.data
            
            var myArray: [String] = []
            var myArrayId: [String] = [ ]
            
            devisionRefName.forEach {(arrType)  in
                myArray.append((arrType.division_name))
                myArrayId.append((arrType.division_id))
                
            }
            print("frdfd",myArray)
            
            dropDown.dataSource = myArray//4
            
            dropDown.anchorView = selectDivisionDropDown //5
            
            dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
            
            dropDown.direction = .bottom
            DropDown.appearance().backgroundColor = UIColor.white
            dropDown.show() //7
            
            var idArray : [String] = []
            devisionRefName.forEach {(arrType)  in
                idArray.append((arrType.division_id))
                
            }
            
            dropDown.selectionAction = { [unowned self] (index:Int, item: String) in
                print("Selected item: \(item) at index: \(index)")
                
                self.divisionDropDownLabel.text = item
                
                print("dropDownTextLabel.text\(item)")
                let deparment = DepartmentModal()
                
                deparment.user_id = memberId
                
                deparment.college_id = colgId
                
                deparment.div_id =  idArray[index]
                
                courseTypeId = idArray[index]
                
                print("idArray[index]\(idArray[index])")
                
                
                
                let deparmentstr = deparment.toJSONString()
                RepienceDeparmentRequest.call_request(param: deparmentstr!){ [self]
                    
                    (res) in
                    
                    
                    
                    let depart : RepienceDeparmentResponce  = Mapper<RepienceDeparmentResponce>().map(JSONString: res)!
                    
                    deparmentRefName = depart.data
                    
                    var isArray : [String] = []
                    var deparment : [String] = []
                    deparmentRefName.forEach {(arrType)  in
                        isArray.append((arrType.department_name))
                        deparment.append((arrType.department_id))
                    }
                    dropDown.dataSource = isArray
                    dropDown.anchorView = selectCourseDropDown //5
                    
                    dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
                    
                    dropDown.direction = .bottom
                    DropDown.appearance().backgroundColor = UIColor.white
                    dropDown.show()
                    
                    
                    dropDown.selectionAction = { [unowned self] (index:Int, item: String) in
                        print("Selected item: \(item) at index: \(index)")
                        
                        print("fevdwsxfcdxs",item)
                        self.courseDropDownLabel.text = item
                        
                        let faculty = FacultyListSenderApp()
                        
                        faculty.userid = memberId
                        faculty.appid = "2"
                        faculty.priority = priority
                        faculty.deptid =   deparment[index]
                        faculty.courseid =  idArray[index]
                        
                        
                        let faculStr = faculty.toJSONString()
                        
                        facultySenderRequest.call_request(param: faculStr!){ [self]
                            (res) in
                            
                            let facultyResp : FacultyResponce =
                            Mapper<FacultyResponce>().map(JSONString: res)!
                            
                            if facultyResp.Status == 1{
                                
                                facultyForSenderRef = facultyResp.data
                                
                                noDataTextView.alpha = 0
                                noDataLabel.alpha = 0
                                
                                tv .delegate = self
                                tv.dataSource = self
                                tv.reloadData()
                            } else{
                                noDataTextView.alpha = 1
                                noDataLabel.alpha = 1
                                noDataTextView.isHidden = false
                                
                                
                                
                            }
                            
                            
                        }
                        
                        
                        
                        
                    }
                    
                }
               
            }
          
            
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if priority == "p1"{
            return facultyForSenderRef.count
        }
        
        else if priority == "p2"  || priority == "p3"{
            
            
            return hodAndTeachingRef.count
            
            
        }
        
        return 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifers, for: indexPath) as! FacultyTableViewCell
        
        
        
        if priority == "p1"{
            
            
            cell.intractview.isHidden = true
            
            cell.cellSubjectName.isHidden = true
            cell.subjectDefautLbl.isHidden = true
            
            let faculty : facultySenderDataDetails = facultyForSenderRef[indexPath.row]
            
            cell.cellStafName.text = faculty.staffname
            cell.cellStafType.text = faculty.stafftype
            
            
            if faculty.facultyphoto == ""{
                
         
                
                
                cell.imageProfileView.image = UIImage(named: "FacultyPencil")
                
                
                
            }
            
            
            
            else{
                
                
                
                cell.imageProfileView.sd_setImage(with: URL(string:  faculty.facultyphoto), placeholderImage: UIImage(named: "person.fill"))
                
                
                
            }
            
        }
        
        else if priority == "p2" ||  priority == "p3"{
            
            
            cell.cellSubjectName.isHidden = true
            cell.intractview.isHidden = true
            cell.subjectDefautLbl.isHidden = true
            
            let hodAndStaff  : StaffHodFacultyResponseData = hodAndTeachingRef[indexPath.row]
            
            
            
            cell.cellStafName.text = hodAndStaff.staffname
            cell.cellStafType.text = hodAndStaff.stafftype
            
            
            if hodAndStaff.facultyphoto == ""{
   
                
                cell.imageProfileView.image = UIImage(named: "FacultyPencil")
                
                
                
            }
            
            
            
            else{
                
          
                cell.imageProfileView.sd_setImage(with: URL(string:  hodAndStaff.facultyphoto), placeholderImage: UIImage(named: "person.fill"))
                
                
                
            }
            
            
        }
        
        
        
        else if priority == "p7"{
            
            
            cell.cellSubjectName.isHidden = true
            cell.intractview.isHidden = true
            cell.subjectDefautLbl.isHidden = true
            
            let hodAndStaff  : StaffHodFacultyResponseData = hodAndTeachingRef[indexPath.row]
            
            
            
            cell.cellStafName.text = hodAndStaff.staffname
            cell.cellStafType.text = hodAndStaff.stafftype
            
            
            if hodAndStaff.facultyphoto == ""{
                
                
                
                
                
                
                
                cell.imageProfileView.image = UIImage(named: "FacultyPencil")
                
                
                
            }
            
            
            
            else{
                
                
                
                cell.imageProfileView.sd_setImage(with: URL(string:  hodAndStaff.facultyphoto), placeholderImage: UIImage(named: "person.fill"))
                
                
                
            }
            
            
        }
        
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    @IBAction func adLoad(gesture:FacultyAddsss){
        
        let vc = SenderExamAddVcViewController(nibName: nil, bundle: nil)
        
        vc.AddWebUrl = gesture.addUrls
        
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
    }
    
    
    func getStaffHodList() {
   
        let staffHod = StaffHodFacultyModal()
        
        staffHod.userid = Int(memberId)
        
        staffHod.appid = 2
        
        staffHod.priority = priority
        
        staffHod.deptid = departmentId
        
        
        let staffHodStr = staffHod.toJSONString()
 
        StaffHodFacultyRequest.call_request(param: staffHodStr!) { [self]
            
            (res) in
      
            let staffHodRess : StaffHodFacultyResponse = Mapper<StaffHodFacultyResponse>().map(JSONString: res)!
            
            hodAndTeachingRef = staffHodRess.data
            
            if staffHodRess.Status == 1 {
                
                
                noDataTextView.isHidden = true
                
                tv.delegate = self
                tv.dataSource = self
                tv.reloadData()
                
                
                print("staffHodRess",res)
                
            }
            
            else {
                
                noDataTextView.isHidden = false
                noDataLabel.text = staffHodRess.Message
                tv.delegate = self
                tv.dataSource = self
                tv.reloadData()
            }
        }
    }
    
    
    func addApi(){
        
        
        let add = AddApiModal()
        
        let defaults = UserDefaults.standard
        var deviceToken = defaults.string(forKey:DefaultsKeys.DeviceToken )
        add.device_token = deviceToken
        print("EventDefaultsKeys.DeviceToken",deviceToken)
        add.member_id = memberId
        add.mobile_no = MobileNumber
        add.priority = priority
        add.college_id = colgId
        add.previous_add_id = PreviousAddId
        
        
        let addstr = add.toJSONString()
        
        
        addRequest.call_request(param: addstr!){ [self]
            
            (res) in
            
            
            
            let addApis : AddApiResponce = Mapper<AddApiResponce>().map(JSONString: res)!
            if addApis.Status == 1 {
                addapiRef = addApis.data
                
                
                for i in addApis.data{
                    
                    
           
                    
                    bigImg.sd_setImage(with: URL(string: i.background_image), placeholderImage: UIImage(named: "ic_white"))
                    
                    
                    smallImg.sd_setImage(with: URL(string: i.add_image), placeholderImage: UIImage(named: "ic_white"))
                    
                    let singleTap = FacultyAddsss(target: self, action: #selector(adLoad))
                    singleTap.addUrls = i.add_url
                    bigImg.isUserInteractionEnabled = true
                    bigImg.addGestureRecognizer(singleTap)
                    
                    
                }
          
                
            }
            
            else{
                
                
            }
            
        }
        
        
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
                    
                    else if i.priority == "p7"{
                        
                        vc.IdentfierLabel = "UNIVERSITY HEAD"
                        vc.loginPrincipal.append(i)
                    }
                }
                vc.modalPresentationStyle = .fullScreen
                
                present(vc, animated: true,completion: nil)
                
                
                
            }
        }
        
        
        
        
        
        
    }
    
    
}
class FacultyAddsss : UITapGestureRecognizer{
    
    
    var addUrls : String!
    
    
}
