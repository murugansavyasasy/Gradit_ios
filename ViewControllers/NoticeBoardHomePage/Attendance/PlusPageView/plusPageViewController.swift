//
//  plusPageViewController.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 20/03/23.
//

import UIKit
import FSCalendar
import DropDown
import ObjectMapper
import KRProgressHUD

@available(iOS 16.0, *)
class plusPageViewController: UIViewController,FSCalendarDelegate,UITextViewDelegate {


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
var loginDatas : [datalogin]!
var logindataprinci :[datalogin]!

var display_date : String!

var url_date : String!

var isSettingFromDate = false

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

var fromdates : Date!

var datecountAryy  : [String] = []

var types : String!
let maxLenghth = 500
var fromDate : String!
var todate : String!
var reasonss : String!
var headerId : String!
var noofday : String!
var leaveType : String!

var FromdateId : String!
var toDateId : String!
var NumberOfToDateCount : Date!

var metronomePlay = AttendanceViewController()
override func viewDidLoad() {
    super.viewDidLoad()
    
    overrideUserInterfaceStyle = .light
    
    
    sideMenuView.isHidden = true
    
    
    datePicker.isHidden = true
    calandViewss.isHidden = true
    reason.returnKeyType = .done
    reason.delegate = self
    
    print("reasonssreasonss",reasonss)
    if types == "1"{
        
        fromDateView.isUserInteractionEnabled = true
        toDateView.isUserInteractionEnabled = true
        fromDateLabel.text = "dd/mm/yyy"
        toDateLabel.text = "dd/mm/yyy"
        noOfdateLabel.text = "No of days"
        reason.text = "Enter the Reason"
        reason.textColor = UIColor.lightGray
        
        
    }
    
    else{
        
        fromDateView.isUserInteractionEnabled = false
        toDateView.isUserInteractionEnabled = false 
        
        let dateFormatterGet = DateFormatter()
        
        dateFormatterGet.dateFormat =  "dd MMM yyyy"
        
        
        
        
        let dateFormatterPrint = DateFormatter()
        
        dateFormatterPrint.dateFormat = "dd-MM-yyy"
        
        
        
        let date: NSDate? = dateFormatterGet.date(from: fromDate ) as NSDate?
        
        
        let toDate : NSDate? = dateFormatterGet.date(from: todate ) as NSDate?
        
        
        fromDateLabel.text = dateFormatterPrint.string(from: date as! Date)
        
        
        
        toDateLabel.text = dateFormatterPrint.string(from: toDate as! Date)
        noOfdateLabel.text = noofday
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
        
    }
    
    else if piroty == "p4"{
        
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
    
    
    let add = AddApiModal()
    
    let defaults = UserDefaults.standard
    var deviceToken = defaults.string(forKey:DefaultsKeys.DeviceToken )
    add.device_token = deviceToken
    print("EventDefaultsKeys.DeviceToken",deviceToken)
    add.member_id = userID
    add.mobile_no = MobileNumber
    add.priority = piroty
    add.college_id = collegeId
    add.previous_add_id = PreviousAddId
    
    
    let addstr = add.toJSONString()
    
    
    addRequest.call_request(param: addstr!){ [self]
        
        (res) in
        
        
        
        let addApis : AddApiResponce = Mapper<AddApiResponce>().map(JSONString: res)!
        if addApis.Status == 1 {
            addapiRef = addApis.data
            
            
            for i in addApis.data{
                
                
                //
                
                bigImg.sd_setImage(with: URL(string: i.background_image), placeholderImage: UIImage(named: "ic_white"))
                
                
                smallImg.sd_setImage(with: URL(string: i.add_image), placeholderImage: UIImage(named: "ic_white"))
                
                let singleTap = addvertisementPlus(target: self, action: #selector(adLoad))
                singleTap.url = i.add_url
                bigImg.isUserInteractionEnabled = true
                bigImg.addGestureRecognizer(singleTap)
                
                
            }
            
            
            
        }
        
        else{
            
            
        }
        
        
        
        
    }
    
    
}


func textViewDidChange(_ textView: UITextView) {
    lblCount.text = "\(maxLenghth - reason.text.count)/"+"\(500)"
    
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
    print("adssdedd",gesture.url)
    vc.modalPresentationStyle = .fullScreen
    
    present(vc, animated: true,completion: nil)
    
}

@IBAction func dropDownVc(){
    
    dropDown.show()
    
}

@IBAction func FromdateVc(){
    toDateLabel.text = "dd/mm/yyy"
    FromDate_Action()
    
    
}


@IBAction func TodateVc(){
    
    
    if fromDateLabel.text == "dd/mm/yyy"{
        
        
        let refreshAlert = UIAlertController(title: "", message: "Select from date", preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            
            
        }))
        
        
        
        
        present(refreshAlert, animated: true, completion: nil)
        
        
    }else{
        datePicker.isHidden = false
        calandViewss.isHidden = false
        calanderTopHeight.constant = 500
        ToDate_Action()
    }
    
    
}



func FromDate_Action(){
    
    FromdateId = "0"
    
    RPicker.selectDate(title: "Select Date", cancelText: "Cancel", datePickerMode: .date, style: .Inline, didSelectDate: {[weak self] (today_date) in
        
        
        
        self?.display_date = today_date.dateString("dd/MM/yyyy")
        
        self?.url_date = today_date.dateString("yyyy/MM/dd")
        
        self?.fromDateLabel.text = self!.display_date
        
        
        
        self!.fromdates =  today_date
        
        
    })
    
}



func ToDate_Action(){
    
    
    toDateId = "1"
    
    
    
    
    
    
    
    
    let dateFormater: DateFormatter = DateFormatter()
    
    dateFormater.dateFormat = "dd/M/yyyy"
    
    let currentDate = fromDateLabel.text
    
    let date = dateFormater.date(from:currentDate!)!
    
    var dt : Date!
    
    dt = date
    
    
    
    
    
    datePicker.minimumDate = dt
    
    
    
    
    let selectedDate = dateFormater.string(from: datePicker.date)
    
    print("selectedDate",selectedDate)
    
    
    
}


func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
    return true
}

