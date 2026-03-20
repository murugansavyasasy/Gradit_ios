//
//  PlusNewTextViewControllerViewController.swift
//  GraditSenderEventMenu
//
//  Created by MACBOOKPRO on 03/12/22.
//

import UIKit
import KRProgressHUD
import ObjectMapper

@available(iOS 16.0, *)
@available(iOS 16.0, *)
@available(iOS 16.0, *)
@available(iOS 16.0, *)
class PlusNewTextViewControllerViewController: UIViewController,UITextViewDelegate,UITextFieldDelegate {
    
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var tapBarView: UIViewX!
    @IBOutlet weak var redirectLoginView: UIViewX!
    
    @IBOutlet weak var selectRepicDeafultId: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var selectRespView: UIViewX!
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var calanderView: UIViewX!
    @IBOutlet weak var DateLabel: UILabel!
    
    @IBOutlet weak var venuTextField: UITextField!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var smallImg: UIImageView!
    @IBOutlet weak var bigImg: UIImageView!
    
    @IBOutlet weak var topMessageLabel: UILabel!
    @IBOutlet weak var clgLogoImg: UIImageView!
    
    
    @IBOutlet weak var cancelView: UIViewX!
    @IBOutlet weak var logoutView: UIView!
    
    @IBOutlet weak var changeRolesView: UIView!
    
    
    @IBOutlet weak var profileView: UIView!
    
    
    
    @IBOutlet weak var changePasswordView: UIView!
    
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var termsAndConditionView: UIView!
    
    @IBOutlet weak var helpView: UIView!
    
    
    @IBOutlet weak var topLabels: UILabel!
    
    @IBOutlet weak var viewTap: UIView!
    
    
    
    @IBOutlet weak var faqView: UIView!
    
    
    @IBOutlet weak var privacyPolicyView: UIView!
    
    
    @IBOutlet weak var refreshView: UIView!
    
    
    
    @IBOutlet weak var sideMenuView: UIView!
    
    
    
    @IBOutlet weak var setTimeView: UIViewX!
    
    
    @IBOutlet weak var descripitionTextField: UITextView!
    
    let maxLenghth = 500
    var time : String!
    
    var url_time: String!
    
    var menuId : String!
    var display_date : String!
    
    var url_date : String!
    
    var backGroundImageUrl : String!
    var smallImageUrl : String!
    var addWebUrl : String!
    var toolBar = UIToolbar()
    var datePicker  = UIDatePicker()
    var priority : String!
    
    var loginDatas : [datalogin]!
    var logindataprinci :[datalogin]!
    
    var password : String!
    
    var memberName : String!
    
    var colgImg : String!
    
    var  mobileNumber : String!
    
    var interval: TimeInterval = 60.0
    
    var editVenu : String!
    var editdate : String!
    var editTitle : String!
    var editDiscreption : String!
    
    var str : [String] = []
    
    var strName : [String] = []
    var eventHeaderId : String!
    
    
    var EditId : String!
    
    var colgId :  String!
    var UserId : String!
    
    var dateStr : String!
    var TimeStr : String!
    var is_read_enabled = ""
    var is_write_enabled = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if menuId == "13"{
            
            selectRepicDeafultId.text = "Send"
            titleTextField.text = editTitle
            venuTextField.text  = editVenu
            descripitionTextField.text = editDiscreption
            
            let firsts = dateStr
            let dateFormatterGet = DateFormatter()
            
            dateFormatterGet.dateFormat =  "dd MMM,yyyy"
            
            
            
            let dateFormatterPrint = DateFormatter()
            
            dateFormatterPrint.dateFormat = "dd-MM-yyyy"
            
            
            
            let dates: NSDate? = dateFormatterGet.date(from: firsts!) as NSDate?
            
            
            
            
            DateLabel.text = dateFormatterPrint.string(from: dates as! Date)
            timeLabel.text = TimeStr
            
            
        }
        
        
        
        else{
            
            selectRepicDeafultId.text = " Select Recipients"
            DateLabel.text = "-SelectDate-"
            timeLabel.text = "-Select Time-"
            
            
        }
        
        overrideUserInterfaceStyle = .light
        
        
        
