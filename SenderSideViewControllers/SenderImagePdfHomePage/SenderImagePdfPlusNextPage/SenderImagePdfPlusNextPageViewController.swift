//
//  SenderImagePdfPlusNextPageViewController.swift
//  GraditImagePdf
//
//  Created by MACBOOKPRO on 07/12/22.
//

import UIKit
import KRProgressHUD
import UniformTypeIdentifiers
import Photos
import ALCameraViewController
import BSImagePicker

@available(iOS 16.0, *)
class SenderImagePdfPlusNextPageViewController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate, UIDocumentPickerDelegate, UITextFieldDelegate {
    
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
    @IBOutlet weak var uploadFileLabel: UILabel!
    @IBOutlet weak var logoutView: UIView!
    @IBOutlet weak var changeRolesView: UIView!
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
    @IBOutlet weak var helpView: UIView!
    @IBOutlet weak var textFieldBaseview: UIView!
    @IBOutlet weak var textViewBaseview: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    let imagePicker = UIImagePickerController()
    var SelectedAssets = [PHAsset]()
    var photoArray = [UIImage]()
    var arrSelectedFilePath: [Any] = []
    var urls: URL!
    var resiveMenuId: String!
    var backGroungImageUrl: String!
    var SmallImageUrl: String!
    var addWebUrl: String!
    var priority: String!
    var fileType: String!
    var AddImage: [URL] = []
    var TotalAws: String!
    var imagePdfId = "5"
    var cologLog: String!
    var MobileNumber: String!
    var password: String!
    let maxLenghth = 500
    var str: [String] = []
    var strName: [String] = []
    var pdfData: Data? = nil
    var is_read_enabled = ""
    var is_write_enabled = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        sideMenuView.isHidden = true
        
        let defaults = UserDefaults.standard
        priority = defaults.string(forKey: DefaultsKeys.priority)
        cologLog = defaults.string(forKey: DefaultsKeys.colglogo)
        MobileNumber = defaults.string(forKey: DefaultsKeys.mobileNumber)
        password = defaults.string(forKey: DefaultsKeys.Password)
        
        bigImg.sd_setImage(with: URL(string: backGroungImageUrl), placeholderImage: UIImage(named: "ic_white"))
        smallImg.sd_setImage(with: URL(string: SmallImageUrl), placeholderImage: UIImage(named: "ic_white"))
        topMessageLabel.text = defaults.string(forKey: DefaultsKeys.memberName)
        clgLogoImg.sd_setImage(with: URL(string: cologLog), placeholderImage: UIImage(named: "EmptyCollegeIcon"))
        
        textFieldBaseview.layer.cornerRadius = 10
        textFieldBaseview.layer.borderWidth = 1
        textFieldBaseview.layer.borderColor = UIColor.lightGray.cgColor
        
        textViewBaseview.layer.cornerRadius = 10
        textViewBaseview.layer.borderWidth = 1
        textViewBaseview.layer.borderColor = UIColor.lightGray.cgColor
        
        descripitionTextField.text = "Enter the Description"
        descripitionTextField.textColor = UIColor.lightGray
        descripitionTextField.returnKeyType = .default
        descripitionTextField.addDoneBtn()
        descripitionTextField.delegate = self
        
        titleTextField.returnKeyType = .done
        titleTextField.delegate = self
        
        if priority == "p1" {
            tapBarView.backgroundColor = UIColor(named: "Principal")
            topLabels.text = "Principal"
        } else if priority == "p4" {
            topLabels.text = "Student"
        } else if priority == "p2" {
            tapBarView.backgroundColor = UIColor(named: "Teaching Staff")
            topLabels.text = "Hod"
        } else if priority == "p7" {
            tapBarView.backgroundColor = UIColor(named: "univercityColorCod")
            topLabels.text = "University Head"
        } else if priority == "p5" {
            topLabels.text = "Father"
        } else if priority == "p3" {
            tapBarView.backgroundColor = UIColor(named: "Teaching Staff")
            topLabels.text = "Teacher"
        }
        
