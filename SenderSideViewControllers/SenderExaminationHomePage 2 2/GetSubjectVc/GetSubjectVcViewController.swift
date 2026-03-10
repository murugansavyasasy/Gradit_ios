//
//  GetSubjectVcViewController.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 27/03/23.
//

import UIKit
import ObjectMapper
import KRProgressHUD

@available(iOS 16.0, *)
class GetSubjectVcViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var topNameview: UIView!
    @IBOutlet weak var countView: UIViewX!
    
    @IBOutlet weak var redirectLoginView: UIViewX!
    
    
    @IBOutlet weak var tapBarView: UIViewX!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var tv: UITableView!
    
    
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var topLabels: UILabel!
    
    
    @IBOutlet weak var profileView: UIView!
    
    @IBOutlet weak var viewTap: UIView!
    
    @IBOutlet weak var clgLogoImg: UIImageView!
    @IBOutlet weak var topMessageLabel: UILabel!
    
    
    
    @IBOutlet weak var smallImg: UIImageView!
    @IBOutlet weak var bigImg: UIImageView!
    @IBOutlet weak var adView: UIView!
    
    @IBOutlet weak var changeRolesView: UIView!
    
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var refreshView: UIView!
    
    @IBOutlet weak var sideMenuView: UIView!
    
    
    @IBOutlet weak var nodataView: UIView!
    @IBOutlet weak var termsAndConditionView: UIView!
    @IBOutlet weak var faqView: UIView!
    
    @IBOutlet weak var privacyPolicyView: UIView!
    
    @IBOutlet weak var nodataLabel: UILabel!
    
    @IBOutlet weak var changePasswordView: UIView!
    @IBOutlet weak var helpView: UIView!
    
    var selectedCell : IndexPath?
    
    
    
    
    
    
    var identifer = "GetSubjectTvTableViewCell"
    
    var examss : [examViewSubjectDataDetails] = []
    var addapiRef : [AddDataDeatils] = []
    var nameString : String!
    
    var resiverId : [String] = []
    var memberId : String!
    var clgId : String!
    
    var exmHeader : String!
    var ExamName : String!
    var memberName : String!
    var colgImg : String!
    var priority : String!
    
    var loginDatas : [datalogin]!
    var logindataprinci :[datalogin]!
    
    var MobileNumber : String!
    
    var password : String!
    
    var str : [String] = []
    var strName : [String] = []
    
    var ExameSection : [examViewSubjectDataDetails] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideMenuView.isHidden = true
        
        
        let defaults = UserDefaults.standard
        
        
        
        
        print("ExameSection123",ExameSection.count)
        
        
        
        if ExameSection.count == 0 {
            
            
            
            countView.isHidden = true
            
            nodataLabel.text = " No Recored Found"
            nodataView.isHidden = false
        }
        
        
        else{
            
            nodataLabel.isHidden = true
            nodataView.isHidden = true
            countView.isHidden = false
        }
        
        let a = String(ExameSection.count)
        countLabel.text = a
        
        memberId = defaults.string(forKey: DefaultsKeys.memberid)
        clgId = defaults.string(forKey: DefaultsKeys.collegeid)
        priority = defaults.string(forKey: DefaultsKeys.priority)
        memberName = defaults.string(forKey: DefaultsKeys.memberName)
        colgImg = defaults.string(forKey: DefaultsKeys.colglogo)
        clgLogoImg.sd_setImage(with: URL(string:  colgImg), placeholderImage: UIImage(named: "person.fill"))
        MobileNumber = defaults.string(forKey: DefaultsKeys.mobileNumber)
        password = defaults.string(forKey: DefaultsKeys.Password)
        topMessageLabel.text = memberName
        
        
        
        if priority == "p1"{
            view.backgroundColor = UIColor(named: "Principal" )
            tapBarView.backgroundColor = UIColor(named: "Principal" )
            topLabels.text = "Principal"
            
        }
        
        else if priority == "p4"{
            view.backgroundColor = UIColor(named: "studentViewColors" )
            tapBarView.backgroundColor = UIColor(named: "studentViewColors" )
            topLabels.text = "Student"
            
        }
        
        else if priority == "p2" {
            view.backgroundColor = UIColor(named: "Teaching Staff" )
            tapBarView.backgroundColor = UIColor(named: "Teaching Staff" )
            topLabels.text = "Hod"
            
        }
        
        else if priority == "p5"{
            view.backgroundColor = UIColor(named: "FatherColor" )
            tapBarView.backgroundColor = UIColor(named: "FatherColor" )
            
            topLabels.text = "Father"
            
            
            
        }
        
        else if priority == "p3"{
            view.backgroundColor = UIColor(named: "Teaching Staff" )
            tapBarView.backgroundColor = UIColor(named: "Teaching Staff" )
            topLabels.text = "Teacher"
            
        }
        
        else if priority == "p6"{
            view.backgroundColor = UIColor(named: "Teaching Staff" )
            tapBarView.backgroundColor = UIColor(named: "Teaching Staff" )
            topLabels.text = "NonTeaching"
            
        }
        addApi()
        
        
        let rownib = UINib(nibName: identifer, bundle: nil)
        tv.register(rownib, forCellReuseIdentifier: identifer)
        tv.delegate = self
        tv.dataSource = self
        
        // tap Bar UiTapGuster.
        
        
        
        let changeRolesGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        changeRolesView.addGestureRecognizer(changeRolesGesture)
        
        
        let topnme = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        topNameview.addGestureRecognizer(topnme)
        
        
        
        let logoutGesture = UITapGestureRecognizer(target: self, action: #selector(logoutPressed))
        loginView.addGestureRecognizer(logoutGesture)
        
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
    
    @IBAction func adLoad(gesture:SenderExamAddsse){
        
        
        let vc = SenderExamAddVcViewController(nibName: nil, bundle: nil)
        
        vc.AddWebUrl = gesture.addUrls
        
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
        
        
    }
    @IBAction func backBtn(_ sender: Any) {
        
        dismiss(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print("ExameSection",ExameSection.count)
        
        
        
        return ExameSection.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifer, for: indexPath) as!
        
        GetSubjectTvTableViewCell
        
        
        
        cell.selectionStyle = .none
        if let selectedCells = selectedCell, selectedCells == indexPath {
            
            cell.LineView.isHidden = false
            cell.syllubusDefaultLbl.isHidden = false
            cell.subjectNameLabel.isHidden = false
            cell.syllabusName.isHidden = false
        }
        
        else{
            
            cell.subjectNameLabel.isHidden = false
            cell.LineView.isHidden = true
            cell.syllubusDefaultLbl.isHidden = true
            cell.syllabusName.isHidden = true
            
        }
        
        let sunjectList : examViewSubjectDataDetails = ExameSection[indexPath.row]
        
        
        
        cell.examName.text = ExamName
        
        
        
        let count =  String(examss.count)
        
        
        
        
        
        
        print("examViewRefName.count",examss.count)
        
        cell.examDate.text = sunjectList.examdate
        cell.sectionLabel.text = sunjectList.examsession
        cell.ExamVenuLabel.text = sunjectList.examvenue
        cell.subjectNameLabel.text = sunjectList.examsubjectname
        cell.syllabusName.text = sunjectList.examsyllabus
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        tv.deselectRow(at: indexPath, animated: true)
        
        
        
        if let selectedCells = selectedCell, selectedCells == indexPath {
            
            selectedCell = nil
            
            
            
        }
        
        else{
            
            selectedCell = indexPath
            
        }
        
        
        tv.beginUpdates()
        tv.endUpdates()
        tv.reloadData()
        
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        
        
        if let selectedCell = selectedCell, selectedCell == indexPath {
            
            return UITableView.automaticDimension
            
        } else {
            
            return 205
            
        }
    }
    
    
    
    
    
    func addApi(){
        
        var add = AddApiModal()
        
        let defaults = UserDefaults.standard
        var deviceToken = defaults.string(forKey:DefaultsKeys.DeviceToken )
        add.device_token = deviceToken
        add.member_id = memberId
        add.mobile_no = MobileNumber
        add.priority = priority
        add.college_id = clgId
        add.previous_add_id = 2
        
        
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
    
    // Tab Bar Nagivation
    
    
    // tap bar View
    
    
    
    
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
        
        //
        
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
        
        let vc = PriorityViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
    }
    
}
class SenderExamAddsse : UITapGestureRecognizer{
    
    
    var addUrls : String!
    
    
}
