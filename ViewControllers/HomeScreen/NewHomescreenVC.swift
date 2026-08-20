//
//  NewHomescreenVC.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 30/07/26.
//

import UIKit

@available(iOS 16.0, *)
class NewHomescreenVC: UIViewController {
    
    @IBOutlet weak var tv: UITableView!
    @IBOutlet weak var topNameview: UIView!
    @IBOutlet weak var tapBarView: UIViewX!
    @IBOutlet weak var loadingCustom: UIActivityIndicatorView!
    @IBOutlet weak var UserNameLabels: UILabel!
    @IBOutlet weak var PersonIconView: UIView!
    @IBOutlet weak var RoleNameLabel: UILabel!
    @IBOutlet weak var LogoImageBaseview: UIViewX!
    @IBOutlet weak var clgLogoImg: UIImageView!
    @IBOutlet weak var sideMenuView: UIView!
    @IBOutlet weak var profileBtn: UIButton!
    @IBOutlet weak var clearCacheBtn: UIButton!
    
    var memberName : String!
    var colgImg : String!
    var colgId : String!
    var memberId : String!
    var priority : String!
    var MobileNumber : String!
    let advertisementIdentifier = "HomeTableViewCell"
    let emergencyIdentifier = "BannerCell"
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
    let Subidentifier = "EmerTableViewCell"
    let MenuTVCellIdentifier = "MenuTVCell"
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
    var LeaveeReq : [LeaveRequestType] = []
    var str : [String] = []
    var strName : [String] = []
    var MenuRefName :[menuApiDataDetails] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInitialUI()
        loadUserDefaults()
        configureUIForPriority()
        registerTableViewCells()
        getDeviceToken()
        loadDashboardAndMenu()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        AudioPlayerManager.shared.stop()
    }
    
    private func setupInitialUI() {
        
        loadingCustom.startAnimating()
        sideMenuView.isHidden = true
        
        let topnameview = UITapGestureRecognizer(target: self, action: #selector(ChangeRoleBtnAct))
        topNameview.addGestureRecognizer(topnameview)
        
        let showSideMenuTap = UITapGestureRecognizer(target: self, action: #selector(showSideMenu))
        PersonIconView.addGestureRecognizer(showSideMenuTap)
        
    }
    
    private func loadUserDefaults() {
        
        let defaults = UserDefaults.standard
        
        colgImg = defaults.string(forKey: DefaultsKeys.colglogo)
        memberName = defaults.string(forKey: DefaultsKeys.memberName)
        colgId = defaults.string(forKey: DefaultsKeys.collegeid)
        memberId = defaults.string(forKey: DefaultsKeys.memberid)
        priority = defaults.string(forKey: DefaultsKeys.priority)
        MobileNumber = defaults.string(forKey: DefaultsKeys.mobileNumber)
        
        UserNameLabels.text = memberName
        
        if colgImg != "" {
            
            clgLogoImg.sd_setImage(
                with: URL(string: colgImg),
                placeholderImage: UIImage(named: "EmptyCollegeIcon")
            )
            
        } else {
            
            clgLogoImg.image = UIImage(named: "EmptyCollegeIcon")
        }
    }
    
    private func configureUIForPriority() {
        
        switch priority {
            
        case "p1":
            tapBarView.backgroundColor = UIColor(named: "Principal")
            view.backgroundColor = UIColor(named: "Principal")
            RoleNameLabel.text = "Principal"
            profileBtn.isHidden = true
            clearCacheBtn.isHidden = true
            
        case "p2":
            tapBarView.backgroundColor = UIColor(named: "Teaching Staff")
            view.backgroundColor = UIColor(named: "Teaching Staff")
            RoleNameLabel.text = "Hod"
            profileBtn.isHidden = true
            clearCacheBtn.isHidden = true
            
        case "p3":
            tapBarView.backgroundColor = UIColor(named: "Teaching Staff")
            view.backgroundColor = UIColor(named: "Teaching Staff")
            RoleNameLabel.text = "Teacher"
            profileBtn.isHidden = true
            clearCacheBtn.isHidden = true
            
        case "p4":
            tapBarView.backgroundColor = UIColor(named: "StudentParent")
            view.backgroundColor = UIColor(named: "studentViewColors")
            RoleNameLabel.text = "Student"
            profileBtn.isHidden = false
            clearCacheBtn.isHidden = true
            
        case "p5":
            tapBarView.backgroundColor = UIColor(named: "FatherColor")
            view.backgroundColor = UIColor(named: "FatherColor")
            RoleNameLabel.text = "Father"
            profileBtn.isHidden = false
            clearCacheBtn.isHidden = true
            
        case "p6":
            tapBarView.backgroundColor = UIColor(named: "Teaching Staff")
            view.backgroundColor = UIColor(named: "Teaching Staff")
            RoleNameLabel.text = "NonTeachingStaff"
            profileBtn.isHidden = true
            clearCacheBtn.isHidden = true
            
        case "p7":
            tapBarView.backgroundColor = UIColor(named: "univercityColorCod")
            view.backgroundColor = UIColor(named: "univercityColorCod")
            RoleNameLabel.text = "UnivesityHead"
            profileBtn.isHidden = true
            clearCacheBtn.isHidden = true
            
        default:
            break
        }
    }
    
    private func registerTableViewCells() {
        
        registerNib(advertisementIdentifier)
        registerNib(assignmentListIdentifier)
        registerNib(chatIdentifier)
        registerNib(leaveRequestIdentifier)
        registerNib(CircularIdentifier)
        registerNib(noticeBoardIdentifier)
        registerNib(emergencyIdentifier)
        registerNib(imagePdfIdentifier)
        registerNib(Subidentifier)
        registerNib(recentNotificationIdentifier)
        registerNib(EventsIdentifier)
        registerNib(attendanceIdentifier)
        registerNib(MenuTVCellIdentifier)
        
        tv.delegate = self
        tv.dataSource = self
    }
    
    private func registerNib(_ name: String) {
        
        let nib = UINib(nibName: name, bundle: nil)
        tv.register(nib, forCellReuseIdentifier: name)
    }
    
    
    //MARK: Api call functions
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
    
    
    func loadDashboardAndMenu() {
        loadingCustom.startAnimating()
        let group = DispatchGroup()
        
        // Dashboard API
        group.enter()
        dashBoardList { [weak self] in
            group.leave()
        }
        
        // Menu API
        group.enter()
        MenuIdList { [weak self] in
            group.leave()
        }
        
        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.loadingCustom.stopAnimating()
            self.loadingCustom.isHidden = true
            
            // Insert MenuList at index 1
            if let menuDashData = self.createMenuDashData() {
                self.dashBoardDataList.insert(menuDashData, at: 1)
            }
            
            self.tv.reloadData()
        }
    }
    
    
    func dashBoardList(completion: @escaping() -> Void) {
        
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
            defer { completion() }
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
                    
                }))
                
                present(refreshAlert, animated: true, completion: nil)
            }
            
            tv.reloadData()
            
        }
    }
    
    func MenuIdList(completion: @escaping () -> Void) {
        
        var Menu = menuApiIdModal ()
        Menu.college_id = colgId
        Menu.priority = priority
        Menu.user_id = memberId
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.GetParentUserMenuWithReadWriteAccess,
            httpMethod: .post,
            queryParam: nil,
            requestBody: Menu
        ) {[weak self] (result:Result<menuApiIdResponce, Error>) in
            defer { completion() }
            guard let self = self else {return}
            
            switch result {
            case .success(let success):
                
                if success.Status == 1 {
                    
                    MenuRefName = success.data
                    MenuRefName.removeAll { menuApiDataDetails in
                        menuApiDataDetails.menu_slug == "home"
                    }
                    DefaultsKeys.MenuRefName = MenuRefName
                    
                    for i in MenuRefName{
                        str.append(i.menu_slug)
                        strName.append(i.menu_name)
                    }
                }
                
            case .failure(let failure):
                print("Error:",failure.localizedDescription)
            }
        }
    }
    
    // ✅ Helper to build DashBoardData for MenuList
    private func createMenuDashData() -> DashBoardData? {
        guard !MenuRefName.isEmpty else { return nil }
        
        return DashBoardData(
            type: "MenuList",
            order: 0,
            data: MenuRefName.map { menu in
                [
                    "menu_id": AnyCodable(menu.menu_id),
                    "menu_name": AnyCodable(menu.menu_name),
                    "menu_slug": AnyCodable(menu.menu_slug),
                    "order_id": AnyCodable(menu.order_id),
                    "parent_id": AnyCodable(menu.parent_id),
                    "is_read_enabled": AnyCodable(menu.is_read_enabled),
                    "is_write_enabled": AnyCodable(menu.is_write_enabled)
                ]
            }
        )
    }
    
    //MARK: Button Actions
    
    @IBAction func refreshBtnAct(_ sender: UIButton) {
        loadDashboardAndMenu()
    }
    
    @IBAction func NotificationBtnAct(_ sender: UIButton) {
        let vc = NotificationViewController(nibName: nil, bundle: nil)
        vc.str = str
        vc.strName = strName
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
    }
    
    @IBAction func showSideMenu(_ sender: Any) {
        sideMenuView.isHidden.toggle()
    }
    
    @IBAction func ChangeRoleBtnAct(_ sender: UIButton) {
        
        let vc = PriorityViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
    }
    
    @IBAction func profileBtnAct(_ sender: UIButton) {
        let vc = ProfileViewController(nibName: nil, bundle: nil)
        vc.str = str
        vc.strName = strName
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func FaqBtnAct(_ sender: UIButton) {
        let vc = FaqViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func ClearCacheBtnAct(_ sender: UIButton) {
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
    
    @IBAction func HelpBtnAct(_ sender: UIButton) {
        let vc = HelpViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func PrivacyPolicyBtnAct(_ sender: UIButton) {
        let vc = PrivacyPolicyViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func TermsAndConditionsBtnAct(_ sender: UIButton) {
        let vc = MenuTermsViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func ChangePasswordBtnAct(_ sender: UIButton) {
        let vc = ChangePasswordViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func LogoutBtnAct(_ sender: UIButton) {
        
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
}

@available(iOS 16.0, *)
extension NewHomescreenVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dashBoardDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        tv.allowsSelection = false
        
        let dashBoardList: DashBoardData = dashBoardDataList[indexPath.row]
        
        switch dashBoardList.type {
        case "Ad":
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: advertisementIdentifier, for: indexPath) as? HomeTableViewCell else {
                return UITableViewCell()
            }
            
            for i in dashBoardList.dashSubData {
                cell.bigImg.sd_setImage(with: URL(string: i.background_image ?? ""), placeholderImage: UIImage(named: "ic_white"))
                cell.smallImg.sd_setImage(with: URL(string: i.add_image ?? ""), placeholderImage: UIImage(named: "ic_white"))
                
                let loadGesture = HomeViewGesture(target: self, action: #selector(adLoad))
                loadGesture.url = i.add_url
                cell.adView.addGestureRecognizer(loadGesture)
            }
            
            return cell
            
            
        case "MenuList":
            
            guard let cell = tv.dequeueReusableCell(withIdentifier: "MenuTVCell", for: indexPath) as? MenuTVCell else {
                return UITableViewCell()
            }
            
            cell.configure(with: MenuRefName)
            //cell.menuList = MenuRefName
            
            return cell
            
        case "Emergency Notification":
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: emergencyIdentifier, for: indexPath) as? BannerCell else {
                return UITableViewCell()
            }
            
            cell.configure(Data: dashBoardList.emerSubData)
            cell.onViewAll = { [weak self] in
                self?.RecentNotificationVc()
            }
            return cell
            
        case "Attendance":
            guard let cell = tableView.dequeueReusableCell(withIdentifier: attendanceIdentifier, for: indexPath) as? AttandanceTableViewCell else {
                return UITableViewCell()
            }
            
            cell.attend = dashBoardList.attendanceSubData
            
            let viewClick = UITapGestureRecognizer(target: self, action: #selector(AttendanceViewVc))
            cell.viewAllClick.addGestureRecognizer(viewClick)
            
            return cell
            
        case "Assignments":
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: assignmentListIdentifier, for: indexPath) as? AssignmentTableviewCel else {
                return UITableViewCell()
            }
            
            cell.strName = strName
            cell.str = str
            
            for i in DefaultsKeys.MenuRefName {
                if i.menu_slug == "assignment" {
                    cell.is_read_enabled = String(i.is_read_enabled)
                    cell.is_write_enabled = String(i.is_write_enabled)
                }
            }
            
            cell.assignmentDatas = dashBoardList.assigment
            
            let assigmentViewAll = UITapGestureRecognizer(target: self, action: #selector(AssigmentViewAllVc))
            cell.viewAll.addGestureRecognizer(assigmentViewAll)
            
            return cell
            
        case "Notice Board":
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: noticeBoardIdentifier, for: indexPath) as? NoticeBoardTableViewCell else {
                return UITableViewCell()
            }
            
            cell.strName = strName
            cell.str = str
            
            for i in DefaultsKeys.MenuRefName {
                if i.menu_slug == "notice_board" {
                    cell.is_read_enabled = String(i.is_read_enabled)
                    cell.is_write_enabled = String(i.is_write_enabled)
                }
            }
            
            cell.noticeBoardData = dashBoardList.noticeSubData
            
            let viewClick = UITapGestureRecognizer(target: self, action: #selector(viewVc))
            cell.noticeView.addGestureRecognizer(viewClick)
            
            return cell
            
        case "Circular":
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CircularIdentifier, for: indexPath) as? CircularTableViewCell else {
                return UITableViewCell()
            }
            
            cell.strName = strName
            cell.str = str
            
            for i in DefaultsKeys.MenuRefName {
                if i.menu_slug == "circular" {
                    cell.is_read_enabled = String(i.is_read_enabled)
                    cell.is_write_enabled = String(i.is_write_enabled)
                }
            }
            
            cell.circularData = dashBoardList.circular
            
            let circularViewClick = UITapGestureRecognizer(target: self, action: #selector(circularViewVc))
            cell.circularView.addGestureRecognizer(circularViewClick)
            
            return cell
            
        case "Recent Notifications":
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: recentNotificationIdentifier, for: indexPath) as? RecentNotificationTableViewCell else {
                return UITableViewCell()
            }
            
            cell.RecentDatas = dashBoardList.recentNotificationSubData
            let recentTap = UITapGestureRecognizer(target: self, action: #selector(RecentNotificationVc))
            cell.ViewClick.addGestureRecognizer(recentTap)
            
            return cell
            
        case "Upcoming Events":
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EventsIdentifier, for: indexPath) as? EventsTableViewCell else {
                return UITableViewCell()
            }
            
            cell.str = str
            cell.strName = strName
            
            for i in DefaultsKeys.MenuRefName {
                if i.menu_slug == "events" {
                    cell.is_read_enabled = String(i.is_read_enabled)
                    cell.is_write_enabled = String(i.is_write_enabled)
                }
            }
            
            cell.EventData = dashBoardList.Events
            
            let EventView = UITapGestureRecognizer(target: self, action: #selector(EventViewVc))
            cell.EventViewClick.addGestureRecognizer(EventView)
            
            return cell
            
        case "Chat":
            guard let cell = tableView.dequeueReusableCell(withIdentifier: chatIdentifier, for: indexPath) as? HomePageChatTableViewCell else {
                return UITableViewCell()
            }
            
            cell.strName = strName
            cell.str = str
            
            for i in DefaultsKeys.MenuRefName {
                if i.menu_slug == "chat" {
                    cell.is_read_enabled = String(i.is_read_enabled)
                    cell.is_write_enabled = String(i.is_write_enabled)
                }
            }
            
            cell.chatsData = dashBoardList.Chat
            
            let chats = UITapGestureRecognizer(target: self, action: #selector(chatViewVc))
            cell.chatViewAll.addGestureRecognizer(chats)
            
            return cell
            
        case "Leave Request":
            guard let cell = tableView.dequeueReusableCell(withIdentifier: leaveRequestIdentifier, for: indexPath) as? HomeLeaveRequestTableViewCell else {
                return UITableViewCell()
            }
            
            cell.mainPresent = self
            cell.LeaveRequestData = dashBoardList.leaveRequest
            
            let leavess = UITapGestureRecognizer(target: self, action: #selector(LeaveViewsVc))
            cell.leaveView.addGestureRecognizer(leavess)
            
            return cell
            
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EventsIdentifier, for: indexPath) as? EventsTableViewCell else {
                return UITableViewCell()
            }
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let dashBoardList = dashBoardDataList[indexPath.row]
        
        switch dashBoardList.type {
        case "Ad":
            return assignmentData.isEmpty ? 0 : 180
            
        case "MenuList":
            return MenuRefName.count < 9 ? 250 : 370
            
        case "Emergency Notification":
            return 290
            
        case "Attendance":
            return CGFloat(200 * attendanceData.count)
            
        case "Assignments":
            return assignmentData.isEmpty ? 0 : 280
            
        case "Notice Board":
            return noticeBoardData.isEmpty ? 0 : 285
            
        case "Circular":
            return circularData.isEmpty ? 0 : 280
            
        case "Recent Notifications":
            switch RecentData.count {
            case 0: return 0
            case 1: return 200
            case 2: return 300
            case 3: return 440
            default: return 440
            }
            
        case "Upcoming Events":
            return EventData.isEmpty ? 0 : 220
            
        case "Chat":
            for chat in dashBoardList.Chat {
                if chat.message == "No such record found!" {
                    return 100
                } else if chat.studentname != nil {
                    return 400
                }
            }
            return 0
            
        case "Leave Request":
            for request in dashBoardList.leaveRequest {
                if request.message == "No such record found!" {
                    return 100
                } else if request.leavestatus != nil {
                    return 350
                }
            }
            return 0
            
        default:
            return 0
        }
    }
    
    @IBAction func AssigmentViewAllVc(){
        
        var is_read_enabled = ""
        var is_write_enabled = ""
        
        if let menu = DefaultsKeys.MenuRefName.first(where: { $0.menu_slug == "assignment" }) {
            is_read_enabled = String(menu.is_read_enabled)
            is_write_enabled = String(menu.is_write_enabled)
        }
        
        switch priority {
            
        case "p4":
            let vc =  AssigmentHomePageViewController(nibName: nil, bundle: nil)
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
        case "p1":
            let vc = SenderAssigmentHomePageViewController()
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.view.backgroundColor = UIColor(named: "Principal" )
            vc.assigmentSegmentName.backgroundColor = UIColor(named: "UnSelector")
            vc.assigmentSegmentName.selectedSegmentTintColor = UIColor(named: "Selector")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
            
        case "p7":
            let vc = SenderAssigmentHomePageViewController(nibName: nil, bundle: nil)
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            vc.assigmentSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.assigmentSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
        case "p3","p2","p6":
            let vc = SenderAssigmentHomePageViewController(nibName: nil, bundle: nil)
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            vc.assigmentSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.assigmentSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
        case "p5":
            let vc =  AssigmentHomePageViewController(nibName: nil, bundle: nil)
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.assigmentSegmentName.backgroundColor = UIColor(named: "FatherUnselector")
            vc.assigmentSegmentName.selectedSegmentTintColor = UIColor(named: "FatherSelector")
            vc.view.backgroundColor = UIColor(named: "FatherColor" )
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
        default :
            break
        }
    }
    
    @IBAction func EventViewVc() {
        
        var is_read_enabled = ""
        var is_write_enabled = ""
        
        if let menu = DefaultsKeys.MenuRefName.first(where: { $0.menu_slug == "events" }) {
            is_read_enabled = String(menu.is_read_enabled)
            is_write_enabled = String(menu.is_write_enabled)
        }
        
        switch priority {
            
        case "p4":
            let vc = EventsViewController(nibName: nil, bundle: nil)
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
        case "p1":
            let vc = SenderEventHomePageViewController(nibName: nil, bundle: nil)
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.view.backgroundColor = UIColor(named: "Principal")
            vc.eventSegmentName.backgroundColor = UIColor(named: "UnSelector")
            vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "Selector")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
            
        case "p2", "p3", "p6":
            let vc = SenderEventHomePageViewController(nibName: nil, bundle: nil)
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.view.backgroundColor = UIColor(named: "Teaching Staff")
            vc.eventSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
        case "p7":
            let vc = SenderEventHomePageViewController(nibName: nil, bundle: nil)
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.view.backgroundColor = UIColor(named: "univercityColorCod")
            vc.eventSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
        case "p5":
            let vc = EventsViewController(nibName: nil, bundle: nil)
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.eventSegmentName.backgroundColor = UIColor(named: "FatherUnselector")
            vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "FatherSelector")
            vc.view.backgroundColor = UIColor(named: "FatherColor")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
        default:
            break
        }
    }
    
    @IBAction func AttendanceViewVc() {
        
        var is_read_enabled = ""
        var is_write_enabled = ""
        
        if let menu = DefaultsKeys.MenuRefName.first(where: { $0.menu_slug == "attendance" }) {
            is_read_enabled = String(menu.is_read_enabled)
            is_write_enabled = String(menu.is_write_enabled)
        }
        
        switch priority {
            
        case "p4":
            let vc = AttendanceViewController(nibName: nil, bundle: nil)
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
        case "p1":
            let vc = SenderAttendanceVcViewController(nibName: nil, bundle: nil)
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.view.backgroundColor = UIColor(named: "Principal")
            vc.segmentName.backgroundColor = UIColor(named: "UnSelector")
            vc.segmentName.selectedSegmentTintColor = UIColor(named: "Selector")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
            
        case "p7":
            let vc = SenderAttendanceVcViewController(nibName: nil, bundle: nil)
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.view.backgroundColor = UIColor(named: "univercityColorCod")
            vc.segmentName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.segmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
        case "p2", "p3", "p6":
            let vc = SenderAttendanceVcViewController(nibName: nil, bundle: nil)
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.view.backgroundColor = UIColor(named: "Teaching Staff")
            vc.segmentName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.segmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
        case "p5":
            let vc = AttendanceViewController(nibName: nil, bundle: nil)
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.segmentName.backgroundColor = UIColor(named: "FatherUnselector")
            vc.segmentName.selectedSegmentTintColor = UIColor(named: "FatherSelector")
            vc.view.backgroundColor = UIColor(named: "FatherColor")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
        default:
            break
        }
    }
    
    @IBAction func RecentNotificationVc() {
        
        var is_read_enabled = ""
        var is_write_enabled = ""
        
        if let menu = DefaultsKeys.MenuRefName.first(where: { $0.menu_slug == "voice" }) {
            is_read_enabled = String(menu.is_read_enabled)
            is_write_enabled = String(menu.is_write_enabled)
        }
        
        switch priority {
            
        case "p4":
            let vc = CommunicationHomePageViewController(nibName: nil, bundle: nil)
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
        case "p1":
            let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.view.backgroundColor = UIColor(named: "Principal")
            vc.CommuniSegementName.backgroundColor = UIColor(named: "UnSelector")
            vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "Selector")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
            
        case "p7":
            let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.view.backgroundColor = UIColor(named: "univercityColorCod")
            vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
        case "p2", "p3", "p6":
            let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.view.backgroundColor = UIColor(named: "Teaching Staff")
            vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
        case "p5":
            let vc = CommunicationHomePageViewController(nibName: nil, bundle: nil)
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.CommuniSegementName.backgroundColor = UIColor(named: "FatherUnselector")
            vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "FatherSelector")
            vc.view.backgroundColor = UIColor(named: "FatherColor")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
        default:
            break
        }
    }
    
    @IBAction func viewVc() {
        
        var is_read_enabled = ""
        var is_write_enabled = ""
        
        if let menu = DefaultsKeys.MenuRefName.first(where: { $0.menu_slug == "notice_board" }) {
            is_read_enabled = String(menu.is_read_enabled)
            is_write_enabled = String(menu.is_write_enabled)
        }
        
        switch priority {
            
        case "p4":
            let vc = NoticeBoardHomePageViewController(nibName: nil, bundle: nil)
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
        case "p1":
            let vc = SenderGraditNoticeBoardMenuViewController(nibName: nil, bundle: nil)
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.view.backgroundColor = UIColor(named: "Principal")
            vc.noticeSegments.backgroundColor = UIColor(named: "UnSelector")
            vc.noticeSegments.selectedSegmentTintColor = UIColor(named: "Selector")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
            
        case "p7":
            let vc = SenderGraditNoticeBoardMenuViewController(nibName: nil, bundle: nil)
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.view.backgroundColor = UIColor(named: "univercityColorCod")
            vc.noticeSegments.backgroundColor = UIColor(named: "HodUnSelector")
            vc.noticeSegments.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
        case "p2", "p3", "p6":
            let vc = SenderGraditNoticeBoardMenuViewController(nibName: nil, bundle: nil)
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.view.backgroundColor = UIColor(named: "Teaching Staff")
            vc.noticeSegments.backgroundColor = UIColor(named: "HodUnSelector")
            vc.noticeSegments.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
        case "p5":
            let vc = NoticeBoardHomePageViewController(nibName: nil, bundle: nil)
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.noticeSegments.backgroundColor = UIColor(named: "FatherUnselector")
            vc.noticeSegments.selectedSegmentTintColor = UIColor(named: "FatherSelector")
            vc.view.backgroundColor = UIColor(named: "FatherColor")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
        default:
            break
        }
    }
    
    @IBAction func LeaveViewsVc() {
        
        var is_read_enabled = ""
        var is_write_enabled = ""
        
        if let menu = DefaultsKeys.MenuRefName.first(where: { $0.menu_slug == "attendance" }) {
            is_read_enabled = String(menu.is_read_enabled)
            is_write_enabled = String(menu.is_write_enabled)
        }
        
        switch priority {
            
        case "p1":
            let vc = SenderAttendanceVcViewController(nibName: nil, bundle: nil)
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.view.backgroundColor = UIColor(named: "Principal")
            vc.segmentName.backgroundColor = UIColor(named: "UnSelector")
            vc.segmentName.selectedSegmentTintColor = UIColor(named: "Selector")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
        case "p2", "p3", "p6":
            let vc = SenderAttendanceVcViewController(nibName: nil, bundle: nil)
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.view.backgroundColor = UIColor(named: "Teaching Staff")
            vc.segmentName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.segmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
        case "p7":
            let vc = SenderAttendanceVcViewController(nibName: nil, bundle: nil)
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.view.backgroundColor = UIColor(named: "univercityColorCod")
            vc.segmentName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.segmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
        case "p4":
            let vc = AttendanceViewController(nibName: nil, bundle: nil)
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.view.backgroundColor = UIColor(named: "Teaching Staff")
            vc.segmentName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.segmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
        default:
            break
        }
    }
    
    @IBAction func chatViewVc() {
        
        var is_read_enabled = ""
        var is_write_enabled = ""
        
        if let menu = DefaultsKeys.MenuRefName.first(where: { $0.menu_slug == "chat" }) {
            is_read_enabled = String(menu.is_read_enabled)
            is_write_enabled = String(menu.is_write_enabled)
        }
        
        switch priority {
            
        case "p4", "p5":
            let vc = ChatHomePageViewController(nibName: nil, bundle: nil)
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
        case "p1", "p2", "p3", "p6", "p7":
            let vc = ChatSenderViewController(nibName: nil, bundle: nil)
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
        default:
            break
        }
    }
    
    @IBAction func circularViewVc() {
        
        var is_read_enabled = ""
        var is_write_enabled = ""
        
        if let menu = DefaultsKeys.MenuRefName.first(where: { $0.menu_slug == "circular" }) {
            is_read_enabled = String(menu.is_read_enabled)
            is_write_enabled = String(menu.is_write_enabled)
        }
        
        switch priority {
            
        case "p4":
            let vc = ImageViewController(nibName: nil, bundle: nil)
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
        case "p1":
            let vc = SenderImagePdfHomePageViewController(nibName: nil, bundle: nil)
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.view.backgroundColor = UIColor(named: "Principal")
            vc.imageSegmentName.backgroundColor = UIColor(named: "UnSelector")
            vc.imageSegmentName.selectedSegmentTintColor = UIColor(named: "Selector")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
            
        case "p2", "p3", "p6":
            let vc = SenderImagePdfHomePageViewController(nibName: nil, bundle: nil)
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.view.backgroundColor = UIColor(named: "Teaching Staff")
            vc.imageSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.imageSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
        case "p7":
            let vc = SenderImagePdfHomePageViewController(nibName: nil, bundle: nil)
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.view.backgroundColor = UIColor(named: "univercityColorCod")
            vc.imageSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.imageSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
        case "p5":
            let vc = ImageViewController(nibName: nil, bundle: nil)
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.imageSegmentName.backgroundColor = UIColor(named: "FatherUnselector")
            vc.imageSegmentName.selectedSegmentTintColor = UIColor(named: "FatherSelector")
            vc.view.backgroundColor = UIColor(named: "FatherColor")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
        default:
            break
        }
    }
    
    @IBAction func adLoad(gesture : HomeViewGesture) {
        
        let vc = HomePageAddViewController(nibName: nil, bundle: nil)
        vc.AddWebUrl = gesture.url
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
    }
    
}



import UIKit

class BackButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        
        let symbolConfiguration = UIImage.SymbolConfiguration(
                pointSize: 20,
                weight: .medium
            )
        
        // UI
        let backImage = UIImage(
               systemName: "chevron.left",
               withConfiguration: symbolConfiguration
           )
        setImage(backImage, for: .normal)
        setTitle("", for: .normal)
        
        tintColor = .white
        setTitleColor(.black, for: .normal)
        
        titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        
        imageView?.contentMode = .scaleAspectFit
        semanticContentAttribute = .forceLeftToRight
        contentHorizontalAlignment = .leading
        
        addTarget(self, action: #selector(backTapped), for: .touchUpInside)
    }
    
    @objc private func backTapped() {
        parentViewController?.dismiss(animated: true)
    }
}

extension UIColor {

    static var priorityColor: UIColor {
        let priority = UserDefaults.standard
            .string(forKey: DefaultsKeys.priority)?
            .lowercased()

        switch priority {
        case "p1":
            return UIColor(named: "Principal") ?? .systemBackground

        case "p2", "p3", "p6":
            return UIColor(named: "Teaching Staff") ?? .systemBackground

        case "p4":
            return UIColor(named: "studentViewColors") ?? .systemBackground

        case "p5":
            return UIColor(named: "FatherColor") ?? .systemBackground

        case "p7":
            return UIColor(named: "univercityColorCod") ?? .systemBackground

        default:
            return UIColor(named: "Principal") ?? .systemBackground
        }
    }
}
