//
//  SenderComunicationPlusNextPageViewController.swift
//  GraditSenderCommunicationMenu
//
//  Created by MACBOOKPRO on 07/12/22.
//

import UIKit
import KRProgressHUD
import ObjectMapper

@available(iOS 16.0, *)
class SenderComunicationPlusNextPageViewController: UIViewController,UITextViewDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate{
    
    
    
    
    @IBOutlet weak var bottomOverAllView: UIView!
    @IBOutlet weak var historyTextMsgCheckBox: checkBoxFour!
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var newTextMsgCheckBox: checkBoxFour!
    
    @IBOutlet weak var tv: UITableView!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var tapBarView: UIViewX!
    @IBOutlet weak var discripitionView: UIViewX!
    
    @IBOutlet weak var nodataLbl: UILabel!
    @IBOutlet weak var topNameview: UIView!
    @IBOutlet weak var enterDiscripitonsLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var smallImg: UIImageView!
    
    @IBOutlet weak var bigImg: UIImageView!
    
    
    @IBOutlet weak var redirectLoginView: UIViewX!
    
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var topLabels: UILabel!
    
    
    @IBOutlet weak var logoutView: UIView!
    
    @IBOutlet weak var changeRolesView: UIView!
    @IBOutlet weak var profileView: UIView!
    
    @IBOutlet weak var clgLogoImg: UIImageView!
    
    @IBOutlet weak var topMessageLabel: UILabel!
    
    
    
    @IBOutlet weak var privacyPolicyView: UIView!
    
    
    
    @IBOutlet weak var faqView: UIView!
    
    
    @IBOutlet weak var viewTap: UIView!
    
    @IBOutlet weak var helpView: UIView!
    
    
    @IBOutlet weak var changePasswordView: UIView!
    
    
    @IBOutlet weak var termsAndConditionView: UIView!
    
    
    @IBOutlet weak var sideMenuView: UIView!
    
    
    
    @IBOutlet weak var refreshView: UIView!
    
    
    
    
    
    
    @IBOutlet weak var selectRecipientsView: UIViewX!
    
    @IBOutlet weak var descripitionTextField: UITextView!
    
    
    @IBOutlet weak var cancelView: UIViewX!
    
    var entierRefName : [EntiercollegeDataDetails] = []
    
    var backGroundImage : String!
    var smallImageUrl : String!
    var addWebUrl : String!
    var comuncationMenuId : String!
    
    var memberId : String!
    var priority : String!
    var collegeId : String!
    var departmentId : String!
    var sectionId : String!
    var loginType : String!
    var memberName : String!
    var colgImg    : String!
    var empty : String!
    var MobileNumber : String!
    
    var previousAddId : Int = 0
    
    var addapiRef : [AddDataDeatils] = []
    
    var loginDatas : [datalogin]!
    var logindataprinci :[datalogin]!
    let maxLenghth = 500
    var password : String!
    var str : [String] = []
    
    var strName : [String] = []
    var is_read_enabled = ""
    var is_write_enabled = ""
    
    var TvCellidentifer = "NextPageTVTableViewCell"
    var historyDataDetails : [HistorySmsVoiceDataDetail] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        
       
        descripitionTextField.text = "Enter the Description"
        descripitionTextField.textColor = UIColor.lightGray
        
        descripitionTextField.returnKeyType = .done
        descripitionTextField.delegate = self
        
        
        bigImg.sd_setImage(with: URL(string: backGroundImage), placeholderImage: UIImage(named: "ic_white"))
        
        
        smallImg.sd_setImage(with: URL(string: smallImageUrl), placeholderImage: UIImage(named: "ic_white"))
        
        tv.delegate = self
        tv.dataSource = self
        tv.isHidden = true
        nodataLbl.isHidden = true
        
        newTextMsgCheckBox.setImage(UIImage.init(named: "radios"), for: .normal)
        
        sideMenuView.isHidden = true
        
        let defaults = UserDefaults.standard
        
        memberId = defaults.string(forKey: DefaultsKeys.memberid)
        priority = defaults.string(forKey: DefaultsKeys.priority)
        collegeId = defaults.string(forKey: DefaultsKeys.collegeid)
        departmentId = defaults.string(forKey: DefaultsKeys.deptid)
        sectionId = defaults.string(forKey: DefaultsKeys.sectionid)
        loginType = defaults.string(forKey: DefaultsKeys.loginAsType)
        memberName = defaults.string(forKey: DefaultsKeys.memberName)
        MobileNumber = defaults.string(forKey: DefaultsKeys.mobileNumber)
        colgImg = defaults.string(forKey: DefaultsKeys.colglogo)
        clgLogoImg.sd_setImage(with: URL(string:  colgImg), placeholderImage: UIImage(named: "person.fill"))
        
