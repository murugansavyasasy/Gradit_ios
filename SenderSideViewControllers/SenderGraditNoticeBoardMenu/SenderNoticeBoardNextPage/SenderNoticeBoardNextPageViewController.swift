//
//  SenderNoticeBoardNextPageViewController.swift
//  GraditSenderSideNoticeBoardMenu
//
//  Created by MACBOOKPRO on 29/11/22.
//

import UIKit
import KRProgressHUD
import ObjectMapper
import UniformTypeIdentifiers
import Photos
import ALCameraViewController
import BSImagePicker

@available(iOS 16.0, *)
class SenderNoticeBoardNextPageViewController: UIViewController, UITextViewDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate & UINavigationControllerDelegate,UIDocumentMenuDelegate,UIDocumentPickerDelegate{
    
    @IBOutlet weak var uploadImageView: RectangularDashedView!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var tapNameview: UIView!
    @IBOutlet weak var tapBarView: UIViewX!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var SelectRespicView: UIViewX!
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var smallImg: UIImageView!
    @IBOutlet weak var bigImg: UIImageView!
    @IBOutlet weak var logoutView: UIView!
    @IBOutlet weak var changeRolesView: UIView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var redirectLoginView: UIViewX!
    @IBOutlet weak var topLabels: UILabel!
    @IBOutlet weak var topMessageLabel: UILabel!
    @IBOutlet weak var clgLogoImg: UIImageView!
    @IBOutlet weak var refreshView: UIView!
    @IBOutlet weak var sideMenuView: UIView!
    @IBOutlet weak var termsAndConditionView: UIView!
    @IBOutlet weak var changePasswordView: UIView!
    @IBOutlet weak var uploadFileLabel: UILabel!
    @IBOutlet weak var privacyPolicyView: UIView!
    @IBOutlet weak var faqView: UIView!
    @IBOutlet weak var viewTap: UIView!
    @IBOutlet weak var helpView: UIView!
    @IBOutlet weak var cancelsView: UIViewX!
    @IBOutlet weak var descripitionTextField: UITextView!
    
    
    var BackGroundImageUrl : String!
    var SmallImageUrl : String!
    var addWebUrl : String!
    var priority : String!
    var menuTypes : String!
    var colgImg : String!
    var strName : [String] = []
    var image = UIImagePickerController()
    var str : [String] = []
    var is_read_enabled = ""
    var is_write_enabled = ""
    var pdfData : Data? = nil
    var fileType : String!
    var SelectedAssets = [PHAsset]()
    var photoArray = [UIImage]()
    var arrSelectedFilePath : [Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        sideMenuView.isHidden = true
        let defaults = UserDefaults.standard
        priority = defaults.string(forKey: DefaultsKeys.priority)
        bigImg.sd_setImage(with: URL(string: BackGroundImageUrl), placeholderImage: UIImage(named: "ic_white"))
        smallImg.sd_setImage(with: URL(string: SmallImageUrl), placeholderImage: UIImage(named: "ic_white"))
        topMessageLabel.text = defaults.string(forKey: DefaultsKeys.memberName)
        colgImg = defaults.string(forKey: DefaultsKeys.colglogo)
        clgLogoImg.sd_setImage(with: URL(string:  colgImg), placeholderImage: UIImage(named: "EmptyCollegeIcon"))
        
        view.backgroundColor = .priorityColor
        tapBarView.backgroundColor = .priorityColor
        topLabels.text = .priorityRole
        descripitionTextField.text = "Enter the Description"
        descripitionTextField.textColor = UIColor.lightGray
        descripitionTextField.font = UIFont(name: "verdana", size: 13.0)
        descripitionTextField.returnKeyType = .done
        descripitionTextField.delegate = self
        titleTextField.returnKeyType = .done
        titleTextField.delegate = self
        let select = UITapGestureRecognizer(target: self, action: #selector(SelectVc))
        SelectRespicView.addGestureRecognizer(select)
        
        
        let tapToUpload =   UITapGestureRecognizer(target: self, action: #selector(GalleryVc))
        uploadImageView.addGestureRecognizer(tapToUpload)
        
        let cancels = UITapGestureRecognizer(target: self, action: #selector(cancelVc))
        cancelsView.addGestureRecognizer(cancels)
        
        
        let loginRediectGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        redirectLoginView.addGestureRecognizer(loginRediectGesture)
        
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
        
        let privacyPolicyGesture = UITapGestureRecognizer(target: self, action: #selector(privacyPolicyRedirect))
        privacyPolicyView.addGestureRecognizer(privacyPolicyGesture)
        
        let termsAndConditionGesture = UITapGestureRecognizer(target: self, action: #selector(termsAndCondition))
        termsAndConditionView.addGestureRecognizer(termsAndConditionGesture)
        
        let chagePassword = UITapGestureRecognizer(target: self, action: #selector(changePassowrdVC))
        changePasswordView.addGestureRecognizer(chagePassword)
        
        let topname = UITapGestureRecognizer(target: self, action: #selector(changePassowrdVC))
        tapNameview.addGestureRecognizer(topname)
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(adLoad))
        
        bigImg.isUserInteractionEnabled = true
        bigImg.addGestureRecognizer(singleTap)
        
    }

    
    @IBAction func SelectVc() {

        let title = titleTextField.text?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        let description = descripitionTextField.text?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        guard !title.isEmpty else {
            showAlert("Kindly Enter Title")
            return
        }

        guard description != "Enter the Description" else {
            showAlert("Kindly Enter Description")
            return
        }

        guard !description.isEmpty else {
            showAlert("Kindly Enter Details Description")
            return
        }

        switch priority {

        case "p1":
            let vc = SelectResipientsViewController(nibName: nil,bundle: nil)
            vc.resivre = menuTypes
            vc.titlesTextField = title
            vc.discreptionss = description
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.fileType = fileType
            vc.pdfData = pdfData
            vc.photoArray = photoArray
            presentFullScreen(vc)

        case "p3":
            let vc = HodRespienViewController(nibName: nil,bundle: nil)
            vc.resivre = menuTypes
            vc.titlesTextField = title
            vc.discreptionss = description
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.imageFileType = fileType
            vc.pdfData = pdfData
            vc.photoArray = photoArray
            presentFullScreen(vc)

        case "p2":
            let vc = HodSelectResipenceViewController(nibName: nil, bundle: nil)
            vc.resivre = menuTypes
            vc.titlesTextField = title
            vc.discreptionss = description
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.fileType = fileType
            vc.pdfData = pdfData
            vc.photoArray = photoArray
            presentFullScreen(vc)

        case "p7":
            let vc = GroupHeadViewController(nibName: nil, bundle: nil)
            vc.resivre = menuTypes
            vc.titlesTextField = title
            vc.discreptionss = description
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.fileType = fileType
            vc.pdfData = pdfData
            vc.photoArray = photoArray
            presentFullScreen(vc)

        default:
            break
        }
    }
    
    
    @IBAction func adLoad(){
        let vc = SenderNoticeAddViewController(nibName: nil, bundle: nil)
        vc.AddWebUrl = addWebUrl
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if descripitionTextField.text == "Enter the Description" {
            descripitionTextField.text = ""
            descripitionTextField.textColor = UIColor.black
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        lblCount.text = "\(descripitionTextField.text.count)/"+"\(500)"
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
    
    
    @IBAction func cancelVc (){
        dismiss(animated: true)
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true)
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
        vc.str = str
        vc.strName = strName
        vc.is_read_enabled = is_read_enabled
        vc.is_write_enabled = is_write_enabled
        vc.modalPresentationStyle = .fullScreen
        let currentController = self.getCurrentViewController()
        currentController?.present(vc, animated: false, completion: nil)
    }
    
    
    
    
    @IBAction func menu() {
        sideMenuView.isHidden.toggle()
    }
    
    @IBAction func changePassowrdVC(){
        let vc = ChangePasswordVC(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        let currentController = self.getCurrentViewController()
        currentController?.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func priorityVc() {
        let vc = PriorityScreenVC(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
    }
   
    
    @IBAction  func GalleryVc() {
        fileType = "image"
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
        if ((action.title!.elementsEqual("Take a Photo"))){
            open_camera()
        }else if ((action.title!.elementsEqual("Gallery"))){
            open_gallery()
        }else if ((action.title!.elementsEqual("Document"))){
            choosePdfVc()
        }else {
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
                let x : Int =  self!.photoArray.count
                self!.uploadFileLabel.text = "number of file selected :" + String(x)
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
        fileType = "image"
        let imagePicker = ImagePickerController()
        imagePicker.settings.selection.max = 3
        imagePicker.settings.fetch.assets.supportedMediaTypes = [.image]
        presentImagePicker(imagePicker, animated: true, select:{ (asset: PHAsset) -> Void in
        }, deselect: { (assets : PHAsset) -> Void in
        }, cancel: {(assets: [PHAsset]) -> Void in
        }, finish: {(assets: [PHAsset]) -> Void in
            for i in 0..<assets.count{
                let resource = PHAssetResource.assetResources(for: assets[i]).first
                let name = resource?.originalFilename
                let PicsLocalPath = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(name!)
                self.arrSelectedFilePath.append(PicsLocalPath)
                let x : Int =  self.arrSelectedFilePath.count
                var myString = String(x)
                self.uploadFileLabel.text = "number of file selected :" + myString
                self.SelectedAssets.append(assets[i])
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
        }
    }

    @IBAction  func TakePhotoVc() {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            image.sourceType = UIImagePickerController.SourceType.camera
            image.allowsEditing = true
            image.delegate = self
            self.present(image, animated: true, completion: nil)
        }else{
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func choosePdfVc(){
        fileType = "pdf"
        clickFunction()
    }
    
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        
        let fileurl: URL = url as URL
        do {
            pdfData = try Data(contentsOf: url, options: NSData.ReadingOptions())
            self.uploadFileLabel.text = "number of file selected :" + "1"
        } catch {
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
        dismiss(animated: true, completion: nil)
    }
    
    func clickFunction(){
        
        photoArray.removeAll()
        SelectedAssets.removeAll()
        arrSelectedFilePath.removeAll()
        let documentPicker =  UIDocumentPickerViewController(documentTypes: ["com.adobe.pdf"], in: .import)
        documentPicker.delegate = self
        documentPicker.modalPresentationStyle = .formSheet
        self.present(documentPicker, animated: true, completion: nil)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return range.location <= 99
    }
}
