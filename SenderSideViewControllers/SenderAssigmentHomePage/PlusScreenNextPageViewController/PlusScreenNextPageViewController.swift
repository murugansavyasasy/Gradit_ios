//
//  PlusScreenNextPageViewController.swift
//  GraditSenderAssigment
//
//  Created by MACBOOKPRO on 01/12/22.
//

import UIKit
import KRProgressHUD
import DropDown
import UniformTypeIdentifiers
import ALCameraViewController
import BSImagePicker
import Photos
import ObjectMapper
import FSCalendar
import AWSCore
import AWSS3


@available(iOS 16.0, *)
class PlusScreenNextPageViewController: UIViewController,UITextViewDelegate,UIImagePickerControllerDelegate & UINavigationControllerDelegate ,UIDocumentMenuDelegate,UIDocumentPickerDelegate, FSCalendarDelegate,UITextFieldDelegate  {

@IBOutlet weak var assigmentTopLbl: UILabel!
@IBOutlet weak var discrpTextView: UIViewX!
@IBOutlet weak var descrpitonDefltLbl: UILabel!
@IBOutlet weak var lblCount: UILabel!
@IBOutlet weak var tapBarView: UIViewX!
@IBOutlet weak var redirectLoginView: UIViewX!
@IBOutlet weak var dateLabel: UILabel!
@IBOutlet weak var uploadFileLabel: UILabel!

@IBOutlet weak var titleTextField: UITextField!
@IBOutlet weak var smallImg: UIImageView!
@IBOutlet weak var bigImg: UIImageView!
@IBOutlet weak var topMessageLabel: UILabel!
@IBOutlet weak var clgLogoImg: UIImageView!
@IBOutlet weak var logoutView: UIView!

@IBOutlet weak var changeRolesView: UIView!


@IBOutlet weak var profileView: UIView!

@IBOutlet weak var topLabels: UILabel!
@IBOutlet weak var refreshView: UIView!
@IBOutlet weak var privacyPolicyView: UIView!

@IBOutlet weak var faqView: UIView!


@IBOutlet weak var submisionSelection: UIView!
@IBOutlet weak var helpView: UIView!

@IBOutlet weak var viewTap: UIView!


@IBOutlet weak var changePasswordView: UIView!


@IBOutlet weak var termsAndConditionView: UIView!

@IBOutlet weak var sideMenuView: UIView!


@IBOutlet weak var cancelView: UIViewX!

@IBOutlet weak var descripitionTextField: UITextView!

@IBOutlet weak var SelectResipionsView: UIViewX!


@IBOutlet weak var uploadView: UIView!


@IBOutlet weak var selectTypeDropDownView: UIViewX!




@IBOutlet weak var dropDownTextLabel: UILabel!



@IBOutlet weak var uploadImageView: UIImageView!


@IBOutlet weak var uploadTextLabel: UILabel!


var assImagePdf : [assigmentImagePdfResponce] = []

let dropDown = DropDown()

var addImageBackGroundurl : String!
var imageWebUrl : String!
var smallImageUrl  : String!

var image_choose: Bool = false

var image = UIImagePickerController()

var selectedImageUrl: URL!

var SelectedAssets = [PHAsset]()

var photoArray = [UIImage]()

var arrSelectedFilePath : [Any] = []


var VimeoURL : URL!

var memberId : String!
var priority : String!
var colgId   : String!
var sectionid : String!
var deptid    : String!
var loginType : String!
var memberName : String!
var colgImg : String!
var display_date : String!

var drop : String!
var urls : URL!

var assigmentID : String!
var awsPdfURl :[String] = []

var fileType : String!

var TotalAws : String!

var NoticeBoardId = "1"
var videoId = "2"
var EventId = "3"
var communicationId = "4"
var imagePdfId = "5"
var Assigment = "6"
var videe : String!

var url_date : String!


var GetVimeoData : VimeoData!

var getVimeoEmbed : VimeoEmbed!

//    var VimeoURL : URL!

var iframes : String!

var videoTypee  : String!

var calendar: FSCalendar!

var mobileNumber : String!

var password : String!

var loginDatas : [datalogin]!
var logindataprinci :[datalogin]!
var str : [String] = []

var strName : [String] = []
var dates : Date!
let maxLenghth = 500
var assigmentHeaderId : String!

var ImgeType : String!
var dateText : String!
var titleText : String!

var currentImageCount = 0
var totalImageCount = 0
var originalImagesArray = [UIImage]()
var absoluteStringImg : String!
var imageUrlArray = NSMutableArray()
var convertedImagesUrlArray = NSMutableArray()
var forwadDiscreption : String!
var absoluteStringPdf : String!
var pdfData : Data? = nil
var is_read_enabled : String!
var is_write_enabled : String!

override func viewDidLoad() {
    super.viewDidLoad()
    
    overrideUserInterfaceStyle = .light
    
    
    bigImg.sd_setImage(with: URL(string: addImageBackGroundurl), placeholderImage: UIImage(named: "ic_white"))
    smallImg.sd_setImage(with: URL(string: smallImageUrl ), placeholderImage: UIImage(named: "ic_white"))
    
    
    
    
    sideMenuView.isHidden = true
    refreshView.isHidden = true
    let defaults = UserDefaults.standard
    
    memberId = defaults.string(forKey: DefaultsKeys.memberid)
    priority = defaults.string(forKey: DefaultsKeys.priority)
    colgId = defaults.string(forKey: DefaultsKeys.collegeid)
    deptid = defaults.string(forKey: DefaultsKeys.deptid)
    sectionid = defaults.string(forKey: DefaultsKeys.sectionid)
    loginType = defaults.string(forKey: DefaultsKeys.loginAsType)
    memberName = defaults.string(forKey: DefaultsKeys.memberName)
    colgImg = defaults.string(forKey: DefaultsKeys.colglogo)
    clgLogoImg.sd_setImage(with: URL(string:  colgImg), placeholderImage: UIImage(named: "person.fill"))
    
    mobileNumber = defaults.string(forKey: DefaultsKeys.mobileNumber)
    
    password = defaults.string(forKey: DefaultsKeys.Password)
    
    
    
    topMessageLabel.text = memberName
    
    
    if Assigment == "6"{
        
        assigmentTopLbl.text = "New Assignment"
        discrpTextView.isHidden = false
        uploadView.isHidden = false
        
        
        
    }
    
    
    
    else{
        
        assigmentTopLbl.text = "Forward Assignment"
        
        titleTextField.isUserInteractionEnabled = false
        selectTypeDropDownView.isUserInteractionEnabled = false
        discrpTextView.isHidden = true
        uploadView.isHidden = true
        descrpitonDefltLbl.isHidden = true
        titleTextField.text = titleText
        
        dropDownTextLabel.text = ImgeType
        
        
        
    }
    
    
    
    
    if priority == "p1"{
        
        view.backgroundColor =  UIColor(named: "Principal" )
        tapBarView.backgroundColor = UIColor(named: "Principal" )
        
        topLabels.text = "Principal"
        
    }
    
    else if priority == "p4"{
        
        topLabels.text = "Student"
        
    }
    
    else if priority == "p2" {
        view.backgroundColor =  UIColor(named: "Teaching Staff" )
        tapBarView.backgroundColor = UIColor(named: "Teaching Staff" )
        topLabels.text = "Hod"
        
    }
    
    else if priority == "p5"{
        
        
        topLabels.text = "Father"
        
        
        
    }
    
    else if priority == "p3"{
        view.backgroundColor =  UIColor(named: "Teaching Staff" )
        tapBarView.backgroundColor = UIColor(named: "Teaching Staff" )
        topLabels.text = "Teacher"
        
    }
    
    
    
    descripitionTextField.text = "Enter the Description"
    descripitionTextField.textColor = UIColor.lightGray
    
    
    descripitionTextField.returnKeyType = .done
    descripitionTextField.delegate = self
    titleTextField.returnKeyType = .done
    titleTextField.delegate = self
    let cancel =   UITapGestureRecognizer(target: self, action: #selector(cancelVcc))
    
    cancelView.addGestureRecognizer(cancel)
    
    
    
    let calander = UITapGestureRecognizer(target: self, action: #selector(CalanderVC))
    submisionSelection.addGestureRecognizer(calander)
    
    
    let tapToUpload =   UITapGestureRecognizer(target: self, action: #selector(AssigmentuploadImage))
    
    uploadView.addGestureRecognizer(tapToUpload)
    
    
    let selectDropDown =   UITapGestureRecognizer(target: self, action: #selector(selectedDropVc))
    
    selectTypeDropDownView.addGestureRecognizer(selectDropDown)
    
    
    let selectResipions =   UITapGestureRecognizer(target: self, action: #selector(respienceVc))
    
    SelectResipionsView.addGestureRecognizer(selectResipions)
    
    
    uploadView.isHidden = true
    uploadImageView.isHidden = true
    uploadTextLabel.isHidden = true
    
    
    let changeRolesGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
    changeRolesView.addGestureRecognizer(changeRolesGesture)
    
    
    let logoutGesture = UITapGestureRecognizer(target: self, action: #selector(logoutPressed))
    logoutView.addGestureRecognizer(logoutGesture)
    
    let loginRediectGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
    redirectLoginView.addGestureRecognizer(loginRediectGesture)
    
    
    
    
    let menuGestureHide = UITapGestureRecognizer(target: self, action: #selector(menu))
    viewTap.addGestureRecognizer(menuGestureHide)
    
    
    
    
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
    
    
    
    
    let chagePassword = UITapGestureRecognizer(target: self, action: #selector(changePassowrdVC))
    changePasswordView.addGestureRecognizer(chagePassword)
    
    
    
    
    let singleTap = UITapGestureRecognizer(target: self, action: #selector(adLoad))
    
    bigImg.isUserInteractionEnabled = true
    bigImg.addGestureRecognizer(singleTap)
    
    
    
    
    
}

func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    titleTextField.resignFirstResponder()
    return true
}

@IBAction func cancelVcc(){
    
    dismiss(animated: true)
}

@IBAction func CalanderVC(){
    
    
    
    
    FromDate_Action()
}



func FromDate_Action(){
    
    
    
    RPicker.selectDate(title: "Select Date", cancelText: "Cancel", datePickerMode: .date, style: .Inline, didSelectDate: {[weak self] (today_date) in
        
        
        
        self?.display_date = today_date.dateString("dd/MM/yyyy")
        
        self?.url_date = today_date.dateString("yyyy/MM/dd")
        
        self?.dateLabel.text = self!.display_date
        
        self!.dates = today_date
        
        
        
        
    })
    
}




func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool
{
    if(date == dates)
    {
        return false
    }
    else
    {
        return true
    }
}


@IBAction func adLoad(){
    
    
    
    let vc = SenderExamAddVcViewController(nibName: nil, bundle: nil)
    
    vc.AddWebUrl = imageWebUrl
    
    vc.modalPresentationStyle = .fullScreen
    present(vc, animated: true,completion: nil)
    
    
}





func textViewDidChange(_ textView: UITextView) {
    lblCount.text = "\(maxLenghth - descripitionTextField.text.count)/"+"\(500)"
    
    
    
    
}

func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    let newText = (descripitionTextField.text as NSString).replacingCharacters(in: range, with: text)
    let numberOfChars = newText.count
    if text == "\n" {
        descripitionTextField.resignFirstResponder()
    }
    return numberOfChars < 500
}


@IBAction  func AssigmentuploadImage() {
    
    photoArray.removeAll()
    arrSelectedFilePath.removeAll()
    
    SelectedAssets.removeAll()
    
    
    
            uploadFileLabel.text = "Upload Files"
    
    
    
    
    if drop == "PDF"{
        
        
        clickFunction()
        
        
        
    }
    
    else if drop == "Image"{
        
        print("uploafdImage")
        
        
        
        let image =  "image"
        
        fileType = image
        
        let alert = UIAlertController(title: "Add Photo", message: "", preferredStyle: .actionSheet)
        
        for i in ["Gallery","Take a Photo"] {
            
            alert.addAction(UIAlertAction(title: i, style: .default, handler: choose_image_handler))
            
        }
        
        
        
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    
    
    
    else if drop == "Text"{
        
        
        
    }
}





@IBAction func selectedDropVc(){
    
    
    let myArray = ["Text","PDF","Image"]
    
    dropDown.dataSource = myArray//4
    dropDown.anchorView = selectTypeDropDownView //5
    
    dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
    
    dropDown.direction = .bottom
    DropDown.appearance().backgroundColor = UIColor.white
    dropDown.show() //7
    
    
    dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
        print("Selected item: \(item) at index: \(index)")
        self.dropDownTextLabel.text = item
        
        drop = item
        
        if item == "Text"{
            
            let text = "Text"
            
            fileType = text
            print("text")
            uploadView.isHidden = true
            uploadImageView.isHidden = true
            uploadTextLabel.isHidden = true
            uploadFileLabel.text = ""
        }
        
        
        
        else if item == "PDF"{
            print("PDF")
            uploadView.isHidden = false
            uploadImageView.isHidden = false
            uploadTextLabel.isHidden = false
            uploadFileLabel.text = "Upload Files"
            
            
        }
        
        
        else if item == "Image"{
            
            print("Image")
            uploadView.isHidden = false
            uploadImageView.isHidden = false
            uploadTextLabel.isHidden = false
            uploadFileLabel.text = "Upload Files"
            
            
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

@IBAction func respienceVc(){
    
    
    
    
    
    if Assigment == "6"{
        
        if dateLabel.text == "DD/MM/YY" {
            
            
            
            let refreshAlert = UIAlertController(title: "", message: "Kindly Enter Date Filed", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
                
                
            }))
            
            
            
            
            present(refreshAlert, animated: true, completion: nil)
            
        }
        
        
        else if  dropDownTextLabel.text == "selectType"{
            
            
            
            let refreshAlert = UIAlertController(title: "", message: "Kindly Select Type", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
                
                
            }))
            
            
            
            
            present(refreshAlert, animated: true, completion: nil)
        }
        
        else if (titleTextField.text == ""){
            
            
            
            let refreshAlert = UIAlertController(title: "", message: "Kindly Enter Title", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
                
                
            }))
            
            
            
            
            present(refreshAlert, animated: true, completion: nil)
        }
        
        else if (descripitionTextField.text == "Enter the Description")  {
            
            
            
            let refreshAlert = UIAlertController(title: "", message: "Kindly Enter Description ", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
                
                
            }))
            
            
            
            
            present(refreshAlert, animated: true, completion: nil)
            
        }
        
        
        
        else if (descripitionTextField.text == "")  {
            
            
            
            
            
            let refreshAlert = UIAlertController(title: "", message: "Kindly Enter Details Description", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
                
                
            }))
            
            
            
            
            present(refreshAlert, animated: true, completion: nil)
        }
        
        
        
        else if uploadFileLabel.text == "Upload Files"{
            
            
            
            
            
            
            let refreshAlert = UIAlertController(title: "", message: "Please Select Image Or Pdf", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
                
                
            }))
            
            
            
            
            present(refreshAlert, animated: true, completion: nil)
            
            
        }
        
        
        
        
        
        
        else{
            
            
            
            
            if priority == "p1"{
                
                
                
                let vc = HodRespienViewController(nibName: nil, bundle: nil)
                vc.resivre = Assigment
                vc.AssigmentMenuAwsUrl = TotalAws
                vc.AssigmentFileType = fileType
                vc.titlesTextField = titleTextField.text
                vc.discreptionss = descripitionTextField.text
                vc.videoURL = videe
                vc.videoIframe = iframes
                vc.videoType = videoTypee
                vc.awsArry = awsPdfURl
                vc.str = str
                vc.strName = strName
                vc.assigmentHeaderId =  assigmentHeaderId
                
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                vc.assigmentDate = dateLabel.text
                vc.photoArray = photoArray
                vc.pdfData = pdfData
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true,completion: nil)
                
                
            }
            
