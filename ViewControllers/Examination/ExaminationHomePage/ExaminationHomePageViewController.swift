//
//  ExaminationHomePageViewController.swift
//  GraditExmation
//
//  Created by MACBOOKPRO on 03/11/22.
//

import UIKit
import ObjectMapper
import WebKit
import KRProgressHUD

@available(iOS 16.0, *)
class ExaminationHomePageViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    
    @IBOutlet weak var reusee: ReuseView!
    
    @IBOutlet weak var topNameview: UIView!
    @IBOutlet weak var tapBarView: UIViewX!
    @IBOutlet weak var loadingCustom: UIActivityIndicatorView!
    
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var profileView: UIView!
    
    @IBOutlet weak var changeRolesView: UIView!
    
    @IBOutlet weak var pastCountView: UIViewX!
    @IBOutlet weak var upcomingCountView: UIViewX!
    @IBOutlet weak var topCountView: UIViewX!
    @IBOutlet weak var pastCountLabel: UILabel!
    
    @IBOutlet weak var searchFullView: UIViewX!
    @IBOutlet weak var upcomingCountLabel: UILabel!
    
    @IBOutlet weak var ExamTopCountLabel: UILabel!
    @IBOutlet weak var topLabels: UILabel!
    @IBOutlet var overallView: UIView!
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var fullView: UIView!
    
    @IBOutlet weak var priorityView: UIViewX!
    
    
    
    @IBOutlet weak var clgLogoImg: UIImageView!
    
    
    @IBOutlet weak var loginView: UIView!
    
    @IBOutlet weak var helpView: UIView!
    
    
    
    @IBOutlet weak var termsAndConditionView: UIView!
    
    @IBOutlet weak var refreshView: UIView!
    
    @IBOutlet weak var faqView: UIView!
    
    
    @IBOutlet weak var changePasswordView: UIView!
    
    
    @IBOutlet weak var SearchView: UIView!
    
    @IBOutlet weak var privacyPolicyView: UIView!
    
    
    
    @IBOutlet weak var topMemberLabel: UILabel!
    
    
    
    @IBOutlet weak var redirectLoginView: UIViewX!
    
    
    
    @IBOutlet weak var viewTap: UIView!
    @IBOutlet weak var sideMenuView: UIView!
    
    
    @IBOutlet weak var smallImg: UIImageView!
    @IBOutlet weak var bigImg: UIImageView!
    @IBOutlet weak var noDataLabel: UILabel!
    @IBOutlet weak var noDataTextView: UIView!
    
    @IBOutlet weak var adView: UIView!
    @IBOutlet weak var examTableView: UITableView!
    @IBOutlet weak var examSegmentName: UISegmentedControl!
    
    
    @IBOutlet weak var swipeMenuHeight: NSLayoutConstraint!
    
    
    
    
    
    
    var loginDatas : [datalogin]!
    var logindataprinci :[datalogin]!
    var  identifiers = "ExamTableViewCell"
    var upcomings : [examDataDetails] = []
    var pasts : [examDataDetails] = []
    let menuIdentifier = "MenuCollectionViewCell"
    var MenuRefName :[menuApiDataDetails] = []
    var principalRef : [menuApiDataDetails] = []
    var HodRef : [menuApiDataDetails] = []
    var addapiRef : [AddDataDeatils] = []
    var overAllRef    : [overAllDataDetails] = []
    
    var isclosaps = false
    var selectedCell : IndexPath?
    var memberId : String!
    var priority :String!
    var colgId   : String!
    var sectionid : String!
    var loginType : String!
    var mem : String!
    
    var colgImg : String!
    
    var MobileNumber : String!
    var password : String!
    var bigImageString : String!
    var smallImageString : String!
    var urlssadd : String!
    var pass : String!
    var departmentId : String!
    var sectionId : String!
    
    var PreviousAddId : Int = 0
    
    
    var str : [String] = []
    
    var strName : [String] = []
    
    var segmentId : String!
    
    var cloneList : [examDataDetails] = []
    
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
        
        let defaults = UserDefaults.standard
        departmentId = defaults.string(forKey: DefaultsKeys.deptid)
        
        memberId = defaults.string(forKey: DefaultsKeys.memberid)
        priority = defaults.string(forKey: DefaultsKeys.priority)
        colgId = defaults.string(forKey: DefaultsKeys.collegeid)
        sectionid  = defaults.string(forKey: DefaultsKeys.sectionid)
        loginType = defaults.string(forKey: DefaultsKeys.loginAsType)
        mem = defaults.string(forKey: DefaultsKeys.memberName)
        colgImg = defaults.string(forKey: DefaultsKeys.colglogo)
        clgLogoImg.sd_setImage(with: URL(string:  colgImg), placeholderImage: UIImage(named: "person.fill"))
        password = defaults.string(forKey: DefaultsKeys.Password)
        topMemberLabel.text = mem
        MobileNumber = defaults.string(forKey: DefaultsKeys.mobileNumber)
        
        
        
        overAllRefName()
        
        PreviousAddId = PreviousAddId+1
        addApi()
        
        
        
        
        
        upcommingRefName()
        
        
        
        
        
        
        
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
            
            print("CommunicationHomePageViewController",reusee.callid)
            
            
        }
        
        
        let loginRediectGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        redirectLoginView.addGestureRecognizer(loginRediectGesture)
        
        
        
        
        
        let rowNib = UINib(nibName: identifiers, bundle: nil)
        examTableView.register(rowNib, forCellReuseIdentifier: identifiers)
        
        
        
        
        
        noDataLabel.isHidden = true
        noDataTextView.isHidden = true
        
        
        // tap Bar UiTapGuster.
        
        
        
        
        let menuGestureHide = UITapGestureRecognizer(target: self, action: #selector(menu))
        viewTap.addGestureRecognizer(menuGestureHide)
        
        let notificationGesture = UITapGestureRecognizer(target: self, action: #selector(notificationVc))
        notificationView.addGestureRecognizer(notificationGesture)
        
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
        
        
        let profileGesture = UITapGestureRecognizer(target: self, action: #selector(profileRedirect))
        profileView.addGestureRecognizer(profileGesture)
        
        //
        let chagePassword = UITapGestureRecognizer(target: self, action: #selector(changePassowrdVC))
        changePasswordView.addGestureRecognizer(chagePassword)
        
        
        let changeRol = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        changeRolesView.addGestureRecognizer(changeRol)
        
        
        
        let tapname = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        topNameview.addGestureRecognizer(tapname)
        
        
        
        let Serach = UITapGestureRecognizer(target: self, action: #selector(Searchfield))
        SearchView.addGestureRecognizer(Serach)
        
    }
    
    
    
    
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        
        if examSegmentName.selectedSegmentIndex == 0 {
            
            
            let filtered_list : [examDataDetails] = Mapper<examDataDetails>().mapArray(JSONString: cloneList.toJSONString()!)!
            
            
            if !searchText.isEmpty{
                
                
                
                upcomings = filtered_list.filter {
                    
                    
                    
                    
                    
                    
                    
                    $0.examname.lowercased().contains(searchText.lowercased()) || $0.createdbyname.lowercased().contains(searchText.lowercased()) || $0.syllabus.lowercased().contains(searchText.lowercased())  || $0.date.lowercased().contains(searchText.lowercased()) || $0.headerid.lowercased().contains(searchText.lowercased()) || $0.subjectname.lowercased().contains(searchText.lowercased())
                    
                    
                    
                }
                
                
                
                
            }else{
                
                
                
                upcomings = filtered_list
                
                
                
                print("pendingOrder")
                
                
                
            }
            
            
            
            
            
            
            
            if upcomings.count > 0{
                
                
                
                print ("searchListPendigCount",upcomings.count)
                noDataLabel.isHidden = true
                noDataTextView.isHidden = true
                
                
            }else{
                
                
                
                
                noDataLabel.isHidden = false
                noDataTextView.isHidden = false
                noDataLabel.text = " No Records Found "
                
                
            }
            
            
            
        }
        
        
        
        else if examSegmentName.selectedSegmentIndex == 1 {
            
            
            
            
            let filtered_list : [examDataDetails] = Mapper<examDataDetails>().mapArray(JSONString: cloneList.toJSONString()!)!
            
            
            
            
            if !searchText.isEmpty{
                
                
                
                pasts = filtered_list.filter {
                    
                    
                    
                    
                    
                    
                    
                    $0.examname.lowercased().contains(searchText.lowercased()) || $0.createdbyname.lowercased().contains(searchText.lowercased()) || $0.syllabus.lowercased().contains(searchText.lowercased())  || $0.date.lowercased().contains(searchText.lowercased()) || $0.headerid.lowercased().contains(searchText.lowercased()) || $0.subjectname.lowercased().contains(searchText.lowercased())
                    
                    
                    
                }
                
                
                
                
                
                
                
            }else{
                
                
                
                pasts = filtered_list
                
                
                
                print("pendingOrder")
                
                
                
            }
            
            
            
            
            
            
            
            if pasts.count > 0{
                
                
                
                print ("searchListPendigCount",pasts.count)
                
                
                noDataLabel.isHidden = true
                noDataTextView.isHidden = true
                
            }else{
                
                
                
                
                
                noDataLabel.isHidden = false
                noDataTextView.isHidden = false
                noDataLabel.text = " No Records Found "
                
            }
            
            
            
            
        }
        
        
        
        examTableView.reloadData()
        
        
        
        
        
        
        
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
        noDataTextView.isHidden = true
        noDataLabel.isHidden = true
        
        
        searchbar.resignFirstResponder()
        
        
        
    }
    
    
    @objc func dismissKeyboards() {
        
        sideMenuView.isHidden = true
        view.endEditing(true)
        
    }
    
    
    @IBAction func Searchfield() {
        
        
        searchbar.isHidden  = false
        searchFullView .isHidden = false
        
        
        
        
        
        
    }
    
    
    
    @IBAction func priorityVc() {
        
        let vc = PriorityViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
    }
    
    
    
    @IBAction func chngeVc(){
        
        
        print("sarannn")
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        
        sideMenuView.isHidden = true
        
        
    }
    
    
    
    @IBAction func menu() {
        
        
        
        sideMenuView.isHidden = false
        
        
        
    }
    
    
    
    
    @IBAction func ProfileBtn(_ sender: Any) {
        
        
        
        
        let vc = ProfileViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
        
        
    }
    @IBAction func adLoad(gesture : addViewGesture) {
        
        
        
        let vc = ShowExaminationAddViewController(nibName: nil, bundle: nil)
        
        
        vc.addString = gesture.url
        print("adssdedd",gesture.url)
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true,completion: nil)
        
    }
    
    
    
    
    @IBAction func examSegment(_ sender: Any) {
        
        if is_read_enabled == "1"{
            
            if examSegmentName.selectedSegmentIndex == 0{
                segmentId = "1"
                selectedCell = IndexPath()
                examTableView.isScrollEnabled = false
                upcommingRefName()
                
            }
            else if examSegmentName.selectedSegmentIndex == 1  {
                segmentId = "2"
                selectedCell = IndexPath()
                examTableView.isScrollEnabled = false
                pastRefName()
                
                
            }
            
        }else{
            
            
            
        }
        
        
        
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if examSegmentName.selectedSegmentIndex == 0 {
            return upcomings.count
        }
        
        
        else  if examSegmentName.selectedSegmentIndex == 1 {
            
            
            return pasts.count
            
            
        }
        
        return 0
        
    }
    
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifiers, for: indexPath) as!
        
        ExamTableViewCell
        
        
        cell.selectionStyle = .none
        
        if let selectedCells = selectedCell, selectedCells == indexPath {
            
            
            cell.cellExamDate.isHidden = false
            cell.cellSendByLabel.isHidden = false
            cell.cellExamName.isHidden = false
            cell.cellExamVenue.isHidden = false
            cell.cellSyllabus.isHidden = false
            cell.cellSyllabus.isHidden = false
            cell.venuDefaultLabl.isHidden = false
            cell.sylubsDefaltLabl.isHidden = false
            cell.syubsDotLabl.isHidden = false
            cell.venuDotLabl.isHidden = false
            cell.arrowImgView.isHidden = true
            cell.sentByView.isHidden = false
            
            
            
        }
        
        else{
            
            
            cell.cellSendByLabel.isHidden = true
            
            cell.cellExamVenue.isHidden = true
            cell.cellSyllabus.isHidden = true
            cell.cellSyllabus.isHidden = true
            cell.venuDefaultLabl.isHidden = true
            cell.sylubsDefaltLabl.isHidden = true
            cell.syubsDotLabl.isHidden = true
            cell.venuDotLabl.isHidden = true
            cell.arrowImgView.isHidden = false
            
            cell.sentByView.isHidden = true
            
        }
        
        
        if examSegmentName.selectedSegmentIndex == 0{
            
            
            let upcom : examDataDetails = upcomings[indexPath.row]
            
            cell.cellExamDate.text = upcom.date + " " + upcom.session
            cell.cellSendByLabel.text = upcom.createdbyname
            cell.cellExamName.text = upcom.examname.capitalized
            cell.cellExamVenue.text = upcom.examvenue
            
            cell.cellSyllabus.text = upcom.syllabus
            
            
            
            let  play = ExamViewPageGesture(target: self, action: #selector(connected))
            play.titleLabel = upcom.examname
            play.examHeaderId = upcom.headerid
            cell.nextView.addGestureRecognizer(play)
            
            
        }
        
        
        else if examSegmentName.selectedSegmentIndex == 1 {
            
            
            
            let past : examDataDetails = pasts[indexPath.row]
            
            cell.cellExamDate.text = past.date
            cell.cellSendByLabel.text = past.createdbyname
            cell.cellExamName.text = past.examname.capitalized
            cell.cellExamVenue.text = past.examvenue
            cell.cellSyllabus.text = past.subjectname
            cell.cellSyllabus.text = past.syllabus
            
            
            let  play = ExamViewPageGesture(target: self, action: #selector(connected))
            play.titleLabel = past.examname
            play.examHeaderId = past.headerid
            cell.nextView.addGestureRecognizer(play)
            
            
            
        }
        
        return cell
    }
    
    
    @IBAction func connected(gesture : ExamViewPageGesture) {
        
        if examSegmentName.selectedSegmentIndex == 0{
            
            
            
            let vc = SenderExaminationNextPageViewController(nibName: nil, bundle: nil)
            vc.examId = gesture.examHeaderId
            
            vc.PreviousAddId = PreviousAddId
            
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            //
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
            
            
            
        }
        
        
        else if examSegmentName.selectedSegmentIndex == 1 {
            let vc = ExaminationDetailsViewControllerViewController(nibName: nil, bundle: nil)
            vc.examHeaderId = gesture.examHeaderId
            vc.titleName = gesture.titleLabel
            vc.prevoiusAddId = PreviousAddId
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
        }
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        examTableView.deselectRow(at: indexPath, animated: true)
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifiers, for: indexPath) as!
        
        ExamTableViewCell
        
        
        //
        if let selectedCells = selectedCell, selectedCells == indexPath {
            
            selectedCell = nil
            
            if self.isclosaps == false {
                
                isclosaps = true
                
            }
            
            else{
                
                
                
                isclosaps = false
            }
            
        }
        
        else{
            
            selectedCell = indexPath
            //
            
            if self.isclosaps == false {
                
                isclosaps = true
                
            }
            
            else{
                
                
                
                isclosaps = false
            }
            
            
            
        }
        
        
        examTableView.beginUpdates()
        examTableView.endUpdates()
        examTableView.reloadData()
        
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        if let selectedCell = selectedCell, selectedCell == indexPath {
            
            return 200
            
        } else {
            
            return 120
            
        }
        
    }
    
    
    func upcommingRefName() {
        
        let upcoming = examModal()
        
        upcoming.userid   = memberId
        upcoming.collegeid = colgId
        upcoming.sectionid = sectionid
        upcoming.appid    = "2"
        upcoming.priority = priority
        upcoming.type     = "upcomingexams"
        
        
        
        
        
        let upcomingStr = upcoming.toJSONString()
        
        
        examRequest.call_request(param: upcomingStr!){ [self]
            
            (res) in
            
            
            let departResp : examResponce =
            Mapper<examResponce>().map(JSONString: res)!
            
            
            print("order data",departResp)
            
            
            
            if departResp.Status == 1{
                
                upcomings = departResp.data
                cloneList = departResp.data
                
                
                noDataLabel.isHidden = true
                noDataTextView.isHidden = true
                examTableView.isScrollEnabled = true
                examTableView.delegate = self
                examTableView.dataSource = self
                
                examTableView.reloadData()
                
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3 ){ [self] in
                    
                    loadingCustom.stopAnimating()
                    
                    
                    loadingCustom.isHidden  = true
                    
                }
            }
            
            else{
                
                noDataLabel.isHidden = false
                noDataTextView.isHidden = false
                noDataLabel.text = departResp.Message
                examTableView.delegate = self
                examTableView.dataSource = self
                
                examTableView.reloadData()
                
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3 ){ [self] in
                    
                    loadingCustom.stopAnimating()
                    
                    
                    loadingCustom.isHidden  = true
                    
                }
            }
            
            
            
            
        }
        
        
    }
    
    
    func pastRefName() {
        
        let past = examModal()
        
        past.userid   = memberId
        past.collegeid = colgId
        past.sectionid = sectionid
        past.appid    = "2"
        past.priority = priority
        past.type     = "pastexams"
        
        
        let pastStr = past.toJSONString()
        
        
        examRequest .call_request(param: pastStr!){ [self]
            
            (res) in
            
            
            let pastResp : examResponce =
            Mapper<examResponce>().map(JSONString: res)!
            
            print("order data",pastResp)
            
            
            
            
            print("order data",pastResp)
            
            
            
            if pastResp.Status == 1{
                
                pasts = pastResp.data
                
                cloneList = pastResp.data
                
                
                noDataLabel.isHidden = true
                noDataTextView.isHidden = true
                examTableView.delegate = self
                examTableView.dataSource = self
                examTableView.isScrollEnabled = true
                
                
                examTableView.reloadData()
                
                
            }
            
            else{
                
                noDataLabel.isHidden = false
                noDataTextView.isHidden = false
                noDataLabel.text = pastResp.Message
                examTableView.delegate = self
                examTableView.dataSource = self
                
                examTableView.reloadData()
                
                
                
            }
            
            
        }
        
        
        
        
    }
    
    
    
    func overAllRefName() {
        
        let overall = overAllModal()
        
        overall.userid   =  memberId
        overall.menuid       = "3"
        overall.collegeid    =  colgId
        overall.departmentid =  departmentId
        overall.sectionid    =  sectionid
        overall.appid        = "2"
        overall.priority     = priority
        
        
        let overallStr = overall.toJSONString()
        
        
        overAllRequest .call_request(param: overallStr!){ [self]
            
            (res) in
            
            
            let overallResp : overAllResponce =
            Mapper<overAllResponce>().map(JSONString: res)!
            
            print("order data",overallResp)
            
            
            
            
            
            
            
            if overallResp.Status == 1{
                
                overAllRef = overallResp.data
                
                for i in overAllRef {
                    
                    
                    
                    upcomingCountLabel.text = i.upcomingexams
                    
                    
                    pastCountLabel.text = i.pastexams
                    
                    
                    if (i.upcomingexams == "0") && (i.pastexams == "0"){
                        
                        topCountView.isHidden = true
                        upcomingCountView.isHidden = true
                        pastCountView.isHidden = true
                        
                    }
                    
                    
                    else if i.upcomingexams == "0"{
                        
                        
                        topCountView.isHidden = false
                        upcomingCountView.isHidden = true
                        pastCountView.isHidden = false
                        
                    }
                    
                    else if i.pastexams == "0"{
                        
                        
                        topCountView.isHidden = false
                        upcomingCountView.isHidden = false
                        pastCountView.isHidden = true
                        
                        
                    }
                    
                    else{
                        
                        
                        topCountView.isHidden = false
                        upcomingCountView.isHidden = false
                        pastCountView.isHidden = false
                        
                    }
                    //
                }
                
                
                
                let a =  Int(upcomingCountLabel.text!)
                let b = Int(pastCountLabel.text!)
                let c = a! + b!
                
                ExamTopCountLabel.text = String(c)
                
                
                
            }
            
            else{
                
                topCountView.isHidden = true
                upcomingCountView.isHidden = true
                pastCountView.isHidden = true
                
                
                
            }
        }
        
        //
    }
    
    func addApi(){
        
        
        var add = AddApiModal()
        
        let defaults = UserDefaults.standard
        var deviceToken = defaults.string(forKey:DefaultsKeys.DeviceToken )
        add.device_token = deviceToken
        print("EventDefaultsKeys.DeviceToken",deviceToken)
        add.member_id = memberId
        add.mobile_no = MobileNumber
        add.priority = priority
        add.college_id = colgId
        add.previous_add_id = PreviousAddId
        
        APiCallManager.shared.callApi(url: APIEndpoints.GetAddsForCollege, httpMethod: .get, queryParam: nil, requestBody: nil
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
        
        if segmentId == "1"{
            
            upcommingRefName()
        }
        else{
            
            pastRefName()
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
    
    
    @IBAction func profileRedirect() {
        
        let vc = ProfileViewController(nibName: nil, bundle: nil)
        vc.str = str
        vc.strName = strName
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
    }
    
}



class addViewGesture : UITapGestureRecognizer {
    
    
    var url : String!
}


class ExamViewPageGesture : UITapGestureRecognizer {
    
    
    var examHeaderId : String!
    var titleLabel : String!
    //    var
}
