//
//  plusPageViewController.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 20/03/23.
//

import UIKit
import DropDown
import ObjectMapper
import KRProgressHUD

@available(iOS 16.0, *)
class plusPageViewController: UIViewController,UITextViewDelegate {


@IBOutlet weak var lblCount: UILabel!
@IBOutlet weak var noOfdateLabel: UILabel!
@IBOutlet weak var leaveTypDropDownView: UIViewX!
@IBOutlet weak var confirmView: UIViewX!
@IBOutlet weak var loginView: UIView!
@IBOutlet weak var dropDownLabel: UILabel!
@IBOutlet weak var toDateLabel: UILabel!
@IBOutlet weak var fromDateLabel: UILabel!
@IBOutlet weak var calanderTopHeight: NSLayoutConstraint!
@IBOutlet weak var calandViewss: UIView!
@IBOutlet weak var tapBarView: UIViewX!
@IBOutlet weak var reason: UITextView!
@IBOutlet weak var toDateView: UIView!
@IBOutlet weak var fromDateView: UIView!
@IBOutlet weak var topMemberLabel: UILabel!
@IBOutlet weak var logoutView: UIView!
@IBOutlet weak var changeRolesView: UIView!
@IBOutlet weak var profileView: UIView!
@IBOutlet weak var topLabels: UILabel!
@IBOutlet weak var clgLogoImg: UIImageView!
@IBOutlet weak var notificationView: UIView!
@IBOutlet weak var privacyPolicyView: UIView!
@IBOutlet weak var cancelssView: UIViewX!
@IBOutlet weak var faqView: UIView!
@IBOutlet weak var refreshView: UIView!
@IBOutlet weak var viewTap: UIView!
@IBOutlet weak var sideMenuView: UIView!
@IBOutlet weak var helpView: UIView!
@IBOutlet weak var termsAndConditionView: UIView!
@IBOutlet weak var changePasswordView: UIView!
@IBOutlet weak var swipeMenuHeight: NSLayoutConstraint!
@IBOutlet weak var datePicker: UIDatePicker!
@IBOutlet weak var swipeMenu: UIView!
@IBOutlet weak var downView: UIView!
@IBOutlet weak var menuImg: UIImageView!
@IBOutlet weak var cv: UICollectionView!
@IBOutlet weak var arrowImg: UIImageView!
@IBOutlet weak var pluPageView: UIView!
@IBOutlet weak var bigImg: UIImageView!
@IBOutlet weak var adView: UIView!
@IBOutlet weak var redirectLoginView: UIViewX!
@IBOutlet weak var smallImg: UIImageView!
  
var LeaTypeRef : [GetLeaveDataDetails] = []
let dropDown = DropDown()
var piroty : String!
var stafId : String!
var collegeId : String!
var section : String!
var leaveTypeId : [String] = []
var nameString : String!
var addapiRef : [AddDataDeatils] = []
var MobileNumber : String!
var password : String!
var userID : String!
var PreviousAddId  : Int!
var colgImg : String!
var types : String!
let maxLenghth = 500
var fromDateString : String?
var toDateString : String?
var reasonss : String!
var headerId : String!
var leaveType : String!
var metronomePlay = AttendanceViewController()
let apiFormatter = DateFormatter()
    var activeDateField: String?   // "from" or "to"
    var fromDate: Date?
    var toDate: Date?

    let displayFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy"
        return df
    }()
    var NoOfDays : Int?
    
