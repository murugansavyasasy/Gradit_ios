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
    
    
    
    if eventSegmentName.selectedSegmentIndex == 0{
        
        let filtered_list : [Eventsdatadetails] = Mapper<Eventsdatadetails>().mapArray(JSONString: cloneList.toJSONString()!)!
        
        
        
        
        if !searchText.isEmpty{
            
            
            
            upcomming = filtered_list.filter {
                
                
                
                $0.event_date.lowercased().contains(searchText.lowercased()) || $0.event_time.lowercased().contains(searchText.lowercased()) || $0.body.lowercased().contains(searchText.lowercased()) ||  $0.topic.lowercased().contains(searchText.lowercased()) || $0.venue.lowercased().contains(searchText.lowercased()) ||  $0.createdby.lowercased().contains(searchText.lowercased())
                
                
                
            }
            
            
            
            
        }else{
            
            
            
            upcomming = filtered_list
            
            
            
        }
        
        
        
        
        
        
        
        if upcomming.count > 0{
            
            
            
            noDataTextView.isHidden = true
            noDataLabel.isHidden = true
            
            
        }else{
            
            
            
            
            noDataTextView.isHidden = false
            noDataLabel.isHidden = false
            noDataLabel.text = "No Records Found"
            
        }
        
        
        
    }
    
    
    
    
    
    else if eventSegmentName.selectedSegmentIndex == 1{
        
        
        
        
        let filtered_list : [Eventsdatadetails] = Mapper<Eventsdatadetails>().mapArray(JSONString: cloneList.toJSONString()!)!
        
        
        
        if !searchText.isEmpty{
            
            
            
            eventsRef = filtered_list.filter {
                
                
                
                
                
                
                $0.event_date.lowercased().contains(searchText.lowercased()) || $0.event_time.lowercased().contains(searchText.lowercased()) || $0.body.lowercased().contains(searchText.lowercased()) ||  $0.topic.lowercased().contains(searchText.lowercased()) || $0.venue.lowercased().contains(searchText.lowercased()) ||  $0.createdby.lowercased().contains(searchText.lowercased())
                
                
                
                
                
            }
            
            
            
            
            
            
            
        }else{
            
            
            
            eventsRef = filtered_list
            
            
            
            
        }
        
        
        
        
        
        
        
        if eventsRef.count > 0{
            
            
            
            print ("searchListPendigCount",eventsRef.count)
            
            noDataTextView.isHidden = true
            noDataLabel.isHidden = true
            
            
        }else{
            
            
            
            
            noDataTextView.isHidden = false
            noDataLabel.isHidden = false
            noDataLabel.text = "No Records Found"
            
        }
        
        
        
        
    }
    
    
    
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
            
        }
        
        else if eventSegmentName.selectedSegmentIndex == 1{
            segementId = "2"
            EventTableView.isScrollEnabled = false
            past()
            
            
        }
        
    }else{}
    
    
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
        
        cell.topicCellLabel.text = event.topic.capitalized
        cell.eventDateCellLabel.text = event.event_date
        cell.timeDateCellLabel.text = event.event_time
        cell.createrNameCellLabel.text = event.createdbyname
        cell.discreptionlabl.text = event.body
        
        let vc  = viewcilck(target: self, action: #selector(viewclick))
        vc.venue = event.venue
        vc.body = event.body
        vc.event_date = event.event_date
        vc.event_time = event.event_time
        vc.newfilepath = event.newfilepath
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
        
        
        cell.topicCellLabel.text = event.topic.capitalized
        cell.eventDateCellLabel.text = event.event_date
        cell.timeDateCellLabel.text = event.event_time
        cell.createrNameCellLabel.text = event.createdbyname
        cell.discreptionlabl.text = event.body
        
        let vc  = viewcilck(target: self, action: #selector(viewclick))
        vc.venue = event.venue
        vc.body = event.body
        vc.event_date = event.event_date
        vc.event_time = event.event_time
        vc.newfilepath = event.newfilepath
        vc.topic = event.topic
        cell.viewclick.addGestureRecognizer(vc)
        
        
    }
    return cell
    
}


