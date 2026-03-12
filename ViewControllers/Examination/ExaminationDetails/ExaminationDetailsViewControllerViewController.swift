//
//  ExaminationDetailsViewControllerViewController.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 24/11/22.
//

import UIKit
import ObjectMapper
import KRProgressHUD

@available(iOS 16.0, *)
class ExaminationDetailsViewControllerViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var reusee: ReuseView!
    
    @IBOutlet weak var topNameview: UIView!
    
    @IBOutlet weak var tapBarView: UIViewX!
    @IBOutlet weak var redirectLoginView: UIViewX!
    
    @IBOutlet weak var profileView: UIView!
    
    @IBOutlet weak var changeRolesView: UIView!
    
    @IBOutlet weak var notificationView: UIView!
    
    @IBOutlet weak var priorityView: UIViewX!
    
    @IBOutlet weak var sideMenuView: UIView!
    
    @IBOutlet weak var tv: UITableView!
    
    
    @IBOutlet weak var topicLabel: UILabel!
    
    
    
    @IBOutlet weak var clgLogoImg: UIImageView!
    
    
    @IBOutlet weak var loginView: UIView!
    
    @IBOutlet weak var helpView: UIView!
    
    
    
    @IBOutlet weak var termsAndConditionView: UIView!
    
    @IBOutlet weak var refreshView: UIView!
    
    @IBOutlet weak var faqView: UIView!
    
    
    @IBOutlet weak var changePasswordView: UIView!
    
    
    
    @IBOutlet weak var privacyPolicyView: UIView!
    
    
    
    @IBOutlet weak var topMemberLabel: UILabel!
    
    
    
    
    
    @IBOutlet weak var viewTap: UIView!
    
    @IBOutlet weak var topLabels: UILabel!
    
    @IBOutlet weak var smallImg: UIImageView!
    @IBOutlet weak var bigImg: UIImageView!
    @IBOutlet weak var noDataLabel: UILabel!
    @IBOutlet weak var noDataTextView: UIView!
    
    @IBOutlet weak var adView: UIView!
    
    @IBOutlet weak var swipeMenuHeight: NSLayoutConstraint!
    
    
    
   
    
    var addapiRef : [AddDataDeatils] = []
    
    var examViewPageRef : [examViewResiverDataDetails] = []
    var MenuRefName :[menuApiDataDetails] = []
    var loginDatas : [datalogin]!
    var logindataprinci :[datalogin]!
    let menuIdentifier = "MenuCollectionViewCell"
    
    var identifier = "ExameViewResiverTableViewCell"
    
    var examHeaderId : String!
    
    var titleName : String!
    
    var memberId : String!
    
    var MobileNumber : String!
    var priority : String!
    
    var mem : String!
    var colgImg : String!
    var colgId : String!
    
    var prevoiusAddId : Int!
    var str : [String] = []
    
    var strName : [String] = []
    
    var is_read_enabled = ""
    var is_write_enabled = ""
    
    
    
    var password : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideMenuView.isHidden = true
        overrideUserInterfaceStyle = .light
        noDataTextView.isHidden = true
        noDataLabel.isHidden = true
        
        let defaults = UserDefaults.standard
        
        
        memberId = defaults.string(forKey: DefaultsKeys.memberid)
        MobileNumber = defaults.string(forKey: DefaultsKeys.mobileNumber)
        priority = defaults.string(forKey: DefaultsKeys.priority)
        
        print("mobileee",MobileNumber)
        mem = defaults.string(forKey: DefaultsKeys.memberName)
        colgImg = defaults.string(forKey: DefaultsKeys.colglogo)
        clgLogoImg.sd_setImage(with: URL(string:  colgImg), placeholderImage: UIImage(named: "person.fill"))
        colgId = defaults.string(forKey: DefaultsKeys.collegeid)
        password = defaults.string(forKey: DefaultsKeys.Password)
        topMemberLabel.text = mem
        
        tv.delegate = self
        tv.dataSource  = self
       
        addApi()
        
        examView()
        
        
        
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
        swipeMenuHeight.constant = 150
                reusee.call_back = { [self]
                    (val) in
                  
                    
                        self.swipeMenuHeight.constant =  reusee.callid
                   
                    print("CommunicationHomePageViewController",reusee.callid)
                    
               
                }
        
    
        
        let loginRediectGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        redirectLoginView.addGestureRecognizer(loginRediectGesture)
        
        
        
        
        
        
        let rowNib = UINib(nibName: identifier, bundle: nil)
        tv.register(rowNib, forCellReuseIdentifier: identifier)
        
        topicLabel.text = titleName
        
        
      
        
        let menuGestureHide = UITapGestureRecognizer(target: self, action: #selector(menu))
        viewTap.addGestureRecognizer(menuGestureHide)
        
        let notificationGesture = UITapGestureRecognizer(target: self, action: #selector(notificationVc))
        notificationView.addGestureRecognizer(notificationGesture)
        
        let refreshGesture = UITapGestureRecognizer(target: self, action: #selector(refreshVc))
        refreshView.addGestureRecognizer(refreshGesture)
        
        
        let faqGesture = UITapGestureRecognizer(target: self, action: #selector(faqRedirect))
        faqView.addGestureRecognizer(faqGesture)
        
        let logoutGesture = UITapGestureRecognizer(target: self, action: #selector(logoutPressed))
        loginView.addGestureRecognizer(logoutGesture)
        
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
        
        
        let topname = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        topNameview.addGestureRecognizer(topname)
        
        
    }
    
    
    @objc func dismissKeyboards() {
        
        sideMenuView.isHidden = true
        view.endEditing(true)
        
    }
    
    
    @IBAction func adLoad(gesture : ExamDetailsaddViewGesturess) {
        
        
        
        
        let vc = ShowExaminationAddViewController(nibName: nil, bundle: nil)
        
        
        vc.addString = gesture.url
        print("adssdedd",gesture.url)
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true,completion: nil)
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return examViewPageRef.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as!
        
        ExameViewResiverTableViewCell
        
        
        
        let view  : examViewResiverDataDetails = examViewPageRef[indexPath.row]
        
        
        cell.markLabel.text = view.marks
        cell.NameLabel.text = view.subjectname
        
        
        if (indexPath.row % 2 == 0){
            
            cell.fulview.backgroundColor = UIColor(named: "examcolors")
            
        }
        
        else{
            
            cell.fulview.backgroundColor = .white
        }
        
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }
    
    
    
    func examView(){
        
        var examVieww = examViewModal()
        
        examVieww.studentid = memberId
        examVieww.examheaderid = examHeaderId
        
        APiCallManager.shared.callApi(url: APIEndpoints.GetStudentMarkDetailsForApp, httpMethod: .post, queryParam: nil, requestBody: examVieww) {[weak self] (result:Result<examViewResponce, Error>) in
            
            guard let self = self else {return}
            
            switch result {
            case .success(let success):
                if success.Status == 1 {
                    examViewPageRef = success.data ?? []
                    noDataTextView.isHidden = true
                    noDataLabel.isHidden = true
                    tv.reloadData()
                    
                }else {
                    
                    examViewPageRef = success.data ?? []
                    noDataTextView.isHidden = false
                    noDataLabel.isHidden = false
                    noDataLabel.text = success.Message
                    tv.reloadData()
                }
            case .failure(let failure):
                examViewPageRef = []
                noDataTextView.isHidden = false
                noDataLabel.isHidden = false
                noDataLabel.text = failure.localizedDescription
                tv.reloadData()
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
        add.previous_add_id = prevoiusAddId
        
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
    
    @IBAction func profileRedirect() {
        
        let vc = ProfileViewController(nibName: nil, bundle: nil)
        vc.str = str
        vc.strName = strName
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
    
    
    
    
    @IBAction func backbtn(_ sender: Any) {
        
        dismiss(animated: true)
    }
}

class ExamDetailsaddViewGesturess : UITapGestureRecognizer {
    
    
    var url : String!
}

