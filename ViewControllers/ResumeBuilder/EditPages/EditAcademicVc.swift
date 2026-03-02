//
//  EditAcademicVc.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 30/05/25.
//

import UIKit
import DropDown
import ObjectMapper
import UniformTypeIdentifiers
import PhotosUI

class EditAcademicVc: UIViewController {
   
    @IBOutlet weak var BackView: UIView!
    @IBOutlet weak var BackBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var SaveBtn: UIButton!
    @IBOutlet weak var tv: UITableView!
    
    var Sections = ["Academic Records","Backlogs and Arrears"]
    var classes = ["10 th","12 th","UG","PG","Others"]
    var educationData : EducationData?
    var EducationDetail : [EducationalDetail] = []
    let dropdown = DropDown()
    var selectedOption: String?
    var Backlogs: String = ""
    var NoOfArrears: String = ""
    let defaults = UserDefaults.standard
    var memberId : String?
    weak var activeTextField: UITextField?
    private var selectedIndexPath: IndexPath?
    private lazy var filePicker = FilePickerHelper(presentingVC: self)
    var collegeId : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memberId = defaults.string(forKey: DefaultsKeys.memberid) ?? ""
        
        BackBtn.setTitleFont(style: .medium, size: 18)
        
        cancelBtn.layer.cornerRadius = 10
        SaveBtn.layer.cornerRadius = 10
        
        SaveBtn.setTitleFont(style: .medium, size: 14)
        cancelBtn.setTitleFont(style: .medium, size: 14)
        