func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
    
    let cell = tableView.dequeueReusableCell(withIdentifier: identifers, for: indexPath) as!
    EventTableViewCell
    
    
    if eventSegmentName.selectedSegmentIndex == 0{
        
        let event : Eventsdatadetails = upcomming[indexPath.row]
        if let selectedCells = selectedCell, selectedCells == indexPath {
            
            selectedCell = nil
        }
        
        else{
            
            selectedCell = indexPath
            
            if event.isappread == "0"{
                
                apread(gesture : event.eventdetailsid)
                
                event.isappread = "1"
                cell.readImageView.isHidden = true
                
            }
        }
    }
    
    
    else if eventSegmentName.selectedSegmentIndex == 1 {
        
        let event : Eventsdatadetails = eventsRef[indexPath.row]
        if let selectedCells = selectedCell, selectedCells == indexPath {
            
            selectedCell = nil
        }
        
        else{
            
            selectedCell = indexPath
            
            if event.isappread == "0"{
                
                apread(gesture : event.eventdetailsid)
                
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
    
    
    let readApiStatus  = AppReadStatusModal()
    
    readApiStatus.msgtype = "event"
    readApiStatus.priority = priority
    readApiStatus.userid = userid
    readApiStatus.detailsid = gesture
    print("sertt",gesture)
    
    
    let commuS = readApiStatus.toJSONString()
    
    ApiReadStatusRequest .call_request(param: commuS!){ [self]
        
        (res) in
        
        
        let com : ReadStausApiResponce =
        Mapper<ReadStausApiResponce>().map(JSONString: res)!
        
        EventTableView.delegate = self
        EventTableView.dataSource = self
        EventTableView.reloadData()
        
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
    
    let evnt = eventsModal()
    
    evnt.userid     =  userid
    evnt.appid      =  collegeid
    evnt.priority   =  priority
    evnt.type       =  "pastevents"
    
    
    
    let eventStr = evnt.toJSONString()
    
    
    EventsRequest .call_request(param: eventStr!){ [self]
        
        (res) in
        
        
        let eventResp : eventsResponce =
        Mapper<eventsResponce>().map(JSONString: res)!
        
        print("order data",eventResp)
        
        if eventResp.Status == 1{
            
            eventsRef = eventResp.data
            cloneList = eventResp.data
            
            EventTableView.isScrollEnabled = true
            noDataLabel.isHidden = true
            noDataTextView.isHidden = true
            EventTableView.delegate = self
            EventTableView.dataSource = self
            EventTableView.reloadData()
            
            
        }
        
        else{
            
            
            noDataLabel.isHidden = false
            noDataTextView.isHidden = false
            noDataLabel.text = eventResp.Message
            EventTableView.delegate = self
            EventTableView.dataSource = self
            EventTableView.reloadData()
            
            
        }
        
        
    }
    
}


func upcoming() {
    
    let evnt = eventsModal()
    
    evnt.userid     =  userid
    evnt.appid      =  collegeid
    evnt.priority   =  priority
    evnt.type       =  "upcomingevents"
    
    
    
    let eventStr = evnt.toJSONString()
    
    
    EventsRequest .call_request(param: eventStr!){ [self]
        
        (res) in
        
        
        let eventResp : eventsResponce =
        Mapper<eventsResponce>().map(JSONString: res)!
        
        print("order data",eventResp)
        
        
        
        if eventResp.Status == 1{
            
            
            upcomming = eventResp.data
            cloneList  = eventResp.data
            noDataLabel.isHidden = true
            noDataTextView.isHidden = true
            EventTableView.isScrollEnabled = true
            EventTableView.delegate = self
            EventTableView.dataSource = self
            EventTableView.reloadData()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3 ){ [self] in
                
                loadingCustom.stopAnimating()
                
                
                loadingCustom.isHidden  = true
                
            }
            
        }
        
        else{
            
            noDataLabel.isHidden = false
            noDataTextView.isHidden = false
            noDataLabel.text = eventResp.Message
            EventTableView.delegate = self
            EventTableView.dataSource = self
            EventTableView.reloadData()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3 ){ [self] in
                
                loadingCustom.stopAnimating()
                
                
                loadingCustom.isHidden  = true
                
            }
            
            
            print("eventResp.Message")
        }
        
    }
    
}



func overAllRefName() {
    
    let overall = overAllModal()
    
    overall.userid   =  userid
    overall.menuid       = "9"
    overall.collegeid    = collegeid
    overall.departmentid =  deparmentId
    overall.sectionid    =   sectionId
    overall.appid        = "2"
    overall.priority     = priority
    
    let overallStr = overall.toJSONString()
    
    
    print("oooooooooo ",overall.toJSON())
    
    
    
    overAllRequest .call_request(param: overallStr!){ [self]
        
        (res) in
        
        
        let overallResp : overAllResponce =
        Mapper<overAllResponce>().map(JSONString: res)!
        
        print("order data",overallResp)
        
        
        if overallResp.Status == 1 {
            
            overAllRef = overallResp.data
            
            
            
            
            
            pastCountLbl.text =  overAllRef[0].pastevents
            upcomingcountLabl.text = overAllRef[0].upcomingevents
            
            if (overAllRef[0].pastevents == "0") && (overAllRef[0].upcomingevents == "0"){
                
                
                eventTopCountView.isHidden = true
                upcomingCountView.isHidden = true
                pastCountView.isHidden = true
                
                
                
            }
            
            else if overAllRef[0].pastevents == "0"{
                
                upcomingCountView.isHidden = false
                eventTopCountView.isHidden = false
                pastCountView.isHidden = true
                
                
                
                
            }
            
            else if overAllRef[0].upcomingevents == "0"{
                
                
                upcomingCountView.isHidden = true
                eventTopCountView.isHidden = false
                pastCountView.isHidden = false
                
                
                
            }
            
            
            else{
                upcomingCountView.isHidden = false
                eventTopCountView.isHidden = false
                pastCountView.isHidden = false
                
                
                
                
            }
            
            
            
            
            
            let a =  Int(upcomingcountLabl.text!)
            let b = Int(pastCountLbl.text!)
            let c = a! + b!
            
            
            eventTopCountLabl.text = String(c)
            
        }
        
        else{
            
            
        }
        
        
    }
    
    
    
    
}

func addApi(){
    
    
    let add = AddApiModal()
    let defaults = UserDefaults.standard
    var deviceToken = defaults.string(forKey:DefaultsKeys.DeviceToken )
    add.device_token = deviceToken
    print("EventDefaultsKeys.DeviceToken",deviceToken)
    add.member_id = userid
    add.mobile_no = MobileNumber
    add.priority = priority
    add.college_id = collegeid
    add.previous_add_id = PreviousAddId
    
    
    let addstr = add.toJSONString()
    
    
    addRequest.call_request(param: addstr!){ [self]
        
        (res) in
        
        
        
        let addApis : AddApiResponce = Mapper<AddApiResponce>().map(JSONString: res)!
        
        
        if addApis.Status == 1 {
            addapiRef = addApis.data
            
            
            for i in addApis.data{
                
                
                //
                
                bigImg.sd_setImage(with: URL(string: i.background_image), placeholderImage: UIImage(named: "ic_white"))
                
                
                smallImg.sd_setImage(with: URL(string: i.add_image), placeholderImage: UIImage(named: "ic_white"))
                
                
                let loadGesture = addverisment(target: self, action: #selector(adLoad))
                loadGesture.url = i.add_url
                
                adView.addGestureRecognizer(loadGesture)
                
            }
            
            
            
            
            
            
            
        }
        
        else{
            
            
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
    
    
    
    
    
    let login = LoginModal ()
    login.mobilenumber = MobileNumber
    login.Password = password
    print("passsdded", login.Password)
    
    
    let loginStr = login.toJSONString()
    
    loginRequest.call_request(param: loginStr!){ [self]
        
        (res) in
        
        
        let loginResponse : LoginResponse =
        Mapper<LoginResponse>().map(JSONString: res)!
        
        loginDatas = loginResponse.data
        print("ctrss",loginDatas.count)
        if (loginResponse.data.count >= 1){
            
            
            
            let vc = PriorityViewController(nibName: nil, bundle: nil)
            for i in loginResponse.data{
                
                
                if i.priority == "p3"{
                    vc.IdentfierLabel = "STAFF"
                    vc.loginPrincipal.append(i)
                    
                }
                
                else if i.priority == "p4"{
                    vc.loginStudent.append(i)
                    
                }
                
                
                else if i.priority == "p2"{
                    
                    vc.IdentfierLabel = "HOD"
                    vc.loginPrincipal.append(i)
                    
                }
                
                else if i.priority == "p1"{
                    
                    vc.IdentfierLabel = "PRINCIPAL"
                    vc.loginPrincipal.append(i)
                }
                
                else if i.priority == "p5"{
                    vc.IdentfierLabel = "PARENT"
                    vc.loginPrincipal.append(i)
                    
                    
                }
                
                
                else if i.priority == "p6"{
                    
                    vc.IdentfierLabel = "NON TEACHING"
                    vc.loginPrincipal.append(i)
                }
                
                
            }
            vc.modalPresentationStyle = .fullScreen
            
            present(vc, animated: true,completion: nil)
            
            
            
        }
    }
    
    
    
    
    
    
    
    
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
