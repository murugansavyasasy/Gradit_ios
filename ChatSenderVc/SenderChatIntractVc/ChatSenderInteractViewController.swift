//
//  ChatSenderInteractViewController.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 17/04/23.
//

import UIKit

import ObjectMapper
import KRProgressHUD



@available(iOS 16.0, *)
class ChatSenderInteractViewController: UIViewController,UITableViewDataSource,UITableViewDelegate, UIGestureRecognizerDelegate,UITextFieldDelegate {
    
    @IBOutlet weak var reusee: ReuseView!
    @IBOutlet weak var swipeMenuHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var replyViewHeight: NSLayoutConstraint!
    @IBOutlet weak var chatMsgHight: NSLayoutConstraint!
    
    
    
    @IBOutlet weak var tapBarView: UIView!
    @IBOutlet weak var redirectLoginView: UIViewX!
    
    @IBOutlet weak var subLabel: UILabel!
    
    @IBOutlet weak var subjectNameLabel: UILabel!
    
    @IBOutlet weak var yearLabel: UILabel!
    
    @IBOutlet weak var semLabel: UILabel!
    @IBOutlet weak var secLabel: UILabel!
    
    @IBOutlet weak var viewTap: UIView!
    
    
    @IBOutlet weak var noDataTextLabel: UILabel!
    
    @IBOutlet weak var noDataTextView: UIView!
    
    
    
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
    
    @IBOutlet weak var chatReplyShowView: UIView!
    @IBOutlet weak var chatReplyShowLabel: UILabel!
    
    @IBOutlet weak var chatIntView: UIView!
    
    @IBOutlet weak var chatcloseView: UIView!
    
    @IBOutlet weak var replySwitch: UISwitch!
    
    @IBOutlet weak var chatToolView: UIView!
    
    @IBOutlet weak var sendMessageView: UIView!
    
    @IBOutlet weak var replyTextField: UITextField!
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var tv: UITableView!
    
    
    
    var chatData :  [ChatSenderInteractData] = []
    
    let chatIdentifier = "ResiverTvTableViewCell"
    let chatIdentifier1 = "ChatSenderTvTableViewCell"
    //    ChatSenderTvTableViewCell
    var chats :  [AnswerStudentQuestionForAppData] = []
    
    
    
    
    
    var indexForCell : Int!
    
    var student_id : String!
    
    var staff_id : String!
    
    var section_id : String!
    
    var is_classteacher : String!
    
    var subject_id : String!
    
    var userID : String!
    
    
    
    var replyViewType : String!
    
    var replyType : Int = 2
    
    
    var subjectName : String!
    
    var section : String!
    var semesterName : String!
    
    var yearName : String!
    
    var course : String!
    
    var priority : String!
    
    var colgImg : String!
    
    var loginDatas : [datalogin]!
    var logindataprinci :[datalogin]!
    
    
    
    var mobileNumber : String!
    
    
    var password : String!
    
    let menuIdentifier = "MenuCollectionViewCell"
    var MenuRefName :[menuApiDataDetails] = []
    
    var str : [String] = []
    
    var strName : [String] = []
    
    var NoticeBoardId = "1"
    var videoId = "2"
    var EventId = "3"
    var communicationId = "4"
    var imagePdfId = "5"
    var Assigment = "6"
    var blocknamestudent : String!
    var indexPathss : Int!
    
    var hideView : Bool!
    
    var viewsss : UIView!
    
    let refreshControl = UIRefreshControl()
    var ReplyId  = ""
    
    var ofsetId = 0
    var tt :  [ChatSenderInteractData] = []
    var StatusId : Int!
    var is_read_enabled = ""
    var is_write_enabled = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        yearLabel.text = yearName
        semLabel.text = semesterName
        secLabel.text = section
        subjectNameLabel.text = course
        subLabel.text = subjectName
        
        
        noDataTextView.isHidden = true
        noDataTextLabel.isHidden = true
        
        sideMenuView.isHidden = true
        
        chatReplyShowView.isHidden = true
        
        let defaults = UserDefaults.standard
        
        
        
        
        
        mobileNumber = defaults.string(forKey: DefaultsKeys.mobileNumber)
        password = defaults.string(forKey: DefaultsKeys.Password)
        
