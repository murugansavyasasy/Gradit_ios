//
//  SenderVideoHomePageViewController.swift
//  GraditSenderVideoMenu
//
//  Created by MACBOOKPRO on 03/12/22.
//

import UIKit
import ObjectMapper
import KRProgressHUD

@available(iOS 16.0, *)
class SenderVideoHomePageViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate {

@IBOutlet weak var reusee: ReuseView!
@IBOutlet weak var SearchView: UIView!
@IBOutlet weak var searchFullView: UIViewX!
@IBOutlet weak var searchbar: UISearchBar!
@IBOutlet weak var tapNameview: UIView!
@IBOutlet weak var tapBarView: UIViewX!
@IBOutlet weak var loadingCustom: UIActivityIndicatorView!
@IBOutlet weak var redirectLoginView: UIViewX!
@IBOutlet weak var notificationView: UIView!
@IBOutlet weak var smallImg: UIImageView!
@IBOutlet weak var bigImg: UIImageView!
@IBOutlet weak var plusPageView: UIViewX!
@IBOutlet weak var privacyPolicyView: UIView!
@IBOutlet weak var helpView: UIView!
@IBOutlet weak var faqView: UIView!
@IBOutlet weak var refreshView: UIView!
@IBOutlet weak var logoutView: UIView!
@IBOutlet weak var changeRolesView: UIView!
@IBOutlet weak var profileView: UIView!
@IBOutlet weak var topLabels: UILabel!
@IBOutlet weak var topMessageLabel: UILabel!
@IBOutlet weak var clgLogoImg: UIImageView!
@IBOutlet weak var sideMenuView: UIView!
@IBOutlet weak var viewTap: UIView!
@IBOutlet weak var changePasswordView: UIView!
@IBOutlet weak var termsAndConditionView: UIView!
@IBOutlet weak var swipeMenuHeight: NSLayoutConstraint!
@IBOutlet weak var videoTableView: UITableView!
@IBOutlet weak var noDataTextLabel: UILabel!
@IBOutlet weak var noDataView: UIView!

var NoticeBoardId = "1"
var videoId = "2"
var EventId = "3"
var communicationId = "4"
var imagePdfId = "5"
var Assigment = "6"
var videoRef     : [SendervideoDataDetails] = []
var MenuRefName :[menuApiDataDetails] = []
var addapiRef : [AddDataDeatils] = []
var identifers = "SenderVideoTableViewCell"
let menuIdentifier = "MenuCollectionViewCell"
var selectedCell : IndexPath?
var memberId : String!
var priority : String!
var colgId   : String!
var loginType : String!
var memberName : String!
var colgImg : String!
var VideoMenuId : String!
var mobileNumber : String!
var loginDatas : [datalogin]!
var logindataprinci :[datalogin]!
var str : [String] = []
var strName : [String] = []
var is_read_enabled = ""
var is_write_enabled = ""
var password : String!
var PreviousAddId : Int = 0
var cloneList : [SendervideoDataDetails] = []
    
    
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
    loginType = defaults.string(forKey: DefaultsKeys.loginAsType)
    memberName = defaults.string(forKey: DefaultsKeys.memberName)
    mobileNumber = defaults.string(forKey: DefaultsKeys.mobileNumber)
    colgImg = defaults.string(forKey: DefaultsKeys.colglogo)
    clgLogoImg.sd_setImage(with: URL(string:  colgImg), placeholderImage: UIImage(named: "person.fill"))
    password = defaults.string(forKey: DefaultsKeys.Password)
    topMessageLabel.text = memberName
    
    addApi()
    
    videoModals()
    if priority == "p1"{
        tapBarView.backgroundColor = UIColor(named: "Principal" )
        topLabels.text = "Principal"
    }
    
    else if priority == "p4"{
        
        topLabels.text = "Student"
    }
    
    else if priority == "p2" {
        
        tapBarView.backgroundColor = UIColor(named: "Teaching Staff" )
        plusPageView.backgroundColor = UIColor(named: "messagecolor")
        topLabels.text = "Hod"
    }
    
    else if priority == "p5"{
        
        topLabels.text = "Father"
    }
    
    else if priority == "p3"{
        
        tapBarView.backgroundColor = UIColor(named: "Teaching Staff" )
        plusPageView.backgroundColor = UIColor(named: "messagecolor")
        topLabels.text = "Teacher"
    }
    
    
    else if priority == "p6"{
        
        tapBarView.backgroundColor = UIColor(named: "Teaching Staff" )
        topLabels.text = "NonTeaching"
        
        plusPageView.isHidden = true
    }
    
