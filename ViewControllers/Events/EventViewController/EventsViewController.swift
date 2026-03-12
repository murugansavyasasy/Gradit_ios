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

@IBOutlet weak var reusee: ReuseView!
@IBOutlet weak var topNameView: UIView!

@IBOutlet weak var searchFullView: UIViewX!

@IBOutlet weak var tapBarView: UIViewX!
@IBOutlet weak var loadingCustom: UIActivityIndicatorView!

@IBOutlet weak var SearchView: UIView!
@IBOutlet weak var logoutView: UIView!
@IBOutlet weak var changeRolesView: UIView!

@IBOutlet weak var redirectLoginView: UIViewX!

@IBOutlet weak var eventTopCountLabl: UILabel!


@IBOutlet weak var eventTopCountView: UIViewX!

@IBOutlet weak var upcomingcountLabl: UILabel!
@IBOutlet weak var upcomingCountView: UIViewX!


@IBOutlet weak var pastCountLbl: UILabel!

@IBOutlet weak var pastCountView: UIViewX!
@IBOutlet weak var profileView: UIView!
@IBOutlet weak var topLabels: UILabel!

@IBOutlet weak var notificationView: UIView!

@IBOutlet weak var topMessageLabel: UILabel!


@IBOutlet weak var clgLogoImg: UIImageView!


@IBOutlet weak var sideMenuView: UIView!



@IBOutlet weak var viewTap: UIView!


@IBOutlet weak var privacyPolicyView: UIView!


@IBOutlet weak var faqView: UIView!
@IBOutlet weak var refreshView: UIView!
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
@IBOutlet weak var swipeMenuHeight: NSLayoutConstraint!





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
var is_write_enabled = ""



override func viewDidAppear(_ animated: Bool) {
    
    print("kljjjjjjjjj")
    
    PreviousAddId = PreviousAddId+1
    print("jkkkkkkk",PreviousAddId)
}