// FSCalendarDelegate method to handle the selection of a date range
func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
    let selectedDates = calendar.selectedDates
    if selectedDates.count == 1 {
        print("Selected date: \(selectedDates[0])")
    } else if selectedDates.count == 2 {
        let fromDate = selectedDates[0]
        let toDate = selectedDates[1]
        print("From date: \(fromDate), To date: \(toDate)")
    }
}





@IBAction func dte(_ sender: UIDatePicker) {
    print("print \(sender.date)")
    
    
    
    NumberOfToDateCount = sender.date
    
    
    
    let dateFormatter = DateFormatter()
    
    dateFormatter.dateFormat = "dd/M/yyyy"
    
    let somedateString = dateFormatter.string(from: sender.date)
    
    
    
    
    
    toDateLabel.text = somedateString
    
    print(somedateString)
    
    
}




@IBAction func BackBtn(_ sender: Any) {
    
    dismiss(animated: true)
    
}

func LeavedropDrop(){
    
    let leaveTypes = GetLeaveTypeModal()
    
    leaveTypes.appid = "1"
    leaveTypes.userid = stafId
    
    let leaveTypesStr = leaveTypes.toJSONString()
    
    leaveTypeRequest.call_request(param: leaveTypesStr!){ [self]
        (res) in
        
        let leaveTypesResp : GetLeaveTypeResponce =
        Mapper<GetLeaveTypeResponce>().map(JSONString: res)!
        
        LeaTypeRef = leaveTypesResp.data
        
        var myArray: [String] = [ ]
        
        LeaTypeRef.forEach {(arrType)  in
            myArray.append((arrType.leavetypename))
            leaveTypeId.append(arrType.leavetypeid)
            
            
            dropDownLabel.text = "Select type of Leave"
            dropDown.anchorView = leaveTypDropDownView
            dropDown.dataSource = myArray
            
            dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
            dropDown.direction = .bottom
            DropDown.appearance().backgroundColor = UIColor.white
            
            
            
            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                print("Selected item: \(item) at index: \(index)")
                print("myArray",myArray)
                
                if item == "CasualLeave"{
                    
                    nameString = "1"
                    
                    
                }
                else if item == "SickLeave"{
                    
                    nameString = "2"
                    
                    
                }
                else if item == "Onduty"{
                    
                    nameString = "3"
                    
                    
                }
                
                self.dropDownLabel.text = item
                
                
                
            }
        }
        
    }
}




