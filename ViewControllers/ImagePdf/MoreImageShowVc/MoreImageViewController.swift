//
//  MoreImageViewController.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 31/03/23.
//

import UIKit
import KRProgressHUD
import ObjectMapper

@available(iOS 16.0, *)
class MoreImageViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {



@IBOutlet weak var addclickeView: UIView!
@IBOutlet weak var topNameview: UIView!

@IBOutlet weak var tapBarView: UIViewX!
@IBOutlet weak var redirectLoginView: UIViewX!

@IBOutlet weak var loginView: UIView!
@IBOutlet weak var topLabels: UILabel!


@IBOutlet weak var profileView: UIView!

@IBOutlet weak var viewTap: UIView!

@IBOutlet weak var clgLogoImg: UIImageView!
@IBOutlet weak var topMessageLabel: UILabel!



@IBOutlet weak var smallImg: UIImageView!
@IBOutlet weak var bigImg: UIImageView!
@IBOutlet weak var adView: UIView!

@IBOutlet weak var changeRolesView: UIView!

@IBOutlet weak var notificationView: UIView!
@IBOutlet weak var refreshView: UIView!

@IBOutlet weak var sideMenuView: UIView!


@IBOutlet weak var termsAndConditionView: UIView!
@IBOutlet weak var faqView: UIView!

@IBOutlet weak var privacyPolicyView: UIView!


@IBOutlet weak var changePasswordView: UIView!
@IBOutlet weak var helpView: UIView!


@IBOutlet weak var noDataLabel: UIView!



@IBOutlet weak var tv: UITableView!



@IBOutlet weak var arrowImg: UIImageView!

@IBOutlet weak var cv: UICollectionView!

@IBOutlet weak var menuImg: UIImageView!

@IBOutlet weak var downView: UIView!

@IBOutlet weak var swipeMenuHeight: NSLayoutConstraint!


@IBOutlet weak var swipeMenu: UIView!



var identifier = "MoreImagesTableViewCell"
let menuIdentifier = "MenuCollectionViewCell"
var imageFile : [String]  = []
var fileType : String!


var memberId : String!
var priority : String!
var collegId  : String!
var departmentId : String!
var sectionId : String!
var loginType : String!

var memberName : String!
var colgImg :String!

var PreviousAddId : Int!
var MobileNumber : String!

var bigImageView : String!
var smallImageView : String!
var addapiRef : [AddDataDeatils] = []
var loginDatas : [datalogin]!
var logindataprinci :[datalogin]!

var password : String!
var str : [String] = []

var strName : [String] = []
var is_read_enabled = ""
var is_write_enabled = ""


override func viewDidLoad() {
    super.viewDidLoad()
    
    overrideUserInterfaceStyle = .light
    
    let defaults = UserDefaults.standard
    
    memberId = defaults.string(forKey: DefaultsKeys.memberid)
    priority = defaults.string(forKey: DefaultsKeys.priority)
    collegId = defaults.string(forKey: DefaultsKeys.collegeid)
    departmentId = defaults.string(forKey: DefaultsKeys.deptid)
    sectionId = defaults.string(forKey: DefaultsKeys.sectionid)
    loginType = defaults.string(forKey: DefaultsKeys.loginAsType)
    MobileNumber = defaults.string(forKey: DefaultsKeys.mobileNumber)
    memberName = defaults.string(forKey: DefaultsKeys.memberName)
    
    password = defaults.string(forKey: DefaultsKeys.Password)
    colgImg = defaults.string(forKey: DefaultsKeys.colglogo)
    clgLogoImg.sd_setImage(with: URL(string:  colgImg), placeholderImage: UIImage(named: "person.fill"))
    
    topMessageLabel.text = memberName
    sideMenuView.isHidden = true
    swipeMenu.isHidden = true
    print("jknjkkkkjkl",imageFile)
    
    noDataLabel.isHidden = true
    
    let rownib = UINib(nibName: identifier, bundle: nil)
    tv.register(rownib, forCellReuseIdentifier: identifier)
    tv.dataSource = self
    tv.delegate = self
    
    
    
    
    
    if priority == "p1"{
        
        view.backgroundColor = UIColor(named: "Principal" )
        
        tapBarView.backgroundColor = UIColor(named: "Principal" )
        topLabels.text = "Principal"
        
    }
    
    
    else if priority == "p7" {
        
        
        tapBarView.backgroundColor = UIColor(named: "univercityColorCod" )
        topLabels.text = "university Head"
        
        
    }
    
    else if priority == "p4"{
        tapBarView.backgroundColor = UIColor(named: "StudentParent" )
        topLabels.text = "Student"
        
    }
    
    else if priority == "p2" {
        
        view.backgroundColor = UIColor(named: "Teaching Staff" )
        tapBarView.backgroundColor = UIColor(named: "Teaching Staff" )
        topLabels.text = "Hod"
        
    }
    
    else if priority == "p5"{
        view.backgroundColor = UIColor(named: "FatherColor" )
        tapBarView.backgroundColor = UIColor(named: "FatherColor" )
        topLabels.text = "Father"
        
        
        
    }
    
    else if priority == "p3"{
        view.backgroundColor = UIColor(named: "Teaching Staff" )
        tapBarView.backgroundColor = UIColor(named: "Teaching Staff" )
        topLabels.text = "Teacher"
        
    }
    
    
    
    
    
    addApi()
    
    
    
    if priority == "p1" {
        
        
        print("PrincipalVieewwColor")
        view.backgroundColor = UIColor(named: "Principal" )
        
        menuImg.image = UIImage(named: "principalBigMenu")
        
    }else if priority == "p4" {
        
        print("StudentVieewwColor")
        view.backgroundColor = UIColor(named: "studentViewColors")
        
        
        menuImg.image = UIImage(named: "studentSwipeImage")
        
    } else if priority == "p3" ||  priority == "p2" {
        
        print("HooodddVieewwColor")
        view.backgroundColor = UIColor(named: "Teaching Staff")
        
        menuImg.image = UIImage(named: "HodImage")
        
    }
    else if priority == "p5"{
        
        
        
        view.backgroundColor = UIColor(named: "FatherColor")
        
        menuImg.image = UIImage(named: "StaffBigMenu")
        
        
    }
    
    
    else if priority == "p6"{
        
        
        view.backgroundColor = UIColor(named: "Teaching Staff")
        
        menuImg.image = UIImage(named: "HodImage")
        
    }
    
    else if priority == "p7" {
        
        print("HooodddVieewwColor")
        view.backgroundColor = UIColor(named: "univercityColorCod")
        
        menuImg.image = UIImage(named: "UnivercityHead")
        
    }
    
    swipeMenuHeight.constant = 0
    
    cv.dataSource = self
    cv.delegate = self
    
    
    cv!.isPagingEnabled = true
    cv!.isScrollEnabled = true
    cv!.setContentOffset(CGPoint(x: 0,y: 0), animated: true)
    
    cv.alwaysBounceVertical = true
    
    let menuRowNib = UINib(nibName: menuIdentifier, bundle: nil)
    cv.register(menuRowNib, forCellWithReuseIdentifier: menuIdentifier)
    
    let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
    swipeRight.direction = .up
    downView.addGestureRecognizer(swipeRight)
    
    let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
    swipeDown.direction = .down
    downView.addGestureRecognizer(swipeDown)
    
    
    
    
    
    // tap Bar UiTapGuster.
    
    
    let loginRediectGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
    redirectLoginView.addGestureRecognizer(loginRediectGesture)
    
    
    let profileGesture = UITapGestureRecognizer(target: self, action: #selector(profileRedirect))
    profileView.addGestureRecognizer(profileGesture)
    
    
    let changeRolesGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
    changeRolesView.addGestureRecognizer(changeRolesGesture)
    
    
    
    
    let topname = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
    topNameview.addGestureRecognizer(topname)
    
    let logoutGesture = UITapGestureRecognizer(target: self, action: #selector(logoutPressed))
    loginView.addGestureRecognizer(logoutGesture)
    
    
    
    
    
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
    
    
    
}


@objc func dismissKeyboards() {
    
    sideMenuView.isHidden = true
    view.endEditing(true)
    
}





@IBAction func adLoad(gesture : MoreImageAdd) {
    
    
    let vc = AddImagePdfViewController(nibName: nil, bundle: nil)
    
    vc.addUrl = gesture.url
    
    vc.modalPresentationStyle = .fullScreen
    present(vc, animated: true,completion: nil)
    
    
}


func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    
    return imageFile.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    
    let  cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as!
    
    MoreImagesTableViewCell
    
    
    
    let more = imageFile[indexPath.row]
    
    
    
    
    let parsed = imageFile[indexPath.row].replacingOccurrences(of: "https://college-app-files.s3.amazonaws.com/", with: "")
    
    let trims = String(parsed.dropFirst(13))
    
    
    cell.fileNameLabel.text = trims
    
    
    let imagee = ImageShow(target: self, action: #selector(ImageShowVc))
    
    
    imagee.imageUrls = imageFile[indexPath.row]
    
    cell.imagePageClickView.addGestureRecognizer(imagee)
    
    
    return cell
    
}




func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 120
}




@IBAction func ImageShowVc( gesture :ImageShow ){
    
    let vc = MoreImageDownLoadViewController(nibName: nil, bundle: nil)
    
    vc.MoreimgfilePath = gesture.imageUrls
    vc.fileType = fileType
    
    vc.modalPresentationStyle = .fullScreen
    
    present(vc, animated: true,completion: nil)
    
    
}


@IBAction func backbtn(_ sender: Any) {
    
    dismiss(animated: true)
}



func addApi(){
    
    
    let add = AddApiModal()
    
    let defaults = UserDefaults.standard
    var deviceToken = defaults.string(forKey:DefaultsKeys.DeviceToken )
    add.device_token = deviceToken
    print("EventDefaultsKeys.DeviceToken",deviceToken)
    add.member_id = memberId
    add.mobile_no = MobileNumber
    add.priority = priority
    add.college_id = collegId
    add.previous_add_id = PreviousAddId
    
    
    let addstr = add.toJSONString()
    
    
    print("jkjkl;;",addstr)
    
    addRequest.call_request(param: addstr!){ [self]
        
        (res) in
        
        
        
        let addApis : AddApiResponce = Mapper<AddApiResponce>().map(JSONString: res)!
        
        
        
        if addApis.Status == 1 {
            
            
            
            
            for i in addApis.data{
                
                
                bigImg.sd_setImage(with: URL(string: i.background_image), placeholderImage: UIImage(named: "ic_white"))
                
                
                smallImg.sd_setImage(with: URL(string: i.add_image), placeholderImage: UIImage(named: "ic_white"))
                
                
                let loadGesture = MoreImageAdd(target: self, action: #selector(adLoad))
                loadGesture.url = i.add_url
                
                addclickeView.addGestureRecognizer(loadGesture)
                
            }
            
            
            
            
            
        }
        
        
        
        
        else{
            
            
            
            
        }
        
        
    }
    
    
}




// this part is  bottom swipe view .




@objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
    
    if let swipeGesture = gesture as? UISwipeGestureRecognizer {
        if priority == "p4" {
            switch swipeGesture.direction {
            case .right:
                print("Swiped right")
            case .down:
                swipeMenuHeight.constant = 150
                
                print("swipeMenuHeight.constant\(swipeMenuHeight.constant)")
                
                arrowImg.image = UIImage(named: "up")
                print("Swiped down")
                dismissKeyboards()
            case .left:
                print("Swiped left")
            case .up:
                
                
                if str.count <= 4{
                    
                    print("uiouiop")
                    swipeMenuHeight.constant = 150
                    
                }
                
                else if str.count  == 5{
                    
                    print("uioiuiopkjhgbjnkmjhvgyjbkn,m")
                    swipeMenuHeight.constant = 240
                    
                }
                else if str.count == 6{
                    
                    
                    swipeMenuHeight.constant = 240
                }
                
                else if str.count == 7 {
                    
                    
                    
                    
                    swipeMenuHeight.constant = 240
                }
                
                else if str.count == 8{
                    
                    
                    swipeMenuHeight.constant = 240
                }
                
                else if str.count == 9{
                    
                    
                    swipeMenuHeight.constant = 300
                }
                else if str.count == 10{
                    
                    
                    swipeMenuHeight.constant = 300
                }
                
                
                else if str.count == 11{
                    
                    
                    swipeMenuHeight.constant = 300
                }
                
                
                else if str.count == 12{
                    
                    
                    swipeMenuHeight.constant = 300
                }
                
                
                else if str.count == 13{
                    
                    
                    swipeMenuHeight.constant = 470
                }
                
                
                else if str.count == 14{
                    
                    
                    swipeMenuHeight.constant = 470
                }
                
                else if str.count == 15{
                    
                    
                    swipeMenuHeight.constant = 400
                    
                    
                }
                
                else {
                    
                    
                    swipeMenuHeight.constant = 400
                }
                
                print("swipeMenuHeight.constant\(swipeMenuHeight.constant)")
                
                arrowImg.image = UIImage(named: "down")
                print("Swiped up")
                dismissKeyboards()
            default:
                break
            }
        }
        
        
        else if priority == "p1" {
            
            
            switch swipeGesture.direction {
            case .right:
                print("Swiped right")
            case .down:
                swipeMenuHeight.constant = 150
                
                print("swipeMenuHeight.constant\(swipeMenuHeight.constant)")
                
                arrowImg.image = UIImage(named: "up")
                print("Swiped down")
            case .left:
                print("Swiped left")
            case .up:
                swipeMenuHeight.constant = 300
                
                menuImg.image = UIImage(named: "principalBigMenu")
                
                
                print("swipeMenuHeight.constant\(swipeMenuHeight.constant)")
                
                arrowImg.image = UIImage(named: "down")
                print("Swiped up")
            default:
                break
            }
            
            
        }
        
        else if priority == "p2" || priority == "p3" || priority == "p6"  {
            
            
            
            switch swipeGesture.direction {
            case .right:
                print("Swiped right")
            case .down:
                swipeMenuHeight.constant = 150
                
                print("swipeMenuHeight.constant\(swipeMenuHeight.constant)")
                
                menuImg.image = UIImage(named: "HodImage")
                
                arrowImg.image = UIImage(named: "up")
                print("Swiped down")
            case .left:
                print("Swiped left")
            case .up:
                if str.count <= 4{
                    
                    print("uiouiop")
                    swipeMenuHeight.constant = 150
                    
                }
                //
                else if str.count  == 5{
                    
                    print("uioiuiopkjhgbjnkmjhvgyjbkn,m")
                    swipeMenuHeight.constant = 240
                    
                }
                else if str.count == 6{
                    
                    
                    swipeMenuHeight.constant = 240
                }
                //
                else if str.count == 7 {
                    
                    
                    swipeMenuHeight.constant = 240
                }
                
                else if str.count == 8{
                    
                    
                    swipeMenuHeight.constant = 240
                }
                
                else if str.count == 9{
                    
                    
                    swipeMenuHeight.constant = 300
                }
                else if str.count == 10{
                    
                    
                    swipeMenuHeight.constant = 300
                }
                
                
                else if str.count == 11{
                    
                    
                    swipeMenuHeight.constant = 300
                }
                
                
                else if str.count == 12{
                    
                    
                    swipeMenuHeight.constant = 300
                }
                
                
                else if str.count == 13{
                    
                    
                    swipeMenuHeight.constant = 470
                }
                
                
                else if str.count == 14{
                    
                    
                    swipeMenuHeight.constant = 470
                }
                
                else if str.count == 15{
                    
                    
                    swipeMenuHeight.constant = 400
                    
                    
                }
                
                else {
                    
                    
                    swipeMenuHeight.constant = 400
                    
                }
                
                arrowImg.image = UIImage(named: "down")
                print("Swiped up")
            default:
                break
            }
            //
        }
        
        
        
        else if priority == "p7" {
            
            
            switch swipeGesture.direction {
            case .right:
                print("Swiped right")
            case .down:
                swipeMenuHeight.constant = 150
                
                print("swipeMenuHeight.constant\(swipeMenuHeight.constant)")
                
                
                arrowImg.image = UIImage(named: "up")
                print("Swiped down")
                
            case .left:
                print("Swiped left")
            case .up:
                
                if str.count <= 4{
                    
                    print("uiouiop")
                    swipeMenuHeight.constant = 150
                    
                }
                //
                else if str.count  == 5{
                    
                    print("uioiuiopkjhgbjnkmjhvgyjbkn,m")
                    swipeMenuHeight.constant = 240
                    
                }
                else if str.count == 6{
                    
                    
                    swipeMenuHeight.constant = 240
                }
                //
                else if str.count == 7 {
                    
                    
                    swipeMenuHeight.constant = 240
                }
                
                else if str.count == 8{
                    
                    
                    swipeMenuHeight.constant = 240
                }
                
                else if str.count == 9{
                    
                    
                    swipeMenuHeight.constant = 300
                }
                else if str.count == 10{
                    
                    
                    swipeMenuHeight.constant = 300
                }
                
                
                else if str.count == 11{
                    
                    
                    swipeMenuHeight.constant = 300
                }
                
                
                else if str.count == 12{
                    
                    
                    swipeMenuHeight.constant = 300
                }
                
                
                else if str.count == 13{
                    
                    
                    swipeMenuHeight.constant = 470
                }
                
                
                else if str.count == 14{
                    
                    
                    swipeMenuHeight.constant = 470
                }
                
                else if str.count == 15{
                    
                    
                    swipeMenuHeight.constant = 470
                }
                
                else {
                    
                    
                    swipeMenuHeight.constant = 470
                    
                }
                
                
                arrowImg.image = UIImage(named: "down")
                print("Swiped up")
                
            default:
                break
            }
            //
        }
        
        else if priority == "p5"{
            switch swipeGesture.direction {
            case .right:
                print("Swiped right")
            case .down:
                swipeMenuHeight.constant = 150
                
                print("swipeMenuHeight.constant\(swipeMenuHeight.constant)")
                
                
                arrowImg.image = UIImage(named: "up")
                print("Swiped down")
                dismissKeyboards()
            case .left:
                print("Swiped left")
            case .up:
                
                if str.count <= 4{
                    
                    print("uiouiop")
                    swipeMenuHeight.constant = 150
                    
                }
                
                else if str.count  == 5{
                    
                    print("uioiuiopkjhgbjnkmjhvgyjbkn,m")
                    swipeMenuHeight.constant = 240
                    
                }
                else if str.count == 6{
                    
                    
                    swipeMenuHeight.constant = 240
                }
                
                else if str.count == 7 {
                    
                    
                    
                    
                    swipeMenuHeight.constant = 240
                }
                
                else if str.count == 8{
                    
                    
                    swipeMenuHeight.constant = 240
                }
                
                else if str.count == 9{
                    
                    
                    swipeMenuHeight.constant = 300
                }
                else if str.count == 10{
                    
                    
                    swipeMenuHeight.constant = 300
                }
                
                
                else if str.count == 11{
                    
                    
                    swipeMenuHeight.constant = 300
                }
                
                
                else if str.count == 12{
                    
                    
                    swipeMenuHeight.constant = 300
                }
                
                
                else if str.count == 13{
                    
                    
                    swipeMenuHeight.constant = 470
                }
                
                
                else if str.count == 14{
                    
                    
                    swipeMenuHeight.constant = 470
                }
                
                else if str.count == 15{
                    
                    
                    swipeMenuHeight.constant = 400
                    
                    
                }
                
                else {
                    
                    
                    swipeMenuHeight.constant = 400
                    
                }
                
                print("swipeMenuHeight.constant\(swipeMenuHeight.constant)")
                
                arrowImg.image = UIImage(named: "down")
                dismissKeyboards()
                print("Swiped up")
            default:
                break
            }
            
        }
        
    }
    
}





func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    if priority == "p4"{
        
        print("stu",strName.count)
        return strName.count
    }
    else if priority == "p7"{
        
        print("Teach",strName.count)
        return strName.count
    }
    else if priority == "p1"{
        
        print("Prin",strName.count)
        return strName.count
        
    }
    
    
    else if priority == "p2" || priority == "p3" || priority == "p6"{
        
        print("Teach",strName.count)
        return strName.count
    }
    
    else if priority == "p5"{
        
        print("father",strName.count)
        return strName.count
        
    }
    
    
    
    return 0
    
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: menuIdentifier , for: indexPath) as! MenuCollectionViewCell
    