            else if priority == "p3"{
                
                
                
                let vc = HodRespienViewController(nibName: nil, bundle: nil)
                
                
                vc.resivre = Assigment
                vc.AssigmentMenuAwsUrl = TotalAws
                vc.AssigmentFileType = fileType
                vc.titlesTextField = titleTextField.text
                vc.discreptionss = descripitionTextField.text
                vc.videoURL = videe
                vc.videoIframe = iframes
                vc.assigmentDate = dateLabel.text
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.str = str
                vc.strName = strName
                vc.awsArry = awsPdfURl
                vc.photoArray = photoArray
                vc.pdfData = pdfData
                vc.assigmentHeaderId =  assigmentHeaderId
                
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true,completion: nil)
            }
            
            
            
            else if priority == "p2"{
                
                
                
                let vc = HodRespienViewController(nibName: nil, bundle: nil)
                vc.resivre = Assigment
                vc.AssigmentMenuAwsUrl = TotalAws
                vc.AssigmentFileType = fileType
                vc.titlesTextField = titleTextField.text
                vc.discreptionss = descripitionTextField.text
                vc.videoURL = videe
                vc.videoIframe = iframes
                vc.videoType = videoTypee
                vc.awsArry = awsPdfURl
                vc.str = str
                vc.strName = strName
                vc.assigmentHeaderId =  assigmentHeaderId
                
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                vc.assigmentDate = dateLabel.text
                vc.photoArray = photoArray
                vc.pdfData = pdfData
                
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true,completion: nil)
                
            }
            
            
            
        }
        
        
    }
    
    
    
    
    
    
    else {
        
        
        
        
        if dateLabel.text == "DD/MM/YY" {
            
            
            let refreshAlert = UIAlertController(title: "", message: "Kindly Enter Date Filed", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
                
                
                
                
            }))
            
            
            
            present(refreshAlert, animated: true, completion: nil)
            
        }
        
        
        else if  dropDownTextLabel.text == "selectType"{
            
            
            let refreshAlert = UIAlertController(title: "", message: "Kindly Select Type", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
                
                
                
                
            }))
            
            
            
            present(refreshAlert, animated: true, completion: nil)
            
            
        }
        
        else if (titleTextField.text == ""){
            
            
            
            
            let refreshAlert = UIAlertController(title: "", message: "Kindly Enter Title", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
                
                
                
                
            }))
            
            
            
            present(refreshAlert, animated: true, completion: nil)
            
            
        }
        
        
        
        
        else{
            
            
            
            
            
            if priority == "p1"{
                
                let vc = HodRespienViewController(nibName: nil, bundle: nil)
                vc.resivre = Assigment
                vc.AssigmentMenuAwsUrl = TotalAws
                vc.AssigmentFileType = fileType
                vc.titlesTextField = titleTextField.text
                vc.discreptionss = forwadDiscreption
                vc.videoURL = videe
                vc.videoIframe = iframes
                vc.videoType = videoTypee
                vc.awsArry = awsPdfURl
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                vc.assigmentDate = dateLabel.text
                vc.assigmentHeaderId =  assigmentHeaderId
                vc.photoArray = photoArray
                vc.pdfData = pdfData
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true,completion: nil)
                
                
            }
            
            else if priority == "p3"{
                
                
                
                let vc = HodRespienViewController(nibName: nil, bundle: nil)
                
                vc.resivre = Assigment
                vc.AssigmentMenuAwsUrl = TotalAws
                vc.AssigmentFileType = fileType
                vc.titlesTextField = titleTextField.text
                vc.discreptionss = forwadDiscreption
                vc.videoURL = videe
                vc.videoIframe = iframes
                vc.assigmentDate = dateLabel.text
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                vc.str = str
                vc.strName = strName
                vc.awsArry = awsPdfURl
                vc.assigmentHeaderId =  assigmentHeaderId
                vc.photoArray = photoArray
                vc.pdfData = pdfData
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true,completion: nil)
            }
            
            else if priority == "p2"{
                
                
                let vc = HodSelectResipenceViewController(nibName: nil, bundle: nil)
                vc.resivre = Assigment
                vc.AssigmentMenuAwsUrl = TotalAws
                vc.AssigmentFileType = fileType
                vc.titlesTextField = titleTextField.text
                vc.discreptionss = forwadDiscreption
                vc.videoUrl = videe
                vc.iframeUrl = iframes
                vc.videoType = videoTypee
                vc.awsArry = awsPdfURl
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                vc.assigmentDate = dateLabel.text
                vc.assigmentHeaderId =  assigmentHeaderId
                vc.photoArray = photoArray
                vc.pdfData = pdfData
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true,completion: nil)
                
            }
            
            else if priority == "p7"{
                
                
                let vc = GroupHeadViewController(nibName: nil, bundle: nil)
                vc.resivre = Assigment
                vc.AssigmentMenuAwsUrl = TotalAws
                vc.AssigmentFileType = fileType
                vc.titlesTextField = titleTextField.text
                vc.discreptionss = forwadDiscreption
                //                    vc.videoUrl = videe
                //                    vc.iframeUrl = iframes
                vc.videoType = videoTypee
                vc.awsArry = awsPdfURl
                vc.str = str
                vc.strName = strName
                
                vc.assigmentDate = dateLabel.text
                vc.assigmentHeaderId =  assigmentHeaderId
                vc.photoArray = photoArray
                vc.pdfData = pdfData
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true,completion: nil)
                
            }
            
            
            
        }
        
        
        
        
    }
    
    
    
}


