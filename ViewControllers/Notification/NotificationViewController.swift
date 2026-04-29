//
//  NotificationViewController.swift
//  Vs_GradIt
//
//  Created by APPLE on 27/09/22.
//

import UIKit
import ObjectMapper
import KRProgressHUD



@available(iOS 16.0, *)
class NotificationViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

@IBOutlet weak var reusee: ReuseView!
@IBOutlet weak var topNameview: UIView!
@IBOutlet weak var topLabels: UILabel!
@IBOutlet weak var tapBarView: UIViewX!
@IBOutlet weak var topMessageLabel: UILabel!
@IBOutlet weak var viewTap: UIView!
@IBOutlet weak var changePasswordView: UIView!
@IBOutlet weak var termsAndConditionView: UIView!
@IBOutlet weak var helpView: UIView!
@IBOutlet weak var clgLogoImg: UIImageView!
@IBOutlet weak var priorityView: UIViewX!
@IBOutlet weak var loginView: UIView!
@IBOutlet weak var sideMenuView: UIView!
@IBOutlet weak var faqView: UIView!
@IBOutlet weak var swipeMenuHeight: NSLayoutConstraint!
@IBOutlet weak var noRecordLbl: UILabel!
@IBOutlet weak var privacyPolicyView: UIView!
@IBOutlet weak var refreshView: UIView!
@IBOutlet weak var tv: UITableView!
@IBOutlet weak var profileView: UIView!
@IBOutlet weak var changeRolesView: UIView!

let menuIdentifier = "MenuCollectionViewCell"
var MenuRefName :[menuApiDataDetails] = []
var notificationDataList : [NotificationData] = []
let rowIdentifier = "NotificationTableViewCell"
var colgId : String!
var memberId : String!
var priority : String!
var colgLog : String!
var MobileNumber : String!
var passwords : String!
var loginDatas : [datalogin]!
var logindataprinci :[datalogin]!
var str : [String] = []
var strName : [String] = []
var is_read_enabled = ""
var is_write_enabled = ""