        tv.register(UINib(nibName: "ResumeHeaderCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "ResumeHeaderCell")
        tv.register(UINib(nibName: "AddFooter", bundle: nil), forHeaderFooterViewReuseIdentifier: "AddFooter")
        
        tv.register(UINib(nibName: "addAcademicTV", bundle: nil), forCellReuseIdentifier: "addAcademicTV")
        
        tv.register(UINib(nibName: "BacklogsTv", bundle: nil), forCellReuseIdentifier: "BacklogsTv")
        
        tv.register(UINib(nibName: "FooterCell", bundle: nil), forCellReuseIdentifier: "FooterCell")
        
        tv.delegate = self
        tv.dataSource = self
        
        dropdown.dataSource = classes
        dropdown.selectionAction = { [weak self] index, item in
            self?.activeTextField?.text = item
        }
        
        let defaults = UserDefaults.standard
        collegeId = defaults.string(forKey: DefaultsKeys.collegeid)
        
        Backlogs = educationData?.backlogs ?? ""
        NoOfArrears = educationData?.numberOfArrears ?? ""
        
       // prepareEducationList()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
        
        filePicker.onFilesPicked = { [weak self] urls in
               self?.handlePickedFiles(urls)
           }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLayoutSubviews() {
        
        BackView.applyBottomShadow()
    }
    
//    func prepareEducationList() {
//        
//        
//        if let details = EducationDetail {
//            educationList = details.map { detail in
//                let edu = eduData()
//                edu.classDegree = detail.classDegree
//                edu.percentage = detail.percentage
//                edu.institution = detail.institution
//                return edu
//            }
//        }
//        
//        if educationList.isEmpty {
//            let edu = eduData()
//            edu.classDegree = ""
//            edu.percentage = ""
//            edu.institution = ""
//            educationList = [edu]
//        }
//    }
    
    @IBAction func BackAct(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
//    @IBAction func SaveAct(_ sender: Any) {
//        
//        self.view.endEditing(true) // Dismiss keyboard if active
//        
//        if !validateEducationList() || Backlogs.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || NoOfArrears.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
//            
//            let alert = UIAlertController(title: "Missing Information", message: "Please fill all details", preferredStyle: .alert)
//            let ok = UIAlertAction(title: "Ok", style: .default)
//            alert.addAction(ok)
//            present(alert, animated: true)
//            return
//        }
//        
//        // All data is valid — proceed with confirmation
//        let confirmAlert = UIAlertController(title: "Confirm", message: "Are you sure you want to update Academic records", preferredStyle: .alert)
//        
//        let yes = UIAlertAction(title: "Yes", style: .default) { [weak self] _ in
//            guard let self = self else { return }
//            
//            let request = Edit_Academic_req()
//            request.idMember = Int(memberId ?? "")
//            request.backlogs = self.Backlogs
//            request.numberOfArrears = self.NoOfArrears
//            request.educationalDetails = self.EducationDetail
//            
//            let academicStr = request.toJSONString() ?? ""
//            print(academicStr)
//            
//            Edit_Academic_Request.call_request(param: academicStr) { [weak self] res in
//                guard let response: Edit_Academic_Response = Mapper<Edit_Academic_Response>().map(JSONString: res) else { return }
//                
//                DispatchQueue.main.async {
//                    if response.status == true {
//                        let alert = UIAlertController(title: "Success", message: "Academic records Updated Successfully", preferredStyle: .alert)
//                        let ok = UIAlertAction(title: "Ok", style: .default) { _ in
//                            self?.dismiss(animated: true)
//                        }
//                        alert.addAction(ok)
//                        self?.present(alert, animated: true)
//                    } else {
//                        let alert = UIAlertController(title: "Failed", message: "Something went wrong", preferredStyle: .alert)
//                        let ok = UIAlertAction(title: "Ok", style: .default)
//                        alert.addAction(ok)
//                        self?.present(alert, animated: true)
//                    }
//                }
//            }
//        }
//        
//        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
//        confirmAlert.addAction(yes)
//        confirmAlert.addAction(cancel)
//        
//        present(confirmAlert, animated: true)
//    }
    
    @IBAction func SaveAct(_ sender: Any) {

        self.view.endEditing(true)

        if !validateEducationList()
            || Backlogs.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            || NoOfArrears.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {

            let alert = UIAlertController(
                title: "Missing Information",
                message: "Please fill all details",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            present(alert, animated: true)
            return
        }

        let confirmAlert = UIAlertController(
            title: "Confirm",
            message: "Are you sure you want to update Academic records",
            preferredStyle: .alert
        )

        let yes = UIAlertAction(title: "Yes", style: .default) { [weak self] _ in
            guard let self = self else { return }

            // 🔹 OPTIONAL: Show loader here
            self.view.isUserInteractionEnabled = false

            // 🔹 STEP 1: Upload attachments first
            uploadEducationAttachments(
                educationDetails: self.EducationDetail,
                collegeId: self.collegeId ?? ""
            ) { updatedEducationDetails in

                DispatchQueue.main.async {

                    // 🔹 STEP 2: Replace local model with uploaded URLs
                    self.EducationDetail = updatedEducationDetails

                    // 🔹 STEP 3: Build request model
                    let request = Edit_Academic_req()
                    request.idMember = Int(self.memberId ?? "")
                    request.backlogs = self.Backlogs
                    request.numberOfArrears = self.NoOfArrears
                    request.educationalDetails = self.EducationDetail

                    let academicStr = request.toJSONString() ?? ""
                    print("Final Request JSON:", academicStr)

                    // 🔹 STEP 4: Call API
                    Edit_Academic_Request.call_request(param: academicStr) { [weak self] res in
                        guard
                            let self = self,
                            let response = Mapper<Edit_Academic_Response>().map(JSONString: res)
                        else { return }

                        DispatchQueue.main.async {
                            self.view.isUserInteractionEnabled = true

                            if response.status == true {
                                let alert = UIAlertController(
                                    title: "Success",
                                    message: "Academic records Updated Successfully",
                                    preferredStyle: .alert
                                )
                                alert.addAction(UIAlertAction(title: "Ok", style: .default) { _ in
                                    self.dismiss(animated: true)
                                })
                                self.present(alert, animated: true)
                            } else {
                                let alert = UIAlertController(
                                    title: "Failed",
                                    message: "Something went wrong",
                                    preferredStyle: .alert
                                )
                                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                                self.present(alert, animated: true)
                            }
                        }
                    }
                }
            }
        }

        confirmAlert.addAction(yes)
        confirmAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(confirmAlert, animated: true)
    }

    
    func validateEducationList() -> Bool {
        for education in EducationDetail {
            if education.classDegree?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true ||
                education.percentage?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true ||
                education.institution?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
                return false
            }
        }
        return true
    }
    
    @IBAction func CancelAct(_ sender: Any) {
        
        dismiss(animated: true)
    }
    
    func handlePickedFiles(_ urls: [URL]) {

        guard let indexPath = selectedIndexPath else { return }

        let files: [File] = urls.compactMap { url in

            // ✅ Copy to sandbox
            guard let localURL = copyToDocumentsIfNeeded(url) else { return nil }

            return File(
                type: inferType(from: localURL),
                url: localURL.absoluteString
            )
        }

        var attachments = EducationDetail[indexPath.row].file_path ?? []
        attachments.append(contentsOf: files)
        EducationDetail[indexPath.row].file_path = attachments

        tv.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func copyToDocumentsIfNeeded(_ url: URL) -> URL? {

        let fileName = url.lastPathComponent
        let destinationURL = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(fileName)

        // Already copied
        if FileManager.default.fileExists(atPath: destinationURL.path) {
            return destinationURL
        }

        do {
            try FileManager.default.copyItem(at: url, to: destinationURL)
            return destinationURL
        } catch {
            print("❌ File copy failed:", error)
            return nil
        }
    }
    
    func inferType(from url: URL) -> String {
        switch url.pathExtension.lowercased() {
        case "jpg", "jpeg", "png", "heic": return "Image"
        case "pdf": return "Pdf"
        case "doc", "docx": return "Doc"
        case "txt", "rtf": return "Text"
        default: return "Text"
        }
    }
    
    func uploadEducationAttachments(
        educationDetails: [EducationalDetail],
        collegeId: String,
        completion: @escaping ([EducationalDetail]) -> Void
    ) {
        let updatedEducationDetails = educationDetails
        let dispatchGroup = DispatchGroup()

        for eduIndex in updatedEducationDetails.indices {

            guard let attachments = updatedEducationDetails[eduIndex].file_path else {
                continue
            }

            for fileIndex in attachments.indices {

                let fileItem = attachments[fileIndex]

                guard
                    let urlString = fileItem.url,
                    isLocalFileURL(urlString),
                    let localURL = URL(string: urlString)
                else {
                    continue
                }

                dispatchGroup.enter()

                uploadSingleFile(
                    fileURL: localURL,
                    collegeId: collegeId
                ) { result in
                    switch result {
                    case .success(let uploadedURL):
                        // ✅ Safe mutation on local copy
                        updatedEducationDetails[eduIndex]
                            .file_path?[fileIndex]
                            .url = uploadedURL

                    case .failure(let error):
                        print(
                            "Upload failed at education[\(eduIndex)] attachment[\(fileIndex)]: \(error)"
                        )
                    }

                    dispatchGroup.leave()
                }
            }
        }

        dispatchGroup.notify(queue: .main) {
            completion(updatedEducationDetails)
        }
    }
    
    func isLocalFileURL(_ urlString: String) -> Bool {
        return urlString.hasPrefix("file://")
    }

    func isImageFile(url: URL) -> Bool {
        let imageExtensions = ["jpg", "jpeg", "png", "heic"]
        return imageExtensions.contains(url.pathExtension.lowercased())
    }

    func uploadSingleFile(
        fileURL: URL,
        collegeId: String,
        completion: @escaping (Result<String, Error>) -> Void
    ) {
        AWSPreSignedURL.shared.fetchPresignedURL(
            bucket: DefaultsKeys.S3BucketName,
            fileName: fileURL,
            bucketPath: collegeId,
            fileType: backendFileType(for: fileURL)
        ) { result in
            switch result {

            case .success(let awsResponse):

                guard
                    let presignedURL = awsResponse.data?.presignedUrl,
                    let uploadedURL = awsResponse.data?.fileUrl
                else {
                    completion(.failure(NSError(domain: "PresignedURLError", code: 0)))
                    return
                }

                // IMAGE
                if self.isImageFile(url: fileURL),
                   let image = UIImage(contentsOfFile: fileURL.path) {

                    AWSUploadManager.shared.uploadImageToAWS(
                        image: image,
                        presignedURL: presignedURL
                    ) { uploadResult in
                        switch uploadResult {
                        case .success:
                            completion(.success(uploadedURL))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }

                // NON-IMAGE (PDF, DOC, AUDIO, PPT, TXT, etc.)
                } else {
                    guard let fileData = try? Data(contentsOf: fileURL) else {
                        completion(.failure(NSError(domain: "FileReadError", code: 0)))
                        return
                    }

                    AWSUploadManager.shared.uploadPDFAWSUsingPresignedURL(
                        pdfData: fileData,
                        presignedURL: presignedURL
                    ) { uploadResult in
                        switch uploadResult {
                        case .success:
                            completion(.success(uploadedURL))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
                }

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func backendFileType(for url: URL) -> String {
        let ext = url.pathExtension.lowercased()

//        switch ext {
//        case "jpg", "jpeg", "png", "heic":
//            return "image"
//        default:
//            return "application"
//        }
        
        switch ext {
                
            // Images
            case "jpg", "jpeg":
                return "image/jpeg"
            case "png":
                return "image/png"
            case "gif":
                return "image/gif"
            case "webp":
                return "image/webp"
            case "heic":
                return "image/heic"
                
            // Documents
            case "pdf":
                return "application/pdf"
            case "doc":
                return "application/msword"
            case "docx":
                return "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
                
            // Fallback
            default:
                return "application/octet-stream"
            }
    }
}

extension EditAcademicVc: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return Sections.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = tv.dequeueReusableHeaderFooterView(withIdentifier: "ResumeHeaderCell") as! ResumeHeaderCell
        header.HeaderLbl.text = Sections[section]
        header.HeaderLbl.setFont(style: .medium, size: FontSize.header)
        header.EditBtn.isHidden = true
        return header
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? EducationDetail.count+1 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tv.dequeueReusableCell(withIdentifier: "addAcademicTV", for: indexPath) as! addAcademicTV
            if indexPath.row < EducationDetail.count {
                let data = EducationDetail[indexPath.row]
                cell.ClassField.text = data.classDegree
                cell.PercentageField.text = data.percentage
                cell.SchoolField.text = data.institution
                cell.configureAttachments(data.file_path ?? [])
                
                cell.onClassChange = { [weak self] text in
                    self?.EducationDetail[indexPath.row].classDegree = text
                }
                cell.onPercentageChange = { [weak self] text in
                    self?.EducationDetail[indexPath.row].percentage = text
                }
                cell.onInstituteChange = { [weak self] text in
                    self?.EducationDetail[indexPath.row].institution = text
                }
                
                cell.deleteAction = { [weak self] in
                    self?.EducationDetail.remove(at: indexPath.row)
                    self?.tv.reloadData()
                }
                
                cell.onAddfile = { [weak self] in
                    if #available(iOS 14.0, *) {
                        self?.selectedIndexPath = indexPath
                        //self?.showAddFileOptions()
                        self?.filePicker.showOptions()
                    }
                }
                
                cell.onRemoveAttachment = { [weak self] fileIndex in
                            guard let self else { return }

                            var current = self.EducationDetail[indexPath.row].file_path ?? []
                            current.remove(at: fileIndex)
                            self.EducationDetail[indexPath.row].file_path = current

                            self.tv.reloadRows(at: [indexPath], with: .automatic)
                        }
                
                cell.onPreviewFile = { [weak self] files, selectedIndex in
                    self?.openPreviewVC(files: files, selectedIndex: selectedIndex, title: data.classDegree ?? "")
                }
                
                return cell
            }else {
                
                let footerCell = tv.dequeueReusableCell(withIdentifier: "FooterCell", for: indexPath) as! FooterCell
                footerCell.AddBtn.setTitleFont(style: .regular, size: FontSize.title)
                footerCell.AddBtn.addTarget(self, action: #selector(AddRowAct), for: .touchUpInside)
                return footerCell
            }
        } else {
            let cell = tv.dequeueReusableCell(withIdentifier: "BacklogsTv", for: indexPath) as! BacklogsTv
            cell.BacklogsField.text = educationData?.backlogs
            cell.ArrearsField.text = educationData?.numberOfArrears
            cell.BacklogsField.addTarget(self, action: #selector(backlogsTextChanged(_:)), for: .editingChanged)
            cell.ArrearsField.addTarget(self, action: #selector(arrearsTextChanged(_:)), for: .editingChanged)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    @objc func AddRowAct() {
        self.view.endEditing(true)
        
        if !validateEducationList() {
            
            let alert = UIAlertController(title: "Missing Information", message: "Please fill all details in the previous records", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            present(alert, animated: true)
            return
        }
        
        // All fields are filled, add new row
//        let newEdu = eduData()
//        newEdu.classDegree = ""
//        newEdu.percentage = ""
//        newEdu.institution = ""
//        educationList.append(newEdu)
//        tv.reloadData()
        
        let newEdu = EducationalDetail()
        EducationDetail.append(newEdu)
        tv.reloadData()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false // Prevent keyboard
    }
    
    @objc func backlogsTextChanged(_ textField: UITextField) {
        Backlogs = textField.text ?? ""
    }
    
    @objc func arrearsTextChanged(_ textField: UITextField) {
        NoOfArrears = textField.text ?? ""
    }
    
    func openPreviewVC(files: [File], selectedIndex: Int,title:String) {

        let vc = AttachmentPreviewVC()
        vc.Files = files
        vc.selectedIndex = selectedIndex
        vc.Title = title
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }

}

extension EditAcademicVc: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let cell = textField.superview?.superview as? UITableViewCell,
              let indexPath = tv.indexPath(for: cell) else { return }
        
        tv.scrollToRow(at: indexPath, at: .none, animated: true)
    }
    
    // MARK: - Keyboard Handling
    
    @objc func keyboardWillShow(notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        let keyboardHeight = keyboardFrame.height
        let bottomInset = keyboardHeight - view.safeAreaInsets.bottom
        
        tv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bottomInset, right: 0)
        tv.scrollIndicatorInsets = tv.contentInset
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        tv.contentInset = .zero
        tv.scrollIndicatorInsets = .zero
    }
    
    
}


//struct AcademicModel {
//    var className: String
//    var percentage: String
//    var institute: String
//    var attachments: [Attachment]
//}
//
//enum AttachmentFileType {
//    case image
//    case pdf
//    case doc
//    case text
//}
//
//enum AttachmentURL {
//    case remote(String)   // AWS URL
//    case local(URL)       // Device file URL
//}
//
//struct Attachment {
//    let type: AttachmentFileType
//    let url: AttachmentURL
//}
//
//
//extension Attachment {
//
//    var fileName: String {
//        switch url {
//        case .remote(let path):
//            return URL(string: path)?.lastPathComponent ?? "Document"
//        case .local(let fileURL):
//            return fileURL.lastPathComponent
//        }
//    }
//}
//
//func attachmentType(from url: URL) -> AttachmentFileType {
//    switch url.pathExtension.lowercased() {
//    case "jpg", "jpeg", "png", "heic": return .image
//    case "pdf": return .pdf
//    case "doc", "docx": return .doc
//    case "txt", "rtf": return .text
//    default: return .text
//    }
//}
//
//func attachmentType(from url: String) -> AttachmentFileType {
//    let ext = URL(string: url)?.pathExtension.lowercased() ?? ""
//    switch ext {
//    case "jpg", "jpeg", "png", "heic": return .image
//    case "pdf": return .pdf
//    case "doc", "docx": return .doc
//    case "txt", "rtf": return .text
//    default: return .text
//    }
//}
//
