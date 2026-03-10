//
//  SenderImagePdfPlusNextPageViewController.swift
//  GraditImagePdf
//
//  Created by MACBOOKPRO on 07/12/22.
//

import UIKit
import KRProgressHUD
import MobileCoreServices
import UniformTypeIdentifiers
import Photos
import ALCameraViewController
import BSImagePicker
import ObjectMapper
import AWSCore
import AWSS3


@available(iOS 16.0, *)
class SenderImagePdfPlusNextPageViewController: UIViewController,UITextViewDelegate,UIImagePickerControllerDelegate & UINavigationControllerDelegate,UIDocumentMenuDelegate,UIDocumentPickerDelegate, UITextFieldDelegate  {
    
    @IBOutlet weak var tapBarView: UIViewX!
    @IBOutlet weak var redirectLoginView: UIViewX!
    
    @IBOutlet weak var notificationView: UIView!
    
    
    @IBOutlet weak var cancelView: UIViewX!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var selectRespinsView: UIViewX!
    @IBOutlet weak var smallImg: UIImageView!
    @IBOutlet weak var descripitionTextField: UITextView!
    
    @IBOutlet weak var lblCount: UILabel!
    
    @IBOutlet weak var bigImg: UIImageView!
    
    @IBOutlet weak var uploadImageView: UIView!
    
    @IBOutlet weak var galleryView: UIView!
    
    
    @IBOutlet weak var uploadFileLabel: UILabel!
    
    @IBOutlet weak var takeAPhotoView: UIView!
    
    
    @IBOutlet weak var choosePDFView: UIView!
    
    @IBOutlet weak var chooseView: UIViewX!
    
    @IBOutlet weak var logoutView: UIView!
    
    @IBOutlet weak var changeRolesView: UIView!
    
    
    @IBOutlet weak var profileView: UIView!
    
    
    @IBOutlet weak var topLabels: UILabel!
    @IBOutlet weak var topMessageLabel: UILabel!
    
    
    @IBOutlet weak var clgLogoImg: UIImageView!
    @IBOutlet weak var refreshView: UIView!
    
    @IBOutlet weak var sideMenuView: UIView!
    
    
    @IBOutlet weak var termsAndConditionView: UIView!
    
    
    
    @IBOutlet weak var changePasswordView: UIView!
    
    
    
    @IBOutlet weak var privacyPolicyView: UIView!
    
    
    @IBOutlet weak var faqView: UIView!
    
    
    @IBOutlet weak var viewTap: UIView!
    
    
    let picker = UIImagePickerController()
    
    @IBOutlet weak var helpView: UIView!
    
    
    var urlss : URL!
    
    var image_choose: Bool = false
    
    
    var selectedImageUrl: URL!
    
    var SelectedAssets = [PHAsset]()
    
    var photoArray = [UIImage]()
    
    var arrSelectedFilePath : [Any] = []
    
    
    var urls : URL!
    
    var image = UIImagePickerController()
    
    var resiveMEnuId = "5"
    
    var AwsPdfUrl : String!
    
    var AwsUrlss : [String] = []
    
    var addImageeee : [String] = []
    var resiveMenuId : String!
    
    var uploadImage : String!
    var backGroungImageUrl : String!
    var SmallImageUrl : String!
    var addWebUrl : String!
    var priority : String!
    
    var fileType : String!
    
    var AddImage : [URL] = []
    
    var TotalAws : String!
    
    var NoticeBoardId = "1"
    var videoId = "2"
    var EventId = "3"
    var communicationId = "4"
    var imagePdfId = "5"
    var Assigment = "6"
    var cologLog : String!
    
    var loginDatas : [datalogin]!
    var logindataprinci :[datalogin]!
    
    var MobileNumber : String!
    
    var password : String!
    let maxLenghth = 500
    var str : [String] = []
    
    var strName : [String] = []
    
    var imagePicker = UIImagePickerController()
    var currentImageCount = 0
    var totalImageCount = 0
    var originalImagesArray = [UIImage]()
    var absoluteStringImg : String!
    var imageUrlArray = NSMutableArray()
    var convertedImagesUrlArray = NSMutableArray()
    var pdfData : Data? = nil
    var is_read_enabled = ""
    var is_write_enabled = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        
        print("srfrd",resiveMenuId)
        sideMenuView.isHidden = true
        //        chooseView.isHidden = true
        let defaults = UserDefaults.standard
        
        
        
