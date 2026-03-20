//
//  VideoPlusPageViewController.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 02/03/23.
//

import UIKit
import KRProgressHUD
import Alamofire
import ObjectMapper
import CoreMedia
import AVFoundation

protocol VideoPlusPageViewControllerDelegate: AnyObject {
    func vimeouploaderSucces(_ response: [String: Any], methodName: String)
    func failedResponse(_ error: Error)
    
    func vimeouploaderError(_ error: Error, methodName: String)
}


@available(iOS 16.0, *)
class VideoPlusPageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextViewDelegate,UITextFieldDelegate, URLSessionDelegate,URLSessionTaskDelegate,URLSessionDataDelegate{
    
    
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var tapBarView: UIViewX!
    @IBOutlet weak var uploadfileNameLabel: UILabel!
    @IBOutlet weak var redirectLoginView: UIViewX!
    @IBOutlet weak var videoTitelText: UITextField!
    @IBOutlet weak var cancelView: UIViewX!
    @IBOutlet weak var videoDiscreption: UITextView!
    @IBOutlet weak var smallImg: UIImageView!
    @IBOutlet weak var uploadView: RectangularDashedView!
    @IBOutlet weak var bigImg: UIImageView!
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
    @IBOutlet weak var helpView: UIView!
    @IBOutlet weak var confirmView: UIViewX!
    
    var IFrameLink : String!
    var memberId : String!
    var priority : String!
    var memberName : String!
    var colgImg : String!
    var addImageBackGroundurl : String!
    var imageWebUrl : String!
    var smallImageUrl  : String!
    var videoMenuId : String!
    var videourl : URL!
    var videe : String!
    var mobileNumber : String!
    var GetVimeoData : VimeoData!
    var getVimeoEmbed : VimeoEmbed!
    var VimeoURL : URL!
    var videoSize : Int!
    var iframes : String!
    var videoUploadUrl : String!
    var is_read_enabled = ""
    var is_write_enabled = ""
    var uploadTask: URLSessionUploadTask!
    var password : String!
    var loginDatas : [datalogin]!
    var logindataprinci :[datalogin]!
    let maxLenghth = 500
    var VimeoIframe : String!
    var VimeoVideoUrl : String!
    var VideoSucessId = 0
    var authToken = ""
    var str : [String] = []
    var strName : [String] = []
    weak var delegate: VideoPlusPageViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        
        print("authTokenauthToken",authToken)
        bigImg.sd_setImage(with: URL(string: addImageBackGroundurl), placeholderImage: UIImage(named: "ic_white"))
        
        smallImg.sd_setImage(with: URL(string: smallImageUrl ), placeholderImage: UIImage(named: "ic_white"))
        
        sideMenuView.isHidden = true
        
        let defaults = UserDefaults.standard
        
        priority = defaults.string(forKey: DefaultsKeys.priority)
        
        memberName = defaults.string(forKey: DefaultsKeys.memberName)
        
        colgImg = defaults.string(forKey: DefaultsKeys.colglogo)
        
        clgLogoImg.sd_setImage(with: URL(string:  colgImg), placeholderImage: UIImage(named: "person.fill"))
        
        password = defaults.string(forKey: DefaultsKeys.Password)
        
        topMessageLabel.text = memberName
        
        mobileNumber  = defaults.string(forKey: DefaultsKeys.mobileNumber)
        
        authToken = defaults.string(forKey: DefaultsKeys.vimeoAccessToken)!
        print("authTokenauthToken11111",authToken)
        if priority == "p1"{
            
            view.backgroundColor = UIColor(named: "Principal" )
            
            tapBarView.backgroundColor = UIColor(named: "Principal" )
            
            topLabels.text = "Principal"
        }else if priority == "p7" {
            
            tapBarView.backgroundColor = UIColor(named: "univercityColorCod" )
            view.backgroundColor = UIColor(named: "univercityColorCod" )
            topLabels.text = "university Head"
            
        }else if priority == "p4"{
            
            topLabels.text = "Student"
            
        }else if priority == "p2"{
            
            view.backgroundColor = UIColor(named: "Teaching Staff" )
            
            tapBarView.backgroundColor = UIColor(named: "Teaching Staff" )
            
            topLabels.text = "Hod"
            
        }else if priority == "p3"{
            
            view.backgroundColor = UIColor(named: "Teaching Staff" )
            
            tapBarView.backgroundColor = UIColor(named: "Teaching Staff" )
            
            topLabels.text = "Teacher"
            
        }else if priority == "p5"{
            
            topLabels.text = "Father"
            
        }
        
