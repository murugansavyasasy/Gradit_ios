//
//  ChatReceiverInteractViewController.swift
//  Vs_GradItCollege
//
//  Created by Apple on 03/04/23.
//

import UIKit
import ObjectMapper
import KRProgressHUD


@available(iOS 16.0, *)
class ChatReceiverInteractViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    
    @IBOutlet weak var reusee: ReuseView!
    
    @IBOutlet weak var viewtotalheight: NSLayoutConstraint!
    
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var menubottom: NSLayoutConstraint!
    
    @IBOutlet weak var tapBarView: UIViewX!
    @IBOutlet weak var redirectLoginView: UIViewX!
    @IBOutlet weak var messageTextfield: UITextField!
    
    @IBOutlet weak var tv: UITableView!
    
    @IBOutlet weak var sendMessageView: UIView!
    
    @IBOutlet weak var backView: UIView!
    
    
    @IBOutlet weak var topMemberLabel: UILabel!
    
    @IBOutlet weak var noDataTextLabel: UILabel!
    
    @IBOutlet weak var noDataTextView: UIView!
    
    
    @IBOutlet weak var stafLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    
    @IBOutlet weak var topLabels: UILabel!
    @IBOutlet weak var notificationView: UIView!
    
    @IBOutlet weak var privacyPolicyView: UIView!
    
    @IBOutlet weak var faqView: UIView!
    
    @IBOutlet weak var changePasswordView: UIView!
    @IBOutlet weak var logoutView: UIView!
    
    @IBOutlet weak var helpView: UIView!
    
    @IBOutlet weak var profileView: UIView!
    
    
    @IBOutlet weak var termsAndConditionView: UIView!
    
    
    @IBOutlet weak var refreshView: UIView!
    
    @IBOutlet weak var changeRolesView: UIView!
    
    @IBOutlet weak var topMessageLabel: UILabel!
    
    
    
    @IBOutlet weak var clgLogoImg: UIImageView!
    
    @IBOutlet weak var sideMenuView: UIView!
    
    @IBOutlet weak var viewTap: UIView!
    
    @IBOutlet weak var swipeMenuHeight: NSLayoutConstraint!
    
    
    
  
    
    var chatData :  [StaffChatList] = []
    
    
    let menuIdentifier = "MenuCollectionViewCell"
    
    
    
    let chatIdentifier = "chatResTableViewCell"
    let chatIdentifier1 = "ChatsendTVTableViewCell"
    var MenuRefName :[menuApiDataDetails] = []
    var loginDatas : [datalogin]!
    var logindataprinci :[datalogin]!
    
    var student_id : String!
    var staff_id : String!
    var section_id : String!
    var is_classteacher : String!
    var subject_id : String!
    var userID : String!
    var priority : String!
    var colgId : String!
    
    var subjectName : String!
    
    
    var staff : String!
    
    
    var mobileNumber : String!
    
    var password  : String!
    
    var colgImg : String!
    
    var str : [String] = []
    
    var strName : [String] = []
    var is_read_enabled = ""
    var is_write_enabled = ""
    
   
    
    var StatusId : Int!
    var rowForScroll = 1
    
    var ofsetId = 0
    let refreshControl = UIRefreshControl()
    var tt :  [StaffChatList] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        
        sideMenuView.isHidden = true
        
        stafLabel.text = staff
        subjectLabel.text = subjectName
        
        let defaults = UserDefaults.standard
        
        
        
        userID = defaults.string(forKey: DefaultsKeys.memberid)
        colgId = defaults.string(forKey: DefaultsKeys.collegeid)
        
        priority = defaults.string(forKey: DefaultsKeys.priority)
        
        topMessageLabel.text = defaults.string(forKey: DefaultsKeys.memberName)
        mobileNumber  = defaults.string(forKey: DefaultsKeys.mobileNumber)
        password = defaults.string(forKey: DefaultsKeys.Password)
        
        
        
        colgImg = defaults.string(forKey: DefaultsKeys.colglogo)
        
        clgLogoImg.sd_setImage(with: URL(string:  colgImg), placeholderImage: UIImage(named: "person.fill"))
        
        
        
        
        let rowNib = UINib(nibName: chatIdentifier, bundle: nil)
        tv.register(rowNib, forCellReuseIdentifier: chatIdentifier)
        
        
        let rowNib2 = UINib(nibName: chatIdentifier1, bundle: nil)
        tv.register(rowNib2, forCellReuseIdentifier: chatIdentifier1)
        
        
        if is_read_enabled == "1"{
            
            chatList()
        }else{}
        
        
        
        
        
        
        let chatSendGesture = UITapGestureRecognizer(target: self, action: #selector( chatSend))
        sendMessageView.addGestureRecognizer(chatSendGesture)
        
        
        let backGesture = UITapGestureRecognizer(target: self, action: #selector( backVc))
        backView.addGestureRecognizer(backGesture)
        
        tv.dataSource = self
        tv.delegate = self
        
        
        messageTextfield.returnKeyType = .done
        messageTextfield.delegate = self
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
                   
                    print("ChatReceiverInteractViewController",reusee.callid)
                    
               
                }
        
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        tv.refreshControl = refreshControl
        
       
        
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
        
        let logoutGesture = UITapGestureRecognizer(target: self, action: #selector(logoutPressed))
        logoutView.addGestureRecognizer(logoutGesture)
        
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
        
        
    }
    
    
    @objc func dismissKeyboards() {
        
        sideMenuView.isHidden = true
        view.endEditing(true)
        
    }
    
    
    @objc func handleRefresh() {
        
        if StatusId == 1 {
            tv.refreshControl?.endRefreshing()
            print("Beforrrrrrrreeee",tt.count)
            ofsetId += 1
            chatList()
            
            
            print("gggdgdgdggdgdjggdfgdjg",tt.count)
           
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        messageTextfield.resignFirstResponder()
        return true
    }
    
    @IBAction  func backVc() {
        dismiss(animated: true)
    }
    
    
    func calculateHeight(inString:String) -> CGFloat
    {
        let messageString = inString
        let lineattribute : [NSAttributedString.Key : Any] = [
            .foregroundColor : UIColor(named: "#0f88b7ff"),
            .underlineStyle : NSUnderlineStyle.single.rawValue
        ]
        
        let attributeString = NSMutableAttributedString(string: messageString, attributes: lineattribute)
        
        let rect : CGRect = attributeString.boundingRect(with: CGSize(width: 222.0, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)
        
        let requredSize:CGRect = rect
        return requredSize.height
    }
    
    
    //
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidEndEditing")
        
        if messageTextfield.text == "" {
            messageTextfield.text = ""
            messageTextfield.textColor = UIColor.lightGray
            
        }
    }
    func chatList() {
        
        
        var chatReceiver = ChatReceiverInteractModal()
        
        chatReceiver.student_id = userID
        chatReceiver.staff_id = staff_id
        chatReceiver.section_id = section_id
        chatReceiver.is_classteacher = is_classteacher
        chatReceiver.subject_id = subject_id
        chatReceiver.limit = "10"
        
        var str = String(ofsetId)
        chatReceiver.offset = str
        
        APiCallManager.shared.callApi(url: APIEndpoints.GetStudentChatScreenForApp, httpMethod: .post, queryParam: nil, requestBody: chatReceiver) { [weak self] (result:Result<ChatReceiverInteractResponse,Error>) in
            guard let self = self else{return}
            
            switch result{
            case .success(let success):
                if success.Status == 1{
                    StatusId = 1
                    if let data = success.data {
                        for i in data {
                            chatData = i.List?.reversed() ?? []
                        }
                    }
                    tt.append(contentsOf: chatData)
                    if ofsetId == 0 {
                        scrollToBottom()
                    }
                    tv.dataSource = self
                    tv.delegate = self
                    tv.reloadData()
                }else{
                    StatusId = 0
                }
            case .failure(let error):
                print("Error: \(error)")
            }
            
        
        }
     
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        
        if ofsetId == 0 {
            
            return chatData.count
            
        }else{
            
            print("chatDatachatDatachatData",tt.count)
            return tt.count
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        
        
        if ofsetId == 0 {
            
            
            let chat : StaffChatList = chatData[indexPath.row]
            
            if chat.answer == "Not answered yet"{
               
                let cell = tableView.dequeueReusableCell(withIdentifier: chatIdentifier , for: indexPath) as! chatResTableViewCell
                
                
                cell.nameLabel.text = chat.studentname
                cell.messageContentLbl.text = chat.question
                
                
                let datees = String(chat.createdon?.prefix(10) ?? "")
                print("uiiiiii",chat.createdon)
                let first = String(chat.createdon?.prefix(16) ?? "")
                let second = String(first.suffix(5))
                print("selll",second)
                
                print("gggggfff",first)
                let dateAsString = second
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm"
                
                let date = dateFormatter.date(from: dateAsString)
                dateFormatter.dateFormat = "h:mm a"
                let Date12 = dateFormatter.string(from: date!)
                print("12 hour formatted Date:",Date12)
                
              
                
                let firsts = String(chat.createdon?.prefix(10) ?? "")
                //
                let dateFormatterGet = DateFormatter()
                
                dateFormatterGet.dateFormat = "yyy-MM-dd"
                
                
                
                let dateFormatterPrint = DateFormatter()
                
                dateFormatterPrint.dateFormat = " dd MMM,yyyy"
                
                
                
                let dates: NSDate? = dateFormatterGet.date(from: firsts) as NSDate?
                
                cell.timeAndDateLbl.text = dateFormatterPrint.string(from: dates! as Date)  +  "  " + Date12
           
                return cell
            }
            
            
            else{
                
                
                
                let cell = tableView.dequeueReusableCell(withIdentifier: chatIdentifier1 , for: indexPath) as! ChatsendTVTableViewCell
              
                cell.ansLbl.text = chat.answer
                cell.questionLbl.text = chat.question
                cell.studentName.text = chat.studentname
                
                
                
                let datees = String(chat.createdon?.prefix(10) ?? "")
                print("uiiiiii",chat.createdon)
                let first = String(chat.createdon?.prefix(16) ?? "")
                let second = String(first.suffix(5))
                print("selll",second)
                
                print("gggggfff",first)
                let dateAsString = second
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm"
                
                let date = dateFormatter.date(from: dateAsString)
                dateFormatter.dateFormat = "h:mm a"
                let Date12 = dateFormatter.string(from: date!)
                print("12 hour formatted Date:",Date12)
               
                
                let firsts = String(chat.createdon?.prefix(10) ?? "")
                //
                let dateFormatterGet = DateFormatter()
                
                dateFormatterGet.dateFormat = "yyy-MM-dd"
                
                
                
                let dateFormatterPrint = DateFormatter()
                
                dateFormatterPrint.dateFormat = " dd MMM,yyyy"
                
                
                
                let dates: NSDate? = dateFormatterGet.date(from: firsts) as NSDate?
                
                cell.timeLbl.text = dateFormatterPrint.string(from: dates! as Date)  +  "  " + Date12
                
                
                return cell
            }
            
            
            
            
            
        }
        
        
        else{
           
            
            let chat : StaffChatList = tt[indexPath.row]
            
            
            
            if chat.answer == "Not answered yet"{
               
                let cell = tableView.dequeueReusableCell(withIdentifier: chatIdentifier , for: indexPath) as! chatResTableViewCell
                
                cell.nameLabel.text = chat.studentname
                cell.messageContentLbl.text = chat.question
                
                
                let datees = String(chat.createdon?.prefix(10) ?? "")
                print("uiiiiii",chat.createdon)
                let first = String(chat.createdon?.prefix(16) ?? "")
                let second = String(first.suffix(5))
                print("selll",second)
                
                print("gggggfff",first)
                let dateAsString = second
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm"
                
                let date = dateFormatter.date(from: dateAsString)
                dateFormatter.dateFormat = "h:mm a"
                let Date12 = dateFormatter.string(from: date!)
                print("12 hour formatted Date:",Date12)
                
             
                
                let firsts = String(chat.createdon?.prefix(10) ?? "")
                //
                let dateFormatterGet = DateFormatter()
                
                dateFormatterGet.dateFormat = "yyy-MM-dd"
                
                
                
                let dateFormatterPrint = DateFormatter()
                
                dateFormatterPrint.dateFormat = " dd MMM,yyyy"
                
                
                
                let dates: NSDate? = dateFormatterGet.date(from: firsts) as NSDate?
                
                cell.timeAndDateLbl.text = dateFormatterPrint.string(from: dates! as Date)  +  "  " + Date12
             
                
                return cell
            }
            
            
            else{
                
                
                
                let cell = tableView.dequeueReusableCell(withIdentifier: chatIdentifier1 , for: indexPath) as! ChatsendTVTableViewCell
                
               
                cell.ansLbl.text = chat.answer
                cell.questionLbl.text = chat.question
                cell.studentName.text = chat.studentname
                
                
                
                let datees = String(chat.createdon?.prefix(10) ?? "")
                print("uiiiiii",chat.createdon)
                let first = String(chat.createdon?.prefix(16) ?? "")
                let second = String(first.suffix(5))
                print("selll",second)
                
                print("gggggfff",first)
                let dateAsString = second
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm"
                
                let date = dateFormatter.date(from: dateAsString)
                dateFormatter.dateFormat = "h:mm a"
                let Date12 = dateFormatter.string(from: date!)
                print("12 hour formatted Date:",Date12)
                
              
                
                let firsts = String(chat.createdon?.prefix(10) ?? "")
                let dateFormatterGet = DateFormatter()
                
                dateFormatterGet.dateFormat = "yyy-MM-dd"
                let dateFormatterPrint = DateFormatter()
                dateFormatterPrint.dateFormat = " dd MMM,yyyy"
                let dates: NSDate? = dateFormatterGet.date(from: firsts) as NSDate?
                cell.timeLbl.text = dateFormatterPrint.string(from: dates! as Date)  +  "  " + Date12
            
                return cell
            }
            
            
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
        
    }
    
    
    
    
    
    @IBAction  func chatSend() {
        
        if messageTextfield.text == ""{
            
            
            let refreshAlert = UIAlertController(title: "", message: "Message should not be empty", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in}))
            present(refreshAlert, animated: true, completion: nil)
        }else{
            
            var MessageSendReceiver = MessageSendReceiverSideModal()
          
            MessageSendReceiver.student_id = userID
            MessageSendReceiver.staff_id = staff_id
            MessageSendReceiver.section_id = section_id
            MessageSendReceiver.is_classteacher = is_classteacher
            MessageSendReceiver.subject_id = subject_id
            MessageSendReceiver.offset = "0"
            MessageSendReceiver.college_id = "1"
            MessageSendReceiver.question = messageTextfield.text
            
            APiCallManager.shared.callApi(url: APIEndpoints.StudentAskQuestionForApp, httpMethod: .post, queryParam: nil, requestBody: MessageSendReceiver) { [weak self] (result:Result<MessageSendResponse,Error>) in
                guard let self = self else{return}
                
                switch result{
                    
                case .success(let messageSendReceiverResponse):
                    if messageSendReceiverResponse.Status == 1{
                    
                        chatList()
                     
                        tv.dataSource = self
                        tv.delegate = self
                        tv.reloadData()
                        
                      
                    }else{
                        
                        let refreshAlert = UIAlertController(title: "", message: messageSendReceiverResponse.Message, preferredStyle: UIAlertController.Style.alert)
                        
                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in}))
                        present(refreshAlert, animated: true, completion: nil)
                        
                    }
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    }
    
    
    // Tab Bar Nagivation
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
        messageTextfield.becomeFirstResponder()
        
        print("You edit myTextField")
        
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
         
            KRProgressHUD.dismiss()
    
        }
       
        scrollToBottom1()
   
    }
    
    
    
    
    func scrollToBottom(){
        
        
        DispatchQueue.main.async { [self] in
            let section = 0
            let numberOfRows = self.chatData.count
            
            if numberOfRows > 0 {
                let indexPath = IndexPath(row: numberOfRows - 1, section: section)
                self.tv.scrollToRow(at: indexPath, at: .bottom, animated: false)
                
                //
            }
        }
        
    }
    
    
    
    
    
    
    func scrollToBottom1(){
        
        if ofsetId == 0 {
            
            DispatchQueue.main.async { [self] in
                let section = 0
                let numberOfRows = self.chatData.count
                
                if numberOfRows > 0 {
                    let indexPath = IndexPath(row: numberOfRows - 1, section: section)
                    self.tv.scrollToRow(at: indexPath, at: .bottom, animated: false)
                    
                    chatList()
                }
            }
            
        }
        
        else{
            
            DispatchQueue.main.async { [self] in
                let section = 0
                let numberOfRows = self.tt.count
                
                if numberOfRows > 0 {
                    let indexPath = IndexPath(row: numberOfRows - 1, section: section)
                    self.tv.scrollToRow(at: indexPath, at: .bottom, animated: false)
                    
                    chatList()
                }
            }
            
            
            
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
    
    
    
    @IBAction func chngeVc(){
        
        
        print("sarannn")
        
    }
    
    @IBAction func profileRedirect() {
        
        let vc = ProfileViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true, completion: nil)
        
    }
    
}
