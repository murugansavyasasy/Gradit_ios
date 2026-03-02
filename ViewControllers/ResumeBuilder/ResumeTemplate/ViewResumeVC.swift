//
//  ViewResumeVC.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 02/06/25.
//

import UIKit
import WebKit
import ObjectMapper

class ViewResumeVC: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var BackView: UIView!
    @IBOutlet weak var BackBtn: UIButton!
    @IBOutlet weak var ResueImg: UIImageView!
    @IBOutlet weak var CancelBtn: UIButton!
    @IBOutlet weak var ProceedBtn: UIButton!
    @IBOutlet weak var Webview: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var PopupView: UIView!
    @IBOutlet weak var Popuptopview: UIView!
    @IBOutlet weak var SaveResumeLbl: UILabel!
    @IBOutlet weak var popupcloseBtn: UIButton!
    @IBOutlet weak var NameresumeLbl: UILabel!
    @IBOutlet weak var nameField: PaddedTextField!
    @IBOutlet weak var Switch: UISwitch!
    @IBOutlet weak var MarkdefaultLbl: UILabel!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var downloadBtn: UIButton!
    @IBOutlet weak var PopupContainerview: UIView!
    @IBOutlet weak var viewResumeLbl: UILabel!
    @IBOutlet weak var resumenameBtn: UIButton!
    @IBOutlet weak var DeleteBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
        
    var currentZoom: CGFloat = 1.0
    var File_url = ""
    var IsNewResume = true
    var resumeName = ""
    var isAwsurl = true
    var selectedPDFURL: URL?
    var awsPDFPath: String?
    var collegeId: String?
    let defaults = UserDefaults.standard
    var memberId : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memberId = defaults.string(forKey: DefaultsKeys.memberid) ?? ""
        Webview.navigationDelegate = self
        
        if let url = URL(string: File_url) {
            
            let request = URLRequest(url: url)
            Webview.load(request)
        }
        
        let defaults = UserDefaults.standard
        collegeId = defaults.string(forKey: DefaultsKeys.collegeid)
        
        resumenameBtn.isHidden = IsNewResume
        DeleteBtn.isHidden = IsNewResume
        viewResumeLbl.text = IsNewResume ? "Preview My Resume" : "View My Resume"
        ProceedBtn.setTitle( IsNewResume ? "Save" : "Download", for: .normal)
        ProceedBtn.setImage(IsNewResume ? UIImage(systemName: "text.document.fill") :  UIImage(systemName: "arrow.down.to.line"), for: .normal)
        resumenameBtn.setTitle(resumeName, for: .normal)
        CancelBtn.setTitle(IsNewResume ? "Change Template" : "Share", for: .normal)
        if !isAwsurl{
            CancelBtn.setTitle("Cancel", for: .normal)
        }
        
        activityIndicator.hidesWhenStopped = true
        
        BackView.applyBottomShadow()
        BackBtn.setTitleFont(style: .medium, size: 18)
        
        CancelBtn.setTitleFont(style: .medium, size: 14)
        ProceedBtn.setTitleFont(style: .medium, size: 14)
        
        CancelBtn.layer.cornerRadius = 10
        ProceedBtn.layer.cornerRadius = 10
        
        ResueImg.layer.shadowOffset = CGSize(width: 0, height: 3)
        ResueImg.layer.shadowRadius = 5
        ResueImg.layer.masksToBounds = false
        ResueImg.layer.shadowOpacity = 0.25
        
        SaveResumeLbl.setFont(style: .semibold, size: FontSize.title)
        NameresumeLbl.setFont(style: .medium, size: FontSize.title)
        MarkdefaultLbl.setFont(style: .regular, size: FontSize.title)
        viewResumeLbl.setFont(style: .medium, size: FontSize.title)
        
        saveBtn.layer.cornerRadius = 10
        downloadBtn.layer.cornerRadius = 10
        
        saveBtn.setTitleFont(style: .semibold, size: FontSize.title)
        downloadBtn.setTitleFont(style: .semibold, size: FontSize.title)
        resumenameBtn.setTitleFont(style: .regular, size: FontSize.body)
        
        downloadBtn.layer.borderColor = UIColor.systemGray4.cgColor
        downloadBtn.layer.borderWidth = 1
        
           PopupContainerview.isHidden = true
           PopupContainerview.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        downloadBtn.isHidden = true
        shareBtn.isHidden = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        // Apply rounded top corners
        PopupView.layer.cornerRadius = 10
        Popuptopview.layer.cornerRadius = 10
        Popuptopview.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        Popuptopview.clipsToBounds = true
    }
    
    @IBAction func DeleteAct(_ sender: Any) {
        
//        let paramDict = ["resumeUrl": File_url]
//        let jsonData = try? JSONSerialization.data(withJSONObject: paramDict, options: [])
//        let param = String(data: jsonData ?? Data(), encoding: .utf8) ?? ""
//        print("requestStr",param)

        let deleteUrl = Constant.Resume_baseUrl+"delete/studentresume/"+(memberId ?? "")
        let body: [String: Any] = [
            "resumeUrl": File_url
        ]

        Delete_Method_Commom_Api.delete(
            url: deleteUrl,
            body: body,
            responseType: common_Response.self
        ) { result in
            switch result {
            case .success(let response):
                if response.status == true {
                    
                    AlertHelper.showOKAlert(on: self, title: "Success", message: "Resume Deleted Successfully",okTitle: "Ok",okAction: {
                        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
                    })
                    print("✅ Resume deleted: \(response.message ?? "")")
                } else {
                    print("⚠️ Failed: \(response.message ?? "No message")")
                }
            case .failure(let error):
                print("❌ Error: \(error.localizedDescription)")
            }
        }
    }
    
    @IBAction func BackAct(_ sender: Any) {
        
        if isAwsurl {
            dismiss(animated: true)
        }else{
            self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    
    
    @IBAction func SaveAct(_ sender: Any) {
        
       // downloadFile(from: File_url)
        
        if IsNewResume {
        showPopup()
        }else {
            downloadFile(from: File_url)
        }
    }
    
    @IBAction func closePopupAct(_ sender: Any) {
        
        hidePopup()
    }
    
    func applyZoom() {
            let js = "document.body.style.zoom = '\(currentZoom)'"
        Webview.evaluateJavaScript(js) { result, error in
                if let error = error {
                    print("JS error: \(error)")
                }
            }
        }
    
    @IBAction func ChangeTemplateAct(_ sender: Any) {
        
        if IsNewResume {
            dismiss(animated: true)
        }else {
            sharePDF()
        }
    }
    
    
    
    @IBAction func SaveResume(_ sender: Any) {
        
        if (nameField.text?.isEmpty ?? true) {
            
            AlertHelper.showOKAlert(on: self, title: "Missing Information", message: "Please Enter a resume name to continue!",okTitle: "Ok",okAction: {})
        }else {
            
            if isAwsurl {
                Save_resume_Api()
            }else {
                
                uploadPDFAndContinue()
            }
        }
    }
    
    
    func ResumeUplaosApi(){
        
        let request = ResumeUploadRequest()
        request.idMember = Int(memberId ?? "")
        request.bucket = "gradit-communication"
        request.bucketPath = "2025-06-27"
        request.file = selectedPDFURL?.absoluteString
        
        let requestStr = request.toJSONString() ?? ""
        
        Upload_Resume_Request.call_request(param: requestStr) {[weak self] res in
            
            guard let response: common_Response = Mapper<common_Response>().map(JSONString: res) else {return}
            
            if response.status == true {
                self?.File_url = response.data?.first ?? ""
                self?.Save_resume_Api()
            }
        }
    }
    
    func Save_resume_Api() {
        DispatchQueue.main.async {
            let resume_title = ResumeTitle()
            resume_title.title = self.nameField.text
            resume_title.url = self.File_url
            resume_title.placementOfficer = self.Switch.isOn

            let request = ResumeTitleRequest()
            request.idMember = Int(self.memberId ?? "")
            request.resumeTitle = [resume_title]

            let requestStr = request.toJSONString() ?? ""
            print("requestStr", requestStr)

            Save_Resume_Request.call_request(param: requestStr) { [weak self] (res) in
                guard let self = self else { return }
                guard let response: common_Response = Mapper<common_Response>().map(JSONString: res) else { return }

                DispatchQueue.main.async {
                    if response.status == true {
                        AlertHelper.showOKAlert(on: self, title: "Success", message: "Resume saved Successfully", okTitle: "Ok", okAction: {
                            
                            self.downloadBtn.isHidden = false
                            self.shareBtn.isHidden = false
                            self.saveBtn.isHidden = true
                            //self.hidePopup()
                        })
                    } else {
                        AlertHelper.showOKAlert(on: self, title: "Failed", message: "Failed to save resume. Try again later", okTitle: "Ok", okAction: {
                            self.hidePopup()
                        })
                    }
                }
            }
        }
    }
    
    
    @IBAction func DownloadResume(_ sender: Any) {
        
        downloadFile(from: File_url)
    }
    func downloadFile(from urlString: String) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        let session = URLSession(configuration: .default)
        let downloadTask = session.downloadTask(with: url) { (tempLocalUrl, response, error) in
            if let error = error {
                print("Download error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    AlertHelper.showOKAlert(on: self, title: "Failed", message: "Download failed", okTitle: "Ok", okAction: {})
                }
                return
            }

            guard let tempLocalUrl = tempLocalUrl else {
                print("No file URL")
                DispatchQueue.main.async {
                    AlertHelper.showOKAlert(on: self, title: "Failed", message: "No file found", okTitle: "Ok", okAction: {})
                }
                return
            }

            let fileManager = FileManager.default
            let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
            let destinationUrl = documentsDirectory.appendingPathComponent(url.lastPathComponent)

            do {
                if fileManager.fileExists(atPath: destinationUrl.path) {
                    try fileManager.removeItem(at: destinationUrl)
                }
                try fileManager.moveItem(at: tempLocalUrl, to: destinationUrl)
                print("File downloaded to: \(destinationUrl)")
                
                // ✅ UI updates on main thread
                DispatchQueue.main.async {
                    AlertHelper.showOKAlert(on: self, title: "Success", message: "Resume downloaded successfully", okTitle: "Ok", okAction: {})
                }
            } catch {
                print("File move error: \(error)")
                DispatchQueue.main.async {
                    AlertHelper.showOKAlert(on: self, title: "Failed", message: "Failed to download resume", okTitle: "Ok", okAction: {})
                }
            }
        }

        downloadTask.resume()
    }

    
    @IBAction func zoomInTapped(_ sender: UIButton) {
        if currentZoom < 3.0 {
                    currentZoom += 0.1
                    applyZoom()
                }
    }

    @IBAction func zoomOutTapped(_ sender: UIButton) {
        if currentZoom > 0.5 {
                    currentZoom -= 0.1
                    applyZoom()
                }
    }
    
    func showPopup() {
        PopupContainerview.alpha = 0
        PopupContainerview.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.PopupContainerview.alpha = 1
        }
    }

    func hidePopup() {
        UIView.animate(withDuration: 0.3, animations: {
            self.PopupContainerview.alpha = 0
        }) { _ in
            self.PopupContainerview.isHidden = true
        }
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: any Error) {
        activityIndicator.stopAnimating()
    }
    
    func uploadPDFToAWS(fileURL: URL, collegeId: String, completion: @escaping (Result<String, Error>) -> Void) {
        // Generate a unique filename
        let timestamp = Int(Date().timeIntervalSince1970)
        let pdfFileName = "vc_\(timestamp).pdf"
        let tempPDFURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(pdfFileName)
        
        // Copy to temp location (optional if already in temp)
        do {
            let pdfData = try Data(contentsOf: fileURL)
            try pdfData.write(to: tempPDFURL)
        } catch {
            print("❌ Failed to write PDF to temp directory: \(error)")
            completion(.failure(error))
            return
        }
        
        // Request pre-signed URL
        AWSPreSignedURL.shared.fetchPresignedURL(
            bucket: DefaultsKeys.S3BucketName,
            fileName: tempPDFURL,
            bucketPath: collegeId,
            fileType: "application"
        ) { result in
            switch result {
            case .success(let awsResponse):
                guard let presignedURLString = awsResponse.data?.presignedUrl,
                      let presignedURL = URL(string: presignedURLString),
                      let uploadedURL = awsResponse.data?.fileUrl else {
                    print("❌ Invalid AWS response")
                    completion(.failure(NSError(domain: "PresignedURLError", code: 0, userInfo: nil)))
                    return
                }

                // Upload PDF using presigned URL
                do {
                    let pdfData = try Data(contentsOf: tempPDFURL)
                    AWSUploadManager.shared.uploadPDFAWSUsingPresignedURL(
                        pdfData: pdfData,
                        presignedURL: presignedURL.absoluteString // ✅ Fix here
                    ) { uploadResult in
                        switch uploadResult {
                        case .success:
                            print("✅ PDF uploaded successfully: \(uploadedURL)")
                            completion(.success(uploadedURL))
                        case .failure(let error):
                            print("❌ PDF upload failed: \(error)")
                            completion(.failure(error))
                        }
                    }
                } catch {
                    print("❌ Failed to load PDF data before upload: \(error)")
                    completion(.failure(error))
                }
                
            case .failure(let error):
                print("❌ Failed to get presigned URL: \(error)")
                completion(.failure(error))
            }
        }
    }

    
    func uploadPDFAndContinue() {
        guard let pdfURL = self.selectedPDFURL else {
            print("No PDF selected to upload.")
            return
        }

        // Replace with your actual collegeId
        let collegeId = self.collegeId ?? ""

        uploadPDFToAWS(fileURL: pdfURL, collegeId: collegeId) { result in
            switch result {
            case .success(let uploadedURL):
                print("✅ Uploaded to AWS: \(uploadedURL)")
                
                // Save or use the uploaded URL as needed
                self.awsPDFPath = uploadedURL
                self.File_url = uploadedURL
                
                // 👉 Call your next API or logic here
                self.Save_resume_Api()

            case .failure(let error):
                print("❌ Upload failed: \(error.localizedDescription)")
            }
        }
    }

    
    @IBAction func sharePDF() {
        
        //        guard let URL = URL(string: File_url) else {return}
        //            // Download the PDF data
        //        URLSession.shared.dataTask(with: URL) { data, response, error in
        //                guard let data = data, error == nil else {
        //                    print("Failed to download PDF:", error ?? "Unknown error")
        //                    return
        //                }
        //
        //                // Save to a temporary location
        //                let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent("SharedPDF.pdf")
        //                do {
        //                    try data.write(to: tempURL)
        //
        //                    // Present UIActivityViewController on main thread
        //                    DispatchQueue.main.async {
        //                        let activityVC = UIActivityViewController(activityItems: [tempURL], applicationActivities: nil)
        //                        self.present(activityVC, animated: true, completion: nil)
        //                    }
        //                } catch {
        //                    print("Failed to save PDF:", error)
        //                }
        //            }.resume()
        //        }
        
        
        
        // You provide this: it could be a remote URL or a local path
        let filePath = File_url  // e.g., "https://s3.amazonaws.com/..." or "file://..." or local path
        
        if filePath.lowercased().hasPrefix("http") {
            // Remote URL (e.g., AWS)
            guard let remoteURL = URL(string: filePath) else {
                print("Invalid remote URL")
                return
            }
            
            // Download the PDF
            URLSession.shared.dataTask(with: remoteURL) { data, response, error in
                guard let data = data, error == nil else {
                    print("Failed to download PDF:", error ?? "Unknown error")
                    return
                }
                
                // Save to temp location
                let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent("SharedPDF.pdf")
                do {
                    try data.write(to: tempURL)
                    
                    DispatchQueue.main.async {
                        let activityVC = UIActivityViewController(activityItems: [tempURL], applicationActivities: nil)
                        self.present(activityVC, animated: true, completion: nil)
                    }
                } catch {
                    print("Failed to save downloaded PDF:", error)
                }
            }.resume()
            
        } else {
            // Local file path
            var fileURL: URL
            
            if filePath.lowercased().hasPrefix("file://") {
                fileURL = URL(fileURLWithPath: filePath.replacingOccurrences(of: "file://", with: ""))
            } else {
                // Assume it's a filename in the Documents directory
                if let documentsDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                    fileURL = documentsDir.appendingPathComponent(filePath)
                } else {
                    print("Unable to locate documents directory.")
                    return
                }
            }
            
            // Check if local file exists
            guard FileManager.default.fileExists(atPath: fileURL.path) else {
                print("Local file not found at path: \(fileURL.path)")
                return
            }
            
            // Share the local file
            let activityVC = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
            self.present(activityVC, animated: true, completion: nil)
        }
        
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }

        let keyboardHeight = keyboardFrame.height

        // Check if the responder is being covered
        if let activeField = findFirstResponder(in: self.view) {
            let fieldFrame = activeField.convert(activeField.bounds, to: self.view)
            let screenHeight = UIScreen.main.bounds.height

            // Only shift if the field is actually hidden
            if fieldFrame.maxY > screenHeight - keyboardHeight {
                let overlap = fieldFrame.maxY - (screenHeight - keyboardHeight)
                UIView.animate(withDuration: 0.3) {
                    self.view.transform = CGAffineTransform(translationX: 0, y: -overlap - 20)
                }
            }
        }
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.view.transform = .identity
        }
    }

    func findFirstResponder(in view: UIView) -> UIView? {
        if view.isFirstResponder { return view }
        for subview in view.subviews {
            if let responder = findFirstResponder(in: subview) {
                return responder
            }
        }
        return nil
    }

    
}



import Alamofire
import ObjectMapper
class Delete_Method_Commom_Api{
   
    static func delete<T: Mappable>(
            url: String,
            body: [String: Any],
            responseType: T.Type,
            completion: @escaping (Result<T, Error>) -> Void
        ) {
            AF.request(
                url,
                method: .delete,
                parameters: body,
                encoding: JSONEncoding.default,
                headers: ["Content-Type": "application/json"]
            )
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    if let json = value as? [String: Any],
                       let mapped = Mapper<T>().map(JSON: json) {
                        completion(.success(mapped))
                    } else {
                        let mappingError = NSError(domain: "MappingError", code: -1, userInfo: [
                            NSLocalizedDescriptionKey: "Failed to map response"
                        ])
                        completion(.failure(mappingError))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
}
