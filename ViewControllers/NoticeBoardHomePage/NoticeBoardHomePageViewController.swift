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
    
    var Indentifiers = "NoticeBoardTableViewCellsTableViewCell"
    var addapiRef : [AddDataDeatils] = []
    var departmentRef : [departmentDataDetails] = []
    var collegeRef    : [departmentDataDetails] = []
    var overAllRef    : [overAllDataDetails] = []
    var readStatusRef : [readStatusResponce] = []
    let menuIdentifier = "MenuCollectionViewCell"
    var MenuRefName :[menuApiDataDetails] = []
    var loginDatas : [datalogin]!
    var logindataprinci :[datalogin]!
    var isAppear : String!
    var isAppearCollege : String!
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
    var password : String!
    var str : [String] = []
    var strName : [String] = []
    var selectedCell : IndexPath?
    var segmentId : String!
    var  cloneList : [departmentDataDetails] = []
    var is_read_enabled = ""
    var is_write_enabled = ""
    
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
        
        password  = defaults.string(forKey: DefaultsKeys.Password)
        topMessageLabel.text = memberName
        
        MobileNumber = defaults.string(forKey: DefaultsKeys.mobileNumber)
        
        overAllRefName()
        
        addApi()
        
        departRefName()
        
        
        if priority == "p1"{
            
            topLabels.text = "Principal"
        }
        else if priority == "p4"{
            
            topLabels.text = "Student"
        }
        else if priority == "p2" {
            
            topLabels.text = "Hod"
        }
        else if priority == "p5"{
        
            topLabels.text = "Father"
        }
        else if priority == "p3"{
            
            topLabels.text = "Teacher"
        }
        
        if priority == "p1" {
            
            print("PrincipalVieewwColor")
            view.backgroundColor = UIColor(named: "Principal" )
            
           
            
        }else if priority == "p4" {
            
            print("StudentVieewwColor")
            view.backgroundColor = UIColor(named: "studentViewColors")
            tapBarView.backgroundColor = UIColor(named: "StudentParent" )
            
          
            
        } else if priority == "p3" ||  priority == "p2"  || priority == "p6"{
            
            print("HooodddVieewwColor")
            view.backgroundColor = UIColor(named: "Teaching Staff")
            
          
            
        }else if priority == "p5"{
            
            view.backgroundColor = UIColor(named: "FatherColor")
            tapBarView.backgroundColor = UIColor(named: "FatherColor" )
          
        }
        
       
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
            
            if departmentRef.count > 0{
                 
                print ("searchListPendigCount",departmentRef.count)
                
                noDataView.isHidden = true
                noDataTextLabel.isHidden = true
                
            }else{
                
                noDataView.isHidden = false
                noDataTextLabel.isHidden = false
                noDataTextLabel.text = "No Records Found"
            }
        }
        
        else if noticeSegments.selectedSegmentIndex == 1{
            
            let filtered_list : [departmentDataDetails] =  cloneList
            
            if !searchText.isEmpty{
                
                let search = searchText.lowercased()

                collegeRef = filtered_list.filter { item in
                    
                    let fields = [
                        item.topic,
                        item.description,
                        item.noticedetailsid,
                        item.createdondate,
                        item.sentbyname,
                        item.createdontime,
                        item.noticeheaderid
                    ]
                    
                    return fields.compactMap { $0?.lowercased() }
                                 .contains { $0.contains(search) }
                }
                
            }else{
                
                collegeRef = filtered_list
                print("pendingOrder")
                
            }
            
            if collegeRef.count > 0{
                
                print ("searchListPendigCount",collegeRef.count)
                
                noDataView.isHidden = true
                noDataTextLabel.isHidden = true
                
            }else{
                
                noDataView.isHidden = false
                noDataTextLabel.isHidden = false
                noDataTextLabel.text = "No Records Found"
            }
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
            }
            else if noticeSegments.selectedSegmentIndex == 1 {
                segmentId = "2"
                selectedCell = IndexPath()
                noticesBoardTableView.isScrollEnabled = false
                collegeRefName()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if noticeSegments.selectedSegmentIndex == 0 {
            return departmentRef.count
        }
        else if noticeSegments.selectedSegmentIndex == 1{
            
            return collegeRef.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Indentifiers, for: indexPath) as!
        
        NoticeBoardTableViewCellsTableViewCell
        
        cell.selectionStyle = .none
        
        if noticeSegments.selectedSegmentIndex == 0 {
            
            let notice : departmentDataDetails = departmentRef[indexPath.row]
            
            if let selectedCells = selectedCell, selectedCells == indexPath {
                
                cell.descriptionCellLabel.isHidden = false
                cell.DetailsStack.isHidden = false
                cell.arrowImage.image = UIImage(systemName: "chevron.up")
                
                
                if notice.filearray?.count == 0{
                    
                    cell.attchmentView.isHidden = true
            
                }else{
                    
                    cell.attchmentView.isHidden = false
                }
                
            } else {
                
                cell.descriptionCellLabel.isHidden = true
                cell.DetailsStack.isHidden = true
                cell.arrowImage.image = UIImage(systemName: "chevron.down")
                
                cell.attchmentView.isHidden = true
                
            }
            
            if notice.isappread == "1"{
                
                cell.redDotImageView.isHidden =  true
                
            }
            
            else {
                
                cell.redDotImageView.isHidden = false
                
            }
            
            cell.topicCellLabel.text = notice.topic?.capitalized
            cell.dateTimeCellLabel.text = (notice.createdondate!)+" \(notice.createdontime!)"
            cell.descriptionCellLabel.text = notice.description
            cell.sentByCellLabel.text = notice.sentbyname
            
            if notice.filearray?.count == 1  {
                
                let  attchmentTap = NoticeImageCounts(target: self, action: #selector(AtchmentVc))
                
                for i in 0..<(notice.filearray?.count ?? 0){
                    
                    attchmentTap.img_url = notice.filearray?[i].filepath
                    attchmentTap.img_urls.append(notice.filearray?[i].filepath ?? "")
                    attchmentTap.imageFileType = notice.filearray?[i].filetype
                }
                
                cell.attchmentView.addGestureRecognizer(attchmentTap)
            }
            
            else{
                let  attchmentTap = NoticeImageCounts(target: self, action: #selector(AtchmentVc))
                
                for i in 0..<(notice.filearray?.count ?? 0){
                    
                    attchmentTap.img_url = notice.filearray?[i].filepath
                    attchmentTap.img_urls.append(notice.filearray?[i].filepath ?? "")
                    attchmentTap.imageFileType = notice.filearray?[i].filetype
                }
                
                cell.attchmentView.addGestureRecognizer(attchmentTap)
            }
        }
        
        else if noticeSegments.selectedSegmentIndex == 1 {
            
            let notice : departmentDataDetails = collegeRef[indexPath.row]
            if let selectedCells = selectedCell, selectedCells == indexPath {
                
                cell.descriptionCellLabel.isHidden = false
                cell.DetailsStack.isHidden = false
                cell.arrowImage.image = UIImage(systemName: "chevron.up")
                
                if notice.filearray?.count == 0{
                    
                    cell.attchmentView.isHidden = true
                    
                }else{
                    
                    cell.attchmentView.isHidden = false
                    
                }
                
            } else {
                
                cell.descriptionCellLabel.isHidden = true
                cell.DetailsStack.isHidden = true
                cell.arrowImage.image = UIImage(systemName: "chevron.down")
                cell.attchmentView.isHidden = true
            }
            
            if notice.isappread == "1"{
                
                cell.redDotImageView.isHidden =  true
            }
            
            else {
                
                cell.redDotImageView.isHidden = false
            }
    
            cell.topicCellLabel.text = notice.topic?.capitalized
            cell.dateTimeCellLabel.text = (notice.createdondate!)+" \(notice.createdontime!)"
            cell.descriptionCellLabel.text = notice.description
            cell.sentByCellLabel.text = notice.sentbyname
            
            if notice.filearray?.count == 1  {
                
                let  attchmentTap = NoticeImageCounts(target: self, action: #selector(AtchmentVc))
                
                for i in 0..<(notice.filearray?.count ?? 0){
                    
                    attchmentTap.img_url = notice.filearray?[i].filepath
                    
                    if notice.filearray?[i].filepath != nil{
                        attchmentTap.img_urls.append(notice.filearray?[i].filepath ?? "")
                    }
                  
                    attchmentTap.imageFileType = notice.filearray?[i].filetype
                }
                
                cell.attchmentView.addGestureRecognizer(attchmentTap)
                
            }
            
            else{
                
                let  attchmentTap = NoticeImageCounts(target: self, action: #selector(AtchmentVc))
                
                for i in 0..<(notice.filearray?.count ?? 0){
                    attchmentTap.img_url = notice.filearray?[i].filepath
                    attchmentTap.img_urls.append(notice.filearray?[i].filepath ?? "")
                    attchmentTap.imageFileType = notice.filearray?[i].filetype
                }
                
                cell.attchmentView.addGestureRecognizer(attchmentTap)
            }
        }
        return cell
    }
    
    @IBAction func AtchmentVc(gesture : NoticeImageCounts){
        
        let vc  = MoreImageVcViewController(nibName: nil, bundle: nil)
        
        vc.imageFile = gesture.img_urls
        vc.fileType = gesture.imageFileType
        
        vc.TopicLbl = gesture.titee
        vc.str = str
        vc.strName = strName
        vc.is_read_enabled = is_read_enabled
        vc.is_write_enabled = is_write_enabled
        vc.modalPresentationStyle = .formSheet
        present(vc, animated: true,completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Indentifiers, for: indexPath) as!
        
        NoticeBoardTableViewCellsTableViewCell
        
        if noticeSegments.selectedSegmentIndex == 0{
            
            if let selectedCells = selectedCell, selectedCells == indexPath {
                
                selectedCell = nil
                
            } else {
                
                selectedCell = indexPath
                if departmentRef[indexPath.row].isappread == "0"{
                    
                    apread(gesture : departmentRef[indexPath.row].noticedetailsid ?? "")
                    
                    departmentRef[indexPath.row].isappread = "1"
                    cell.redDotImageView.isHidden = true
                    
                }
            }
        }
        
        else if noticeSegments.selectedSegmentIndex == 1{
            
            if let selectedCells = selectedCell, selectedCells == indexPath {
                
                selectedCell = nil
                
            } else {
                
                selectedCell = indexPath
                
                if collegeRef[indexPath.row].isappread == "0"{
                    
                    apread(gesture : collegeRef[indexPath.row].noticedetailsid ?? "")
                    
                    collegeRef[indexPath.row].isappread = "1"
                    cell.redDotImageView.isHidden = true
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
        print("sertt",gesture)
        
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
                
                if success.Status == 1 {
                    
                    departmentRef = success.data ?? []
                    cloneList = success.data ?? []
                    noDataTextLabel.isHidden = true
                    noDataView.isHidden = true
                    noticesBoardTableView.isScrollEnabled = true
                    noticesBoardTableView.delegate = self
                    noticesBoardTableView.dataSource = self
                    noticesBoardTableView.reloadData()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3 ){ [self] in
                        
                        self.loadingCustom.stopAnimating()
                        self.loadingCustom.isHidden  = true
                        
                    }
                    
                }else{
                    
                    noDataView.isHidden = false
                    noDataTextLabel.isHidden = false
                    
                    noDataTextLabel.text = success.Message
                    noticesBoardTableView.isScrollEnabled = true
                    noticesBoardTableView.delegate = self
                    noticesBoardTableView.dataSource = self
                    noticesBoardTableView.reloadData()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3 ){ [self] in
                        
                        self.loadingCustom.stopAnimating()
                        self.loadingCustom.isHidden  = true
                    }
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
                if success.Status == 1{
                    
                    collegeRef = success.data ?? []
                    cloneList = success.data ?? []
                    noticesBoardTableView.isScrollEnabled = true
                    noDataTextLabel.isHidden = true
                    noDataView.isHidden =  true
                    noticesBoardTableView.delegate = self
                    noticesBoardTableView.dataSource = self
                    noticesBoardTableView.reloadData()
                }else{
                    
                    noDataTextLabel.isHidden = false
                    noDataView.isHidden = false
                    noDataTextLabel.text = success.Message
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
                
                if success.Status == 1{
                    
                    overAllRef = success.data ?? []
                    
                    
                    for i in overAllRef {
                        
                        departmentCountLabel.text = i.departmentnotice
                        collegeCountLabel.text = i.collegenotice
                        
                        if (i.departmentnotice == "0") && (i.collegenotice == "0"){
                            
                            departmentCountView.isHidden = true
                            collegeCountView.isHidden = true
                            noticeBoardCountView.isHidden = true
                            
                        }
                        
                        else if i.departmentnotice == "0"{
                            
                            departmentCountView.isHidden = true
                            collegeCountView.isHidden = false
                            noticeBoardCountView.isHidden = false
                            
                        }
                        
                        else if i.collegenotice == "0"{
                            
                            
                            departmentCountView.isHidden = false
                            collegeCountView.isHidden = true
                            noticeBoardCountView.isHidden = false
                            
                        }
                        
                        else{
                            
                            departmentCountView.isHidden = false
                            collegeCountView.isHidden = false
                            noticeBoardCountView.isHidden = false
                            
                        }
                    }
                    
                    let a =  Int(collegeCountLabel.text!)
                    let b = Int(departmentCountLabel.text!)
                    let c = a! + b!
                    
                    
                    noticeBoardCountLabel.text = String(c)
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
        print("EventDefaultsKeys.DeviceToken",deviceToken)
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
        
        if  segmentId == "1"{
            
            departRefName()
            
        }
        
        else{
            
            collegeRefName()
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

    @IBAction func menu() {
        
        if sideMenuView.isHidden == true{
            
            sideMenuView.isHidden = false
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
}


class ResiveNotice : UITapGestureRecognizer{
    
    var img_url : String!
    var imageFileType : String!
    var titee : String!
    var descrttt : String!
    var img_urls : [String] = []
    
}


class addverisment : UITapGestureRecognizer {
    
    var url : String!
}
