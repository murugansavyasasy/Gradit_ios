//
//  SubmitionViewController.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 30/03/23.
//

import UIKit
import KRProgressHUD
import DropDown
import UniformTypeIdentifiers
import ALCameraViewController
import BSImagePicker
import Photos
import ObjectMapper
import AWSCore
import AWSS3




@available(iOS 16.0, *)
class SubmitionViewController: UIViewController,UIImagePickerControllerDelegate & UINavigationControllerDelegate ,UIDocumentPickerDelegate,UITextViewDelegate{

@IBOutlet weak var topNameview: UIView!
@IBOutlet weak var tapBarView: UIViewX!
@IBOutlet weak var uploadFileLabel: UILabel!
@IBOutlet weak var cancelView: UIViewX!
@IBOutlet weak var sendView: UIViewX!
@IBOutlet weak var selectTypeLabel: UILabel!
@IBOutlet weak var assigmentDropDownView: UIViewX!
@IBOutlet weak var descriptionTextView: UITextView!
@IBOutlet weak var uploadView: RectangularDashedView!
@IBOutlet weak var lblCount: UILabel!
@IBOutlet weak var loginView: UIView!
@IBOutlet weak var topLabels: UILabel!
@IBOutlet weak var profileView: UIView!
@IBOutlet weak var viewTap: UIView!
@IBOutlet weak var clgLogoImg: UIImageView!
@IBOutlet weak var topMessageLabel: UILabel!
@IBOutlet weak var redirectLoginView: UIViewX!
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


var urls : URL!
var awsArry : [String] = []
var fileType : String!
var awscountShowing : [String] = []
var assigmentImagPdf : [assigmentImagePdfResponce] = []
var addapiRef : [AddDataDeatils] = []
var loginDatas : [datalogin]!
var logindataprinci :[datalogin]!
var addImageBackGroundurl : String!
var imageWebUrl : String!
var smallImageUrl  : String!
var image_choose: Bool = false
var image = UIImagePickerController()
var selectedImageUrl: URL!
var SelectedAssets = [PHAsset]()
var photoArray = [UIImage]()
var arrSelectedFilePath : [Any] = []
let maxLenghth = 500
var drop : String!
let dropDown = DropDown()
var memberId : String!
var priority : String!
var colgId : String!
var deptid : String!
var sectionid : String!
var course : String!
var Progressid : String!
var assigmentId : String!
var PreviousAddId : Int = 0
var mobileNumber : String!
var password : String!
var colgImg : String!
var str : [String] = []
var strName : [String] = []
var imagePicker = UIImagePickerController()
var currentImageCount = 0
var totalImageCount = 0
var originalImagesArray = [UIImage]()
var absoluteStringImg : String!
var imageUrlArray = NSMutableArray()
var convertedImagesUrlArray = NSMutableArray()
var pdfData : NSData? = nil

override func viewDidAppear(_ animated: Bool) {
    
    print("kljjjjjjjjj")
    
    PreviousAddId = PreviousAddId+1
    
    print("jkkkkkkk",PreviousAddId)
    
}
    
override func viewDidLoad() {
    super.viewDidLoad()
    
    print("hghghghghg",selectTypeLabel.text)
    print("fr4fdfe",descriptionTextView.text)
    
    sideMenuView.isHidden = true
    uploadView.isHidden = true
    overrideUserInterfaceStyle = .light
    PreviousAddId = PreviousAddId+1
    
    let defaults = UserDefaults.standard
    
    memberId = defaults.string(forKey: DefaultsKeys.memberid)
    priority = defaults.string(forKey: DefaultsKeys.priority)
    colgId = defaults.string(forKey: DefaultsKeys.collegeid)
    deptid = defaults.string(forKey: DefaultsKeys.deptid)
    sectionid = defaults.string(forKey: DefaultsKeys.sectionid)
    course = defaults.string(forKey: DefaultsKeys.courseid)
    mobileNumber = defaults.string(forKey: DefaultsKeys.mobileNumber)
    
    topMessageLabel.text = defaults.string(forKey: DefaultsKeys.memberName)
    
    password = defaults.string(forKey: DefaultsKeys.Password)
    
    colgImg = defaults.string(forKey: DefaultsKeys.colglogo)
    clgLogoImg.sd_setImage(with: URL(string:  colgImg), placeholderImage: UIImage(named: "person.fill"))
    
    print("tgidfgdfghjkjhgh",Progressid)
    
    descriptionTextView.text = "Enter the Description"
    descriptionTextView.textColor = UIColor.lightGray
    
    descriptionTextView.returnKeyType = .done
    descriptionTextView.delegate = self
    
    if priority == "p1"{
        
        view.backgroundColor = UIColor(named: "Principal" )
        topLabels.text = "Principal"
    } else if priority == "p4"{
        tapBarView.backgroundColor = UIColor(named: "StudentParent" )
        topLabels.text = "Student"
        
    }else if priority == "p2" {
        
        view.backgroundColor = UIColor(named: "Teaching Staff" )
        topLabels.text = "Hod"
        
    }else if priority == "p5"{
        view.backgroundColor = UIColor(named: "FatherColor" )
        tapBarView.backgroundColor = UIColor(named: "FatherColor" )
        topLabels.text = "Father"
        
    }else if priority == "p3"{
        view.backgroundColor = UIColor(named: "Teaching Staff" )
        topLabels.text = "Teacher"
        
    }else if priority == "p6"{
        
        topLabels.text = "Non Teaching"
    }
    
    addApi()
    
    let selectDropDown =   UITapGestureRecognizer(target: self, action: #selector(selectedDropVc))
    
    assigmentDropDownView.addGestureRecognizer(selectDropDown)
    
    let tapToUpload =   UITapGestureRecognizer(target: self, action: #selector(AssigmentuploadImage))
    
    uploadView.addGestureRecognizer(tapToUpload)
    
    let send =   UITapGestureRecognizer(target: self, action: #selector(sendVc))
    
    sendView.addGestureRecognizer(send)
    
    let profileGesture = UITapGestureRecognizer(target: self, action: #selector(profileRedirect))
    profileView.addGestureRecognizer(profileGesture)
    
    
    let changeRolesGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
    changeRolesView.addGestureRecognizer(changeRolesGesture)
    
    
    let topname = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
    topNameview.addGestureRecognizer(topname)
    
    
    let logoutGesture = UITapGestureRecognizer(target: self, action: #selector(logoutPressed))
    loginView.addGestureRecognizer(logoutGesture)
    
    let loginRediectGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
    redirectLoginView.addGestureRecognizer(loginRediectGesture)
    
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
    
    let cancel = UITapGestureRecognizer(target: self, action: #selector(CancelVc))
    cancelView.addGestureRecognizer(cancel)
      
}


@objc func dismissKeyboards() {
    
    sideMenuView.isHidden = true
    view.endEditing(true)
    
}


func textViewDidBeginEditing(_ textView: UITextView) {
    if descriptionTextView.text == "Enter the Description" {
        descriptionTextView.text = ""
        descriptionTextView.textColor = UIColor.black
        
    }
}

func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    if text == "\n" {
        descriptionTextView.resignFirstResponder()
    }
    return true
}

func textViewDidEndEditing(_ textView: UITextView) {
    if descriptionTextView.text == "" {
        descriptionTextView.text = "Enter the Description"
        descriptionTextView.textColor = UIColor.lightGray
        
    }
}


@IBAction func CancelVc(){
    
    dismiss(animated: true)
    
}


@IBAction func selectedDropVc(){
    
    let  myArray = ["PDF","Image"]
    
    dropDown.dataSource = myArray//4
    dropDown.anchorView = assigmentDropDownView //5
    
    dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
    
    dropDown.direction = .bottom
    DropDown.appearance().backgroundColor = UIColor.white
    dropDown.show() //7
    
    dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
        print("Selected item: \(item) at index: \(index)")
        self.selectTypeLabel.text = item
        
        drop = item
        
        if item == "PDF"{
            uploadView.isHidden = false
            
        }else if item == "Image"{
            
            uploadView.isHidden = false
           
        }
    }
}




func addApi(){
    
    var add = AddApiModal()
    
    let defaults = UserDefaults.standard
    var deviceToken = defaults.string(forKey:DefaultsKeys.DeviceToken )
    add.device_token = deviceToken
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
                    
                    let singleTap = adds(target: self, action: #selector(tapDetected))
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

@objc func tapDetected(gesture : AddGustersssss) {
    
    let vc = AddEventsViewController(nibName: nil, bundle: nil)
    vc.addWebUrl = gesture.urlss
    vc.modalPresentationStyle = .fullScreen
    present(vc, animated: true,completion: nil)
    
}



@IBAction  func sendVc() {
    
    
    print("selectTypeLabel.text",selectTypeLabel.text)
    
    if  ((selectTypeLabel.text! == "selectType")){
        
        let refreshAlert = UIAlertController(title: "", message: "Kindly Select Type", preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            
        }))
        present(refreshAlert, animated: true, completion: nil)
        
    }else if  (descriptionTextView.text! == "Enter the Description"){
        
        let refreshAlert = UIAlertController(title: "", message: "Kindly Enter Description", preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            
        }))
        present(refreshAlert, animated: true, completion: nil)
    }else if  (descriptionTextView.text! == ""){
        
        
        let refreshAlert = UIAlertController(title: "", message: "Kindly Enter Description", preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            
            
            
        }))
        present(refreshAlert, animated: true, completion: nil)
    }
    
    
    else if uploadFileLabel.text ==  "Upload Files" {
        
        
        let refreshAlert = UIAlertController(title: "", message: "Kindly Pick Image Or Pdf", preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            
        }))
        present(refreshAlert, animated: true, completion: nil)
    }
    
    
    else{
        
        
        let refreshAlert = UIAlertController(title: "Hold on!!", message: "Are you Sure You Want To Submit ?", preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "YES", style: .default, handler: { [self] (action: UIAlertAction!) in
            
            
            if drop == "PDF"{
                
                uploadPDFFileToAWS(pdfData : pdfData!)
                
            }
            
            else if drop == "Image"{
                
                getImageURL(images: photoArray)
                
                DispatchQueue.main.asyncAfter(deadline: .now()+4.3) { [self] in
                    KRProgressHUD.dismiss()
                    
                    
                    assigmentImagePdf(ImageArry: awsArry)
                }
                
            }
            
        }))
        
        
        refreshAlert.addAction(UIAlertAction(title: "NO", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        present(refreshAlert, animated: true, completion: nil)
        
    }
    
}

