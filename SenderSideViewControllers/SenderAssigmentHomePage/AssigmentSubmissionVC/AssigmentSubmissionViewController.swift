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

@IBOutlet weak var topNameview: UIView!


@IBOutlet weak var tapBarView: UIViewX!
@IBOutlet weak var redirectLoginView: UIViewX!




@IBOutlet weak var ImageShowCv: UICollectionView!

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


@IBOutlet weak var termsAndConditionView: UIView!
@IBOutlet weak var faqView: UIView!

@IBOutlet weak var privacyPolicyView: UIView!


@IBOutlet weak var changePasswordView: UIView!
@IBOutlet weak var helpView: UIView!


@IBOutlet weak var swipeMenuHeight: NSLayoutConstraint!


@IBOutlet weak var swipeMenu: UIView!


@IBOutlet weak var menuImg: UIImageView!



@IBOutlet weak var downView: UIView!



@IBOutlet weak var cv: UICollectionView!


@IBOutlet weak var arrowImg: UIImageView!



var identfire = "AssigmentMoreCollectionViewCell"
let menuIdentifier = "MenuCollectionViewCell"
var MenuRefName :[menuApiDataDetails] = []

var assigmentMemberCount : [AssigmentmebCountData] = []

var addapiRef : [AddDataDeatils] = []
var memberId : String!
var assigmentId : String!
var assigmentFileType : String!
var cellMemberId : String!
var priority : String!
var mobileNumber : String!
var colgId : String!
var loginDatas : [datalogin]!
var logindataprinci :[datalogin]!
var str : [String] = []

var strName : [String] = []

var colgImg : String!

var password : String!

var NoticeBoardId = "1"
var videoId = "2"
var EventId = "3"
var communicationId = "4"
var imagePdfId = "5"
var Assigment = "6"
var is_read_enabled = ""
var is_write_enabled = ""

var SucessShow : Bool!

var upadeMarid = "1"

var updateSecTime = "0"
override func viewDidLoad() {
    super.viewDidLoad()
    
    overrideUserInterfaceStyle = .light
    print("jjjkkkefaerferferferf",assigmentFileType)
    
    sideMenuView.isHidden = true
    swipeMenu.isHidden = true
    swipeMenuHeight.constant = 0
    let defaults = UserDefaults.standard
    
    memberId = defaults.string(forKey: DefaultsKeys.memberid)
    priority = defaults.string(forKey: DefaultsKeys.priority)
    mobileNumber = defaults.string(forKey: DefaultsKeys.mobileNumber)
    colgId = defaults.string(forKey: DefaultsKeys.collegeid)
    topMessageLabel.text = defaults.string(forKey: DefaultsKeys.memberName)
    
    password = defaults.string(forKey: DefaultsKeys.Password)
    
    colgImg = defaults.string(forKey: DefaultsKeys.colglogo)
    clgLogoImg.sd_setImage(with: URL(string:  colgImg), placeholderImage: UIImage(named: "EmptyCollegeIcon"))
    
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
        view.backgroundColor = UIColor(named: "Teaching Staff")
        tapBarView.backgroundColor = UIColor(named: "Teaching Staff" )
        topLabels.text = "Hod"
        
    }
    
    else if priority == "p5"{
        
        view.backgroundColor = UIColor(named: "FatherColor")
        tapBarView.backgroundColor = UIColor(named: "FatherColor" )
        topLabels.text = "Father"
        
        
        
    }
    
    else if priority == "p3"{
        view.backgroundColor = UIColor(named: "Teaching Staff")
        tapBarView.backgroundColor = UIColor(named: "Teaching Staff" )
        topLabels.text = "Teacher"
        
    }
    
    
    
    
    
    if priority == "p1" {
        
        
        print("PrincipalVieewwColor")
        view.backgroundColor = UIColor(named: "Principal" )
        
        menuImg.image = UIImage(named: "principalBigMenu")
        assigmentCount()
        
    }else if priority == "p4" {
        
        print("StudentVieewwColor")
        view.backgroundColor = UIColor(named: "studentViewColors")
        
        
        menuImg.image = UIImage(named: "studentSwipeImage")
        
        AssignmentSubmissionForStudent()
        
    } else if priority == "p3" ||  priority == "p2" {
        
        print("HooodddVieewwColor")
        view.backgroundColor = UIColor(named: "Teaching Staff")
        
        menuImg.image = UIImage(named: "HodImage")
        assigmentCount()
    }
    else if priority == "p5"{
        
        
        
        view.backgroundColor = UIColor(named: "FatherColor")
        
        menuImg.image = UIImage(named: "StaffBigMenu")
        AssignmentSubmissionForStudent()
        
    }
    
    else if priority == "p6"{
        
        print("HooodddVieewwColor")
        view.backgroundColor = UIColor(named: "Teaching Staff")
        
        menuImg.image = UIImage(named: "HodImage")
        assigmentCount()
    }
    
    
    
    
    let menuRowNib1 = UINib(nibName: identfire, bundle: nil)
    ImageShowCv.register(menuRowNib1, forCellWithReuseIdentifier: identfire)
    
    let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
    swipeRight.direction = .up
    downView.addGestureRecognizer(swipeRight)
    
    let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
    swipeDown.direction = .down
    downView.addGestureRecognizer(swipeDown)
    

    addApi()
    // tap Bar UiTapGuster.
    
    
    
    let changeRolesGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
    changeRolesView.addGestureRecognizer(changeRolesGesture)
    
    
    let topna = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
    topNameview.addGestureRecognizer(topna)
    
    
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
    
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
}

