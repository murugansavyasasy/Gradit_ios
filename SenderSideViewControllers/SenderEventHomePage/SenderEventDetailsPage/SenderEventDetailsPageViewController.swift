//
//  SenderEventDetailsPageViewController.swift
//  GraditSenderEventMenu
//
//  Created by MACBOOKPRO on 02/12/22.
//

import UIKit
import ObjectMapper
import SDWebImage
import KRProgressHUD
import ALCameraViewController
import BSImagePicker
import Photos
import AWSCore
import AWSS3

@available(iOS 16.0, *)
class SenderEventDetailsPageViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

@IBOutlet weak var tapBarView: UIViewX!

@IBOutlet weak var editView: UIViewX!
@IBOutlet weak var redirectLoginView: UIViewX!


@IBOutlet weak var confirmView: UIViewX!
@IBOutlet weak var addView: UIViewX!


@IBOutlet weak var notificationView: UIView!
@IBOutlet weak var smallImg: UIImageView!
@IBOutlet weak var bigImg: UIImageView!

@IBOutlet weak var topMessageLabel: UILabel!
@IBOutlet weak var clgLogoImg: UIImageView!


@IBOutlet weak var logoutView: UIView!

@IBOutlet weak var changeRolesView: UIView!


@IBOutlet weak var profileView: UIView!



@IBOutlet weak var changePasswordView: UIView!



@IBOutlet weak var termsAndConditionView: UIView!

@IBOutlet weak var helpView: UIView!


@IBOutlet weak var topLabels: UILabel!

@IBOutlet weak var viewTap: UIView!



@IBOutlet weak var faqView: UIView!


@IBOutlet weak var privacyPolicyView: UIView!


@IBOutlet weak var refreshView: UIView!



@IBOutlet weak var sideMenuView: UIView!






@IBOutlet weak var venueLabel: UILabel!
@IBOutlet weak var topicLabel: UILabel!

@IBOutlet weak var imageCollectionView: UICollectionView!

@IBOutlet weak var dateLabel: UILabel!

var viewBgColor : String!

@IBOutlet weak var bodyLabel: UILabel!

@IBOutlet weak var timeLabel: UILabel!

@IBOutlet weak var noImageLabel: UILabel!

@IBOutlet weak var noImageView: UIView!
var identifers = "SenderEventCollectionViewCell"

var image_choose: Bool = false


var selectedImageUrl: URL!

var SelectedAssets = [PHAsset]()

var photoArray = [UIImage]()

var arrSelectedFilePath : [Any] = []
var image = UIImagePickerController()
var AwsUrl : String!

var backGroundImageUrl : String!
var smallImageUrl : String!
var addWebUrl : String!

var venuestr : String!
var topistrs  : String!
var datestr  : String!
var timestr  : String!
var bodystr  : String!

var sendImageEvent : [sendImageEventDataDetails] = []
var addapiRef : [AddDataDeatils] = []
var filePath : [String] = []

var AwsfilePath : [String] = []

var priority : String!

var meberID : String!

var memberName : String!

var colgImg : String!

var coldId : String!

var userId : String!

var headerId : String!

var TotalAws : String!

var loginDatas : [datalogin]!
var logindataprinci :[datalogin]!

var MobileNumber : String!

var password : String!

var AddButtonId : String = "0"

var previousAdId : String!

var str : [String] = []

var strName : [String] = []

var eventCreaderId : String!
var currentImageCount = 0
var totalImageCount = 0
var originalImagesArray = [UIImage]()
var absoluteStringImg : String!
var imageUrlArray = NSMutableArray()
var convertedImagesUrlArray = NSMutableArray()
var is_read_enabled = ""
var is_write_enabled = ""