        sideMenuView.isHidden = true
        
        
        let defaults = UserDefaults.standard
        memberName = defaults.string(forKey: DefaultsKeys.memberName)
        priority = defaults.string(forKey: DefaultsKeys.priority)
        colgImg = defaults.string(forKey: DefaultsKeys.colglogo)
        clgLogoImg.sd_setImage(with: URL(string:  colgImg), placeholderImage: UIImage(named: "person.fill"))
        
        
        mobileNumber  = defaults.string(forKey: DefaultsKeys.mobileNumber)
        
        password  = defaults.string(forKey: DefaultsKeys.Password)
        
        colgId = defaults.string(forKey: DefaultsKeys.collegeid)
        
        UserId = defaults.string(forKey: DefaultsKeys.memberid)
        
        
        topMessageLabel.text = memberName
        
        bigImg.sd_setImage(with: URL(string: backGroundImageUrl), placeholderImage: UIImage(named: "ic_white"))
        
        
        smallImg.sd_setImage(with: URL(string: smallImageUrl), placeholderImage: UIImage(named: "ic_white"))
        
        
        
        
        
        
        
        
        
        if priority == "p1"{
            tapBarView.backgroundColor = UIColor(named: "Principal" )
            topLabels.text = "Principal"
            
        }
        
        else if priority == "p4"{
            
            topLabels.text = "Student"
            
        }
        
        else if priority == "p2" {
            tapBarView.backgroundColor = UIColor(named: "Teaching Staff" )
            
            topLabels.text = "HOD"
            
        }
        
        else if priority == "p5"{
            
            
            topLabels.text = "Father"
            
            
            
        }
        
        else if priority == "p3"{
            
            tapBarView.backgroundColor = UIColor(named: "Teaching Staff" )
            topLabels.text = "Teacher"
            
        }
        
        else if priority == "p7"{
            
            tapBarView.backgroundColor = UIColor(named: "univercityColorCod" )
            topLabels.text = "University Head"
            
        }
        
        
        
        descripitionTextField.returnKeyType = .done
        descripitionTextField.delegate = self
        titleTextField.returnKeyType = .done
        titleTextField.delegate = self
        