@IBAction  func AssigmentuploadImage() {
    print("kklllllclllf",photoArray.count)
    SelectedAssets.removeAll()
    photoArray.removeAll()
    print("kklllllclllf",photoArray.count)
    arrSelectedFilePath.removeAll()
    
    uploadFileLabel.text = "Upload Files"
    
    
    if drop == "PDF"{
        
        clickFunction()
        
    }else if drop == "Image"{
        
        print("uploafdImage")
        let image =  "image"
        
        fileType = image
        let alert = UIAlertController(title: "Add Photo", message: "", preferredStyle: .actionSheet)
        
        for i in ["Gallery", "Take a Photo"] {
            
            alert.addAction(UIAlertAction(title: i, style: .default, handler: choose_image_handler))
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
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
    
    else {
        
        let optionMenu = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        
        self.present(optionMenu, animated: true, completion: nil)
        
    }
     
}


func open_camera(){
    
    photoArray.removeAll()
    arrSelectedFilePath.removeAll()
    
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
          }       else {
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
    SelectedAssets.removeAll()
    
    let imagePicker = ImagePickerController()
    
    imagePicker.settings.selection.max = 3
    
    imagePicker.settings.fetch.assets.supportedMediaTypes = [.image]
    
    presentImagePicker(imagePicker, animated: true, select:{ (asset: PHAsset) -> Void in
        
    }, deselect: { (assets : PHAsset) -> Void in
        
    }, cancel: {(assets: [PHAsset]) -> Void in
        
    }, finish: {(assets: [PHAsset]) -> Void in
        
        
        self.image_choose = true
        
        for i in 0..<assets.count {
            
            let resource = PHAssetResource.assetResources(for: assets[i]).first
            
            let name = resource?.originalFilename
            
            let PicsLocalPath = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(name!)
            
            
            self.arrSelectedFilePath.append(PicsLocalPath)
            
            print("path",PicsLocalPath)
            
            print("vfdcdcfvcdxfcdxfcdx",self.arrSelectedFilePath.count)
            let x : Int =  self.arrSelectedFilePath.count
            let myString = String(x)
            print("myStringmyString",myString)
            self.uploadFileLabel.text = "number of file selected :" + myString
            //
            
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
        
        
        
        print("photoArray.count" ,photoArray)
        
        
        
    }
    
    
    
    print("complete phto array \(self.photoArray)")
    
    
    
}


@IBAction  func TakePhotoVc() {
    
    
    
    
    
    if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
        image.sourceType = UIImagePickerController.SourceType.camera
        
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


    func assigmentImagePdf(ImageArry : [String]){
        
        print("ffggfdsfcdsad", ImageArry.count)
        
        var imageAryy : [filenamesss] = []
        
        for i in ImageArry{
            var imageAws = filenamesss()
            imageAws.FileName = i
            
            imageAryy.append(imageAws)
        }
        
        var imagePdf = sendAssigmentModal()
        
        imagePdf.assignmentid = assigmentId
        imagePdf.filetype = fileType
        imagePdf.colgid = colgId
        imagePdf.description = descriptionTextView.text
        imagePdf.processby = memberId
        imagePdf.FileNameArray = imageAryy
        
        print("yearAndSectionModalStr", imagePdf)
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.SubmitAssignmentFromAppWithCloudURL,
            httpMethod: .post,
            queryParam: nil,
            requestBody: imagePdf
        ) { [weak self] (result: Result<sndAssigmentResponce, Error>) in
            
            guard let self = self else { return }
            
            switch result {
                
            case .success(let particularss):
                
                if particularss.Status == 1 {
                    
                    print("uiiuiiooo")
                    
                    let refreshAlert = UIAlertController(title: "", message: particularss.Message, preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] (action: UIAlertAction!) in
                        
                        guard let self = self else { return }
                        
                        if priority == "p4"{
                            
                            print("ytytyytyty")
                            let vc = AssigmentHomePageViewController(nibName: nil, bundle: nil)
                            vc.str  = str
                            vc.strName = strName
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true)
                            
                        }
                        
                        else if priority == "p5"{
                            
                            let vc = AssigmentHomePageViewController(nibName: nil, bundle: nil)
                            vc.view.backgroundColor = UIColor(named: "FatherColor")
                            vc.assigmentSegmentName.backgroundColor = UIColor(named: "FatherUnselector")
                            vc.assigmentSegmentName.selectedSegmentTintColor = UIColor(named: "FatherSelector")
                            vc.str  = str
                            vc.strName = strName
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true)
                        }
                        
                    }))
                    
                    self.present(refreshAlert, animated: true, completion: nil)
                    
                    self.reloadInputViews()
                    
                }
                else{
                    
                    let refreshAlert = UIAlertController(title: "", message: particularss.Message, preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] (action: UIAlertAction!) in
                        
                        guard let self = self else { return }
                        
                        if priority == "p4"{
                            let vc = AssigmentHomePageViewController(nibName: nil, bundle: nil)
                            vc.str  = str
                            vc.strName = strName
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true)
                        }
                        
                        else if priority == "p5"{
                            
                            let vc = AssigmentHomePageViewController(nibName: nil, bundle: nil)
                            vc.view.backgroundColor = UIColor(named: "FatherColor")
                            vc.assigmentSegmentName.backgroundColor = UIColor(named: "FatherUnselector")
                            vc.assigmentSegmentName.selectedSegmentTintColor = UIColor(named: "FatherSelector")
                            vc.str  = str
                            vc.strName = strName
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true)
                        }
                        
                    }))
                    
                    self.present(refreshAlert, animated: true, completion: nil)
                }
                
                self.reloadInputViews()
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }



// Upload Image To Aws File.

func getImageURL(images : [UIImage]){
    self.originalImagesArray = images
    self.totalImageCount = images.count
    if currentImageCount < images.count{
        uploadAWS(image: images[currentImageCount])
        print("uploadAWS",self.uploadAWS)
    }
}
    
func uploadAWS(image: UIImage) {
        
        KRProgressHUD.show()
        
        let defaults = UserDefaults.standard
        let colgId = defaults.string(forKey: DefaultsKeys.collegeid) ?? ""
        
        // Create file
        let fileName = "vc_\(Date().timeIntervalSince1970).jpg"
        let fileURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
        
        guard let data = image.jpegData(compressionQuality: 0.9) else {
            KRProgressHUD.dismiss()
            return
        }
        
        do {
            try data.write(to: fileURL)
        } catch {
            KRProgressHUD.dismiss()
            print("File write error:", error)
            return
        }
        
        // Step 1: Get presigned URL
        AWSPreSignedURL.shared.fetchPresignedURL(
            bucket: DefaultsKeys.S3BucketName,
            fileName: fileURL,
            bucketPath: colgId,
            fileType: "image"
        ) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
                
            case .success(let awsResponse):
                
                let presignedURL = awsResponse.data?.presignedUrl ?? ""
                let fileUrl = awsResponse.data?.fileUrl ?? ""   // ✅ IMPORTANT
                
                print("Presigned URL:", presignedURL)
                print("Final File URL:", fileUrl)
                
                // Step 2: Upload
                AWSUploadManager.shared.uploadImageToAWS(
                    image: image,
                    presignedURL: presignedURL
                ) { result in
                    
                    DispatchQueue.main.async {
                        
                        switch result {
                            
                        case .success(_):
                            
                            print("Upload success")
                            
                            // ✅ STORE FINAL URL (NOT presigned URL)
                            self.awsArry.append(fileUrl)
                            
                            let imageDict = NSMutableDictionary()
                            imageDict["FileName"] = fileUrl
                            self.imageUrlArray.add(imageDict)
                            
                        case .failure(let error):
                            print("Upload failed:", error.localizedDescription)
                            KRProgressHUD.dismiss()
                            return
                        }
                        
                        // 🔁 Next image
                        self.currentImageCount += 1
                        
                        if self.currentImageCount < self.totalImageCount {
                            self.getImageURL(images: self.originalImagesArray)
                        } else {
                            print("All uploads done:", self.imageUrlArray)
                            self.convertedImagesUrlArray = self.imageUrlArray
                            KRProgressHUD.dismiss()
                        }
                    }
                }
                
            case .failure(let error):
                KRProgressHUD.dismiss()
                print("Presigned URL error:", error.localizedDescription)
            }
        }
    }