    if priority == "p4"{
        
        
        cell.menuNameLbl.text = strName[indexPath.row]
        
        cell.menuImg.image = UIImage(named: String(str[indexPath.row]))
        
        
        
    }
    
    else if priority == "p1"{
        
        
        
        
        cell.menuNameLbl.text = strName[indexPath.row]
        
        cell.menuImg.image = UIImage(named: String(str[indexPath.row]))
        
    }
    
    else if priority == "p7"{
        //
        
        cell.menuNameLbl.text = strName[indexPath.row]
        
        cell.menuImg.image = UIImage(named: String(str[indexPath.row]))
        
        
        
        
    }
    
    
    else if priority == "p2" || priority == "p3"{
        
        cell.menuNameLbl.text = strName[indexPath.row]
        
        cell.menuImg.image = UIImage(named: String(str[indexPath.row]))
        
        
    }
    
    else if priority == "p5"{
        
        cell.menuNameLbl.text = strName[indexPath.row]
        
        cell.menuImg.image = UIImage(named: String(str[indexPath.row]))
        
    }
    
    
    else if priority == "p6"{
        
        
        cell.menuNameLbl.text = strName[indexPath.row]
        
        cell.menuImg.image = UIImage(named: String(str[indexPath.row]))
        
    }
    
    
    
    
    return cell
}



