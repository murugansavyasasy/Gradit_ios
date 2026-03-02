//
//  PopupVC.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 17/07/25.
//

protocol PopupVcDelegate: AnyObject {
    func PopupDidDismiss()
}

import UIKit
import UniformTypeIdentifiers

class PopupVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIDocumentPickerDelegate{
    
    @IBOutlet weak var PopupContainerView: UIView!
    @IBOutlet weak var PopupView: UIView!
    @IBOutlet weak var topview: UIView!
    @IBOutlet weak var MyresumesLbl: UILabel!
    @IBOutlet weak var selectresumeLbl: UILabel!
    @IBOutlet weak var tv: UITableView!
    @IBOutlet weak var buildResumeBtn: UIButton!
    @IBOutlet weak var UploadResumeBtn: UIButton!
    
    var EducationDetail : [EducationalDetail]?
    var ProfileDetails: Profile?
    var SkillData: SkillProfile?
    var Resumes: [ResumeTitle]?
    var delegate: PopupVcDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        PopupContainerView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        PopupView.layer.cornerRadius = 10
        topview.layer.cornerRadius = 10
        topview.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        MyresumesLbl.setFont(style: .semibold, size: FontSize.title)
        
        buildResumeBtn.layer.cornerRadius = 10
        buildResumeBtn.setTitleFont(style: .semibold, size: FontSize.body)
        buildResumeBtn.backgroundColor = .clear
        
        UploadResumeBtn.setTitleFont(style: .regular, size: FontSize.body)
        selectresumeLbl.setFont(style: .regular, size: FontSize.body)
        
        tv.register(UINib(nibName: "myResumeTV", bundle: nil), forCellReuseIdentifier: "myResumeTV")
        tv.delegate = self
        tv.dataSource = self
        tv.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        buildResumeBtn.setGradientBackground(colors: [.systemYellow.withAlphaComponent(0.5),.systemOrange])
    }

    
    @IBAction func closePopupAct(_ sender: Any) {
        
        dismiss(animated: true){
            self.delegate?.PopupDidDismiss()
        }
    }
    
    @IBAction func buildResumeAct(_ sender: Any) {
        
        let vc = GenerateResumeVC(nibName: nil, bundle: nil)
        vc.EducationDetail = EducationDetail
        vc.ProfileDetails = ProfileDetails
        vc.SkillData = SkillData
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @available(iOS 14.0, *)
    @IBAction func uploadResumeAct(_ sender: Any) {
        
        pickDocument()
    }
    
    @available(iOS 14.0, *)
//    func pickDocument() {
//        let supportedTypes: [UTType] = [UTType.pdf]
//
//            let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: supportedTypes, asCopy: true)
//            documentPicker.delegate = self
//            documentPicker.allowsMultipleSelection = false  // ✅ Only one file allowed
//            present(documentPicker, animated: true, completion: nil)
//        }
//    
//    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
//            guard let fileURL = urls.first else { return }
//
//            // Start security access to sandboxed file
//            if fileURL.startAccessingSecurityScopedResource() {
//                defer { fileURL.stopAccessingSecurityScopedResource() }
//
//                print("📁 Picked file path: \(fileURL.path)")
//                let vc = ViewResumeVC(nibName: nil, bundle: nil)
//                vc.isAwsurl = false
//                vc.IsNewResume = true
//                vc.selectedPDFURL = fileURL
//                vc.File_url = fileURL.absoluteString
//                vc.modalPresentationStyle = .fullScreen
//                present(vc, animated: true)
//            }
//        }

//       func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
//           print("❌ Document picker canceled.")
//       }
    
    func pickDocument() {
        let supportedTypes: [UTType] = [UTType.pdf]

            let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: supportedTypes, asCopy: true)
            documentPicker.delegate = self
            documentPicker.allowsMultipleSelection = false  // ✅ Only one file allowed
            present(documentPicker, animated: true, completion: nil)
        }
    
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        
        let fileurl: URL = url as URL
        let filename = url.lastPathComponent
        let fileextension = url.pathExtension
        print("URL: \(fileurl)", "NAME: \(filename)", "EXTENSION: \(fileextension)")
        
                let vc = ViewResumeVC(nibName: nil, bundle: nil)
                vc.isAwsurl = false
                vc.IsNewResume = true
                vc.selectedPDFURL = fileurl
                vc.File_url = fileurl.absoluteString
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true)
        }

       func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
           print("❌ Document picker canceled.")
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Resumes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tv.dequeueReusableCell(withIdentifier: "myResumeTV", for: indexPath) as! myResumeTV
        
        cell.TitleLbl.text = Resumes?[indexPath.row].title
        cell.defaultBtn.isHidden = !(Resumes?[indexPath.row].placementOfficer ?? false)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = ViewResumeVC(nibName: nil, bundle: nil)
        vc.IsNewResume = false
        vc.modalPresentationStyle = .fullScreen
        vc.File_url = Resumes?[indexPath.row].url ?? ""
        vc.resumeName = Resumes?[indexPath.row].title ?? ""
        present(vc, animated: true)
    }
}
