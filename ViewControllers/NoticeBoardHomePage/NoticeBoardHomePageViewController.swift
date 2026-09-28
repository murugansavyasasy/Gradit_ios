//
//  NoticeBoardHomePageViewController.swift
//  GraditNoticeBoard
//
//  Created by MACBOOKPRO on 26/10/22.
//

import UIKit
import ObjectMapper
import KRProgressHUD
import WebKit

@available(iOS 16.0, *)
class NoticeBoardHomePageViewController:
    UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate{
    
    @IBOutlet weak var topNameview: UIView!
    @IBOutlet weak var tapBarView: UIViewX!
    @IBOutlet weak var searchFullView: UIViewX!
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var logoutView: UIView!
    @IBOutlet weak var redirectLoginView: UIViewX!
    @IBOutlet weak var topLabels: UILabel!
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var loadingCustom: UIActivityIndicatorView!
    @IBOutlet weak var clgLogoImg: UIImageView!
    @IBOutlet weak var topMessageLabel: UILabel!
    @IBOutlet weak var faqView: UIView!
    @IBOutlet weak var refreshView: UIView!
    @IBOutlet weak var helpView: UIView!
    @IBOutlet weak var termsAndConditionView: UIView!
    @IBOutlet weak var changePasswordView: UIView!
    @IBOutlet weak var privacyPolicyView: UIView!
    @IBOutlet weak var sideMenuView: UIView!
    @IBOutlet weak var viewTap: UIView!
    @IBOutlet weak var noticeBoardCountView: UIViewX!
    @IBOutlet weak var departmentCountView: UIViewX!
    @IBOutlet weak var collegeCountView: UIViewX!
    @IBOutlet weak var noDataView: UIView!
    @IBOutlet weak var noticeBoardCountLabel: UILabel!
    @IBOutlet weak var departmentCountLabel: UILabel!
    @IBOutlet weak var collegeCountLabel: UILabel!
    @IBOutlet weak var noticeSegments: UISegmentedControl!
    @IBOutlet weak var adView: UIView!
    @IBOutlet weak var noticesBoardTableView
    : UITableView!
    @IBOutlet weak var bigImg: UIImageView!
    @IBOutlet weak var smallImg: UIImageView!
    @IBOutlet weak var noDataTextLabel: UILabel!
    @IBOutlet weak var changeRolesView: UIView!
    @IBOutlet weak var SearchView: UIView!
    
    var Indentifiers = "SenderNoticeBoardTableViewCell"
    var addapiRef : [AddDataDeatils] = []
    var departmentRef : [departmentDataDetails] = []
    var collegeRef    : [departmentDataDetails] = []
    var overAllRef    : [overAllDataDetails] = []
    var collegeid : String!
    var userid : String!
    var priority : String!
    var deparmentId : String!
    var sectionId : String!
    var loginType : String!
    var memberName : String!
    var colgImg : String!
    var MobileNumber : String!
    var PreviousAddId  = 3
    var str : [String] = []
    var strName : [String] = []
    var selectedCell : IndexPath?
    var segmentId : String!
    var  cloneList : [departmentDataDetails] = []
    var is_read_enabled = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        loadingCustom.startAnimating()
        sideMenuView.isHidden = true
        searchbar.delegate = self
        searchbar.isHidden  = true
        searchFullView .isHidden = true
        noDataView.isHidden =  true
        noDataTextLabel.isHidden =  true
        noticesBoardTableView.delegate = self
        noticesBoardTableView.dataSource = self
        let defaults = UserDefaults.standard
        
        collegeid = defaults.string(forKey: DefaultsKeys.collegeid)
        userid = defaults.string(forKey: DefaultsKeys.memberid)
        
        priority = defaults.string(forKey:DefaultsKeys.priority)
        
        deparmentId = defaults.string(forKey: DefaultsKeys.deptid)
        sectionId = defaults.string(forKey: DefaultsKeys.sectionid)
        loginType = defaults.string(forKey: DefaultsKeys.loginAsType)
        
        memberName = defaults.string(forKey: DefaultsKeys.memberName)
        colgImg = defaults.string(forKey: DefaultsKeys.colglogo)
        clgLogoImg.sd_setImage(with: URL(string:  colgImg), placeholderImage: UIImage(named: "EmptyCollegeIcon"))
        topMessageLabel.text = memberName
        MobileNumber = defaults.string(forKey: DefaultsKeys.mobileNumber)
        overAllRefName()
        addApi()
        departRefName()
        topLabels.text = .priorityRole
        view.backgroundColor = .priorityColor
        tapBarView.backgroundColor = .priorityColor
        
        let rowNib = UINib(nibName: Indentifiers, bundle: nil)
        noticesBoardTableView.register(rowNib, forCellReuseIdentifier: Indentifiers)
        
        let changeRolesGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        changeRolesView.addGestureRecognizer(changeRolesGesture)
        
        let topname = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        topNameview.addGestureRecognizer(topname)
        
        let menuGestureHide = UITapGestureRecognizer(target: self, action: #selector(menu))
        viewTap.addGestureRecognizer(menuGestureHide)
        
        let notificationGesture = UITapGestureRecognizer(target: self, action: #selector(notificationVc))
        notificationView.addGestureRecognizer(notificationGesture)
        
        let refreshGesture = UITapGestureRecognizer(target: self, action: #selector(refreshVc))
        refreshView.addGestureRecognizer(refreshGesture)
        
        let faqGesture = UITapGestureRecognizer(target: self, action: #selector(faqRedirect))
        faqView.addGestureRecognizer(faqGesture)
        
        let loginRediectGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        redirectLoginView.addGestureRecognizer(loginRediectGesture)
        
        let helpGesture = UITapGestureRecognizer(target: self, action: #selector(helpRedirect))
        helpView.addGestureRecognizer(helpGesture)
        
        let privacyPolicyGesture = UITapGestureRecognizer(target: self, action: #selector(privacyPolicyRedirect))
        privacyPolicyView.addGestureRecognizer(privacyPolicyGesture)
        
        let termsAndConditionGesture = UITapGestureRecognizer(target: self, action: #selector(termsAndCondition))
        termsAndConditionView.addGestureRecognizer(termsAndConditionGesture)
        
        let chagePassword = UITapGestureRecognizer(target: self, action: #selector(changePassowrdVC))
        changePasswordView.addGestureRecognizer(chagePassword)
        
        let logoutGesture = UITapGestureRecognizer(target: self, action: #selector(logoutPressed))
        logoutView.addGestureRecognizer(logoutGesture)
        
        let Serach = UITapGestureRecognizer(target: self, action: #selector(Searchfield))
        SearchView.addGestureRecognizer(Serach)
        
    }
    
    @IBAction func Searchfield() {
        searchbar.isHidden  = false
        searchFullView .isHidden = false
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if noticeSegments.selectedSegmentIndex == 0{
            let filtered_list : [departmentDataDetails] = cloneList
            if !searchText.isEmpty{
                let search = searchText.lowercased()
                departmentRef = filtered_list.filter {
                    ($0.topic?.lowercased().contains(search) ?? false) ||
                    ($0.description?.lowercased().contains(search) ?? false) ||
                    ($0.noticedetailsid?.lowercased().contains(search) ?? false) ||
                    ($0.createdondate?.lowercased().contains(search) ?? false) ||
                    ($0.sentbyname?.lowercased().contains(search) ?? false) ||
                    ($0.createdontime?.lowercased().contains(search) ?? false) ||
                    ($0.noticeheaderid?.lowercased().contains(search) ?? false)
                }
            }else{
                departmentRef = filtered_list
            }
            noDataTextLabel.text = "No Records Found"
            noDataView.isHidden = departmentRef.count > 0
            noDataTextLabel.isHidden = departmentRef.count > 0
        }else if noticeSegments.selectedSegmentIndex == 1{
            let filtered_list : [departmentDataDetails] =  cloneList
            if !searchText.isEmpty{
                let search = searchText.lowercased()
                collegeRef = filtered_list.filter { item in
                    let fields = [item.topic,item.description,item.noticedetailsid,item.createdondate,item.sentbyname,item.createdontime,item.noticeheaderid]
                    
                    return fields.compactMap { $0?.lowercased() }
                        .contains { $0.contains(search) }
                }
            }else{
                collegeRef = filtered_list
            }
            
            noDataTextLabel.text = "No Records Found"
            noDataView.isHidden = collegeRef.count > 0
            noDataTextLabel.isHidden = collegeRef.count > 0
            
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
        noDataView.isHidden = true
        noDataTextLabel.isHidden = true
        searchbar.resignFirstResponder()
    }
    
    @IBAction func adLoad(gesture : addverisment) {
        
        let vc = AddNoticeBoardViewController(nibName: nil, bundle: nil)
        vc.AddWebUrl = gesture.url
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
    }
    
    @IBAction func noticeBoardSegment(_ sender: Any) {
        
        if is_read_enabled == "1"{
            if noticeSegments.selectedSegmentIndex == 0 {
                segmentId = "1"
                selectedCell = IndexPath()
                noticesBoardTableView.isScrollEnabled = false
                departRefName()
            }else if noticeSegments.selectedSegmentIndex == 1 {
                segmentId = "2"
                selectedCell = IndexPath()
                noticesBoardTableView.isScrollEnabled = false
                collegeRefName()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noticeSegments.selectedSegmentIndex == 0 ? departmentRef.count:collegeRef.count
    }
    func tableView(_ tableView: UITableView,cellForRowAt indexPath: IndexPath) ->UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Indentifiers,for: indexPath) as! SenderNoticeBoardTableViewCell
        cell.selectionStyle = .none
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
                hasAttachment: !(notice.filearray?.isEmpty ?? true), memberId: ""
            )
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
                hasAttachment: !(notice.filearray?.isEmpty ?? true), memberId: ""
            )
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Indentifiers, for: indexPath) as!SenderNoticeBoardTableViewCell
        
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
        readApiStatus.userid = userid
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
        
        var depart = departmentModal()
        
        depart.userid   = userid
        depart.appid    = "2"
        depart.priority = priority
        depart.type     = "departmentnotice"
        
        APiCallManager.shared.callApi(url: APIEndpoints.GetNoticeListByType, httpMethod: .post, queryParam: nil, requestBody: depart) { [weak self] (result:Result<departmentResponce,Error>) in
            guard let self = self else {return}
            switch result{
            case .success(let success):
                departmentRef = success.data ?? []
                cloneList = success.data ?? []
                noDataTextLabel.isHidden = success.Status == 1
                noDataView.isHidden = success.Status == 1
                noDataTextLabel.text = success.Message
                noticesBoardTableView.reloadData()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3 ){ [self] in
                    self.loadingCustom.stopAnimating()
                    self.loadingCustom.isHidden  = true
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        
    }
    
    
    func collegeRefName() {
        
        var college = departmentModal()
        
        college.userid   =  userid
        college.appid    = "2"
        college.priority = priority
        college.type     =  "collegenotice"
        
        APiCallManager.shared.callApi(url: APIEndpoints.GetNoticeListByType, httpMethod: .post, queryParam: nil, requestBody: college) { [weak self] (result:Result<departmentResponce,Error>) in
            guard let self = self else{return}
            switch result{
            case .success(let success):
                collegeRef = success.data ?? []
                cloneList = success.data ?? []
                noDataTextLabel.isHidden = success.Status == 1
                noDataView.isHidden =  success.Status == 1
                noDataTextLabel.text = success.Message
                noticesBoardTableView.reloadData()
                
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func overAllRefName() {
        
        var overall = overAllModal()
        
        overall.userid   =  userid
        overall.menuid       = "7"
        overall.collegeid    = collegeid
        overall.departmentid =  deparmentId
        overall.sectionid    =   sectionId
        overall.appid        = "2"
        overall.priority     = priority
        
        
        APiCallManager.shared.callApi(url: APIEndpoints.GetOverallcountByMenuType, httpMethod: .post, queryParam: nil, requestBody: overall) { [weak self] (result:Result<overAllResponce,Error>) in
            guard let self = self else{return}
            switch result{
            case .success(let success):
                
                if success.Status == 1 {
                    overAllRef = success.data ?? []
                    departmentCountLabel.text = overAllRef.first?.departmentnotice ?? "0"
                    collegeCountLabel.text = overAllRef.first?.collegenotice ?? "0"
                    for i in overAllRef {
                        let hasDepartmentNotice = i.departmentnotice != "0"
                        let hasCollegeNotice = i.collegenotice != "0"
                        departmentCountView.isHidden = !hasDepartmentNotice
                        collegeCountView.isHidden = !hasCollegeNotice
                        noticeBoardCountView.isHidden = !hasDepartmentNotice && !hasCollegeNotice
                        let departmentCount = Int(i.departmentnotice ?? "0") ?? 0
                        let collegeCount = Int(i.collegenotice ?? "0") ?? 0
                        noticeBoardCountLabel.text = String(departmentCount + collegeCount)
                    }
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
        add.member_id = Int(userid)
        add.mobile_no = MobileNumber
        add.priority = priority
        add.college_id = Int(collegeid)
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
    
    @IBAction func refreshVc() {
        if  segmentId == "1"{
            departRefName()
        }else{
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

class addverisment : UITapGestureRecognizer {
    var url : String!
}