override func viewDidLoad() {
    super.viewDidLoad()
    
    sideMenuView.isHidden = true
    refreshView.isHidden = true
    noRecordLbl.isHidden = true
    let defaults = UserDefaults.standard
    
    
    colgId = defaults.string(forKey: DefaultsKeys.collegeid)
    memberId = defaults.string(forKey: DefaultsKeys.memberid)
    priority = defaults.string(forKey: DefaultsKeys.priority)
    topMessageLabel.text = defaults.string(forKey: DefaultsKeys.memberName)
    passwords = defaults.string(forKey: DefaultsKeys.Password)
    MobileNumber = defaults.string(forKey: DefaultsKeys.mobileNumber)
    
    colgLog = defaults.string(forKey: DefaultsKeys.colglogo)
    clgLogoImg.sd_setImage(with: URL(string:  colgLog), placeholderImage: UIImage(named: "EmptyCollegeIcon"))
    tv.dataSource = self
    tv.delegate = self
    
    
    if priority == "p1"{
        tapBarView.backgroundColor = UIColor(named: "Principal" )
        topLabels.text = "Principal"
        
        profileView.isHidden = true
    }
    
    else if priority == "p4"{
        
        topLabels.text = "Student"
        tapBarView.backgroundColor = UIColor(named: "StudentParent" )
        profileView.isHidden = false
    }
    
    else if priority == "p2" || priority == "p3"{
        
        tapBarView.backgroundColor = UIColor(named: "Teaching Staff" )
        topLabels.text = "Teacher"
        
        profileView.isHidden = true
    }
    
    else if priority == "p5"{
        
        tapBarView.backgroundColor = UIColor(named: "FatherColor" )
        topLabels.text = "Father"
        
        profileView.isHidden = false
        
    }
    
    else if priority == "p6"{
        
        tapBarView.backgroundColor = UIColor(named: "Teaching Staff" )
        topLabels.text = "Non Teaching"
        
        profileView.isHidden = true
        
    }
    
    
    else if priority == "p7"{
        
        tapBarView.backgroundColor = UIColor(named: "univercityColorCod" )
        topLabels.text = "GroupHead"
        
        profileView.isHidden = true
        
    }
    
    dashBoardList()
    
    if priority == "p1" {
        
        print("PrincipalVieewwColor")
        view.backgroundColor = UIColor(named: "Principal" )
        
        reusee.menuImg.image = UIImage(named: "principalBigMenu")
        
    }else if priority == "p4" {
        
        print("StudentVieewwColor")
        view.backgroundColor = UIColor(named: "studentViewColors")
        
        reusee.menuImg.image = UIImage(named: "studentSwipeImage")
        
    } else if priority == "p3" ||  priority == "p2" || priority == "p6" {
        
        print("HooodddVieewwColor")
        view.backgroundColor = UIColor(named: "Teaching Staff")
        
        reusee.menuImg.image = UIImage(named: "HodImage")
        
    }
    else if priority == "p5"{
        
        view.backgroundColor = UIColor(named: "FatherColor")
        
        reusee.menuImg.image = UIImage(named: "StaffBigMenu")
        
    }
    
    else if priority == "p7"{
        
        
        view.backgroundColor = UIColor(named: "univercityColorCod")
        
        reusee.menuImg.image = UIImage(named: "UnivercityHead")
        
    }
    swipeMenuHeight.constant = 150
    reusee.call_back = { [self]
        (val) in
        
        
        self.swipeMenuHeight.constant =  reusee.callid
        
        print("NotificationViewController",reusee.callid)
        
        
    }
    let testVC = HomeScreenViewController()
    
    let rowNib = UINib(nibName: rowIdentifier, bundle: nil)
    tv.register(rowNib, forCellReuseIdentifier: rowIdentifier)
    
    
    
    
    let tapGes = UITapGestureRecognizer(target: self, action: #selector(testVC.refreshVc))
    refreshView.addGestureRecognizer(tapGes)
    
    
    let menuGestureHide = UITapGestureRecognizer(target: self, action: #selector(menu))
    viewTap.addGestureRecognizer(menuGestureHide)
    
    
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
    
    
    let changeRolesGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
    changeRolesView.addGestureRecognizer(changeRolesGesture)
    
    let tops = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
    topNameview.addGestureRecognizer(tops)
    
    
    
    
    let profileGesture = UITapGestureRecognizer(target: self, action: #selector(profileRedirect))
    profileView.addGestureRecognizer(profileGesture)
    
    
    let chagePassword = UITapGestureRecognizer(target: self, action: #selector(changePassowrdVC))
    changePasswordView.addGestureRecognizer(chagePassword)
    
    
    
    
}


@objc func dismissKeyboards() {
    
    sideMenuView.isHidden = true
    view.endEditing(true)
    
}

    
    func dashBoardList() {
        
        var notification = NotificationModal()
        notification.college_id = colgId
        notification.member_id = memberId
        
        print("notification request", notification)
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.GetNotificationForCollege,
            httpMethod: .post,
            queryParam: nil,
            requestBody: notification
        ) { [weak self] (result: Result<NotificationResponse, Error>) in
            
            guard let self = self else { return }
            
            switch result {
                
            case .success(let notificationResponse):
                
                if notificationResponse.Status == 1{
                    
                    self.noRecordLbl.isHidden = true
                    self.notificationDataList = notificationResponse.data ?? []
                    
                    self.tv.dataSource = self
                    self.tv.delegate = self
                    self.tv.reloadData()
                }
                
                else{
                    
                    self.noRecordLbl.isHidden = false
                    self.noRecordLbl.text = notificationResponse.Message
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }


func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return notificationDataList.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    
    let cell = tableView.dequeueReusableCell(withIdentifier: rowIdentifier, for: indexPath)  as! NotificationTableViewCell
    
    let notify : NotificationData = notificationDataList[indexPath.row]
    cell.contentLbl.text = notify.notification_content
    cell.titleLbl.text = notify.title
    
    let datees = String((notify.sent_on ?? "").prefix(10))
    print("uiiiiii",notify.sent_on ?? "")
    let first = String((notify.sent_on ?? "").prefix(16))
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
    
    let dateFormatterGet = DateFormatter()
    
    dateFormatterGet.dateFormat = "yyy-MM-dd"
    
    
    
    let dateFormatterPrint = DateFormatter()
    
    dateFormatterPrint.dateFormat = " MMM dd,yyyy"
    
    
    
    
    let date3: NSDate? = dateFormatterGet.date(from: datees ) as NSDate?
    
    
    cell.timeLbl.text = Date12
    cell.datelabel.text = dateFormatterPrint.string(from: date3 as! Date)
    
    return cell
}



func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    
    let notify : NotificationData = notificationDataList[indexPath.row]
    
    
    if notify.module_type == "Circular"{
        
        if priority == "p1"{
            let vc = SenderImagePdfHomePageViewController(nibName: nil, bundle: nil)
            
            vc.view.backgroundColor = UIColor(named: "Principal" )
            vc.imageSegmentName.backgroundColor = UIColor(named: "UnSelector")
            vc.imageSegmentName.selectedSegmentTintColor = UIColor(named: "Selector")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
            
            
            
            
        }
        else if priority == "p2" || priority == "p3" || priority == "p6"{
            
            let vc = SenderImagePdfHomePageViewController(nibName: nil, bundle: nil)
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            vc.imageSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.imageSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
            
        }
        else if priority == "p7"{
            
            let vc = SenderImagePdfHomePageViewController(nibName: nil, bundle: nil)
            vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
            vc.imageSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.imageSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
            
        }
        
        else if priority == "p4" {
            
            for i in DefaultsKeys.MenuRefName{
                
                if i.menu_slug == "circular"{
                    is_read_enabled = String(i.is_read_enabled)
                    is_write_enabled = String(i.is_write_enabled)
                }
            }
            
            let vc = ImageViewController(nibName: nil, bundle: nil)
            
            vc.view.backgroundColor = UIColor(named: "StudentParent")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
            
        }
        
        else if priority == "p5" {
            
            
            
            let vc = ImageViewController(nibName: nil, bundle: nil)
            vc.view.backgroundColor = UIColor(named: "FatherColor")
            
            vc.imageSegmentName.backgroundColor = UIColor(named: "FatherUnselector")
            vc.imageSegmentName.selectedSegmentTintColor = UIColor(named: "FatherSelector")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
           
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
            
            
        }
        
        
    }
    
    
    else if notify.module_type == "Communication"{
        
        
        if priority == "p1"{
            
            
            let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
            
            vc.view.backgroundColor = UIColor(named: "Principal" )
            vc.CommuniSegementName.backgroundColor = UIColor(named: "UnSelector")
            vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "Selector")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
           
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
            
            
            
        }
        else if priority == "p2" || priority == "p3" || priority == "p6"{
            
            let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
           
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
            
        }
        
        else if priority == "p7"{
            
            let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
            vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
            vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
         
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
            
        }
        
        else if priority == "p4" {
            
            let vc = CommunicationHomePageViewController(nibName: nil, bundle: nil)
            
            print("communicationssssssss")
         
            vc.view.backgroundColor = UIColor(named: "StudentParent")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            
            present(vc, animated: false, completion: nil)
      
        }
        
        else if priority == "p5" {
            
            let vc = CommunicationHomePageViewController(nibName: nil, bundle: nil)
            
            
            vc.view.backgroundColor = UIColor(named: "FatherColor")
            vc.CommuniSegementName.backgroundColor = UIColor(named: "FatherUnselector")
            vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "FatherSelector")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
          
            vc.modalPresentationStyle = .fullScreen
            
            present(vc, animated: false, completion: nil)
        
        }
        
    }
    
    
    
    else if notify.module_type == "Events"{
        
        if priority == "p4"{
            
            let vc = EventsViewController(nibName: nil, bundle: nil)
            vc.modalPresentationStyle = .fullScreen
            
            vc.view.backgroundColor = UIColor(named: "StudentParent")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
        
        }
        
        else if priority == "p1"{
            
            let vc = SenderEventHomePageViewController(nibName: nil, bundle: nil)
            
            vc.view.backgroundColor = UIColor(named: "Principal" )
            vc.eventSegmentName.backgroundColor = UIColor(named: "UnSelector")
            vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "Selector")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
            
        
        }
        
        
        else if priority == "p2" || priority == "p3" {
            
            let vc = SenderEventHomePageViewController(nibName: nil, bundle: nil)
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            vc.eventSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
            
            
            
        }
        
        
        else if priority == "p7" {
            
            
            
            let vc = SenderEventHomePageViewController(nibName: nil, bundle: nil)
            vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
            vc.eventSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
            
            
            
        }
        else if priority == "p5"{
            
            let vc = EventsViewController(nibName: nil, bundle: nil)
            vc.view.backgroundColor = UIColor(named: "FatherColor")
            vc.eventSegmentName.backgroundColor = UIColor(named: "FatherUnselector")
            vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "FatherSelector")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
            
        }
    }
    
    
    else if notify.module_type == "Notice board"{
        
        if priority == "p4"{
            
            for i in DefaultsKeys.MenuRefName{
                
                if i.menu_slug == "notice_board"{
                    is_read_enabled = String(i.is_read_enabled)
                    is_write_enabled = String(i.is_write_enabled)
                }
            }
            
            let vc = NoticeBoardHomePageViewController(nibName: nil, bundle: nil)
            
            vc.view.backgroundColor = UIColor(named: "StudentParent")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
        }
        
        else if priority == "p1"{
            
            let vc = SenderGraditNoticeBoardMenuViewController(nibName: nil, bundle: nil)
            
            vc.view.backgroundColor = UIColor(named: "Principal" )
            vc.noticeSegments.backgroundColor = UIColor(named: "UnSelector")
            vc.noticeSegments.selectedSegmentTintColor = UIColor(named: "Selector")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
        }
        
        
        else if priority == "p2" || priority == "p3" {
            
            
            let vc = SenderGraditNoticeBoardMenuViewController(nibName: nil, bundle: nil)
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            vc.noticeSegments.backgroundColor = UIColor(named: "HodUnSelector")
            vc.noticeSegments.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
        
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
        }
        
        else if priority == "p7" {
            
            
            let vc = SenderGraditNoticeBoardMenuViewController(nibName: nil, bundle: nil)
            vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
            vc.noticeSegments.backgroundColor = UIColor(named: "HodUnSelector")
            vc.noticeSegments.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
            
            
        }
        
        
        else if priority == "p5"{
            
            let vc = NoticeBoardHomePageViewController(nibName: nil, bundle: nil)
            vc.view.backgroundColor = UIColor(named: "FatherColor")
            
            vc.noticeSegments.backgroundColor = UIColor(named: "FatherUnselector")
            vc.noticeSegments.selectedSegmentTintColor = UIColor(named: "FatherSelector")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
            
        }
     
    }
    
    
    else if notify.module_type == "Videos"{
        
        
        
        if priority == "p4"{
            
            
            
            let vc = VideoViewController(nibName: nil, bundle: nil)
            
            vc.view.backgroundColor = UIColor(named: "StudentParent")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
         
        }
        
        
        
        
        else if priority == "p1"{
            
            
            let vc = SenderVideoHomePageViewController(nibName: nil, bundle: nil)
            
            vc.view.backgroundColor = UIColor(named: "Principal" )
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
          
        }
        
        
        
        
        else if priority == "p2" || priority == "p3" {
            
            
            let vc = SenderVideoHomePageViewController(nibName: nil, bundle: nil)
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            
            vc.str = str
            vc.strName = strName
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
         
        }
        
        
        
        else if priority == "p7" {
            
            
            let vc = SenderVideoHomePageViewController(nibName: nil, bundle: nil)
            vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
            
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            
            vc.str = str
            vc.strName = strName
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
        
        }
        
        
        else if priority == "p5"{
            
            
            let vc = VideoViewController(nibName: nil, bundle: nil)
            
            vc.view.backgroundColor = UIColor(named: "FatherColor")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
        
        }
        
        
        
    }
    
    else if notify.module_type == "Assignments"{
        
        
        if priority == "p4"{
            
            let vc = AssigmentHomePageViewController(nibName: nil, bundle: nil)
            
            vc.view.backgroundColor = UIColor(named: "StudentParent")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
            
            
            
            
        }
        
        
        
        
        else if priority == "p1"{
            
            let vc = SenderAssigmentHomePageViewController(nibName: nil, bundle: nil)
            
            vc.view.backgroundColor = UIColor(named: "Principal" )
            vc.assigmentSegmentName.backgroundColor = UIColor(named: "UnSelector")
            vc.assigmentSegmentName.selectedSegmentTintColor = UIColor(named: "Selector")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
            
        }
        
        
        
        
        else if priority == "p2" || priority == "p3" {
            
            
            let vc = SenderAssigmentHomePageViewController(nibName: nil, bundle: nil)
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            vc.assigmentSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.assigmentSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
            //
            
            
        }
        
        
        else if priority == "p7" {
            
            
            let vc = SenderAssigmentHomePageViewController(nibName: nil, bundle: nil)
            vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
            vc.assigmentSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.assigmentSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
            //
            
            
        }
        
        else if priority == "p5"{
            
            
            let vc = AssigmentHomePageViewController(nibName: nil, bundle: nil)
            
            vc.view.backgroundColor = UIColor(named: "StudentParent")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
            
            
            
        }
        
        
    }
 
}


func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 120
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
     
        print("menuVisble")
    }
    
    else{
        
        sideMenuView.isHidden = true
     
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


@IBAction func priortyScreenVc(){
    
   
    let vc = PriorityViewController(nibName: nil, bundle: nil)
    vc.modalPresentationStyle = .fullScreen
    //
    let defaults = UserDefaults.standard
    
    
    present(vc, animated: true,completion: nil)
    
}

@IBAction func profileRedirect() {
    
    let vc = ProfileViewController(nibName: nil, bundle: nil)
    vc.str = str
    vc.strName = strName
    vc.modalPresentationStyle = .fullScreen
    present(vc, animated: true, completion: nil)
    
}


}