    else if priority == "p7"{
        
        tapBarView.backgroundColor = UIColor(named: "univercityColorCod" )
        topLabels.text = "University Head"
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
    
    
    else if priority == "p6" {
        
        print("HooodddVieewwColor")
        view.backgroundColor = UIColor(named: "Teaching Staff")
        
        reusee.menuImg.image = UIImage(named: "HodImage")
    }
    
    
    else if priority == "p7" {
        
        print("HooodddVieewwColor")
        view.backgroundColor = UIColor(named: "univercityColorCod")
        
        reusee.menuImg.image = UIImage(named: "UnivercityHead")
    }
    
    let plusPageViews = UITapGestureRecognizer(target: self, action: #selector(plusPageVc))
    plusPageView.addGestureRecognizer(plusPageViews)
    
    swipeMenuHeight.constant = 150
    reusee.call_back = { [self]
        (val) in
        
        
        self.swipeMenuHeight.constant =  reusee.callid
        
        print("HelloWorld544544343",reusee.callid)
    }
    
    
    let rownib = UINib(nibName: identifers, bundle: nil)
    videoTableView.register(rownib, forCellReuseIdentifier: identifers)
    
    videoTableView.delegate = self
    videoTableView.dataSource = self
    
    noDataView.isHidden = true
    noDataTextLabel.isHidden = true
    
    
    let changeRolesGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
    changeRolesView.addGestureRecognizer(changeRolesGesture)
    
    
    let tpname = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
    tapNameview.addGestureRecognizer(tpname)
    
    
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
    
    
    let loginRediectGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
    redirectLoginView.addGestureRecognizer(loginRediectGesture)
    
    
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
    
    let filtered_list : [SendervideoDataDetails] = Mapper<SendervideoDataDetails>().mapArray(JSONString: cloneList.toJSONString()!)!
    
    if !searchText.isEmpty{
        
        videoRef = filtered_list.filter {
            
            
            $0.description.lowercased().contains(searchText.lowercased())  || $0.createdby.lowercased().contains(searchText.lowercased()) ||  $0.createdon.lowercased().contains(searchText.lowercased()) || $0.title.lowercased().contains(searchText.lowercased())
            
        }
        
        
    }else{
        
        videoRef = filtered_list
        
        print("pendingOrder")
    }
    
    
    if videoRef.count > 0{
        
        print ("searchListPendigCount",videoRef.count)
        
    }else{
        
    }
    
    videoTableView.reloadData()
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


func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return videoRef.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: identifers, for: indexPath) as!
    SenderVideoTableViewCell
    
    
    cell.selectionStyle = .none
    
    
    if let selectedCells = selectedCell, selectedCells == indexPath {
        
        cell.descriptionLableCell.isHidden = false
        
        cell.sendView.isHidden = false
        cell.downArrowImage.image = UIImage(named: "up")
        
        
    } else {
        
        cell.descriptionLableCell.isHidden = true
        cell.sendView.isHidden = true
        cell.downArrowImage.image = UIImage(named: "down")
    }
    
    
    let Shopres : SendervideoDataDetails = videoRef[indexPath.row]
    
    cell.sentByLableCell.text = Shopres.createdby
    cell.descriptionLableCell.text = Shopres.description
    cell.titleLableCell.text  = Shopres.title.capitalized
    cell.dateTimeLabelCell.text = Shopres.createdon
    
    if Shopres.isappviewed == "1"{
        
        
        cell.redDotImageView.isHidden = true
    }
    
    else {
        
        cell.redDotImageView.isHidden = false
    }
    
    
    let nexts : SendervideoDataDetails = videoRef[indexPath.row]
    
    let  play = videoGestures(target: self, action: #selector(connected))
    play.title = nexts.title
    play.desc = nexts.description
    play.videoUrl = nexts.iframe
    play.videoid = nexts.vimeoid
    cell.playView.addGestureRecognizer(play)
    
    return cell
    
}

@IBAction func connected( gestures : videoGestures) {
    
    
    if priority == "p2" || priority == "p3" {
        
        let vc = SenderPlayingVideoViewController(nibName: nil, bundle: nil)
        vc.viewBgColor = "Teaching Staff"
        vc.titlesss = gestures.title
        vc.descriptionszs = gestures.desc
        vc.url = gestures.videoUrl
        vc.videoid = gestures.videoid
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
    }
    
    
    if priority == "p7" {
        
        let vc = SenderPlayingVideoViewController(nibName: nil, bundle: nil)
        vc.viewBgColor = "univercityColorCod"
        vc.titlesss = gestures.title
        vc.descriptionszs = gestures.desc
        vc.url = gestures.videoUrl
        vc.videoid = gestures.videoid
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
    }
    
    else{
        
        let vc = SenderPlayingVideoViewController(nibName: nil, bundle: nil)
        vc.viewBgColor = "Principal"
        vc.titlesss = gestures.title
        vc.descriptionszs = gestures.desc
        vc.url = gestures.videoUrl
        vc.videoid = gestures.videoid
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
    }
}


@IBAction func plusPageVc(){
    
    
    for i in addapiRef{
        
        let vc = VideoRestionViewController(nibName: nil, bundle: nil)
        
        vc.addImageBackGroundurl = i.background_image
        vc.smallImageUrl = i.add_image
        vc.imageWebUrl = i.add_url
        vc.videoMenuId = videoId
        vc.str  = str
        vc.is_read_enabled = is_read_enabled
        vc.is_write_enabled = is_write_enabled
        
        vc.strName = strName
        vc.modalPresentationStyle = .formSheet
        present(vc, animated: true,completion: nil)
        
    }
}


func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    videoTableView.deselectRow(at: indexPath, animated: true)
    let cell = tableView.dequeueReusableCell(withIdentifier: identifers, for: indexPath) as!
    SenderVideoTableViewCell
    
    let Shopres : SendervideoDataDetails = videoRef[indexPath.row]
    
    if let selectedCells = selectedCell, selectedCells == indexPath {
        
        
        selectedCell = nil
        
    } else {
        
        selectedCell = indexPath
        
        if Shopres.isappviewed == "0"{
            
            apread(gesture : Shopres.detailid)
            
            Shopres.isappviewed = "1"
            cell.redDotImageView.isHidden = true
            
        }
        
    }
    
    videoTableView.beginUpdates()
    videoTableView.endUpdates()
    videoTableView.reloadData()
    
}


func apread(gesture : String){
    
    
    let readApiStatus  = AppReadStatusModal()
    
    readApiStatus.msgtype = "video"
    readApiStatus.priority = priority
    readApiStatus.userid = memberId
    readApiStatus.detailsid = gesture
    print("sertt",gesture)
    
    
    let commuS = readApiStatus.toJSONString()
    
    ApiReadStatusRequest .call_request(param: commuS!){ [self]
        
        (res) in
        
        
        let com : ReadStausApiResponce =
        Mapper<ReadStausApiResponce>().map(JSONString: res)!
        
        
        
        videoTableView.delegate = self
        videoTableView.dataSource = self
        videoTableView.reloadData()
        
    }
    
}


func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    return UITableView.automaticDimension
}
    
    
func videoModals() {
    
    let vedi = SendervideoModal()
    
    vedi.userid       =  memberId
    vedi.collegeid     =  colgId
    vedi.priority      =  priority
    
    let videoStr = vedi.toJSONString()
    
    
    SenderVideoRequest .call_request(param: videoStr!){ [self]
        
        (res) in
        
        
        let VideoResp : SendervideoResponce =
        Mapper<SendervideoResponce>().map(JSONString: res)!
        
        print("order data",VideoResp)
        
        
        if VideoResp.Status == 1 {
            
            
            videoRef = VideoResp.data
            cloneList = VideoResp.data
            
            noDataView.isHidden = true
            noDataTextLabel.isHidden = true
            videoTableView.delegate = self
            videoTableView.dataSource = self
            
            videoTableView.reloadData()
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3 ){ [self] in
                
                loadingCustom.stopAnimating()
                
                
                loadingCustom.isHidden  = true
                
            }
            
        }
        
        else {
            
            
            noDataView.isHidden = false
            noDataTextLabel.isHidden = false
            noDataTextLabel.text = VideoResp.Message
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3 ){ [self] in
                
                loadingCustom.stopAnimating()
                
                loadingCustom.isHidden  = true
                
            }
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


@IBAction func adLoad( gesture : videoAdd){
    
    
    let vc = TotalAddLoadPageViewController(nibName: nil, bundle: nil)
    
    vc.AddWebUrl = gesture.url
    
    vc.modalPresentationStyle = . fullScreen
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
        
        
        
        
        KRProgressHUD.dismiss()
        
    }
    
    videoModals()
    
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



class videoGestures : UITapGestureRecognizer {

var title : String!
var desc : String!
var videoUrl : String!
var videoid : String!

}


class videoAdd : UITapGestureRecognizer{


var url : String!

}