func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.size.width / 4, height: 78)
}



func getCurrentViewController() -> UIViewController? {
    
    if let rootController = UIApplication.shared.keyWindow?.rootViewController {
        var currentController: UIViewController! = rootController
        while( currentController.presentedViewController != nil ) {
            currentController = currentController.presentedViewController
        }
        return currentController
    }
    return nil
    
}

func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let stud : menuApiDataDetails =  DefaultsKeys.MenuRefName[indexPath.row]
    let read = String(stud.is_read_enabled)
    let write =  String(stud.is_write_enabled)
    
    
    
    if priority == "p4"{
        
        
        
        if str[indexPath.row] == "home"{
            
            let vc = HomeScreenViewController(nibName: nil, bundle: nil)
            let currentController = self.getCurrentViewController()
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
            
            
        }
        else if str[indexPath.row] == "hall_ticket"{
            
            
            
            
            let vc = HallTicketViewController(nibName: nil, bundle: nil)
            
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_read_enabled
            
            vc.view.backgroundColor = UIColor(named: "StudentParent")
            vc.str = str
            vc.strName = strName
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
        }
        
        else if str[indexPath.row] == "voice"{
            
            
            let vc = CommunicationHomePageViewController(nibName: nil, bundle: nil)
            
            print("communicationssssssss")
            
            
            
            
            vc.view.backgroundColor = UIColor(named: "StudentParent")
            vc.str = str
            print("hgjhgnbv",is_read_enabled)
            vc.strName = strName
            
            vc.modalPresentationStyle = .fullScreen
            
            
            present(vc, animated: true, completion: nil)
            
            
            //
            
        }
        
        
        else if str[indexPath.row] == "text"{
            
            
            let vc = CommuniSMSViewController(nibName: nil, bundle: nil)
            
            print("communicationssssssss")
            
            
            
            vc.view.backgroundColor = UIColor(named: "StudentParent")
            vc.str = str
            print("hgjhgnbv",is_read_enabled)
            vc.strName = strName
            
            vc.modalPresentationStyle = .fullScreen
            
            
            present(vc, animated: true, completion: nil)
            
            
            //
            
        }
        
        else if str[indexPath.row] == "examination"{
            
            
            let vc = ExaminationHomePageViewController(nibName: nil, bundle: nil)
            let currentController = self.getCurrentViewController()
            vc.view.backgroundColor = UIColor(named: "StudentParent")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: false, completion: nil)
            
            
        }
        
        
        else if str[indexPath.row] == "attendance"{
            
            
            let vc = AttendanceViewController(nibName: nil, bundle: nil)
            let currentController = self.getCurrentViewController()
            vc.view.backgroundColor = UIColor(named: "StudentParent")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: false, completion: nil)
            
            
            
        }
        
        
        else if str[indexPath.row] == "assignment"{
            
            let vc = AssigmentHomePageViewController(nibName: nil, bundle: nil)
            let currentController = self.getCurrentViewController()
            vc.view.backgroundColor = UIColor(named: "StudentParent")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: false, completion: nil)
            
            
        }
        
        
        
        else if str[indexPath.row] == "circular"{
            
            
            let vc = ImageViewController(nibName: nil, bundle: nil)
            let currentController = self.getCurrentViewController()
            vc.view.backgroundColor = UIColor(named: "StudentParent")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: false, completion: nil)
            
            
            
            
        }
        
        
        
        else if str[indexPath.row] == "notice_board"{
            
            
            let vc = NoticeBoardHomePageViewController(nibName: nil, bundle: nil)
            let currentController = self.getCurrentViewController()
            vc.view.backgroundColor = UIColor(named: "StudentParent")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: false, completion: nil)
            
            
        }
        
        
        
        else if str[indexPath.row] == "events"{
            
            let vc = EventsViewController(nibName: nil, bundle: nil)
            vc.modalPresentationStyle = .fullScreen
            let currentController = self.getCurrentViewController()
            vc.view.backgroundColor = UIColor(named: "StudentParent")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: false, completion: nil)
            
            
            
        }
        
        
        else if str[indexPath.row] == "faculty"{
            
            let vc = FacultyHomePageViewController(nibName: nil, bundle: nil)
            let currentController = self.getCurrentViewController()
            vc.view.backgroundColor = UIColor(named: "StudentParent")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: false, completion: nil)
            
            
        }
        
        
        else if str[indexPath.row] == "video"{
            
            let vc = VideoViewController(nibName: nil, bundle: nil)
            let currentController = self.getCurrentViewController()
            vc.view.backgroundColor = UIColor(named: "StudentParent")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: false, completion: nil)
            
        }
        
        else if str[indexPath.row] == "chat"{
            
            
            let vc = ChatHomePageViewController(nibName: nil, bundle: nil)
            
            let currentController = self.getCurrentViewController()
            vc.view.backgroundColor = UIColor(named: "StudentParent")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: false, completion: nil)
            
        }
        
        else if str[indexPath.row] == "course_details"{
            
            let vc = CourseHomePageViewController(nibName: nil, bundle: nil)
            
            let currentController = self.getCurrentViewController()
            vc.view.backgroundColor = UIColor(named: "StudentParent")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: false, completion: nil)
            
            
            
        }
        
        
        else if str[indexPath.row] == "category_credit_points"{
            
            
            let vc = CategoryHomePageViewController(nibName: nil, bundle: nil)
            let currentController = self.getCurrentViewController()
            vc.view.backgroundColor = UIColor(named: "StudentParent")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: false, completion: nil)
            
            
        }
        
        
        else if str[indexPath.row] == "sem_credit_points"{
            
            let vc = SemesterHomePageViewController(nibName: nil, bundle: nil)
            let currentController = self.getCurrentViewController()
            vc.view.backgroundColor = UIColor(named: "StudentParent")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: false, completion: nil)
            
            
            
        }
        
        
        
        
        else if str[indexPath.row] == "exam_application_details"{
            
            
            let vc = ExamDetailsHomePageViewController(nibName: nil, bundle: nil)
            let currentController = self.getCurrentViewController()
            vc.view.backgroundColor = UIColor(named: "StudentParent")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: false, completion: nil)
            
            
        }
        
        
        
        
        
        
    }
    
    
    else if priority == "p7"{
        
        if str[indexPath.row] == "home"{
            
            
            
            let vc = HomeScreenViewController(nibName: nil, bundle: nil)
            let currentController = self.getCurrentViewController()
            vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
            
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: false, completion: nil)
            
            
            
        }
        
        
        
        else if str[indexPath.row] == "communication"{
            
            
            let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
            vc.is_read_enabled = read
            vc.is_write_enabled = write
            
            vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
            vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.str = str
            vc.strName = strName
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
            
        }
        
        
        
        else if str[indexPath.row] == "examination"{
            
            
            let vc = SenderExmainationHomePageViewController(nibName: nil, bundle: nil)
            vc.is_read_enabled = read
            vc.is_write_enabled = write
            
            vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
            
            vc.examSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.examSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.str = str
            vc.strName = strName
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
            
            
        }
        
        
        
        else if str[indexPath.row] == "attendance"{
            
            
            let vc =  SenderAttendanceVcViewController(nibName: nil, bundle: nil)
            let currentController = self.getCurrentViewController()
            vc.is_read_enabled = read
            vc.is_write_enabled = write
            
            vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
            vc.segmentName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.segmentName.selectedSegmentTintColor = UIColor(named: "HodUnSelector")
            vc.str = str
            vc.strName = strName
            
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: false, completion: nil)
            
            
            
        }
        
        
        else if str[indexPath.row] == "assignment"{
            
            
            let vc = SenderAssigmentHomePageViewController(nibName: nil, bundle: nil)
            vc.is_read_enabled = read
            vc.is_write_enabled = write
            
            vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
            vc.assigmentSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.assigmentSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            
            vc.str = str
            vc.strName = strName
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
            
        }
        
        
        else if str[indexPath.row] == "circular"{
            
            let vc = SenderImagePdfHomePageViewController(nibName: nil, bundle: nil)
            
            vc.is_read_enabled = read
            vc.is_write_enabled = write
            vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
            vc.imageSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.imageSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            
            vc.str = str
            vc.strName = strName
            
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
            
        }
        
        else if str[indexPath.row] == "notice_board"{
            
            let vc = SenderGraditNoticeBoardMenuViewController(nibName: nil, bundle: nil)
            vc.is_read_enabled = read
            vc.is_write_enabled = write
            vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
            vc.noticeSegments.backgroundColor = UIColor(named: "HodUnSelector")
            vc.noticeSegments.selectedSegmentTintColor = UIColor(named: "HodSelector")
            
            vc.str = str
            vc.strName = strName
            
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
            
        }
        
        
        
        else if str[indexPath.row] == "events"{
            
            
            let vc = SenderEventHomePageViewController(nibName: nil, bundle: nil)
            vc.is_read_enabled = read
            vc.is_write_enabled = write
            vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
            vc.eventSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            
            vc.str = str
            vc.strName = strName
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
            
        }
        
        
        
        else if str[indexPath.row] == "faculty"{
            
            let vc = SenderFacultyViewController(nibName: nil, bundle: nil)
            vc.is_read_enabled = read
            vc.is_write_enabled = write
            vc.view.backgroundColor = UIColor(named: "univercityColorCodf" )
            vc.str = str
            vc.strName = strName
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
            
            
            
        }
        
        else if str[indexPath.row] == "video"{
            
            
            let vc = SenderVideoHomePageViewController(nibName: nil, bundle: nil)
            vc.is_read_enabled = read
            vc.is_write_enabled = write
            vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
            
            vc.str = str
            vc.strName = strName
            
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
            
        }
        
        
        else if str[indexPath.row] == "chat"{
            
            
            let vc =  ChatSenderViewController(nibName: nil, bundle: nil)
            vc.is_read_enabled = read
            vc.is_write_enabled = write
            vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
            vc.str = str
            vc.strName = strName
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
            
            
            
        }
        
        
        
    }
    
    
    
    else if priority == "p1"{
        
        
        
        if str[indexPath.row] == "home"{
            
            
            
            let vc = HomeScreenViewController(nibName: nil, bundle: nil)
            let currentController = self.getCurrentViewController()
            vc.view.backgroundColor = UIColor(named: "Principal" )
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: false, completion: nil)
            
            
            
        }
        
        
        
        else if str[indexPath.row] == "communication"{
            
            
            let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
            let currentController = self.getCurrentViewController()
            vc.view.backgroundColor = UIColor(named: "Principal" )
            vc.CommuniSegementName.backgroundColor = UIColor(named: "UnSelector")
            vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "Selector")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: false, completion: nil)
            
        }
        
        
        
        else if str[indexPath.row] == "examination"{
            
            
            let vc = SenderExmainationHomePageViewController(nibName: nil, bundle: nil)
            let currentController = self.getCurrentViewController()
            vc.view.backgroundColor = UIColor(named: "Principal" )
            vc.examSegmentName.backgroundColor = UIColor(named: "UnSelector")
            vc.examSegmentName.selectedSegmentTintColor = UIColor(named: "Selector")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: false, completion: nil)
            
            
        }
        
        
        
        else if str[indexPath.row] == "attendance"{
            
            print("attence is clicked")
            
            
            let vc = SenderAttendanceVcViewController(nibName: nil, bundle: nil)
            
            let currentController = self.getCurrentViewController()
            vc.view.backgroundColor = UIColor(named: "Principal" )
            vc.segmentName.backgroundColor = UIColor(named: "UnSelector")
            vc.segmentName.selectedSegmentTintColor = UIColor(named: "Selector")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: false, completion: nil)
            
        }
        
        
        else if str[indexPath.row] == "assignment"{
            
            
            let vc = SenderAssigmentHomePageViewController(nibName: nil, bundle: nil)
            let currentController = self.getCurrentViewController()
            vc.view.backgroundColor = UIColor(named: "Principal" )
            vc.assigmentSegmentName.backgroundColor = UIColor(named: "UnSelector")
            vc.assigmentSegmentName.selectedSegmentTintColor = UIColor(named: "Selector")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: false, completion: nil)
            
            //
        }
        
        
        else if str[indexPath.row] == "circular"{
            
            let vc = SenderImagePdfHomePageViewController(nibName: nil, bundle: nil)
            let currentController = self.getCurrentViewController()
            vc.view.backgroundColor = UIColor(named: "Principal" )
            vc.imageSegmentName.backgroundColor = UIColor(named: "UnSelector")
            vc.imageSegmentName.selectedSegmentTintColor = UIColor(named: "Selector")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: false, completion: nil)
            
            
        }
        
        else if str[indexPath.row] == "notice_board"{
            
            let vc = SenderGraditNoticeBoardMenuViewController(nibName: nil, bundle: nil)
            let currentController = self.getCurrentViewController()
            vc.view.backgroundColor = UIColor(named: "Principal" )
            vc.noticeSegments.backgroundColor = UIColor(named: "UnSelector")
            vc.noticeSegments.selectedSegmentTintColor = UIColor(named: "Selector")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: false, completion: nil)
            
            
        }
        
        
        
        else if str[indexPath.row] == "events"{
            
            
            let vc = SenderEventHomePageViewController(nibName: nil, bundle: nil)
            let currentController = self.getCurrentViewController()
            vc.view.backgroundColor = UIColor(named: "Principal" )
            vc.eventSegmentName.backgroundColor = UIColor(named: "UnSelector")
            vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "Selector")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: false, completion: nil)
            
            
        }
        
        
        
        else if str[indexPath.row] == "faculty"{
            
            print("faculty is clicked")
            
            let vc = SenderFacultyViewController(nibName: nil, bundle: nil)
            let currentController = self.getCurrentViewController()
            vc.view.backgroundColor = UIColor(named: "Principal" )
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: false, completion: nil)
            
            
        }
        
        else if str[indexPath.row] == "video" {
            
            
            let vc = SenderVideoHomePageViewController(nibName: nil, bundle: nil)
            let currentController = self.getCurrentViewController()
            vc.view.backgroundColor = UIColor(named: "Principal" )
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: false, completion: nil)
            
            
        }
        
        
        else if str[indexPath.row] == "chat"{
            
            
            print("chat is clicked ")
            
            let vc  = ChatSenderViewController(nibName: nil, bundle: nil)
            let currentController = self.getCurrentViewController()
            vc.view.backgroundColor = UIColor(named: "Principal" )
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: false, completion: nil)
            
        }
        
        
    }
    
    
    else if priority == "p2" || priority == "p3"{
        
        if str[indexPath.row] == "home"{
            
            
            
            let vc = HomeScreenViewController(nibName: nil, bundle: nil)
            let currentController = self.getCurrentViewController()
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            
            currentController?.present(vc, animated: false, completion: nil)
            
            
            
        }
        
        
        
        else if str[indexPath.row] == "communication"{
            
            
            let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
            
        }
        
        
        
        else if str[indexPath.row] == "examination"{
            
            
            let vc = SenderExmainationHomePageViewController(nibName: nil, bundle: nil)
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            vc.examSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.examSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
            
            
        }
        
        
        
        else if str[indexPath.row] == "attendance"{
            
            
            let vc = SenderAttendanceVcViewController(nibName: nil, bundle: nil)
            
            let currentController = self.getCurrentViewController()
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            vc.segmentName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.segmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: false, completion: nil)
            
            
            
            
        }
        
        
        else if str[indexPath.row] == "assignment"{
            
            
            let vc = SenderAssigmentHomePageViewController(nibName: nil, bundle: nil)
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            vc.assigmentSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.assigmentSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
            //
        }
        
        
        else if str[indexPath.row] == "circular"{
            
            let vc = SenderImagePdfHomePageViewController(nibName: nil, bundle: nil)
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            vc.imageSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.imageSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
            
        }
        
        else if str[indexPath.row] == "notice_board"{
            
            let vc = SenderGraditNoticeBoardMenuViewController(nibName: nil, bundle: nil)
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            vc.noticeSegments.backgroundColor = UIColor(named: "HodUnSelector")
            vc.noticeSegments.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
            
        }
        
        
        
        else if str[indexPath.row] == "events"{
            
            
            let vc = SenderEventHomePageViewController(nibName: nil, bundle: nil)
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            vc.eventSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
            
        }
        
        
        
        else if str[indexPath.row] == "faculty"{
            
            let vc = SenderFacultyViewController(nibName: nil, bundle: nil)
            let currentController = self.getCurrentViewController()
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: false, completion: nil)
            
            
        }
        
        else if str[indexPath.row] == "video"{
            
            
            let vc = SenderVideoHomePageViewController(nibName: nil, bundle: nil)
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
            
        }
        
        
        else if str[indexPath.row] == "chat"{
            
            
            let vc  = ChatSenderViewController(nibName: nil, bundle: nil)
            let currentController = self.getCurrentViewController()
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: false, completion: nil)
            
        }
        
        
        
    }
    
    //
    else if priority == "p5"{
        
        
        if str[indexPath.row] == "home"{
            
            let vc = HomeScreenViewController(nibName: nil, bundle: nil)
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
            
            
        }
        
        else if str[indexPath.row] == "communication"{
            
            let vc = CommunicationHomePageViewController(nibName: nil, bundle: nil)
            
            
            let currentController = self.getCurrentViewController()
            
            vc.view.backgroundColor = UIColor(named: "FatherColor")
            vc.CommuniSegementName.backgroundColor = UIColor(named: "FatherUnselector")
            vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "FatherSelector")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            
            vc.modalPresentationStyle = .fullScreen
            
            currentController?.present(vc, animated: false, completion: nil)
            
            
            
            
        }
        
        else if str[indexPath.row] == "examination"{
            
            
            let vc = ExaminationHomePageViewController(nibName: nil, bundle: nil)
            
            let currentController = self.getCurrentViewController()
            vc.view.backgroundColor = UIColor(named: "FatherColor")
            vc.examSegmentName.backgroundColor = UIColor(named: "FatherUnselector")
            vc.examSegmentName.selectedSegmentTintColor = UIColor(named: "FatherSelector")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: false, completion: nil)
            
            
        }
        
        
        else if str[indexPath.row] == "attendance"{
            
            
            let vc = AttendanceViewController(nibName: nil, bundle: nil)
            let currentController = self.getCurrentViewController()
            vc.view.backgroundColor = UIColor(named: "FatherColor")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: false, completion: nil)
            
            
            
        }
        
        
        else if str[indexPath.row] == "assignment"{
            
            let vc = AssigmentHomePageViewController(nibName: nil, bundle: nil)
            let currentController = self.getCurrentViewController()
            vc.view.backgroundColor = UIColor(named: "FatherColor")
            vc.assigmentSegmentName.backgroundColor = UIColor(named: "FatherUnselector")
            vc.assigmentSegmentName.selectedSegmentTintColor = UIColor(named: "FatherSelector")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: false, completion: nil)
            
            
        }
        
        
        
        else if str[indexPath.row] == "circular"{
            
            
            let vc = ImageViewController(nibName: nil, bundle: nil)
            vc.view.backgroundColor = UIColor(named: "FatherColor")
            
            vc.imageSegmentName.backgroundColor = UIColor(named: "FatherUnselector")
            vc.imageSegmentName.selectedSegmentTintColor = UIColor(named: "FatherSelector")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            let currentController = self.getCurrentViewController()
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: false, completion: nil)
            
            
            
            
        }
        
        
        
        else if str[indexPath.row] == "notice_board"{
            
            
            let vc = NoticeBoardHomePageViewController(nibName: nil, bundle: nil)
            vc.view.backgroundColor = UIColor(named: "FatherColor")
            
            vc.noticeSegments.backgroundColor = UIColor(named: "FatherUnselector")
            vc.noticeSegments.selectedSegmentTintColor = UIColor(named: "FatherSelector")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            let currentController = self.getCurrentViewController()
            
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: false, completion: nil)
            
            
        }
        
        
        
        else if str[indexPath.row] == "events"{
            
            let vc = EventsViewController(nibName: nil, bundle: nil)
            vc.view.backgroundColor = UIColor(named: "FatherColor")
            
            
            vc.eventSegmentName.backgroundColor = UIColor(named: "FatherUnselector")
            vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "FatherSelector")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            let currentController = self.getCurrentViewController()
            
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: false, completion: nil)
            
            
            
        }
        
        
        else if str[indexPath.row] == "faculty"{
            
            let vc = FacultyHomePageViewController(nibName: nil, bundle: nil)
            
            let currentController = self.getCurrentViewController()
            vc.view.backgroundColor = UIColor(named: "FatherColor")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: false, completion: nil)
            
            
        }
        
        
        else if str[indexPath.row] == "video"{
            
            let vc = VideoViewController(nibName: nil, bundle: nil)
            let currentController = self.getCurrentViewController()
            vc.view.backgroundColor = UIColor(named: "FatherColor")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: false, completion: nil)
            
        }
        
        else if str[indexPath.row] == "chat"{
            
            
            let vc = ChatHomePageViewController(nibName: nil, bundle: nil)
            
            let currentController = self.getCurrentViewController()
            vc.view.backgroundColor = UIColor(named: "FatherColor")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: false, completion: nil)
            
        }
        
        else if str[indexPath.row] == "course_details"{
            
            let vc = CourseHomePageViewController(nibName: nil, bundle: nil)
            
            let currentController = self.getCurrentViewController()
            vc.view.backgroundColor = UIColor(named: "FatherColor")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: false, completion: nil)
            
            
            
        }
        else if str[indexPath.row] == "hall_ticket"{
            
            
            
            
            let vc = HallTicketViewController(nibName: nil, bundle: nil)
            
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_read_enabled
            
            vc.view.backgroundColor = UIColor(named: "StudentParent")
            vc.str = str
            vc.strName = strName
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
        }
        
        
        else if str[indexPath.row] == "category_credit_points"{
            
            
            let vc = CategoryHomePageViewController(nibName: nil, bundle: nil)
            let currentController = self.getCurrentViewController()
            vc.view.backgroundColor = UIColor(named: "FatherColor")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: false, completion: nil)
            
            
        }
        
        
        else if str[indexPath.row] == "sem_credit_points"{
            
            let vc = SemesterHomePageViewController(nibName: nil, bundle: nil)
            let currentController = self.getCurrentViewController()
            vc.view.backgroundColor = UIColor(named: "FatherColor")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: false, completion: nil)
            
            
            
        }
        
        
        
        
        else if str[indexPath.row] == "exam_application_details"{
            
            
            let vc = ExamDetailsHomePageViewController(nibName: nil, bundle: nil)
            let currentController = self.getCurrentViewController()
            vc.view.backgroundColor = UIColor(named: "FatherColor")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: false, completion: nil)
            
            
        }
        
        
    }
    
    
    else if priority == "p6"{
        
        
        if str[indexPath.row] == "home"{
            
            
            
            let vc = HomeScreenViewController(nibName: nil, bundle: nil)
            let currentController = self.getCurrentViewController()
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: false, completion: nil)
            
            
            
        }
        
        
        
        else if str[indexPath.row] == "communication"{
            
            
            let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
            
        }
        
        
        
        else if str[indexPath.row] == "examination"{
            
            
            let vc = SenderExmainationHomePageViewController(nibName: nil, bundle: nil)
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            vc.examSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.examSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
            
            
        }
        
        
        
        else if str[indexPath.row] == "attendance"{
            
            
            let vc = SenderAttendanceVcViewController(nibName: nil, bundle: nil)
            
            let currentController = self.getCurrentViewController()
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            vc.segmentName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.segmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: false, completion: nil)
            
            
            
            
        }
        
        
        else if str[indexPath.row] == "assignment"{
            
            
            let vc = SenderAssigmentHomePageViewController(nibName: nil, bundle: nil)
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            vc.assigmentSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.assigmentSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
            //
        }
        
        
        else if str[indexPath.row] == "circular"{
            
            let vc = SenderImagePdfHomePageViewController(nibName: nil, bundle: nil)
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            vc.imageSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.imageSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
            
        }
        
        else if str[indexPath.row] == "notice_board"{
            
            let vc = SenderGraditNoticeBoardMenuViewController(nibName: nil, bundle: nil)
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            vc.noticeSegments.backgroundColor = UIColor(named: "HodUnSelector")
            vc.noticeSegments.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
            
        }
        
        
        
        else if str[indexPath.row] == "events"{
            
            
            let vc = SenderEventHomePageViewController(nibName: nil, bundle: nil)
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            vc.eventSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
            
        }
        
        
        
        else if str[indexPath.row] == "faculty"{
            
            let vc = SenderFacultyViewController(nibName: nil, bundle: nil)
            let currentController = self.getCurrentViewController()
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: false, completion: nil)
            
            
        }
        
        else if str[indexPath.row] == "video"{
            
            
            let vc = SenderVideoHomePageViewController(nibName: nil, bundle: nil)
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
            
        }
        
        
        else if str[indexPath.row] == "chat"{
            
            
            let vc  = ChatSenderViewController(nibName: nil, bundle: nil)
            let currentController = self.getCurrentViewController()
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: false, completion: nil)
            
        }
        
        
        
    }
    
}




// tap bar View




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
                
                
                else if i.priority == "p7"{
                    
                    vc.IdentfierLabel = "UNIVERSITY HEAD"
                    vc.loginPrincipal.append(i)
                }
                
                
            }
            vc.modalPresentationStyle = .fullScreen
            
            present(vc, animated: true,completion: nil)
            
            
            
        }
    }
    
    
    
    
    
    
    
    
    
}



}


class ImageShow : UITapGestureRecognizer{


var imageUrls : String!


}

class MoreImageAdd : UITapGestureRecognizer {

var url : String!
}