@IBAction func backbtn(_ sender: Any) {
    
    dismiss(animated: true)
}




func textViewDidBeginEditing(_ textView: UITextView) {
    if descripitionTextField.text == "Enter the Description" {
        descripitionTextField.text = ""
        descripitionTextField.textColor = UIColor.black
        
    }
}



func textViewDidEndEditing(_ textView: UITextView) {
    if descripitionTextField.text == "" {
        descripitionTextField.text = "Enter the Description"
        descripitionTextField.textColor = UIColor.lightGray
        
    }
}



@IBAction func helpRedirect() {
    
    let vc = HelpViewController(nibName: nil, bundle: nil)
    vc.modalPresentationStyle = .fullScreen
    let currentController = self.getCurrentViewController()
    currentController?.present(vc, animated: true, completion: nil)
    
    
}


@IBAction func termsAndCondition() {
    
    let vc = MenuTermsViewController(nibName: nil, bundle: nil)
    vc.modalPresentationStyle = .fullScreen
    let currentController = self.getCurrentViewController()
    currentController?.present(vc, animated: true, completion: nil)
    
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
    let currentController = self.getCurrentViewController()
    currentController?.present(vc, animated: true, completion: nil)
    
}

@IBAction func privacyPolicyRedirect() {
    
    let vc = PrivacyPolicyViewController(nibName: nil, bundle: nil)
    vc.modalPresentationStyle = .fullScreen
    let currentController = self.getCurrentViewController()
    currentController?.present(vc, animated: true, completion: nil)
    
}





