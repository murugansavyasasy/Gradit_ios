//
//  AssigmentSubmissionViewController.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 05/04/23.
//

import UIKit
import ObjectMapper
import KRProgressHUD

@available(iOS 16.0, *)
class AssigmentSubmissionViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var customTabbar: CustomTabBar!
    @IBOutlet weak var ImageShowCv: UICollectionView!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var smallImg: UIImageView!
    @IBOutlet weak var bigImg: UIImageView!
    @IBOutlet weak var changeRolesView: UIView!
    @IBOutlet weak var sideMenuView: UIView!
    @IBOutlet weak var termsAndConditionView: UIView!
    @IBOutlet weak var faqView: UIView!
    @IBOutlet weak var privacyPolicyView: UIView!
    @IBOutlet weak var changePasswordView: UIView!
    @IBOutlet weak var helpView: UIView!
    
    var identfire = "AssigmentMoreCollectionViewCell"
    var assigmentMemberCount : [AssigmentmebCountData] = []
    var addapiRef : [AddDataDeatils] = []
    var memberId : String!
    var assigmentId : String!
    var assigmentFileType : String!
    var cellMemberId : String!
    var priority : String!
    var mobileNumber : String!
    var colgId : String!
    var str : [String] = []
    var strName : [String] = []
    var password : String!
    var Assigment = "6"
    var is_read_enabled = ""
    var is_write_enabled = ""
    var SucessShow : Bool!
    var updateSecTime = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        
        sideMenuView.isHidden = true
        let defaults = UserDefaults.standard
        
        memberId = defaults.string(forKey: DefaultsKeys.memberid)
        priority = defaults.string(forKey: DefaultsKeys.priority)
        mobileNumber = defaults.string(forKey: DefaultsKeys.mobileNumber)
        colgId = defaults.string(forKey: DefaultsKeys.collegeid)
        password = defaults.string(forKey: DefaultsKeys.Password)
        
        view.backgroundColor = .priorityColor
        
        customTabbar.delegate = self
        
        ImageShowCv.delegate = self
        ImageShowCv.dataSource = self
        
        if priority == "p4" || priority == "p5" {
            AssignmentSubmissionForStudent()
        }else {
            assigmentCount()
        }
        
        let menuRowNib1 = UINib(nibName: identfire, bundle: nil)
        ImageShowCv.register(menuRowNib1, forCellWithReuseIdentifier: identfire)
        
        addApi()
        
        // tap Bar UiTapGuster.
        
        let changeRolesGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        changeRolesView.addGestureRecognizer(changeRolesGesture)
        
        let logoutGesture = UITapGestureRecognizer(target: self, action: #selector(logoutPressed))
        loginView.addGestureRecognizer(logoutGesture)
        
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        guard let layout = ImageShowCv.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        let width = ImageShowCv.bounds.width
        guard width > 0, layout.estimatedItemSize.width != width else { return }

        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = .zero
        layout.itemSize = UICollectionViewFlowLayout.automaticSize          // keep
        layout.estimatedItemSize = CGSize(width: width, height: 100)        // width MUST equal collection width
        layout.invalidateLayout()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { _ in
            self.ImageShowCv.collectionViewLayout.invalidateLayout()
        })
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height-50
                print("keyboardSize.height",keyboardSize.height)
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @IBAction func adLoad(gesture : senderassSubmisionAdd){
        
        let vc = SenderExamAddVcViewController(nibName: nil, bundle: nil)
        vc.AddWebUrl = gesture.url
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
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
    
    
    @IBAction func attechentVc( gesture : AttechmentClick){
        
        let vc = AttechmentViewController(nibName: nil, bundle: nil)
        vc.memberId = gesture.meberId
        vc.assigmentId = assigmentId
        vc.assigmentFileType = assigmentFileType
        vc.studentName = gesture.submisionName
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
    }
    
    
    func assigmentCount(){
        
        var assigmentCount = assigmentMemberCountModal()
        
        assigmentCount.assignmentid = assigmentId
        assigmentCount.processby = memberId
        assigmentCount.submissiontype = "submitted"
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.GetAssignmentSubmissions,
            httpMethod: .post,
            queryParam: nil,
            requestBody: assigmentCount
        ) { [weak self] (result: Result<assigmentMemberCountResponce, Error>) in
            
            guard let self = self else { return }
            
            switch result {
                
            case .success(let AssigmentResp):
                
                if AssigmentResp.Status == 1 {
                    
                    self.assigmentMemberCount = AssigmentResp.data ?? []
                    
                    if updateSecTime == "1" {
                        
                    }else{
                        self.ImageShowCv.reloadData()
                    }
                }else{
                    
                    self.ImageShowCv.reloadData()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func AssignmentSubmissionForStudent(){
        
        var assigmentCount = assigmentMemberCountModal()
        assigmentCount.assignmentid = assigmentId
        assigmentCount.processby = memberId
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.GetSubmittedAssignmentForStudents,
            httpMethod: .post,
            queryParam: nil,
            requestBody: assigmentCount
        ) { [weak self] (result: Result<assigmentMemberCountResponce, Error>) in
            
            guard let self = self else { return }
            
            switch result {
                
            case .success(let AssigmentResp):
                
                if AssigmentResp.Status == 1 {
                    
                    self.assigmentMemberCount = AssigmentResp.data ?? []
                    
                    if updateSecTime == "1" {
                        
                    }else{
                        self.ImageShowCv.reloadData()
                    }
                }
                
                else{
                    self.ImageShowCv.reloadData()
                    
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    @IBAction func backBtn(_ sender: Any) {
        
        dismiss(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return assigmentMemberCount.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identfire , for: indexPath) as! AssigmentMoreCollectionViewCell
        
        var assiment : AssigmentmebCountData = assigmentMemberCount[indexPath.row]
        
        assiment.ImageShow  = false
        SucessShow = assiment.ImageShow
        
        
        cell.NameLabel.text = assiment.studentname
        cell.registerNo.text =  assiment.register_number
        let firstFourFiles = Array((assiment.filearray ?? []).prefix(6))
        cell.Filepath = firstFourFiles
        cell.Filepath2 = assiment.filearray ?? []
        cell.main = self
        
        if priority == "p4" || priority == "p6" || priority == "p5"{
            
            cell.sendView.isHidden = true
            cell.MarkTextField.isEnabled = true
            
            if assiment.obtainedmark == ""{
                
                cell.MarkTextField.isHidden = true
                cell.studentLabel.text = " Not evaluted yet !"
            }else {
                cell.MarkTextField.isHidden = true
                cell.studentLabel.text = " Your mark : " + "  " + (assiment.obtainedmark ?? "")
            }
            
            cell.registerNoStack.isHidden = true
            cell.nameStack.isHidden = true
            
        }else{
            
            cell.registerNoStack.isHidden = false
            cell.nameStack.isHidden = false
            cell.sendView.isHidden = false
            cell.MarkTextField.isUserInteractionEnabled = true
            cell.studentLabel.isHidden = true
            if assiment.obtainedmark == ""{
                
            }else {
                cell.MarkTextField.text = assiment.obtainedmark
            }
            cell.MarkTextField.isUserInteractionEnabled = true
            cell.sendView.isHidden = false
            
        }
        
        let marks = SendMarks(target: self, action: #selector(Markclick))
        marks.assignmentdetailsid = assiment.assignmentdetailsid
        marks.studentid = assiment.studentid
        marks.marks = cell.MarkTextField
        marks.imageViews = cell.sucessImageView
        cell.sendView.addGestureRecognizer(marks)
        
        return cell
        
    }
    
    
    @IBAction func Markclick(ges : SendMarks){
        
        
        if ges.marks.text == "" || ges.marks.text == "Mark"{
            
            let refreshAlert = UIAlertController(title: "Alert", message: "Mark field is empty", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [self] (action: UIAlertAction!) in
                
            }))
            
            present(refreshAlert, animated: true, completion: nil)
        }
        else{
            
            ges.marks.resignFirstResponder()
            self.PutMark(studentid : ges.studentid,assignmentdetailsid : ges.assignmentdetailsid,marks : ges.marks, SucessImage: ges.imageViews)
            
        }
    }
    
    
    func PutMark(studentid : String!, assignmentdetailsid : String!, marks : UITextField!, SucessImage : UIImageView!){
        
        var markSub = PutMarkResp()
        
        markSub.assignmentdetailsid = assignmentdetailsid
        markSub.assignmentid = assigmentId
        markSub.marks = marks.text
        markSub.studentid = studentid
        markSub.processby = memberId
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.AddMarksForAssignment,
            httpMethod: .post,
            queryParam: nil,
            requestBody: markSub
        ) { [weak self] (result: Result<PutMarkResponse, Error>) in
            
            guard let self = self else { return }
            
            switch result {
                
            case .success(let PutMarkResponseResp):
                
                if PutMarkResponseResp.Status == 1 {
                    
                    self.SucessShow = true
                    
                    if self.SucessShow == true{
                        SucessImage.image = UIImage(named: "tick")
                    }else{
                        SucessImage.image = UIImage(named: "sendRocket")
                    }
                    
                    self.updateSecTime = "1"
                    self.assigmentCount()
                    
                } else{
                    
                    let refreshAlert = UIAlertController(title: "", message: PutMarkResponseResp.Message, preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                        
                    }))
                    
                    self.present(refreshAlert, animated: true, completion: nil)
                    
                }
                
            case .failure(let error):
                print(error.localizedDescription)
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
    
    
    @IBAction func changePassowrdVC(){
        
        let vc = ChangePasswordVC(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func priorityVc() {
        
        let vc = PriorityScreenVC(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
    }
    
}

@available(iOS 16.0, *)
extension AssigmentSubmissionViewController : CustomTabBarDelegate {
    func didTapSearch() {
        
    }
    
    func didTapSideMenu() {
        sideMenuView.isHidden.toggle()
    }
}

class AttechmentClick : UITapGestureRecognizer{
    
    var meberId : String!
    var submisionName : String!
    
    
}


class senderassSubmisionAdd : UITapGestureRecognizer{
    
    var url : String!
    
}


class SendMarks : UITapGestureRecognizer{
    
    var studentid : String!
    var assignmentdetailsid : String!
    var marks : UITextField!
    var imageViews : UIImageView!
    
}
