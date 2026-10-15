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
class MoreImageViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {



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

var identifier = "MoreImagesTableViewCell"
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
    clgLogoImg.sd_setImage(with: URL(string:  colgImg), placeholderImage: UIImage(named: "EmptyCollegeIcon"))
    
    topMessageLabel.text = memberName
    sideMenuView.isHidden = true
  
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
    
    view.backgroundColor = .priorityColor
    
    
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
    
    var add = AddApiModal()
    
    let defaults = UserDefaults.standard
    var deviceToken = defaults.string(forKey:DefaultsKeys.DeviceToken )
    add.device_token = deviceToken
    print("EventDefaultsKeys.DeviceToken",deviceToken)
    add.member_id = Int(memberId)
    add.mobile_no = MobileNumber
    add.priority = priority
    add.college_id = Int(collegId)
    add.previous_add_id = PreviousAddId
    
    APiCallManager.shared.callApi(url: APIEndpoints.GetAddsForCollege, httpMethod: .post, queryParam: nil, requestBody: add
    ) {[weak self] (result:Result<AddApiResponce,Error>) in
        
        guard let self = self else {return}
        
        switch result {
        case .success(let success):
     
                addapiRef = success.data ?? []
                
                let ad = addapiRef.first
              
                bigImg.setAdImage(
                    imageURL: ad?.background_image,
                    adURL: ad?.add_url,
                    from: self
                )

                smallImg.setAdImage(
                    imageURL: ad?.add_image,
                    adURL: ad?.add_url,
                    placeholder: UIImage(named: "Default_Ad_small"),
                    from: self
                )
            
            
        case .failure(let failure):
            print(failure.localizedDescription)
            
            bigImg.setAdImage(
                imageURL: "",
                adURL: "",
                from: self
            )

            smallImg.setAdImage(
                imageURL:"",
                adURL: "",
                placeholder: UIImage(named: "Default_Ad_small"),
                from: self
            )
        }
    }
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
        
        let vc = LoginVc(nibName: nil, bundle: nil)
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


class ImageShow : UITapGestureRecognizer{


var imageUrls : String!


}