func manageLeaveResponce(){
    
    if types == "1"{
        let srtingconvrt = String(datecountAryy.count)
        
        let mangeLeave = manageLeaveModal()
        
        mangeLeave.leavetypeid = nameString
        
        print("nasdfghjkl",nameString)
        
        
        
        mangeLeave.applicationid = "0"
        mangeLeave.clgsectionid = section
        mangeLeave.colgid = collegeId
        mangeLeave.leavefromdate = fromDateLabel.text
        mangeLeave.leavereason = reason.text
        mangeLeave.leavetodate = toDateLabel.text
        mangeLeave.memberid = stafId
        mangeLeave.numofdays = srtingconvrt
        mangeLeave.processtype = "add"
        
        
        let mangeLeaveStr = mangeLeave.toJSONString()
        
        
        
        print("yearAndSectionModalStr",mangeLeaveStr)
        
        ManageLeaveRequest.call_request(param: mangeLeaveStr!) {
            
            [self]  (res) in
            
            
            
            
            
            let particular : [manageLeaveResponce] = Mapper<manageLeaveResponce>().mapArray(JSONString: res)!
            
            
            for i in particular{
                
                if i.Status == 1 {
                    
                    
                    
                    
                    let refreshAlert = UIAlertController(title: "", message: i.Message, preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        
                        dismiss(animated: true)
                    }))
                    
                    
                    
                    
                    present(refreshAlert, animated: true, completion: nil)
                    
                    
                    
                    
                }else{
                    
                    let refreshAlert = UIAlertController(title: "", message: i.Message, preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        
                        
                    }))
                    
                    
                    
                    
                    present(refreshAlert, animated: true, completion: nil)
                    
                    
                    
                    
                }
                
                
                
            }
            
            
            
            
            
            
        }
        
    }
    
    
    
    else{
        
        
        
        let srtingconvrt = String(datecountAryy.count)
        
        let mangeLeave = manageLeaveModal()
        
        mangeLeave.leavetypeid = nameString
        
        print("nasdfghjkl",nameString)
        
        
        
        mangeLeave.applicationid = headerId
        mangeLeave.clgsectionid = section
        mangeLeave.colgid = collegeId
        
        
        mangeLeave.leavefromdate = fromDateLabel.text
        mangeLeave.leavereason = reason.text
        mangeLeave.leavetodate = toDateLabel.text
        mangeLeave.memberid = stafId
        if FromdateId == "0" && toDateId == "1"{
            mangeLeave.numofdays = srtingconvrt
        }
        else if toDateId == "1" || FromdateId == "0"{
            
            mangeLeave.numofdays = srtingconvrt
            
        }
        
        else{
            
            mangeLeave.numofdays = noofday
        }
        mangeLeave.processtype = "edit"
        
        
        let mangeLeaveStr = mangeLeave.toJSONString()
        
        
        
        print("yearAndSectionModalStr",mangeLeaveStr)
        
        ManageLeaveRequest.call_request(param: mangeLeaveStr!) {
            
            [self]  (res) in
            
            
            
            
            
            let particular : [manageLeaveResponce] = Mapper<manageLeaveResponce>().mapArray(JSONString: res)!
            
            
            for i in particular{
                
                if i.Status == 1 {
                    
                    
                    
                    
                    let refreshAlert = UIAlertController(title: "", message: i.Message, preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        
                        
                        dismiss(animated: true)
                    }))
                    
                    
                    
                    
                    present(refreshAlert, animated: true, completion: nil)
                    
                    
                    
                    
                }else{
                    
                    
                    
                    
                    let refreshAlert = UIAlertController(title: "", message: i.Message, preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        
                        
                    }))
                    
                    
                    
                    
                    present(refreshAlert, animated: true, completion: nil)
                    
                }
                
                
                
            }
            
            
            
            
            
            
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
                
                
            }
            vc.modalPresentationStyle = .fullScreen
            
            present(vc, animated: true,completion: nil)
            
            
            
        }
    }
    
    
    
    
    
    
}








@IBAction func done(_ sender: Any) {
    
    
    
    calandViewss.isHidden = true
    
    calanderTopHeight.constant = 0
    
    
    
    datecountAryy.removeAll()
    
    
    let dateFormater: DateFormatter = DateFormatter()
    
    dateFormater.dateFormat = "dd/M/yyyy"
    
    var date = dateFormater.date(from: fromDateLabel.text!)
    
    
    
  
    
    let endDate = NumberOfToDateCount
    
    
    
    let fmt = DateFormatter()
    
    fmt.dateFormat = "dd/MM/yyyy"
    
    
    if endDate != nil{
        while date! <= endDate! {
            
            print(fmt.string(from: date!))
            
            self.datecountAryy.append(fmt.string(from: date!))
            
            
            
            print("datecountAryy",self.datecountAryy.count)
            
            date = Calendar.current.date(byAdding: .day, value: 1, to: date!)!
            
        }
    }
    
    
    
    
    let stringconvert =  String(self.datecountAryy.count)
    
    
    
    self.noOfdateLabel.text = stringconvert + "  days"
    
    
    
}





}
class addvertisementPlus : UITapGestureRecognizer{

var url : String!




}
