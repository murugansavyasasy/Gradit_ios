//
//  SenderAssigmentHomePageViewController.swift
//  GraditSenderAssigment
//
//  Created by MACBOOKPRO on 30/11/22.
//

import UIKit
import ObjectMapper
import KRProgressHUD

@available(iOS 16.0, *)
class SenderAssigmentHomePageViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate {


@IBOutlet weak var reusee: ReuseView!
@IBOutlet weak var SearchView: UIView!
@IBOutlet weak var searchFullView: UIViewX!
@IBOutlet weak var searchbar: UISearchBar!
@IBOutlet weak var topNameview: UIView!
@IBOutlet weak var tapBarView: UIViewX!
@IBOutlet weak var redirectLoginView: UIViewX!
@IBOutlet weak var notificationView: UIView!
@IBOutlet weak var smallImg: UIImageView!


@IBOutlet weak var loadingCustom: UIActivityIndicatorView!
@IBOutlet weak var bigImg: UIImageView!

@IBOutlet weak var logoutView: UIView!

@IBOutlet weak var changeRolesView: UIView!


@IBOutlet weak var profileView: UIView!

@IBOutlet weak var topLabels: UILabel!
@IBOutlet weak var refreshView: UIView!
@IBOutlet weak var privacyPolicyView: UIView!

@IBOutlet weak var faqView: UIView!


@IBOutlet weak var helpView: UIView!

@IBOutlet weak var viewTap: UIView!


@IBOutlet weak var changePasswordView: UIView!


@IBOutlet weak var termsAndConditionView: UIView!

@IBOutlet weak var sideMenuView: UIView!


@IBOutlet weak var assigmentCountViews: UIViewX!

@IBOutlet weak var topMessageLabel: UILabel!

@IBOutlet weak var clgLogoImg: UIImageView!


@IBOutlet weak var upcommingcountView: UIViewX!


@IBOutlet weak var noDataView: UIView!


@IBOutlet weak var noDataTextLabel: UILabel!
@IBOutlet weak var assigmentPastCountView: UIViewX!
@IBOutlet weak var assigmentUpcommingCount: UILabel!
@IBOutlet weak var assigmentTopCount: UILabel!

@IBOutlet weak var assigmentSegmentName: UISegmentedControl!

@IBOutlet weak var assigmentPastCount: UILabel!


@IBOutlet weak var addPlusVcNextPage: UIViewX!
@IBOutlet weak var assigmentTableView: UITableView!


@IBOutlet weak var swipeMenuHeight: NSLayoutConstraint!





var Indentifiers = "SenderAssigmentTableViewCell"
let menuIdentifier = "MenuCollectionViewCell"
var MenuRefName :[menuApiDataDetails] = []

var UpcommingRef : [upcommingdataDetails] = []
var PasrRef      : [upcommingdataDetails]    = []
var overAllRef    : [overAllDataDetails] = []
var addapiRef : [AddDataDeatils] = []
var assigmentImagPdf : [assigmentImagePdfResponce] = []
var selectedCell : IndexPath?

var memberId : String!
var priority : String!
var colgId   : String!
var sectionid : String!
var deptid    : String!
var loginType : String!
var memberName : String!
var colgImg : String!
var assigmentMenuId : String!

var NoticeBoardId = "1"
var videoId = "2"
var EventId = "3"
var communicationId = "4"
var imagePdfId = "5"
var Assigment = "6"
var meberIDForCompar : Int!
var mobileNumber : String!


var password : String!

var loginDatas : [datalogin]!
var logindataprinci :[datalogin]!
var str : [String] = []

var strName : [String] = []

var PreviousAddId : Int = 0
var addImageBackGroundurl : String!
var  smallImageUrl : String!
var addurls : String!

var segmentID : String!

var cloneList :  [upcommingdataDetails] = []

var is_read_enabled : String!
var is_write_enabled : String!

override func viewDidAppear(_ animated: Bool) {
    
    print("kljjjjjjjjj")
    
    
    PreviousAddId = PreviousAddId+1
    
    
    
    print("jkkkkkkk",PreviousAddId)
    
}


override func viewDidLoad() {
    super.viewDidLoad()
    
    overrideUserInterfaceStyle = .light
    loadingCustom.startAnimating()
    
    sideMenuView.isHidden = true
    searchbar.delegate = self
    searchbar.isHidden  = true
    searchFullView .isHidden = true
    
    let defaults = UserDefaults.standard
    
    memberId = defaults.string(forKey: DefaultsKeys.memberid)
    priority = defaults.string(forKey: DefaultsKeys.priority)
    colgId = defaults.string(forKey: DefaultsKeys.collegeid)
    deptid = defaults.string(forKey: DefaultsKeys.deptid)
    sectionid = defaults.string(forKey: DefaultsKeys.sectionid)
    loginType = defaults.string(forKey: DefaultsKeys.loginAsType)
    meberIDForCompar = defaults.integer(forKey: DefaultsKeys.memberid)
    mobileNumber = defaults.string(forKey: DefaultsKeys.mobileNumber)
    password  = defaults.string(forKey: DefaultsKeys.Password)
    
    if sectionid == ""{
        
        sectionid = "0"
        
        
    }
    memberName = defaults.string(forKey: DefaultsKeys.memberName)
    colgImg = defaults.string(forKey: DefaultsKeys.colglogo)
    clgLogoImg.sd_setImage(with: URL(string:  colgImg), placeholderImage: UIImage(named: "person.fill"))
    
    topMessageLabel.text = memberName
    addApi()
    
    
    
    print("is_read_enabled45678", is_read_enabled)
    print("is_read_enabled345678", is_write_enabled)
    
    if is_read_enabled == "1"{
        UpcommingRefName()
        
    }else{}
    if is_write_enabled == "1"{
        
        addPlusVcNextPage.isHidden = false
    }else{
        addPlusVcNextPage.isHidden = true
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
        addPlusVcNextPage.backgroundColor = UIColor(named: "messagecolor")
        topLabels.text = "Hod"
        
        overAllRefName()
    }
    
    else if priority == "p5"{
        
        
        topLabels.text = "Father"
        overAllRefName()
        
        
    }
    
    else if priority == "p3"{
        
        tapBarView.backgroundColor = UIColor(named: "Teaching Staff" )
        addPlusVcNextPage.backgroundColor = UIColor(named: "messagecolor")
        topLabels.text = "Teacher"
        overAllRefName()
    }
    
    else if priority == "p7"{
        
        tapBarView.backgroundColor = UIColor(named: "univercityColorCod" )
        addPlusVcNextPage.backgroundColor = UIColor(named: "messagecolor")
        topLabels.text = "University Head"
        overAllRefName()
    }
    else if priority == "p6"{
        
        
        tapBarView.backgroundColor = UIColor(named: "Teaching Staff" )
        topLabels.text = "NonTeaching"
        
        addPlusVcNextPage.isHidden = true
        
        assigmentTopCount.isHidden = true
        assigmentPastCountView.isHidden = true
        upcommingcountView.isHidden = true
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
        
        view.backgroundColor = UIColor(named: "attendanceColor")
        
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
    
    
    
    
    
    
    let rowNib = UINib(nibName: Indentifiers, bundle: nil)
    assigmentTableView.register(rowNib, forCellReuseIdentifier: Indentifiers)
    
    
    let Serach = UITapGestureRecognizer(target: self, action: #selector(Searchfield))
    SearchView.addGestureRecognizer(Serach)
    
    
    let plusAddViews = UITapGestureRecognizer(target: self, action: #selector(PlusVc))
    addPlusVcNextPage.addGestureRecognizer(plusAddViews)
    
    
    // tap Bar UiTapGuster.
    
    let loginRediectGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
    redirectLoginView.addGestureRecognizer(loginRediectGesture)
    
    
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
    //
    
    let privacyPolicyGesture = UITapGestureRecognizer(target: self, action: #selector(privacyPolicyRedirect))
    privacyPolicyView.addGestureRecognizer(privacyPolicyGesture)
    
    let termsAndConditionGesture = UITapGestureRecognizer(target: self, action: #selector(termsAndCondition))
    termsAndConditionView.addGestureRecognizer(termsAndConditionGesture)
    
    
    
    let chagePassword = UITapGestureRecognizer(target: self, action: #selector(changePassowrdVC))
    changePasswordView.addGestureRecognizer(chagePassword)
    
    
    noDataView.isHidden = true
    noDataTextLabel.isHidden = true
    
}



@IBAction func Searchfield() {
    
    
    searchbar.isHidden  = false
    searchFullView .isHidden = false
    
    
    
}




func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
    
    
    if assigmentSegmentName.selectedSegmentIndex == 0{
        
        let filtered_list : [upcommingdataDetails] = Mapper<upcommingdataDetails>().mapArray(JSONString: cloneList.toJSONString()!)!
        
        
        
        
        
        if !searchText.isEmpty{
            
            
            
            UpcommingRef = filtered_list.filter {
                
                $0.description.lowercased().contains(searchText.lowercased())  || $0.assignmenttype.lowercased().contains(searchText.lowercased()) ||  $0.createdon.lowercased().contains(searchText.lowercased()) || $0.topic.lowercased().contains(searchText.lowercased()) || $0.subjectname.lowercased().contains(searchText.lowercased()) || $0.createdby.lowercased().contains(searchText.lowercased())
                
                
                
            }
            
            
        }else{
            
            
            
            UpcommingRef = filtered_list
            
            
            
            print("pendingOrder")
            
            
            
        }
        
        if UpcommingRef.count > 0{
            
            
            
            print ("searchListPendigCount",UpcommingRef.count)
            
            
            noDataTextLabel.isHidden = true
            noDataView.isHidden = true
            
            
            
        }else{
            
            noDataTextLabel.isHidden = false
            noDataView.isHidden = false
            noDataTextLabel.text = "No Records Found"
            
            
        }
        
    }
    
    
    
    
    
    else if assigmentSegmentName.selectedSegmentIndex == 1{
        
        
        
        let filtered_list : [upcommingdataDetails] = Mapper<upcommingdataDetails>().mapArray(JSONString: cloneList.toJSONString()!)!
        
        if !searchText.isEmpty{
            
            
            
            PasrRef = filtered_list.filter {
                
                
                
                $0.description.lowercased().contains(searchText.lowercased())  || $0.assignmenttype.lowercased().contains(searchText.lowercased()) ||  $0.createdon.lowercased().contains(searchText.lowercased()) || $0.topic.lowercased().contains(searchText.lowercased()) || $0.subjectname.lowercased().contains(searchText.lowercased()) || $0.createdby.lowercased().contains(searchText.lowercased())
                
                
                
            }
            
            
            
        }else{
            
            
            
            PasrRef = filtered_list
            
            
        }
        
        
        if PasrRef.count > 0{
            
            
            
            print ("searchListPendigCount",PasrRef.count)
            
            noDataTextLabel.isHidden = true
            noDataView.isHidden = true
            
            
            
        }else{
            
            
            
            
            noDataTextLabel.isHidden = false
            noDataView.isHidden = false
            noDataTextLabel.text = "No Records Found"
            
            
            
        }
        
        
        
    }
    
    assigmentTableView.reloadData()
    
    
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
        
        if priority == "p2" || priority == "p3"{
            
            let vc = PlusScreenNextPageViewController(nibName: nil, bundle: nil)
            
            vc.addImageBackGroundurl = i.background_image
            vc.assigmentID = Assigment
            vc.imageWebUrl = i.add_url
            vc.smallImageUrl = i.add_image
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.str = str
            vc.strName = strName
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true , completion: nil)
            
            
        }
        
        
        else if priority == "p7"{
            
            let vc = PlusScreenNextPageViewController(nibName: nil, bundle: nil)
            
            vc.addImageBackGroundurl = i.background_image
            vc.assigmentID = Assigment
            vc.imageWebUrl = i.add_url
            vc.smallImageUrl = i.add_image
            
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            
            vc.str = str
            vc.strName = strName
            vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true , completion: nil)
            
            
        }
        
        
        else{
            
            
            let vc = PlusScreenNextPageViewController(nibName: nil, bundle: nil)
            
            vc.addImageBackGroundurl = i.background_image
            vc.assigmentID = Assigment
            vc.imageWebUrl = i.add_url
            vc.smallImageUrl = i.add_image
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            
            vc.str = str
            vc.strName = strName
            vc.view.backgroundColor = UIColor(named: "Principal" )
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true , completion: nil)
            
            
            
        }
    }
    
    
    
}



@IBAction func segmentAction(_ sender: Any) {
    
    if assigmentSegmentName .selectedSegmentIndex == 0 {
        segmentID = "1"
        addPlusVcNextPage.isHidden = false
        selectedCell = IndexPath()
        assigmentTableView.isScrollEnabled = false
        UpcommingRefName()
        
        
    }
    
    
    else if assigmentSegmentName.selectedSegmentIndex == 1 {
        segmentID = "2"
        addPlusVcNextPage.isHidden = false
        assigmentTableView.isScrollEnabled = false
        selectedCell = IndexPath()
        PastRefName()
        
    }
    
    
}



func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    if assigmentSegmentName.selectedSegmentIndex == 0{
        
        return UpcommingRef.count
        
    }
    
    else if assigmentSegmentName.selectedSegmentIndex == 1{
        
        return PasrRef.count
        
        
    }
    
    return 0
    
}

@IBAction func NotSelectdFunc(gesture : AssigmentDeletes){
    
    
    let notsubimted = AssigmentNotSubViewController(nibName: nil, bundle: nil)
    notsubimted.assigmentId = gesture.assigmentHeaderId
    notsubimted.modalPresentationStyle = .fullScreen
    present(notsubimted, animated: true)
    
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    
    let cell = tableView.dequeueReusableCell(withIdentifier: Indentifiers, for: indexPath) as! SenderAssigmentTableViewCell
    
    
    if assigmentSegmentName.selectedSegmentIndex == 0{
        
        let upcoming : upcommingdataDetails = UpcommingRef[indexPath.row]
        
        if let selectedCells = selectedCell, selectedCells == indexPath {
            
            cell.descriptionLabel.isHidden = false
            
            cell.creatonLabel.isHidden = false
            
            cell.cellArrowImage.isHidden = true
            
            cell.sentByDefaultLbl.isHidden = false
            
            cell.submisonDfaltLbl.isHidden = false
            
            cell.AttchmentView.isHidden = false
            
            cell.submitionDateLabel.isHidden = false
            
            cell.forwardView.isHidden = false
            
            cell.PlusOneView.isHidden = false
            
            cell.plusOneCountLabel.isHidden = false
            
            cell.submissionView.isHidden = false
            
            cell.forwardView.isHidden = false
            
            cell.PlusOneView.isHidden = false
            
            cell.creatonLabel.alpha = 1
            cell.submutionDateFullView.isHidden = false
            
            cell.SubmissonHorizontalStack.isHidden = false
            cell.SubmissonHorizontalStackHeight.constant = 37
            
            
            if upcoming.assignmenttype == "Text"{
                
                cell.AttchmentView.isHidden = true
                
                cell.PlusOneView.isHidden = true
            }
            
            else if upcoming.assignmenttype ==  "text"{
                
                cell.AttchmentView.isHidden = true
                
                cell.PlusOneView.isHidden = true
                
            }
            
            else if upcoming.assignmenttype == "All"{
                
                cell.AttchmentView.isHidden = true
                
                cell.PlusOneView.isHidden = true
            }
            
            else{
                
                cell.AttchmentView.isHidden = false
                
                cell.PlusOneView.isHidden = false
            }
            
            if upcoming.isappread == "1"{
                
                
                cell.readDotImageView.isHidden =  true
            }
            
            else {
                
                cell.readDotImageView.isHidden = false
            }
            
        } else {
            
            cell.creatonLabel.isHidden = true
            
            cell.descriptionLabel.isHidden = true
            
            cell.cellArrowImage.isHidden = false
            
            cell.sentByDefaultLbl.isHidden = true
            
            cell.submisonDfaltLbl.isHidden = true
            
            
            cell.AttchmentView.isHidden = true
            
            cell.submitionDateLabel.isHidden = true
            
            cell.forwardView.isHidden = true
            
            
            
            cell.PlusOneView.isHidden = true
            
            cell.plusOneCountLabel.isHidden = true
            
            
            
            cell.submissionView.isHidden = true
            
            cell.forwardView.isHidden = true
            
            cell.PlusOneView.isHidden = true
            cell.submutionDateFullView.isHidden = true
            
            cell.SubmissonHorizontalStack.isHidden = true
            cell.SubmissonHorizontalStackHeight.constant = 0
            
            cell.creatonLabel.alpha = 0
            
        }
        
        
        if upcoming.createdby == memberId{
            
            cell.forwardView.isHidden = false
        }
        
        else{
            
            cell.forwardView.isHidden = true
        }
        
        
        cell.topicLabel.text = upcoming.topic.capitalized
        
        cell.dateTimeLabel.text = upcoming.createdon
        
        cell.descriptionLabel.text = upcoming.description
        
        cell.creatonLabel.text = upcoming.sentbyname
        
        cell.countLabel.text = upcoming.submittedcount
        
    
        let dateFormatterGet = DateFormatter()
        
        dateFormatterGet.dateFormat = "dd-MM-yyy"
        
        let dateFormatterPrint = DateFormatter()
        
        dateFormatterPrint.dateFormat = " dd MMM,yyyy"
        
        let dates: NSDate? = dateFormatterGet.date(from: upcoming.submissiondate) as NSDate?
        
        
        cell.submitionDateLabel.text = dateFormatterPrint.string(from: dates as! Date)
        
        
        
        let  plusoneCount  = upcoming.newfilepath.count-1
        
        let stringconvert = String(plusoneCount)
        
        cell.plusOneCountLabel.text = "+" + stringconvert
        
        
        if upcoming.userfilename  == ""{
            
            
            
            cell.AttchmentView.isHidden = true
            
            cell.PlusOneView.isHidden = true
            
            
        }
        
        else if upcoming.userfilename  == "null"{
            
            
            
            cell.AttchmentView.isHidden = true
            
            
            
            cell.PlusOneView.isHidden = true
            
            
            
        }
        
        else{
            
            
            
            
        }
        
     
        if upcoming.newfilepath.count == 1  {
            
            
            
            cell.PlusOneView.isHidden = true
            
            let  attchmentTap = senderassigments(target: self, action: #selector(AtchmentVc))
            
            attchmentTap.img_urls = upcoming.newfilepath
            
            attchmentTap.imageFileType = upcoming.assignmenttype
            
            attchmentTap.titee = upcoming.topic
            
            attchmentTap.descrttt = upcoming.description
            
            for i in upcoming.newfilepath{
                
                
                
                attchmentTap.img_url = i
                
                
                
            }
            
            
            
            cell.AttchmentView.addGestureRecognizer(attchmentTap)
            
            
            
        }
     
        else{
            
            
            let  attchmentTap = senderassigments(target: self, action: #selector(AtchmentVc))
            
            attchmentTap.img_urls = upcoming.newfilepath
            
            attchmentTap.imageFileType = upcoming.assignmenttype
            
            attchmentTap.titee = upcoming.topic
            
            attchmentTap.descrttt = upcoming.description
            
            for i in upcoming.newfilepath{
                
                
                
                attchmentTap.img_url = i
                
                
            }
            
            
            
            cell.AttchmentView.addGestureRecognizer(attchmentTap)
            
        }
        
        
        if upcoming.newfilepath.count == 1  {
            
            
            cell.PlusOneView.isHidden = true
            
            let  attchmentTap = senderassigments(target: self, action: #selector(AtchmentVc))
            
            attchmentTap.img_urls = upcoming.newfilepath
            
            attchmentTap.imageFileType = upcoming.assignmenttype
            
            attchmentTap.titee = upcoming.topic
            
            attchmentTap.descrttt = upcoming.description
            
            for i in upcoming.newfilepath{
                
                attchmentTap.img_url = i
                
            }
            
            cell.PlusOneView.addGestureRecognizer(attchmentTap)
            
            
        }
        
        else{
            
            
            
            let  attchmentTap = senderassigments(target: self, action: #selector(AtchmentVc))
            
            attchmentTap.img_urls = upcoming.newfilepath
            
            attchmentTap.imageFileType = upcoming.assignmenttype
            
            attchmentTap.titee = upcoming.topic
            
            attchmentTap.descrttt = upcoming.description
            
            for i in upcoming.newfilepath{
                
                attchmentTap.img_url = i
                
            }
            
            cell.PlusOneView.addGestureRecognizer(attchmentTap)
            
        }
        
        let forward = AssigmentDeletes(target: self, action: #selector(ForwardVC))
        
        
        forward.assigmentHeaderId = upcoming.assignmentid
        
        forward.ImgeType = upcoming.assignmenttype
        
        forward.dateText = upcoming.submissiondate
        
        forward.titleText = upcoming.topic
        
        forward.resiveId = "8"
        
        forward.discreptionForwad = upcoming.description
        
        forward.newfilePathForWad = upcoming.newfilepath
        
        forward.fileType = upcoming.assignmenttype
        
        cell.forwardView.addGestureRecognizer(forward)
        
        
        
        if upcoming.submittedcount != "0"{
            
            cell.submissionView.isUserInteractionEnabled = true
            
            cell.submissionView.isHidden = false
            
            cell.submissionDefaultlbl.textColor = UIColor(named: "Next")
            cell.countLabel.textColor = UIColor(named: "Next")
            cell.submissionDefaultlbl.textColor = UIColor(named: "Next")
            cell.submissionView.cornerRadius = 8
            cell.submissionView.borderColor = UIColor(named: "Next")!
            cell.submissionView.isUserInteractionEnabled = true
            
            
            let submission = AssigmentDeletes(target: self, action: #selector(AssigmentSubmissionVC))
            
            submission.assigmentHeaderId = upcoming.assignmentid
            
            submission.fileType = upcoming.assignmenttype
            submission.memberId = upcoming.createdby
            cell.submissionView.addGestureRecognizer(submission)
            
            
            
        }
        
        
        
        else{
            
            cell.submissionView.isUserInteractionEnabled = false
            cell.submissionView.isHidden = false
            cell.submissionDefaultlbl.textColor = UIColor(named: "SendByColor")
            cell.countLabel.textColor = UIColor(named: "SendByColor")
            cell.submissionDefaultlbl.textColor = UIColor(named: "SendByColor")
            cell.submissionView.cornerRadius = 8
            cell.submissionView.borderColor = UIColor(named: "SendByColor")!
            
            
            let submission = AssigmentDeletes(target: self, action: #selector(AssigmentSubmissionVC))
            
            submission.assigmentHeaderId = upcoming.assignmentid
            
            submission.fileType = upcoming.assignmenttype
            
            cell.submissionView.addGestureRecognizer(submission)
            
        }
        
        cell.notSubLBL.text = "Not submitted" + " : " + upcoming.totalcount
        
        let vc = AssigmentDeletes(target: self, action:#selector(NotSelectdFunc) )
        vc.assigmentHeaderId = upcoming.assignmentid
        cell.notSubmittedView.addGestureRecognizer(vc)
        
        
        
    }
    
    else if assigmentSegmentName.selectedSegmentIndex == 1 {
        
        
        
        let past : upcommingdataDetails = PasrRef[indexPath.row]
        
        
        
        if let selectedCells = selectedCell, selectedCells == indexPath {
            
            
            
            cell.descriptionLabel.isHidden = false
            
            
            
            
            cell.creatonLabel.isHidden = false
            
            cell.cellArrowImage.isHidden = true
            
            cell.sentByDefaultLbl.isHidden = false
            
            cell.submisonDfaltLbl.isHidden = false
            
            
            cell.AttchmentView.isHidden = false
            
            cell.submitionDateLabel.isHidden = false
            
            cell.forwardView.isHidden = false
            
            
            cell.PlusOneView.isHidden = false
            
            cell.plusOneCountLabel.isHidden = false
            
            cell.submissionView.isHidden = false
            
            cell.forwardView.isHidden = false
            
            cell.PlusOneView.isHidden = false
            cell.submutionDateFullView.isHidden = false
            
            cell.SubmissonHorizontalStack.isHidden = false
            cell.SubmissonHorizontalStackHeight.constant = 37
            
            cell.creatonLabel.alpha = 1
            
            if past.assignmenttype == "Text"{
                
                cell.AttchmentView.isHidden = true
                
                cell.PlusOneView.isHidden = true
                
                
            }
            
            
            
            else if past.assignmenttype ==  "text"{
                
                
                
                cell.AttchmentView.isHidden = true
                
                cell.PlusOneView.isHidden = true
                
                
            }
            
            
            else if past.assignmenttype == "All"{
                
                cell.AttchmentView.isHidden = true
                
                cell.PlusOneView.isHidden = true
                
                
            }
            
            else{
                
                cell.AttchmentView.isHidden = false
                
                cell.PlusOneView.isHidden = false
            }
            
            if past.isappread == "1"{
                
                cell.readDotImageView.isHidden =  true
                
            }
            
            else {
                
                cell.readDotImageView.isHidden = false
            }
            
        } else {
            
            
            cell.creatonLabel.isHidden = true
            
            cell.descriptionLabel.isHidden = true
            
            cell.cellArrowImage.isHidden = false
            
            cell.sentByDefaultLbl.isHidden = true
            
            cell.submisonDfaltLbl.isHidden = true
            
            cell.AttchmentView.isHidden = true
            
            cell.submitionDateLabel.isHidden = true
            
            cell.forwardView.isHidden = true
            
            cell.PlusOneView.isHidden = true
            
            cell.plusOneCountLabel.isHidden = true
            
            cell.submissionView.isHidden = true
            
            cell.forwardView.isHidden = true
            
            cell.PlusOneView.isHidden = true
            
            cell.submutionDateFullView.isHidden = true
            cell.SubmissonHorizontalStack.isHidden = true
            cell.SubmissonHorizontalStackHeight.constant = 0
            cell.creatonLabel.alpha = 0
            
        }
        
        cell.topicLabel.text = past.topic.capitalized
        cell.dateTimeLabel.text = past.createdon
        cell.descriptionLabel.text = past.description
        cell.creatonLabel.text = past.sentbyname
        cell.notSubLBL.text = "Not submitted" + " : " + past.totalcount
        cell.countLabel.text = past.submittedcount
        
        
        let dateFormatterGet = DateFormatter()
        
        
        
        dateFormatterGet.dateFormat = "dd-MM-yyy"
        
        
        
        let dateFormatterPrint = DateFormatter()
        
        dateFormatterPrint.dateFormat = " dd MMM,yyyy"
        
        let dates: NSDate? = dateFormatterGet.date(from: past.submissiondate) as NSDate?
        
        
        
        cell.submitionDateLabel.text = dateFormatterPrint.string(from: dates as! Date)
        
        
        
        let  plusoneCount  = past.newfilepath.count-1
        
        let stringconvert = String(plusoneCount)
        
        cell.plusOneCountLabel.text = "+" + stringconvert
        
        
        
        if past.userfilename  == ""{
            
            
            
            cell.AttchmentView.isHidden = true
            
            cell.PlusOneView.isHidden = true
            
        }
        
        
        
        
        
        else if past.userfilename  == "null"{
            
            
            
            cell.AttchmentView.isHidden = true
            
            cell.PlusOneView.isHidden = true
            
            
            
        }
        
        
        
        
        
        else{
            
            
            
            
            
            
        }
        
        
        if past.newfilepath.count == 1  {
            
            cell.PlusOneView.isHidden = true
            
            let  attchmentTap = senderassigments(target: self, action: #selector(AtchmentVc))
            
            attchmentTap.img_urls = past.newfilepath
            
            attchmentTap.imageFileType = past.assignmenttype
            
            attchmentTap.titee = past.topic
            
            attchmentTap.descrttt = past.description
            
            for i in past.newfilepath{
                
                attchmentTap.img_url = i
                
            }
            
            cell.AttchmentView.addGestureRecognizer(attchmentTap)
            
            
        }
        
        
        
        else{
            
            let  attchmentTap = senderassigments(target: self, action: #selector(AtchmentVc))
            
            attchmentTap.img_urls = past.newfilepath
            
            attchmentTap.imageFileType = past.assignmenttype
            
            attchmentTap.titee = past.topic
            
            attchmentTap.descrttt = past.description
            
            for i in past.newfilepath{
                
                attchmentTap.img_url = i
                
            }
            
            cell.AttchmentView.addGestureRecognizer(attchmentTap)
            
        }
        
        if past.newfilepath.count == 1  {
            
            
            cell.PlusOneView.isHidden = true
            
            let  attchmentTap = senderassigments(target: self, action: #selector(AtchmentVc))
            
            attchmentTap.img_urls = past.newfilepath
            
            attchmentTap.imageFileType = past.assignmenttype
            
            attchmentTap.titee = past.topic
            
            attchmentTap.descrttt = past.description
            
            for i in past.newfilepath{
                
                attchmentTap.img_url = i
                
            }
            
            cell.PlusOneView.addGestureRecognizer(attchmentTap)
            
        }
        
        
        else{
            
            
            let  attchmentTap = senderassigments(target: self, action: #selector(AtchmentVc))
            
            attchmentTap.img_urls = past.newfilepath
            
            attchmentTap.imageFileType = past.assignmenttype
            
            attchmentTap.titee = past.topic
            
            attchmentTap.descrttt = past.description
            
            for i in past.newfilepath{
                
                attchmentTap.img_url = i
                
            }
            
            cell.PlusOneView.addGestureRecognizer(attchmentTap)
            
        }
        
        if memberId == past.createdby{
            
            
            cell.forwardView.isHidden = false
            
            
            
        }else{
            
            cell.forwardView.isHidden = true
            
        }
        
        
        
        
        
        let forward = AssigmentDeletes(target: self, action: #selector(ForwardVC))
        
        
        
        forward.assigmentHeaderId = past.assignmentid
        
        forward.ImgeType = past.assignmenttype
        
        forward.dateText = past.submissiondate
        
        forward.titleText = past.topic
        
        forward.resiveId = "8"
        
        forward.newfilePathForWad = past.newfilepath
        
        forward.discreptionForwad = past.description
        
        forward.fileType = past.assignmenttype
        
        cell.forwardView.addGestureRecognizer(forward)
        
        
        
        if past.submittedcount != "0"{
            
            
            cell.submissionView.isHidden = false
            
            
            cell.submissionDefaultlbl.textColor = UIColor(named: "Next")
            cell.countLabel.textColor = UIColor(named: "Next")
            cell.submissionDefaultlbl.textColor = UIColor(named: "Next")
            cell.submissionView.cornerRadius = 8
            cell.submissionView.borderColor = UIColor(named: "Next")!
            cell.submissionView.isUserInteractionEnabled = true
            
            
            let submission = AssigmentDeletes(target: self, action: #selector(AssigmentSubmissionVC))
            
            submission.assigmentHeaderId = past.assignmentid
            
            submission.fileType = past.assignmenttype
            
            cell.submissionView.addGestureRecognizer(submission)
            
            
            
            
            
        }
        
        
        
        else{
            
            
            cell.submissionView.isHidden = false
            cell.submissionView.isUserInteractionEnabled = false
            cell.submissionDefaultlbl.textColor = UIColor(named: "SendByColor")
            cell.countLabel.textColor = UIColor(named: "SendByColor")
            cell.submissionDefaultlbl.textColor = UIColor(named: "SendByColor")
            cell.submissionView.cornerRadius = 8
            cell.submissionView.borderColor = UIColor(named: "SendByColor")!
            
            let submission = AssigmentDeletes(target: self, action: #selector(AssigmentSubmissionVC))
            
            submission.assigmentHeaderId = past.assignmentid
            
            submission.fileType = past.assignmenttype
            
            cell.submissionView.addGestureRecognizer(submission)
            
        }
        
        
        let vc = AssigmentDeletes(target: self, action:#selector(NotSelectdFunc) )
        vc.assigmentHeaderId = past.assignmentid
        cell.notSubmittedView.addGestureRecognizer(vc)
        
        
        
    }
    
    
    return cell
    
}




@IBAction func AssigmentSubmissionVC(gesture : AssigmentDeletes){
    
    if assigmentSegmentName.selectedSegmentIndex == 0{
        let vc = AssigmentSubmissionViewController(nibName: nil, bundle: nil)
        vc.assigmentId = gesture.assigmentHeaderId
        vc.assigmentFileType = gesture.fileType
        vc.str = str
        vc.strName = strName
        vc.is_read_enabled = is_read_enabled
        vc.is_write_enabled = is_write_enabled
        
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
    }
    
    
    else{
        
        let vc = AssigmentSubmissionViewController(nibName: nil, bundle: nil)
        vc.assigmentId = gesture.assigmentHeaderId
        vc.assigmentFileType = gesture.fileType
        vc.str = str
        vc.strName = strName
        vc.is_read_enabled = is_read_enabled
        vc.is_write_enabled = is_write_enabled
        
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
        
        
    }
}
@IBAction func ForwardVC(gesture : AssigmentDeletes ){
    
    if assigmentSegmentName.selectedSegmentIndex == 0{
        
        let vc =  PlusScreenNextPageViewController(nibName:nil, bundle: nil)
        
        
        vc.assigmentHeaderId =  gesture.assigmentHeaderId
        vc.Assigment = gesture.resiveId
        vc.strName = strName
        vc.str = str
        vc.is_read_enabled = is_read_enabled
        vc.is_write_enabled = is_write_enabled
        
        vc.ImgeType = gesture.ImgeType
        vc.fileType = gesture.fileType
        vc.titleText = gesture.titleText
        vc.dateText = gesture.dateText
        vc.addImageBackGroundurl = addImageBackGroundurl
        vc.smallImageUrl = smallImageUrl
        vc.imageWebUrl = addurls
        vc.forwadDiscreption = gesture.discreptionForwad
        vc.awsPdfURl = gesture.newfilePathForWad
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true,completion: nil)
        
    }
    
    
    else if assigmentSegmentName.selectedSegmentIndex == 1 {
        
        
        
        let vc =  PlusScreenNextPageViewController(nibName:nil, bundle: nil)
        
        
        
        vc.assigmentHeaderId =  gesture.assigmentHeaderId
        vc.Assigment = gesture.resiveId
        vc.strName = strName
        vc.str = str
        vc.ImgeType = gesture.ImgeType
        vc.titleText = gesture.titleText
        vc.dateText = gesture.dateText
        vc.addImageBackGroundurl = addImageBackGroundurl
        vc.smallImageUrl = smallImageUrl
        vc.forwadDiscreption = gesture.discreptionForwad
        vc.imageWebUrl = addurls
        vc.fileType = gesture.fileType
        vc.awsPdfURl = gesture.newfilePathForWad
        vc.is_read_enabled = is_read_enabled
        vc.is_write_enabled = is_write_enabled
        
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true,completion: nil)
        
        
    }
    
    
}


@IBAction func PastDeleteVc(gesture : AssigmentDeletes){
    
    
    let imagePdfFileArry = FileNameArray()
    
    imagePdfFileArry.fileName = ""
    
    let imagePdf = assigmentImagePdfModal()
    
    imagePdf.collegeid = ""
    
    imagePdf.sectionid = ""
    
    imagePdf.processtype = "delete"
    imagePdf.staffid = ""
    imagePdf.assignmentdescription = ""
    imagePdf.assignmentid = gesture.assigmentHeaderId
    imagePdf.assignmenttopic = ""
    imagePdf.assignmenttype = ""
    imagePdf.callertype = ""
    imagePdf.courseid = ""
    
    imagePdf.receiverid = ""
    imagePdf.receivertype = ""
    
    imagePdf.subjectid = ""
    imagePdf.yearid = ""
    imagePdf.submissiondate = ""
    imagePdf.fileNameArray = [imagePdfFileArry]
    
    let imagePdfStrs = imagePdf.toJSONString()
    
    print("SenderAssigmentDelete",imagePdfStrs)
    
    assigmentDeleteRequest.call_request(param: imagePdfStrs!) {
        
        [self]  (res) in
        
        
        let particularss : [assigmentImagePdfResponce] = Mapper<assigmentImagePdfResponce>().mapArray(JSONString: res)!
        
        
        
        
        for i in particularss{
            
            assigmentImagPdf = particularss
            
            if i.Status == 1 {
                
                
                
                let refreshAlert = UIAlertController(title: "", message: i.Message, preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    
                    
                    
                    
                    
                }))
                
                
                
                present(refreshAlert, animated: true, completion: nil)
                
                
                
                assigmentTableView.dataSource = self
                assigmentTableView.delegate = self
                assigmentTableView.reloadData()
                
                
                PastRefName()
            }else{
                
                
                let refreshAlert = UIAlertController(title: "", message: i.Message, preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    
                    
                    
                    
                    
                }))
                
                
                
                present(refreshAlert, animated: true, completion: nil)
                
                
                assigmentTableView.dataSource = self
                assigmentTableView.delegate = self
                assigmentTableView.reloadData()
            }
            
            
            
        }
        
        
        
    }
    
}


@IBAction func UpcomingDeleteVc(gesture : AssigmentDeletes){
    
    
    
    
    
    
    let imagePdfFileArry = FileNameArray()
    
    imagePdfFileArry.fileName = ""
    
    let imagePdf = assigmentImagePdfModal()
    
    imagePdf.collegeid = ""
    
    imagePdf.sectionid = ""
    
    imagePdf.processtype = "delete"
    imagePdf.staffid = ""
    imagePdf.assignmentdescription = ""
    imagePdf.assignmentid = gesture.assigmentHeaderId
    imagePdf.assignmenttopic = ""
    imagePdf.assignmenttype = ""
    imagePdf.callertype = ""
    imagePdf.courseid = ""
    
    imagePdf.receiverid = ""
    imagePdf.receivertype = ""
    
    imagePdf.subjectid = ""
    imagePdf.yearid = ""
    imagePdf.submissiondate = ""
    imagePdf.fileNameArray = [imagePdfFileArry]
    
    let imagePdfStrs = imagePdf.toJSONString()
    
    print("yearAndSectionModalStr",imagePdfStrs)
    
    assigmentDeleteRequest.call_request(param: imagePdfStrs!) {
        
        [self]  (res) in
        
        
        let particularss : [assigmentImagePdfResponce] = Mapper<assigmentImagePdfResponce>().mapArray(JSONString: res)!
        
        
        
        
        for i in particularss{
            
            assigmentImagPdf = particularss
            
            if i.Status == 1 {
                
                
                
                let refreshAlert = UIAlertController(title: "", message: i.Message, preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    
                }))
                
                
                
                present(refreshAlert, animated: true, completion: nil)
                assigmentTableView.dataSource = self
                assigmentTableView.delegate = self
                assigmentTableView.reloadData()
                
                
                UpcommingRefName()
            }else{
                
                
                let refreshAlert = UIAlertController(title: "", message: i.Message, preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    
                    
                    
                }))
                
                present(refreshAlert, animated: true, completion: nil)
                
                
                assigmentTableView.dataSource = self
                assigmentTableView.delegate = self
                assigmentTableView.reloadData()
            }
            
            
            
        }
        
        
        
    }
    
    
    
    
    
    
    
}



@IBAction func AtchmentVc(gesture : senderassigments){
    
    
    
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


func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }

func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    assigmentTableView.deselectRow(at: indexPath, animated: true)
    
    
    let cell = tableView.dequeueReusableCell(withIdentifier: Indentifiers, for: indexPath) as!
    
    SenderAssigmentTableViewCell
    
    
    
    if assigmentSegmentName.selectedSegmentIndex == 0{
        
        
        if let selectedCells = selectedCell, selectedCells == indexPath {
            
            selectedCell = nil
            
            
        } else {
            
            
            selectedCell = indexPath
            let upcoming : upcommingdataDetails = UpcommingRef[indexPath.row]
            let readApiStatus  = AppReadStatusModal()
            
            if upcoming.isappread == "0"{
                
                apread(gesture : upcoming.assignmentdetailid)
                
                upcoming.isappread = "1"
                cell.readDotImageView.isHidden = true
                
            }
        }
        
        
        
    }
    
    else if assigmentSegmentName.selectedSegmentIndex == 1 {
        
        
        
        
        if let selectedCells = selectedCell, selectedCells == indexPath {
            
            selectedCell = nil
            
            
        } else {
            
            
            selectedCell = indexPath
            let past : upcommingdataDetails = PasrRef[indexPath.row]
            
            if past.isappread == "0"{
                
                apread(gesture : past.assignmentdetailid)
                
                past.isappread = "1"
                cell.readDotImageView.isHidden = true
                
            }
            
        }
        
        
        
        
    }
    
    
    assigmentTableView.beginUpdates()
    assigmentTableView.endUpdates()
    assigmentTableView.reloadData()
    
}


func apread(gesture : String){
    
    var readApiStatus  = AppReadStatusModal()
    
    readApiStatus.msgtype = "assignment"
    readApiStatus.priority = priority
    readApiStatus.userid = memberId
    readApiStatus.detailsid = gesture
    print("sertt",gesture)
    
    APiCallManager.shared.callApi(url: APIEndpoints.Appreadstatus, httpMethod: .post, queryParam: nil, requestBody: readApiStatus) {[weak self]  (result:Result<ReadStausApiResponce, Error>) in
        
        guard let self = self else {return}
        
        switch result {
        case .success(let success):
            assigmentTableView.reloadData()
        case .failure(let failure):
            print(failure.localizedDescription)
        }
    }
}

func UpcommingRefName() {
    
    let Upcom = senderUpcommingModal()
    
    Upcom.userid   = memberId
    Upcom.collegeid    = colgId
    Upcom.departmentid = deptid
    Upcom.sectionid     = sectionid
    Upcom.appid    =  "2"
    Upcom.priority = priority
    Upcom.type = "upcomingassignments"
    
    
    
    let upcommingStr = Upcom.toJSONString()
    
    
    senderPastRequest.call_request(param: upcommingStr!){ [self]
        
        (res) in
        
        
        let upcommingResp : senderUpcommingResponces =
        Mapper<senderUpcommingResponces>().map(JSONString: res)!
        
        
        if upcommingResp.Status == 1 {
            
            print("order data",upcommingResp)
            
            cloneList = upcommingResp.data
            UpcommingRef = upcommingResp.data
            
            
            assigmentTableView.isScrollEnabled = true
            noDataView.isHidden = true
            noDataTextLabel.isHidden = true
            assigmentTableView.delegate = self
            assigmentTableView.dataSource = self
            assigmentTableView.reloadData()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3 ){ [self] in
                
                loadingCustom.stopAnimating()
                
                loadingCustom.isHidden  = true
                
            }
            
            
        }else{
            
            
            noDataView.isHidden = false
            noDataTextLabel.isHidden = false
            noDataTextLabel.text = upcommingResp.Message
            assigmentTableView.delegate = self
            assigmentTableView.dataSource = self
            assigmentTableView.reloadData()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3 ){ [self] in
                
                loadingCustom.stopAnimating()
                
                loadingCustom.isHidden  = true
                
            }
            
            
            print("noRecords")
        }
        
        
        
    }
    
    
    
    
}


func PastRefName() {
    
    let past = senderUpcommingModal()
    
    past.userid   = memberId
    
    past.collegeid    = colgId
    
    past.departmentid = deptid
    past.sectionid     = sectionid
    
    past.appid    =  "2"
    past.priority = priority
    
    past.type = "pastassignments"
    
    
    let pastStr = past.toJSONString()
    
    print("kkkkkkk",pastStr)
    
    senderPastRequest .call_request(param: pastStr!){ [self]
        
        (res) in
        
        
        let pastResp : senderUpcommingResponces =
        Mapper<senderUpcommingResponces>().map(JSONString: res)!
        
        print("order data",pastResp)
        
        
        if pastResp.Status == 1{
            
            
            PasrRef = pastResp.data
            cloneList = pastResp.data
            
            assigmentTableView.isScrollEnabled = true
            noDataView.isHidden = true
            noDataTextLabel.isHidden = true
            
            assigmentTableView.delegate = self
            assigmentTableView.dataSource = self
            assigmentTableView.reloadData()
            
            
            
            
        }
        
        else {
            
            
            //
            
            noDataView.isHidden = false
            noDataTextLabel.isHidden = false
            noDataTextLabel.text = pastResp.Message
            assigmentTableView.delegate = self
            assigmentTableView.dataSource = self
            assigmentTableView.reloadData()
            
            
            
        }
        
        
    }
    
    
    
    
}



func overAllRefName() {
    
    var overall = overAllModal()
    
    overall.userid   =  memberId
    overall.menuid       = "5"
    overall.collegeid    = colgId
    overall.departmentid =  deptid
    overall.sectionid    =   sectionid
    overall.appid        = "2"
    overall.priority     = priority
    
    
    APiCallManager.shared.callApi(url: APIEndpoints.GetOverallcountByMenuType, httpMethod: .post, queryParam: nil, requestBody: overall) { [weak self] (result:Result<overAllResponce,Error>) in
        guard let self = self else{return}
        switch result {
        case .success(let success):
            if success.Status == 1{
                overAllRef = success.data ?? []
                
                for i in overAllRef{
                    
                    assigmentUpcommingCount.text = i.upcomingassignment
                    assigmentPastCount.text = i.pastassignment
                    if (i.upcomingassignment == "0") && (i.pastassignment == "0"){
                        
                        upcommingcountView.isHidden = true
                        assigmentPastCountView.isHidden = true
                        assigmentCountViews.isHidden = true
                        
                        
                        
                    }
                    
                    else if  i.upcomingassignment == "0"{
                        
                        upcommingcountView.isHidden = true
                        assigmentPastCountView.isHidden = false
                        assigmentCountViews.isHidden = false
                        
                        
                    }
                    
                    else if i.pastassignment == "0"{
                        
                        upcommingcountView.isHidden = false
                        assigmentPastCountView.isHidden = true
                        assigmentCountViews.isHidden = false
                        
                        
                        
                    }
                    
                    else{
                        
                        upcommingcountView.isHidden = false
                        assigmentPastCountView.isHidden = false
                        assigmentCountViews.isHidden = false
                        
                        
                    }
                    
                }
                
                
                let a =  Int( assigmentUpcommingCount.text!)
                let b = Int(assigmentPastCount.text!)
                let c = a! + b!
                
                assigmentTopCount.text = String(c)
                
                
                
                
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
    add.member_id = memberId
    add.mobile_no = mobileNumber
    add.priority = priority
    add.college_id = colgId
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



@IBAction func adLoad(gesture:senderassAdd){
    
    
    let vc = SenderExamAddVcViewController(nibName: nil, bundle: nil)
    
    vc.AddWebUrl = gesture.url
    
    vc.modalPresentationStyle = .fullScreen
    present(vc, animated: true,completion: nil)
    
    
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
        
        //            self.tv.reloadData()
        
        
        KRProgressHUD.dismiss()
        
    }
    
    if  segmentID == "1"{
        
        UpcommingRefName()
    }
    else{
        
        PastRefName()
        
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


class senderassigments : UITapGestureRecognizer{


var img_url : String!
var imageFileType : String!
var titee : String!
var descrttt : String!

var img_urls : [String] = []

}

class senderassAdd : UITapGestureRecognizer{


var url : String!

}


class AssigmentDeletes : UITapGestureRecognizer{


var assigmentHeaderId : String!

var resiveId : String!

var fileType : String!

var titleText : String!

var dateText : String!
var ImgeType : String!
var newfilePathForWad : [String]!

var discreptionForwad : String!

var memberId : String!
}

class forwardAssigment : UITapGestureRecognizer{


}