        venuTextField.returnKeyType = .done
        venuTextField.delegate = self
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(adLoad))
        
        bigImg.isUserInteractionEnabled = true
        bigImg.addGestureRecognizer(singleTap)
        
        
        let cancel = UITapGestureRecognizer(target: self, action: #selector(cancelVc))
        cancelView.addGestureRecognizer(cancel)
        
        
        
        // tap Bar UiTapGuster.
        
        
        
        let timess = UITapGestureRecognizer(target: self, action: #selector(SetTimeVc))
        setTimeView.addGestureRecognizer(timess)
        
        
        let changeRolesGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        changeRolesView.addGestureRecognizer(changeRolesGesture)
        
        
        let logoutGesture = UITapGestureRecognizer(target: self, action: #selector(logoutPressed))
        logoutView.addGestureRecognizer(logoutGesture)
        let loginRediectGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        redirectLoginView.addGestureRecognizer(loginRediectGesture)
        
        
        
        
        let selectResp = UITapGestureRecognizer(target: self, action: #selector(SelectVc))
        selectRespView.addGestureRecognizer(selectResp)
        
        
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
    
    
    
    func textViewDidChange(_ textView: UITextView) {
        lblCount.text = "\(maxLenghth - descripitionTextField.text.count)/"+"\(500)"
        
        
        
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (descripitionTextField.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        if text == "\n" {
            descripitionTextField.resignFirstResponder()
        }
        return numberOfChars < 500
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
        venuTextField.resignFirstResponder()
        return true
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        
        
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height-91
                print("keyboardSize.height",keyboardSize.height)
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    
    @IBAction func SetTimeVc(){
        
        timeSS()
        
        
    }
    
    
    
    func timeSS(){
        
        RPicker.selectDate(title: "Select time", cancelText: "Cancel", datePickerMode: .time, style: .Wheel, didSelectDate: {[weak self] (today_date) in
            
            
            self?.display_date = today_date.dateString("hh:mm:a")
            self?.url_time = today_date.dateString("a:mm:hh")
            
            self?.timeLabel.text = self!.display_date
            
            
        })
        
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int,          inComponent component: Int) {
        //        myLabel.text = pickerData[row]
        interval = Double(row+1) * 60.0
    }
    
    
    func FromDate_Action(){
        
        
        
        RPicker.selectDate(title: "Select Date", cancelText: "Cancel", datePickerMode: .date, style: .Inline, didSelectDate: {[weak self] (today_date) in
            
            
            
            self?.display_date = today_date.dateString("dd/MM/yyyy")
            
            self?.url_date = today_date.dateString("yyyy/MM/dd")
            
            self?.DateLabel.text = self!.display_date
            
            
            
        })
        
    }
    
    
    
    
    @IBAction func cancelVc(){
        
        
        dismiss(animated: true)
        
    }
    
    
    @IBAction func SelectVc(){
        
        
        
        
        if menuId == "13"{
            
            
            
            
            if (descripitionTextField.text!.isEmpty) && (titleTextField.text!.isEmpty) {
                
                
                
                print("heloo",descripitionTextField.text.count)
                
                
                
                
                let refreshAlert = UIAlertController(title: "", message: "Kindly Enter Details ", preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    
                    
                    
                    
                    
                }))
                
                
                
                present(refreshAlert, animated: true, completion: nil)
            }
            
            
            else if  DateLabel.text ==  "-SelectDate-" {
                
                
                
                
                let refreshAlert = UIAlertController(title: "", message: "  Please Select Date ", preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    
                    
                    
                    
                    
                }))
                
                
                
                present(refreshAlert, animated: true, completion: nil)
                
            }
            
            
            
            
            else if  timeLabel.text == "-Select Time-" {
                
                
                
                
                let refreshAlert = UIAlertController(title: "", message: "  Please Select Time ", preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    
                    
                    
                    
                    
                }))
                
                
                
                present(refreshAlert, animated: true, completion: nil)
                
                
                
            }
            
            
            else if venuTextField.text == ""{
                
                
                let refreshAlert = UIAlertController(title: "", message: "  Kindly Enter Venue Details ", preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    
                    
                    
                    
                    
                }))
                
                
                
                present(refreshAlert, animated: true, completion: nil)
                
                
                
                
                
            }
            
            
            
            else{
                
                
                let refreshAlert = UIAlertController(title: "", message: "Are You Sure Want To Submit?", preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in
                    
                    var particular = EventParticualrModal()

                    particular.eventid = eventHeaderId
                    particular.eventbody = descripitionTextField.text
                    particular.eventdate = DateLabel.text
                    particular.eventvenue = venuTextField.text
                    particular.eventtime = timeLabel.text
                    particular.eventtopic = titleTextField.text

                    particular.processtype = "edit"
                    particular.collegeid = colgId
                    particular.staffid = UserId
                    particular.Callertype = priority
                    particular.receivertype = ""

                    particular.isparent = false
                    particular.isstaff = false
                    particular.isstudent = false
                    particular.receiveridlist = ""

                    print("yearAndSectionModalStr", particular)

                    APiCallManager.shared.callApi(
                        url: APIEndpoints.ManageEvents,
                        httpMethod: .post,
                        queryParam: nil,
                        requestBody: particular
                    ) { [weak self] (result: Result<[EventParticularResponce], Error>) in
                        
                        guard let self = self else { return }
                        
                        switch result {
                            
                        case .success(let response):
                            
                            for i in response {
                                
                                if i.Status == 1 {
                                    
                                    let refreshAlert = UIAlertController(
                                        title: "",
                                        message: i.Message,
                                        preferredStyle: .alert
                                    )
                                    
                                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                                        
                                        if self.priority == "p2" || self.priority == "p3" {
                                            
                                            let vc = SenderEventHomePageViewController()
                                            vc.is_read_enabled = self.is_read_enabled
                                            vc.is_write_enabled = self.is_write_enabled
                                            vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                                            vc.eventSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                                            vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                                            vc.str = self.str
                                            vc.strName = self.strName
                                            vc.modalPresentationStyle = .fullScreen
                                            self.present(vc, animated: true)
                                            
                                        } else {
                                            
                                            let vc = SenderEventHomePageViewController()
                                            vc.is_read_enabled = self.is_read_enabled
                                            vc.is_write_enabled = self.is_write_enabled
                                            vc.view.backgroundColor = UIColor(named: "Principal")
                                            vc.eventSegmentName.backgroundColor = UIColor(named: "UnSelector")
                                            vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "Selector")
                                            vc.str = self.str
                                            vc.strName = self.strName
                                            vc.modalPresentationStyle = .fullScreen
                                            self.present(vc, animated: true)
                                        }
                                    })
                                    
                                    self.present(refreshAlert, animated: true)
                                    
                                } else {
                                    
                                    let refreshAlert = UIAlertController(
                                        title: "",
                                        message: i.Message,
                                        preferredStyle: .alert
                                    )
                                    
                                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                                        
                                        if self.priority == "p2" || self.priority == "p3" {
                                            
                                            let vc = SenderEventHomePageViewController()
                                            vc.is_read_enabled = self.is_read_enabled
                                            vc.is_write_enabled = self.is_write_enabled
                                            vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                                            vc.eventSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                                            vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                                            vc.str = self.str
                                            vc.strName = self.strName
                                            vc.modalPresentationStyle = .fullScreen
                                            self.present(vc, animated: true)
                                        }
                                        
                                        if self.priority == "p7" {
                                            
                                            let vc = SenderEventHomePageViewController()
                                            vc.is_read_enabled = self.is_read_enabled
                                            vc.is_write_enabled = self.is_write_enabled
                                            vc.view.backgroundColor = UIColor(named: "univercityColorCod")
                                            vc.eventSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                                            vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                                            vc.str = self.str
                                            vc.strName = self.strName
                                            vc.modalPresentationStyle = .fullScreen
                                            self.present(vc, animated: true)
                                            
                                        } else {
                                            
                                            let vc = SenderEventHomePageViewController()
                                            vc.is_read_enabled = self.is_read_enabled
                                            vc.is_write_enabled = self.is_write_enabled
                                            vc.view.backgroundColor = UIColor(named: "Principal")
                                            vc.eventSegmentName.backgroundColor = UIColor(named: "UnSelector")
                                            vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "Selector")
                                            vc.str = self.str
                                            vc.strName = self.strName
                                            vc.modalPresentationStyle = .fullScreen
                                            self.present(vc, animated: true)
                                        }
                                    })
                                    
                                    self.present(refreshAlert, animated: true)
                                }
                            }
                            
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                    
                }))
                
                
                
                present(refreshAlert, animated: true, completion: nil)
                
                
                refreshAlert.addAction(UIAlertAction(title: "CANCEL", style: .default, handler: { (action: UIAlertAction!) in
                    
                    
                }))
                
                
                
                
                
            }
            
        }
        
        
        
        
        else{
            
            
            
            if priority == "p1"{
                
                if (descripitionTextField.text!.isEmpty) && (titleTextField.text!.isEmpty) {
                    
                    
                    
                    print("heloo",descripitionTextField.text.count)
                    
                    
                    
                    
                    let refreshAlert = UIAlertController(title: "", message: "Kindly Enter Details ", preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        
                        
                        
                        
                        
                    }))
                    
                    
                    
                    present(refreshAlert, animated: true, completion: nil)
                }
                
                
                else if  DateLabel.text ==  "-SelectDate-" {
                    
                    
                    
                    
                    let refreshAlert = UIAlertController(title: "", message: "  Please Select Date ", preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        
                        
                        
                        
                        
                    }))
                    
                    
                    
                    present(refreshAlert, animated: true, completion: nil)
                    
                }
                
                
                
                
                else if  timeLabel.text == "-Select Time-" {
                    
                    
                    
                    
                    let refreshAlert = UIAlertController(title: "", message: "  Please Select Time ", preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        
                        
                        
                        
                        
                    }))
                    
                    
                    
                    present(refreshAlert, animated: true, completion: nil)
                    
                    
                    
                }
                
                
                else if venuTextField.text == ""{
                    
                    
                    let refreshAlert = UIAlertController(title: "", message: "  Kindly Enter Venue Details ", preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        
                        
                        
                        
                        
                    }))
                    
                    
                    
                    present(refreshAlert, animated: true, completion: nil)
                    
                    
                    
                    
                    
                }
                
                
                else{
                    
                    let vc = SelectResipientsViewController(nibName: nil, bundle: nil)
                    
                    vc.resivre = menuId
                    vc.VenuTestField = venuTextField.text
                    vc.DateLabels = DateLabel.text
                    vc.titlesTextField = titleTextField.text
                    vc.discreptionss = descripitionTextField.text
                    vc.EventTime = timeLabel.text
                    vc.strName = strName
                    vc.str = str
                    vc.is_read_enabled = is_read_enabled
                    vc.is_write_enabled = is_write_enabled
                    vc.modalPresentationStyle = .fullScreen
                    present(vc, animated: true,completion: nil)
                    
                }
                
            }
            
            
            else if priority == "p3"{
                
                if (descripitionTextField.text!.isEmpty) && (titleTextField.text!.isEmpty) {
                    
                    
                    
                    print("heloo",descripitionTextField.text.count)
                    
                    let refreshAlert = UIAlertController(title: "", message: "Kindly Enter Details ", preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        
                        
                        
                        
                        
                    }))
                    
                    
                    
                    present(refreshAlert, animated: true, completion: nil)
                    
                }
                
                
                
                else if  DateLabel.text ==  "-SelectDate-" {
                    
                    
                    
                    
                    let refreshAlert = UIAlertController(title: "", message: "  Please Select Date ", preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        
                        
                        
                        
                        
                    }))
                    
                    
                    
                    present(refreshAlert, animated: true, completion: nil)
                    
                }
                
                
                
                
                else if  timeLabel.text == "-Select Time-" {
                    
                    
                    
                    
                    let refreshAlert = UIAlertController(title: "", message: "  Please Select Time ", preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        
                        
                        
                        
                        
                    }))
                    
                    
                    
                    present(refreshAlert, animated: true, completion: nil)
                    
                    
                    
                }
                
                
                else if venuTextField.text == ""{
                    
                    
                    let refreshAlert = UIAlertController(title: "", message: "  Kindly Enter Venue Details ", preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        
                        
                        
                        
                        
                    }))
                    
                    
                    
                    present(refreshAlert, animated: true, completion: nil)
                    
                    
                    
                    
                    
                }
                
                
                else{
                    
                    let vc = HodRespienViewController(nibName: nil, bundle: nil)
                    vc.venumtextField = venuTextField.text
                    vc.titlesTextField = titleTextField.text
                    vc.discreptionss = descripitionTextField.text
                    vc.DateLabels = DateLabel.text
                    vc.resivre = menuId
                    vc.EventTime = timeLabel.text
                    vc.strName = strName
                    vc.str = str
                    vc.is_read_enabled = is_read_enabled
                    vc.is_write_enabled = is_write_enabled
                    vc.modalPresentationStyle = .fullScreen
                    present(vc, animated: true,completion: nil)
                    
                }
                
                
                
            }
            
            
            else if priority == "p7"{
                
                if (descripitionTextField.text!.isEmpty) && (titleTextField.text!.isEmpty) {
                    
                    
                    
                    print("heloo",descripitionTextField.text.count)
                    
                    let refreshAlert = UIAlertController(title: "", message: "Kindly Enter Details ", preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        
                        
                        
                        
                        
                    }))
                    
                    
                    
                    present(refreshAlert, animated: true, completion: nil)
                    
                }
                
                
                
                else if  DateLabel.text ==  "-SelectDate-" {
                    
                    
                    
                    
                    let refreshAlert = UIAlertController(title: "", message: "  Please Select Date ", preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        
                        
                        
                        
                        
                    }))
                    
                    
                    
                    present(refreshAlert, animated: true, completion: nil)
                    
                }
                
                
                
                
                else if  timeLabel.text == "-Select Time-" {
                    
                    
                    
                    
                    let refreshAlert = UIAlertController(title: "", message: "  Please Select Time ", preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        
                        
                        
                        
                        
                    }))
                    
                    
                    
                    present(refreshAlert, animated: true, completion: nil)
                    
                    
                    
                }
                
                
                else if venuTextField.text == ""{
                    
                    
                    let refreshAlert = UIAlertController(title: "", message: "  Kindly Enter Venue Details ", preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        
                        
                        
                        
                        
                    }))
                    
                    
                    
                    present(refreshAlert, animated: true, completion: nil)
                    
                    
                    
                    
                    
                }
                
                
                else{
                    
                    let vc = GroupHeadViewController(nibName: nil, bundle: nil)
                    vc.venumtextField = venuTextField.text
                    vc.titlesTextField = titleTextField.text
                    vc.discreptionss = descripitionTextField.text
                    vc.DateLabels = DateLabel.text
                    vc.resivre = menuId
                    vc.EventTime = timeLabel.text
                    vc.strName = strName
                    vc.str = str
                    vc.is_read_enabled = is_read_enabled
                    vc.is_write_enabled = is_write_enabled
                    vc.modalPresentationStyle = .fullScreen
                    present(vc, animated: true,completion: nil)
                    
                }
                
                
                
            }
            
            else if priority == "p2"{
                
                if (descripitionTextField.text!.isEmpty) && (titleTextField.text!.isEmpty) {
                    
                    
                    
                    print("heloo",descripitionTextField.text.count)
                    
                    
                    let refreshAlert = UIAlertController(title: "", message: "Kindly Enter Details ", preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        
                        
                        
                        
                        
                    }))
                    
                    
                    
                    present(refreshAlert, animated: true, completion: nil)
                }
                
                
                else if  DateLabel.text ==  "-SelectDate-" {
                    
                    
                    
                    
                    let refreshAlert = UIAlertController(title: "", message: "  Please Select Date ", preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        
                        
                        
                        
                        
                    }))
                    
                    
                    
                    present(refreshAlert, animated: true, completion: nil)
                    
                }
                
                
                
                
                else if  timeLabel.text == "-Select Time-" {
                    
                    
                    
                    
                    let refreshAlert = UIAlertController(title: "", message: "  Please Select Time ", preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        
                        
                        
                        
                        
                    }))
                    
                    
                    
                    present(refreshAlert, animated: true, completion: nil)
                    
                    
                    
                }
                
                
                
                else if venuTextField.text == ""{
                    
                    
                    let refreshAlert = UIAlertController(title: "", message: "  Kindly Enter Venue Details ", preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        
                        
                        
                        
                        
                    }))
                    
                    
                    
                    present(refreshAlert, animated: true, completion: nil)
                    
                    
                    
                    
                    
                }
                
                
                else{
                    
                    let vc = HodSelectResipenceViewController(nibName: nil, bundle: nil)
                    vc.venumtextField = venuTextField.text
                    vc.titlesTextField = titleTextField.text
                    vc.discreptionss = descripitionTextField.text
                    vc.resivre = menuId
                    vc.eventDate = DateLabel.text
                    vc.EventTime = timeLabel.text
                    vc.strName = strName
                    vc.str = str
                    vc.is_read_enabled = is_read_enabled
                    vc.is_write_enabled = is_write_enabled
                    vc.modalPresentationStyle = .fullScreen
                    present(vc, animated: true,completion: nil)
                    
                }
                
                
            }
            
        }
        
        
        
        
        
        
    }
    
    
    
    
    @IBAction func BtnClicked(_ sender: Any) {
        
        
        FromDate_Action()
        
        
    }
    
    
    
    @IBAction func adLoad( ){
        
        
        let vc = TotalAddLoadPageViewController(nibName: nil, bundle: nil)
        
        vc.AddWebUrl = addWebUrl
        
        vc.modalPresentationStyle = . fullScreen
        present(vc, animated: true,completion: nil)
        
        
    }
    
    
    
    
    @IBAction func backbtn(_ sender: Any) {
        dismiss(animated: true)
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
        vc.modalPresentationStyle = .fullScreen
        let currentController = self.getCurrentViewController()
        currentController?.present(vc, animated: false, completion: nil)
        
        
        
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
        let currentController = self.getCurrentViewController()
        currentController?.present(vc, animated: true, completion: nil)
        
        
        
    }
    
    @IBAction func priorityVc() {
        
        let vc = PriorityViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return range.location <= 99
    }
    
    
}