        topMessageLabel.text = memberName
        password  = defaults.string(forKey: DefaultsKeys.Password)
        
        
        descripitionTextField.delegate = self
        titleTextField.returnKeyType = .done
        titleTextField.delegate = self
        
        
        
        let TextRownib = UINib(nibName: TvCellidentifer, bundle: nil)
        tv.register(TextRownib, forCellReuseIdentifier: TvCellidentifer)
        
        
        
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
        previousAddId = previousAddId + 1
        addApi()
        
        
        let disp = UITapGestureRecognizer(target: self, action: #selector(dispVc))
        discripitionView.addGestureRecognizer(disp)
        
        
        let selectRecpient = UITapGestureRecognizer(target: self, action: #selector(SelectRepVc))
        
        selectRecipientsView.addGestureRecognizer(selectRecpient)
        
        let cancel = UITapGestureRecognizer(target: self, action: #selector(cancelVC))
        cancelView.addGestureRecognizer(cancel)
        
        
        
        
        let changeRolesGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        changeRolesView.addGestureRecognizer(changeRolesGesture)
        
        let topname = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        topNameview.addGestureRecognizer(topname)
        
        
        let logoutGesture = UITapGestureRecognizer(target: self, action: #selector(logoutPressed))
        logoutView.addGestureRecognizer(logoutGesture)
        
        
        
        let menuGestureHide = UITapGestureRecognizer(target: self, action: #selector(menu))
        viewTap.addGestureRecognizer(menuGestureHide)
        
        let notificationGesture = UITapGestureRecognizer(target: self, action: #selector(notificationVc))
        notificationView.addGestureRecognizer(notificationGesture)
        
        let refreshGesture = UITapGestureRecognizer(target: self, action: #selector(refreshVc))
        refreshView.addGestureRecognizer(refreshGesture)
        let loginRediectGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        redirectLoginView.addGestureRecognizer(loginRediectGesture)
        
        
        let faqGesture = UITapGestureRecognizer(target: self, action: #selector(faqRedirect))
        faqView.addGestureRecognizer(faqGesture)
        
        
        
        let NewTextCheckBox = UITapGestureRecognizer(target: self, action: #selector(NewTextMsgVC))
        newTextMsgCheckBox.addGestureRecognizer(NewTextCheckBox)
        
        
        let historyCheckBoxs = UITapGestureRecognizer(target: self, action: #selector(HistoryMsgVC))
        historyTextMsgCheckBox.addGestureRecognizer(historyCheckBoxs)
        
        
        let helpGesture = UITapGestureRecognizer(target: self, action: #selector(helpRedirect))
        helpView.addGestureRecognizer(helpGesture)
        //
        
        let privacyPolicyGesture = UITapGestureRecognizer(target: self, action: #selector(privacyPolicyRedirect))
        privacyPolicyView.addGestureRecognizer(privacyPolicyGesture)
        
        let termsAndConditionGesture = UITapGestureRecognizer(target: self, action: #selector(termsAndCondition))
        termsAndConditionView.addGestureRecognizer(termsAndConditionGesture)
        
        
        
        let chagePassword = UITapGestureRecognizer(target: self, action: #selector(changePassowrdVC))
        changePasswordView.addGestureRecognizer(chagePassword)
        
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(adLoad))
        
        bigImg.isUserInteractionEnabled = true
        bigImg.addGestureRecognizer(singleTap)
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    @IBAction func HistoryMsgVC(){
        
        
        if historyTextMsgCheckBox.isChecked == true{
            
            historyTextMsgCheckBox.isChecked = false
            
          
            newTextMsgCheckBox.isChecked = true
            print("offff")
            tv.isHidden = true
            bottomOverAllView.isHidden = false
            contentView.isHidden = false
        }
        
        
        
        else{
            
            
            newTextMsgCheckBox.isChecked = false
            print("onnnnnn")
            tv.isHidden = false
            contentView.isHidden = true
            bottomOverAllView.isHidden = true
            HistoryApi()
            
            historyTextMsgCheckBox.isChecked = true
        }
        
        
        
    }
    
    
    
    
    @IBAction func NewTextMsgVC(){
        
        nodataLbl.isHidden = true
        if newTextMsgCheckBox.isChecked == true{
            
            newTextMsgCheckBox.isChecked = false
            
            
            historyTextMsgCheckBox.isChecked = true
            
            tv.isHidden = false
            contentView.isHidden = true
            bottomOverAllView.isHidden = true
            print("offff")
        }
        
        
        else{
            
            tv.isHidden = true
            print("onnnnnn")
            contentView.isHidden = false
            bottomOverAllView.isHidden = false
            historyTextMsgCheckBox.isChecked = false
            newTextMsgCheckBox.isChecked = true
        }
        
        
        
        
        
        
    }
    
    
    
    
    @IBAction func dispVc(){
        
        
        discripitionView.isHidden = true
        
    }
    
    
    @IBAction func adLoad(){
        
        
        let vc = SendercomuniAddViewController(nibName: nil, bundle: nil)
        
        vc.AddWebUrl = addWebUrl
        
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
        
    }
    
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        print("true")
        if descripitionTextField.text == "Enter the Description" {
            descripitionTextField.text = ""
            descripitionTextField.textColor = UIColor.black
            descripitionTextField.font = UIFont(name: "verdana", size: 14.0)
        }
    }
    
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        print("false")
        if descripitionTextField.text == "" {
            descripitionTextField.text = "Enter the Description"
            descripitionTextField.textColor = UIColor.lightGray
            descripitionTextField.font = UIFont(name: "verdana", size: 13.0)
            let selectRecpient = UITapGestureRecognizer(target: self, action: #selector(SelectRepVc))
            selectRecipientsView.addGestureRecognizer(selectRecpient)
            
        }
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
        return true
    }
    
    
    
    
    func HistoryApi(){
        
        var History = HistorySmsVoiceModal()
        
        History.priority = priority
        History.userid = memberId
        History.appid = "1"
        
        APiCallManager.shared.callApi(url: APIEndpoints.GetTextMessageHistory, httpMethod: .post, queryParam: nil, requestBody: History) {[weak self] (result:Result<HistorySmsVoiceResponce, Error>) in
        
            guard let self = self else {return}
            
            switch result {
            case .success(let success):
                historyDataDetails =  success.data ?? []
                nodataLbl.isHidden = !historyDataDetails.isEmpty
                nodataLbl.text = success.Message
                tv.reloadData()
            case .failure(let failure):
                historyDataDetails =  []
                nodataLbl.isHidden = false
                nodataLbl.text = failure.localizedDescription
                tv.reloadData()
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return historyDataDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TvCellidentifer, for: indexPath) as!
        NextPageTVTableViewCell
        
        let historys : HistorySmsVoiceDataDetail = historyDataDetails[indexPath.row]
        
        
        cell.DiscreptionLbl.text = historys.description
        cell.msgContent.text = historys.msgcontent
        cell.timeAndDateLbl.text = historys.timing
        
        let send  = sendGesture(target: self, action: #selector(sendVc))
        send.Discreption = historys.description
        send.MsgContent = historys.msgcontent
        cell.sendView.addGestureRecognizer(send)
        
        
        return cell
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    
    
    @IBAction func backbtn(_ sender: Any) {
        
        dismiss(animated: true)
    }
    
    
    @IBAction func sendVc(gesture : sendGesture){
        
        
        
        if priority == "p1"{
            
            
            
            let vc = SelectResipientsViewController(nibName: nil, bundle: nil)
            
            vc.resivre = comuncationMenuId
            vc.strName = strName
            vc.str = str
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            
            
            vc.titlesTextField = gesture.MsgContent
            vc.discreptionss = gesture.Discreption
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true,completion: nil)
            
            
            
        }
        
        
        else if priority == "p3"{
            
            
            
            let vc = HodRespienViewController(nibName: nil, bundle: nil)
            
            vc.resivre = comuncationMenuId
            vc.titlesTextField = gesture.MsgContent
            vc.discreptionss = gesture.Discreption
            vc.strName = strName
            vc.str = str
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true,completion: nil)
            
            
            
            
            
            
        }
        
        
        
        else if priority == "p7"{
            
            
            
            let vc = GroupHeadViewController(nibName: nil, bundle: nil)
            
            vc.resivre = comuncationMenuId
            vc.titlesTextField = gesture.MsgContent
            vc.discreptionss = gesture.Discreption
            vc.strName = strName
            vc.str = str
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true,completion: nil)
            
            
            
            
            
            
        }
        
        else if priority == "p2"{
            
            
            
            let vc = HodSelectResipenceViewController(nibName: nil, bundle: nil)
            
            vc.resivre = comuncationMenuId
            vc.titlesTextField = gesture.MsgContent
            vc.discreptionss = gesture.Discreption
            vc.strName = strName
            vc.str = str
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true,completion: nil)
            
        }
        
        
        
    }
    
    
    @IBAction func SelectRepVc(){
        
        
        
        if priority == "p1"{
            
            
            
            if (titleTextField.text == "") {
                
                
                
                
                
                
                let refreshAlert = UIAlertController(title: "", message: "Kindly Enter Title ", preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    
                }))
                
                
                
                present(refreshAlert, animated: true, completion: nil)
                
                
            }
            
            
            
            else if (descripitionTextField.text == "Enter the Description"){
                
                
                
                
                let refreshAlert = UIAlertController(title: "", message: "Kindly Enter Description", preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    
                }))
                
                
                
                present(refreshAlert, animated: true, completion: nil)
                
                
            }
            
            
            
            
            else if (descripitionTextField.text == ""){
                
                
                
                
                
                
                
                let refreshAlert = UIAlertController(title: "", message: "Kindly Enter Description", preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    
                }))
                
                
                
                present(refreshAlert, animated: true, completion: nil)
                
                
            }
            
            
            else{
                
                let vc = SelectResipientsViewController(nibName: nil, bundle: nil)
                
                vc.resivre = comuncationMenuId
                vc.strName = strName
                vc.str = str
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.titlesTextField = titleTextField.text
                vc.discreptionss = descripitionTextField.text
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true,completion: nil)
                
            }
            
        }
        
        
        else if priority == "p3"{
            
            if (titleTextField.text == "") {
                
                
                
                
                let refreshAlert = UIAlertController(title: "", message: "Kindly Enter Title", preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    
                }))
                
                
                
                present(refreshAlert, animated: true, completion: nil)
                
                
            }
            
            
            
            else if (descripitionTextField.text == "Enter the Description"){
                
                
                
                
                
                
                
                
                let refreshAlert = UIAlertController(title: "", message: "Kindly Enter Description", preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    
                }))
                
                
                
                present(refreshAlert, animated: true, completion: nil)
                
                
            }
            
            
            
            
            else if (descripitionTextField.text == ""){
                
                
                
                
                
                
                
                let refreshAlert = UIAlertController(title: "", message: "Kindly Enter Description", preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    
                }))
                
                
                
                present(refreshAlert, animated: true, completion: nil)
                
                
                
                
            }
            
            
            
            
            
