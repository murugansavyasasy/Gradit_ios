//
//  AttechmentViewController.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 06/04/23.
//

import UIKit
import ObjectMapper
import KRProgressHUD

@available(iOS 16.0, *)
class AttechmentViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

@IBOutlet weak var pdfdefaultlbl: UILabel!
@IBOutlet weak var imagedefaultLbl: UILabel!
@IBOutlet weak var tapBarView: UIViewX!
@IBOutlet weak var studentNameLAbel: UILabel!

@IBOutlet weak var redirectLoginView: UIViewX!

@IBOutlet weak var nodataLabel: UILabel!
@IBOutlet weak var nodataView: UIView!
@IBOutlet weak var PdfView: UIViewX!

@IBOutlet weak var Tv: UITableView!



@IBOutlet weak var imageVIew: UIViewX!



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





var identifier = "AssigmentAttechmentTableViewCell"



var assigmentSubmiited : [AssignmentSubDataDetail] = []
var addapiRef : [AddDataDeatils] = []


var memberId : String!
var assigmentId : String!
var assigmentFileType : String!

var fileType : String!



var selectedCell : IndexPath?




var piroty : String!
var mobileNumber : String!
var colgId : String!





var loginDatas : [datalogin]!
var logindataprinci :[datalogin]!



var password : String!

var colgImg : String!