override func viewDidLoad() {
    super.viewDidLoad()
    overrideUserInterfaceStyle = .light
    print("header",headerId)
    
    
    confirmView.isHidden = true
    
    let defaults = UserDefaults.standard
    memberName = defaults.string(forKey: DefaultsKeys.memberName)
    meberID = defaults.string(forKey: DefaultsKeys.memberid)
    coldId = defaults.string(forKey: DefaultsKeys.collegeid)
    priority = defaults.string(forKey: DefaultsKeys.priority)
    colgImg = defaults.string(forKey: DefaultsKeys.colglogo)
    clgLogoImg.sd_setImage(with: URL(string:  colgImg), placeholderImage: UIImage(named: "person.fill"))
    userId = defaults.string(forKey: DefaultsKeys.memberid)
    password = defaults.string(forKey: DefaultsKeys.Password)
    MobileNumber = defaults.string(forKey: DefaultsKeys.Password)
    
    topMessageLabel.text = memberName
    
    bigImg.sd_setImage(with: URL(string: backGroundImageUrl), placeholderImage: UIImage(named: "ic_white"))
    
    
    smallImg.sd_setImage(with: URL(string: smallImageUrl), placeholderImage: UIImage(named: "ic_white"))
    
    
    sideMenuView.isHidden = true
    
    
    print("venueLabelvenueLabel",venuestr)
    print("dateLabeldateLabel",datestr)
    venueLabel.text = venuestr
    dateLabel.text = datestr
    timeLabel.text = timestr
    bodyLabel.text = bodystr
    topicLabel.text = topistrs
    
    
    
    if eventCreaderId == meberID{
        
        
        editView.isHidden = false
        
    }
    
    else{
        
        
        
        editView.isHidden = true
    }
    
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
    
    else if priority == "p5"{
        
        
        topLabels.text = "Father"
        
        
        
    }
    
    else if priority == "p3"{
        tapBarView.backgroundColor = UIColor(named: "Teaching Staff" )
        topLabels.text = "Teacher"
        
    }
    else if priority == "p7"{
        tapBarView.backgroundColor = UIColor(named: "univercityColorCod" )
        topLabels.text = "University Head"
        
    }
    
    
    let rowNib = UINib(nibName: identifers, bundle: nil)
    imageCollectionView.register(rowNib, forCellWithReuseIdentifier: identifers)
    
    imageCollectionView.delegate = self
    imageCollectionView.dataSource = self
    
    noImageView.isHidden = true
    noImageLabel.isHidden = true
    
    if filePath.count == 0 {
        
        
        noImageView.isHidden = false
        noImageLabel.isHidden = false
        
        
    }
    
    
    let singleTap = UITapGestureRecognizer(target: self, action: #selector(adLoad))
    
    bigImg.isUserInteractionEnabled = true
    bigImg.addGestureRecognizer(singleTap)
    
    let Edit = UITapGestureRecognizer(target: self, action: #selector(EditVc))
    editView.addGestureRecognizer(Edit)
    
    
    // tap Bar UiTapGuster.
    
    
    
    
    let confirmGesture = UITapGestureRecognizer(target: self, action: #selector(confirmViewVc))
    confirmView.addGestureRecognizer(confirmGesture)
    
    
    let addImage = UITapGestureRecognizer(target: self, action: #selector(addImageEventView))
    addView.addGestureRecognizer(addImage)
    
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
    //
    
    let privacyPolicyGesture = UITapGestureRecognizer(target: self, action: #selector(privacyPolicyRedirect))
    privacyPolicyView.addGestureRecognizer(privacyPolicyGesture)
    
    let termsAndConditionGesture = UITapGestureRecognizer(target: self, action: #selector(termsAndCondition))
    termsAndConditionView.addGestureRecognizer(termsAndConditionGesture)
    
    
    
    
    let chagePassword = UITapGestureRecognizer(target: self, action: #selector(changePassowrdVC))
    changePasswordView.addGestureRecognizer(chagePassword)
    
    
    
    
    
    
    
}






@IBAction func EditVc(){
    
    
    if priority == "p2" || priority == "p3" {
        
        let vc = PlusNewTextViewControllerViewController(nibName: nil, bundle: nil)
        vc.smallImageUrl =  smallImageUrl
        vc.backGroundImageUrl = backGroundImageUrl
        vc.addWebUrl = addWebUrl
        vc.menuId = "13"
        vc.editTitle = topistrs
        
        vc.editVenu = venuestr
        vc.editDiscreption = bodystr
        vc.strName = strName
        vc.str = str
        vc.dateStr = datestr
        vc.TimeStr = timestr
        vc.eventHeaderId = headerId
        
        vc.is_read_enabled = is_read_enabled
        vc.is_write_enabled = is_write_enabled
        vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
        
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true , completion: nil)
        
    }
    
    
    else if priority == "p7" {
        
        let vc = PlusNewTextViewControllerViewController(nibName: nil, bundle: nil)
        vc.smallImageUrl =  smallImageUrl
        vc.backGroundImageUrl = backGroundImageUrl
        vc.addWebUrl = addWebUrl
        vc.menuId = "13"
        vc.editTitle = topistrs
        
        vc.editVenu = venuestr
        vc.editDiscreption = bodystr
        vc.strName = strName
        vc.str = str
        vc.dateStr = datestr
        vc.TimeStr = timestr
        vc.eventHeaderId = headerId
        
        vc.is_read_enabled = is_read_enabled
        vc.is_write_enabled = is_write_enabled
        vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
        
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true , completion: nil)
        
    }
    
    else{
        
        let vc = PlusNewTextViewControllerViewController(nibName: nil, bundle: nil)
        vc.smallImageUrl = smallImageUrl
        vc.backGroundImageUrl = backGroundImageUrl
        vc.addWebUrl = addWebUrl
        vc.editTitle = topistrs
        
        vc.editVenu = venuestr
        vc.editDiscreption = bodystr
        vc.dateStr = datestr
        vc.TimeStr = timestr
        
        vc.menuId = "13"
        vc.strName = strName
        vc.str = str
        vc.eventHeaderId = headerId
        
        vc.is_read_enabled = is_read_enabled
        vc.is_write_enabled = is_write_enabled
        vc.view.backgroundColor = UIColor(named: "Principal" )
        
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true , completion: nil)
        
    }
    
    
    
    
}

@IBAction func confirmViewVc(){
    
    
    
    
}



@IBAction func addImageEventView( ){
    
    
    let AddimagId = "1"
    
    AddButtonId = AddimagId
    
    
    let alert = UIAlertController(title: "Add Photo", message: "", preferredStyle: .actionSheet)
    
    for i in ["Camera", "Gallery"] {
        
        alert.addAction(UIAlertAction(title: i, style: .default, handler: choose_image_handler))
        
    }
    
    
    
    alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
    
    
    self.present(alert, animated: true, completion: nil)
    
    
    
    
    
    
    
}




@IBAction func adLoad( ){
    
    
    let vc = TotalAddLoadPageViewController(nibName: nil, bundle: nil)
    
    vc.AddWebUrl = addWebUrl
    
    vc.modalPresentationStyle = . fullScreen
    present(vc, animated: true,completion: nil)
    
    
}


@IBAction func backbtn(_ sender: Any) {
    
    dismiss(animated: true)
}



func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return filePath.count
    
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifers, for: indexPath) as!
    
    SenderEventCollectionViewCell
    
    
    
    
    
    
    cell.cellImageView.sd_setImage(with: URL(string: filePath[indexPath.row]), placeholderImage: UIImage(named: "placeHolder.png"))
    
    
    
    
    
    return cell
}



func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    
    let vc = SenderImageViewController(nibName: nil, bundle: nil)
    
    
    vc.imgfilePath = filePath[indexPath.row]
    
    
    
    
    vc.modalPresentationStyle = .fullScreen
    present(vc, animated: true, completion: nil)
    
    
}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.size.width / 3, height:100)
    
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
    let currentController = self.getCurrentViewController()
    currentController?.present(vc, animated: false, completion: nil)
    
    //        vc.modalPresentationStyle = .fullScreen
    
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
    let currentController = self.getCurrentViewController()
    currentController?.present(vc, animated: true, completion: nil)
    
    
    
}

    @IBAction func priorityVc() {
        
        let vc = PriorityViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
    }