@IBAction func refreshVc() {
    
    
    KRProgressHUD.show()
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        
        
        
        KRProgressHUD.dismiss()
        
    }
    
    
}


@IBAction func notificationVc() {
    print("NotificationViewController")
    let vc = NotificationViewController(nibName: nil, bundle: nil)
    vc.modalPresentationStyle = .fullScreen
    let currentController = self.getCurrentViewController()
    currentController?.present(vc, animated: false, completion: nil)
    
    
    
}




@IBAction func menu() {
    
    if sideMenuView.isHidden == true{
        
        sideMenuView.isHidden = false
        //
        
        print("menuVisble")
    }
    
    else{
        
        sideMenuView.isHidden = true
        
        
    }
    
    
}


@IBAction func changePassowrdVC(){
    
    let vc = ChangePasswordViewController(nibName: nil, bundle: nil)
    vc.modalPresentationStyle = .fullScreen
    let currentController = self.getCurrentViewController()
    currentController?.present(vc, animated: true, completion: nil)
    
    
}


 @IBAction func priorityVc() {
        
        let vc = PriorityViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
    }

// upload Image Aws Part


func choose_image_handler(action: UIAlertAction){
    
    
    
    print(action.title!)
    
    if ((action.title!.elementsEqual("Gallery"))){
        
        print("camera")
        
        
        
        open_gallery()
        
    }else if ((action.title!.elementsEqual("Take a Photo"))){
        
        print("Take a Photo")
        
        open_camera()
        
    }
    
    else {
        
        
        
        let optionMenu = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        
        self.present(optionMenu, animated: true, completion: nil)
        
    }
    
    
    
}