@objc func keyboardWillShow(notification: NSNotification) { // -----> to set key board set height
    
    
    
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
    print("EventDefaultsKeys.DeviceToken",deviceToken)
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
    
    
    if priority == "p4"{
        
        let vc = AttechmentViewController(nibName: nil, bundle: nil)
        vc.memberId = gesture.meberId
        vc.assigmentId = assigmentId
        vc.assigmentFileType = assigmentFileType
        vc.studentName = gesture.submisionName
        vc.view.backgroundColor = UIColor(named: "StudentParent")
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
        
    }
    
    else if priority == "p2" || priority == "p3"{
        
        
        let vc = AttechmentViewController(nibName: nil, bundle: nil)
        vc.memberId = gesture.meberId
        vc.assigmentId = assigmentId
        vc.assigmentFileType = assigmentFileType
        vc.studentName = gesture.submisionName
        vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
        
        
        
    }
    
    
    else if priority == "p1"{
        
        let vc = AttechmentViewController(nibName: nil, bundle: nil)
        vc.memberId = gesture.meberId
        vc.assigmentId = assigmentId
        vc.assigmentFileType = assigmentFileType
        vc.studentName = gesture.submisionName
        vc.view.backgroundColor = UIColor(named: "Principal" )
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
        
        
        
    }
    
    else if priority == "p5"{
        
        
        
        let vc = AttechmentViewController(nibName: nil, bundle: nil)
        vc.memberId = gesture.meberId
        vc.assigmentId = assigmentId
        vc.assigmentFileType = assigmentFileType
        vc.studentName = gesture.submisionName
        vc.view.backgroundColor = UIColor(named: "FatherColor")
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
        
    }
    
    
    else if priority == "p6"{
        
        let vc = AttechmentViewController(nibName: nil, bundle: nil)
        vc.memberId = gesture.meberId
        vc.assigmentId = assigmentId
        vc.assigmentFileType = assigmentFileType
        vc.studentName = gesture.submisionName
        vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
        
        
        
    }
}


    func assigmentCount(){
        
        var assigmentCount = assigmentMemberCountModal()
        
        assigmentCount.assignmentid = assigmentId
        assigmentCount.processby = memberId
        assigmentCount.submissiontype = "submitted"
        
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
                
                if AssigmentResp.Status == 1 {
                    
                    self.assigmentMemberCount = AssigmentResp.data ?? []
                    
                    if updateSecTime == "1" {
                        
                    }else{
                        self.ImageShowCv.delegate = self
                        self.ImageShowCv.dataSource = self
                        self.ImageShowCv.reloadData()
                    }
                }
                
                else{
                    
                    self.ImageShowCv.delegate = self
                    self.ImageShowCv.dataSource = self
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
        
        print("yearAndSectionModalStr", assigmentCount)
        
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
                        self.ImageShowCv.delegate = self
                        self.ImageShowCv.dataSource = self
                        self.ImageShowCv.reloadData()
                    }
                }
                
                else{
                    
                    self.ImageShowCv.delegate = self
                    self.ImageShowCv.dataSource = self
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



// this part is bottom swipe view .



@objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
    
    if let swipeGesture = gesture as? UISwipeGestureRecognizer {
    if priority == "p4" {
    switch swipeGesture.direction {
    case .right:
        print("Swiped right")
    case .down:
        swipeMenuHeight.constant = 150
        
        print("swipeMenuHeight.constant\(swipeMenuHeight.constant)")
        
        //
        
        arrowImg.image = UIImage(named: "up")
        print("Swiped down")
    case .left:
        print("Swiped left")
    case .up:
        swipeMenuHeight.constant = 400
        
        print("swipeMenuHeight.constant\(swipeMenuHeight.constant)")
        
        arrowImg.image = UIImage(named: "down")
        print("Swiped up")
    default:
        break
    }
    }


    else if priority == "p1" {


    switch swipeGesture.direction {
    case .right:
        print("Swiped right")
    case .down:
        swipeMenuHeight.constant = 150
        
        print("swipeMenuHeight.constant\(swipeMenuHeight.constant)")
        
        arrowImg.image = UIImage(named: "up")
        print("Swiped down")
    case .left:
        print("Swiped left")
    case .up:
        
        
        if str.count <= 4{
            
            print("uiouiop")
            swipeMenuHeight.constant = 150
            
        }
        //
        else if str.count  == 5{
            
            print("uioiuiopkjhgbjnkmjhvgyjbkn,m")
            swipeMenuHeight.constant = 240
            
        }
        else if str.count == 6{
            
            
            swipeMenuHeight.constant = 240
        }
        //
        else if str.count == 7 {
            
            
            
            swipeMenuHeight.constant = 240
        }
        
        else if str.count == 8{
            
            
            swipeMenuHeight.constant = 240
        }
        
        else if str.count == 9{
            
            
            swipeMenuHeight.constant = 300
        }
        else if str.count == 10{
            
            
            swipeMenuHeight.constant = 300
        }
        
        
        else if str.count == 11{
            
            
            swipeMenuHeight.constant = 300
        }
        
        
        else if str.count == 12{
            
            
            swipeMenuHeight.constant = 300
        }
        
        
        else if str.count == 13{
            
            
            swipeMenuHeight.constant = 470
        }
        
        
        else if str.count == 14{
            
            
            swipeMenuHeight.constant = 470
        }
        
        else if str.count == 15{
            
            
            swipeMenuHeight.constant = 400
            
            
        }
        
        else {
            
            
            swipeMenuHeight.constant = 400
            
        }
        
        menuImg.image = UIImage(named: "principalBigMenu")
        
        
        print("swipeMenuHeight.constant\(swipeMenuHeight.constant)")
        
        arrowImg.image = UIImage(named: "down")
        print("Swiped up")
    default:
        break
    }


    }

    else if priority == "p2" || priority == "p3" {



    switch swipeGesture.direction {
    case .right:
        print("Swiped right")
    case .down:
        swipeMenuHeight.constant = 150
        
        print("swipeMenuHeight.constant\(swipeMenuHeight.constant)")
        
        menuImg.image = UIImage(named: "HodImage")
        
        arrowImg.image = UIImage(named: "up")
        print("Swiped down")
    case .left:
        print("Swiped left")
    case .up:
        
        
        if str.count <= 4{
            
            print("uiouiop")
            swipeMenuHeight.constant = 150
            
        }
        //
        else if str.count  == 5{
            
            print("uioiuiopkjhgbjnkmjhvgyjbkn,m")
            swipeMenuHeight.constant = 240
            
        }
        else if str.count == 6{
            
            
            swipeMenuHeight.constant = 240
        }
        //
        else if str.count == 7 {
            
            
       
            swipeMenuHeight.constant = 240
        }
        
        else if str.count == 8{
            
            
            swipeMenuHeight.constant = 240
        }
        
        else if str.count == 9{
            
            
            swipeMenuHeight.constant = 300
        }
        else if str.count == 10{
            
            
            swipeMenuHeight.constant = 300
        }
        
        
        else if str.count == 11{
            
            
            swipeMenuHeight.constant = 300
        }
        
        
        else if str.count == 12{
            
            
            swipeMenuHeight.constant = 300
        }
        
        
        else if str.count == 13{
            
            
            swipeMenuHeight.constant = 470
        }
        
        
        else if str.count == 14{
            
            
            swipeMenuHeight.constant = 470
        }
        
        else if str.count == 15{
            
            
            swipeMenuHeight.constant = 400
            
            
        }
        
        else {
            
            
            swipeMenuHeight.constant = 400
            
        }
        
        print("swipeMenuHeight.constant\(swipeMenuHeight.constant)")
        
        arrowImg.image = UIImage(named: "down")
        print("Swiped up")
    default:
        break
    }
    //
    }

    else if priority == "p5"{
    switch swipeGesture.direction {
    case .right:
        print("Swiped right")
    case .down:
        swipeMenuHeight.constant = 150
        
        print("swipeMenuHeight.constant\(swipeMenuHeight.constant)")
        
        arrowImg.image = UIImage(named: "up")
        print("Swiped down")
    case .left:
        print("Swiped left")
    case .up:
        swipeMenuHeight.constant = 400
        
        print("swipeMenuHeight.constant\(swipeMenuHeight.constant)")
        
        arrowImg.image = UIImage(named: "down")
        print("Swiped up")
    default:
        break
    }
    //



    }


    else if priority == "p6"  {



    switch swipeGesture.direction {
    case .right:
        print("Swiped right")
    case .down:
        swipeMenuHeight.constant = 150
        
        print("swipeMenuHeight.constant\(swipeMenuHeight.constant)")
        arrowImg.image = UIImage(named: "up")
        print("Swiped down")
    case .left:
        print("Swiped left")
    case .up:
        
        if str.count <= 4{
            
            print("uiouiop")
            swipeMenuHeight.constant = 150
            
        }
        //
        else if str.count  == 5{
            
            print("uioiuiopkjhgbjnkmjhvgyjbkn,m")
            swipeMenuHeight.constant = 240
            
        }
        else if str.count == 6{
            
            
            swipeMenuHeight.constant = 240
        }
        //
        else if str.count == 7 {
            
            
            
            
            swipeMenuHeight.constant = 240
        }
        
        else if str.count == 8{
            
            
            swipeMenuHeight.constant = 240
        }
        
        else if str.count == 9{
            
            
            swipeMenuHeight.constant = 300
        }
        else if str.count == 10{
            
            
            swipeMenuHeight.constant = 300
        }
        
        
        else if str.count == 11{
            
            
            swipeMenuHeight.constant = 300
        }
        
        
        else if str.count == 12{
            
            
            swipeMenuHeight.constant = 300
        }
        
        
        else if str.count == 13{
            
            
            swipeMenuHeight.constant = 470
        }
        
        
        else if str.count == 14{
            
            
            swipeMenuHeight.constant = 470
        }
        
        else if str.count == 15{
            
            
            swipeMenuHeight.constant = 400
            
            
        }
        
        else {
            
            
            swipeMenuHeight.constant = 400
            
        }
        
        
        print("swipeMenuHeight.constant\(swipeMenuHeight.constant)")
        
        arrowImg.image = UIImage(named: "down")
        print("Swiped up")
    default:
        break
    }
    //
    }


    }
    
}





