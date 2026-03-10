//
//  ImageViewController.swift
//  GraditCircularImage
//
//  Created by MACBOOKPRO on 02/11/22.
//

import UIKit
import ObjectMapper
import WebKit
import KRProgressHUD

@available(iOS 16.0, *)
class ImageViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {

@IBOutlet weak var reusee: ReuseView!

@IBOutlet weak var tapBarView: UIViewX!


@IBOutlet weak var topNameview: UIView!
@IBOutlet weak var loadingCustom: UIActivityIndicatorView!

@IBOutlet weak var logoutView: UIView!

@IBOutlet weak var changeRolesView: UIView!

@IBOutlet weak var redirectLoginView: UIViewX!

@IBOutlet weak var searchbar: UISearchBar!
@IBOutlet weak var profileView: UIView!
@IBOutlet weak var topLabels: UILabel!
@IBOutlet weak var clgLogoImg: UIImageView!


@IBOutlet weak var notificationView: UIView!

@IBOutlet weak var privacyPolicyView: UIView!



@IBOutlet weak var topMemberLabel: UILabel!


@IBOutlet weak var faqView: UIView!


@IBOutlet weak var refreshView: UIView!

@IBOutlet weak var viewTap: UIView!



@IBOutlet weak var sideMenuView: UIView!




@IBOutlet weak var helpView: UIView!



@IBOutlet weak var termsAndConditionView: UIView!


@IBOutlet weak var changePasswordView: UIView!


@IBOutlet weak var searchFullView: UIViewX!


@IBOutlet weak var imageCountView: UIViewX!
@IBOutlet weak var collegeCountView: UIViewX!

@IBOutlet weak var departmentCountView: UIViewX!

@IBOutlet weak var smallImg: UIImageView!
@IBOutlet weak var bigImg: UIImageView!
@IBOutlet weak var adView: UIView!
@IBOutlet weak var imageTopCountLabel: UILabel!
@IBOutlet weak var collegeCountLabel: UILabel!

@IBOutlet weak var departmentCountLabel: UILabel!

@IBOutlet weak var noDataLabel: UILabel!

@IBOutlet weak var noDataTextView: UIView!



@IBOutlet weak var imageTableView: UITableView!

@IBOutlet weak var imageSegmentName: UISegmentedControl!




@IBOutlet weak var swipeMenuHeight: NSLayoutConstraint!



@IBOutlet weak var SearchView: UIView!

var identifers = "ImageTableViewCell"
let menuIdentifier = "MenuCollectionViewCell"
var MenuRefName :[menuApiDataDetails] = []


var addapiRef : [AddDataDeatils] = []
var departmentRef     : [departmentImageDataDetails] = []
var collegeRef     : [departmentImageDataDetails] = []
var overAllRef    : [overAllDataDetails] = []

var loginDatas : [datalogin]!
var logindataprinci :[datalogin]!

var selectedIndex = -1
var isclosaps = false
var selectedCell : IndexPath?
var filePathStr : [String] = []
var strs : String!
var collegeid : String!
var userid    : String!
var priority   : String!
var sectionId : String!
var departmentId : String!
var imageRef : [String] = []
var loginType : String!

var memberName : String!

var colgImg : String!

var MobileNumber : String!

var appreadId : String!


var PreviousAddId  : Int = 0

var str : [String] = []

var strName : [String] = []

var is_read_enabled = ""
var is_write_enabled = ""



var password : String!
var backGroundAddImageView : String!
var smallImageAddImageView : String!
var segemntID : String!
var cloneList :  [departmentImageDataDetails] = []


override func viewDidAppear(_ animated: Bool) {
    
    print("kljjjjjjjjj")
    
    
    PreviousAddId = PreviousAddId+1
    
    //        addApi()
    
    print("jkkkkkkk",PreviousAddId)
    
}

override func viewDidLoad() {
    super.viewDidLoad()
    
    loadingCustom.startAnimating()
    overrideUserInterfaceStyle = .light
    sideMenuView.isHidden = true
    searchbar.delegate = self
    searchbar.isHidden  = true
    searchFullView .isHidden = true
    PreviousAddId = PreviousAddId+1
    
    let defaults =  UserDefaults.standard
    
    collegeid = defaults.string(forKey: DefaultsKeys.collegeid)
    userid = defaults.string(forKey: DefaultsKeys.memberid)
    
    
    priority = defaults.string(forKey:DefaultsKeys.priority)
    
    sectionId = defaults.string(forKey: DefaultsKeys.sectionid)
    departmentId = defaults.string(forKey: DefaultsKeys.deptid)
    loginType = defaults.string(forKey: DefaultsKeys.loginAsType)
    memberName = defaults.string(forKey: DefaultsKeys.memberName)
    colgImg = defaults.string(forKey: DefaultsKeys.colglogo)
    clgLogoImg.sd_setImage(with: URL(string:  colgImg), placeholderImage: UIImage(named: "person.fill"))
    
    topMemberLabel.text = memberName
    
    MobileNumber = defaults.string(forKey: DefaultsKeys.mobileNumber)
    
    password = defaults.string(forKey: DefaultsKeys.Password)
    
    addApi()
    overAllRefName()
    
    
    
    
    departRefName()
    
    
    
    
    print("filePathStr.count",filePathStr.count)
    
    
    
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
        
        print("ImageViewController",reusee.callid)
        
        
    }
    
    
    
    
    