override func viewDidLoad() {
    super.viewDidLoad()
    lblCount?.text = ""
    overrideUserInterfaceStyle = .light
    
    sideMenuView.isHidden = true
    
    datePicker.isHidden = true
    calandViewss.isHidden = true
    reason.returnKeyType = .done
    reason.delegate = self
    
    fromDateView.isUserInteractionEnabled = true
    toDateView.isUserInteractionEnabled = true
    
    if types == "1"{
        fromDateLabel.text = "dd/mm/yyy"
        toDateLabel.text = "dd/mm/yyy"
        noOfdateLabel.text = "No of days"
        reason.text = "Enter the Reason"
        reason.textColor = UIColor.lightGray
    }else{
        
        let apiFormatter = DateFormatter()
        apiFormatter.dateFormat = "dd MMM yyyy"
        apiFormatter.locale = Locale(identifier: "en_US_POSIX")

        if let from = apiFormatter.date(from: fromDateString ?? "") {
            fromDate = from
            fromDateLabel.text = displayFormatter.string(from: from)
        }

        if let to = apiFormatter.date(from: toDateString ?? "") {
            toDate = to
            toDateLabel.text = displayFormatter.string(from: to)
        }

        calculateDays()
       
        reason.text = reasonss
        reason.textColor = UIColor.black
    }
    
    
    let defaults = UserDefaults.standard
    
    piroty = defaults.string(forKey: DefaultsKeys.priority)
    stafId = defaults.string(forKey: DefaultsKeys.memberid)
    
    collegeId = defaults.string(forKey: DefaultsKeys.collegeid)
    section = defaults.string(forKey: DefaultsKeys.sectionid)
    password = defaults.string(forKey: DefaultsKeys.Password)
    MobileNumber = defaults.string(forKey: DefaultsKeys.mobileNumber)
    userID =  defaults.string(forKey: DefaultsKeys.memberid)
    topMemberLabel.text =  defaults.string(forKey: DefaultsKeys.memberName)
    colgImg = defaults.string(forKey: DefaultsKeys.colglogo)
    clgLogoImg.sd_setImage(with: URL(string:  colgImg), placeholderImage: UIImage(named: "person.fill"))
    
    if piroty == "p1"{
        topLabels.text = "Principal"
    }else if piroty == "p4"{
        
        tapBarView.backgroundColor = UIColor(named: "StudentParent" )
        topLabels.text = "Student"
    }
    
    else if piroty == "p2" || piroty == "p3"{
        
        
        topLabels.text = "Teacher"
        
    }
    
    else if piroty == "p5"{
        tapBarView.backgroundColor = UIColor(named: "FatherColor" )
        
        topLabels.text = "Father"
    }
    addApi()
    LeavedropDrop()
    let leaveType = UITapGestureRecognizer(target: self, action: #selector(dropDownVc))
    
    leaveTypDropDownView.addGestureRecognizer(leaveType)
    
    
    let confirm = UITapGestureRecognizer(target: self, action: #selector(ConfirmVc))
    
    confirmView.addGestureRecognizer(confirm)
    
    
    let fromDate = UITapGestureRecognizer(target: self, action: #selector(FromdateVc))
    
    fromDateView.addGestureRecognizer(fromDate)
    
    
    let cancelVieww = UITapGestureRecognizer(target: self, action: #selector(CancelVc))
    
    cancelssView.addGestureRecognizer(cancelVieww)
    
    
    let ToDate = UITapGestureRecognizer(target: self, action: #selector(TodateVc))
    
    toDateView.addGestureRecognizer(ToDate)
    
    // tap Bar UiTapGuster.
    
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
    
    let loginRediectGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
    redirectLoginView.addGestureRecognizer(loginRediectGesture)
    
    
}


@objc func dismissKeyboards() {
    
    sideMenuView.isHidden = true
    view.endEditing(true)
    
}

@IBAction func CancelVc(){
    
    dismiss(animated: true)
    
}


@IBAction func ConfirmVc(){
    
    if dropDownLabel.text! == "Select type of Leave"{
        
        let refreshAlert = UIAlertController(title: "", message: "Please Select Leave type", preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            
            
        }))
        
        present(refreshAlert, animated: true, completion: nil)
        
    }
    else if fromDateLabel.text == "dd/mm/yyy"{
        
        let refreshAlert = UIAlertController(title: "", message: "From Date Field is Empty", preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            
        }))
        
        present(refreshAlert, animated: true, completion: nil)
        
    }
    
    else if toDateLabel.text == "dd/mm/yyy"{
        
        let refreshAlert = UIAlertController(title: "", message: "To Date Field is Empty", preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            
            
        }))
        
        present(refreshAlert, animated: true, completion: nil)
        
    }
    
    else if noOfdateLabel.text == "No of days"{
        
        let refreshAlert = UIAlertController(title: "", message: "No Of Date Field is Empty", preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            
        }))
        
        present(refreshAlert, animated: true, completion: nil)
        
    }
    
    else if reason.text == "Enter the Reason" {
        
        let refreshAlert = UIAlertController(title: "", message: "Please fill the Valid reason", preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            
            
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
    
    
    else if reason.text == "" {
        
        let refreshAlert = UIAlertController(title: "", message: "Please fill the Valid reason", preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
     
    else{
        
        manageLeaveResponce()
    }
}

func textViewDidBeginEditing(_ textView: UITextView) {
    if reason.text == "Enter the Reason" {
        reason.text = ""
        reason.textColor = UIColor.black
        
    }
}
    
func textViewDidEndEditing(_ textView: UITextView) {
    if reason.text == "" {
        reason.text = "Enter the Reason"
        reason.textColor = UIColor.lightGray
        
    }
}

func addApi(){
    
    
    var add = AddApiModal()
    
    let defaults = UserDefaults.standard
    var deviceToken = defaults.string(forKey:DefaultsKeys.DeviceToken )
    add.device_token = deviceToken
    print("EventDefaultsKeys.DeviceToken",deviceToken)
    add.member_id = userID
    add.mobile_no = MobileNumber
    add.priority = piroty
    add.college_id = collegeId
    add.previous_add_id = PreviousAddId
    
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


func textViewDidChange(_ textView: UITextView) {
    lblCount?.text = "\(maxLenghth - reason.text.count)/"+"\(500)"
    
}

func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    let newText = (reason.text as NSString).replacingCharacters(in: range, with: text)
    let numberOfChars = newText.count
    
    if text == "\n" {
        
        reason.resignFirstResponder()
    }
    return  numberOfChars < 500
    
}

@IBAction func adLoad(gesture : addvertisementPlus) {
    
    let vc = ShowExaminationAddViewController(nibName: nil, bundle: nil)
    vc.addString = gesture.url
    vc.modalPresentationStyle = .fullScreen
    present(vc, animated: true,completion: nil)
}

@IBAction func dropDownVc(){
    
    dropDown.show()
    
}

    @IBAction func FromdateVc() {
        activeDateField = "from"

        datePicker.datePickerMode = .date
        datePicker.minimumDate = nil

        datePicker.isHidden = false
        calandViewss.isHidden = false
        calanderTopHeight.constant = 328
    }


    @IBAction func TodateVc() {

        guard let start = fromDate else {
            let alert = UIAlertController(title: "", message: "Select from date first", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "OK", style: .default))

            present(alert, animated: true)
            return
        }

        activeDateField = "to"

        datePicker.datePickerMode = .date
        datePicker.minimumDate = start

        datePicker.isHidden = false
        calandViewss.isHidden = false
        calanderTopHeight.constant = 328
    }

    @IBAction func dte(_ sender: UIDatePicker) {

        if activeDateField == "from" {

            fromDate = sender.date
            fromDateLabel.text = displayFormatter.string(from: sender.date)

        } else {

            toDate = sender.date
            toDateLabel.text = displayFormatter.string(from: sender.date)
        }

        calculateDays()
    }
    
    func calculateDays() {

        guard let start = fromDate,
              let end = toDate else { return }

        if end < start {
            noOfdateLabel.text = "Invalid Date"
            return
        }

        let days = Calendar.current.dateComponents([.day], from: start, to: end).day ?? 0

        noOfdateLabel.text = "\(days + 1) days"
        NoOfDays = days
    }



@IBAction func BackBtn(_ sender: Any) {
    
    dismiss(animated: true)
    
}

func LeavedropDrop(){
    
    var leaveTypes = GetLeaveTypeModal()
    
    leaveTypes.appid = "1"
    leaveTypes.userid = stafId
    
    APiCallManager.shared.callApi(
        url: APIEndpoints.GetLeaveType,
        httpMethod: .post,
        queryParam: nil,
        requestBody: leaveTypes
    ){ [weak self] (result:Result<GetLeaveTypeResponce, Error>) in
        
        guard let self = self else { return }
        
        switch result {
        case .success(let success):
            
            LeaTypeRef = success.data ?? []

            var myArray: [String] = []
            leaveTypeId.removeAll()

            LeaTypeRef.forEach { arrType in
                myArray.append(arrType.leavetypename ?? "")
                self.leaveTypeId.append(arrType.leavetypeid ?? "")
            }

            dropDownLabel.text = "Select type of Leave"
            dropDown.anchorView = leaveTypDropDownView
            dropDown.dataSource = myArray

            dropDown.bottomOffset = CGPoint(x: 0, y: (dropDown.anchorView?.plainView.bounds.height)!)
            dropDown.direction = .bottom
            DropDown.appearance().backgroundColor = UIColor.white

            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                
                print("Selected item: \(item) at index: \(index)")
                
                self.dropDownLabel.text = item
                
                // Correct way to get ID
                self.nameString = String(self.leaveTypeId[index])
                
                print("Selected Leave ID:", self.nameString ?? "")
            }
            
        case .failure(let failure):
            print("Error:", failure.localizedDescription)
        }
    }
}

    func manageLeaveResponce(){
        
        var mangeLeave = manageLeaveModal()
        
        mangeLeave.leavetypeid = nameString
        mangeLeave.clgsectionid = section
        mangeLeave.colgid = collegeId
        mangeLeave.leavefromdate = fromDateLabel.text
        mangeLeave.leavereason = reason.text
        mangeLeave.leavetodate = toDateLabel.text
        mangeLeave.memberid = stafId
        mangeLeave.numofdays = String(NoOfDays ?? 0)
        
        if types == "1" {
            mangeLeave.processtype = "add"
            mangeLeave.applicationid = "0"
        }else {
            mangeLeave.processtype = "edit"
            mangeLeave.applicationid = headerId
        }
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.ManageLeaveapplication,
            httpMethod: .post,
            queryParam: nil,
            requestBody: mangeLeave
        ) {[weak self] (result:Result<manageLeaveResponce, Error>) in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let success):
                
               
                    let refreshAlert = UIAlertController(title: "", message: success.Message, preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        
                        self.dismiss(animated: true)
                    }))
                    present(refreshAlert, animated: true, completion: nil)
                
            case .failure(let failure):
                let refreshAlert = UIAlertController(title: "", message: failure.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    
                    self.dismiss(animated: true)
                }))
                present(refreshAlert, animated: true, completion: nil)
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
        let vc = PriorityViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
    }

@IBAction func done(_ sender: Any) {
    
    calandViewss.isHidden = true
    calanderTopHeight.constant = 0
}
}
class addvertisementPlus : UITapGestureRecognizer{

var url : String!
}