            else{
                
                let vc = HodRespienViewController(nibName: nil, bundle: nil)
                
                vc.resivre = comuncationMenuId
                vc.titlesTextField = titleTextField.text
                vc.discreptionss = descripitionTextField.text
                vc.strName = strName
                vc.str = str
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true,completion: nil)
                
            }
            
            
            
            
            
        }
        
        
        
        else if priority == "p7"{
            
            if (titleTextField.text == "") {
                
                
                
                
                let refreshAlert = UIAlertController(title: "", message: "Kindly Enter Title", preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    
                }))
                
                
                
                present(refreshAlert, animated: true, completion: nil)
                
                
            }
            
            
            
            else if (descripitionTextField.text == "Enter the Description"){
                
                
                
                
                
                
                
                
                let refreshAlert = UIAlertController(title: "", message: "Kindly Enter Description", preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    
                }))
                
                
                
                present(refreshAlert, animated: true, completion: nil)
                
                
            }
            
            
            
            
            else if (descripitionTextField.text == ""){
                
                
                
                
                
                
                
                let refreshAlert = UIAlertController(title: "", message: "Kindly Enter Description", preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    
                }))
                
                
                
                present(refreshAlert, animated: true, completion: nil)
                
                
                
                
            }
            
            
            
            
            
            else{
                
                let vc = GroupHeadViewController(nibName: nil, bundle: nil)
                
                vc.resivre = comuncationMenuId
                vc.titlesTextField = titleTextField.text
                vc.discreptionss = descripitionTextField.text
                vc.strName = strName
                vc.str = str
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true,completion: nil)
                
            }
            
            
            
            
            
        }
        
        else if priority == "p2"{
            
            
            if (titleTextField.text == "") {
                
                
                
                
                
                
                
                let refreshAlert = UIAlertController(title: "", message: "Kindly Enter Title", preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    
                }))
                
                
                
                present(refreshAlert, animated: true, completion: nil)
                
                
            }
            
            
            
            else if (descripitionTextField.text == "Enter the Description"){
                
                
                
                
                
                
                
                let refreshAlert = UIAlertController(title: "", message: "Kindly Enter Description", preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    
                }))
                
                
                
                present(refreshAlert, animated: true, completion: nil)
                
            }
            
            
            
            
            else if (descripitionTextField.text == ""){
                
                
                
                
                
                
                
                let refreshAlert = UIAlertController(title: "", message: "Kindly Enter Description", preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    
                }))
                
                
                
                present(refreshAlert, animated: true, completion: nil)
                
                
                
            }
            
            
            
            else{
                
                let vc = HodSelectResipenceViewController(nibName: nil, bundle: nil)
                
                vc.resivre = comuncationMenuId
                vc.titlesTextField = titleTextField.text
                vc.discreptionss = descripitionTextField.text
                vc.strName = strName
                vc.str = str
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true,completion: nil)
                
            }
            
            
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
        add.college_id = collegeId
        add.previous_add_id = 3
        
        previousAddId = previousAddId + 1
        
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
    
    @IBAction func cancelVC(){
       
        dismiss(animated: true)
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
    
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return range.location <= 99
    }
    
}


class sendGesture : UITapGestureRecognizer{
    
    
    var MsgContent : String!
    var Discreption : String!
    
    
}
