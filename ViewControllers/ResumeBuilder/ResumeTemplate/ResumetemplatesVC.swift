//
//  ResumetemplatesVC.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 30/05/25.
//

import UIKit
import ObjectMapper

class ResumetemplatesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var TV: UITableView!
    @IBOutlet weak var BackView: UIView!
    @IBOutlet weak var BackBtn: UIButton!
    @IBOutlet weak var CancelBtn: UIButton!
    @IBOutlet weak var SaveBtn: UIButton!
    
    var Templates: [ResumeTemplate]?
    var Colours: [String]?
    var context: ResumeContext?
    var templatenumber = 1
    var themecolour = ""
    var resume_Url = ""
    let defaults = UserDefaults.standard
    var memberId : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memberId = defaults.string(forKey: DefaultsKeys.memberid) ?? ""
//        BackView.layer.shadowColor = UIColor.black.cgColor
//        BackView.layer.shadowOpacity = 0.25
//        BackView.layer.shadowOffset = CGSize(width: 0, height: 4)
//        BackView.layer.shadowRadius = 8
//        BackView.layer.masksToBounds = false
        BackView.applyBottomShadow()
        BackBtn.setTitleFont(style: .medium, size: 18)
        
        CancelBtn.setTitleFont(style: .medium, size: 14)
        SaveBtn.setTitleFont(style: .medium, size: 14)
        
        CancelBtn.layer.cornerRadius = 10
        SaveBtn.layer.cornerRadius = 10
        
        Get_Templates_Api()
        themecolour = Colours?.first ?? ""
        let nib = UINib(nibName: "TemplateTvCell", bundle: nil)
        TV.register(nib, forCellReuseIdentifier: "TemplateTvCell")
        
        let headerNib = UINib(nibName: "ResumeHeaderCell", bundle: nil)
        TV.register(headerNib, forHeaderFooterViewReuseIdentifier: "ResumeHeaderCell")
        
        TV.delegate = self
        TV.dataSource = self
    }
    
    
    func Get_Templates_Api(){
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.get_resumetemplatethemecolor,
            httpMethod: .get,
            isBaseUrl: false,
            queryParam: nil,
            requestBody: nil
        ){ [weak self] (result:Result<TemplateResponse, Error>) in
            
            guard let self = self else {return}
            
            switch result {
            case .success(let success):
                if success.status == true {
                    
                    self.Templates = success.data?.first?.template
                    self.Colours = success.data?[1].themecolor
                    self.TV.reloadData()
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func Generate_Resume_Api(){
        
        var request = ResumeRequest()
        request.context = context
        request.templateNumber = templatenumber
        request.themeColor = themecolour
        request.idMember = Int(memberId ?? "")
        request.bucket = "gradit-communication"
        request.bucketPath = "2025-02-12/7033"
        
        APiCallManager.shared.callApi(
         url: APIEndpoints.resume_post_resume,
         httpMethod: .post,
         isBaseUrl: false,
         queryParam: nil,
         requestBody: request
        ){ [weak self] (result:Result<ResumeUploadResponse, Error>) in
            
            guard let self = self else {return}
            
            switch result {
            case .success(let success):
                
                if success.status == true {
                        
                        self.resume_Url = success.data?.first?.file_url ?? ""
                        View_resumeVC()
                  
                }else {
                    
                    AlertHelper.showOKAlert(on: self, title: "Failed", message: "Resume genaration is failed",okTitle: "Ok",okAction: {
                    })
                }
                
            case .failure(let failure):
                print(failure.localizedDescription)
            }
            
        }
    }
    
    @IBAction func BackAct(_ sender: Any) {
        
        dismiss(animated: true)
    }
    
    
    @IBAction func ProceedAct(_ sender: Any) {
        
        AlertHelper.showOKCancelAlert(on: self, title: "Confirm", message: "Are you sure want to Generate resume?",okTitle: "Ok",cancelTitle: "Cancel",okAction: {
            self.Generate_Resume_Api()
        },cancelAction:{
            
        })
        
//        let vc = ViewResumeVC(nibName: nil, bundle: nil)
//        vc.modalPresentationStyle = .fullScreen
//        present(vc, animated: true)
    }
    
    func View_resumeVC(){
        let vc = ViewResumeVC(nibName: nil, bundle: nil)
        vc.IsNewResume = true
        vc.File_url = resume_Url
        vc.isAwsurl = true
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = TV.dequeueReusableHeaderFooterView(withIdentifier: "ResumeHeaderCell") as! ResumeHeaderCell
        
        header.HeaderLbl.setFont(style: .medium, size: 17)
        header.EditBtn.isHidden = true
        
        if section == 0 {
            header.HeaderLbl.text = "Pick a Template"
        }else {
            header.HeaderLbl.text = "Select a Theme"
        }
        
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            let cell = TV.dequeueReusableCell(withIdentifier: "TemplateTvCell", for: indexPath) as! TemplateTvCell
           // cell.isTemplate = true
            cell.configure(template: Templates ?? [], colours: Colours ?? [], istemplate: true)
            cell.cvHeight.constant = cell.CV.collectionViewLayout.collectionViewContentSize.height
            cell.CV.layoutIfNeeded()
            cell.onTemplate = {[weak self] number in
                self?.templatenumber = number
            }
            return cell
        }else {
            let cell = TV.dequeueReusableCell(withIdentifier: "TemplateTvCell", for: indexPath) as! TemplateTvCell
            cell.configure(template: Templates ?? [], colours: Colours ?? [], istemplate: false)
           // cell.isTemplate = false
            
            cell.cvHeight.constant = cell.CV.collectionViewLayout.collectionViewContentSize.height
            cell.CV.layoutIfNeeded()
            cell.onColour = {[weak self] colour in
                self?.themecolour = colour
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
}


extension UIView {
    func findViewController() -> UIViewController? {
        var responder: UIResponder? = self
        while let next = responder?.next {
            if let vc = next as? UIViewController {
                return vc
            }
            responder = next
        }
        return nil
    }
}