        userID = defaults.string(forKey: DefaultsKeys.memberid)
        priority = defaults.string(forKey: DefaultsKeys.priority)
        
        topMessageLabel.text = defaults.string(forKey: DefaultsKeys.memberName)
        
        
        colgImg = defaults.string(forKey: DefaultsKeys.colglogo)
        clgLogoImg.sd_setImage(with: URL(string:  colgImg), placeholderImage: UIImage(named: "person.fill"))
        
        print("   chatMsgHight.constant = 150",   chatMsgHight.constant)
        if priority == "p1"{
            view.backgroundColor = UIColor(named: "Principal" )
            tapBarView.backgroundColor = UIColor(named: "Principal" )
            topLabels.text = "Principal"
            
        }
        
        else if priority == "p4"{
            
            topLabels.text = "Student"
            
        }
        
        else if priority == "p2"{
            view.backgroundColor = UIColor(named: "Teaching Staff" )
            tapBarView.backgroundColor = UIColor(named: "Teaching Staff" )
            topLabels.text = "Hod"
            
        }
        
        else if  priority == "p3" {
            view.backgroundColor = UIColor(named: "Teaching Staff" )
            tapBarView.backgroundColor = UIColor(named: "Teaching Staff" )
            topLabels.text = "Teacher"
        }
        
        
        
        
        else if priority == "p5"{
            
            
            topLabels.text = "Father"
            
            
            
        }
        
        else if priority == "p7"{
            
            
            topLabels.text = "univercityColorCod"
            
            
            
        }
        
        
        
        
        if is_read_enabled == "1"{
            
            chatList()
        }
        else{}
        
        
        let rowNib = UINib(nibName: chatIdentifier, bundle: nil)
        
        tv.register(rowNib, forCellReuseIdentifier: chatIdentifier)
        
        
        let rowNib1 = UINib(nibName: chatIdentifier1, bundle: nil)
        
        tv.register(rowNib1, forCellReuseIdentifier: chatIdentifier1)
        
        
        tv.dataSource = self
        
        tv.delegate = self
        
        
        