        let cancelV = UITapGestureRecognizer(target: self, action: #selector(CancelVc))
        cancelView.addGestureRecognizer(cancelV)
        
        let select = UITapGestureRecognizer(target: self, action: #selector(selectVc))
        selectRespinsView.addGestureRecognizer(select)
        
        let loginRediectGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        redirectLoginView.addGestureRecognizer(loginRediectGesture)
        
        let tapToUpload = UITapGestureRecognizer(target: self, action: #selector(GalleryVc))
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
        
        let privacyPolicyGesture = UITapGestureRecognizer(target: self, action: #selector(privacyPolicyRedirect))
        privacyPolicyView.addGestureRecognizer(privacyPolicyGesture)
        
        let termsAndConditionGesture = UITapGestureRecognizer(target: self, action: #selector(termsAndCondition))
        termsAndConditionView.addGestureRecognizer(termsAndConditionGesture)
        
        let chagePassword = UITapGestureRecognizer(target: self, action: #selector(changePassowrdVC))
        changePasswordView.addGestureRecognizer(chagePassword)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if descripitionTextField.text == "Enter the Description" {
            descripitionTextField.text = ""
            descripitionTextField.textColor = UIColor.black
        }
    }

    func textViewDidChange(_ textView: UITextView) {
        lblCount.text = "\(descripitionTextField.text.count)/\(maxLenghth)"
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (descripitionTextField.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        if text == "\n" {
            descripitionTextField.resignFirstResponder()
        }
        return numberOfChars <= 500
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
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        guard let Frame  = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        let keyboardHeight = Frame.height + 10
        
        scrollView.contentInset.bottom = keyboardHeight
        scrollView.verticalScrollIndicatorInsets.bottom = keyboardHeight
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset.bottom = 0
        scrollView.verticalScrollIndicatorInsets.bottom = 0
    }

    @IBAction func CancelVc() {
        dismiss(animated: true)
    }

    @IBAction func selectVc() {
        if priority == "p1" {
            if titleTextField.text == "" {
                let refreshAlert = UIAlertController(title: "", message: "Kindly Enter Title", preferredStyle: .alert)
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in }))
                present(refreshAlert, animated: true, completion: nil)
            } else if descripitionTextField.text == "Enter the Description" {
                let refreshAlert = UIAlertController(title: "", message: "Kindly Enter Description ", preferredStyle: .alert)
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in }))
                present(refreshAlert, animated: true, completion: nil)
            } else if descripitionTextField.text == "" {
                let refreshAlert = UIAlertController(title: "", message: "Kindly Enter Details Description ", preferredStyle: .alert)
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in }))
                present(refreshAlert, animated: true, completion: nil)
            } else if uploadFileLabel.text == "Upload Files" {
                let refreshAlert = UIAlertController(title: "", message: "Kindly Select Image Or Pdf ", preferredStyle: .alert)
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in }))
                present(refreshAlert, animated: true, completion: nil)
            } else {
                let vc = SelectResipientsViewController(nibName: nil, bundle: nil)
                vc.awsurl = TotalAws
                vc.fileType = fileType
                vc.resivre = imagePdfId
                vc.titlesTextField = titleTextField.text
                vc.discreptionss = descripitionTextField.text
                vc.photoArray = photoArray
                vc.str = str
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                vc.strName = strName
                vc.pdfData = pdfData
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true, completion: nil)
            }
        } else if priority == "p3" {
            if titleTextField.text == "" {
                let refreshAlert = UIAlertController(title: "", message: "Kindly Enter Title ", preferredStyle: .alert)
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in }))
                present(refreshAlert, animated: true, completion: nil)
            } else if descripitionTextField.text == "Enter the Description" {
                let refreshAlert = UIAlertController(title: "", message: "Kindly Enter Description ", preferredStyle: .alert)
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in }))
                present(refreshAlert, animated: true, completion: nil)
            } else if descripitionTextField.text == "" {
                let refreshAlert = UIAlertController(title: "", message: "Kindly Enter Details Description ", preferredStyle: .alert)
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in }))
                present(refreshAlert, animated: true, completion: nil)
            } else if uploadFileLabel.text == "Upload Files" {
                let refreshAlert = UIAlertController(title: "", message: "Kindly Select Image Or Pdf", preferredStyle: .alert)
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in }))
                present(refreshAlert, animated: true, completion: nil)
            } else {
                let vc = HodRespienViewController(nibName: nil, bundle: nil)
                vc.resivre = imagePdfId
                vc.imageFileType = fileType
                vc.titlesTextField = titleTextField.text
                vc.discreptionss = descripitionTextField.text
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                vc.awsurl = TotalAws
                vc.pdfData = pdfData
                vc.photoArray = photoArray
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true, completion: nil)
            }
        } else if priority == "p7" {
            if titleTextField.text == "" {
                let refreshAlert = UIAlertController(title: "", message: "Kindly Enter Title ", preferredStyle: .alert)
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in }))
                present(refreshAlert, animated: true, completion: nil)
            } else if descripitionTextField.text == "Enter the Description" {
                let refreshAlert = UIAlertController(title: "", message: "Kindly Enter Description ", preferredStyle: .alert)
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in }))
                present(refreshAlert, animated: true, completion: nil)
            } else if descripitionTextField.text == "" {
                let refreshAlert = UIAlertController(title: "", message: "Kindly Enter Details Description ", preferredStyle: .alert)
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in }))
                present(refreshAlert, animated: true, completion: nil)
            } else if uploadFileLabel.text == "Upload Files" {
                let refreshAlert = UIAlertController(title: "", message: "Kindly Select Image Or Pdf", preferredStyle: .alert)
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in }))
                present(refreshAlert, animated: true, completion: nil)
            } else {
                let vc = GroupHeadViewController(nibName: nil, bundle: nil)
                vc.resivre = imagePdfId
                vc.awsurl = TotalAws
                vc.imageFileType = fileType
                vc.titlesTextField = titleTextField.text
                vc.discreptionss = descripitionTextField.text
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                vc.pdfData = pdfData
                vc.photoArray = photoArray
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true, completion: nil)
            }
        } else if priority == "p2" {
            if titleTextField.text == "" {
                let refreshAlert = UIAlertController(title: "", message: "Kindly Enter Title", preferredStyle: .alert)
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in }))
                present(refreshAlert, animated: true, completion: nil)
            } else if descripitionTextField.text == "Enter the Description" {
                let refreshAlert = UIAlertController(title: "", message: "Kindly Enter Description ", preferredStyle: .alert)
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in }))
                present(refreshAlert, animated: true, completion: nil)
            } else if descripitionTextField.text == "" {
                let refreshAlert = UIAlertController(title: "", message: "Kindly Enter Details Description ", preferredStyle: .alert)
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in }))
                present(refreshAlert, animated: true, completion: nil)
            } else if uploadFileLabel.text == "Upload Files" {
                let refreshAlert = UIAlertController(title: "", message: "Kindly Select Image Or Pdf ", preferredStyle: .alert)
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in }))
                present(refreshAlert, animated: true, completion: nil)
            } else {
                let vc = HodSelectResipenceViewController(nibName: nil, bundle: nil)
                vc.resivre = imagePdfId
                vc.ImagePdfAws = TotalAws
                vc.fileType = fileType
                vc.titlesTextField = titleTextField.text
                vc.discreptionss = descripitionTextField.text
                vc.str = str
                vc.strName = strName
                vc.pdfData = pdfData
                vc.photoArray = photoArray
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true, completion: nil)
            }
        }
    }

    @IBAction func adLoad() {
        let vc = SendercomuniAddViewController(nibName: nil, bundle: nil)
        vc.AddWebUrl = addWebUrl
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }

    @IBAction func backbtn(_ sender: Any) {
        dismiss(animated: true)
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
        let refreshAlert = UIAlertController(title: "", message: "Are you sure do you want to logout", preferredStyle: .alert)
        refreshAlert.addAction(UIAlertAction(title: "YES", style: .default, handler: { _ in
            UserDefaults.standard.removeObject(forKey: DefaultsKeys.mobileNumber)
            let vc = LoginVc(nibName: nil, bundle: nil)
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }))
        refreshAlert.addAction(UIAlertAction(title: "NO", style: .cancel, handler: { _ in
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
        KRProgressHUD.show()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            KRProgressHUD.dismiss()
        }
    }

    @IBAction func notificationVc() {
        print("NotificationViewController")
        let vc = NotificationViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }

    @IBAction func menu() {
        if sideMenuView.isHidden == true {
            sideMenuView.isHidden = false
            print("menuVisble")
        } else {
            sideMenuView.isHidden = true
        }
    }

    @IBAction func changePassowrdVC() {
        let vc = ChangePasswordVC(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }

    @IBAction func priorityVc() {
        let vc = PriorityScreenVC(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }

    @IBAction func GalleryVc() {
        var galaryid = "2"
        fileType = galaryid
        photoArray.removeAll()
        SelectedAssets.removeAll()
        arrSelectedFilePath.removeAll()
        pdfData?.removeAll()
        uploadFileLabel.text = "Upload Files"
        let alert = UIAlertController(title: "Add Photo", message: "", preferredStyle: .actionSheet)
        for i in ["Document", "Gallery", "Take a Photo"] {
            alert.addAction(UIAlertAction(title: i, style: .default, handler: choose_image_handler))
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func choose_image_handler(action: UIAlertAction) {
        print(action.title!)
        if action.title!.elementsEqual("Take a Photo") {
            print("camera")
            open_camera()
        } else if action.title!.elementsEqual("Gallery") {
            print("gallery")
            open_gallery()
        } else if action.title!.elementsEqual("Document") {
            choosePdfVc()
        } else {
            let optionMenu = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
            self.present(optionMenu, animated: true, completion: nil)
        }
    }

    func open_camera() {
        photoArray.removeAll()
        SelectedAssets.removeAll()
        arrSelectedFilePath.removeAll()
        pdfData?.removeAll()
        if UIImagePickerController.availableCaptureModes(for: .rear) != nil {
            let camera_controller = CameraViewController { [weak self] image, asset in
                self!.photoArray.append(image! as UIImage)
                let x: Int = self!.photoArray.count
                let myString = String(x)
                self!.uploadFileLabel.text = "number of file selected :" + myString
                self?.dismiss(animated: true, completion: nil)
            }
            present(camera_controller, animated: true, completion: nil)
        } else {
            noCamera()
        }
    }

    func noCamera() {
        let alertVC = UIAlertController(title: "No Camera", message: "Sorry, this device has no camera", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
    }

    func open_gallery() {
        photoArray.removeAll()
        SelectedAssets.removeAll()
        arrSelectedFilePath.removeAll()
        pdfData?.removeAll()
        print("1")
        let imagePicker = ImagePickerController()
        imagePicker.settings.selection.max = 3
        imagePicker.settings.fetch.assets.supportedMediaTypes = [.image]
        presentImagePicker(imagePicker, animated: true, select: { (_: PHAsset) -> Void in
        }, deselect: { (_: PHAsset) -> Void in
        }, cancel: { (_: [PHAsset]) -> Void in
        }, finish: { (assets: [PHAsset]) -> Void in
            
            for i in 0..<assets.count {
                let resource = PHAssetResource.assetResources(for: assets[i]).first
                let name = resource?.originalFilename
                let PicsLocalPath = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(name!)
                self.arrSelectedFilePath.append(PicsLocalPath)
                self.AddImage.append(PicsLocalPath)
                let x: Int = self.arrSelectedFilePath.count
                let myString = String(x)
                self.uploadFileLabel.text = "number of file selected :" + myString
                self.SelectedAssets.append(assets[i])
            }
            self.convertAssetToImages()
        })
    }

    func convertAssetToImages() {
        if SelectedAssets.count != 0 {
            for i in 0..<SelectedAssets.count {
                let manager = PHImageManager.default()
                let option = PHImageRequestOptions()
                var thumbnail = UIImage()
                option.isSynchronous = true
                manager.requestImage(for: SelectedAssets[i], targetSize: CGSize(width: 200, height: 200), contentMode: .aspectFill, options: option, resultHandler: { (result, _) -> Void in
                    thumbnail = result!
                })
                let data = thumbnail.jpegData(compressionQuality: 0.7)
                let newImage = UIImage(data: data!)
                self.photoArray.append(newImage! as UIImage)
            }
            let x: Int = self.photoArray.count
            let myString = String(x)
            self.uploadFileLabel.text = "number of file selected :" + myString
            print("photoArray.count", photoArray)
        }
        print("complete phto array \(self.photoArray)")
    }

    @IBAction func TakePhotoVc() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    @IBAction func choosePdfVc() {
        let pdftype = "3"
        fileType = pdftype
        clickFunction()
    }

    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        print("urldsss", url)
        let fileurl: URL = url as URL
        let filename = url.lastPathComponent
        let fileextension = url.pathExtension
        print("URL: \(fileurl)", "NAME: \(filename)", "EXTENSION: \(fileextension)")
        urls = fileurl
        let _ = NSData(contentsOf: url)
        do {
            pdfData = try Data(contentsOf: url, options: NSData.ReadingOptions())
            self.uploadFileLabel.text = "number of file selected :" + "1"
        } catch {
            print("set PDF filer error : ", error)
            let refreshAlert = UIAlertController(title: "", message: "set PDF filer error", preferredStyle: .alert)
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in }))
        }
    }

    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("view was cancelled")
        dismiss(animated: true, completion: nil)
    }

    func clickFunction() {
        photoArray.removeAll()
        SelectedAssets.removeAll()
        arrSelectedFilePath.removeAll()
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.pdf], asCopy: true)
        documentPicker.delegate = self
        documentPicker.modalPresentationStyle = .formSheet
        self.present(documentPicker, animated: true, completion: nil)
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return range.location <= 99
    }
}
