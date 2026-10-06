//
//  EventsViewController.swift
//  EventsGradit
//
//  Created by MACBOOKPRO on 29/10/22.
//

import UIKit
import ObjectMapper
import WebKit
import KRProgressHUD
@available(iOS 16.0, *)
class EventsViewController: UIViewController, UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate{
    
    
    @IBOutlet weak var searchFullView: UIViewX!
    @IBOutlet weak var tapBarView: CustomTabBar!
    @IBOutlet weak var logoutView: UIView!
    @IBOutlet weak var changeRolesView: UIView!
    @IBOutlet weak var eventTopCountLabl: UILabel!
    @IBOutlet weak var eventTopCountView: UIViewX!
    @IBOutlet weak var upcomingcountLabl: UILabel!
    @IBOutlet weak var upcomingCountView: UIViewX!
    @IBOutlet weak var pastCountLbl: UILabel!
    @IBOutlet weak var pastCountView: UIViewX!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var sideMenuView: UIView!
    @IBOutlet weak var privacyPolicyView: UIView!
    @IBOutlet weak var faqView: UIView!
    @IBOutlet weak var helpView: UIView!
    @IBOutlet weak var termsAndConditionView: UIView!
    @IBOutlet weak var changePasswordView: UIView!
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var bigImg: UIImageView!
    @IBOutlet weak var noDataLabel: UILabel!
    @IBOutlet weak var noDataTextView: UIView!
    @IBOutlet weak var smallImg: UIImageView!
    @IBOutlet weak var adView: UIView!
    @IBOutlet weak var eventSegmentName: UISegmentedControl!
    @IBOutlet weak var EventTableView: UITableView!
    
    
    var identifers = "EventTableViewCell"
    var eventsRef     : [Eventsdatadetails] = []
    var upcomming   : [Eventsdatadetails] = []
    let menuIdentifier = "MenuCollectionViewCell"
    var MenuRefName :[menuApiDataDetails] = []
    var addapiRef : [AddDataDeatils] = []
    var overAllRef    : [overAllDataDetails] = []
    var collegeid : String!
    var userid : String!
    var priority : String!
    var loginType : String!
    var memberName : String!
    var colgImg : String!
    var MobileNumber : String!
    var deparmentId : String!
    var sectionId : String!
    var PreviousAddId : Int = 2
    var password : String!
    var loginDatas : [datalogin]!
    var logindataprinci :[datalogin]!
    var str : [String] = []
    var strName : [String] = []
    var selectedCell:IndexPath?
    var segementId : String!
    var cloneList : [Eventsdatadetails] = []
    var is_read_enabled = ""
    
