//
//  ChatSenderViewController.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 21/03/23.
//

import UIKit
import ObjectMapper
import KRProgressHUD

@available(iOS 16.0, *)
class ChatSenderViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
  
    @IBOutlet weak var reusee: ReuseView!
    @IBOutlet weak var tapNameview: UIView!
    @IBOutlet weak var tapBarView: UIViewX!
    @IBOutlet weak var topMemberLabel: UILabel!
    
    @IBOutlet weak var noDataTextLabel: UILabel!
    
    @IBOutlet weak var noDataTextView: UIView!
    
    @IBOutlet weak var redirectLoginView: UIViewX!
    
    
    @IBOutlet weak var topLabels: UILabel!
    @IBOutlet weak var notificationView: UIView!
    
    @IBOutlet weak var privacyPolicyView: UIView!
    
    @IBOutlet weak var faqView: UIView!
    
    @IBOutlet weak var changePasswordView: UIView!
    @IBOutlet weak var logoutView: UIView!
    
    @IBOutlet weak var helpView: UIView!
    
    @IBOutlet weak var profileView: UIView!
    
    
    @IBOutlet weak var termsAndConditionView: UIView!
    
    
    @IBOutlet weak var refreshView: UIView!
    
    @IBOutlet weak var changeRolesView: UIView!
    
    @IBOutlet weak var topMessageLabel: UILabel!
    
    
    
    @IBOutlet weak var clgLogoImg: UIImageView!
    
    @IBOutlet weak var sideMenuView: UIView!
    
    @IBOutlet weak var viewTap: UIView!
    
    @IBOutlet weak var swipeMenuHeight: NSLayoutConstraint!
   
    @IBOutlet weak var smallImg: UIImageView!
    @IBOutlet weak var bigImg: UIImageView!
    @IBOutlet weak var adView: UIView!
    @IBOutlet weak var chatCollectionView: UICollectionView!
    var Indentifiers = "ChatsCollectionViewCell"
    
    var chatFortPageRefName : [intractChatData] = []
    
    let menuIdentifier = "MenuCollectionViewCell"
    var MenuRefName :[menuApiDataDetails] = []
    var addapiRef : [AddDataDeatils] = []
    
    var memberId : String!
    var colgId   : String!
    var departmentId : String!
    var priority : String!
    var sectionid : String!
    var colgImg : String!
    var mem : String!
    var NoticeBoardId = "1"
    var videoId = "2"
    var EventId = "3"
    var communicationId = "4"
    var imagePdfId = "5"
    var Assigment = "6"
    var PreviousAddId : Int = 0
    
    var MobileNumber : String!
    
    
    var password : String!
    
    var str : [String] = []
    
    var strName : [String] = []
    var is_read_enabled = ""
    var is_write_enabled = ""
    
    var loginDatas : [datalogin]!
    var logindataprinci :[datalogin]!
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        print("kljjjjjjjjj")
        
        
        PreviousAddId = PreviousAddId+1
        
      
        
        print("jkkkkkkk",PreviousAddId)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        PreviousAddId = PreviousAddId+1
        sideMenuView.isHidden = true
        noDataTextView.isHidden = true
        noDataTextLabel.isHidden = true
        let defaults = UserDefaults.standard
     
        departmentId = defaults.string(forKey: DefaultsKeys.deptid)
        
        memberId = defaults.string(forKey: DefaultsKeys.memberid)
        priority = defaults.string(forKey: DefaultsKeys.priority)
        colgId = defaults.string(forKey: DefaultsKeys.collegeid)
        sectionid  = defaults.string(forKey: DefaultsKeys.sectionid)
        colgImg = defaults.string(forKey: DefaultsKeys.colglogo)
        clgLogoImg.sd_setImage(with: URL(string:  colgImg), placeholderImage: UIImage(named: "person.fill"))
        mem = defaults.string(forKey: DefaultsKeys.memberName)
        topMemberLabel.text = mem
        MobileNumber = defaults.string(forKey: DefaultsKeys.mobileNumber)
        password = defaults.string(forKey: DefaultsKeys.Password)
        
        addApi()
        if is_read_enabled == "1"{
            
            chatfortPage()
        }else{
            
            
            noDataTextView.isHidden = false
            noDataTextLabel.isHidden = false
            noDataTextLabel.text = "No Data Found"
        }
       
        
        
        let rowNib = UINib(nibName: Indentifiers, bundle: nil)
        chatCollectionView.register(rowNib, forCellWithReuseIdentifier: Indentifiers)
        
        
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
        
        
        else if  priority == "p3"{
            
            
            tapBarView.backgroundColor = UIColor(named: "Teaching Staff" )
            topLabels.text = "Teacher"
            
            
        }
        else if priority == "p5"{
            
            
            topLabels.text = "Father"
            
            
            
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
        
        
        else if priority == "p7"{
            
            
            
            view.backgroundColor = UIColor(named: "univercityColorCod")
            
            reusee.menuImg.image = UIImage(named: "UnivercityHead")
            
            
        }
        
        
        swipeMenuHeight.constant = 150
                reusee.call_back = { [self]
                    (val) in
                  
                    
                        self.swipeMenuHeight.constant =  reusee.callid
                   
                    print("ChatSenderInteractViewController",reusee.callid)
                    
               
                }
      
     
        
        
        let menuGestureHide = UITapGestureRecognizer(target: self, action: #selector(menu))
        viewTap.addGestureRecognizer(menuGestureHide)
        
        let notificationGesture = UITapGestureRecognizer(target: self, action: #selector(notificationVc))
        notificationView.addGestureRecognizer(notificationGesture)
        
        let refreshGesture = UITapGestureRecognizer(target: self, action: #selector(refreshVc))
        refreshView.addGestureRecognizer(refreshGesture)
        
        
        let faqGesture = UITapGestureRecognizer(target: self, action: #selector(faqRedirect))
        faqView.addGestureRecognizer(faqGesture)
        
        let logoutGesture = UITapGestureRecognizer(target: self, action: #selector(logoutPressed))
        logoutView.addGestureRecognizer(logoutGesture)
        
        let helpGesture = UITapGestureRecognizer(target: self, action: #selector(helpRedirect))
        helpView.addGestureRecognizer(helpGesture)
        //
        
        let privacyPolicyGesture = UITapGestureRecognizer(target: self, action: #selector(privacyPolicyRedirect))
        privacyPolicyView.addGestureRecognizer(privacyPolicyGesture)
        
        
        let termsAndConditionGesture = UITapGestureRecognizer(target: self, action: #selector(termsAndCondition))
        termsAndConditionView.addGestureRecognizer(termsAndConditionGesture)
        
        
        
        let loginRediectGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        redirectLoginView.addGestureRecognizer(loginRediectGesture)
        
        let tpname = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        tapNameview.addGestureRecognizer(tpname)
        
        
        //
        let chagePassword = UITapGestureRecognizer(target: self, action: #selector(changePassowrdVC))
        changePasswordView.addGestureRecognizer(chagePassword)
        
        
        let changeRol = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        changeRolesView.addGestureRecognizer(changeRol)
        
        
        
        
    }
    
    
    @objc func dismissKeyboards() {
        
        sideMenuView.isHidden = true
        view.endEditing(true)
        
    }
    
    
    func chatfortPage(){
        
        print("chat")
        var chatfornt = IntractApiModal()
        
        chatfornt.college_id = colgId
        chatfornt.staff_id = memberId
        
        APiCallManager.shared.callApi(url: APIEndpoints.GetStaffClassesforChatForApp, httpMethod: .post, queryParam: nil, requestBody: chatfornt) { [weak self] (result:Result<IntractChatResponces,Error>) in
            guard let self = self else{return}
            switch result{
            case .success(let success):
                chatFortPageRefName = success.data ?? []
                if success.Status == 1{
                    noDataTextView.isHidden = true
                    noDataTextLabel.isHidden = true
                    chatCollectionView.dataSource = self
                    chatCollectionView.delegate = self
                    chatCollectionView.reloadData()
                }else{
                    noDataTextLabel.text = success.Message
                    noDataTextView.isHidden = false
                    noDataTextLabel.isHidden = false
                    
                    chatCollectionView.dataSource = self
                    chatCollectionView.delegate = self
                    chatCollectionView.reloadData()
                }
            case .failure(let error):
                noDataTextLabel.text = error.localizedDescription
                noDataTextView.isHidden = false
                noDataTextLabel.isHidden = false
                
                chatCollectionView.dataSource = self
                chatCollectionView.delegate = self
                chatCollectionView.reloadData()
            }
        }
        
    }
    
    
    
    
    func addApi(){
        
        var add = AddApiModal()
        
        let defaults = UserDefaults.standard
        var deviceToken = defaults.string(forKey:DefaultsKeys.DeviceToken )
        add.device_token = deviceToken
        print("EventDefaultsKeys.DeviceToken",deviceToken)

        add.member_id = memberId
        add.mobile_no = MobileNumber
        add.priority = priority
        add.college_id = colgId
        add.previous_add_id = PreviousAddId
        
        APiCallManager.shared.callApi(url: APIEndpoints.GetAddsForCollege, httpMethod: .get, queryParam: nil, requestBody: nil
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
    
    
    @objc func adLoad( gesture : addss){
        
        let vc = ChatAddViewController(nibName: nil, bundle: nil)
        vc.addWeurl = gesture.url
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
    }
   
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //
        
        
        print("jkjnkklnlkl",UIDevice.current.name)
            print("chat2")
            
            
            return chatFortPageRefName.count
            
       
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
       
        
        
            
            print("chat3")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Indentifiers, for: indexPath) as!
            
            ChatsCollectionViewCell
            print("chat4")
            let chatForntPages : intractChatData = chatFortPageRefName[indexPath.row]
            
            cell.subjectNameCellLabel.text = chatForntPages.subjectname
            cell.staffNameCellLabel.text = chatForntPages.coursename
            //
        cell.yrNamLbl.text = (chatForntPages.yearname ?? "") + " | " + (chatForntPages.sectionname ?? "") + " | " + (chatForntPages.semestername ?? "")
            
            let intract = intractClick(target: self, action: #selector(intractVc))
            
            intract.sectionId = chatForntPages.sectionid
            intract.subjectId = chatForntPages.subjectid
            intract.isClassTeacher = chatForntPages.isclassteacher
            intract.subjectName = chatForntPages.subjectname
            intract.semesterName = chatForntPages.semestername
            intract.course = chatForntPages.coursename
            intract.yearName = chatForntPages.yearname
            intract.section = chatForntPages.sectionname
            
            cell.interactCellView.addGestureRecognizer(intract)
            
            
            
            let FullClick = intractClick(target: self, action: #selector(intractVc))
            
            FullClick.sectionId = chatForntPages.sectionid
            FullClick.subjectId = chatForntPages.subjectid
            FullClick.isClassTeacher = chatForntPages.isclassteacher
            FullClick.subjectName = chatForntPages.subjectname
            FullClick.semesterName = chatForntPages.semestername
            FullClick.course = chatForntPages.coursename
            FullClick.yearName = chatForntPages.yearname
            FullClick.section = chatForntPages.sectionname
            
            cell.fullView.addGestureRecognizer(FullClick)
            return cell
            
            
       
        
    }
    
    
    @IBAction func intractVc(gesture : intractClick){
        
        
        let vc =  ChatSenderInteractViewController(nibName: nil, bundle: nil)
        
        vc.section_id = gesture.sectionId
        vc.subject_id = gesture.subjectId
        vc.is_classteacher = gesture.isClassTeacher
        vc.subjectName = gesture.subjectName
        vc.semesterName = gesture.semesterName
        vc.course = gesture.course
        vc.yearName = gesture.yearName
        vc.section = gesture.section
        vc.str = str
        vc.strName = strName
        vc.is_read_enabled = is_read_enabled
        vc.is_write_enabled = is_write_enabled
       
        
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
        
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
      
        if UIDevice.current.name == "iPhone 8"{
            
            return CGSize(width: collectionView.frame.size.width / 2, height: 200)
            
        }
        else{
            
            return CGSize(width: collectionView.frame.size.width / 2, height: collectionView.frame.size.height - 180)
            
            
        }
        
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
        vc.str = str
        vc.strName = strName
        vc.modalPresentationStyle = .fullScreen
        let currentController = self.getCurrentViewController()
        currentController?.present(vc, animated: false, completion: nil)
        
        
    }
    
    
    
    
    
    
    @IBAction func changePassowrdVC(){
        
        let vc = ChangePasswordViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        let currentController = self.getCurrentViewController()
        currentController?.present(vc, animated: true, completion: nil)
        
        
    }
    
    
    
    
    @IBAction func priortyScreenVc(){
 
        
    }
    
    
    @IBAction func priorityV() {
        
        
    }
    
    @IBAction func menu() {
        
        if sideMenuView.isHidden == true{
            
            sideMenuView.isHidden = false
            //
            
            print("menuVisble")
        }
        
        else{
            
            sideMenuView.isHidden = true
            
        }
        
        
    }
    
    
    
    @IBAction func priorityVc() {
        let vc = PriorityViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
    }
    
    @IBAction func profileRedirect() {
        
        let vc = ProfileViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        let currentController = self.getCurrentViewController()
        currentController?.present(vc, animated: true, completion: nil)
        
    }
    
}
//extension UIDevice {
//       var modelName: String {
//           var systemInfo = utsname()
//           uname(&systemInfo)
//           let machineMirror = Mirror(reflecting: systemInfo.machine)
//           let identifier = machineMirror.children.reduce("") { identifier, element in
//               guard let value = element.value as? Int8, value != 0 else { return identifier }
//               return identifier + String(UnicodeScalar(UInt8(value)))
//           }
//           return identifier
//       }
//   }

class addss : UITapGestureRecognizer{
    
    var url : String!
    
}


class intractClick : UITapGestureRecognizer{
    
    var sectionId : String!
    var subjectId : String!
    var isClassTeacher : String!
    
    var subjectName : String!
    
    var section : String!
    var semesterName : String!
    
    var yearName : String!
    
    var course : String!
}