func open_camera(){
    
    
    photoArray.removeAll()
    arrSelectedFilePath.removeAll()
    pdfData
    if UIImagePickerController.availableCaptureModes(for: .rear) != nil {
        let camera_controller = CameraViewController
        
        
        { [weak self] image, asset in
            
            
            //
            self!.photoArray.append(image! as UIImage)
            //
            
            
            
            let x : Int =  self!.photoArray.count
            var myString = String(x)
            self!.uploadFileLabel.text = "number of file selected :" + myString
            
            self?.dismiss(animated: true, completion: nil)
            
        }
        
        
        
        present(camera_controller, animated: true, completion: nil)
    } else {
        noCamera()
        
    }
    
    
    
}


func noCamera(){
    let alertVC = UIAlertController(title: "No Camera", message: "Sorry, this device has no camera",preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style:.default, handler: nil)
    alertVC.addAction(okAction)
    present(alertVC,animated: true,completion: nil)
    
}










func open_gallery(){
    
    
    photoArray.removeAll()
    arrSelectedFilePath.removeAll()
    
    let imagePicker = ImagePickerController()
    
    
    
    imagePicker.settings.selection.max = 3
    
    imagePicker.settings.fetch.assets.supportedMediaTypes = [.image]
    
    
    
    presentImagePicker(imagePicker, animated: true, select:{ (asset: PHAsset) -> Void in
        
        
        
    }, deselect: { (assets : PHAsset) -> Void in
        
        
    }, cancel: {(assets: [PHAsset]) -> Void in
        
    }, finish: {(assets: [PHAsset]) -> Void in
        
        
        self.image_choose = true
        
        
        
        for i in 0..<assets.count
                
                
                
        {
            
            let resource = PHAssetResource.assetResources(for: assets[i]).first
            
            let name = resource?.originalFilename
            
            let PicsLocalPath = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(name!)
            
            
            self.arrSelectedFilePath.append(PicsLocalPath)
            
            print("path",PicsLocalPath)
            
            print("filepathssss",self.arrSelectedFilePath)
            
            
            self.SelectedAssets.append(assets[i])
            
            print("pathdsssssassets",self.SelectedAssets)
            print("assetssss",assets[i])
        }
        
        self.convertAssetToImages()
        
    })
    
    
    
}