    override func viewDidAppear(_ animated: Bool) {
        PreviousAddId = PreviousAddId+1
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        noDataLabel.isHidden =  true
        noDataTextView.isHidden = true
        sideMenuView.isHidden = true
        searchbar.delegate = self
        searchFullView.isHidden = true
        tapBarView.delegate = self
        EventTableView.delegate = self
        EventTableView.dataSource = self
        EventTableView.showsVerticalScrollIndicator = false
        EventTableView.showsHorizontalScrollIndicator = false
        let defaults = UserDefaults.standard
        
        collegeid = defaults.string(forKey: DefaultsKeys.collegeid)
        userid = defaults.string(forKey: DefaultsKeys.memberid)
        deparmentId  = defaults.string(forKey: DefaultsKeys.deptid)
        sectionId  = defaults.string(forKey: DefaultsKeys.sectionid)
        
        priority = defaults.string(forKey:DefaultsKeys.priority)
        loginType = defaults.string(forKey: DefaultsKeys.loginAsType)
        password  = defaults.string(forKey: DefaultsKeys.Password)
        
        MobileNumber = defaults.string(forKey: DefaultsKeys.mobileNumber)
        
        overAllRefName()
        addApi()
        upcoming()
        EventTableView.allowsSelection = true
        view.backgroundColor = .priorityColor
        let rownib = UINib(nibName: identifers, bundle: nil)
        EventTableView .register(rownib, forCellReuseIdentifier: identifers)
        
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
        
        let profileGesture = UITapGestureRecognizer(target: self, action: #selector(profileRedirect))
        profileView.addGestureRecognizer(profileGesture)
        
        let chagePassword = UITapGestureRecognizer(target: self, action: #selector(changePassowrdVC))
        changePasswordView.addGestureRecognizer(chagePassword)
        
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let text = searchText
        if text.isEmpty {
            if eventSegmentName.selectedSegmentIndex == 0 {
                upcomming = cloneList
            }else{
                eventsRef = cloneList
            }
        }else{
            
            let filtered = cloneList.filter {
                ($0.event_date ?? "").localizedCaseInsensitiveContains(text) ||
                ($0.event_time ?? "").localizedCaseInsensitiveContains(text) ||
                ($0.topic ?? "").localizedCaseInsensitiveContains(text) ||
                ($0.body ?? "").localizedCaseInsensitiveContains(text) ||
                ($0.venue ?? "").localizedCaseInsensitiveContains(text) ||
                ($0.createdby ?? "").localizedCaseInsensitiveContains(text)
            }
            
            if eventSegmentName.selectedSegmentIndex == 0 {
                upcomming = filtered
            } else {
                eventsRef = filtered
            }
        }
        
        let count = eventSegmentName.selectedSegmentIndex == 0
        ? upcomming.count
        : eventsRef.count
        
        let hasData = count > 0
        noDataTextView.isHidden = hasData
        noDataLabel.isHidden = hasData
        noDataLabel.text = hasData ? "" : "No Records Found"
        EventTableView.reloadData()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchbar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchbar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchFullView.isHidden  = true
        noDataTextView.isHidden = true
        noDataLabel.isHidden = true
        searchbar.resignFirstResponder()
        
    }
    
    @objc func dismissKeyboards() {
        sideMenuView.isHidden = true
        view.endEditing(true)
    }
    
    
    @IBAction func adLoad(gesture : AddGuster) {
        let vc = AddEventsViewController(nibName: nil, bundle: nil)
        vc.addWebUrl = gesture.url
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
    }
    
    @IBAction func segmentControl(_ sender: Any) {
        if is_read_enabled == "1"{
            if eventSegmentName.selectedSegmentIndex == 0 {
                upcoming()
            }else{
                past()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventSegmentName.selectedSegmentIndex == 0 ? upcomming.count:eventsRef.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifers, for: indexPath) as!
        EventTableViewCell
        
        cell.selectionStyle = .none
        
        let event = eventSegmentName.selectedSegmentIndex == 0 ? upcomming[indexPath.row]: eventsRef[indexPath.row]
        cell.readImageView.backgroundColor =  event.isappread == "1" ? .clear : .red.withAlphaComponent(0.3)
        cell.topicCellLabel.text = event.topic?.capitalized
        cell.eventDateCellLabel.text = event.event_date
        cell.timeDateCellLabel.text = event.event_time
        cell.createrNameCellLabel.text = event.createdbyname
        cell.discreptionlabl.text = event.body
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if eventSegmentName.selectedSegmentIndex == 0{
            if upcomming[indexPath.row].isappread == "0"{
                apread(gesture : upcomming[indexPath.row].eventdetailsid ?? "")
                upcomming[indexPath.row].isappread = "1"
            }
        }else if eventSegmentName.selectedSegmentIndex == 1 {
            if eventsRef[indexPath.row].isappread == "0"{
                apread(gesture : eventsRef[indexPath.row].eventdetailsid ?? "")
                eventsRef[indexPath.row].isappread = "1"
            }
        }
        let event = eventSegmentName.selectedSegmentIndex == 0 ? upcomming[indexPath.row]: eventsRef[indexPath.row]
        viewclick(gesture: event)
        EventTableView.reloadData()
        
    }
    
    
    
    func apread(gesture : String){
        
        var readApiStatus  = AppReadStatusModal()
        
        readApiStatus.msgtype = "event"
        readApiStatus.priority = priority
        readApiStatus.userid = userid
        readApiStatus.detailsid = gesture
        
        APiCallManager.shared.callApi(url: APIEndpoints.Appreadstatus, httpMethod: .post, queryParam: nil, requestBody: readApiStatus) {[weak self]  (result:Result<ReadStausApiResponce, Error>) in
            
            guard let self = self else {return}
            
            switch result {
            case .success(let success):
                EventTableView.reloadData()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    
    func viewclick(gesture : Eventsdatadetails){
        let vc = EventDetailsViewController(nibName: nil, bundle: nil)
        vc.topistr = gesture.topic
        vc.bodystr = gesture.body
        vc.timestr = gesture.event_time
        vc.datestr = gesture.event_date
        vc.venuestr = gesture.venue
        vc.filePath = gesture.newfilepath ?? []
        vc.previousAdId = PreviousAddId
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    func past() {
        
        var evnt = eventsModal()
        
        evnt.userid     =  userid
        evnt.appid      =  collegeid
        evnt.priority   =  priority
        evnt.type       =  "pastevents"
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.GetEventListByType,
            httpMethod: .post,
            queryParam: nil,
            requestBody: evnt
        ) {[weak self] (result:Result<eventsResponce, Error>) in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let success):
                if success.Status == 1{
                    eventsRef = success.data ?? []
                    cloneList = success.data ?? []
                    EventTableView.isScrollEnabled = true
                    noDataLabel.isHidden = true
                    noDataTextView.isHidden = true
                    EventTableView.reloadData()
                } else{
                    
                    noDataLabel.isHidden = false
                    noDataTextView.isHidden = false
                    noDataLabel.text = success.Message
                    
                    EventTableView.reloadData()
                }
            case .failure(let failure):
                noDataLabel.isHidden = false
                noDataTextView.isHidden = false
                noDataLabel.text = failure.localizedDescription
                
                EventTableView.reloadData()
            }
        }
    }
    
    
    func upcoming() {
        
        var evnt = eventsModal()
        
        evnt.userid     =  userid
        evnt.appid      =  collegeid
        evnt.priority   =  priority
        evnt.type       =  "upcomingevents"
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.GetEventListByType,
            httpMethod: .post,
            queryParam: nil,
            requestBody: evnt
        ) {[weak self] (result:Result<eventsResponce, Error>) in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let success):
                if success.Status == 1 {
                    upcomming = success.data ?? []
                    cloneList  = success.data ?? []
                    noDataLabel.isHidden = true
                    noDataTextView.isHidden = true
                    EventTableView.isScrollEnabled = true
                    
                    EventTableView.reloadData()
                }else {
                    noDataLabel.isHidden = false
                    noDataTextView.isHidden = false
                    noDataLabel.text = success.Message
                    
                    EventTableView.reloadData()
                }
            case .failure(let failure):
                noDataLabel.isHidden = false
                noDataTextView.isHidden = false
                noDataLabel.text = failure.localizedDescription
                EventTableView.reloadData()
            }
        }
        
    }
    
    
    
    func overAllRefName() {
        
        var overall = overAllModal()
        overall.userid   =  userid
        overall.menuid       = "9"
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
                    pastCountLbl.text =  overAllRef.first?.pastevents
                    upcomingcountLabl.text = overAllRef.first?.upcomingevents
                    upcomingCountView.isHidden = overAllRef.first?.upcomingevents == "0"
                    eventTopCountView.isHidden = overAllRef.first?.upcomingevents == "0" && overAllRef.first?.pastevents == "0"
                    pastCountView.isHidden = overAllRef.first?.pastevents == "0"
                    eventTopCountLabl.text = String((Int(upcomingcountLabl.text!) ?? 0) + (Int(pastCountLbl.text!) ?? 0))
                    
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
        AlertHelper.showOKCancelAlert(on: self, title: "", message: "Are you sure do you want to logout",okTitle: "",cancelTitle: "",okAction:{
            
            UserDefaults.standard.removeObject(forKey: DefaultsKeys.mobileNumber)
            let vc = LoginVc(nibName: nil, bundle: nil)
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        })
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
    
    @IBAction func profileRedirect() {
        let vc = ProfileViewController(nibName: nil, bundle: nil)
        vc.str = str
        vc.strName = strName
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func priorityVc() {
        let vc = PriorityScreenVC(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
    }
    
}
@available(iOS 16.0, *)
extension EventsViewController:CustomTabBarDelegate{
    func didTapSearch() {
        searchFullView.isHidden.toggle()
    }
    
    func didTapSideMenu() {
        sideMenuView.isHidden.toggle()
    }
}
class AddGuster : UITapGestureRecognizer{
    var url : String!
}

