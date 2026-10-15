//
//  ChatHomePageViewController.swift
//  GraditChat
//
//  Created by MACBOOKPRO on 14/11/22.
//

import UIKit
import WebKit
import ObjectMapper
import KRProgressHUD

@available(iOS 16.0, *)
class ChatHomePageViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var customTabBar: CustomTabBar!
    @IBOutlet weak var noDataTextLabel: UILabel!
    @IBOutlet weak var noDataTextView: UIView!
    @IBOutlet weak var privacyPolicyView: UIView!
    
    @IBOutlet weak var faqView: UIView!
    
    @IBOutlet weak var changePasswordView: UIView!
    @IBOutlet weak var logoutView: UIView!
    
    @IBOutlet weak var helpView: UIView!
    
    @IBOutlet weak var profileView: UIView!
    
    
    @IBOutlet weak var termsAndConditionView: UIView!
    @IBOutlet weak var changeRolesView: UIView!
    @IBOutlet weak var sideMenuView: UIView!
    @IBOutlet weak var smallImg: UIImageView!
    @IBOutlet weak var bigImg: UIImageView!
    @IBOutlet weak var chatCollectionView: UICollectionView!
    var Indentifiers = "ChatsCollectionViewCell"
    
    var chatFortPageRefName : [chatFrontPageDataDetails] = []
    
    let menuIdentifier = "MenuCollectionViewCell"
    var MenuRefName :[menuApiDataDetails] = []
    var addapiRef : [AddDataDeatils] = []
    var loginDatas : [datalogin]!
    var logindataprinci :[datalogin]!
    
    var memberId : String!
    var colgId   : String!
    var departmentId : String!
    var priority : String!
    var sectionid : String!
    var colgImg : String!
    var mem : String!
    var mobileNumber : String!
    
    var passwords : String!
    
    var str : [String] = []
    
    var strName : [String] = []
    
    var is_read_enabled = ""
    var is_write_enabled = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customTabBar.delegate = self
        
        overrideUserInterfaceStyle = .light
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
        
        passwords = defaults.string(forKey: DefaultsKeys.Password)
        
        mobileNumber = defaults.string(forKey: DefaultsKeys.mobileNumber)
      
        
        addApi()
        
        
        if is_read_enabled == "1"{
            
            chatfortPage()
        }
    
        let rowNib = UINib(nibName: Indentifiers, bundle: nil)
        chatCollectionView.register(rowNib, forCellWithReuseIdentifier: Indentifiers)
        
        view.backgroundColor = .priorityColor
       
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
        
        
        let profileGesture = UITapGestureRecognizer(target: self, action: #selector(profileRedirect))
        profileView.addGestureRecognizer(profileGesture)
        
        //
        let chagePassword = UITapGestureRecognizer(target: self, action: #selector(changePassowrdVC))
        changePasswordView.addGestureRecognizer(chagePassword)
        
        
        let changeRol = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        changeRolesView.addGestureRecognizer(changeRol)
        
        
        
        
        //
    }
    
    
    @objc func dismissKeyboards() {
        
        sideMenuView.isHidden = true
        view.endEditing(true)
        
    }
    
    

    func chatfortPage(){
        
        print("chat")
        var chatfornt = ChatFrontPageModal()
        chatfornt.college_id = colgId
        chatfornt.student_id = memberId
        
        APiCallManager.shared.callApi(url: APIEndpoints.GetstaffdetailsForApp, httpMethod: .post, queryParam: nil, requestBody: chatfornt) {[weak self] (result:Result<ChatFrontPageResponce,  Error>) in
            
            guard let self = self else {return}
            
            switch result {
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
                
            case .failure(let failure):
                
                chatFortPageRefName = []
                noDataTextLabel.text = failure.localizedDescription
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
        add.member_id = Int(memberId)
        add.mobile_no = mobileNumber
        add.priority = priority
        add.college_id = Int(colgId)
        add.previous_add_id = 2
        
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

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return chatFortPageRefName.count
        
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
       
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Indentifiers, for: indexPath) as!
        
        ChatsCollectionViewCell
        
        
        cell.yrNamLbl.isHidden = true
        
       
        let chatForntPages : chatFrontPageDataDetails = chatFortPageRefName[indexPath.row]
        
        cell.subjectNameCellLabel.text = chatForntPages.subjectname
        cell.staffNameCellLabel.text = chatForntPages.staffname
        
        let intract = intractTap(target: self, action: #selector(intractVc))
        
        intract.sectionId = chatForntPages.sectionid
        intract.isTeacher = chatForntPages.isclassteacher
        intract.staffId = chatForntPages.staffid
        intract.subject = chatForntPages.subjectid
        intract.subjectName = chatForntPages.subjectname
        intract.staffName = chatForntPages.staffname
        
        cell.interactCellView.addGestureRecognizer(intract)
        
        
        let FullClick = intractTap(target: self, action: #selector(intractVc))
        FullClick.sectionId = chatForntPages.sectionid
        FullClick.isTeacher = chatForntPages.isclassteacher
        FullClick.staffId = chatForntPages.staffid
        FullClick.subject = chatForntPages.subjectid
        FullClick.subjectName = chatForntPages.subjectname
        FullClick.staffName = chatForntPages.staffname
        
        cell.fullView.addGestureRecognizer(FullClick)
        
        return cell
        
    }
    
    
    @IBAction func intractVc(geture : intractTap){
        
        
        let vc = ChatReceiverInteractViewController(nibName: nil, bundle: nil)
        
        vc.section_id = geture.sectionId
        vc.is_classteacher = geture.isTeacher
        vc.staff_id = geture.staffId
        vc.subject_id = geture.subject
        vc.subjectName = geture.subjectName
        vc.staff = geture.staffName
        vc.str = str
        vc.strName = strName
        vc.is_read_enabled = is_read_enabled
        vc.is_write_enabled = is_write_enabled
        
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
        
        
    }
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.size.width / 2, height: 250)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let chatForntPages : chatFrontPageDataDetails = chatFortPageRefName[indexPath.row]
        
        let vc = ChatReceiverInteractViewController(nibName: nil, bundle: nil)
        
        vc.section_id = chatForntPages.sectionid
        vc.is_classteacher = chatForntPages.isclassteacher
        vc.staff_id = chatForntPages.staffid
        vc.subject_id = chatForntPages.subjectid
        vc.subjectName = chatForntPages.subjectname
        vc.staff = chatForntPages.staffname
        vc.str = str
        vc.strName = strName
        vc.is_read_enabled = is_read_enabled
        vc.is_write_enabled = is_write_enabled
        
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
        
        
    }
    
    
    
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
        let currentController = self.getCurrentViewController()
        currentController?.present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func privacyPolicyRedirect() {
        
        let vc = PrivacyPolicyViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        let currentController = self.getCurrentViewController()
        currentController?.present(vc, animated: true, completion: nil)
        
    }
 
    @IBAction func changePassowrdVC(){
        
        let vc = ChangePasswordVC(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        let currentController = self.getCurrentViewController()
        currentController?.present(vc, animated: true, completion: nil)
        
    }
    
    
    @IBAction func priorityVc() {
        
        let vc = PriorityScreenVC(nibName: nil, bundle: nil)
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

@available(iOS 16.0, *)
extension ChatHomePageViewController : CustomTabBarDelegate {
    func didTapSearch() {
        
    }
    
    func didTapSideMenu() {
        sideMenuView.isHidden.toggle()
    }
    
    
}


class intractTap : UITapGestureRecognizer{
    
    
    
    var sectionId :  String!
    
    var staffId : String!
    
    var isTeacher : String!
    
    var subject : String!
    
    var subjectName : String!
    var staffName : String!
    
}