func convertAssetToImages() -> Void {
    
    
    if SelectedAssets.count != 0 {
        
        
        
        for i in 0..<SelectedAssets.count {
            
            
            
            let manager = PHImageManager.default()
            
            
            
            let option = PHImageRequestOptions()
            
            
            
            var thumbnail = UIImage()
            
            
            
            option.isSynchronous = true
            
            
            
            manager.requestImage(for: SelectedAssets[i],targetSize: CGSize( width : 200,height : 200), contentMode: .aspectFill, options: option, resultHandler: {(result, info) ->  Void in
                
                
                
                thumbnail = result!
                
                
                
            })
            
            
            
            let data  = thumbnail.jpegData(compressionQuality: 0.7)
            
            let newImage = UIImage(data: data!)
            
            self.photoArray.append(newImage! as UIImage)
            
        }
        
        
        
        let x : Int =  self.photoArray.count
        var myString = String(x)
        self.uploadFileLabel.text = "number of file selected :" + myString
        
        
        print("photoArray.count" ,photoArray)
        
        
        
        
        
        
    }
    
    
    
    print("complete phto array \(self.photoArray)")
    
    
    
}






public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
    
    
    
    
    
    print("urldsss",url)
    
    let fileurl: URL = url as URL
    let filename = url.lastPathComponent
    let fileextension = url.pathExtension
    print("URL: \(fileurl)", "NAME: \(filename)", "EXTENSION: \(fileextension)")
    
    urls = fileurl
    
    let imageData = NSData(contentsOf: url)
    
    
    
    
    do {
        pdfData = try Data(contentsOf: url, options: NSData.ReadingOptions())
        
        self.uploadFileLabel.text = "number of file selected :" + "1"
        
        
        
        
    } catch {
        print("set PDF filer error : ", error)
        
        
        let refreshAlert = UIAlertController(title: "", message: "set PDF filer error", preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in
            
        }))
    }
    
    
    
    
    
    
    
    
    
}

@objc public func documentMenu(_ documentMenu:UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
    
    
    documentPicker.delegate = self
    present(documentPicker, animated: true, completion: nil)
}


func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
    print("view was cancelled")
    dismiss(animated: true, completion: nil)
}

func clickFunction(){
    
    var assigmentPdfType = "pdf"
    
    fileType = assigmentPdfType
    
    let documentPicker = UIDocumentPickerViewController(documentTypes: ["com.adobe.pdf"], in: .import)
    
    documentPicker.delegate = self
    documentPicker.modalPresentationStyle = .formSheet
    
    
    
    self.present(documentPicker, animated: true, completion: nil)
}



func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
    return range.location <= 99
}

}