        videoDiscreption.text = "Enter the Description"
        videoDiscreption.textColor = UIColor.lightGray
        videoDiscreption.returnKeyType = .done
        videoDiscreption.delegate = self
        videoTitelText.returnKeyType = .done
        videoTitelText.delegate = self
        
        let uploadviewss = UITapGestureRecognizer(target: self, action: #selector(uploadViewVc))
        
        uploadView.addGestureRecognizer(uploadviewss)
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(adLoad))
        
        bigImg.isUserInteractionEnabled = true
        
        bigImg.addGestureRecognizer(singleTap)
        
        
        let cancel = UITapGestureRecognizer(target: self, action: #selector(CancelVc))
        
        cancelView.addGestureRecognizer(cancel)
        
        let changeRolesGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        
        changeRolesView.addGestureRecognizer(changeRolesGesture)
        
        let loginRediectGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        
        redirectLoginView.addGestureRecognizer(loginRediectGesture)
        
        let logoutGesture = UITapGestureRecognizer(target: self, action: #selector(logoutPressed))
        
        logoutView.addGestureRecognizer(logoutGesture)
        
        let confirmGesture = UITapGestureRecognizer(target: self, action: #selector(ConfirmVc))
        
        confirmView.addGestureRecognizer(confirmGesture)
        
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
        
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        videoTitelText.resignFirstResponder()
        return true
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if videoDiscreption.text == "Enter the Description" {
            
            videoDiscreption.text = ""
            
            videoDiscreption.textColor = UIColor.black
             
        }
        
    }
    
    
    
    func textViewDidChange(_ textView: UITextView) {
        
        lblCount.text = "\(maxLenghth - videoDiscreption.text.count)/"+"\(500)"
        
    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let newText = (videoDiscreption.text as NSString).replacingCharacters(in: range, with: text)
        
        let numberOfChars = newText.count
        
        if text == "\n" {
            
            videoDiscreption.resignFirstResponder()
            
        }
        
        return numberOfChars < 500
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if videoDiscreption.text == "" {
            
            videoDiscreption.text = "Enter the Description"
            
            videoDiscreption.textColor = UIColor.lightGray
            
        }
        
    }
    
    
    @IBAction func CancelVc() {
        
        dismiss(animated: true)
        
    }
    
    
    @IBAction func ConfirmVc() {
        
        if   videoTitelText.text == ""{
            
            let refreshAlert = UIAlertController(title: "", message: "Kindly Enter Title", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
            }))
            
            present(refreshAlert, animated: true, completion: nil)
            
        } else if videoDiscreption.text == "Enter the Description"{
            
            let refreshAlert = UIAlertController(title: "", message: "Kindly Enter Description", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
            }))
            