        priority = defaults.string(forKey: DefaultsKeys.priority)
        cologLog = defaults.string(forKey: DefaultsKeys.colglogo)
        MobileNumber  = defaults.string(forKey: DefaultsKeys.mobileNumber)
        
        password = defaults.string(forKey: DefaultsKeys.Password)
        
        bigImg.sd_setImage(with: URL(string: backGroungImageUrl), placeholderImage: UIImage(named: "ic_white"))
        
        
        smallImg.sd_setImage(with: URL(string: SmallImageUrl), placeholderImage: UIImage(named: "ic_white"))
        
        topMessageLabel.text = defaults.string(forKey: DefaultsKeys.memberName)
        
        clgLogoImg.sd_setImage(with: URL(string: cologLog), placeholderImage: UIImage(named: "ic_white"))
        
        
        
        
        descripitionTextField.text = "Enter the Description"
        descripitionTextField.textColor = UIColor.lightGray
        
        descripitionTextField.returnKeyType = .done
        descripitionTextField.delegate = self
        titleTextField.returnKeyType = .done
        titleTextField.delegate = self
        
        if priority == "p1"{
            tapBarView.backgroundColor = UIColor(named: "Principal" )
            topLabels.text = "Principal"
            
        }
        
        else if priority == "p4"{
            
            topLabels.text = "Student"
            
        }
        
        else if priority == "p2" {
            
            tapBarView.backgroundColor = UIColor(named: "Teaching Staff" )
            topLabels.text = "Hod"
            
        }
        
        else if priority == "p7" {
            
            tapBarView.backgroundColor = UIColor(named: "univercityColorCod" )
            topLabels.text = "University Head"
            
        }
        else if priority == "p5"{
            
            
            topLabels.text = "Father"
            
            
            
        }
        
        else if priority == "p3"{
            
            tapBarView.backgroundColor = UIColor(named: "Teaching Staff" )
            topLabels.text = "Teacher"
            
        }
        
        
        
        
        
        let cancelV =   UITapGestureRecognizer(target: self, action: #selector(CancelVc))
        
        cancelView.addGestureRecognizer(cancelV)
        
        
        
        let select =   UITapGestureRecognizer(target: self, action: #selector(selectVc))
        
        selectRespinsView.addGestureRecognizer(select)
        
        let loginRediectGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        redirectLoginView.addGestureRecognizer(loginRediectGesture)
        
        
        let tapToUpload =   UITapGestureRecognizer(target: self, action: #selector(GalleryVc))
        
        uploadImageView.addGestureRecognizer(tapToUpload)
        
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(adLoad))
        
        bigImg.isUserInteractionEnabled = true
        bigImg.addGestureRecognizer(singleTap)
        
        
        
        let changeRolesGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        changeRolesView.addGestureRecognizer(changeRolesGesture)
        
        
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
        
        
        
        
    }
    
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if descripitionTextField.text == "Enter the Description" {
            descripitionTextField.text = ""
            descripitionTextField.textColor = UIColor.black
            
        }
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
    func textViewDidEndEditing(_ textView: UITextView) {
        if descripitionTextField.text == "" {
            descripitionTextField.text = "Enter the Description"
            descripitionTextField.textColor = UIColor.lightGray
            
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
        return true
    }
    
    @IBAction func CancelVc(){
        
        dismiss(animated: true)
    }
    
    
    @IBAction func selectVc(){
        
        
        if priority == "p1"{
            //
            
            
            
            
            if (titleTextField.text == ""){
                
                
                
                
                
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
                
                
                
                
                
                let refreshAlert = UIAlertController(title: "", message: "Kindly Enter Details Description ", preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    
                    
                    
                }))
                
                
                
                
                present(refreshAlert, animated: true, completion: nil)
                
            }
            
            else if  uploadFileLabel.text == "Upload Files"{
                
                
                
                
                
                let refreshAlert = UIAlertController(title: "", message: "Kindly Select Image Or Pdf ", preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    
                    
                    
                }))
                
                
                
                
                present(refreshAlert, animated: true, completion: nil)
                
            }
            