    let rownib = UINib(nibName: identifers, bundle: nil)
    imageTableView.register(rownib, forCellReuseIdentifier: identifers)
    
    
    noDataTextView.isHidden = true
    noDataLabel.isHidden = true
    
    
    // tap Bar UiTapGuster.
    
    
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
    
    let profileGesture = UITapGestureRecognizer(target: self, action: #selector(profileRedirect))
    profileView.addGestureRecognizer(profileGesture)
    //
    
    let changeRolesGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
    changeRolesView.addGestureRecognizer(changeRolesGesture)
    
    
    let logoutGesture = UITapGestureRecognizer(target: self, action: #selector(logoutPressed))
    logoutView.addGestureRecognizer(logoutGesture)
    
    
    
    let chagePassword = UITapGestureRecognizer(target: self, action: #selector(changePassowrdVC))
    changePasswordView.addGestureRecognizer(chagePassword)
    
    let loginRediectGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
    redirectLoginView.addGestureRecognizer(loginRediectGesture)
    
    
    
    let Serach = UITapGestureRecognizer(target: self, action: #selector(Searchfield))
    SearchView.addGestureRecognizer(Serach)
    
    
    
}


@IBAction func Searchfield() {
    
    
    searchbar.isHidden  = false
    searchFullView .isHidden = false
    
    
    
    
    
    
    
    
}


func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
    
    
    if imageSegmentName.selectedSegmentIndex == 0{
        
        let filtered_list : [departmentImageDataDetails] = Mapper<departmentImageDataDetails>().mapArray(JSONString: cloneList.toJSONString()!)!
        
        
        if !searchText.isEmpty{
            
            
            
            departmentRef = filtered_list.filter {
                
                
                
                
                
                
                
                $0.title.lowercased().contains(searchText.lowercased()) || $0.description.lowercased().contains(searchText.lowercased()) || $0.createdontime.lowercased().contains(searchText.lowercased()) ||  $0.sentbyname.lowercased().contains(searchText.lowercased()) || $0.sentbyname.lowercased().contains(searchText.lowercased()) ||  $0.filetype.lowercased().contains(searchText.lowercased())
                
                
                
            }
            
            
            
            
        }else{
            
            
            
            departmentRef = filtered_list
            
            
            
            print("pendingOrder")
            
            
            
        }
        
        
        
        
        
        
        
        if departmentRef.count > 0{
            
            
            
            print ("searchListPendigCount",departmentRef.count)
            
            noDataTextView.isHidden = true
            noDataLabel.isHidden = true
            
            
        }else{
            
            
            
            
            noDataTextView.isHidden = false
            noDataLabel.isHidden = false
            noDataLabel.text = "No Records Found"
            
        }
        
        
        
    }
    
    
    
    
    
    else if imageSegmentName.selectedSegmentIndex == 1{
        
        
        
        
        let filtered_list : [departmentImageDataDetails] = Mapper<departmentImageDataDetails>().mapArray(JSONString: cloneList.toJSONString()!)!
        
        
        
        
        if !searchText.isEmpty{
            
            
            
            collegeRef = filtered_list.filter {
                
                
                
                
                
                
                $0.title.lowercased().contains(searchText.lowercased()) || $0.description.lowercased().contains(searchText.lowercased()) || $0.createdontime.lowercased().contains(searchText.lowercased()) ||  $0.sentbyname.lowercased().contains(searchText.lowercased()) || $0.sentbyname.lowercased().contains(searchText.lowercased()) ||  $0.filetype.lowercased().contains(searchText.lowercased())
                
                
                
                
            }
            
            
            
            
            
            
            
        }else{
            
            
            
            collegeRef = filtered_list
            
            
            
            print("pendingOrder")
            
            
            
        }
        
        
        
        
        
        
        
        if collegeRef.count > 0{
            
            
            
            print ("searchListPendigCount",collegeRef.count)
            
            noDataTextView.isHidden = true
            noDataLabel.isHidden = true
            
            
        }else{
            
            
            
            
            noDataTextView.isHidden = false
            noDataLabel.isHidden = false
            noDataLabel.text = "No Records Found"
            
        }
        
        
        
        
    }
    
    
    
    imageTableView.reloadData()
    
    
    
    
    
    
    
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



@IBAction func imageSegment(_ sender: Any) {
    
    if is_read_enabled == "1"{
        
        if imageSegmentName.selectedSegmentIndex == 0 {
            print("ok")
            segemntID = "1"
            selectedCell = IndexPath()
            imageTableView.isScrollEnabled = false
            departRefName()
            
        }
        
        else if imageSegmentName.selectedSegmentIndex == 1{
            segemntID = "2"
            selectedCell = IndexPath()
            imageTableView.isScrollEnabled = false
            collegeRefName()
            
            
        }
        
    }else{
        
        
        
    }
    
    
}


@IBAction func adLoad(gesture : viewClickGesture) {
    
    
    let vc = AddImagePdfViewController(nibName: nil, bundle: nil)
    
    vc.addUrl = gesture.url
    
    vc.modalPresentationStyle = .fullScreen
    present(vc, animated: true,completion: nil)
    
    
}



func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if imageSegmentName.selectedSegmentIndex == 0 {
        return departmentRef.count
    }
    else if imageSegmentName.selectedSegmentIndex == 1 {
        
        return collegeRef.count
        
    }
    
    return 0
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    
    let cell = tableView.dequeueReusableCell(withIdentifier: identifers, for: indexPath) as!
    ImageTableViewCell
    
    cell.selectionStyle = .none
    
    if let selectedCell = selectedCell, selectedCell == indexPath {
        
        
        cell.imageCellDescripitionLabel.isHidden = false
        cell.SendbyStack.isHidden = false
        cell.AttachmentStack.isHidden = false
        cell.upArrowssImages.image = UIImage(named: "up")
    }else{

        cell.imageCellDescripitionLabel.isHidden = true
        cell.SendbyStack.isHidden = true
        cell.AttachmentStack.isHidden = true
       
        cell.upArrowssImages.image = UIImage(named: "down")
    }
    
    
    if imageSegmentName.selectedSegmentIndex == 0 {
        
        let image : departmentImageDataDetails = departmentRef[indexPath.row]
        
        cell.imageCellTimeLabel.text = image.createdontime
        cell.imageCellDateLabel.text = image.createdondate
        cell.imageCellDescripitionLabel.text = image.description.capitalized
        cell.sendByCellLabel.text = image.sentbyname
        cell.imageCellTitelLabel.text = image.title
        
        if image.newfilepath == [""] || image.newfilepath == ["[]"]{
            
            print("vfdscds")
            
            cell.viewTap.isHidden = true
        }
        else{
            
            print("12344")
            cell.viewTap.isHidden = false
        }
        
        let parsed = image.file_path.replacingOccurrences(of: "https://college-app-files.s3.amazonaws.com/", with: "")
        
        
        //
        let cutss = parsed.suffix(43)
        //
        let strss = String(cutss)
        
        let counts = image.newfilepath.count-1
        
        let srtcovert = String(counts)
        cell.plusoneLabl.text = "+" + srtcovert
        
        if image.isappread == "1"{
            
            cell.redDotImageView.isHidden =  true
            
            
        }
        
        else {
            
            cell.redDotImageView.isHidden = false
        }
        
        
        
        if image.newfilepath.count == 1{
            
            
            cell.countImageView.isHidden = true
            
            
            let  play = viewClickGesture(target: self, action: #selector(connected))
            play.img_urls = image.newfilepath
            play.imageFileType = image.filetype
            for i in image.newfilepath {
                play.img_url =  i
            }
            
            cell.viewTap.addGestureRecognizer(play)
            
        }
        
        
        
        
        else{
            
            
            cell.countImageView.isHidden = false
            
            
            
            let  play = viewClickGesture(target: self, action: #selector(connected))
            
            play.img_urls = image.newfilepath
            play.imageFileType = image.filetype
            for i in image.newfilepath {
                play.img_url =  i
            }
            
            cell.viewTap.addGestureRecognizer(play)
            
            
            
            
        }
        
        
        
    }
    
    
    
    else if imageSegmentName.selectedSegmentIndex == 1 {
        
        let images : departmentImageDataDetails = collegeRef[indexPath.row]
        
        cell.imageCellTimeLabel.text = images.createdontime
        cell.imageCellDateLabel.text = images.createdondate
        cell.imageCellDescripitionLabel.text = images.description.capitalized
        cell.sendByCellLabel.text = images.sentbyname
        cell.imageCellTitelLabel.text = images.title
        
        let parsed = images.file_path.replacingOccurrences(of: "https://college-app-files.s3.amazonaws.com/", with: "")
        
        let cutss = parsed.suffix(43)
        let strss = String(cutss)
        let counts = images.newfilepath.count-1
        let srtcovert = String(counts)
        
        cell.plusoneLabl.text = "+" + srtcovert
        
        
        if images.isappread == "1"{
            
            cell.redDotImageView.isHidden =  true
            
        }
        
        else {
            
            cell.redDotImageView.isHidden = false
            //
        }
        
        if images.newfilepath == [""] || images.newfilepath == ["[]"]{
            
            cell.viewTap.isHidden = true
        }
        
        else{
            cell.viewTap.isHidden = false
        }
        
        
        
        if images.newfilepath.count == 1{
            
            
            cell.countImageView.isHidden = true
            
            
            let  play = viewClickGesture(target: self, action: #selector(connected))
            play.img_urls = images.newfilepath
            play.imageFileType = images.filetype
            for i in images.newfilepath {
                play.img_url =  i
            }
            
            cell.viewTap.addGestureRecognizer(play)
            
        }
        
        else{
            
            cell.countImageView.isHidden = false
            let  play = viewClickGesture(target: self, action: #selector(connected))
            
            play.img_urls = images.newfilepath
            play.imageFileType = images.filetype
            
            for i in images.newfilepath {
                play.img_url =  i
            }
            
            cell.viewTap.addGestureRecognizer(play)
        }
    }
    return cell
}





@objc func connected(gesture : viewClickGesture) {
    
    
    if imageSegmentName.selectedSegmentIndex == 0{
        
        
        if gesture.img_urls.count == 1 {
            
            
            
            let vc = ImageDownloadViewController(nibName: nil, bundle: nil)
            print("view")
            
            
            vc.fileType = gesture.imageFileType
            
            vc.imgfilePath = gesture.img_url
            
            print("gesture.img_url",gesture.img_url.count)
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
            
            
            
        }
        
        
        else{
            
            
            
            
            
            let vc  = MoreImageViewController(nibName: nil, bundle: nil)
            
            vc.imageFile = gesture.img_urls
            vc.fileType = gesture.imageFileType
            vc.PreviousAddId = PreviousAddId
            
            vc.smallImageView = smallImageAddImageView
            vc.bigImageView = backGroundAddImageView
            vc.strName = strName
            vc.str = str
            
            vc.modalPresentationStyle = .fullScreen
            
            present(vc, animated: true,completion: nil)
            
            
            
            
        }
        
        
    }
    
    
    
    
    
    
    else if imageSegmentName.selectedSegmentIndex == 1 {
        
        
        if gesture.img_urls.count == 1{
            
            
            let vc = ImageDownloadViewController(nibName: nil, bundle: nil)
            print("view")
            
            
            vc.fileType = gesture.imageFileType
            
            vc.imgfilePath = gesture.img_url
            print("gesture.img_url",gesture.img_url.count)
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
            
            
            
            
        }
        
        
        else{
            
            
            
            
            
            
            let vc  = MoreImageViewController(nibName: nil, bundle: nil)
            
            vc.imageFile = gesture.img_urls
            vc.fileType = gesture.imageFileType
            vc.smallImageView = smallImageAddImageView
            vc.bigImageView = backGroundAddImageView
            vc.PreviousAddId = PreviousAddId
            vc.strName = strName
            vc.str = str
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            
            present(vc, animated: true,completion: nil)
            
            
            
            
        }
        
        
        
        
    }
}



func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return UITableView.automaticDimension
}




func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    imageTableView.deselectRow(at: indexPath, animated: true)
    
    
    let cell = tableView.dequeueReusableCell(withIdentifier: identifers, for: indexPath) as!
    
    ImageTableViewCell
    
    
    
    
    
    if imageSegmentName.selectedSegmentIndex == 0 {
        
        let image : departmentImageDataDetails = departmentRef[indexPath.row]
        
        
        
        if let selectedCells = selectedCell, selectedCells == indexPath {
            
            selectedCell = nil
            
        }
        
        else{
            
            selectedCell = indexPath
            
            if image.isappread == "0"{
                
                apread(gesture : image.detailsid)
                
                image.isappread = "1"
                cell.redDotImageView.isHidden = true
                
            }
            
            
            
            
            
            
        }
        
        
    }
    
    
    else if imageSegmentName.selectedSegmentIndex == 1 {
        
        let images : departmentImageDataDetails = collegeRef[indexPath.row]
        
        if let selectedCells = selectedCell, selectedCells == indexPath {
            
            selectedCell = nil
            
        }
        
        else{
            
            selectedCell = indexPath
            
            
            if images.isappread == "0"{
                
                apread(gesture : images.detailsid)
                
                images.isappread = "1"
                cell.redDotImageView.isHidden = true
                
            }
            
            
            
        }
        
        
        
    }
    
    
    imageTableView.beginUpdates()
    imageTableView.endUpdates()
    imageTableView.reloadData()
}




func departRefName() {
    
    let depart = departmentModal()
    
    depart.userid = userid
    depart.appid  = "2"
    depart.priority = priority
    depart.type    = "departmentcircular"
    
    
    
    
    
    let departStr = depart.toJSONString()
    
    
    imageRequest.call_request(param: departStr!){ [self]
        
        (res) in
        
        
        let departResp :departmentImageResponce = Mapper<departmentImageResponce>().map(JSONString: res)!
        
        
        if departResp.Status == 1 {
            
            print("order data",departResp)
            
            
            departmentRef = departResp.data
            cloneList = departResp.data
            
            for i in departmentRef {
                filePathStr = i.newfilepath
            }
            
            
            imageTableView.isScrollEnabled = true
            noDataLabel.isHidden = true
            noDataTextView.isHidden = true
            imageTableView.delegate = self
            imageTableView.dataSource = self
            
            
            imageTableView.reloadData()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3 ){ [self] in
                
                loadingCustom.stopAnimating()
                
                
                loadingCustom.isHidden  = true
                
            }
        }else{
            
            noDataTextView.isHidden = false
            noDataLabel.isHidden = false
            noDataLabel.text = departResp.Message
            imageTableView.delegate = self
            imageTableView.dataSource = self
            
            
            imageTableView.reloadData()
            print("noRecords")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3 ){ [self] in
                
                loadingCustom.stopAnimating()
                
                
                loadingCustom.isHidden  = true
                
            }
        }
        
        
        
    }
    
    
    
    
}


func collegeRefName() {
    
    let college = departmentModal()
    
    college.userid   =  userid
    college.appid    = "2"
    college.priority = priority
    college.type     =  "collegecircular"
    
    
    
    
    
    
    let collegeStr = college.toJSONString()
    
    
    imageRequest .call_request(param: collegeStr!){ [self]
        
        (res) in
        
        
        let collegeResp : departmentImageResponce =
        Mapper<departmentImageResponce>().map(JSONString: res)!
        
        print("order data",collegeResp)
        
        
        
        
        
        if collegeResp.Status == 1 {
            
            print("order data",collegeResp)
            
            
            collegeRef = collegeResp.data
            cloneList = collegeResp.data
            
            for i in collegeRef {
                
                
                filePathStr = i.newfilepath
                
                print("collegeUrl",i.newfilepath)
            }
            
            imageTableView.isScrollEnabled = true
            noDataLabel.isHidden = true
            noDataTextView.isHidden  = true
            imageTableView.delegate = self
            imageTableView.dataSource = self
            
            imageTableView.reloadData()
            
            
        }else{
            
            noDataTextView.isHidden = false
            noDataLabel.isHidden = false
            noDataLabel.text = collegeResp.Message
            imageTableView.delegate = self
            imageTableView.dataSource = self
            
            imageTableView.reloadData()
            
            print("noRecords")
        }
        
        
        
    }
    
    
    
    
}


func apread(gesture : String){
    
    
    let readApiStatus  = AppReadStatusModal()
    
    readApiStatus.msgtype = "circular"
    readApiStatus.priority = priority
    readApiStatus.userid = userid
    readApiStatus.detailsid = gesture
    print("sertt",gesture)
    
    
    let commuS = readApiStatus.toJSONString()
    
    ApiReadStatusRequest .call_request(param: commuS!){ [self]
        
        (res) in
        
        
        let com : ReadStausApiResponce =
        Mapper<ReadStausApiResponce>().map(JSONString: res)!
        
        
        
        imageTableView.delegate = self
        imageTableView.dataSource = self
        imageTableView.reloadData()
        
        
        
    }
    
    
    
}


func overAllRefName() {
    
    var overall = overAllModal()
    
    overall.userid   =  userid
    overall.menuid       = "6"
    overall.collegeid    =  collegeid
    overall.departmentid =  departmentId
    overall.sectionid    =   sectionId
    overall.appid        = "2"
    overall.priority     = priority
    
    
    APiCallManager.shared.callApi(url: APIEndpoints.GetOverallcountByMenuType, httpMethod: .post, queryParam: nil, requestBody: overall) { [weak self] (result:Result<overAllResponce,Error>) in
        guard let self = self else{return}
        switch result{
        case.success(let result):

            if result.Status == 1{
                overAllRef = result.data ?? []
                for i in overAllRef {
                    departmentCountLabel.text = i.departmentcircular
                    collegeCountLabel.text = i.collegecircular
                    
                    if (i.departmentcircular == "0") && (i.collegecircular == "0"){
                        
                        imageCountView.isHidden = true
                        departmentCountView.isHidden = true
                        collegeCountView.isHidden = true
                    }else if i.departmentcircular == "0"{
                        imageCountView.isHidden = false
                        departmentCountView.isHidden = true
                        collegeCountView.isHidden = false
                        
                    }else if i.collegecircular == "0"{
                        
                        
                        imageCountView.isHidden = false
                        departmentCountView.isHidden = false
                        collegeCountView.isHidden = true
                        
                        
                    }else{
                        imageCountView.isHidden = false
                        departmentCountView.isHidden = false
                        collegeCountView.isHidden = false
                        
                    }
                }
                
                let a =  Int(collegeCountLabel.text!)
                let b = Int(departmentCountLabel.text!)
                let c = a! + b!
                
                imageTopCountLabel.text = String(c)
                
            }else{
                
                imageCountView.isHidden = true
                departmentCountView.isHidden = true
                collegeCountView.isHidden = true
                
            }
        case.failure(let error):
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
    
    if segemntID ==  "1"{
        
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
class viewClickGesture : UITapGestureRecognizer {

var url : String!
var img_url : String!
var imageFileType : String!
var img_urls : [String] = []
}


