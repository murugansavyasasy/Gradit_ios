//
//  AssigmentNotSubViewController.swift
//  Vs_GradItCollege
//
//  Created by admin on 04/03/24.
//

import UIKit
import ObjectMapper

@available(iOS 16.0, *)
class AssigmentNotSubViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tv: UITableView!
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var customTabbar: CustomTabBar!
    @IBOutlet weak var smallImg: UIImageView!
    @IBOutlet weak var bigImg: UIImageView!
    @IBOutlet weak var sideMenuView: UIView!

    
    var assigmentId : String!
    var memberId  : String!
    var Indentifiers = "NotSubmitTableViewCell"
    var assigmentMemberCount : [AssigmentmebCountData] = []
    var priority : String!
    var mobileNumber : String!
    var colgId : String!
    var addapiRef : [AddDataDeatils] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        let defaults = UserDefaults.standard
        
        memberId = defaults.string(forKey: DefaultsKeys.memberid)
        priority = defaults.string(forKey: DefaultsKeys.priority)
        mobileNumber = defaults.string(forKey: DefaultsKeys.mobileNumber)
        colgId = defaults.string(forKey: DefaultsKeys.collegeid)
        
        let rowNib = UINib(nibName: Indentifiers, bundle: nil)
        tv.register(rowNib, forCellReuseIdentifier: Indentifiers)
        
        sideMenuView.isHidden = true
        
        customTabbar.delegate = self
        
        tv.delegate = self
        tv.dataSource = self
        
        addApi()
        
        assigmentCount()
        
        baseView.backgroundColor = .priorityColor
        
    }
    
    @IBAction func back(_ sender: Any) {
        
        dismiss(animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return assigmentMemberCount.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Indentifiers, for: indexPath) as! NotSubmitTableViewCell
        
        let notSubmit : AssigmentmebCountData = assigmentMemberCount[indexPath.row]
        cell.serilNom.text = String(indexPath.row+1)
        cell.regNumber.text = notSubmit.register_number
        cell.courseLbl.text = notSubmit.course
        cell.nameLbl.text = notSubmit.studentname
        cell.yearLbl.text = notSubmit.year
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func assigmentCount(){
        
        var assigmentCount = assigmentMemberCountModal()
        
        assigmentCount.assignmentid = assigmentId
        assigmentCount.processby = memberId
        assigmentCount.submissiontype = "notsubmitted"
        
        print("yearAndSectionModalStr", assigmentCount)
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.GetAssignmentSubmissions,
            httpMethod: .post,
            queryParam: nil,
            requestBody: assigmentCount
        ) { [weak self] (result: Result<assigmentMemberCountResponce, Error>) in
            
            guard let self = self else { return }
            
            switch result {
                
            case .success(let AssigmentResp):
                
                self.assigmentMemberCount = AssigmentResp.data ?? []
                self.tv.reloadData()
                
            case .failure(let error):
                print(error.localizedDescription)
                self.assigmentMemberCount = []
                self.tv.reloadData()
            }
            
        }
    }
    
    func addApi(){
        
        var add = AddApiModal()
        
        let defaults = UserDefaults.standard
        var deviceToken = defaults.string(forKey:DefaultsKeys.DeviceToken )
        add.device_token = deviceToken
        add.member_id = Int(memberId)
        add.mobile_no = mobileNumber
        add.priority = priority
        add.college_id = Int(colgId)
        add.previous_add_id = 3
        
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
    
    @IBAction func adLoad(gesture : senderassSubmisionAdd){
        
        let vc = SenderExamAddVcViewController(nibName: nil, bundle: nil)
        vc.AddWebUrl = gesture.url
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
    }
    
    @IBAction func ChangeRoleBtnAct(_ sender: UIButton) {
        
        let vc = PriorityScreenVC(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
    }
    
    @IBAction func FaqBtnAct(_ sender: UIButton) {
        let vc = FaqViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func HelpBtnAct(_ sender: UIButton) {
        let vc = HelpViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func PrivacyPolicyBtnAct(_ sender: UIButton) {
        let vc = PrivacyPolicyViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func TermsAndConditionsBtnAct(_ sender: UIButton) {
        let vc = MenuTermsViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func ChangePasswordBtnAct(_ sender: UIButton) {
        let vc = ChangePasswordVC(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func LogoutBtnAct(_ sender: UIButton) {
        
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
}

@available(iOS 16.0, *)
extension AssigmentNotSubViewController : CustomTabBarDelegate {
    func didTapSearch() {
        
    }
    
    func didTapSideMenu() {
        sideMenuView.isHidden.toggle()
    }
}