            else{
                
                let vc = SelectResipientsViewController(nibName: nil, bundle: nil)
                vc.awsurl = TotalAws
                vc.fileType = fileType
               
                vc.resivre = imagePdfId
                vc.titlesTextField = titleTextField.text
                vc.discreptionss = descripitionTextField.text
                vc.photoArray = photoArray
                vc.str =  str
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.strName = strName
                vc.pdfData = pdfData
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true,completion: nil)
                
            }
            
        }
        
        
        else if priority == "p3"{
            
            
            if (titleTextField.text == ""){
                
                
                
                
                let refreshAlert = UIAlertController(title: "", message: "Kindly Enter Title ", preferredStyle: UIAlertController.Style.alert)
                
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
                
                
                
                
                
                let refreshAlert = UIAlertController(title: "", message: "Kindly Enter Details Description ", preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    
                    
                    
                }))
                
                
                
                
                present(refreshAlert, animated: true, completion: nil)
                
            }
            
            
            else if  uploadFileLabel.text == "Upload Files"{
                
                
                
                
                let refreshAlert = UIAlertController(title: "", message: "Kindly Select Image Or Pdf", preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    
                    
                    
                }))
                
                
                
                
                present(refreshAlert, animated: true, completion: nil)
                
                
            }
            
            else{
                
                let vc = HodRespienViewController(nibName: nil, bundle: nil)
                vc.resivre = imagePdfId
                
                vc.imageFileType = fileType
                vc.titlesTextField = titleTextField.text
                vc.discreptionss = descripitionTextField.text
                vc.str =  str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                vc.awsurl = TotalAws
                vc.pdfData = pdfData
                vc.photoArray = photoArray
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true,completion: nil)
                
            }
            
            
            
            
            
        }
        
        
        
        
        else if priority == "p7"{
            
            
            if (titleTextField.text == ""){
                
                
                
                
                let refreshAlert = UIAlertController(title: "", message: "Kindly Enter Title ", preferredStyle: UIAlertController.Style.alert)
                
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
                
                
                
                
                
                let refreshAlert = UIAlertController(title: "", message: "Kindly Enter Details Description ", preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    
                    
                    
                }))
                
                
                
                
                present(refreshAlert, animated: true, completion: nil)
                
            }
            
            
            else if  uploadFileLabel.text == "Upload Files"{
                
                
                
                
                let refreshAlert = UIAlertController(title: "", message: "Kindly Select Image Or Pdf", preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    
                    
                    
                }))
                
                
                
                
                present(refreshAlert, animated: true, completion: nil)
                
                
            }
            
            else{
                
                let vc = GroupHeadViewController(nibName: nil, bundle: nil)
                vc.resivre = imagePdfId
                vc.awsurl = TotalAws
                vc.imageFileType = fileType
                vc.titlesTextField = titleTextField.text
                vc.discreptionss = descripitionTextField.text
                vc.str =  str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.pdfData = pdfData
                vc.photoArray = photoArray
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true,completion: nil)
                
            }
            
            
            
            
            
        }
        
        
        
        else if priority == "p2"{
            
            
            if (titleTextField.text == ""){
                
                
                
                
                
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
                
                
                
                
                
                let refreshAlert = UIAlertController(title: "", message: "Kindly Enter Details Description ", preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    
                    
                    
                }))
                
                
                
                
                present(refreshAlert, animated: true, completion: nil)
                
                
            }
            
            
            else if  uploadFileLabel.text == "Upload Files"{
                
                
                
                let refreshAlert = UIAlertController(title: "", message: "Kindly Select Image Or Pdf ", preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    
                    
                    
                }))
                
                
                
                
                present(refreshAlert, animated: true, completion: nil)
                
            }
            
            else{
                
                let vc = HodSelectResipenceViewController(nibName: nil, bundle: nil)
                
                vc.resivre = imagePdfId
                vc.ImagePdfAws = TotalAws
                vc.fileType = fileType
                vc.titlesTextField = titleTextField.text
                vc.discreptionss = descripitionTextField.text
                vc.str =  str
                vc.strName = strName
                vc.pdfData = pdfData
                vc.photoArray = photoArray
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true,completion: nil)
                
            }
            
            
        }
        
        
        
        
        
        
        
        
    }
    
    
    @IBAction func adLoad(){
        
        
        let vc = SendercomuniAddViewController(nibName: nil, bundle: nil)
        
        vc.AddWebUrl = addWebUrl
        
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
        
        
        
        
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
    
    
    
    
    
    
    @IBAction func backbtn(_ sender: Any) {
        
        dismiss(animated: true)
    }
    
    
    
    // Tab Bar Nagivation
    
    
    
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
    
    // image and Pdf Upload part
    
    
    
    @IBAction  func GalleryVc() {
        
        var galaryid =  "2"
        
        fileType = galaryid
        
        
        
        photoArray.removeAll()
        SelectedAssets.removeAll()
        arrSelectedFilePath.removeAll()
        pdfData?.removeAll()
        
        uploadFileLabel.text = "Upload Files"
        
        
        let alert = UIAlertController(title: "Add Photo", message: "", preferredStyle: .actionSheet)
        
        for i in ["Document","Gallery", "Take a Photo"] {
            
            alert.addAction(UIAlertAction(title: i, style: .default, handler: choose_image_handler))
            
            
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        
        
        self.present(alert, animated: true, completion: nil)
        
        
        
        
    }
    
    
    func choose_image_handler(action: UIAlertAction){
        
        
        
        print(action.title!)
        
        if ((action.title!.elementsEqual("Take a Photo"))){
            
            print("camera")
            
            open_camera()
            
        }else if ((action.title!.elementsEqual("Gallery"))){
            
            print("gallery")
            
            open_gallery()
            
        }
        
        else if ((action.title!.elementsEqual("Document"))){
            
            
            choosePdfVc()
            
        }
        
        else {
            
            
            
            let optionMenu = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
            
            self.present(optionMenu, animated: true, completion: nil)
            
        }
        
        
        
    }
    
    
    func open_camera(){
        
        photoArray.removeAll()
        SelectedAssets.removeAll()
        arrSelectedFilePath.removeAll()
        pdfData?.removeAll()
        
        if UIImagePickerController.availableCaptureModes(for: .rear) != nil {
            let camera_controller = CameraViewController
            
            
            { [weak self] image, asset in
                
                
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
        SelectedAssets.removeAll()
        arrSelectedFilePath.removeAll()
        pdfData?.removeAll()
        
        
        
        print("1")
        
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
                
                print("22222222222")
                
                let resource = PHAssetResource.assetResources(for: assets[i]).first
                
                let name = resource?.originalFilename
                
                let PicsLocalPath = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(name!)
                
                
                self.arrSelectedFilePath.append(PicsLocalPath)
                
                print("path",PicsLocalPath)
                
                self.AddImage.append(PicsLocalPath)
                print("tititititititi",self.AddImage)
                print("vfdcdcfvcdxfcdxfcdx",self.arrSelectedFilePath)
                
                let x : Int =  self.arrSelectedFilePath.count
                var myString = String(x)
                self.uploadFileLabel.text = "number of file selected :" + myString
                
                
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
    
    
    
    
    
    
    
    
    
    
    
    @IBAction  func TakePhotoVc() {
        
        
        
        
        
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            image.sourceType = UIImagePickerController.SourceType.camera
            //If you dont want to edit the photo then you can set allowsEditing to false
            image.allowsEditing = true
            image.delegate = self
            self.present(image, animated: true, completion: nil)
        }
        else{
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        
        
        
        
    }
    
    
    
    
    @IBAction func choosePdfVc(){
        
        var pdftype = "3"
        
        fileType = pdftype
        
        clickFunction()
        
        
        
    }
    
    
    
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        
        
        
        
        
        
        
        print("urldsss",url)
        
        let fileurl: URL = url as URL
        let filename = url.lastPathComponent
        let fileextension = url.pathExtension
        print("URL: \(fileurl)", "NAME: \(filename)", "EXTENSION: \(fileextension)")
        
        urls = fileurl
        
        
        
        
        //
        
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
        
        photoArray.removeAll()
        SelectedAssets.removeAll()
        arrSelectedFilePath.removeAll()
        
        
        let documentPicker = UIDocumentPickerViewController(documentTypes: ["com.adobe.pdf"], in: .import)
        
        documentPicker.delegate = self
        documentPicker.modalPresentationStyle = .formSheet
        
        
        
        self.present(documentPicker, animated: true, completion: nil)
    }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return range.location <= 99
    }
    
}
