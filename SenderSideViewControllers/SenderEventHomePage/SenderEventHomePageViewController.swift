//
//  SenderEventHomePageViewController.swift
//  GraditSenderEventMenu
//
//  Created by MACBOOKPRO on 02/12/22.
//

import UIKit
import ObjectMapper
import WebKit
import KRProgressHUD

@available(iOS 16.0, *)
class SenderEventHomePageViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate {

@IBOutlet weak var searchbar: UISearchBar!
@IBOutlet weak var topNameview: UIView!
@IBOutlet weak var tapBarView: UIViewX!
@IBOutlet weak var loadingCustom: UIActivityIndicatorView!
@IBOutlet weak var eventTopCountView: UIViewX!

@IBOutlet weak var SearchView: UIView!

@IBOutlet weak var eventtopcountLabel: UILabel!
@IBOutlet weak var pastCountLabl: UILabel!

@IBOutlet weak var pastcountView: UIViewX!
@IBOutlet weak var upcountLabel: UILabel!

@IBOutlet weak var UpcountView: UIViewX!


@IBOutlet weak var redirectLoginView: UIViewX!
@IBOutlet weak var notificationView: UIView!

@IBOutlet weak var smallImg: UIImageView!
@IBOutlet weak var bigImg: UIImageView!

@IBOutlet weak var topMessageLabel: UILabel!
@IBOutlet weak var clgLogoImg: UIImageView!


@IBOutlet weak var logoutView: UIView!

@IBOutlet weak var changeRolesView: UIView!


@IBOutlet weak var profileView: UIView!



@IBOutlet weak var changePasswordView: UIView!



@IBOutlet weak var termsAndConditionView: UIView!

@IBOutlet weak var helpView: UIView!


@IBOutlet weak var topLabels: UILabel!

@IBOutlet weak var viewTap: UIView!



@IBOutlet weak var faqView: UIView!


@IBOutlet weak var privacyPolicyView: UIView!


@IBOutlet weak var refreshView: UIView!



@IBOutlet weak var sideMenuView: UIView!


@IBOutlet weak var reusee: ReuseView!



@IBOutlet weak var plussView: UIViewX!



@IBOutlet weak var searchFullView: UIViewX!
@IBOutlet weak var plusImageView: UIImageView!

@IBOutlet weak var noDataTextView: UIView!
@IBOutlet weak var eventSegmentName: UISegmentedControl!

@IBOutlet weak var noDataLabel: UILabel!

@IBOutlet weak var EventTableView: UITableView!

@IBOutlet weak var swipeMenuHeight: NSLayoutConstraint!



var EventMenuId : String!


var identifers = "SenderEventTableViewCell"

var pastRef     : [SenderPastEventsdatadetails] = []
var upcomming : [SenderPastEventsdatadetails] = []
let menuIdentifier = "MenuCollectionViewCell"
var MenuRefName :[menuApiDataDetails] = []
var addapiRef : [AddDataDeatils] = []

var overAllRef    : [overAllDataDetails] = []
var NoticeBoardId = "1"
var videoId = "2"
var EventId = "3"
var communicationId = "4"
var imagePdfId = "5"
var Assigment = "6"

var memberId : String!
var priority : String!
var loginType : String!
var collegeId : String!

var memberName : String!

var colgImg : String!

var headerId : String!

var departmentId : String!

var sectionId : String!

var PreviousAddId : Int = 0

var mobileNumber : String!

var loginDatas : [datalogin]!
var logindataprinci :[datalogin]!

var password : String!

var str : [String] = []

var strName : [String] = []
var is_read_enabled = ""
var is_write_enabled = ""

var selectedCell:IndexPath?
var backGroundImg : String!
var SmallImgAdd : String!
var segmentID : String!

var cloneList : [SenderPastEventsdatadetails] = []

override func viewDidAppear(_ animated: Bool) {
    
    print("kljjjjjjjjj")
    
    
    PreviousAddId = PreviousAddId+1
    
    
    
    print("jkkkkkkk",PreviousAddId)
    
}

override func viewDidLoad() {
    super.viewDidLoad()
    overrideUserInterfaceStyle = .light
    loadingCustom.startAnimating()
    
    PreviousAddId = PreviousAddId+1
    
    sideMenuView.isHidden = true
    
    searchbar.delegate = self
    searchbar.isHidden  = true
    searchFullView .isHidden = true
    
    let defaults = UserDefaults.standard
    
    memberId = defaults.string(forKey: DefaultsKeys.memberid)
    priority = defaults.string(forKey: DefaultsKeys.priority)
    loginType = defaults.string(forKey: DefaultsKeys.loginAsType)
    collegeId = defaults.string(forKey: DefaultsKeys.collegeid)
    memberName = defaults.string(forKey: DefaultsKeys.memberName)
    colgImg = defaults.string(forKey: DefaultsKeys.colglogo)
    departmentId = defaults.string(forKey: DefaultsKeys.deptid)
    sectionId = defaults.string(forKey: DefaultsKeys.sectionid)
    
    print("sectiomnnx",sectionId)
    mobileNumber = defaults.string(forKey: DefaultsKeys.mobileNumber)
    password = defaults.string(forKey: DefaultsKeys.Password)
    
    clgLogoImg.sd_setImage(with: URL(string:  colgImg), placeholderImage: UIImage(named: "person.fill"))
    
    topMessageLabel.text = memberName
    addApi()
    
    
    if is_read_enabled == "1"{
        upcoming()
    }else{}
    
    if is_write_enabled == "1"{
        
        plussView.isHidden = false
    }else{
        
        plussView.isHidden = true
    }
    
    
    
    if priority == "p1"{
        
        
        tapBarView.backgroundColor = UIColor(named: "Principal" )
        
        topLabels.text = "Principal"
        overAllRefName()
        
    }
    
    else if priority == "p4"{
        
        topLabels.text = "Student"
        overAllRefName()
        
    }
    
    else if priority == "p2" {
        
        tapBarView.backgroundColor = UIColor(named: "Teaching Staff" )
        plussView.backgroundColor = UIColor(named: "messagecolor")
        topLabels.text = "Hod"
        
        overAllRefName()
        
    }
    
    else if priority == "p5"{
        
        
        topLabels.text = "Father"
        
        overAllRefName()
        
        
        
    }
    
    else if priority == "p3"{
        
        
        tapBarView.backgroundColor = UIColor(named: "Teaching Staff" )
        plussView.backgroundColor = UIColor(named: "messagecolor")
        topLabels.text = "Teacher"
        overAllRefName()
        
    }
    
    
    else if priority == "p6"{
        
        
        tapBarView.backgroundColor = UIColor(named: "Teaching Staff" )
        topLabels.text = "Non Teaching"
        plussView.isHidden = true
        
        eventTopCountView.isHidden = true
        pastcountView.isHidden = true
        UpcountView.isHidden = true
        
    }
    
    else if priority == "p7"{
        
        
        tapBarView.backgroundColor = UIColor(named: "univercityColorCod" )
        topLabels.text = "University Head"
        
        overAllRefName()
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
    
    
    else if priority == "p6"{
        
        
        view.backgroundColor = UIColor(named: "Teaching Staff")
        
        reusee.menuImg.image = UIImage(named: "HodImage")
        
    }
    
    else if priority == "p7"{
        
        
        view.backgroundColor = UIColor(named: "univercityColorCod")
        
        reusee.menuImg.image = UIImage(named: "UnivercityHead")
        
    }
    
    swipeMenuHeight.constant = 150
    reusee.call_back = { [self]
        (val) in
        
        
        self.swipeMenuHeight.constant =  reusee.callid
        
        print("HelloWorld544544343",reusee.callid)
        
        
    }
    
    
    
    
    
    let rownib = UINib(nibName: identifers, bundle: nil)
    EventTableView .register(rownib, forCellReuseIdentifier: identifers)
    
    
    EventTableView.delegate = self
    EventTableView.dataSource = self
    
    
    let plusAddViews = UITapGestureRecognizer(target: self, action: #selector(PlusVc))
    plussView.addGestureRecognizer(plusAddViews)
    
    noDataLabel.isHidden = true
    noDataTextView.isHidden = true
    
    
    
    
    // tap Bar UiTapGuster.
    
    
    
    
    
    let changeRolesGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
    changeRolesView.addGestureRecognizer(changeRolesGesture)
    
    let loginRediectGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
    redirectLoginView.addGestureRecognizer(loginRediectGesture)
    
    
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
    //
    
    let privacyPolicyGesture = UITapGestureRecognizer(target: self, action: #selector(privacyPolicyRedirect))
    privacyPolicyView.addGestureRecognizer(privacyPolicyGesture)
    
    let termsAndConditionGesture = UITapGestureRecognizer(target: self, action: #selector(termsAndCondition))
    termsAndConditionView.addGestureRecognizer(termsAndConditionGesture)
    
    
    
    let chagePassword = UITapGestureRecognizer(target: self, action: #selector(changePassowrdVC))
    changePasswordView.addGestureRecognizer(chagePassword)
    
    
    
    let topname = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
    topNameview.addGestureRecognizer(topname)
    
    
    
    let Serach = UITapGestureRecognizer(target: self, action: #selector(Searchfield))
    SearchView.addGestureRecognizer(Serach)
    
    
    
    
    
    
    
}




@IBAction func Searchfield() {
    
    
    searchbar.isHidden  = false
    searchFullView .isHidden = false
    
    
    
    
    
    
    
    
}




func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
    
    
    
    
    let filtered_list : [SenderPastEventsdatadetails] = Mapper<SenderPastEventsdatadetails>().mapArray(JSONString: cloneList.toJSONString()!)!
    
    
    
    
    
    if !searchText.isEmpty{
        
        
        
        upcomming = filtered_list.filter {
            
            
            
            
            
            
            
            $0.venue.lowercased().contains(searchText.lowercased())  || $0.topic.lowercased().contains(searchText.lowercased()) ||  $0.event_date.lowercased().contains(searchText.lowercased()) || $0.body.lowercased().contains(searchText.lowercased())
            
            
            
        }
        
        
        
        
        
        
        
    }else{
        
        
        
        upcomming = filtered_list
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
    if upcomming.count > 0{
        
        
        
        print ("searchListPendigCount",upcomming.count)
        
        
        
    }else{
        
        
        
        
        
        
        
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
    searchFullView .isHidden = true
    
    searchbar.resignFirstResponder()
    
    
    
}


@IBAction func PlusVc() {
    
    
    for i in addapiRef{
        
        if priority == "p2" || priority == "p3" {
            
            let vc = PlusNewTextViewControllerViewController(nibName: nil, bundle: nil)
            vc.smallImageUrl = i.add_image
            vc.backGroundImageUrl = i.background_image
            vc.addWebUrl = i.add_url
            vc.menuId = EventId
            vc.strName = strName
            vc.str = str
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true , completion: nil)
            
        }
        
        
        
        if priority == "p7" {
            
            let vc = PlusNewTextViewControllerViewController(nibName: nil, bundle: nil)
            vc.smallImageUrl = i.add_image
            vc.backGroundImageUrl = i.background_image
            vc.addWebUrl = i.add_url
            vc.menuId = EventId
            vc.strName = strName
            vc.str = str
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true , completion: nil)
            
        }
        
        
        else{
            
            let vc = PlusNewTextViewControllerViewController(nibName: nil, bundle: nil)
            vc.smallImageUrl = i.add_image
            vc.backGroundImageUrl = i.background_image
            vc.addWebUrl = i.add_url
            vc.menuId = EventId
            vc.strName = strName
            vc.str = str
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.view.backgroundColor = UIColor(named: "Principal" )
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true , completion: nil)
            
        }
    }
    
}




@IBAction func segmentAction(_ sender: UISegmentedControl) {
    
    if is_read_enabled == "1"{
        
        if priority == "p1"{
            if eventSegmentName.selectedSegmentIndex == 0{
                segmentID = "1"
                
                EventTableView.isScrollEnabled = false
                upcoming()
                
            }
            
            
            
            else if eventSegmentName.selectedSegmentIndex == 1 {
                segmentID = "2"
                
                EventTableView.isScrollEnabled = false
                past()
                
            }
        }
        
        else if priority == "p2" ||  priority == "p3"{
            
            
            if eventSegmentName.selectedSegmentIndex == 0{
                segmentID = "1"
                
                EventTableView.isScrollEnabled = false
                upcoming()
                
            }
            
            
            
            else if eventSegmentName.selectedSegmentIndex == 1 {
                segmentID = "2"
                
                EventTableView.isScrollEnabled = false
                past()
                
            }
        }
        
        else {
            
            
            if eventSegmentName.selectedSegmentIndex == 0{
                segmentID = "1"
                
                EventTableView.isScrollEnabled = false
                upcoming()
                
                
                
            }
            
            
            
            else if eventSegmentName.selectedSegmentIndex == 1 {
                segmentID = "2"
                
                EventTableView.isScrollEnabled = false
                past()
                
            }
            
        }
    }else{}
}


func past() {
    
    let pastEvent = senderPastEventModal()
    
    pastEvent.userid     = memberId
    pastEvent.appid      = "2"
    pastEvent.priority   = priority
    pastEvent.type       =  "pastevents"
    
    
    
    let pastEventStr = pastEvent.toJSONString()
    
    
    SenderEventsRequest.call_request(param: pastEventStr!){ [self]
        
        (res) in
        
        
        let PastEventResp : senderPastEventResponce =
        Mapper<senderPastEventResponce>().map(JSONString: res)!
        
        print("order data",PastEventResp)
        
        if PastEventResp.Status == 1{
            
            pastRef = PastEventResp.data
            noDataLabel.isHidden = true
            noDataTextView.isHidden = true
            EventTableView.isScrollEnabled = true
            EventTableView.delegate = self
            EventTableView.dataSource = self
            EventTableView.reloadData()
            
            
            
        }
        
        else{
            
            
            
            
            noDataLabel.isHidden = false
            noDataTextView.isHidden = false
            noDataLabel.text = PastEventResp.Message
            EventTableView.delegate = self
            EventTableView.dataSource = self
            EventTableView.reloadData()
            
        }
        
        
    }
    
}


func upcoming() {
    
    let UpcommingEvent = senderPastEventModal()
    
    UpcommingEvent.userid     =  memberId
    UpcommingEvent.appid      =  "2"
    UpcommingEvent.priority   = priority
    UpcommingEvent.type       =  "upcomingevents"
    
    
    
    let upcommingeventStr = UpcommingEvent.toJSONString()
    
    
    SenderEventsRequest .call_request(param: upcommingeventStr!){ [self]
        
        (res) in
        
        
        let upcommingeventResp : senderPastEventResponce =
        Mapper<senderPastEventResponce>().map(JSONString: res)!
        
        print("order data",upcommingeventResp)
        
        
        
        if upcommingeventResp.Status == 1{
            
            noDataLabel.isHidden = true
            noDataTextView.isHidden = true
            upcomming = upcommingeventResp.data
            cloneList = upcommingeventResp.data
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
            noDataLabel.text = upcommingeventResp.Message
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




func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    if eventSegmentName.selectedSegmentIndex == 0 {
        
        return upcomming.count
    }
    else if eventSegmentName.selectedSegmentIndex == 1{
        
        return pastRef.count
    }
    
    
    return 0
}



func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: identifers, for: indexPath) as!
    SenderEventTableViewCell
    
    
    
    cell.selectionStyle = .none
    
    
    if let selectedCell = selectedCell, selectedCell == indexPath {
        
        
        cell.discreptionlbl.isHidden = false
        cell.sendbyDefltlab.isHidden = false
        cell.viewclick.isHidden = false
        cell.createrNameCellLabel.isHidden = false
        cell.arrowImage.image = UIImage(named: "up")
        cell.SendByViewFull.isHidden = false
    }
    
    
    
    else{
        
        
        cell.discreptionlbl.isHidden = true
        cell.sendbyDefltlab.isHidden = true
        cell.viewclick.isHidden = true
        cell.createrNameCellLabel.isHidden = true
        cell.arrowImage.image = UIImage(named: "down")
        cell.SendByViewFull.isHidden = true
        
    }
    
    
    
    if eventSegmentName.selectedSegmentIndex == 0 {
        
        let Upcommimgsevent : SenderPastEventsdatadetails = upcomming[indexPath.row]
        
        if Upcommimgsevent.isappread == "1"{
            
            cell.ReadDotImageView.isHidden =  true
            
        }
        
        else {
            
            cell.ReadDotImageView.isHidden = false
            //
        }
        
        cell.topicCellLabel.text = Upcommimgsevent.topic.capitalized
        cell.eventDateCellLabel.text = Upcommimgsevent.event_date
        cell.timeDateCellLabel.text = Upcommimgsevent.event_time
        cell.createrNameCellLabel.text = Upcommimgsevent.createdbyname
        cell.discreptionlbl.text = Upcommimgsevent.body
        
        let vc  = viewcilcksender(target: self, action: #selector(viewclick))
        vc.venue = Upcommimgsevent.venue
        vc.topic = Upcommimgsevent.topic
        vc.body = Upcommimgsevent.body
        vc.event_date = Upcommimgsevent.event_date
        vc.event_time = Upcommimgsevent.event_time
        vc.newfilepath = Upcommimgsevent.newfilepath
        vc.headerId = Upcommimgsevent.eventid
        vc.eventCreatedId = Upcommimgsevent.createdby
        
        
        cell.viewclick.addGestureRecognizer(vc)
        
        
    }
    
    else if eventSegmentName.selectedSegmentIndex == 1{
        
        let Pastsevent : SenderPastEventsdatadetails = pastRef[indexPath.row]
        
        if Pastsevent.isappread == "1"{
            
            cell.ReadDotImageView.isHidden =  true
            
        }
        
        else {
            
            cell.ReadDotImageView.isHidden = false
            
        }
        
        cell.topicCellLabel.text = Pastsevent.topic.capitalized
        cell.eventDateCellLabel.text = Pastsevent.event_date
        cell.timeDateCellLabel.text = Pastsevent.event_time
        cell.createrNameCellLabel.text = Pastsevent.createdbyname
        
        cell.discreptionlbl.text = Pastsevent.body
        let vc  = viewcilcksender(target: self, action: #selector(viewclick))
        vc.venue = Pastsevent.venue
        vc.body = Pastsevent.body
        vc.topic = Pastsevent.topic
        vc.event_date = Pastsevent.event_date
        vc.event_time = Pastsevent.event_time
        vc.newfilepath = Pastsevent.newfilepath
        vc.headerId = Pastsevent.eventid
        
        cell.viewclick.addGestureRecognizer(vc)
        
        
        
    }
    return cell
    
}


@IBAction  func viewclick(gesture : viewcilcksender){
    
    
    
    
    
    if priority == "p1" {
        let vc = SenderEventDetailsPageViewController(nibName: nil, bundle: nil)
        
        vc.topistrs = gesture.topic
        vc.bodystr = gesture.body
        vc.timestr = gesture.event_time
        vc.datestr = gesture.event_date
        vc.venuestr = gesture.venue
        vc.filePath = gesture.newfilepath
        //                vc.previousAdId = PreviousAddId
        vc.backGroundImageUrl = backGroundImg
        vc.smallImageUrl = SmallImgAdd
        vc.headerId = gesture.headerId
        vc.str = str
        vc.strName = strName
        vc.is_read_enabled = is_read_enabled
        vc.is_write_enabled = is_write_enabled
        
        vc.eventCreaderId = gesture.eventCreatedId
        vc.view.backgroundColor = UIColor(named: "Principal" )
        print("gesture.topicgesture.topic",gesture.topic)
        
        
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
    }
    
    
    
    
    else   if priority == "p2" || priority == "p3" || priority == "p6"  || priority == "p7"{
        let vc = SenderEventDetailsPageViewController(nibName: nil, bundle: nil)
        vc.topistrs = gesture.topic
        vc.bodystr = gesture.body
        vc.timestr = gesture.event_time
        vc.datestr = gesture.event_date
        vc.venuestr = gesture.venue
        vc.filePath = gesture.newfilepath
        
        
        vc.backGroundImageUrl = backGroundImg
        vc.headerId = gesture.headerId
        vc.smallImageUrl = SmallImgAdd
        vc.str = str
        vc.strName = strName
        vc.is_read_enabled = is_read_enabled
        vc.is_write_enabled = is_write_enabled
        vc.eventCreaderId = gesture.eventCreatedId
        vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
        
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
    }
    
    
    
    else   if  priority == "p7"{
        let vc = SenderEventDetailsPageViewController(nibName: nil, bundle: nil)
        vc.topistrs = gesture.topic
        vc.bodystr = gesture.body
        vc.timestr = gesture.event_time
        vc.datestr = gesture.event_date
        vc.venuestr = gesture.venue
        vc.filePath = gesture.newfilepath
        
        
        vc.backGroundImageUrl = backGroundImg
        vc.headerId = gesture.headerId
        vc.smallImageUrl = SmallImgAdd
        vc.str = str
        vc.strName = strName
        vc.is_read_enabled = is_read_enabled
        vc.is_write_enabled = is_write_enabled
        vc.eventCreaderId = gesture.eventCreatedId
        vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
        
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
    }
    
    
    
}
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
    
    let cell = tableView.dequeueReusableCell(withIdentifier: identifers, for: indexPath) as!
    SenderEventTableViewCell
    
    
    
    if eventSegmentName.selectedSegmentIndex == 0{
        
        let Upcommimgsevent : SenderPastEventsdatadetails = upcomming[indexPath.row]
        if let selectedCells = selectedCell, selectedCells == indexPath {
            
            selectedCell = nil
            
        }
        
        else{
            
            selectedCell = indexPath
            
            
            if Upcommimgsevent.isappread == "0"{
                
                apread(gesture : Upcommimgsevent.eventdetailsid)
                
                Upcommimgsevent.isappread = "1"
                cell.ReadDotImageView.isHidden = true
                
            }
            
            
        }
        
        
        
    }
    
    
    else if eventSegmentName.selectedSegmentIndex == 1 {
        
        let Pastsevent : SenderPastEventsdatadetails = pastRef[indexPath.row]
        if let selectedCells = selectedCell, selectedCells == indexPath {
            
            selectedCell = nil
            
        }
        
        else{
            
            selectedCell = indexPath
            
            
            
            
            if Pastsevent.isappread == "0"{
                
                apread(gesture : Pastsevent.eventdetailsid)
                
                Pastsevent.isappread = "1"
                cell.ReadDotImageView.isHidden = true
                
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
    readApiStatus.userid = memberId
    readApiStatus.detailsid = gesture
    print("sertt",gesture)
    
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



func addApi(){
    
    var add = AddApiModal()
    
    let defaults = UserDefaults.standard
    var deviceToken = defaults.string(forKey:DefaultsKeys.DeviceToken )
    add.device_token = deviceToken
    add.member_id = memberId
    add.mobile_no = mobileNumber
    add.priority = priority
    add.college_id = collegeId
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

func overAllRefName() {
    
    var overall = overAllModal()
    
    overall.userid   =  memberId
    overall.menuid       = "9"
    overall.collegeid    =  collegeId
    overall.departmentid =  departmentId
    overall.sectionid    =   "0"
    overall.appid        = "2"
    overall.priority     = priority
    
    APiCallManager.shared.callApi(url: APIEndpoints.GetOverallcountByMenuType, httpMethod: .post, queryParam: nil, requestBody: overall) { [weak self] (result:Result<overAllResponce,Error>) in
        guard let self = self else{return}
        switch result{
        case .success(let result):
            if result.Status == 1{
                overAllRef = result.data ?? []
                
                for i in overAllRef{
                    
                    upcountLabel.text = i.upcomingevents
                    pastCountLabl.text = i.pastevents
                    if (i.unread == "0") && (i.read == "0"){
                        
                        UpcountView.isHidden = true
                        pastcountView.isHidden = true
                        EventTableView.isHidden = true
                        
                        
                        
                    }
                    
                    else if i.unread == "0"{
                        
                        
                        UpcountView.isHidden = true
                        pastcountView.isHidden = false
                        EventTableView.isHidden = false
                        
                    }
                    
                    else if i.read == "0"{
                        
                        UpcountView.isHidden = false
                        pastcountView.isHidden = true
                        EventTableView.isHidden = false
                        
                        
                    }
                    
                    else {
                        
                        UpcountView.isHidden = false
                        pastcountView.isHidden = false
                        EventTableView.isHidden = false
                        
                        
                        
                    }
                    
                    
                    
                }
                
                
                let a =  Int( upcountLabel.text!)
                let b = Int(pastCountLabl.text!)
                let c = a! + b!
                
                eventtopcountLabel.text = String(c)
                
                
                
                EventTableView.delegate = self
                EventTableView.dataSource = self
                
                
                EventTableView.reloadData()
                
                
            }else{
                
                UpcountView.isHidden = true
                pastcountView.isHidden = true
                EventTableView.isHidden = true
                
                
                
            }
        case .failure(let error):
            print("Error: \(error)")
        }
    }
}



@IBAction func adLoad( gesture : eventAdd){
    
    
    let vc = TotalAddLoadPageViewController(nibName: nil, bundle: nil)
    
    vc.AddWebUrl = gesture.url
    
    vc.modalPresentationStyle = . fullScreen
    present(vc, animated: true,completion: nil)
    
    
}



// This part for bottom  swipe view .






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
    
    
    if segmentID == "1"{
        
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





    @IBAction func priorityVc() {
        
        let vc = PriorityViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
    }

}


class viewcilcksender : UITapGestureRecognizer{

var topic : String!
var body : String!
var event_time : String!
var event_date : String!
var venue     : String!
var newfilepath : [String] = []

var headerId : String!

var eventCreatedId : String!


}
class eventAdd: UITapGestureRecognizer{

var url : String!


}