override func viewDidLoad() {
    super.viewDidLoad()
    overrideUserInterfaceStyle = .light
    loadingCustom.startAnimating()
    noDataLabel.isHidden =  true
    noDataTextView.isHidden = true
    sideMenuView.isHidden = true
    searchbar.delegate = self
    searchbar.isHidden  = true
    
    EventTableView.delegate = self
    EventTableView.dataSource = self
    
    let defaults = UserDefaults.standard
    
    collegeid = defaults.string(forKey: DefaultsKeys.collegeid)
    userid = defaults.string(forKey: DefaultsKeys.memberid)
    deparmentId  = defaults.string(forKey: DefaultsKeys.deptid)
    
    sectionId  = defaults.string(forKey: DefaultsKeys.sectionid)
    
    priority = defaults.string(forKey:DefaultsKeys.priority)
    loginType = defaults.string(forKey: DefaultsKeys.loginAsType)
    
    memberName = defaults.string(forKey: DefaultsKeys.memberName)
    colgImg = defaults.string(forKey: DefaultsKeys.colglogo)
    clgLogoImg.sd_setImage(with: URL(string:  colgImg), placeholderImage: UIImage(named: "person.fill"))
    
    topMessageLabel.text = memberName
    
    password  = defaults.string(forKey: DefaultsKeys.Password)
    
    MobileNumber = defaults.string(forKey: DefaultsKeys.mobileNumber)
    
    overAllRefName()
    
    addApi()
    upcoming()
    
    EventTableView.allowsSelection = true
    
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
        
        print("EventsViewController",reusee.callid)
        
        
    }
    
    
    let rownib = UINib(nibName: identifers, bundle: nil)
    EventTableView .register(rownib, forCellReuseIdentifier: identifers)
    
    
    
    
    // tap Bar UiTapGuster.
    
    
    let loginRediectGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
    redirectLoginView.addGestureRecognizer(loginRediectGesture)
    
    let changeRolesGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
    changeRolesView.addGestureRecognizer(changeRolesGesture)
    
    let topnam = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
    topNameView.addGestureRecognizer(changeRolesGesture)
    
    let menuGestureHide = UITapGestureRecognizer(target: self, action: #selector(menu))
    viewTap.addGestureRecognizer(menuGestureHide)
    
    let notificationGesture = UITapGestureRecognizer(target: self, action: #selector(notificationVc))
    notificationView.addGestureRecognizer(notificationGesture)
    
    let refreshGesture = UITapGestureRecognizer(target: self, action: #selector(refreshVc))
    refreshView.addGestureRecognizer(refreshGesture)
    
    let logoutGesture = UITapGestureRecognizer(target: self, action: #selector(logoutPressed))
    logoutView.addGestureRecognizer(logoutGesture)
    
    let faqGesture = UITapGestureRecognizer(target: self, action: #selector(faqRedirect))
    faqView.addGestureRecognizer(faqGesture)
    
    //
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
    
    
    
    
    let Serach = UITapGestureRecognizer(target: self, action: #selector(Searchfield))
    SearchView.addGestureRecognizer(Serach)
    
    
    
}


@IBAction func Searchfield() {
    
    searchbar.isHidden  = false
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
    
    searchbar.isHidden  = true
    
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
            segementId = "1"
            EventTableView.isScrollEnabled = false
            upcoming()
            
        }else if eventSegmentName.selectedSegmentIndex == 1{
            segementId = "2"
            EventTableView.isScrollEnabled = false
            past()
        }
    }
}




func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    if eventSegmentName.selectedSegmentIndex == 0 {
        
        return upcomming.count
    }
    else if eventSegmentName.selectedSegmentIndex == 1{
        
        return eventsRef.count
    }
    
    
    return 0
    
}



func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: identifers, for: indexPath) as!
    EventTableViewCell
    
    cell.selectionStyle = .none
    
    if let selectedCell = selectedCell, selectedCell == indexPath {
        
        cell.discreptionlabl.isHidden = false
        cell.sendbyDefltlab.isHidden = false
        cell.viewclick.isHidden = false
        cell.sendByView.isHidden = false
        cell.createrNameCellLabel.isHidden = false
        cell.arrowImage.image = UIImage(named: "up")
        
    } else{
        
        cell.discreptionlabl.isHidden = true
        cell.sendbyDefltlab.isHidden = true
        cell.viewclick.isHidden = true
        cell.createrNameCellLabel.isHidden = true
        cell.sendByView.isHidden = true
        cell.arrowImage.image = UIImage(named: "down")
    }
    
    
    if eventSegmentName.selectedSegmentIndex == 0 {
        
        let event : Eventsdatadetails = upcomming[indexPath.row]
        
        if event.isappread == "1"{
            
            cell.readImageView.isHidden =  true
            
        }
        
        else {
            
            cell.readImageView.isHidden = false
        }
        
        cell.topicCellLabel.text = event.topic?.capitalized
        cell.eventDateCellLabel.text = event.event_date
        cell.timeDateCellLabel.text = event.event_time
        cell.createrNameCellLabel.text = event.createdbyname
        cell.discreptionlabl.text = event.body
        
        let vc  = viewcilck(target: self, action: #selector(viewclick))
        vc.venue = event.venue
        vc.body = event.body
        vc.event_date = event.event_date
        vc.event_time = event.event_time
        vc.newfilepath = event.newfilepath ?? []
        vc.topic = event.topic
        cell.viewclick.addGestureRecognizer(vc)
        
    }
    
    else if eventSegmentName.selectedSegmentIndex == 1{
        
        
        let event : Eventsdatadetails = eventsRef[indexPath.row]
        
        if event.isappread == "1"{
            
            cell.readImageView.isHidden =  true
            
        }
        
        else {
            
            cell.readImageView.isHidden = false
            //
        }
        
        
        cell.topicCellLabel.text = event.topic?.capitalized
        cell.eventDateCellLabel.text = event.event_date
        cell.timeDateCellLabel.text = event.event_time
        cell.createrNameCellLabel.text = event.createdbyname
        cell.discreptionlabl.text = event.body
        
        let vc  = viewcilck(target: self, action: #selector(viewclick))
        vc.venue = event.venue
        vc.body = event.body
        vc.event_date = event.event_date
        vc.event_time = event.event_time
        vc.newfilepath = event.newfilepath ?? []
        vc.topic = event.topic
        cell.viewclick.addGestureRecognizer(vc)
        
        
    }
    return cell
    
}


func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
    
    let cell = tableView.dequeueReusableCell(withIdentifier: identifers, for: indexPath) as!
    EventTableViewCell
    
    
    if eventSegmentName.selectedSegmentIndex == 0{
        
        var event : Eventsdatadetails = upcomming[indexPath.row]
        if let selectedCells = selectedCell, selectedCells == indexPath {
            
            selectedCell = nil
        }
        
        else{
            
            selectedCell = indexPath
            
            if event.isappread == "0"{
                
                apread(gesture : event.eventdetailsid ?? "")
                
                event.isappread = "1"
                cell.readImageView.isHidden = true
                
            }
        }
    }
    
    
    else if eventSegmentName.selectedSegmentIndex == 1 {
        
        var event : Eventsdatadetails = eventsRef[indexPath.row]
        if let selectedCells = selectedCell, selectedCells == indexPath {
            
            selectedCell = nil
        }
        
        else{
            
            selectedCell = indexPath
            
            if event.isappread == "0"{
                
                apread(gesture : event.eventdetailsid ?? "")
                
                event.isappread = "1"
                cell.readImageView.isHidden = true
                
            }
        }
    }
    EventTableView.beginUpdates()
    EventTableView.endUpdates()
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


@IBAction  func viewclick(gesture : viewcilck){
    
    let vc = EventDetailsViewController(nibName: nil, bundle: nil)
    
    vc.topistr = gesture.topic
    vc.bodystr = gesture.body
    vc.timestr = gesture.event_time
    vc.datestr = gesture.event_date
    vc.venuestr = gesture.venue
    vc.filePath = gesture.newfilepath
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
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3 ){ [self] in
                    self.loadingCustom.stopAnimating()
                    self.loadingCustom.isHidden  = true
                }
            }else {
                noDataLabel.isHidden = false
                noDataTextView.isHidden = false
                noDataLabel.text = success.Message
                
                EventTableView.reloadData()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3 ){ [self] in
                    self.loadingCustom.stopAnimating()
                    self.loadingCustom.isHidden  = true
                }
            }
        case .failure(let failure):
            noDataLabel.isHidden = false
            noDataTextView.isHidden = false
            noDataLabel.text = failure.localizedDescription
           
            EventTableView.reloadData()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3 ){ [self] in
                self.loadingCustom.stopAnimating()
                self.loadingCustom.isHidden  = true
            }
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
                    
                    if (overAllRef.first?.pastevents == "0") && (overAllRef.first?.upcomingevents == "0"){
                        eventTopCountView.isHidden = true
                        upcomingCountView.isHidden = true
                        pastCountView.isHidden = true
                    }else if overAllRef.first?.pastevents == "0"{
                        
                        upcomingCountView.isHidden = false
                        eventTopCountView.isHidden = false
                        pastCountView.isHidden = true
                    }else if overAllRef.first?.upcomingevents == "0"{
                        
                        upcomingCountView.isHidden = true
                        eventTopCountView.isHidden = false
                        pastCountView.isHidden = false
                    }else{
                        upcomingCountView.isHidden = false
                        eventTopCountView.isHidden = false
                        pastCountView.isHidden = false
                    }
                    
                    let a =  Int(upcomingcountLabl.text!)
                    let b = Int(pastCountLbl.text!)
                    let c = a! + b!
                    
                    eventTopCountLabl.text = String(c)
                    
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
    add.member_id = userid
    add.mobile_no = MobileNumber
    add.priority = priority
    add.college_id = collegeid
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
    
    if segementId == "1"{
        
        upcoming()
    }
    
    else{
        
        
        past()
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
        //
        
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

@IBAction func profileRedirect() {
    
    let vc = ProfileViewController(nibName: nil, bundle: nil)
    vc.str = str
    vc.strName = strName
    vc.modalPresentationStyle = .fullScreen
    present(vc, animated: true, completion: nil)
    
}

    @IBAction func priorityVc() {
        let vc = PriorityViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
    }

}

class AddGuster : UITapGestureRecognizer{

var url : String!




}

class viewcilck : UITapGestureRecognizer{

var topic : String!
var body : String!
var event_time : String!
var event_date : String!
var venue     : String!
var newfilepath : [String] = []




}