        replySwitch.addTarget(self, action: #selector(switchIsChanged), for: UIControl.Event.valueChanged)
        
        
        
        chatToolView.isHidden = true
        chatMsgHight.constant = 0
        
        
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
        
        else if priority == "p6"{
            
            
            
            view.backgroundColor = UIColor(named: "Teaching Staff")
            
            reusee.menuImg.image = UIImage(named: "HodImage")
            
            
        }
        
        swipeMenuHeight.constant = 150
        reusee.call_back = { [self]
            (val) in
            
            
            self.swipeMenuHeight.constant =  reusee.callid
            
            print("ChatSenderInteractViewController",reusee.callid)
            
            
        }
        
        
        
        let backGesture = UITapGestureRecognizer(target: self, action: #selector( backVc))
        
        backView.addGestureRecognizer(backGesture)
        
        
        
        
        let menuGestureHide = UITapGestureRecognizer(target: self, action: #selector(menu))
        viewTap.addGestureRecognizer(menuGestureHide)
        
        let notificationGesture = UITapGestureRecognizer(target: self, action: #selector(notificationVc))
        notificationView.addGestureRecognizer(notificationGesture)
        
        let refreshGesture = UITapGestureRecognizer(target: self, action: #selector(refreshVc))
        refreshView.addGestureRecognizer(refreshGesture)
        
        
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
        
        let loginRediectGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        redirectLoginView.addGestureRecognizer(loginRediectGesture)
        
        
        
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        tv.refreshControl = refreshControl
        
        
        replyTextField.returnKeyType = .done
        replyTextField.delegate = self
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        replyTextField.resignFirstResponder()
        return true
    }
    
    @objc func dismissKeyboards() {
        
        sideMenuView.isHidden = true
        view.endEditing(true)
        
    }
    
    @objc func handleRefresh() {
        
        if StatusId == 1 {
            
            tv.refreshControl?.endRefreshing()
            
            ofsetId += 1
            chatList()
            
        }
        
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
    
    
    
    @IBAction func switchIsChanged(mySwitch: UISwitch) {
        
        
        
        if replySwitch.isOn == true {
            
            replyType = 1
            
            print("UISwitch is ON")
            
        }else{
            
            replyType = 2
            
            print("UISwitch is OFF")
            
        }
        
    }
    
    
    
    func dismissKeyboard(ges: ReplyGesture) {

        if let replyView = ges.replyView {
            replyView.isHidden = true
        }

        view.endEditing(true)
    }
    
    
    
    
    
    @IBAction  func backVc() {
        
        dismiss(animated: true)
        
    }
    
    
    
    @IBAction  func chatIntss(ges : ReplyGesture) {
        chatMsgHight.constant = 0
        viewsss.isHidden = true
        
        chatToolView.isHidden = true
        if let replyView = ges.replyView {
            replyView.isHidden = true
        }
        chatReplyShowView.isHidden = true
    }
    
    
    
    func chatList() {
        
        var chatSender = ChatSenderInteractModal()
        chatSender.limit = "10"
        
        chatSender.staff_id = userID
        
        chatSender.section_id = section_id
        
        chatSender.is_classteacher = is_classteacher
        
        chatSender.subject_id = subject_id
        
        var str = String(ofsetId)
        chatSender.offset = str
        APiCallManager.shared.callApi(url: APIEndpoints.GetStaffChatScreenForApp, httpMethod: .post, queryParam: nil, requestBody: chatSender) { [weak self] (result:Result<ChatSenderInteractResponse,Error>) in
            guard let self = self else{return}
            
            switch result{
            case .success(let success):
                if ((success.result?.elementsEqual("1")) != nil){
                    
                    
                    
                    chatData = success.data?.reversed() ?? []
                    tt.append(contentsOf: chatData)
                    StatusId = 1
                    
                    noDataTextView.isHidden = true
                    noDataTextLabel.isHidden = true
                    tv.dataSource = self
                    
                    tv.delegate = self
                    
                    tv.reloadData()
                    
                    
                    if ofsetId == 0 {
                        
                        scrollToBottom()
                    }
                }else{
                    
                    StatusId = 0
                    noDataTextView.isHidden = false
                    noDataTextLabel.isHidden = false
                    noDataTextLabel.text = success.resultmessage
                    tv.dataSource = self
                    
                    tv.delegate = self
                    
                    tv.reloadData()
                    
                    
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
            
            let chat : ChatSenderInteractData = chatData[indexPath.row]
            
            
            if chat.answer == "Not answered yet"{
                
                
                
                
                let cell = tableView.dequeueReusableCell(withIdentifier: chatIdentifier , for: indexPath) as! ResiverTvTableViewCell
                
                
                
                
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
                
                let dateFormatterGet = DateFormatter()
                
                dateFormatterGet.dateFormat = "yyy-MM-dd"
                
                
                
                let dateFormatterPrint = DateFormatter()
                
                dateFormatterPrint.dateFormat = " dd MMM,yyyy"
                
                
                
                let dates: NSDate? = dateFormatterGet.date(from: firsts) as NSDate?
                
                cell.timeAndDateLbl.text = dateFormatterPrint.string(from: dates! as Date)  +  "  " + Date12
                
                
                
                if  chat.is_student_blocked == "0"{
                    
                    
                    cell.blockLabelName.text = "Block Student"
                    
                    
                }
                
                else{
                    
                    
                    cell.blockLabelName.text = "UnBlock Students"
                    
                }
                
                
                
                
                if chat.changeanswer == "1"{
                    
                    
                    cell.changeReplyLabl.text = "ChangeReply"
                    
                    
                }
                
                
                
                else{
                    
                    
                    cell.changeReplyLabl.text = "Reply"
                    
                }
                
                
                
                let replyViewGest = ReplyGesture(target: self, action: #selector(ReplyView))
                
                replyViewGest.replyView = cell.dotSelView
                
                cell.dotSelectView.addGestureRecognizer(replyViewGest)
                
                
                let chatInt = ReplyGesture(target: self, action: #selector( chatIntss))
                chatInt.replyView = cell.dotSelView
                
                chatIntView.addGestureRecognizer(chatInt)
                
                
                
                let blockGest = ReplyGesture(target: self, action: #selector(BlockStud))

                blockGest.blockstudent = chat.studentid ?? ""
                blockGest.blockStudentId = chat.is_student_blocked ?? "0"
                cell.blockStudView.isUserInteractionEnabled = true
                cell.blockStudView.addGestureRecognizer(blockGest)
                
                
                let replyGest = ReplyGesture(target: self, action: #selector(ReplySelect))
                
                
                replyGest.questinos = chat.question
                
                cell.replyView.addGestureRecognizer(replyGest)
                
                
                let chatSendGesture = ReplyGesture(target: self, action: #selector( ReplychatSend))
                
                chatSendGesture.indexss = indexPath.row
                chatSendGesture.section = indexPath.section
                
                chatSendGesture.quesId = chat.questionid
                
                sendMessageView.addGestureRecognizer(chatSendGesture)
                
                
                
                
                
                
                return cell
            }
            
            
            else{
                
                
                
                let cell = tableView.dequeueReusableCell(withIdentifier: chatIdentifier1 , for: indexPath) as! ChatSenderTvTableViewCell
                
                
                
                
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
        
        
        else{
            
            let chat : ChatSenderInteractData = tt[indexPath.row]
            
            
            if chat.answer == "Not answered yet"{
                
                
                
                
                let cell = tableView.dequeueReusableCell(withIdentifier: chatIdentifier , for: indexPath) as! ResiverTvTableViewCell
                
                
                
                
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
                
                let dateFormatterGet = DateFormatter()
                
                dateFormatterGet.dateFormat = "yyy-MM-dd"
                
                
                
                let dateFormatterPrint = DateFormatter()
                
                dateFormatterPrint.dateFormat = " dd MMM,yyyy"
                
                
                
                let dates: NSDate? = dateFormatterGet.date(from: firsts) as NSDate?
                
                cell.timeAndDateLbl.text = dateFormatterPrint.string(from: dates! as Date)  +  "  " + Date12
                
                
                
                if  chat.is_student_blocked == "0"{
                    
                    
                    cell.blockLabelName.text = "Block Student"
                    
                    
                }
                
                else{
                    
                    
                    cell.blockLabelName.text = "UnBlock Students"
                    
                }
                
                
                
                
                if chat.changeanswer == "1"{
                    
                    
                    cell.changeReplyLabl.text = "ChangeReply"
                    
                    
                }
                
                
                
                else{
                    
                    
                    cell.changeReplyLabl.text = "Reply"
                    
                }
                
                
                
                let replyViewGest = ReplyGesture(target: self, action: #selector(ReplyView))
                
                replyViewGest.replyView = cell.dotSelView
                
                cell.dotSelectView.addGestureRecognizer(replyViewGest)
                
                
                let chatInt = ReplyGesture(target: self, action: #selector( chatIntss))
                chatInt.replyView = cell.dotSelView
                
                chatIntView.addGestureRecognizer(chatInt)
                
                
                
                let blockGest = ReplyGesture(target: self, action: #selector(BlockStud))
                
                blockGest.blockstudent = chat.studentid
                
                blockGest.blockStudentId = chat.is_student_blocked
                
                cell.blockStudView.addGestureRecognizer(blockGest)
                
                
                let replyGest = ReplyGesture(target: self, action: #selector(ReplySelect))
                
                
                replyGest.questinos = chat.question
                
                cell.replyView.addGestureRecognizer(replyGest)
                
                
                
                
                
                
                
                let chatSendGesture = ReplyGesture(target: self, action: #selector( ReplychatSend))
                
                chatSendGesture.indexss = indexPath.row
                chatSendGesture.section = indexPath.section
                
                chatSendGesture.quesId = chat.questionid
                
                sendMessageView.addGestureRecognizer(chatSendGesture)
                
                
                
                
                
                
                return cell
            }
            
            
            else{
                
                
                
                let cell = tableView.dequeueReusableCell(withIdentifier: chatIdentifier1 , for: indexPath) as! ChatSenderTvTableViewCell
                
                
                
                
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
    }
    
    
    
    
    
    @IBAction func ReplyView(ges: ReplyGesture) {

        guard let replyView = ges.replyView else { return }

        viewsss = replyView

        if replyView.isHidden {
            replyView.isHidden = false
        } else {
            replyView.isHidden = true
            hideView = replyView.isHidden
        }
    }
    
    
    
    
    
    
    @IBAction func BlockStud(gesture: ReplyGesture) {

        guard let blockId = gesture.blockStudentId else { return }
        guard let studentId = gesture.blockstudent else { return }

        var studName: String?

        if blockId == "0" {
            studName = "Trying to block \(blocknamestudent ?? "")"
        } else {
            studName = "Trying to Unblock \(blocknamestudent ?? "")"
        }

        let alertController = UIAlertController(title: studName,
                                                message: "Press OK to confirm",
                                                preferredStyle: .alert)

        viewsss?.isHidden = true

        let okAction = UIAlertAction(title: "Ok", style: .default) { [weak self] _ in
            guard let self = self else { return }

            var blockModal = ChatBlockModal()
            blockModal.staff_id = self.userID
            blockModal.student_id = studentId
            blockModal.college_id = "1"

            APiCallManager.shared.callApi(
                url: APIEndpoints.UnblockStudentForApp,
                httpMethod: .post,
                queryParam: nil,
                requestBody: blockModal
            ) { (result: Result<ChatBlocResponse, Error>) in

                switch result {

                case .success(let success):
                    if success.Status == 1 {

                        self.view.makeToast(success.Message, duration: 1.0)

                        self.tv.reloadData()
                        self.chatList()
                    }

                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

        alertController.addAction(okAction)
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true)
    }
    
    @IBAction func ReplySelect(gesture : ReplyGesture ) {
        
        
        
        print("Reply")
        
        ReplyId = "0"
        viewsss.isHidden = true
        chatReplyShowLabel.text = gesture.questinos
        
        chatReplyShowView.isHidden = false
        
        
        chatToolView.isHidden = false
        chatMsgHight.constant = 100
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return UITableView.automaticDimension
        
    }
    
    
    @IBAction  func ReplychatSend(ges : ReplyGesture) {
        
        
        
        if replyTextField.text == ""{
            
            
            let refreshAlert = UIAlertController(title: "", message: "Message should not be empty", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
                
                
                
            }))
            
            
            
            
            self.present(refreshAlert, animated: true, completion: nil)
            
        }else{
            var answerChatSender = AnswerStudentQuestionForAppModal()
            answerChatSender.question_id =  ges.quesId
            answerChatSender.answer = replyTextField.text
            
            print("ReplyIdReplyId", ReplyId)
            
            if ReplyId == "0"{
                answerChatSender.is_changeanswer =  "0"
            }else{
                answerChatSender.is_changeanswer =  "1"
            }
            
            answerChatSender.reply_type =  String(replyType)
            answerChatSender.staff_id = userID
            
            APiCallManager.shared.callApi(url: APIEndpoints.AnswerStudentQuestionForApp, httpMethod: .post, queryParam: nil, requestBody: answerChatSender) { [weak self] (result:Result<AnswerStudentQuestionForAppResponse,Error>) in
                guard let self = self else{return}
                
                switch result{
                case .success(let success):
                    if success.Status == 1{
                        chatReplyShowView.isHidden = true
                        chatToolView.isHidden = true
                        chatMsgHight.constant = 0
                        viewsss.isHidden = true
                        tv.dataSource = self
                        tv.delegate = self
                        tv.reloadData()
                        chatList()
                    }
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            
            KRProgressHUD.dismiss()
            
            
        }
        
        
        scrollToBottom()
        
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
        
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: false, completion: nil)
        
        
        
    }
    
    
    
    
    
    
    @IBAction func changePassowrdVC(){
        
        let vc = ChangePasswordViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true, completion: nil)
        
        
        
    }
    
    
    
    
    
    
    @IBAction func menu() {
        
        if sideMenuView.isHidden == true{
            
            sideMenuView.isHidden = false
            //
            
            
        }
        
        else{
            
            sideMenuView.isHidden = true
            //
            
        }
        
        
    }
    
    
    
    @IBAction func priorityVc() {
        let vc = PriorityViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
    }
    
    @IBAction func profileRedirect() {
        
        let vc = ProfileViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true, completion: nil)
        
    }
    
    
}




class ReplyGesture: UITapGestureRecognizer {

    var replyView: UIView?
    var quesId: String?
    var blockstudent: String?
    var blockStudentId: String?
    var questinos: String?
    var indexss: Int?
    var section: Int?
    var leadConstant: NSLayoutConstraint?
}