var studentName : String!
override func viewDidLoad() {
    super.viewDidLoad()
    
    
    overrideUserInterfaceStyle = .light
    studentNameLAbel.text = studentName
    
    imagedefaultLbl.textColor = UIColor(named: "bluecolor")
    pdfdefaultlbl.textColor = UIColor(named: "bluecolor")
    sideMenuView.isHidden = true
    nodataLabel.isHidden = true
    nodataView.isHidden = true
    Tv.isHidden = true
    
    let defaults = UserDefaults.standard
    
    //        memberId = defaults.string(forKey: DefaultsKeys.memberid)
    piroty = defaults.string(forKey: DefaultsKeys.priority)
    mobileNumber = defaults.string(forKey: DefaultsKeys.mobileNumber)
    colgId = defaults.string(forKey: DefaultsKeys.collegeid)
    topMessageLabel.text = defaults.string(forKey: DefaultsKeys.memberName)
    password = defaults.string(forKey: DefaultsKeys.Password)
    colgImg = defaults.string(forKey: DefaultsKeys.colglogo)
    clgLogoImg.sd_setImage(with: URL(string:  colgImg), placeholderImage: UIImage(named: "person.fill"))
    
    
    if piroty == "p1"{
        
        view.backgroundColor = UIColor(named: "Principal" )
        tapBarView.backgroundColor = UIColor(named: "Principal" )
        topLabels.text = "Principal"
        
    }
    
    else if piroty == "p4"{
        view.backgroundColor = UIColor(named: "studentViewColors" )
        tapBarView.backgroundColor = UIColor(named: "studentViewColors" )
        topLabels.text = "Student"
        
    }
    
    else if piroty == "p2" {
        view.backgroundColor = UIColor(named: "Teaching Staff")
        tapBarView.backgroundColor = UIColor(named: "Teaching Staff" )
        topLabels.text = "Hod"
        
    }
    
    else if piroty == "p5"{
        
        view.backgroundColor = UIColor(named: "FatherColor")
        tapBarView.backgroundColor = UIColor(named: "FatherColor" )
        topLabels.text = "Father"
        
        
        
    }
    
    else if piroty == "p3"{
        view.backgroundColor = UIColor(named: "Teaching Staff")
        tapBarView.backgroundColor = UIColor(named: "Teaching Staff" )
        topLabels.text = "Teacher"
        
    }
    
    
    addApi()
    
    let rowNib = UINib(nibName: identifier, bundle: nil)
    Tv.register(rowNib, forCellReuseIdentifier: identifier)
    
    
    let image = UITapGestureRecognizer(target: self, action: #selector(imageVc))
    imageVIew.addGestureRecognizer(image)
    
    let pdf = UITapGestureRecognizer(target: self, action: #selector(pdfVc))
    PdfView.addGestureRecognizer(pdf)
    
    imageVc()
    // tap Bar UiTapGuster.
    let loginRediectGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
    redirectLoginView.addGestureRecognizer(loginRediectGesture)
    
    
    
    let changeRolesGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
    changeRolesView.addGestureRecognizer(changeRolesGesture)
    
    
    let logoutGesture = UITapGestureRecognizer(target: self, action: #selector(logoutPressed))
    loginView.addGestureRecognizer(logoutGesture)
    
    
    
    
    
    let menuGestureHide = UITapGestureRecognizer(target: self, action: #selector(menu))
    viewTap.addGestureRecognizer(menuGestureHide)
    
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


func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return assigmentSubmiited.count
    
    
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    
    let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as!
    
    
    AssigmentAttechmentTableViewCell
    let assiment : AssignmentSubDataDetail = assigmentSubmiited[indexPath.row]
    
    
    
    if let selectedCells = selectedCell, selectedCells == indexPath {
        
        cell.lineView.isHidden = false
        cell.discreptionsLabel.isHidden = false
        
    } else {
        
        
        cell.lineView.isHidden = true
        cell.discreptionsLabel.isHidden = true
    }
    
    
    
    
    if assiment.file_name == nil{
        
        
        
        
        cell.DateLabel.text = assiment.submittedtime
        cell.FileNameLabel.isHidden = true
        cell.imageViewClick.isUserInteractionEnabled = false
        cell.discreptionsLabel.text = assiment.description
        
        
    }
    
    
    else{
        
        
        cell.FileNameLabel.isHidden = false
        
        
        let cardtrim = assiment.file_name.trimmingCharacters(in: CharacterSet(charactersIn: "https://s3.ap-south-1.amazonaws.com/gradit-india-live/26-09-2023/")) //value: 1000001
        print("cardtrim",cardtrim)
        
        cell.DateLabel.text = assiment.submittedtime
        cell.FileNameLabel.text = cardtrim
        cell.discreptionsLabel.text = assiment.description
        
        
        let cellclick  = cellclik(target: self, action: #selector(ShowContentVc))
        
        cellclick.imageUrl = assiment.content
        
        cell.fileImage.addGestureRecognizer(cellclick)
        
    }
    
    
    
    return cell
    
    
}

func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    if let selectedCells = selectedCell, selectedCells == indexPath {
        
        selectedCell = nil
        
        
    } else {
        
        
        selectedCell = indexPath
    }
    
    
    
    Tv.beginUpdates()
    Tv.endUpdates()
    Tv.reloadData()
    
    
}


func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    
    
    if let selectedCell = selectedCell, selectedCell == indexPath {
        
        Tv.estimatedRowHeight = 100
        return UITableView.automaticDimension
        
    } else {
        
        return 105
        
    }
    
    
}


@IBAction func ShowContentVc(gesture : cellclik){
    
    if piroty == "p4"{
        
        if fileType == "image"{
            
            let vc = SenderImageDownloadViewController(nibName: nil, bundle: nil)
            vc.imgfilePath = gesture.imageUrl
            vc.fileType = "2"
            vc.view.backgroundColor = UIColor(named: "StudentParent")
            vc.modalPresentationStyle = .fullScreen
            
            present(vc, animated: true,completion: nil)
        }
        
        else if fileType == "pdf"{
            
            let vc = SenderImageDownloadViewController(nibName: nil, bundle: nil)
            vc.imgfilePath = gesture.imageUrl
            vc.fileType = "3"
            vc.view.backgroundColor = UIColor(named: "StudentParent")
            vc.modalPresentationStyle = .fullScreen
            
            present(vc, animated: true,completion: nil)
            
        }
        
        
    }
    
    else if piroty == "p5"{
        
        if fileType == "image"{
            
            let vc = SenderImageDownloadViewController(nibName: nil, bundle: nil)
            vc.imgfilePath = gesture.imageUrl
            vc.fileType = "2"
            vc.view.backgroundColor = UIColor(named: "FatherColor" )
            vc.modalPresentationStyle = .fullScreen
            
            present(vc, animated: true,completion: nil)
        }
        
        else if fileType == "pdf"{
            
            let vc = SenderImageDownloadViewController(nibName: nil, bundle: nil)
            vc.imgfilePath = gesture.imageUrl
            vc.fileType = "3"
            vc.view.backgroundColor = UIColor(named: "FatherColor" )
            vc.modalPresentationStyle = .fullScreen
            
            present(vc, animated: true,completion: nil)
            
        }
        
        
    }
    
    
    else if piroty == "p1"{
        
        if fileType == "image"{
            
            let vc = SenderImageDownloadViewController(nibName: nil, bundle: nil)
            vc.imgfilePath = gesture.imageUrl
            vc.fileType = "2"
            vc.view.backgroundColor = UIColor(named: "Principal" )
            vc.modalPresentationStyle = .fullScreen
            
            present(vc, animated: true,completion: nil)
        }
        
        else if fileType == "pdf"{
            
            let vc = SenderImageDownloadViewController(nibName: nil, bundle: nil)
            vc.imgfilePath = gesture.imageUrl
            vc.fileType = "3"
            vc.view.backgroundColor = UIColor(named: "Principal" )
            vc.modalPresentationStyle = .fullScreen
            
            present(vc, animated: true,completion: nil)
            
        }
        
        
    }
    
    
    else if piroty == "p2"{
        
        if fileType == "image"{
            
            let vc = SenderImageDownloadViewController(nibName: nil, bundle: nil)
            vc.imgfilePath = gesture.imageUrl
            vc.fileType = "2"
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            vc.modalPresentationStyle = .fullScreen
            
            present(vc, animated: true,completion: nil)
        }
        
        else if fileType == "pdf"{
            
            let vc = SenderImageDownloadViewController(nibName: nil, bundle: nil)
            vc.imgfilePath = gesture.imageUrl
            vc.fileType = "3"
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            vc.modalPresentationStyle = .fullScreen
            
            present(vc, animated: true,completion: nil)
            
        }
        
    }
    
    
    else if piroty == "p3"{
        
        if fileType == "image"{
            
            let vc = SenderImageDownloadViewController(nibName: nil, bundle: nil)
            vc.imgfilePath = gesture.imageUrl
            vc.fileType = "2"
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            vc.modalPresentationStyle = .fullScreen
            
            present(vc, animated: true,completion: nil)
        }
        
        else if fileType == "pdf"{
            
            let vc = SenderImageDownloadViewController(nibName: nil, bundle: nil)
            vc.imgfilePath = gesture.imageUrl
            vc.fileType = "3"
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            vc.modalPresentationStyle = .fullScreen
            
            present(vc, animated: true,completion: nil)
            
        }
        
        
    }
}

@IBAction func imageVc(){
    imagedefaultLbl.textColor = .white
    
    let filetypes = "image"
    fileType = filetypes
    
    if imageVIew.isUserInteractionEnabled ==  true {
        
        imageVIew.backgroundColor = UIColor(named: "bluecolor")
        
        imagedefaultLbl.textColor = .white
        pdfdefaultlbl.textColor = UIColor(named: "bluecolor")
        PdfView.backgroundColor = UIColor.white
        
        
        assigmentCount()
    }
    
    
    else{
        
        imageVIew.isUserInteractionEnabled = false
        imageVIew.backgroundColor = UIColor.white
        imagedefaultLbl.textColor = UIColor(named: "bluecolor")
        
        
    }
    
    
    
    
}

@IBAction func pdfVc(){
    
    
    let filetypes = "pdf"
    fileType = filetypes
    
    if PdfView.isUserInteractionEnabled ==  true {
        
        PdfView.backgroundColor = UIColor(named: "bluecolor")
        imageVIew.backgroundColor = UIColor.white
        imagedefaultLbl.textColor = UIColor(named: "bluecolor")
        pdfdefaultlbl.textColor = .white
        
        
        assigmentCount()
    }
    
    
    else{
        
        PdfView.isUserInteractionEnabled = false
        
        
        
        pdfdefaultlbl.textColor = UIColor(named: "bluecolor")
        
    }
    
}


@IBAction func adLoad(gesture : sendSubmisionAdd){
    
    
    
    let vc = SenderExamAddVcViewController(nibName: nil, bundle: nil)
    
    vc.AddWebUrl = gesture.url
    
    vc.modalPresentationStyle = .fullScreen
    present(vc, animated: true,completion: nil)
    
    
}

func addApi(){
    
    
    let add = AddApiModal()
    
    let defaults = UserDefaults.standard
    var deviceToken = defaults.string(forKey:DefaultsKeys.DeviceToken )
    add.device_token = deviceToken
    print("EventDefaultsKeys.DeviceToken",deviceToken)
    add.member_id = memberId
    add.mobile_no = mobileNumber
    add.priority = piroty
    add.college_id = colgId
    add.previous_add_id = 3
    
    
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
                
                let singleTap = sendSubmisionAdd(target: self, action: #selector(adLoad))
                singleTap.url = i.add_url
                bigImg.isUserInteractionEnabled = true
                bigImg.addGestureRecognizer(singleTap)
                
                
            }
        }
        
        else{
            
            
        }
    }
    
    
}

func assigmentCount(){
    
    let assigmentCount = AssigmentSummitedModal()
    
    
    assigmentCount.assignmentid = assigmentId
    assigmentCount.processby = memberId
    assigmentCount.filetype = fileType
    
    
    let assigmentCountStrs = assigmentCount.toJSONString()
    
    print("yearAndSectionModalStr",assigmentCountStrs)
    
    assigmentSubmmitedRequest.call_request(param: assigmentCountStrs!) {
        
        [self]  (res) in
        
        
        
        let AssigmentResp : AssigmentSubmitResponce =
        Mapper<AssigmentSubmitResponce>().map(JSONString: res)!
        
        
        
        if AssigmentResp.status == 1 {
            
            
            assigmentSubmiited = AssigmentResp.data
            nodataLabel.isHidden = true
            nodataView.isHidden = true
            Tv.isHidden = false
            Tv.delegate = self
            Tv.dataSource = self
            Tv.reloadData()
            
            
            
        }
        
        
        else{
            
            
            nodataLabel.isHidden = false
            nodataView.isHidden = false
            nodataLabel.text = AssigmentResp.message
            Tv.isHidden = true
            Tv.delegate = self
            Tv.dataSource = self
            Tv.reloadData()
            
        }
        
    }
    
}


@IBAction func backBtn(_ sender: Any) {
    
    dismiss(animated: true)
}



// Tab Bar Nagivation


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
        
        //            self.tv.reloadData()
        
        
        KRProgressHUD.dismiss()
        
    }
    
    
}


@IBAction func notificationVc() {
    print("NotificationViewController")
    let vc = NotificationViewController(nibName: nil, bundle: nil)
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
    
    
    
    
    
    
    let login = LoginModal ()
    login.mobilenumber = mobileNumber
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


class cellclik : UITapGestureRecognizer{



var imageUrl : String!





}
class sendSubmisionAdd : UITapGestureRecognizer{


var url : String!

}