// imageUploadPart .




func choose_image_handler(action: UIAlertAction){
    
    
    
    print(action.title!)
    
    if ((action.title!.elementsEqual("Camera"))){
        
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
    SelectedAssets.removeAll()
    
    if UIImagePickerController.availableCaptureModes(for: .rear) != nil {
        let camera_controller = CameraViewController
        
        
        { [weak self] image, asset in
            
            
            
            self!.photoArray.append(image! as UIImage)
            
            self!.getImageURL(images: self!.photoArray)
            
            DispatchQueue.main.asyncAfter(deadline: .now()+4.3) { [self] in
                
                KRProgressHUD.dismiss()
                
                
                self!.eventSendImage()
                
                
                
            }
            
            
            
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
    
    
    
    imagePicker.settings.selection.max = 5
    
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
            
            
            print("vfdcdcfvcdxfcdxfcdx",self.arrSelectedFilePath)
            
            
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
        
        
        
        
        
        
        
        getImageURL(images: photoArray)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1.3) { [self] in
            
            KRProgressHUD.dismiss()
            
            
            eventSendImage()
            
            
            
        }
        
        
        
    }
    
    
    
    print("complete phto array \(self.photoArray)")
    
    
    
}


func getImageURL(images : [UIImage]){
    self.originalImagesArray = images
    self.totalImageCount = images.count
    if currentImageCount < images.count{
        uploadAWS(image: images[currentImageCount])
        
    }
}



//
func uploadAWS(image : UIImage){
    
    
    
    
    KRProgressHUD.show()
    
    
    
    var colgId : String!
    let defaults = UserDefaults.standard
    colgId = defaults.string(forKey: DefaultsKeys.collegeid)
    
    let S3BucketName =  DefaultsKeys.S3BucketName
    let CognitoPoolID =  DefaultsKeys.CognitoPoolID
    let Region = AWSRegionType.APSouth1
    
    let credentialsProvider = AWSCognitoCredentialsProvider(regionType:Region,identityPoolId:CognitoPoolID)
    let configuration = AWSServiceConfiguration(region:Region, credentialsProvider:credentialsProvider)
    AWSServiceManager.default().defaultServiceConfiguration = configuration
    
    let currentTimeStamp = NSString.init(format: "%ld",Date() as CVarArg)
    let imageNameWithoutExtension = NSString.init(format: "vc_%@",currentTimeStamp)
    let imageName = NSString.init(format: "%@%@",imageNameWithoutExtension, ".jpg")
    let dateFormatter = DateFormatter()
    
    dateFormatter.dateFormat = "dd-MM-yyyy"
    
    let  currentDate =   dateFormatter.string(from: Date())
    
    
    
    
    
    
    let ext = imageName as String
    
    let fileName = imageNameWithoutExtension
    let fileType = ".jpg"
    
    let imageURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(ext)
    let data = image.jpegData(compressionQuality: 0.9)
    do {
        try data?.write(to: imageURL)
    }
    catch {}
    
    print(imageURL)
    
    let uploadRequest = AWSS3TransferManagerUploadRequest()
    uploadRequest?.body = imageURL
    uploadRequest?.key = colgId + "/" + currentDate +  "/" + "File_" + ext
    uploadRequest?.bucket = S3BucketName
    uploadRequest?.contentType = ".jpg"
    
    
    // upload
    
    let transferManager = AWSS3TransferManager.default()
    transferManager.upload(uploadRequest!).continueWith { [self] (task) -> AnyObject? in
        
        if let error = task.error {
            print("Upload failed : (\(error))")
            KRProgressHUD.dismiss()
        }
        
        if task.result != nil {
            
            let url = AWSS3.default().configuration.endpoint.url
            let publicURL = url?.appendingPathComponent((uploadRequest?.bucket!)!).appendingPathComponent((uploadRequest?.key!)!)
            if  let absoluteString = publicURL?.absoluteString {
                print("Uploaded to:\(absoluteString)")
                
                print("Uploaded to:\(absoluteString)")
                
                absoluteStringImg = absoluteString
                AwsfilePath.append(absoluteStringImg)
                
                self.TotalAws = self.AwsfilePath.joined(separator: ",")
                let imageDict = NSMutableDictionary()
                imageDict["FileName"] = absoluteString
                self.imageUrlArray.add(imageDict)
                self.currentImageCount = self.currentImageCount + 1
                if self.currentImageCount < self.totalImageCount{
                    DispatchQueue.main.async {
                        self.getImageURL(images: self.originalImagesArray)
                    }
                }else{
                    self.convertedImagesUrlArray = self.imageUrlArray
                    
                    
                }
                
                
                
                //                    
            }
        }
        else {
            KRProgressHUD.dismiss()
            print("Unexpected empty result.")
        }
        return nil
    }
    
    
    
    
    
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
    
    func eventSendImage(){

        let refreshAlert = UIAlertController(title: "", message: "Are Your Sure Want to Submit ? ", preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in
            
            var evenimageName = FileNames()
            evenimageName.FileName = TotalAws
            
            print("printttt", evenimageName.FileName)
            
            var eventImagess = EventImageModal()
            eventImagess.collegeid = coldId
            eventImagess.Userid = userId
            eventImagess.eventheaderid = headerId
            eventImagess.FileNameArray = [evenimageName]
            
            print("noriceEnier", eventImagess)
            
            APiCallManager.shared.callApi(
                url: APIEndpoints.AddeventphotosWithCloudURL,
                httpMethod: .post,
                queryParam: nil,
                requestBody: eventImagess
            ) { [weak self] (result: Result<EventImageSendResponce, Error>) in
                
                guard let self = self else { return }
                
                switch result {
                    
                case .success(let particularss):
                    
                    if particularss.Status == 1{
                        
                        self.sendImageEvent = particularss.data ?? []
                        
                        let refreshAlert = UIAlertController(title: "", message: particularss.Message, preferredStyle: UIAlertController.Style.alert)
                        
                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] (action: UIAlertAction!) in
                            
                            guard let self = self else { return }
                            
                            if priority == "p2" || priority == "p3" {
                                
                                let vc = SenderEventHomePageViewController(nibName: nil, bundle: nil)
                                vc.is_read_enabled = is_read_enabled
                                vc.is_write_enabled = is_write_enabled
                                vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                                vc.eventSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                                vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                                vc.str  = str
                                vc.strName = strName
                                vc.modalPresentationStyle = .fullScreen
                                self.present(vc, animated: true , completion: nil)
                            } else if priority == "p7" {
                                
                                let vc = SenderEventHomePageViewController(nibName: nil, bundle: nil)
                                vc.view.backgroundColor = UIColor(named: "univercityColorCod")
                                vc.eventSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                                vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                                vc.str  = str
                                vc.strName = strName
                                vc.modalPresentationStyle = .fullScreen
                                self.present(vc, animated: true , completion: nil)
                            }
                            else{
                                
                                let vc = SenderEventHomePageViewController(nibName: nil, bundle: nil)
                                vc.is_read_enabled = is_read_enabled
                                vc.is_write_enabled = is_write_enabled
                                vc.view.backgroundColor = UIColor(named: "Principal")
                                vc.eventSegmentName.backgroundColor = UIColor(named: "UnSelector")
                                vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "Selector")
                                vc.str  = str
                                vc.strName = strName
                                vc.modalPresentationStyle = .fullScreen
                                self.present(vc, animated: true , completion: nil)
                            }
                            
                        }))
                        
                        self.present(refreshAlert, animated: true, completion: nil)
                        
                        self.imageCollectionView.delegate = self
                        self.imageCollectionView.dataSource = self
                        self.imageCollectionView.reloadData()
                    }
                    
                    else{
                        
                        let refreshAlert = UIAlertController(title: "", message: particularss.Message , preferredStyle: UIAlertController.Style.alert)
                        
                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                            
                            UserDefaults.standard.removeObject(forKey: DefaultsKeys.mobileNumber)
                            
                        }))
                        
                        self.present(refreshAlert, animated: true, completion: nil)
                        
                        self.imageCollectionView.delegate = self
                        self.imageCollectionView.dataSource = self
                        self.imageCollectionView.reloadData()
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "CANCEL", style: .default, handler: { [self] (action: UIAlertAction!) in
            
        }))
        
        self.present(refreshAlert, animated: true, completion: nil)
    }

}


