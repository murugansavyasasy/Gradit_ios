//
//  SenderGraditNoticeBoardMenuViewController.swift
//  SenderGraditNoticeBoard
//
//  Created by MACBOOKPRO on 06/12/22.
//

import UIKit
import ObjectMapper
import KRProgressHUD

@available(iOS 16.0, *)
class SenderGraditNoticeBoardMenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var topNameview: UIView!
    @IBOutlet weak var SearchView: UIView!
    @IBOutlet weak var searchFullView: UIViewX!
    @IBOutlet weak var redirectLoginView: UIViewX!
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var smallImg: UIImageView!
    @IBOutlet weak var bigImg: UIImageView!
    @IBOutlet weak var logoutView: UIView!
    @IBOutlet weak var changeRolesView: UIView!
    @IBOutlet weak var tapBarView: UIViewX!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var topMessageLabel: UILabel!
    @IBOutlet weak var clgLogoImg: UIImageView!
    @IBOutlet weak var helpView: UIView!
    @IBOutlet weak var topLabels: UILabel!
    @IBOutlet weak var viewTap: UIView!
    @IBOutlet weak var faqView: UIView!
    @IBOutlet weak var privacyPolicyView: UIView!
    @IBOutlet weak var refreshView: UIView!
    @IBOutlet weak var sideMenuView: UIView!
    @IBOutlet weak var termsAndConditionView: UIView!
    @IBOutlet weak var changePasswordView: UIView!
    @IBOutlet weak var plusImageView: UIImageView!
    @IBOutlet weak var noticeBoardCountViews: UIViewX!
    @IBOutlet weak var collegeCountView: UIViewX!
    @IBOutlet weak var departmentCountView: UIViewX!
    @IBOutlet weak var noRecordLbl: UILabel!
    @IBOutlet weak var departmentCountLabel: UILabel!
    @IBOutlet weak var noticeBoardCountLabel: UILabel!
    @IBOutlet weak var noticesBoardTableView: UITableView!
    @IBOutlet weak var noticeSegments: UISegmentedControl!
    @IBOutlet weak var plusAddView: UIViewX!
    @IBOutlet weak var collegeCountLabel: UILabel!
    @IBOutlet weak var noRecordView: UIView!
    
    var Indentifiers = "SenderNoticeBoardTableViewCell"
    var NoticeBoardMenuId = "1"
    var departmentRef : [SenderNoticeBoardDepartmentDataDetails] = []
    var collegeRef    : [SenderNoticeBoardCollegeDataDetails] = []
    var overAllRef    : [overAllDataDetails] = []
    var addapiRef : [AddDataDeatils] = []
    var memberId : String!
    var priority : String!
    var collegeId : String!
    var departmentId : String!
    var sectionID : String!
    var memberName : String!
    var colgImg : String!
    var PreviousAddId : Int = 0
    var mobileNumber : String!
    var selectedCell : IndexPath?
    var str : [String] = []
    var strName : [String] = []
    var is_read_enabled = ""
    var is_write_enabled = ""
    var segmentTypeId : String!
    var cloneList : [SenderNoticeBoardDepartmentDataDetails] = []
    override func viewDidAppear(_ animated: Bool) {
        PreviousAddId = PreviousAddId+1
        //        addApi()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        PreviousAddId = PreviousAddId+1
        sideMenuView.isHidden = true
        searchbar.delegate = self
        searchbar.isHidden  = true
        searchFullView .isHidden = true
        
        let defaults = UserDefaults.standard
        memberId = defaults.string(forKey: DefaultsKeys.memberid)
        priority = defaults.string(forKey: DefaultsKeys.priority)
        collegeId = defaults.string(forKey: DefaultsKeys.collegeid)
        departmentId = defaults.string(forKey: DefaultsKeys.deptid)
        sectionID = defaults.string(forKey: DefaultsKeys.deptid)
        mobileNumber = defaults.string(forKey: DefaultsKeys.mobileNumber)
        if sectionID == ""{
            sectionID = "0"
        }
        memberName = defaults.string(forKey: DefaultsKeys.memberName)
        colgImg = defaults.string(forKey: DefaultsKeys.colglogo)
        clgLogoImg.sd_setImage(with: URL(string:  colgImg), placeholderImage: UIImage(named: "EmptyCollegeIcon"))
        topMessageLabel.text = memberName
        addApi()
        if is_read_enabled == "1"{
            departRefName()
        }
        plusAddView.isHidden = is_write_enabled != "1"
        noticesBoardTableView.allowsSelection = true
        noticesBoardTableView.dataSource =  self
        noticesBoardTableView.delegate =  self
        tapBarView.backgroundColor = .priorityColor
        topLabels.text = .priorityRole
        view.backgroundColor = .priorityColor
        overAllRefName()
        
        let rowNib = UINib(nibName: Indentifiers, bundle: nil)
        noticesBoardTableView.register(rowNib, forCellReuseIdentifier: Indentifiers)
        
        let loginRediectGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        redirectLoginView.addGestureRecognizer(loginRediectGesture)
        
        let plusAddViews = UITapGestureRecognizer(target: self, action: #selector(PlusVc))
        plusAddView.addGestureRecognizer(plusAddViews)
        
        noRecordLbl.isHidden = true
        noRecordView.isHidden = true
        
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
        
        let Serach = UITapGestureRecognizer(target: self, action: #selector(Searchfield))
        SearchView.addGestureRecognizer(Serach)
        
    }
    
    @IBAction func Searchfield() {
        searchbar.isHidden  = false
        searchFullView .isHidden = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let filtered_list:[SenderNoticeBoardDepartmentDataDetails] = cloneList
        if !searchText.isEmpty{
            let search = searchText.lowercased()
            departmentRef = filtered_list.filter {
                ($0.description?.lowercased().contains(search) ?? false) ||
                ($0.topic?.lowercased().contains(search) ?? false) ||
                ($0.createdby?.lowercased().contains(search) ?? false) ||
                ($0.sentbyname?.lowercased().contains(search) ?? false)
            }
        }else{
            departmentRef = filtered_list
        }
        noticesBoardTableView.reloadData()
    }
    
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchbar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchbar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchbar.isHidden  = true
        searchFullView .isHidden = true
        searchbar.resignFirstResponder()
    }
    
    @IBAction func PlusVc() {
        for i in addapiRef{
            let vc = SenderNoticeBoardNextPageViewController(nibName: nil, bundle: nil)
            vc.menuTypes = NoticeBoardMenuId
            vc.SmallImageUrl = i.add_image
            vc.BackGroundImageUrl = i.background_image
            vc.addWebUrl = i.add_url
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true , completion: nil)
        }
    }
    @IBAction func SegmentAction(_ sender: Any) {
        if is_read_enabled == "1"{
            if noticeSegments.selectedSegmentIndex == 0 {
                segmentTypeId = "1"
                noticesBoardTableView.isScrollEnabled = false
                departRefName()
            }else if noticeSegments.selectedSegmentIndex == 1 {
                segmentTypeId = "2"
                noticesBoardTableView.isScrollEnabled = false
                collegeRefName()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if noticeSegments.selectedSegmentIndex == 0 {
            return departmentRef.count
        }else if noticeSegments.selectedSegmentIndex == 1{
            return collegeRef.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView,cellForRowAt indexPath: IndexPath) ->UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Indentifiers,
            for: indexPath
        ) as! SenderNoticeBoardTableViewCell
        
        if noticeSegments.selectedSegmentIndex == 0 {
            
            let notice = departmentRef[indexPath.row]
            cell.configureCommonCell(
                isSelected: selectedCell == indexPath,
                createdBy: notice.createdby,
                isAppRead: notice.isappread,
                topic: notice.topic,
                date: notice.createdondate,
                time: notice.createdontime,
                description: notice.description,
                sentByName: notice.sentbyname,
                hasAttachment: !(notice.filearray?.isEmpty ?? true), memberId: memberId
            )
            if memberId == notice.createdby {
                let delete = departmentNoticeDelete(target: self,action:#selector(DepartdeleteVc))
                delete.noticeBoardId = notice.noticeheaderid
                cell.deleteView.addGestureRecognizer(delete)
            }
            setupAttachment(for: cell,index: indexPath.row)
            
        } else {
            
            let notice = collegeRef[indexPath.row]
            cell.configureCommonCell(
                isSelected: selectedCell == indexPath,
                createdBy: notice.createdby,
                isAppRead: notice.isappread,
                topic: notice.topic,
                date: notice.createdondate,
                time: notice.createdontime,
                description: notice.description,
                sentByName: notice.sentbyname,
                hasAttachment: !(notice.filearray?.isEmpty ?? true), memberId: memberId
            )
            if memberId == notice.createdby {
                let delete = CollegeNoticeDelete(target: self,action: #selector(ColleagedeleteVc))
                delete.noticeBoardId = notice.noticeheaderid
                cell.deleteView.addGestureRecognizer(delete)
            }
            setupAttachment(for: cell,index: indexPath.row)
        }
        
        return cell
    }
    
    private func setupAttachment(
        for cell: SenderNoticeBoardTableViewCell,
        index: Int?
    ) {
        cell.attchmentView.isUserInteractionEnabled = true
        cell.attchmentView.tag = index ?? 0
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(AtchmentVc)
        )
        cell.attchmentView.addGestureRecognizer(tapGesture)
    }
    
    @objc func AtchmentVc(_ gesture: UITapGestureRecognizer) {
        let index = gesture.view?.tag ?? 0
        let vc  = MoreImageVcViewController(nibName: nil, bundle: nil)
        if noticeSegments.selectedSegmentIndex == 0 {
            vc.imageFile = departmentRef[index].filearray?.compactMap { $0.filepath } ?? []
            vc.fileType = departmentRef[index].filearray?.first?.filetype
            vc.TopicLbl = collegeRef[index].topic
        } else {
            vc.imageFile = collegeRef[index].filearray?.compactMap { $0.filepath } ?? []
            vc.fileType = collegeRef[index].filearray?.first?.filetype
            vc.TopicLbl = collegeRef[index].topic
        }
        vc.modalPresentationStyle = .formSheet
        present(vc, animated: true,completion: nil)
    }
    
    
    @IBAction func DepartdeleteVc(gesture: departmentNoticeDelete) {
        let refreshAlert = UIAlertController(
            title: "Delete Notice",
            message: "Once done can't be changed",
            preferredStyle: .alert
        )
        
        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] _ in
            var particularNotice = NoticeBoardPartiModal()
            particularNotice.noticeboardid = gesture.noticeBoardId
            particularNotice.description = ""
            particularNotice.receivertype = ""
            particularNotice.isstaff = false
            particularNotice.isstudent = false
            particularNotice.isparent = false
            particularNotice.processtype = "delete"
            particularNotice.receiveridlist = ""
            particularNotice.topic = ""
            particularNotice.colgid = collegeId
            particularNotice.staffid = memberId
            particularNotice.callertype = ""
            APiCallManager.shared.callApi(
                url: APIEndpoints.ManageNoticeBoard,
                httpMethod: .post,
                queryParam: nil,
                requestBody: particularNotice
            ) { [weak self] (result: Result<NoticePArticularResponce, Error>) in
                
                guard let self = self else { return }
                
                switch result {
                    
                case .success(let response):
                    if response.Status == 1 {
                        let refreshAlert = UIAlertController(title: "",message: response.Message,preferredStyle: .alert)
                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default) { _ in})
                        self.present(refreshAlert, animated: true)
                        self.departRefName()
                        
                    } else {
                        let refreshAlert = UIAlertController(title: "",message: response.Message,preferredStyle: .alert)
                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default) { _ in})
                        self.present(refreshAlert, animated: true)
                        self.noticesBoardTableView.dataSource = self
                        self.noticesBoardTableView.delegate = self
                        self.noticesBoardTableView.reloadData()
                    }
                    
                case .failure(let error):
                    print("API Error:", error.localizedDescription)
                }
            }
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: { _ in }))
        present(refreshAlert, animated: true)
    }
    
    @IBAction func ColleagedeleteVc(gesture: CollegeNoticeDelete) {
        let refreshAlert = UIAlertController(title: "Delete Notice",message: "Once done can't be changed",preferredStyle: .alert)
        
        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] _ in
            
            var particularNotice = NoticeBoardPartiModal()
            particularNotice.noticeboardid = gesture.noticeBoardId
            particularNotice.description = ""
            particularNotice.receivertype = ""
            particularNotice.isstaff = false
            particularNotice.isstudent = false
            particularNotice.isparent = false
            particularNotice.processtype = "delete"
            particularNotice.receiveridlist = ""
            particularNotice.topic = ""
            particularNotice.colgid = collegeId
            particularNotice.staffid = memberId
            particularNotice.callertype = ""
            
            APiCallManager.shared.callApi(url: APIEndpoints.ManageNoticeBoard,httpMethod: .post,queryParam: nil,requestBody: particularNotice
            ) { [weak self] (result: Result<NoticePArticularResponce, Error>) in
                
                guard let self = self else { return }
                switch result {
                    
                case .success(let response):
                    
                    if response.Status == 1 {
                        let refreshAlert = UIAlertController(title: "",message: response.Message,preferredStyle: .alert)
                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default) { _ in})
                        self.present(refreshAlert, animated: true)
                        self.collegeRefName()
                    } else {
                        let refreshAlert = UIAlertController(title: "",message: response.Message,preferredStyle: .alert)
                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default) { _ in})
                        self.present(refreshAlert, animated: true)
                        self.noticesBoardTableView.dataSource = self
                        self.noticesBoardTableView.delegate = self
                        self.noticesBoardTableView.reloadData()
                    }
                    
                case .failure(let error):
                    print("API Error:", error.localizedDescription)
                }
            }
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: { _ in }))
        present(refreshAlert, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Indentifiers, for: indexPath) as! SenderNoticeBoardTableViewCell
        if noticeSegments.selectedSegmentIndex == 0{
            if let selectedCells = selectedCell, selectedCells == indexPath {
                selectedCell = nil
            } else {
                selectedCell = indexPath
                if departmentRef[indexPath.row].isappread == "0"{
                    apread(gesture : departmentRef[indexPath.row].noticedetailsid ?? "")
                    departmentRef[indexPath.row].isappread = "1"
                    cell.redImageView.isHidden = true
                }
            }
        }else if noticeSegments.selectedSegmentIndex == 1{
            if let selectedCells = selectedCell, selectedCells == indexPath {
                selectedCell = nil
            } else {
                selectedCell = indexPath
                if collegeRef[indexPath.row].isappread == "0"{
                    apread(gesture : collegeRef[indexPath.row].noticedetailsid ?? "")
                    collegeRef[indexPath.row].isappread = "1"
                    cell.redImageView.isHidden = true
                }
            }
        }
        noticesBoardTableView.beginUpdates()
        noticesBoardTableView.endUpdates()
        noticesBoardTableView.reloadData()
        
    }
    
    func apread(gesture : String){
        var readApiStatus  = AppReadStatusModal()
        readApiStatus.msgtype = "noticeboard"
        readApiStatus.priority = priority
        readApiStatus.userid = memberId
        readApiStatus.detailsid = gesture
        APiCallManager.shared.callApi(url: APIEndpoints.Appreadstatus, httpMethod: .post, queryParam: nil, requestBody: readApiStatus) {[weak self]  (result:Result<ReadStausApiResponce, Error>) in
            
            guard let self = self else {return}
            
            switch result {
            case .success(let success):
                noticesBoardTableView.reloadData()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func departRefName() {
        
        var depart = SenderNoticeBoardDepartmentModal()
        depart.userid   = memberId
        depart.appid    = "2"
        depart.priority = priority
        depart.type     = "departmentnotice"
        
        APiCallManager.shared.callApi(url: APIEndpoints.GetNoticeListByType, httpMethod: .post, queryParam: nil, requestBody: depart) { [weak self] (result:Result<SenderNoticeBoardDepartmentResponce,Error>) in
            guard let self = self else{return}
            switch result{
            case .success(let departResp):
                if departResp.Status == 1 {
                    departmentRef = departResp.data ?? []
                    cloneList = departResp.data ?? []
                    noticesBoardTableView.isScrollEnabled = true
                    noticesBoardTableView.delegate = self
                    noticesBoardTableView.dataSource = self
                    noRecordLbl.isHidden = true
                    noRecordView.isHidden = true
                    noticesBoardTableView.reloadData()
                }else{
                    noRecordLbl.isHidden = false
                    noRecordView.isHidden = false
                    noRecordLbl.text = departResp.Message
                    noticesBoardTableView.delegate = self
                    noticesBoardTableView.dataSource = self
                    noticesBoardTableView.reloadData()
                }
                
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        
    }
    
    func collegeRefName() {
        
        var college = SenderNoticeBoardCollegeModal()
        college.userid   =  memberId
        college.appid    = "2"
        college.priority = priority
        college.type     =  "collegenotice"
        
        APiCallManager.shared.callApi(url: APIEndpoints.GetNoticeListByType, httpMethod: .post, queryParam: nil, requestBody: college) { [weak self] (result:Result<SenderNoticeBoardCollegeResponce,Error>) in
            guard let self = self else{return}
            switch result{
            case .success(let collegeResp):
                
                if collegeResp.Status == 1{
                    collegeRef = collegeResp.data ?? []
                    noRecordLbl.isHidden = true
                    noRecordView.isHidden = true
                    noticesBoardTableView.isScrollEnabled = true
                    noticesBoardTableView.delegate = self
                    noticesBoardTableView.dataSource = self
                    noticesBoardTableView.reloadData()
                }else {
                    noRecordLbl.isHidden = false
                    noRecordView.isHidden = false
                    noRecordLbl.text = collegeResp.Message
                    noticesBoardTableView.delegate = self
                    noticesBoardTableView.dataSource = self
                    noticesBoardTableView.reloadData()
                }
                
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        
    }
    
    func overAllRefName() {
        
        var overall = overAllModal()
        overall.userid   =  memberId
        overall.menuid       = "7"
        overall.collegeid    =  collegeId
        overall.departmentid =  departmentId
        overall.sectionid    =   sectionID
        overall.appid        = "2"
        overall.priority     = priority
        APiCallManager.shared.callApi(url: APIEndpoints.GetOverallcountByMenuType, httpMethod: .post, queryParam: nil, requestBody: overall) { [weak self] (result:Result<overAllResponce,Error>) in
            guard let self = self else{return}
            switch result{
            case .success(let result):
                if result.Status == 1{
                    overAllRef = result.data ?? []
                    
                    for i in overAllRef{
                        departmentCountLabel.text = i.departmentnotice
                        collegeCountLabel.text = i.collegenotice
                        let hasDepartmentNotice = i.departmentnotice != "0"
                        let hasCollegeNotice = i.collegenotice != "0"
                        departmentCountView.isHidden = !hasDepartmentNotice
                        collegeCountView.isHidden = !hasCollegeNotice
                        noticeBoardCountViews.isHidden = !hasDepartmentNotice && !hasCollegeNotice
                    }
                    
                    noticeBoardCountLabel.text = String((Int( departmentCountLabel.text!) ?? 0) + (Int(collegeCountLabel.text!) ?? 0))
                    noticesBoardTableView.delegate = self
                    noticesBoardTableView.dataSource = self
                    noticesBoardTableView.reloadData()
                }else{
                    departmentCountView.isHidden = true
                    collegeCountView.isHidden = true
                    noticeBoardCountViews.isHidden = true
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func addApi(){
        var add = AddApiModal()
        let defaults = UserDefaults.standard
        var deviceToken = defaults.string(forKey:DefaultsKeys.DeviceToken )
        add.device_token = deviceToken
        add.member_id = Int(memberId)
        add.mobile_no = mobileNumber
        add.priority = priority
        add.college_id = Int(collegeId)
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
    
    @IBAction func adLoad( gesture : noticeBoardAdd){
        let vc = SenderNoticeAddViewController(nibName: nil, bundle: nil)
        vc.AddWebUrl = gesture.url
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
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
        
        refreshAlert.addAction(UIAlertAction(title: "NO", style: .cancel, handler: { (action: UIAlertAction!) in }))
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
    
    @IBAction func refreshVc() {
        if segmentTypeId == "1"{
            departRefName()
        } else{
            collegeRefName()
        }
    }
    
    @IBAction func notificationVc() {
        let vc = NotificationViewController(nibName: nil, bundle: nil)
        vc.str = str
        vc.strName = strName
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false, completion: nil)
    }
    
    @IBAction func menu() {
        sideMenuView.isHidden.toggle()
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
}


class noticeBoardAdd : UITapGestureRecognizer{
    var url : String!
}

class departmentNoticeDelete : UITapGestureRecognizer{
    var noticeBoardId : String!
}

class CollegeNoticeDelete : UITapGestureRecognizer{
    var noticeBoardId : String!
}