            present(refreshAlert, animated: true, completion: nil)
            
        } else if videoDiscreption.text == ""{
            
            let refreshAlert = UIAlertController(title: "", message: "Kindly Enter Description", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
            }))
            
            present(refreshAlert, animated: true, completion: nil)
            
        } else if VimeoURL == nil{
            
            let refreshAlert = UIAlertController(title: "", message: "Kindly Upload Video", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
                
                UserDefaults.standard.removeObject(forKey: DefaultsKeys.mobileNumber)
                
            }))
            
            present(refreshAlert, animated: true, completion: nil)
            
        } else{
            
            if priority == "p1"{
                
                let vc = SelectResipientsViewController(nibName: nil, bundle: nil)
                
                vc.resivre = videoMenuId
                vc.videoVimeoUrl = videe
                vc.videoIframe = IFrameLink
                vc.discreptionss = videoDiscreption.text
                vc.titlesTextField = videoTitelText.text
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.modalPresentationStyle = .fullScreen
                
                present(vc, animated: true,completion: nil)
                
            }else if priority == "p2"{
                
                
                let vc = HodSelectResipenceViewController(nibName: nil, bundle: nil)
                
                vc.resivre = videoMenuId
                vc.videoUrl = videe
                vc.iframeUrl = IFrameLink
                vc.discreptionss = videoDiscreption.text
                vc.titlesTextField = videoTitelText.text
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                vc.modalPresentationStyle = .fullScreen
                
                present(vc, animated: true,completion: nil)
                
            }else if priority == "p3"{
                
                let vc = HodRespienViewController(nibName: nil, bundle: nil)
                
                vc.resivre = videoMenuId
                vc.videoURL = videe
                vc.videoIframe = IFrameLink
                vc.discreptionss = videoDiscreption.text
                vc.titlesTextField = videoTitelText.text
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true)
            }
            
            else if priority == "p7"{
                
                let vc = GroupHeadViewController(nibName: nil, bundle: nil)
                
                vc.resivre = videoMenuId
                vc.videoURL = videe
                vc.videoIframe = IFrameLink
                vc.discreptionss = videoDiscreption.text
                vc.titlesTextField = videoTitelText.text
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true)
                
            }
        }
    }
   
    
    @IBAction func adLoad(){
        
        let vc = TotalAddLoadPageViewController(nibName: nil, bundle: nil)
        
        vc.AddWebUrl = imageWebUrl
        
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true,completion: nil)
        
    }
    
    @IBAction func  uploadViewVc(){
        
        if   videoTitelText.text == ""{
            
            let refreshAlert = UIAlertController(title: "", message: "Kindly Enter Title", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
            }))
            
            
            present(refreshAlert, animated: true, completion: nil)
            
        } else if videoDiscreption.text == "Enter the Description"{
            
            
            
            let refreshAlert = UIAlertController(title: "", message: "Kindly Enter Description", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
            }))
            
            present(refreshAlert, animated: true, completion: nil)
        }else if videoDiscreption.text == ""{
            
            let refreshAlert = UIAlertController(title: "", message: "Kindly Enter Description", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
            }))
            
            
            present(refreshAlert, animated: true, completion: nil)
            
        } else{
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = .photoLibrary
            //    imagePickerController.mediaTypes = [kUTTypeMovie as String, kUTTypeVideo as String]
            imagePickerController.mediaTypes = [
                UTType.movie.identifier,
                UTType.video.identifier
            ]
            
            present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let url = info[.mediaURL] as? URL {
            // Handle the selected video URL here
            print("oplddd",url)
            
            
            VimeoURL = url
            
            videoSize = url.pathComponents.count
            
            uploadVideo(authToken: authToken, videoFilePath: url)
            
            
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    enum UploadResult {
        case success(String)
        case failure(Error)
    }
    
    func getFileSize(at url: URL) -> UInt64? {
        do {
            let attributes = try FileManager.default.attributesOfItem(atPath: url.path)
            if let fileSize = attributes[FileAttributeKey.size] as? UInt64 {
                return fileSize
            }
        } catch {
            print("Error: \(error)")
        }
        return nil
    }
    
//    func createVimeoUploadURL(authToken: String, videoFilePath: URL, completion: @escaping (UploadResult) -> Void) {
//        
//        KRProgressHUD.show(withMessage: "Uploading Video....")
//        
//        //        KRProgressHUD.show()
//        guard let fileSize = getFileSize(at: videoFilePath) else {
//            completion(.failure(NSError(domain: "com.vimeo", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unable to get file size"])))
//            return
//        }
//        
//        let headers: HTTPHeaders = [
//            "Authorization": "Bearer \(authToken)",
//            "Content-Type": "application/json",
//            "Accept": "application/vnd.vimeo.*+json;version=3.4"
//        ]
//        
//        let parameters: [String: Any] = [
//            "upload": [
//                "approach": "tus",
//                "size": "\(fileSize)" // Use the actual video file size
//            ],
//            "name": videoTitelText.text, // Replace with actual video name
//            "description": videoDiscreption.text // Replace with actual video description
//            
//        ]
//        
//        AF.request("https://api.vimeo.com/me/videos", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
//            .responseJSON { [self] response in
//                switch response.result {
//                case .success(let value):
//                    print("Vimeo API Response: \(value)") // Print the full JSON
//                    if let json = value as? [String: Any],
//                       let upload = json["upload"] as? [String: Any],
//                       let uploadLink = upload["upload_link"] as? String {
//                        
//                        let embedUrl = json["player_embed_url"] as! String
//                        
//                        let embed = json["embed"]! as AnyObject
//                        IFrameLink = embed["html"]  as! String
//                        videe = embedUrl as! String
//                        print("videe = embedUrl",videe)
//                        print("IFrameLink",IFrameLink)
//                        
//                        VideoSucessId = 1
//                        VideoStatus()
//                        completion(.success(uploadLink))
//                        
//                        
//                    } else {
//                        completion(.failure(NSError(domain: "com.vimeo", code: -1, userInfo: [NSLocalizedDescriptionKey: "Upload link not found"])))
//                        
//                        VideoSucessId = 0
//                        VideoStatus()
//                    }
//                case .failure(let error):
//                    completion(.failure(error))
//                    
//                    
//                    VideoSucessId = 0
//                    VideoStatus()
//                }
//            }
//    }
    
    func createVimeoUploadURL(authToken: String, videoFilePath: URL, completion: @escaping (UploadResult) -> Void) {
        
        KRProgressHUD.show(withMessage: "Uploading Video....")
        
        guard let fileSize = getFileSize(at: videoFilePath) else {
            completion(.failure(NSError(domain: "com.vimeo", code: -1,
                                        userInfo: [NSLocalizedDescriptionKey: "Unable to get file size"])))
            return
        }
        
        // URL
        guard let url = URL(string: "https://api.vimeo.com/me/videos") else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1)))
            return
        }
        
        // Request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/vnd.vimeo.*+json;version=3.4", forHTTPHeaderField: "Accept")
        
        // Body
        let parameters: [String: Any] = [
            "upload": [
                "approach": "tus",
                "size": "\(fileSize)"
            ],
            "name": videoTitelText.text ?? "",
            "description": videoDiscreption.text ?? ""
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            completion(.failure(error))
            return
        }
        
        // URLSession Call
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            
            guard let self = self else { return }
            
            if let error = error {
                DispatchQueue.main.async {
                    self.VideoSucessId = 0
                    self.VideoStatus()
                    completion(.failure(error))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self.VideoSucessId = 0
                    self.VideoStatus()
                    completion(.failure(NSError(domain: "No data", code: -1)))
                }
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                print("Vimeo API Response:", json ?? [:])
                
                if let upload = json?["upload"] as? [String: Any],
                   let uploadLink = upload["upload_link"] as? String {
                    
                    let embedUrl = json?["player_embed_url"] as? String ?? ""
                    
                    if let embed = json?["embed"] as? [String: Any] {
                        self.IFrameLink = embed["html"] as? String
                    }
                    
                    self.videe = embedUrl
                    
                    DispatchQueue.main.async {
                        self.VideoSucessId = 1
                        self.VideoStatus()
                        completion(.success(uploadLink))
                    }
                    
                } else {
                    DispatchQueue.main.async {
                        self.VideoSucessId = 0
                        self.VideoStatus()
                        completion(.failure(NSError(domain: "Upload link not found", code: -1)))
                    }
                }
                
            } catch {
                DispatchQueue.main.async {
                    self.VideoSucessId = 0
                    self.VideoStatus()
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }
    
    func uploadVideoToVimeo(uploadLink: String, videoFilePath: URL, authToken: String, chunkSize: Int = 5 * 1024 * 1024, completion: @escaping (UploadResult) -> Void) {
        guard let fileHandle = try? FileHandle(forReadingFrom: videoFilePath) else {
            completion(.failure(NSError(domain: "com.vimeo", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unable to read video file"])))
            return
        }
        print("fileHandleBefore",fileHandle)
        var offset: Int = 0
        let fileSize = fileHandle.seekToEndOfFile()
        fileHandle.seek(toFileOffset: 0)
        
        print("fileHandleBefore",fileHandle)
        func uploadNextChunk() {
            let chunkData = fileHandle.readData(ofLength: chunkSize)
            
            if chunkData.isEmpty {
                fileHandle.closeFile()
                completion(.success(("")))
                return
            }
            
            var request = URLRequest(url: URL(string: uploadLink)!)
            request.httpMethod = "PATCH"
            request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
            request.setValue("application/offset+octet-stream", forHTTPHeaderField: "Content-Type")
            request.setValue("\(offset)", forHTTPHeaderField: "Upload-Offset")
            request.setValue("1.0.0", forHTTPHeaderField: "Tus-Resumable")
            request.httpBody = chunkData
            
            let uploadTask = URLSession.shared.uploadTask(with: request, from: chunkData) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 204 {
                        offset += chunkSize
                        uploadNextChunk()
                    } else if httpResponse.statusCode == 412 {
                        // Handle 412 error (precondition failed), retry or get correct offset from server
                        if let rangeHeader = httpResponse.value(forHTTPHeaderField: "Upload-Offset"), let serverOffset = Int(rangeHeader) {
                            offset = serverOffset
                            uploadNextChunk()
                        } else {
                            let error = NSError(domain: "com.vimeo", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to upload chunk: Precondition Failed"])
                            completion(.failure(error))
                        }
                    } else {
                        let error = NSError(domain: "com.vimeo", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to upload chunk, status code: \(httpResponse.statusCode)"])
                        completion(.failure(error))
                    }
                }
            }
            
            uploadTask.resume()
        }
        
        uploadNextChunk()
    }
    
    
    func VideoStatus(){
        
        if VideoSucessId == 0 {
            
            uploadfileNameLabel.text = "Upload Files"
        }else{
            
            uploadfileNameLabel.text = "Selected video count : 1"
        }
        
    }
    func uploadVideo(authToken: String, videoFilePath: URL) {
        createVimeoUploadURL(authToken: authToken, videoFilePath: videoFilePath) { [self] result in
            switch result {
            case .success(let uploadLink):
                uploadVideoToVimeo(uploadLink: uploadLink, videoFilePath: videoFilePath, authToken: authToken) { [self] result in
                    
                    
                    switch result {
                    case .success:
                        print("Video uploaded successfully!")
                        KRProgressHUD.dismiss()
                        
                    case .failure(let error):
                        print("Failed to upload video: \(error)")
                        //                VideoSucessId = 0
                        KRProgressHUD.dismiss()
                        let refreshAlert = UIAlertController(title: "", message: "Failed to upload video", preferredStyle: UIAlertController.Style.alert)
                        
                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in
                            
                            //                            uploadfileNameLabel.text = "Upload Files"
                            
                            
                        }))
                        
                        
                        present(refreshAlert, animated: true, completion: nil)
                        
                        
                        
                    }
                    
                    
                }
            case .failure(let error):
                print("Failed to create upload URL: \(error)")
                //        VideoSucessId = 0
                KRProgressHUD.dismiss()
                let refreshAlert = UIAlertController(title: "", message: "Failed to upload video", preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in
                    //                    uploadfileNameLabel.text = "Upload Files"
                }))
                
                
                present(refreshAlert, animated: true, completion: nil)
                
                
            }
        }
    }   //VimeoVideoUploadProcess End Srn :
    
    
    
    
    @IBAction func backbtn(_ sender: Any) {
        
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
        
        vc.modalPresentationStyle = .fullScreen
        
        let currentController = self.getCurrentViewController()
        
        currentController?.present(vc, animated: false, completion: nil)
        
    }
    
    
    @IBAction func menu() {
        
        if sideMenuView.isHidden == true{
            
            sideMenuView.isHidden = false
            
            print("menuVisble")
            
        } else{
            
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
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return range.location <= 99
    }
    
}