// AWS PDF Upload Part
    
    func uploadPDFFileToAWS(pdfData: NSData) {
        
        KRProgressHUD.show()
        
        let defaults = UserDefaults.standard
        let colgId = defaults.string(forKey: DefaultsKeys.collegeid) ?? ""
        
        // Create temp file
        let fileName = "vc_\(Date().timeIntervalSince1970).pdf"
        let fileURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
        
        do {
            try pdfData.write(to: fileURL)
        } catch {
            KRProgressHUD.dismiss()
            print("PDF write error:", error)
            return
        }
        
        print("PDF Local URL:", fileURL)
        
        // Step 1: Get presigned URL
        AWSPreSignedURL.shared.fetchPresignedURL(
            bucket: DefaultsKeys.S3BucketName,
            fileName: fileURL,
            bucketPath: colgId,
            fileType: "application"   // keep same as your sample
        ) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
                
            case .success(let awsResponse):
                
                let presignedURL = awsResponse.data?.presignedUrl ?? ""
                let fileUrl = awsResponse.data?.fileUrl ?? ""   // ✅ FINAL URL
                
                print("Presigned URL:", presignedURL)
                print("Final File URL:", fileUrl)
                
                guard !presignedURL.isEmpty else {
                    KRProgressHUD.dismiss()
                    return
                }
                
                // Step 2: Upload PDF
                AWSUploadManager.shared.uploadPDFAWSUsingPresignedURL(
                    pdfData: pdfData as Data,
                    presignedURL: presignedURL
                ) { result in
                    
                    DispatchQueue.main.async {
                        
                        switch result {
                            
                        case .success(_):
                                
                            print("PDF uploaded successfully")
                            
                            // ✅ Store FINAL URL
                            self.awsArry.append(fileUrl)
                            
                            let imageDict = NSMutableDictionary()
                            imageDict["FileName"] = fileUrl
                            self.imageUrlArray.add(imageDict)
                            
                            self.convertedImagesUrlArray = self.imageUrlArray
                            
                            // 🔁 Your existing API call
                            self.assigmentImagePdf(ImageArry: [fileUrl])
                            
                            KRProgressHUD.dismiss()
                            
                        case .failure(let error):
                            KRProgressHUD.dismiss()
                            print("Upload failed:", error.localizedDescription)
                        }
                    }
                }
                
            case .failure(let error):
                KRProgressHUD.dismiss()
                print("Presigned URL error:", error.localizedDescription)
            }
        }
    }

// upload Pdf in aws Part

public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
    
    print("urldsss",url)
    
    let fileurl: URL = url as URL
    let filename = url.lastPathComponent
    let fileextension = url.pathExtension
    print("URL: \(fileurl)", "NAME: \(filename)", "EXTENSION: \(fileextension)")
    
    urls = fileurl
    
    
    let imageData = NSData(contentsOf: url)
    
    
    do {
        pdfData = try NSData(contentsOf: url, options: NSData.ReadingOptions())
        
        
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
    
    let documentPicker =  UIDocumentPickerViewController(documentTypes: ["com.adobe.pdf"], in: .import)
    
    documentPicker.delegate = self
    documentPicker.modalPresentationStyle = .formSheet
    
    
    
    self.present(documentPicker, animated: true, completion: nil)
}











@IBAction func backBtn(_ sender: Any) {
    
    dismiss(animated: true)
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
        let vc = PriorityViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
    }


func textViewDidChange(_ textView: UITextView) {
    lblCount.text = "\(maxLenghth - descriptionTextView.text.count)/"+"\(500)"
    
    
    
    
}



}
class AddGustersssss : UITapGestureRecognizer{

var urlss : String!




}