func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    if collectionView == ImageShowCv{
        
        
        
        return assigmentMemberCount.count
        
    }
    else{
        if priority == "p4"{
            
            print("stu",strName.count)
            return strName.count
        }
        
        else if priority == "p1"{
            
            print("Prin",strName.count)
            return strName.count
            
        }
        
        
        else if priority == "p2" || priority == "p3"{
            
            print("Teach",strName.count)
            return strName.count
        }
        
        else if priority == "p5"{
            
            print("father",strName.count)
            return strName.count
            
        }
        
        
        else if priority == "p6"{
            
            print("father",strName.count)
            return strName.count
            
        }
        
    }
    return 0
    
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    
    if collectionView == ImageShowCv{
        
        
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identfire , for: indexPath) as! AssigmentMoreCollectionViewCell
        
        
        
        
        var assiment : AssigmentmebCountData = assigmentMemberCount[indexPath.row]
        
        assiment.ImageShow  = false
        //
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
            }
            else {
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
                
                
            }
            else {
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
    
    
    
    else{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: menuIdentifier , for: indexPath) as! MenuCollectionViewCell
        
        
        if priority == "p4"{
            
            
            
            cell.menuNameLbl.text = strName[indexPath.row]
            
            cell.menuImg.image = UIImage(named: String(str[indexPath.row]))
            
            
            
        }
        
        else if priority == "p1"{
            
            
            
            
            cell.menuNameLbl.text = strName[indexPath.row]
            
            cell.menuImg.image = UIImage(named: String(str[indexPath.row]))
            
            
        }
        
        
        else if priority == "p2" || priority == "p3"{
            
            cell.menuNameLbl.text = strName[indexPath.row]
            
            cell.menuImg.image = UIImage(named: String(str[indexPath.row]))
            
            
            
            
        }
        
        else if priority == "p5"{
            
            
            cell.menuNameLbl.text = strName[indexPath.row]
            
            cell.menuImg.image = UIImage(named: String(str[indexPath.row]))
            
            
            
        }
        
        
        
        else if priority == "p6"{
            
            cell.menuNameLbl.text = strName[indexPath.row]
            
            cell.menuImg.image = UIImage(named: String(str[indexPath.row]))
            
            
            
        }
        
        
        return cell
        
    }
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
        
        print("yearAndSectionModalStr", markSub)
        
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

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    if collectionView == ImageShowCv{
        let collectionView = collectionView.bounds.width
        
        
        
        let assiment : AssigmentmebCountData = assigmentMemberCount[indexPath.row]
        
        if assiment.filearray?.count == 1{
            
            return CGSize(width: collectionView / 1 - 2, height: collectionView / 1 - 2)
            //
        }else if assiment.filearray?.count == 2{
            return CGSize(width: collectionView / 1 - 2, height: collectionView / 1 - 2)
            //
            
        }else if assiment.filearray?.count == 3{
            return CGSize(width: collectionView / 1 - 2, height: collectionView / 1 - 2)
            //
            
        }else if assiment.filearray?.count == 4{
            
            return CGSize(width: collectionView / 1 - 2, height: 450)
        }else if assiment.filearray?.count == 5{
            
            return CGSize(width: collectionView / 1 - 2, height: 450)
        }else if assiment.filearray?.count == 6{
            return CGSize(width: collectionView / 1 - 2, height: 450)
            
        }
        
        else{
            
            return CGSize(width: collectionView / 1 - 2, height: 450)
        }
        
        
    }
    else{
        return CGSize(width: collectionView.frame.size.width / 4, height: 80)
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

func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    
    
    if collectionView == ImageShowCv{
        
        
        
    }
    
    else{
        
        if priority == "p4"{
            
            
            if str[indexPath.row] == "home"{
                
                let vc = HomeScreenViewController(nibName: nil, bundle: nil)
                let currentController = self.getCurrentViewController()
                
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false, completion: nil)
                
                
            }
            
            else if str[indexPath.row] == "voice"{
                
                let vc = CommunicationHomePageViewController(nibName: nil, bundle: nil)
                
                print("communicationssssssss")
                let currentController = self.getCurrentViewController()
                
                
                vc.view.backgroundColor = UIColor(named: "StudentParent")
                vc.modalPresentationStyle = .fullScreen
                
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                currentController?.present(vc, animated: false, completion: nil)
                
                
                
                
            }
            else if str[indexPath.row] == "text"{
                
                let vc = CommuniSMSViewController(nibName: nil, bundle: nil)
                
                print("communicationssssssss")
                let currentController = self.getCurrentViewController()
                
                
                vc.view.backgroundColor = UIColor(named: "StudentParent")
                vc.modalPresentationStyle = .fullScreen
                
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                currentController?.present(vc, animated: false, completion: nil)
                
                
                
                
            }
            
            
            else if str[indexPath.row] == "examination"{
                
                
                let vc = ExaminationHomePageViewController(nibName: nil, bundle: nil)
                let currentController = self.getCurrentViewController()
                vc.view.backgroundColor = UIColor(named: "StudentParent")
                vc.modalPresentationStyle = .fullScreen
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                currentController?.present(vc, animated: false, completion: nil)
                
                
            }
            
            
            else if str[indexPath.row] == "attendance"{
                
                
                let vc = AttendanceViewController(nibName: nil, bundle: nil)
                let currentController = self.getCurrentViewController()
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.modalPresentationStyle = .fullScreen
                
                currentController?.present(vc, animated: false, completion: nil)
                
                
                
            }
            
            
            else if str[indexPath.row] == "assignment"{
                
                let vc = AssigmentHomePageViewController(nibName: nil, bundle: nil)
                let currentController = self.getCurrentViewController()
                vc.view.backgroundColor = UIColor(named: "StudentParent")
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: false, completion: nil)
                
                
            }
            
            
            
            else if str[indexPath.row] == "circular"{
                
                
                let vc = ImageViewController(nibName: nil, bundle: nil)
                let currentController = self.getCurrentViewController()
                vc.view.backgroundColor = UIColor(named: "StudentParent")
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: false, completion: nil)
                
                
                
                
            }
            
            
            
            else if str[indexPath.row] == "notice_board"{
                
                
                let vc = NoticeBoardHomePageViewController(nibName: nil, bundle: nil)
                let currentController = self.getCurrentViewController()
                vc.view.backgroundColor = UIColor(named: "StudentParent")
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: false, completion: nil)
                
                
            }
            
            
            
            else if str[indexPath.row] == "events"{
                
                let vc = EventsViewController(nibName: nil, bundle: nil)
                vc.modalPresentationStyle = .fullScreen
                let currentController = self.getCurrentViewController()
                vc.view.backgroundColor = UIColor(named: "StudentParent")
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: false, completion: nil)
                
                
                
            }
            
            
            else if str[indexPath.row] == "faculty"{
                
                let vc = FacultyHomePageViewController(nibName: nil, bundle: nil)
                let currentController = self.getCurrentViewController()
                vc.view.backgroundColor = UIColor(named: "StudentParent")
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: false, completion: nil)
                
                
            }
            
            
            else if str[indexPath.row] == "video"{
                
                let vc = VideoViewController(nibName: nil, bundle: nil)
                let currentController = self.getCurrentViewController()
                vc.view.backgroundColor = UIColor(named: "StudentParent")
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: false, completion: nil)
                
            }
            
            else if str[indexPath.row] == "chat"{
                
                
                let vc = ChatHomePageViewController(nibName: nil, bundle: nil)
                
                let currentController = self.getCurrentViewController()
                vc.view.backgroundColor = UIColor(named: "imagSafeAreaColor")
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: false, completion: nil)
                
            }
            
            else if str[indexPath.row] == "course_details"{
                
                let vc = CourseHomePageViewController(nibName: nil, bundle: nil)
                //            vc.modalPresentationStyle = .fullScreen
                let currentController = self.getCurrentViewController()
                vc.view.backgroundColor = UIColor(named: "imagSafeAreaColor")
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: false, completion: nil)
                
                
                
            }
            
            
            else if str[indexPath.row] == "category_credit_points"{
                
                
                let vc = CategoryHomePageViewController(nibName: nil, bundle: nil)
                let currentController = self.getCurrentViewController()
                vc.view.backgroundColor = UIColor(named: "imagSafeAreaColor")
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: false, completion: nil)
                
                
            }
            
            
            else if str[indexPath.row] == "sem_credit_points"{
                
                let vc = SemesterHomePageViewController(nibName: nil, bundle: nil)
                let currentController = self.getCurrentViewController()
                vc.view.backgroundColor = UIColor(named: "imagSafeAreaColor")
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: false, completion: nil)
                
                
                
            }
            
            
            
            
            else if str[indexPath.row] == "exam_application_details"{
                
                
                let vc = ExamDetailsHomePageViewController(nibName: nil, bundle: nil)
                let currentController = self.getCurrentViewController()
                vc.view.backgroundColor = UIColor(named: "imagSafeAreaColor")
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: false, completion: nil)
                
                
            }
            //
            //
            //
            
            
            
        }
        
        else if priority == "p1"{
            
            
            
            if str[indexPath.row] == "home"{
                
                
                
                let vc = HomeScreenViewController(nibName: nil, bundle: nil)
                let currentController = self.getCurrentViewController()
                vc.view.backgroundColor = UIColor(named: "Principal" )
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: false, completion: nil)
                
                
                
            }
            
            
            
            else if str[indexPath.row] == "voice"{
                
                
                let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
                let currentController = self.getCurrentViewController()
                vc.view.backgroundColor = UIColor(named: "Principal" )
                vc.CommuniSegementName.backgroundColor = UIColor(named: "UnSelector")
                vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "Selector")
                vc.ComunimenuId = communicationId
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: false, completion: nil)
                
            }
            else if str[indexPath.row] == "text"{
                
                
                let vc = CommuniSMSViewController(nibName: nil, bundle: nil)
                let currentController = self.getCurrentViewController()
                vc.view.backgroundColor = UIColor(named: "Principal" )
                vc.CommuniSegementName.backgroundColor = UIColor(named: "UnSelector")
                vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "Selector")
                vc.ComunimenuId = communicationId
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: false, completion: nil)
                
            }
            
            
            
            else if str[indexPath.row] == "examination"{
                
                
                let vc = SenderExmainationHomePageViewController(nibName: nil, bundle: nil)
                let currentController = self.getCurrentViewController()
                vc.view.backgroundColor = UIColor(named: "Principal" )
                vc.examSegmentName.backgroundColor = UIColor(named: "UnSelector")
                vc.examSegmentName.selectedSegmentTintColor = UIColor(named: "Selector")
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: false, completion: nil)
                
                
            }
            
            
            
            else if str[indexPath.row] == "attendance"{
                
                
                
                let vc =  SenderAttendanceVcViewController(nibName: nil, bundle: nil)
                let currentController = self.getCurrentViewController()
                vc.view.backgroundColor = UIColor(named: "Principal" )
                vc.segmentName.backgroundColor = UIColor(named: "UnSelector")
                vc.segmentName.selectedSegmentTintColor = UIColor(named: "Selector")
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: false, completion: nil)
                
                
            }
            
            
            else if str[indexPath.row] == "assignment"{
                
                
                let vc = SenderAssigmentHomePageViewController(nibName: nil, bundle: nil)
                let currentController = self.getCurrentViewController()
                vc.view.backgroundColor = UIColor(named: "Principal" )
                vc.assigmentSegmentName.backgroundColor = UIColor(named: "UnSelector")
                vc.assigmentSegmentName.selectedSegmentTintColor = UIColor(named: "Selector")
                vc.assigmentMenuId = Assigment
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: false, completion: nil)
                
                //
            }
            
            
            else if str[indexPath.row] == "circular"{
                
                let vc = SenderImagePdfHomePageViewController(nibName: nil, bundle: nil)
                let currentController = self.getCurrentViewController()
                vc.view.backgroundColor = UIColor(named: "Principal" )
                vc.imageSegmentName.backgroundColor = UIColor(named: "UnSelector")
                vc.imageSegmentName.selectedSegmentTintColor = UIColor(named: "Selector")
                vc.imagePdfMenuIdType = imagePdfId
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: false, completion: nil)
                
                
            }
            
            else if str[indexPath.row] == "notice_board"{
                
                let vc = SenderGraditNoticeBoardMenuViewController(nibName: nil, bundle: nil)
                let currentController = self.getCurrentViewController()
                vc.view.backgroundColor = UIColor(named: "Principal" )
                vc.noticeSegments.backgroundColor = UIColor(named: "UnSelector")
                vc.noticeSegments.selectedSegmentTintColor = UIColor(named: "Selector")
                vc.menuTypessww = NoticeBoardId
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: false, completion: nil)
                
                
            }
            
            
            
            else if str[indexPath.row] == "events"{
                
                
                let vc = SenderEventHomePageViewController(nibName: nil, bundle: nil)
                let currentController = self.getCurrentViewController()
                vc.view.backgroundColor = UIColor(named: "Principal" )
                vc.eventSegmentName.backgroundColor = UIColor(named: "UnSelector")
                vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "Selector")
                vc.EventMenuId = EventId
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: false, completion: nil)
                
                
            }
            
            
            
            else if str[indexPath.row] == "faculty"{
                
                print("faculty is clicked")
                
                let vc = SenderFacultyViewController(nibName: nil, bundle: nil)
                
                vc.view.backgroundColor = UIColor(named: "Principal" )
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false, completion: nil)
                
                
            }
            
            else if str[indexPath.row] == "video"{
                
                
                let vc = SenderVideoHomePageViewController(nibName: nil, bundle: nil)
                let currentController = self.getCurrentViewController()
                vc.view.backgroundColor = UIColor(named: "Principal" )
                vc.videoId = videoId
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: false, completion: nil)
                
                
            }
            
            
            else if str[indexPath.row] == "chat"{
                
                
                print("chat is clicked ")
                
                
                let vc =  ChatSenderViewController(nibName: nil, bundle: nil)
                vc.view.backgroundColor = UIColor(named: "Principal" )
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false, completion: nil)
                
                
            }
            
            
        }
        
        
        else if priority == "p2" || priority == "p3"{
            
            if str[indexPath.row] == "home"{
                
                
                
                let vc = HomeScreenViewController(nibName: nil, bundle: nil)
                let currentController = self.getCurrentViewController()
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: false, completion: nil)
                
                
                
            }
            
            
            
            else if str[indexPath.row] == "voice"{
                
                
                let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
                vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                vc.ComunimenuId = communicationId
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false, completion: nil)
                
            }
            
            
            else if str[indexPath.row] == "text"{
                
                
                let vc = CommuniSMSViewController(nibName: nil, bundle: nil)
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
                vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                vc.ComunimenuId = communicationId
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false, completion: nil)
                
            }
            else if str[indexPath.row] == "examination"{
                
                
                let vc = SenderExmainationHomePageViewController(nibName: nil, bundle: nil)
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.examSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                vc.examSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false, completion: nil)
                
                
            }
            
            
            
            else if str[indexPath.row] == "attendance"{
                
                
                let vc =  SenderAttendanceVcViewController(nibName: nil, bundle: nil)
                let currentController = self.getCurrentViewController()
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.segmentName.backgroundColor = UIColor(named: "HodUnSelector")
                vc.segmentName.selectedSegmentTintColor = UIColor(named: "HodUnSelector")
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: false, completion: nil)
                
                
                
            }
            
            
            else if str[indexPath.row] == "assignment"{
                
                
                let vc = SenderAssigmentHomePageViewController(nibName: nil, bundle: nil)
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.assigmentSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                vc.assigmentSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                vc.assigmentMenuId = Assigment
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false, completion: nil)
                //
            }
            
            
            else if str[indexPath.row] == "circular"{
                
                let vc = SenderImagePdfHomePageViewController(nibName: nil, bundle: nil)
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.imageSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                vc.imageSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                vc.imagePdfMenuIdType = imagePdfId
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false, completion: nil)
                
            }
            
            else if str[indexPath.row] == "notice_board"{
                
                let vc = SenderGraditNoticeBoardMenuViewController(nibName: nil, bundle: nil)
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.noticeSegments.backgroundColor = UIColor(named: "HodUnSelector")
                vc.noticeSegments.selectedSegmentTintColor = UIColor(named: "HodSelector")
                vc.menuTypessww = NoticeBoardId
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false, completion: nil)
                
            }
            
            
            
            else if str[indexPath.row] == "events"{
                
                
                let vc = SenderEventHomePageViewController(nibName: nil, bundle: nil)
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.eventSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                vc.EventMenuId = EventId
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false, completion: nil)
                
            }
            
            
            
            else if str[indexPath.row] == "faculty"{
                
                let vc = SenderFacultyViewController(nibName: nil, bundle: nil)
                
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false, completion: nil)
                
                
                
            }
            
            else if str[indexPath.row] == "video"{
                
                
                let vc = SenderVideoHomePageViewController(nibName: nil, bundle: nil)
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                
                
                vc.str = str
                vc.strName = strName
                vc.VideoMenuId = videoId
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false, completion: nil)
                
            }
            
            
            else if str[indexPath.row] == "chat"{
                
                
                let vc =  ChatSenderViewController(nibName: nil, bundle: nil)
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false, completion: nil)
                
                
                
            }
            
            
            
        }
        
        
        else if priority == "p6"{
            
            if str[indexPath.row] == "home"{
                
                
                
                let vc = HomeScreenViewController(nibName: nil, bundle: nil)
                let currentController = self.getCurrentViewController()
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: false, completion: nil)
                
                
                
            }
            
            
            
            else if str[indexPath.row] == "voice"{
                
                
                let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
                vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                vc.ComunimenuId = communicationId
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false, completion: nil)
                
            }
            else if str[indexPath.row] == "text"{
                
                
                let vc = CommuniSMSViewController(nibName: nil, bundle: nil)
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
                vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                vc.ComunimenuId = communicationId
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false, completion: nil)
                
            }
            
            
            
            
            else if str[indexPath.row] == "examination"{
                
                
                let vc = SenderExmainationHomePageViewController(nibName: nil, bundle: nil)
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.examSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                vc.examSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false, completion: nil)
                
                
            }
            
            
            
            else if str[indexPath.row] == "attendance"{
                
                
                let vc =  SenderAttendanceVcViewController(nibName: nil, bundle: nil)
                let currentController = self.getCurrentViewController()
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.segmentName.backgroundColor = UIColor(named: "HodUnSelector")
                vc.segmentName.selectedSegmentTintColor = UIColor(named: "HodUnSelector")
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: false, completion: nil)
                
                
                
            }
            
            
            else if str[indexPath.row] == "assignment"{
                
                
                let vc = SenderAssigmentHomePageViewController(nibName: nil, bundle: nil)
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.assigmentSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                vc.assigmentSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                vc.assigmentMenuId = Assigment
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false, completion: nil)
                //
            }
            
            
            else if str[indexPath.row] == "circular"{
                
                let vc = SenderImagePdfHomePageViewController(nibName: nil, bundle: nil)
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.imageSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                vc.imageSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                vc.imagePdfMenuIdType = imagePdfId
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false, completion: nil)
                
            }
            
            else if str[indexPath.row] == "notice_board"{
                
                let vc = SenderGraditNoticeBoardMenuViewController(nibName: nil, bundle: nil)
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.noticeSegments.backgroundColor = UIColor(named: "HodUnSelector")
                vc.noticeSegments.selectedSegmentTintColor = UIColor(named: "HodSelector")
                vc.menuTypessww = NoticeBoardId
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false, completion: nil)
                
            }
            
            
            
            else if str[indexPath.row] == "events"{
                
                
                let vc = SenderEventHomePageViewController(nibName: nil, bundle: nil)
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.eventSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                vc.EventMenuId = EventId
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false, completion: nil)
                
            }
            
            
            
            else if str[indexPath.row] == "faculty"{
                
                let vc = SenderFacultyViewController(nibName: nil, bundle: nil)
                
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false, completion: nil)
                
                
                
            }
            
            else if str[indexPath.row] == "video"{
                
                
                let vc = SenderVideoHomePageViewController(nibName: nil, bundle: nil)
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                
                vc.VideoMenuId = videoId
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false, completion: nil)
                
            }
            
            
            else if str[indexPath.row] == "chat"{
                
                
                let vc =  ChatSenderViewController(nibName: nil, bundle: nil)
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false, completion: nil)
                
                
                
            }
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

    @IBAction func priorityVc() {
        
        let vc = PriorityViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
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
