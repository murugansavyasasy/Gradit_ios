//
//  HomeScreenViewController.swift
//  GraditLoginApp
//
//  Created by MACBOOKPRO on 18/10/22.
//

import UIKit
import KRProgressHUD
import ObjectMapper

@available(iOS 16.0, *)
class HomeScreenViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var topNameview: UIView!
    @IBOutlet weak var tapBarView: UIViewX!
    @IBOutlet weak var loadingCustom: UIActivityIndicatorView!
    @IBOutlet weak var clearCacheView: UIView!
    @IBOutlet weak var topLabels: UILabel!
    @IBOutlet weak var changePasswordView: UIView!
    @IBOutlet weak var viewTap: UIView!
    @IBOutlet weak var topNameLabel: UILabel!
    @IBOutlet weak var swipeMenuHeight: NSLayoutConstraint!
    @IBOutlet weak var redirectLoginView: UIViewX!
    @IBOutlet weak var refreshView: UIView!
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var faqView: UIView!
    @IBOutlet weak var logoutView: UIView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var termsAndConditionView: UIView!
    @IBOutlet weak var privacyPolicyView: UIView!
    @IBOutlet weak var helpView: UIView!
    @IBOutlet weak var changeRolesView: UIView!
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var clgLogoImg: UIImageView!
    @IBOutlet weak var sideMenuView: UIView!
    @IBOutlet weak var tv: UITableView!
    @IBOutlet weak var actionView: UIView!
    @IBOutlet weak var reusee: ReuseView!
    @IBOutlet weak var ResumeBuildView: UIView!
    
    var loginDatas : [datalogin]!
    var logindataprinci :[datalogin]!
    private var realHeight = 0
    var MenuRefName :[menuApiDataDetails] = []
    var principlaRef :[menuApiDataDetails] = []
    var HodRef : [menuApiDataDetails] = []
    var fatherRef : [menuApiDataDetails] = []
    var LeaveeReq : [LeaveRequestType] = []
    var inde : IndexPath?
    var NoticeBoardId = "1"
    var videoId = "2"
    var EventId = "3"
    var communicationId = "4"
    var imagePdfId = "5"
    var Assigment = "6"
    var loginAsType : String!
    var memberName : String!
    var colgName : String!
    var colgImg : String!
    var colgId : String!
    var memberId : String!
    var priority : String!
    var colgcity  : String!
    var message : String!
    var orderType : Int!
    var passwords : String!
    let advertisementIdentifier = "HomeTableViewCell"
    let emergencyIdentifier = "EmergencyTableViewCell"
    let attendanceIdentifier = "AttandanceTableViewCell"
    let noticeBoardIdentifier = "NoticeBoardTableViewCell"
    let imagePdfIdentifier = "ImagePdfTableViewCell"
    let recentNotificationIdentifier = "RecentNotificationTableViewCell"
    let CircularIdentifier = "CircularTableViewCell"
    let assignmentListIdentifier = "AssignmentTableviewCel"
    let EventsIdentifier = "EventsTableViewCell"
    var identifer2 = "MydeparmentHeaderFooterView"
    let menuIdentifier = "MenuCollectionViewCell"
    let chatIdentifier = "HomePageChatTableViewCell"
    let leaveRequestIdentifier = "HomeLeaveRequestTableViewCell"
    
    var assignmentData : [AssignmentsDashType] = []
    var noticeBoardData : [NoticeBoardDashType] = []
    var dashBoardDataList : [DashBoardData] = []
    var emerData : [EmergencyDashTypes] = []
    var dashBoardDataType : String!
    var AdvertismentData : [AdData] = []
    var circularData : [CircularDashType] = []
    var attendanceData : [AttendanceDashType] = []
    var RecentData : [RecentNotificationsDashType] = []
    var  sti : [AdData] = []
    var EventData : [UpcomingEventsDashType] = []
    var chatDatas : [chatData] = []
    var getMenuData : [GetUsermenuData] = []
    let NC = UINavigationController()
    var str : [String] = []
    var strName : [String] = []
    var MobileNumber : String!
    var is_read_enabled = ""
    var is_write_enabled = ""
    var heightss  = 0
    var Subidentifier = "EmerTableViewCell"
    var valType = "0"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        
        loadingCustom.startAnimating()
        
        sideMenuView.isHidden = true
        
        priorityVc()
        
        print("swipeMenuHeightswipeMenuHeightswipeMenuHeight",heightss)
        print("OpenHomeViewController")
        let defaults = UserDefaults.standard
        
        colgImg = defaults.string(forKey: DefaultsKeys.colglogo)
        memberName = defaults.string(forKey: DefaultsKeys.memberName)
        colgName = defaults.string(forKey: DefaultsKeys.colgName)
        colgId = defaults.string(forKey: DefaultsKeys.collegeid)
        memberId = defaults.string(forKey: DefaultsKeys.memberid)
        loginAsType = defaults.string(forKey: DefaultsKeys.loginAsType)
        priority = defaults.string(forKey: DefaultsKeys.priority)
        colgcity = defaults.string(forKey:DefaultsKeys.colgcity)
        MobileNumber = defaults.string(forKey: DefaultsKeys.mobileNumber)
        passwords = defaults.string(forKey: DefaultsKeys.Password)
        print("passsddesrffd",passwords)
        print("MobileNumber",MobileNumber)
        
        tv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 120, right: 0)
        
        topNameLabel.text = memberName
        
        
        if colgImg != ""{
            
            clgLogoImg.sd_setImage(with: URL(string:  colgImg), placeholderImage: UIImage(named: "EmptyCollegeIcon"))
        } else{
            
            clgLogoImg.image = UIImage(named: "EmptyCollegeIcon")
        }
        
        swipeMenuHeight.constant = 150
        reusee.call_back = { [self]
            (val) in
            self.swipeMenuHeight.constant =  reusee.callid
            
            print("HelloWorld544544343",reusee.callid)
            
        }
        
        dashBoardList()
        
        if priority == "p1"{
            
            tapBarView.backgroundColor = UIColor(named: "Principal" )
            topLabels.text = "Principal"
            
            profileView.isHidden = true
            clearCacheView.isHidden = true
        }
        
        else if priority == "p4"{
            tapBarView.backgroundColor = UIColor(named: "StudentParent" )
            topLabels.text = "Student"
            profileView.isHidden = false
            clearCacheView.isHidden = true
        }
        
        else if priority == "p2" {
            
            tapBarView.backgroundColor = UIColor(named: "Teaching Staff" )
            topLabels.text = "Hod"
            profileView.isHidden = true
            clearCacheView.isHidden = true
        }
        
        
        else if priority == "p7" {
            
            tapBarView.backgroundColor = UIColor(named: "univercityColorCod" )
            topLabels.text = "UnivesityHead"
            profileView.isHidden = true
            clearCacheView.isHidden = true
        }
        else if priority == "p5"{
            
            tapBarView.backgroundColor = UIColor(named: "FatherColor" )
            topLabels.text = "Father"
            profileView.isHidden = false
            clearCacheView.isHidden = true
        }
        
        else if priority == "p3"{
            
            tapBarView.backgroundColor = UIColor(named: "Teaching Staff" )
            topLabels.text = "Teacher"
            
            profileView.isHidden = true
            clearCacheView.isHidden = true
        }
        
        else if priority == "p6"{
            
            tapBarView.backgroundColor = UIColor(named: "Teaching Staff" )
            topLabels.text = "NonTeachingStaff"
            
            profileView.isHidden = true
            clearCacheView.isHidden = true
            
        }
        if priority == "p1" {
            
            
            print("PrincipalVieewwColor")
            view.backgroundColor = UIColor(named: "Principal" )
            viewBg.backgroundColor = UIColor(named: "Principal" )
            
            reusee.menuImg.image = UIImage(named: "principalBigMenu")
            
        }else if priority == "p4" {
            
            print("StudentVieewwColor")
            view.backgroundColor = UIColor(named: "studentViewColors")
            viewBg.backgroundColor = UIColor(named: "studentViewColors")
            
            reusee.menuImg.image = UIImage(named: "studentSwipeImage")
            
        } else if priority == "p3" ||  priority == "p2" {
            
            print("HooodddVieewwColor")
            view.backgroundColor = UIColor(named: "Teaching Staff")
            viewBg.backgroundColor = UIColor(named: "Teaching Staff")
            
            reusee.menuImg.image = UIImage(named: "HodImage")
            
        }
        
        
        else if priority == "p7" {
            
            print("HooodddVieewwColor")
            view.backgroundColor = UIColor(named: "univercityColorCod")
            viewBg.backgroundColor = UIColor(named: "univercityColorCod")
            
            reusee.menuImg.image = UIImage(named: "UnivercityHead")
            
        }
        
        else if priority == "p5"{
            
            view.backgroundColor = UIColor(named: "FatherColor")
            viewBg.backgroundColor = UIColor(named: "FatherColor")
            
            reusee.menuImg.image = UIImage(named: "StaffBigMenu")
            
        }
        
        else if priority == "p6"{
            
            view.backgroundColor = UIColor(named: "Teaching Staff")
            viewBg.backgroundColor = UIColor(named: "Teaching Staff")
            
            reusee.menuImg.image = UIImage(named: "HodImage")
            
        }
        
        let advertisementRowNib = UINib(nibName: advertisementIdentifier, bundle: nil)
        tv.register(advertisementRowNib, forCellReuseIdentifier: advertisementIdentifier)
        //
        self.tv.tableFooterView = UIView()
        
        let assignmentRowNib = UINib(nibName: assignmentListIdentifier, bundle: nil)
        tv.register(assignmentRowNib, forCellReuseIdentifier: assignmentListIdentifier)
        
        let chatRowNib = UINib(nibName: chatIdentifier, bundle: nil)
        tv.register(chatRowNib, forCellReuseIdentifier: chatIdentifier)
        
        
        let leaves = UINib(nibName: leaveRequestIdentifier, bundle: nil)
        tv.register(leaves, forCellReuseIdentifier: leaveRequestIdentifier)
        
        
        let CircularRowNib = UINib(nibName: CircularIdentifier, bundle: nil)
        tv.register(CircularRowNib, forCellReuseIdentifier: CircularIdentifier)
        
        
        let loginRediectGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        redirectLoginView.addGestureRecognizer(loginRediectGesture)
        
        
        let clearCache = UITapGestureRecognizer(target: self, action: #selector(clearCheaseVc))
        clearCacheView.addGestureRecognizer(clearCache)
        //
        
        let notificationGesture = UITapGestureRecognizer(target: self, action: #selector(notificationVc))
        notificationView.addGestureRecognizer(notificationGesture)
        
        let noticeBoardRowNib = UINib(nibName: noticeBoardIdentifier, bundle: nil)
        tv.register(noticeBoardRowNib, forCellReuseIdentifier: noticeBoardIdentifier)
        
        let emergencyRowNib = UINib(nibName: emergencyIdentifier, bundle: nil)
        tv.register(emergencyRowNib, forCellReuseIdentifier: emergencyIdentifier)
        
        
        let imageRowNib = UINib(nibName: imagePdfIdentifier, bundle: nil)
        tv.register(imageRowNib, forCellReuseIdentifier: imagePdfIdentifier)
        
        
        let Subidentif = UINib(nibName: Subidentifier, bundle: nil)
        tv.register(Subidentif, forCellReuseIdentifier: Subidentifier)
        
        
        let recentNotificationRowNib = UINib(nibName: recentNotificationIdentifier, bundle: nil)
        tv.register(recentNotificationRowNib, forCellReuseIdentifier: recentNotificationIdentifier)
        
        let eventsRowNib = UINib(nibName: EventsIdentifier, bundle: nil)
        tv.register(eventsRowNib, forCellReuseIdentifier: EventsIdentifier)
        
        
        let attendanceRowNib = UINib(nibName: attendanceIdentifier, bundle: nil)
        tv.register(attendanceRowNib, forCellReuseIdentifier: attendanceIdentifier)
        
        
        // tap bar  UITapGusture :
        
        let changeRolesGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        changeRolesView.addGestureRecognizer(changeRolesGesture)
        
        let topnameview = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        topNameview.addGestureRecognizer(topnameview)
        
        let termsAndConditionGesture = UITapGestureRecognizer(target: self, action: #selector(termsAndCondition))
        termsAndConditionView.addGestureRecognizer(termsAndConditionGesture)
        
        let refreshGesture = UITapGestureRecognizer(target: self, action: #selector(refreshVc))
        refreshView.addGestureRecognizer(refreshGesture)
        
        let profileGesture = UITapGestureRecognizer(target: self, action: #selector(profileRedirect))
        profileView.addGestureRecognizer(profileGesture)
        //
        let helpGesture = UITapGestureRecognizer(target: self, action: #selector(helpRedirect))
        helpView.addGestureRecognizer(helpGesture)
        
        let logoutGesture = UITapGestureRecognizer(target: self, action: #selector(logoutPressed))
        logoutView.addGestureRecognizer(logoutGesture)
        
        
        let menuGestureHide = UITapGestureRecognizer(target: self, action: #selector(menu))
        
        sideMenuView.isHidden = true
        viewTap.addGestureRecognizer(menuGestureHide)
        
        
        let chagePassword = UITapGestureRecognizer(target: self, action: #selector(changePassowrdVC))
        changePasswordView.addGestureRecognizer(chagePassword)
        
        let faqGesture = UITapGestureRecognizer(target: self, action: #selector(faqRedirect))
        faqView.addGestureRecognizer(faqGesture)
        let privacyPolicyGesture = UITapGestureRecognizer(target: self, action: #selector(privacyPolicyRedirect))
        privacyPolicyView.addGestureRecognizer(privacyPolicyGesture)
        
        let ResumeTap = UITapGestureRecognizer(target: self, action: #selector(resumeBuilderRedirect))
        ResumeBuildView.addGestureRecognizer(ResumeTap)
        
        getDeviceToken()
        
        
    }
    
    
    func getDeviceToken(){
        var devicToken = DeviceTokenModal()
        
        let defaults = UserDefaults.standard
        var mobileNum = defaults.string(forKey: DefaultsKeys.mobileNumber)
        
        defaults.set( devicToken.devicetoken, forKey: DefaultsKeys.DEVICETOKEN)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let myOtherVariable = appDelegate.DeviceToken
        
        print("devicetoken",myOtherVariable)
        devicToken.mobileno = mobileNum
        devicToken.devicetype    = "iphone"
        devicToken.devicetoken    = myOtherVariable
        
        APiCallManager.shared.callApi(url: APIEndpoints.DeviceToken, httpMethod: .post, queryParam: nil, requestBody: devicToken) {[weak self] (result:Result<DeviceTokenResponse, any Error>) in
            
            guard let self = self else {return}
            
            switch result {
            case .success(let success):
                print(success.Message ?? "")
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    
    func removeDuplicateElements(arr: [Int]) -> [Int] {
        var uniqueElements: [Int] = []
        for x in arr {
            if !uniqueElements.contains(x) {
                uniqueElements.append(x)
            }
        }
        return uniqueElements
    }
    
    func dashBoardList() {
        
        print("homePagedashBoardList")
        
        var dashBoard = DashBoardModal()
        dashBoard.collegeid = colgId
        dashBoard.userid = memberId
        dashBoard.priority = priority
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.DashboardApi_Live,
            httpMethod: .post,
            queryParam: nil,
            requestBody: dashBoard
        ) {[weak self] (result:Result<DashBoardResponse, Error>) in
                
            guard let self = self else { return }
            
            switch result {
            case .success(let success):
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3 ){ [weak self] in
                    self?.loadingCustom.stopAnimating()
                    self?.loadingCustom.isHidden  = true
                }
                
                if success.Status == 1 {
                    dashBoardDataList =  success.data ?? []
                    
                    for i in dashBoardDataList {
                        
                        if i.type == "Ad"{
                            AdvertismentData = i.dashSubData
                            print("addd.coun",AdvertismentData.count)
                        }else if i.type == "Emergency Notification"{
                            emerData = i.emerSubData
                        }else if i.type == "Attendance"{
                            attendanceData = i.attendanceSubData
                        }else if i.type == "Assignments"{
                            assignmentData = i.assigment
                        }else if i.type == "Notice Board" {
                            noticeBoardData =   i.noticeSubData
                        }else if i.type == "Circular"{
                            circularData = i.circular
                        }else if i.type == "Recent Notifications"{
                            RecentData = i.recentNotificationSubData
                        }else if i.type == "Leave Request"{
                            LeaveeReq = i.leaveRequest
                        }else if i.type == "Chat"{
                            chatDatas = i.Chat
                        }else if i.type == "Upcoming Events"{
                            EventData = i.Events
                        }
                    }
                }else {
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3 ){ [weak self] in
                        self?.loadingCustom.stopAnimating()
                        self?.loadingCustom.isHidden  = true
                    }
                    
                    let refreshAlert = UIAlertController(title: "Something Went Wrong, Try Again later", message: success.Message, preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "YES", style: .default, handler: { (action: UIAlertAction!) in
                        
//                        UserDefaults.standard.removeObject(forKey: DefaultsKeys.mobileNumber)
                    }))
                    
                    present(refreshAlert, animated: true, completion: nil)
                }
            case .failure(let failure):
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3 ){ [weak self] in
                    self?.loadingCustom.stopAnimating()
                    self?.loadingCustom.isHidden  = true
                }
                
                let refreshAlert = UIAlertController(title: "Something Went Wrong, Try Again later", message: failure.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "YES", style: .default, handler: { (action: UIAlertAction!) in
                    
//                    UserDefaults.standard.removeObject(forKey: DefaultsKeys.mobileNumber)
                }))
                
                present(refreshAlert, animated: true, completion: nil)
            }
            
            tv.dataSource = self
            tv.delegate = self
            tv.reloadData()
            
            }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dashBoardDataList.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        print("index",indexPath.row)
        
        tv.allowsSelection = false
        
        
        let dashBoardList : DashBoardData = dashBoardDataList[indexPath.row]
        
        
        var indeRow = indexPath.row + 1
        
        if dashBoardList.type == "Ad" {
            
            indeRow = dashBoardList.order
            
            let cell = tableView.dequeueReusableCell(withIdentifier: advertisementIdentifier, for: indexPath)as! HomeTableViewCell
            
            for i in dashBoardList.dashSubData{
                
                cell.bigImg.sd_setImage(with: URL(string: i.background_image ?? ""), placeholderImage: UIImage(named: "ic_white"))
                cell.smallImg.sd_setImage(with: URL(string: i.add_image ?? ""), placeholderImage: UIImage(named: "ic_white"))
                
                let loadGesture = HomeViewGesture(target: self, action: #selector(adLoad))
                
                loadGesture.url =  i.add_url
                
                cell.adView.addGestureRecognizer(loadGesture)
                
            }
            
            return cell
        }
        
        
        
        else if dashBoardList.type == "Emergency Notification" {
            print("indexsssulla",indeRow)
            indeRow = dashBoardList.order
            
            let cell = tableView.dequeueReusableCell(withIdentifier: emergencyIdentifier, for: indexPath)as! EmergencyTableViewCell
            
            cell.emrgencyRef = dashBoardList.emerSubData
            
            let viewClick = UITapGestureRecognizer(target: self, action: #selector(RecentNotificationVc))
            
            cell.ClickView.addGestureRecognizer(viewClick)
            
            print("dashBoardList.dashOrder",dashBoardList.emerSubData)
            
            print("cell.emrgencyRef12",emerData)
            print("cell.emrgencyRef",dashBoardList.emerSubData)
            
            
            cell.call_back = { [self]
                (val) in
                
                valType = val
                print("cell.expandType",cell.expandType)
                print("cellVal",val)
                tv.delegate = self
                tv.reloadData()
            }
            
            return cell
            
        }
        
        else if dashBoardList.type == "Attendance" {
            
            indeRow = dashBoardList.order
            
            print("Attendance")
            
            let cell = tableView.dequeueReusableCell(withIdentifier: attendanceIdentifier, for: indexPath)as! AttandanceTableViewCell
            
            cell.attend = dashBoardList.attendanceSubData
            
            let viewClick = UITapGestureRecognizer(target: self, action: #selector(AttendanceViewVc))
            
            cell.viewAllClick.addGestureRecognizer(viewClick)
            
            
            return cell
        }
        
        else if dashBoardList.type == "Assignments"  {
            
            indeRow = dashBoardList.order
            
            let cell = tableView.dequeueReusableCell(withIdentifier: assignmentListIdentifier, for: indexPath)as! AssignmentTableviewCel
            
            cell.strName = strName
            cell.str = str
            for i in DefaultsKeys.MenuRefName{
                if i.menu_slug == "assignment"{
                    cell.is_read_enabled = String(i.is_read_enabled)
                    cell.is_write_enabled = String(i.is_write_enabled)
                }
            }
            cell.assignmentDatas = dashBoardList.assigment
            
            let assigmentViewAll = UITapGestureRecognizer(target: self, action: #selector(AssigmentViewAllVc))
            
            cell.viewAll.addGestureRecognizer(assigmentViewAll)
            
            return cell
            
        }
        
        
        else   if  dashBoardList.type == "Notice Board"  {
            
            indeRow = dashBoardList.order
            
            let cell = tableView.dequeueReusableCell(withIdentifier: noticeBoardIdentifier, for: indexPath)as! NoticeBoardTableViewCell
            
            cell.strName = strName
            cell.str = str
            for i in DefaultsKeys.MenuRefName{
                if i.menu_slug == "notice_board"{
                    cell.is_read_enabled = String(i.is_read_enabled)
                    cell.is_write_enabled = String(i.is_write_enabled)
                }
            }
            cell.noticeBoardData = dashBoardList.noticeSubData
            
            let viewClick = UITapGestureRecognizer(target: self, action: #selector(viewVc))
            
            cell.noticeView.addGestureRecognizer(viewClick)
            
            
            return cell
            
            
        } else   if dashBoardList.type == "Circular"{
            
            indeRow = dashBoardList.order
            
            let cell = tableView.dequeueReusableCell(withIdentifier: CircularIdentifier, for: indexPath)as! CircularTableViewCell
            
            cell.strName = strName
            cell.str = str
            for i in DefaultsKeys.MenuRefName{
                if i.menu_slug == "circular"{
                    cell.is_read_enabled = String(i.is_read_enabled)
                    cell.is_write_enabled = String(i.is_write_enabled)
                }
            }
            cell.circularData = dashBoardList.circular
            let circularViewClick = UITapGestureRecognizer(target: self, action: #selector(circularViewVc))
            
            cell.circularView.addGestureRecognizer(circularViewClick)
            
            
            return cell
        }
        else if dashBoardList.type == "Recent Notifications"   {
            
            indeRow = dashBoardList.order
            
            let cell = tableView.dequeueReusableCell(withIdentifier: recentNotificationIdentifier, for: indexPath)as! RecentNotificationTableViewCell
            
            cell.RecentDatas = dashBoardList.recentNotificationSubData
            let RecentNotification = UITapGestureRecognizer(target: self, action: #selector(RecentNotificationVc))
            
            cell.ViewClick.addGestureRecognizer(RecentNotification)
            
            return cell
        }
        
        else if dashBoardList.type == "Upcoming Events" {
            
            print("Upcoming Events")
            
            indeRow = dashBoardList.order
            let cell = tableView.dequeueReusableCell(withIdentifier: EventsIdentifier, for: indexPath)as! EventsTableViewCell
            
            cell.str = str
            cell.strName = strName
            for i in DefaultsKeys.MenuRefName{
                if i.menu_slug == "events"{
                    cell.is_read_enabled = String(i.is_read_enabled)
                    cell.is_write_enabled = String(i.is_write_enabled)
                }
            }
            cell.EventData = dashBoardList.Events
            if  EventData.count == 1 {
                
                cell.EventViewClick.isHidden = true
                
            }else{
                let EventView = UITapGestureRecognizer(target: self, action: #selector(EventViewVc))
                
                cell.EventViewClick.addGestureRecognizer(EventView)
                
            }
            return cell
            
        }
        
        
        else if dashBoardList.type == "Chat" {
            
            print("Chat......")
            
            indeRow = dashBoardList.order
            let cell = tableView.dequeueReusableCell(withIdentifier: chatIdentifier, for: indexPath)as! HomePageChatTableViewCell
            
            cell.strName = strName
            cell.str = str
            for i in DefaultsKeys.MenuRefName{
                if i.menu_slug == "chat"{
                    cell.is_read_enabled = String(i.is_read_enabled)
                    cell.is_write_enabled = String(i.is_write_enabled)
                }
            }
            cell.chatsData = dashBoardList.Chat
            
            let chats = UITapGestureRecognizer(target: self, action: #selector(chatViewVc))
            
            cell.chatViewAll.addGestureRecognizer(chats)
            
            return cell
            
        }
        
        
        else if dashBoardList.type == "Leave Request" {
            
            indeRow = dashBoardList.order
            
            print("HomeScreenLeaveRequestTableViewCell",LeaveeReq.count)
            
            print("HomeScreenLeaveRequestTableViewCell")
            
            let cell = tableView.dequeueReusableCell(withIdentifier: leaveRequestIdentifier, for: indexPath)as! HomeLeaveRequestTableViewCell
            
            cell.mainPresent = self
            cell.LeaveRequestData = dashBoardList.leaveRequest
            
            let leavess = UITapGestureRecognizer(target: self, action: #selector(LeaveViewsVc))
            
            cell.leaveView.addGestureRecognizer(leavess)
            
            return cell
            
        }
        
        else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: EventsIdentifier, for: indexPath)as! EventsTableViewCell
            print("Unknownnnnn")
            return cell
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let dashBoardLists : DashBoardData = dashBoardDataList[indexPath.row]
        
        var indeRow = indexPath.row + 1
        
        
        
        if dashBoardLists.type == "Ad"{
            indeRow = dashBoardLists.order
            //
            
            if AdvertismentData.count != 0{
                
                return 180
            }else{
                
                return 0
            }
            
        }
        
        else if dashBoardLists.type ==  "Emergency Notification" {
            
            indeRow = dashBoardLists.order
            
            if emerData.count == 0{
                
                
                return 0
                
                
            }
            
            else if emerData.count == 1{
                
                
                print("valTypee4r34wew4e",valType)
                if valType == "1" {
                    return 340
                }else if valType  == "0"{
                    return 180
                }
                
            }
            
            else if emerData.count == 2{
                
                return 300
                
            }
            
            else if emerData.count == 3 {
                
                var a = emerData.count * 20
                var b = a + 340
                
                var c = b
                
                return CGFloat(c)
            }
            
            else{
                
                var a = emerData.count * 20
                var b = a + 400
                
                var c = b
                
                return CGFloat(c)
            }
        }
        
        
        else if dashBoardLists.type == "Attendance"  {
            
            indeRow = dashBoardLists.order
            
            
            
            for i in dashBoardLists.attendanceSubData{
                
                if attendanceData.count == 0{
                    
                    return 0
                    
                }
                
                else if attendanceData.count == 1 {
                    return 200
                    
                    
                }
                else if attendanceData.count == 2 {
                    
                    return 400
                    
                }
                else if attendanceData.count == 3 {
                    
                    
                    return 580
                    
                }
                
                else{
                    
                    return 0
                    
                }
            }
        }
        
        else if dashBoardLists.type == "Assignments"  {
            
            indeRow = dashBoardLists.order
            
            
            if assignmentData.count != 0{
                
                
                return 280
            }
            
            else{
                
                
                return 0
            }
            
        }
        
        else if dashBoardLists.type == "Notice Board" {
            
            indeRow = dashBoardLists.order
            
            if noticeBoardData.count != 0 {
                
                
                return 285
            }
            
            else{
                
                return 0
            }
        }
        
        else if  dashBoardLists.type == "Circular"{
            
            indeRow = dashBoardLists.order
            
            if circularData.count != 0{
                
                
                return 280
            }
            
            else{
                
                return 0
            }
        }
        
        else if  dashBoardLists.type == "Recent Notifications" {
            
            indeRow = dashBoardLists.order
            
            
            
            if emerData.count == 0{
                
                
                
                return 0
                
                
            }
            
            else if RecentData.count == 1{
                
                return 200
            }
            
            else if RecentData.count == 2{
                
                return 300
                
            }
            
            else if RecentData.count == 3 {
                
                return 440
            }
            
            else{
                
                return 440
                
            }
            
        }
        
        
        else if  dashBoardLists.type == "Upcoming Events" {
            
            indeRow = dashBoardLists.order
            
            
            if EventData.count != 0{
                
                
                return 220
            }
            
            else{
                
                return 0
            }
            
        }
        
        else if  dashBoardLists.type == "Chat" {
            
            indeRow = dashBoardLists.order
            
            
            for i in dashBoardLists.Chat{
                
                if i.message == "No such record found!"{
                    
                    
                    return 100
                    
                    
                }
                
                
                else if i.studentname != nil{
                    
                    
                    return 400
                    
                }
                
                
                else{
                    
                    return 0
                    
                }
                
            }
            
        }
        
        
        
        else if  dashBoardLists.type == "Leave Request" {
            
            
            
            indeRow = dashBoardLists.order
            
            
            for i in dashBoardLists.leaveRequest{
                
                
                if i.message == "No such record found!"{
                    
                    
                    print("if 100")
                    return 100
                    
                    
                    
                    
                }
                
                
                else if i.leavestatus != nil{
                    
                    print("else if 380")
                    return 350
                    
                    
                    
                    
                }
                
                
                else{
                    
                    print("else 0")
                    return 0
                    
                    
                    
                }
                
                
            }
            
            
            
        }
        
        return 0
    }
    
    
    
    @IBAction func AssigmentViewAllVc(){
        
        if priority == "p4" {
            
            
            let vc =  AssigmentHomePageViewController(nibName: nil, bundle: nil)
            vc.str = str
            vc.strName = strName
            
            for i in DefaultsKeys.MenuRefName{
                if i.menu_slug == "assignment"{
                    vc.is_read_enabled = String(i.is_read_enabled)
                    vc.is_write_enabled = String(i.is_write_enabled)
                }
            }
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
        }else if priority == "p1" {
            
            let vc = SenderAssigmentHomePageViewController()
            
            vc.str = str
            vc.strName = strName
            for i in DefaultsKeys.MenuRefName{
                if i.menu_slug == "assignment"{
                    vc.is_read_enabled = String(i.is_read_enabled)
                    vc.is_write_enabled = String(i.is_write_enabled)
                }
            }
            
            vc.view.backgroundColor = UIColor(named: "Principal" )
            vc.assigmentSegmentName.backgroundColor = UIColor(named: "UnSelector")
            vc.assigmentSegmentName.selectedSegmentTintColor = UIColor(named: "Selector")
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
            
        }else if priority == "p7"  {
            
            let vc = SenderAssigmentHomePageViewController(nibName: nil, bundle: nil)
            
            vc.str = str
            vc.strName = strName
            for i in DefaultsKeys.MenuRefName{
                if i.menu_slug == "assignment"{
                    vc.is_read_enabled = String(i.is_read_enabled)
                    vc.is_write_enabled = String(i.is_write_enabled)
                }
            }
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            vc.assigmentSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.assigmentSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
        
        
        else if priority == "p3" ||  priority == "p2"  {
            
            let vc = SenderAssigmentHomePageViewController(nibName: nil, bundle: nil)
            
            vc.str = str
            vc.strName = strName
            for i in DefaultsKeys.MenuRefName{
                if i.menu_slug == "assignment"{
                    vc.is_read_enabled = String(i.is_read_enabled)
                    vc.is_write_enabled = String(i.is_write_enabled)
                }
            }
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            vc.assigmentSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.assigmentSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
        
        else if priority == "p5"{
            
            let vc =  AssigmentHomePageViewController(nibName: nil, bundle: nil)
            
            vc.str = str
            vc.strName = strName
            for i in DefaultsKeys.MenuRefName{
                if i.menu_slug == "assignment"{
                    vc.is_read_enabled = String(i.is_read_enabled)
                    vc.is_write_enabled = String(i.is_write_enabled)
                }
            }
            vc.assigmentSegmentName.backgroundColor = UIColor(named: "FatherUnselector")
            vc.assigmentSegmentName.selectedSegmentTintColor = UIColor(named: "FatherSelector")
            vc.view.backgroundColor = UIColor(named: "FatherColor" )
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
            
        }
        
        
        else if priority == "p6"{
            
            
            let vc = SenderAssigmentHomePageViewController(nibName: nil, bundle: nil)
           
            vc.str = str
            vc.strName = strName
            
            for i in DefaultsKeys.MenuRefName{
                if i.menu_slug == "assignment"{
                    vc.is_read_enabled = String(i.is_read_enabled)
                    vc.is_write_enabled = String(i.is_write_enabled)
                }
            }
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            vc.assigmentSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.assigmentSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
            
        }
        
    }
    
    
    @IBAction func EventViewVc(){
        
        if priority == "p4" {
            let vc =  EventsViewController(nibName: nil, bundle: nil)
            vc.str = str
            vc.strName = strName
            for i in DefaultsKeys.MenuRefName{
                if i.menu_slug == "events"{
                    vc.is_read_enabled = String(i.is_read_enabled)
                    vc.is_write_enabled = String(i.is_write_enabled)
                }
            }
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
        }
        
        else if priority == "p1" {
            
            let vc = SenderEventHomePageViewController(nibName: nil, bundle: nil)
            
           
            vc.str = str
            vc.strName = strName
            for i in DefaultsKeys.MenuRefName{
                if i.menu_slug == "events"{
                    vc.is_read_enabled = String(i.is_read_enabled)
                    vc.is_write_enabled = String(i.is_write_enabled)
                }
            }
            vc.view.backgroundColor = UIColor(named: "Principal" )
            vc.eventSegmentName.backgroundColor = UIColor(named: "UnSelector")
            vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "Selector")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
            
            
        }
        
        
        else if priority == "p3" ||  priority == "p2"  {
            
            let vc = SenderEventHomePageViewController(nibName: nil, bundle: nil)
           
            vc.str = str
            vc.strName = strName
            for i in DefaultsKeys.MenuRefName{
                if i.menu_slug == "events"{
                    vc.is_read_enabled = String(i.is_read_enabled)
                    vc.is_write_enabled = String(i.is_write_enabled)
                }
            }
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            vc.eventSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
        
        else if priority == "p7" {
            
            let vc = SenderEventHomePageViewController(nibName: nil, bundle: nil)
            
            vc.str = str
            vc.strName = strName
            for i in DefaultsKeys.MenuRefName{
                if i.menu_slug == "events"{
                    vc.is_read_enabled = String(i.is_read_enabled)
                    vc.is_write_enabled = String(i.is_write_enabled)
                }
            }
            vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
            vc.eventSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
        
        else if priority == "p5"{
            
            let vc =  EventsViewController(nibName: nil, bundle: nil)
            
            vc.str = str
            vc.strName = strName
            for i in DefaultsKeys.MenuRefName{
                if i.menu_slug == "events"{
                    vc.is_read_enabled = String(i.is_read_enabled)
                    vc.is_write_enabled = String(i.is_write_enabled)
                }
            }
            vc.eventSegmentName.backgroundColor = UIColor(named: "FatherUnselector")
            vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "FatherSelector")
            vc.view.backgroundColor = UIColor(named: "FatherColor" )
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
            
        }
        
        
        else if priority == "p6"{
            
            
            let vc = SenderEventHomePageViewController(nibName: nil, bundle: nil)
            
            vc.str = str
            vc.strName = strName
            for i in DefaultsKeys.MenuRefName{
                if i.menu_slug == "events"{
                    vc.is_read_enabled = String(i.is_read_enabled)
                    vc.is_write_enabled = String(i.is_write_enabled)
                }
            }
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            vc.eventSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
            
        }
        
    }
    
    
    @IBAction func AttendanceViewVc(){
        
        if priority == "p4" {
            let vc =  AttendanceViewController(nibName: nil, bundle: nil)
            vc.str = str
            vc.strName = strName
            for i in DefaultsKeys.MenuRefName{
                if i.menu_slug == "attendance"{
                    vc.is_read_enabled = String(i.is_read_enabled)
                    vc.is_write_enabled = String(i.is_write_enabled)
                }
            }
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
        }
        
        else if priority == "p1" {
            
            let vc = SenderAttendanceVcViewController(nibName: nil, bundle: nil)
            
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.view.backgroundColor = UIColor(named: "Principal" )
            vc.segmentName.backgroundColor = UIColor(named: "UnSelector")
            vc.segmentName.selectedSegmentTintColor = UIColor(named: "Selector")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
            
            
        }
        
        
        else if priority == "p7"  {
            
            let vc = SenderAttendanceVcViewController(nibName: nil, bundle: nil)
           
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
            vc.segmentName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.segmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
        
        
        else if priority == "p3" ||  priority == "p2"  {
            
            let vc = SenderAttendanceVcViewController(nibName: nil, bundle: nil)
            
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            vc.segmentName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.segmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
        
        else if priority == "p5"{
            
            let vc =  AttendanceViewController(nibName: nil, bundle: nil)
            
            vc.str = str
            vc.strName = strName
            for i in DefaultsKeys.MenuRefName{
                if i.menu_slug == "attendance"{
                    vc.is_read_enabled = String(i.is_read_enabled)
                    vc.is_write_enabled = String(i.is_write_enabled)
                }
            }
            vc.segmentName.backgroundColor = UIColor(named: "FatherUnselector")
            vc.segmentName.selectedSegmentTintColor = UIColor(named: "FatherSelector")
            vc.view.backgroundColor = UIColor(named: "FatherColor" )
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
            
        }
        
        
        else if priority == "p6"{
            
            let vc = SenderAttendanceVcViewController(nibName: nil, bundle: nil)
            
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            vc.segmentName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.segmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
            
        }
        
    }
    
    @IBAction func RecentNotificationVc(){
        
        if priority == "p4" {
            
            let vc =  CommunicationHomePageViewController(nibName: nil, bundle: nil)
            vc.str = str
            vc.strName = strName
            
            for i in DefaultsKeys.MenuRefName{
                if i.menu_slug == "voice"{
                    vc.is_read_enabled = String(i.is_read_enabled)
                    vc.is_write_enabled = String(i.is_write_enabled)
                }
            }
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
        
        else if priority == "p1" {
            
            let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
            
            vc.str = str
            vc.strName = strName
            
            for i in DefaultsKeys.MenuRefName{
                if i.menu_slug == "voice"{
                    vc.is_read_enabled = String(i.is_read_enabled)
                    vc.is_write_enabled = String(i.is_write_enabled)
                }
            }
            vc.view.backgroundColor = UIColor(named: "Principal" )
            vc.CommuniSegementName.backgroundColor = UIColor(named: "UnSelector")
            vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "Selector")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
            
            
        }
        
        
        else if priority == "p3" ||  priority == "p2"  {
            
            let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
           
            vc.str = str
            vc.strName = strName
            for i in DefaultsKeys.MenuRefName{
                if i.menu_slug == "voice"{
                    vc.is_read_enabled = String(i.is_read_enabled)
                    vc.is_write_enabled = String(i.is_write_enabled)
                }
            }
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
        
        else if priority == "p7" {
            
            let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
           
            vc.str = str
            vc.strName = strName
            for i in DefaultsKeys.MenuRefName{
                if i.menu_slug == "voice"{
                    vc.is_read_enabled = String(i.is_read_enabled)
                    vc.is_write_enabled = String(i.is_write_enabled)
                }
            }
            vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
            vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
        
        else if priority == "p5"{
            
            let vc =  CommunicationHomePageViewController(nibName: nil, bundle: nil)
           
            vc.str = str
            vc.strName = strName
            for i in DefaultsKeys.MenuRefName{
                if i.menu_slug == "voice"{
                    vc.is_read_enabled = String(i.is_read_enabled)
                    vc.is_write_enabled = String(i.is_write_enabled)
                }
            }
            vc.CommuniSegementName.backgroundColor = UIColor(named: "FatherUnselector")
            vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "FatherSelector")
            vc.view.backgroundColor = UIColor(named: "FatherColor" )
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
            
        }
        
        
        else if priority == "p6"{
            
            
            
            let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
            
            vc.str = str
            vc.strName = strName
            for i in DefaultsKeys.MenuRefName{
                if i.menu_slug == "voice"{
                    vc.is_read_enabled = String(i.is_read_enabled)
                    vc.is_write_enabled = String(i.is_write_enabled)
                }
            }
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
            
        }
        
        
        
    }
    
    
    @IBAction func viewVc(){
        
        if priority == "p4" {
            let vc =  NoticeBoardHomePageViewController(nibName: nil, bundle: nil)
            vc.str = str
            vc.strName = strName
            for i in DefaultsKeys.MenuRefName{
                if i.menu_slug == "notice_board"{
                    vc.is_read_enabled = String(i.is_read_enabled)
                    vc.is_write_enabled = String(i.is_write_enabled)
                }
            }
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
        }
        
        else if priority == "p1" {
            
            let vc = SenderGraditNoticeBoardMenuViewController(nibName: nil, bundle: nil)
            
            vc.str = str
            vc.strName = strName
            for i in DefaultsKeys.MenuRefName{
                if i.menu_slug == "notice_board"{
                    vc.is_read_enabled = String(i.is_read_enabled)
                    vc.is_write_enabled = String(i.is_write_enabled)
                }
            }
            vc.view.backgroundColor = UIColor(named: "Principal" )
            vc.noticeSegments.backgroundColor = UIColor(named: "UnSelector")
            vc.noticeSegments.selectedSegmentTintColor = UIColor(named: "Selector")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
        }
        
        
        else if priority == "p3" ||  priority == "p2"  {
            
            let vc = SenderGraditNoticeBoardMenuViewController(nibName: nil, bundle: nil)
           
            vc.str = str
            vc.strName = strName
            for i in DefaultsKeys.MenuRefName{
                if i.menu_slug == "notice_board"{
                    vc.is_read_enabled = String(i.is_read_enabled)
                    vc.is_write_enabled = String(i.is_write_enabled)
                }
            }
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            vc.noticeSegments.backgroundColor = UIColor(named: "HodUnSelector")
            vc.noticeSegments.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
        
        else if priority == "p7" {
            
            let vc = SenderGraditNoticeBoardMenuViewController(nibName: nil, bundle: nil)
           
            vc.str = str
            vc.strName = strName
            for i in DefaultsKeys.MenuRefName{
                if i.menu_slug == "notice_board"{
                    vc.is_read_enabled = String(i.is_read_enabled)
                    vc.is_write_enabled = String(i.is_write_enabled)
                }
            }
            vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
            vc.noticeSegments.backgroundColor = UIColor(named: "HodUnSelector")
            vc.noticeSegments.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
        
        
        else if priority == "p5"{
            
            let vc =  NoticeBoardHomePageViewController(nibName: nil, bundle: nil)
           
            vc.str = str
            vc.strName = strName
            for i in DefaultsKeys.MenuRefName{
                if i.menu_slug == "notice_board"{
                    vc.is_read_enabled = String(i.is_read_enabled)
                    vc.is_write_enabled = String(i.is_write_enabled)
                }
            }
            vc.noticeSegments.backgroundColor = UIColor(named: "FatherUnselector")
            vc.noticeSegments.selectedSegmentTintColor = UIColor(named: "FatherSelector")
            vc.view.backgroundColor = UIColor(named: "FatherColor" )
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
            
        }
        
        
        else if priority == "p6"{
            
            
            let vc = SenderGraditNoticeBoardMenuViewController(nibName: nil, bundle: nil)
            
            vc.str = str
            vc.strName = strName
            for i in DefaultsKeys.MenuRefName{
                if i.menu_slug == "notice_board"{
                    vc.is_read_enabled = String(i.is_read_enabled)
                    vc.is_write_enabled = String(i.is_write_enabled)
                }
            }
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            vc.noticeSegments.backgroundColor = UIColor(named: "HodUnSelector")
            vc.noticeSegments.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
        }
        
        
    }
    
    
    @IBAction func LeaveViewsVc(){
        
        
        
        
        
        if priority == "p1" {
            
            let vc =  SenderAttendanceVcViewController(nibName: nil, bundle: nil)
            
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.view.backgroundColor = UIColor(named: "Principal" )
            vc.segmentName.backgroundColor = UIColor(named: "UnSelector")
            vc.segmentName.selectedSegmentTintColor = UIColor(named: "Selector")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true,completion: nil)
            
            
        }
        
        
        else if priority == "p2" || priority == "p3" {
            
            
            let vc =  SenderAttendanceVcViewController(nibName: nil, bundle: nil)
            
            
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            vc.segmentName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.segmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true,completion: nil)
            
            
            
        }
        
        else if priority == "p7" {
            
            
            let vc =  SenderAttendanceVcViewController(nibName: nil, bundle: nil)
            
            
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
            vc.segmentName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.segmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true,completion: nil)
            
            
            
        }
        
        
        else if priority == "p6" {
            
            
            let vc =  SenderAttendanceVcViewController(nibName: nil, bundle: nil)
            
            
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            vc.segmentName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.segmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true,completion: nil)
            
            
            
        }
        
        
        
        else if priority == "p4" {
            
            
            let vc =  AttendanceViewController(nibName: nil, bundle: nil)
            
           
            vc.str = str
            vc.strName = strName
            
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            vc.segmentName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.segmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true,completion: nil)
            
            
            
        }
        
        
        
    }
    
    
    
    @IBAction func chatViewVc(){
        
        
        
        if priority == "p4" {
            
            let vc =  ChatHomePageViewController(nibName: nil, bundle: nil)
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true,completion: nil)
            
            
        }
        
        else if priority == "p1" {
            
            let vc =  ChatSenderViewController(nibName: nil, bundle: nil)
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true,completion: nil)
            
            
            
        }
        
        
        else if priority == "p2" || priority == "p3" {
            
            
            let vc =  ChatSenderViewController(nibName: nil, bundle: nil)
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true,completion: nil)
            
            
            
        }
        
        
        else if priority == "p7"  {
            
            
            let vc =  ChatSenderViewController(nibName: nil, bundle: nil)
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true,completion: nil)
            
            
            
        }
        
        
        else if  priority == "p5"{
            
            
            let vc =  ChatHomePageViewController(nibName: nil, bundle: nil)
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true,completion: nil)
            
            
            
        }
        
        
        
        else if priority == "p6"{
            
            
            let vc =  ChatSenderViewController(nibName: nil, bundle: nil)
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true,completion: nil)
            
            
            
        }
        
        
        
    }
    
    
    @IBAction func circularViewVc(){
        
        if priority == "p4" {
            let vc =  ImageViewController (nibName: nil, bundle: nil)
            vc.str = str
            vc.strName = strName
            for i in DefaultsKeys.MenuRefName{
                if i.menu_slug == "circular"{
                    vc.is_read_enabled = String(i.is_read_enabled)
                    vc.is_write_enabled = String(i.is_write_enabled)
                }
            }
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
            
        }
        
        else if priority == "p1" {
            
            let vc = SenderImagePdfHomePageViewController(nibName: nil, bundle: nil)
            
            vc.str = str
            vc.strName = strName
            for i in DefaultsKeys.MenuRefName{
                if i.menu_slug == "circular"{
                    vc.is_read_enabled = String(i.is_read_enabled)
                    vc.is_write_enabled = String(i.is_write_enabled)
                }
            }
            vc.view.backgroundColor = UIColor(named: "Principal" )
            vc.imageSegmentName.backgroundColor = UIColor(named: "UnSelector")
            vc.imageSegmentName.selectedSegmentTintColor = UIColor(named: "Selector")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
            
            
        }
        
        
        else if priority == "p3" ||  priority == "p2"{
            
            let vc = SenderImagePdfHomePageViewController(nibName: nil, bundle: nil)
            
            vc.str = str
            vc.strName = strName
            for i in DefaultsKeys.MenuRefName{
                if i.menu_slug == "circular"{
                    vc.is_read_enabled = String(i.is_read_enabled)
                    vc.is_write_enabled = String(i.is_write_enabled)
                }
            }
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            vc.imageSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.imageSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
        
        
        else if priority == "p7" {
            
            let vc = SenderImagePdfHomePageViewController(nibName: nil, bundle: nil)
           
            vc.str = str
            vc.strName = strName
            for i in DefaultsKeys.MenuRefName{
                if i.menu_slug == "circular"{
                    vc.is_read_enabled = String(i.is_read_enabled)
                    vc.is_write_enabled = String(i.is_write_enabled)
                }
            }
            vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
            vc.imageSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.imageSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
        
        
        
        else if priority == "p5"{
            
            let vc =  ImageViewController (nibName: nil, bundle: nil)
           
            vc.str = str
            vc.strName = strName
            for i in DefaultsKeys.MenuRefName{
                if i.menu_slug == "circular"{
                    vc.is_read_enabled = String(i.is_read_enabled)
                    vc.is_write_enabled = String(i.is_write_enabled)
                }
            }
            vc.imageSegmentName.backgroundColor = UIColor(named: "FatherUnselector")
            vc.imageSegmentName.selectedSegmentTintColor = UIColor(named: "FatherSelector")
            vc.view.backgroundColor = UIColor(named: "FatherColor" )
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
            
            
        }
        
        else if priority == "p6"{
            
            
            let vc = SenderImagePdfHomePageViewController(nibName: nil, bundle: nil)
            
            vc.str = str
            vc.strName = strName
            for i in DefaultsKeys.MenuRefName{
                if i.menu_slug == "circular"{
                    vc.is_read_enabled = String(i.is_read_enabled)
                    vc.is_write_enabled = String(i.is_write_enabled)
                }
            }
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            vc.imageSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.imageSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
            
        }
        
        
    }
    
    
    
    
    
    @IBAction func adLoad(gesture : HomeViewGesture) {
        
        
        
        let vc = HomePageAddViewController(nibName: nil, bundle: nil)
        vc.AddWebUrl = gesture.url
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
        
        
    }
    
    
    // tap bar Nivigation.
    
    @IBAction func changePassowrdVC(){
        
        let vc = ChangePasswordViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true, completion: nil)
        
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
    
    @IBAction func resumeBuilderRedirect(){
        
        let vc = ResumeVC(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
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
    
    @IBAction func refreshVc() {
        
        dashBoardList()
        
    }
    
    
    @IBAction func loginRedirect() {
        
        
        let vc = LoginViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
        
    }
    
    @IBAction func priorityVc() {
           
           let vc = PriorityViewController(nibName: nil, bundle: nil)
           vc.modalPresentationStyle = .fullScreen
           present(vc, animated: true,completion: nil)
       }
    
    @IBAction func helpRedirect() {
        
        let vc = HelpViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
        
    }
    
    
    
    
    @IBAction func profileRedirect() {
        
        let vc = ProfileViewController(nibName: nil, bundle: nil)
        vc.str = str
        vc.strName = strName
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
    
    @IBAction func menuHide() {
        
        
        sideMenuView.isHidden = true
        
    }
    
    
    @IBAction func notificationVc() {
        
        let vc = NotificationViewController(nibName: nil, bundle: nil)
        vc.str = str
        vc.strName = strName
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
        
    }
    
    
    
    @IBAction func termsAndCondition() {
        
        let vc = MenuTermsViewController(nibName: nil, bundle: nil)
        
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
    }
    
    
    
    
    @IBAction func clearCheaseVc() {
        
        let caches = (NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0])
        let appId = Bundle.main.infoDictionary!["CFBundleIdentifier"] as! String
        let path = String(format:"%@/%@/Cache.db-wal",caches, appId)
        do {
            try FileManager.default.removeItem(atPath: path)
            
            SweetAlert().showAlert("",subTitle: "Successfully Cache Cleared",style: .none,buttonTitle: "OK",buttonColor:.systemGray)
        } catch {
            
            SweetAlert().showAlert("",subTitle: "Already Cache Cleared",style: .none,buttonTitle: "OK",buttonColor:.systemGray)
            print("ERROR DESCRIPTION: \(error)")
        }
        
        
        
        
    }
    
    
    
    
    class HomeViewGesture : UITapGestureRecognizer {
        
        
        var url : String!
    }
    
}


