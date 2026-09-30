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
    
    @IBOutlet weak var newTextMessageBtn: UIButton!
    @IBOutlet weak var selectFromHistoryBtn: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bottomOverAllView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var tv: UITableView!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var customTabBar: CustomTabBar!
    @IBOutlet weak var discripitionView: UIViewX!
    @IBOutlet weak var nodataLbl: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var smallImg: UIImageView!
    @IBOutlet weak var bigImg: UIImageView!
    @IBOutlet weak var logoutView: UIView!
    @IBOutlet weak var changeRolesView: UIView!
    @IBOutlet weak var privacyPolicyView: UIView!
    @IBOutlet weak var faqView: UIView!
    @IBOutlet weak var helpView: UIView!
    @IBOutlet weak var changePasswordView: UIView!
    @IBOutlet weak var termsAndConditionView: UIView!
    @IBOutlet weak var sideMenuView: UIView!
    @IBOutlet weak var selectRecipientsView: UIViewX!
    @IBOutlet weak var descripitionTextField: UITextView!
    @IBOutlet weak var cancelView: UIViewX!
    
    var backGroundImage : String!
    var smallImageUrl : String!
    var addWebUrl : String!
    var comuncationMenuId : String!
    var memberId : String!
    var priority : String!
    var collegeId : String!
    var MobileNumber : String!
    var previousAddId : Int = 0
    var addapiRef : [AddDataDeatils] = []
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
        descripitionTextField.returnKeyType = .default
        descripitionTextField.addDoneBtn()
        descripitionTextField.delegate = self
        
        bigImg.sd_setImage(with: URL(string: backGroundImage), placeholderImage: UIImage(named: "ic_white"))
        smallImg.sd_setImage(with: URL(string: smallImageUrl), placeholderImage: UIImage(named: "ic_white"))
        
        tv.delegate = self
        tv.dataSource = self
        tv.isHidden = true
        nodataLbl.isHidden = true
        sideMenuView.isHidden = true
        
        let defaults = UserDefaults.standard
        
        memberId = defaults.string(forKey: DefaultsKeys.memberid)
        priority = defaults.string(forKey: DefaultsKeys.priority)
        collegeId = defaults.string(forKey: DefaultsKeys.collegeid)
        MobileNumber = defaults.string(forKey: DefaultsKeys.mobileNumber)
        password  = defaults.string(forKey: DefaultsKeys.Password)
        
        descripitionTextField.delegate = self
        titleTextField.returnKeyType = .done
        titleTextField.delegate = self
        
        let TextRownib = UINib(nibName: TvCellidentifer, bundle: nil)
        tv.register(TextRownib, forCellReuseIdentifier: TvCellidentifer)
        
        view.backgroundColor = .priorityColor
        customTabBar.delegate = self
        
        previousAddId = previousAddId + 1
        addApi()
        
        let selectRecpient = UITapGestureRecognizer(target: self, action: #selector(SelectRepVc))
        selectRecipientsView.addGestureRecognizer(selectRecpient)
        
        let cancel = UITapGestureRecognizer(target: self, action: #selector(cancelVC))
        cancelView.addGestureRecognizer(cancel)
        
        let changeRolesGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        changeRolesView.addGestureRecognizer(changeRolesGesture)
        
        let logoutGesture = UITapGestureRecognizer(target: self, action: #selector(logoutPressed))
        logoutView.addGestureRecognizer(logoutGesture)
        
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
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(adLoad))
        bigImg.isUserInteractionEnabled = true
        bigImg.addGestureRecognizer(singleTap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func SelectFromHistoryAct(_sender: UIButton){
        
        tv.isHidden = false
        contentView.isHidden = true
        selectRecipientsView.isHidden = true
        HistoryApi()
        newTextMessageBtn.setImage(UIImage(systemName: "circle"), for: .normal)
        selectFromHistoryBtn.setImage(UIImage(systemName: "inset.filled.circle"), for: .normal)
    }
  
    @IBAction func NewTextMessageAct(_sender: UIButton){
        
        tv.isHidden = true
        contentView.isHidden = false
        selectRecipientsView.isHidden = false
        newTextMessageBtn.setImage(UIImage(systemName: "inset.filled.circle"), for: .normal)
        selectFromHistoryBtn.setImage(UIImage(systemName: "circle"), for: .normal)
    }
   
    @IBAction func adLoad(){
        
        let vc = SendercomuniAddViewController(nibName: nil, bundle: nil)
        
        vc.AddWebUrl = addWebUrl
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if descripitionTextField.text == "Enter the Description" {
            descripitionTextField.text = ""
            descripitionTextField.textColor = UIColor.black
            descripitionTextField.font = UIFont(name: "verdana", size: 14.0)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if descripitionTextField.text == "" {
            descripitionTextField.text = "Enter the Description"
            descripitionTextField.textColor = UIColor.lightGray
            descripitionTextField.font = UIFont(name: "verdana", size: 13.0)
            let selectRecpient = UITapGestureRecognizer(target: self, action: #selector(SelectRepVc))
            selectRecipientsView.addGestureRecognizer(selectRecpient)
            
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        lblCount.text = "\(descripitionTextField.text.count)/"+"\(maxLenghth)"
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (descripitionTextField.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        
        return numberOfChars <= 500
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
        
        if let timing = historys.timing {
            let dateAndTime = timing.components(separatedBy: " - ")

            cell.DateLbl.text = dateAndTime.first ?? ""
            cell.TimeLbl.text = dateAndTime.dropFirst().joined(separator: " - ")
        }
        
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
        
        }else if priority == "p3"{
            
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
            
        }else if priority == "p7"{
            
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
             
        }else if priority == "p2"{
            
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
        
        if titleTextField.text?.isEmpty == true {
            AlertHelper.showOKAlert(on: self, title: "", message: "Please Enter the Title")
        }else if descripitionTextField.text?.isEmpty == true || descripitionTextField.text == "Enter the Description"{
            AlertHelper.showOKAlert(on: self, title: "", message: "Please Enter the Description")
        }else {
            
            switch priority {
                
            case "p1":
                
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
                
            case "p2":
                
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
                
            case "p3":
                
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
                
            case "p7" :
                
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
                
            default :
                break
            }
        }
    }
    
    func addApi(){
        
        var add = AddApiModal()
        
        let defaults = UserDefaults.standard
        var deviceToken = defaults.string(forKey:DefaultsKeys.DeviceToken )
        add.device_token = deviceToken
        add.member_id = Int(memberId)
        add.mobile_no = MobileNumber
        add.priority = priority
        add.college_id = Int(collegeId)
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return range.location <= 99
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        
        guard let keyboardFrame = notification.userInfo?[
            UIResponder.keyboardFrameEndUserInfoKey
        ] as? CGRect else { return }
        
        let keyboardHeight = keyboardFrame.height + 20
        
        scrollView.contentInset.bottom = keyboardHeight
        scrollView.verticalScrollIndicatorInsets.bottom = keyboardHeight
        
//        DispatchQueue.main.async {
//               self.scrollView.scrollRectToVisible(
//                   self.descripitionTextField.frame,
//                   animated: true
//               )
//           }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        scrollView.contentInset.bottom = 0
           scrollView.verticalScrollIndicatorInsets.bottom = 0
    }
}

@available(iOS 16.0, *)
extension SenderComunicationPlusNextPageViewController : CustomTabBarDelegate {
    func didTapSearch() {
    }
    
    func didTapSideMenu() {
        sideMenuView.isHidden.toggle()
    }
}


class sendGesture : UITapGestureRecognizer{
    
    var MsgContent : String!
    var Discreption : String!
}
