//
//  HodSelectResipenceViewController.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 14/03/23.
//

import UIKit
import ObjectMapper
import Alamofire
import KRProgressHUD
import AWSCore
import AWSS3


@available(iOS 16.0, *)
class HodSelectResipenceViewController: UIViewController {
    
    @IBOutlet weak var entierDefaultLbl: UILabel!
    @IBOutlet weak var sendView: UIViewX!
    @IBOutlet weak var staffChck: CheckBoxTwo!
    
    @IBOutlet weak var parentchck: CheckBoxTwo!
    @IBOutlet weak var studentChck: CheckBoxTwo!
    
    @IBOutlet weak var entierDepartmentChk: CheckBoxTwo!
    @IBOutlet weak var myDepartmentView: UIViewX!
    
    @IBOutlet weak var cancelView: UIViewX!
    @IBOutlet weak var yourClassView: UIViewX!
    var entierRefName : [EntiercollegeDataDetails] = []
    var particularSms : NoticePArticularResponce?
    var imagePdfEniter : [sendImagePdfDataDetails] = []
    var assigmentImagPdf : [assigmentImagePdfResponce] = []
    var titlesTextField : String!
    var discreptionss : String!
    var resivre : String!
    var memberId : String!
    var collegeId : String!
    var priority : String!
    var venumtextField : String!
    var AssigmentMenuAwsUrl : String!
    var eventDate : String!
    var AssigmentFileType : String!
    var fileType : String!
    var ImagePdfAws : String!
    var videoUrl : String!
    var iframeUrl : String!
    var videoType : String!
    var videoUploadEntier : [EntierVideoUploadDataDetails] = []
    var voiceDuration : String!
    var voiceReplyType : String!
    var voiceUrl : URL!
    var assigmentDate : String!
    
    var str : [String] = []
    
    var strName : [String] = []
    
    var EventTime : String!
    
    var awsArry : [String] = []
    var assigmentHeaderId : String!
    
    var currentImageCount = 0
    var totalImageCount = 0
    var originalImagesArray = [UIImage]()
    var absoluteStringImg : String!
    var imageUrlArray = NSMutableArray()
    var convertedImagesUrlArray = NSMutableArray()
    var forwadDiscreption : String!
    var absoluteStringPdf : String!
    var pdfData : Data? = nil
    
    var photoArray = [UIImage]()
    
    
    var VoiceHstryId : String!
    var voiceHstryHeaderId : String!
    var is_read_enabled = ""
    var is_write_enabled = ""
    //    var
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        
        
        
        print("VoiceHstryIdVoiceHstryId",VoiceHstryId)
        let defaults = UserDefaults.standard
        
        memberId = defaults.string(forKey: DefaultsKeys.memberid)
        
        collegeId = defaults.string(forKey: DefaultsKeys.collegeid)
        priority = defaults.string(forKey: DefaultsKeys.priority)
        
        let yourclass = UITapGestureRecognizer(target: self, action: #selector(YourClassVc))
        
        yourClassView.addGestureRecognizer(yourclass)
        
        let send = UITapGestureRecognizer(target: self, action: #selector(sendVc))
        
        sendView.addGestureRecognizer(send)
        
        
        
        let cancel = UITapGestureRecognizer(target: self, action: #selector(cancelVc))
        cancelView.addGestureRecognizer(cancel)
        
        
        let mydepart = UITapGestureRecognizer(target: self, action: #selector(DepartmentVc))
        myDepartmentView.addGestureRecognizer(mydepart)
        
        entierDefaultLbl.isHidden = true
        entierDepartmentChk.isHidden = true
        sendView.isHidden = true
        
        parentchck.isHidden = true
        studentChck.isHidden = true
        staffChck.isHidden = true
    }
    
    
    
    
    @IBAction func sendVc(){
        
        
        //
        
        
        
        
        let refreshAlert = UIAlertController(title: "", message: "Are you sure you want to submit?", preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in
            
            
            if self.resivre == "1"{
                
                print("Notice")
                
                self.NoticeSendSmsEntier()
                
                
                
                
            }
            
            else if self.resivre == "2"{
                
                print("video")
                
                self.videoUpload()
                
            }
            
            else if self.resivre == "3"{
                
                
                print("event545454454")
                
                self.EventEntier()
                
            }
            
            else if self.resivre == "4"{
                
                
                print("communication")
                
                self.entierDepart()
                
                
            }
            
            
            else if self.resivre == "5"{
                print("imagePdf")
                
                
                self.ImagePdfEntier()
                
                
            }
            
            
            else if self.resivre == "6"{
                
                self.assigmentImagePdf()
                
            }
            
            
            
            else if self.resivre == "11"{
                
                
                if VoiceHstryId == "1"{
                    self.multypartAudio()
                    
                }else if  VoiceHstryId == "2"{
                    self.HistoryVoiceSend()
                    
                    
                }
                
            }
            
            
        }))
        
        
        refreshAlert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        self.present(refreshAlert, animated: true, completion: nil)
        
        
        
        
    }
    
    
    
    
    func HistoryVoiceSend() {
        
        var voiceUpload = VoiceHstryModal()
        
        voiceUpload.staffid = memberId
        voiceUpload.description = discreptionss
        voiceUpload.callertype = priority
        voiceUpload.collegeid = collegeId
        voiceUpload.forwarding_voice_id = voiceHstryHeaderId
        voiceUpload.isparent = parentchck.isChecked
        voiceUpload.isemergencyvoice = voiceReplyType
        voiceUpload.isstaff = staffChck.isChecked
        voiceUpload.isstudent = studentChck.isChecked
        
        APiCallManager.shared.callApi(
                url: APIEndpoints.SendVoiceToEntireCollegeFromHistory,
                httpMethod: .post,
                queryParam: nil,
                requestBody: voiceUpload
            ) {[weak self] (result:Result<voiceHstryResponce, Error>) in
                    
                guard let self = self else { return }
                
                switch result {
                case .success(let success):
                    
                    if success.Status == 1 {
                        
                        let refreshAlert = UIAlertController(title: "", message: success.Message, preferredStyle: UIAlertController.Style.alert)
                        
                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                            
                        }))
                        
                        present(refreshAlert, animated: true, completion: nil)
                        
                    }else{
                        
                        let refreshAlert = UIAlertController(title: "", message: success.Message, preferredStyle: UIAlertController.Style.alert)
                        
                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                            
                        }))
                        
                        present(refreshAlert, animated: true, completion: nil)
                    }
                    
                case .failure(let failure):
                     print("Error:",failure.localizedDescription)
                }
                
                }
    }
    
    
    func multypartAudio() {
        
        let vimeoVideoEndpoint = "https://gradit.voicesnap.com/api/AppDetailsBal/SendFileToEntireCollege"
        
        var voiceUpload = voiceUploadEntierModal()
        
        
        voiceUpload.staffid = memberId
        voiceUpload.description = discreptionss
        voiceUpload.callertype = priority
        voiceUpload.collegeid = collegeId
        voiceUpload.fileduration = voiceDuration
        voiceUpload.filetype = "1"
        voiceUpload.isemergencyvoice = voiceReplyType
        voiceUpload.isparent = parentchck.isChecked
        voiceUpload.isstaff = staffChck.isChecked
        voiceUpload.isstudent = studentChck.isChecked
        
//        let voiceUploadStr = voiceUpload.toJSONString()
//        
//        print("chatSenderStr",voiceUpload)
//        
//        AF.upload(multipartFormData: { [self] (multipartFormData) in
//            
//            KRProgressHUD.show()
//            
//            
//            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//                
//                
//                
//                
//                KRProgressHUD.dismiss()
//                
//            }
//            
//            var videoU : String!
//            
//            let pathURL = voiceUrl
//            
//            let pathString = pathURL!.path
//            
//            multipartFormData.append(URL(fileURLWithPath: pathString), withName: "file")
//            
//            multipartFormData.append(Data(voiceUploadStr!.description.utf8), withName: "info")
//            
//            
//            
//            print("parameters.description.utf8",voiceUploadStr!.description.utf8)
//            
            
//        },to: vimeoVideoEndpoint).responseJSON{
//            //
//            res in
//            
//            
//            let json_str = String(data: res.data!, encoding: .utf8)
//            
//            print("json \(json_str!)")
//            
//            
//            
//            do {
//                if let json = try JSONSerialization.jsonObject(with: res.data!, options: []) as? [String: Any] {
//                    if let status = json["Status"] as? Int {
//                        print("Status: \(status)")
//                        
//                        if status == 1 {
//                            
//                            
//                            let a = json["Message"]
//                            
//                            
//                            let refreshAlert = UIAlertController(title: "", message: a as! String, preferredStyle: UIAlertController.Style.alert)
//                            
//                            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in
//                                
//                                if priority == "p2" || priority == "p3" {
//                                    
//                                    let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
//                                    
//                                    vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
//                                    
//                                    vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
//                                    vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
//                                    vc.strName = self.strName
//                                    vc.str = self.str
//                                    
//                                    vc.modalPresentationStyle = .fullScreen
//                                    self.present(vc, animated: true , completion: nil)
//                                    
//                                }
//                                
//                                
//                                else{
//                                    
//                                    let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
//                                    
//                                    vc.view.backgroundColor = UIColor(named: "Principal" )
//                                    
//                                    vc.CommuniSegementName.backgroundColor = UIColor(named: "UnSelector")
//                                    vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "Selector")
//                                    
//                                    vc.strName = self.strName
//                                    vc.str = self.str
//                                    vc.modalPresentationStyle = .fullScreen
//                                    self.present(vc, animated: true , completion: nil)
//                                    
//                                }
//                                
//                                
//                            }))
//                            
//                            
//                            refreshAlert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: { (action: UIAlertAction!) in
//                                print("Handle Cancel Logic here")
//                            }))
//                            
//                            self.present(refreshAlert, animated: true, completion: nil)
//                            
//                            
//                            
//                            
//                        }
//                        else {
//                            
//                            
//                            
//                            let a = json["Message"]
//                            
//                            let refreshAlert = UIAlertController(title: "", message: a as! String, preferredStyle: UIAlertController.Style.alert)
//                            
//                            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in
//                                
//                                if priority == "p2" || priority == "p3" {
//                                    
//                                    let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
//                                    
//                                    vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
//                                    
//                                    vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
//                                    vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
//                                    vc.strName = self.strName
//                                    vc.str = self.str
//                                    
//                                    vc.modalPresentationStyle = .fullScreen
//                                    self.present(vc, animated: true , completion: nil)
//                                    
//                                }
//                                
//                                
//                                else{
//                                    
//                                    let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
//                                    
//                                    vc.view.backgroundColor = UIColor(named: "Principal" )
//                                    
//                                    vc.CommuniSegementName.backgroundColor = UIColor(named: "UnSelector")
//                                    vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "Selector")
//                                    
//                                    vc.strName = self.strName
//                                    vc.str = self.str
//                                    vc.modalPresentationStyle = .fullScreen
//                                    self.present(vc, animated: true , completion: nil)
//                                    
//                                }
//                                
//                                
//                            }))
//                            
//                            
//                            refreshAlert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: { (action: UIAlertAction!) in
//                                print("Handle Cancel Logic here")
//                            }))
//                            
//                            self.present(refreshAlert, animated: true, completion: nil)
//                            
//                            
//                            
//                            
//                        }
//                        
//                    }
//                }
//            } catch {
//                print("Error parsing JSON: \(error)")
//            }
//            
//            
//            
//            
//            
//        }
        
        
        
        
    }
    
    
    func videoUpload(){
        
        var uploadvideo = EntierVideoUpload()
        
        uploadvideo.isparent = parentchck.isChecked
        uploadvideo.callertype = priority
        uploadvideo.url = videoUrl
        uploadvideo.collegeid = collegeId
        uploadvideo.description = discreptionss
        uploadvideo.iframe = iframeUrl
        
        print("uploadvideo.iframe", uploadvideo.iframe)
        print("uploadvideo.url", uploadvideo.url)
        
        uploadvideo.isstaff = staffChck.isChecked
        uploadvideo.isstudent = studentChck.isChecked
        uploadvideo.staffid = memberId
        uploadvideo.title = titlesTextField
        uploadvideo.FileName = "video"
        
        print("yearAndSectionModalStr", uploadvideo)
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.SendVideoToEntireCollege,
            httpMethod: .post,
            queryParam: nil,
            requestBody: uploadvideo
        ) { [weak self] (result: Result<EntierVideoUploadResponce, Error>) in
            
            guard let self = self else { return }
            
            switch result {
                
            case .success(let particular):
                
                self.videoUploadEntier = particular.data ?? []
                
                if particular.Status == 1 {
                    
                    let refreshAlert = UIAlertController(
                        title: "",
                        message: particular.Message,
                        preferredStyle: .alert
                    )
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                        
                        if self.priority == "p2" || self.priority == "p3" {
                            
                            let vc = SenderVideoHomePageViewController()
                            vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                            vc.strName = self.strName
                            vc.str = self.str
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true)
                            
                        } else {
                            
                            let vc = SenderVideoHomePageViewController()
                            vc.view.backgroundColor = UIColor(named: "Principal")
                            vc.strName = self.strName
                            vc.str = self.str
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true)
                        }
                    }))
                    
                    self.present(refreshAlert, animated: true)
                    
                } else {
                    
                    let refreshAlert = UIAlertController(
                        title: "",
                        message: particular.Message,
                        preferredStyle: .alert
                    )
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                        
                        if self.priority == "p2" || self.priority == "p3" {
                            
                            let vc = SenderVideoHomePageViewController()
                            vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                            vc.strName = self.strName
                            vc.str = self.str
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true)
                            
                        } else {
                            
                            let vc = SenderVideoHomePageViewController()
                            vc.view.backgroundColor = UIColor(named: "Principal")
                            vc.strName = self.strName
                            vc.str = self.str
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true)
                        }
                    }))
                    
                    refreshAlert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: { _ in
                        print("Handle Cancel Logic here")
                    }))
                    
                    self.present(refreshAlert, animated: true)
                }
                
            case .failure(let error):
                print("API Error:", error.localizedDescription)
            }
        }
    }
    
    
    @IBAction func DepartmentVc(){
        
        
        let  vc = MyDeparmentViewController(nibName: nil, bundle: nil)
        vc.aws = ImagePdfAws
        vc.imagePdfFileType = fileType
        vc.titlesText = titlesTextField
        vc.discreptionsTextField = discreptionss
        vc.eventDate = eventDate
        vc.eventVenu = venumtextField
        vc.resivre = resivre
        vc.assigmentDate = assigmentDate
        vc.videoIframe = iframeUrl
        vc.videoVimeoUrl = videoUrl
        vc.AssigmentFileType = AssigmentFileType
        vc.AssigmentMenuAwsUrl = AssigmentMenuAwsUrl
        vc.voiceDuration = voiceDuration
        vc.voiceReplyType = voiceReplyType
        vc.voiceURl = voiceUrl
        vc.str = str
        vc.strName = strName
        vc.EventTime = EventTime
        vc.photoArray = photoArray
        vc.pdfData = pdfData
        vc.is_read_enabled = is_read_enabled
        vc.is_write_enabled = is_write_enabled
        
        
        
        
        if VoiceHstryId == nil{
            
            
        }
        else{
            
            vc.voiceHstryHeaderId = VoiceHstryId
            vc.VoiceHstryId = VoiceHstryId
        }
        
        
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true,completion: nil)
        
        
    }
    
    
    
    @IBAction func YourClassVc(){
        
        
        let  vc = HodRespienViewController(nibName: nil, bundle: nil)
        
        vc.resivre = resivre
        vc.imageFileType = fileType
        vc.titlesTextField = titlesTextField
        vc.discreptionss = discreptionss
        vc.DateLabels = eventDate
        vc.venumtextField = venumtextField
        
        vc.videoURL = videoUrl
        vc.videoIframe = iframeUrl
        vc.voiceUrl = voiceUrl
        
        vc.voiceDuration = voiceDuration
        vc.str = str
        vc.strName = strName
        vc.EventTime = EventTime
        
        vc.assigmentDate = assigmentDate
        vc.AssigmentFileType = AssigmentFileType
        vc.pdfData = pdfData
        vc.photoArray = photoArray
        vc.is_read_enabled = is_read_enabled
        vc.is_write_enabled = is_write_enabled
        
        if VoiceHstryId == nil{
            
            
        }
        else{
            
            vc.VoiceHstryId = VoiceHstryId
            
            
            vc.voiceHstryHeaderId = VoiceHstryId
            
        }
        
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true,completion: nil)
        
        
    }
    
    func entierDepart(){
        
        var entier = EntierCollegeModal()
        
        entier.collegeid = collegeId
        entier.staffid = memberId
        entier.filetype = "1"
        entier.callertype = priority
        entier.isparent =  parentchck.isChecked
        entier.isstaff = staffChck.isChecked
        entier.isstudent = studentChck.isChecked
        entier.messagecontent = titlesTextField
        entier.description = discreptionss
        
        APiCallManager.shared.callApi(
                url: APIEndpoints.SendSMSToEntireCollege,
                httpMethod: .post,
                queryParam: nil,
                requestBody: entier
            ) {[weak self] (result:Result<EntierCollegeResponce, Error>) in
                    
                guard let self = self else { return }
                
                switch result {
                case .success(let success):
                    
                    entierRefName = success.data ?? []
                    
                    if success.Status == 1{
                        
                        let refreshAlert = UIAlertController(title: "", message: success.Message, preferredStyle: UIAlertController.Style.alert)
                        
                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] (action: UIAlertAction!) in
                            
                            if self?.priority == "p2" || self?.priority == "p3" {
                                
                                let vc = CommuniSMSViewController(nibName: nil, bundle: nil)
                                
                                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                                
                                vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
                                vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                                
                                vc.str = self?.str ?? []
                                vc.strName = self?.strName ?? []
                                vc.modalPresentationStyle = .fullScreen
                                self?.present(vc, animated: true , completion: nil)
                            }
                        }))
                        
                        self.present(refreshAlert, animated: true, completion: nil)
                    }else {
                        
                        let refreshAlert = UIAlertController(title: "", message: success.Message, preferredStyle: UIAlertController.Style.alert)
                        
                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: {  (action: UIAlertAction!) in
                            
                        }))
                        self.present(refreshAlert, animated: true, completion: nil)
                    }
                    
                    reloadInputViews()
                    
                case .failure(let failure):
                     print("Error:",failure.localizedDescription)
                    let refreshAlert = UIAlertController(title: "", message: failure.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: {  (action: UIAlertAction!) in
                        
                    }))
                    self.present(refreshAlert, animated: true, completion: nil)
                }
                
                }
    }
    
    
    func NoticeSendSmsEntier() {
        
        var particularNotice = NoticeBoardPartiModal()
        
        particularNotice.noticeboardid = "0"
        particularNotice.description = discreptionss
        particularNotice.receivertype = "1"
        particularNotice.isstaff = staffChck.isChecked
        particularNotice.isstudent = studentChck.isChecked
        particularNotice.isparent = parentchck.isChecked
        particularNotice.processtype = "add"
        particularNotice.receiveridlist = ""
        particularNotice.topic = titlesTextField
        particularNotice.colgid = collegeId
        particularNotice.staffid = memberId
        particularNotice.callertype = priority
        
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.ManageNoticeBoard,
            httpMethod: .post,
            queryParam: nil,
            requestBody: particularNotice
        ) { [weak self] (result: Result<NoticePArticularResponce, Error>) in
            
            guard let self = self else { return }
            
            switch result {
                
            case .success(let particularss):
                    
                    if particularss.Status == 1 {
                        
                        self.particularSms = particularss
                        
                        let refreshAlert = UIAlertController(
                            title: "",
                            message: particularss.Message,
                            preferredStyle: .alert
                        )
                        
                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                            
                            if self.priority == "p2" || self.priority == "p3" {
                                
                                let vc = SenderGraditNoticeBoardMenuViewController()
                                
                                vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                                vc.noticeSegments.backgroundColor = UIColor(named: "HodUnSelector")
                                vc.noticeSegments.selectedSegmentTintColor = UIColor(named: "HodSelector")
                                vc.strName = self.strName
                                vc.str = self.str
                                vc.modalPresentationStyle = .fullScreen
                                self.present(vc, animated: true)
                            }
                        })
                        
                        self.present(refreshAlert, animated: true)
                        
                        self.reloadInputViews()
                        
                    } else {
                        
                        let refreshAlert = UIAlertController(
                            title: "",
                            message: particularss.Message,
                            preferredStyle: .alert
                        )
                        
                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                            
                            if self.priority == "p2" || self.priority == "p3" {
                                
                                let vc = SenderGraditNoticeBoardMenuViewController()
                                
                                vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                                vc.noticeSegments.backgroundColor = UIColor(named: "HodUnSelector")
                                vc.noticeSegments.selectedSegmentTintColor = UIColor(named: "HodSelector")
                                vc.strName = self.strName
                                vc.str = self.str
                                vc.modalPresentationStyle = .fullScreen
                                self.present(vc, animated: true)
                            }
                        })
                        
                        self.present(refreshAlert, animated: true)
                        
                        self.reloadInputViews()
                    }
                
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func EventEntier() {
        
        var particular = EventParticualrModal()
        print("events")
        
        particular.eventid = "0"
        particular.eventbody = titlesTextField
        particular.eventdate = eventDate
        particular.eventvenue = venumtextField
        particular.eventtime = EventTime
        particular.eventtopic = discreptionss
        particular.processtype = "add"
        particular.collegeid = collegeId
        particular.staffid = memberId
        particular.Callertype = priority
        particular.receivertype = "1"
        particular.isparent = parentchck.isChecked
        particular.isstaff = staffChck.isChecked
        particular.isstudent = studentChck.isChecked
        particular.receiveridlist = ""
        
        print("yearAndSectionModalStr", particular)
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.ManageEvents,
            httpMethod: .post,
            queryParam: nil,
            requestBody: particular
        ) { [weak self] (result: Result<[EventParticularResponce], Error>) in
            
            guard let self = self else { return }
            
            switch result {
                
            case .success(let particularResponse):
                
                for i in particularResponse {
                    
                    if i.Status == 1 {
                        
                        let refreshAlert = UIAlertController(
                            title: "",
                            message: i.Message,
                            preferredStyle: .alert
                        )
                        
                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                            
                            if self.priority == "p2" || self.priority == "p3" {
                                
                                let vc = SenderEventHomePageViewController()
                                
                                vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                                vc.eventSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                                vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                                vc.strName = self.strName
                                vc.str = self.str
                                vc.modalPresentationStyle = .fullScreen
                                
                                self.present(vc, animated: true)
                            }
                        })
                        
                        self.present(refreshAlert, animated: true)
                        
                        self.reloadInputViews()
                        
                    } else {
                        
                        let refreshAlert = UIAlertController(
                            title: "",
                            message: i.Message,
                            preferredStyle: .alert
                        )
                        
                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                            
                            if self.priority == "p2" || self.priority == "p3" {
                                
                                let vc = SenderEventHomePageViewController()
                                
                                vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                                vc.eventSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                                vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                                vc.strName = self.strName
                                vc.str = self.str
                                vc.modalPresentationStyle = .fullScreen
                                
                                self.present(vc, animated: true)
                            }
                        })
                        
                        self.present(refreshAlert, animated: true)
                        
                        self.reloadInputViews()
                    }
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func ImagePdfEntier(){
        
        var imageAryy : [FileNameImage] = []
        
        for i in awsArry{
            var imageAws = FileNameImage()
            imageAws.FileName = i
            imageAryy.append(imageAws)
        }
        
        var sendImagePdfEntier = SendImagePdfModal()
        
        sendImagePdfEntier.Staffid = memberId
        sendImagePdfEntier.collegeid = collegeId
        sendImagePdfEntier.callertype = priority
        sendImagePdfEntier.isparent = parentchck.isChecked
        sendImagePdfEntier.isstudent = studentChck.isChecked
        sendImagePdfEntier.isstaff = staffChck.isChecked
        sendImagePdfEntier.fileduration = "0"
        sendImagePdfEntier.Description = discreptionss
        sendImagePdfEntier.title = titlesTextField
        sendImagePdfEntier.filetype = fileType
        sendImagePdfEntier.FileNameArray = imageAryy
        
        print("yearAndSectionModalStr", sendImagePdfEntier)
        
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.SendImageOrPDFToEntireCollegeWithCloudURL,
            httpMethod: .post,
            queryParam: nil,
            requestBody: sendImagePdfEntier
        ) { [weak self] (result: Result<SendImagePdfResponce, Error>) in
            
            guard let self = self else { return }
            
            switch result {
                
            case .success(let enierImagePdf):
                
                self.imagePdfEniter = enierImagePdf.data ?? []
                
                let refreshAlert = UIAlertController(
                    title: "",
                    message: enierImagePdf.Message,
                    preferredStyle: .alert
                )
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                    
                    if self.priority == "p2" || self.priority == "p3" {
                        
                        let vc = SenderImagePdfHomePageViewController()
                        
                        vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                        
                        vc.imageSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                        vc.imageSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                        vc.strName = self.strName
                        vc.str = self.str
                        vc.modalPresentationStyle = .fullScreen
                        
                        self.present(vc, animated: true)
                    }
                })
                
                self.present(refreshAlert, animated: true)
                self.reloadInputViews()
                
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    func assigmentImagePdf(){
        
        var assigmet : [FileNameArray] = []
        
        for i in awsArry{
            var imagePdfFileArry = FileNameArray()
            imagePdfFileArry.FileName = i
            assigmet.append(imagePdfFileArry)
        }
        
        var imagePdf = assigmentImagePdfModal()
        
        imagePdf.collegeid = collegeId
        imagePdf.sectionid = ""
        imagePdf.processtype = "add"
        imagePdf.staffid = memberId
        imagePdf.assignmentdescription = discreptionss
        imagePdf.assignmentid = "0"
        imagePdf.assignmenttopic = titlesTextField
        imagePdf.assignmenttype = AssigmentFileType
        imagePdf.callertype = priority
        imagePdf.courseid = ""
        imagePdf.receiverid = ""
        imagePdf.receivertype = "1"
        imagePdf.subjectid = "144"
        imagePdf.yearid = ""
        imagePdf.submissiondate = assigmentDate
        imagePdf.fileNameArray = assigmet
        
        print("yearAndSectionModalStr", imagePdf)
        
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.ManageAssignmentWithCloudURL,
            httpMethod: .post,
            queryParam: nil,
            requestBody: imagePdf
        ) { [weak self] (result: Result<[assigmentImagePdfResponce], Error>) in
            
            guard let self = self else { return }
            
            switch result {
                
            case .success(let particularss):
                
                for i in particularss{
                    
                    self.assigmentImagPdf = particularss
                    
                    let refreshAlert = UIAlertController(
                        title: "",
                        message: i.Message,
                        preferredStyle: .alert
                    )
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                        
                        if self.priority == "p2" || self.priority == "p3" {
                            
                            let vc = SenderAssigmentHomePageViewController()
                            
                            vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                            
                            vc.assigmentSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                            vc.assigmentSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                            vc.strName = self.strName
                            vc.str = self.str
                            vc.modalPresentationStyle = .fullScreen
                            
                            self.present(vc, animated: true)
                        }
                    })
                    
                    self.present(refreshAlert, animated: true)
                    
                    self.reloadInputViews()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func cancelVc(){
        
        
        DefaultsKeys.resiverId.removeAll()
        dismiss(animated: true)
    }
    
    
    
    
    
    
    
  func getImageURL(images: [UIImage]) {
    
        self.originalImagesArray = images
        self.totalImageCount = images.count
            if currentImageCount < images.count {
               
                self.uploadAWS(image: images[currentImageCount])
            } else {
                print("All images uploaded. Final URLs: \("")")
                // Handle final uploaded URLs (e.g., send them to the server or update the UI)
            }
    }

    func uploadAWS(image: UIImage) {
        let currentTimeStamp = NSString.init(format: "%ld", Date() as CVarArg)
        let imageNameWithoutExtension = NSString.init(format: "vc_%@", currentTimeStamp)
        let imageName = NSString.init(format: "%@%@", imageNameWithoutExtension, ".png")
        let ext = imageName as String
        let imageURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(ext)

        if let data = image.jpegData(compressionQuality: 0.9) {
            do {
                try data.write(to: imageURL)
            } catch {
                print("Error writing image data to file: \(error)")
                return
            }
        }

        AWSPreSignedURL.shared.fetchPresignedURL(
            bucket: DefaultsKeys.S3BucketName,
            fileName: imageURL,
            bucketPath: collegeId,
            fileType: "image"
        ) { [self] result in
            switch result {
            case .success(let awsResponse):
                print("Presigned URL fetched: \(awsResponse.data?.presignedUrl)")
                let presignedURL = awsResponse.data?.presignedUrl
                let UploadPDf = awsResponse.data?.fileUrl
              
                AWSUploadManager.shared.uploadImageToAWS(image: image, presignedURL: presignedURL!) { result in
                    switch result {
                    case .success(let uploadedURL):
                        print("Image uploaded successfully: \(uploadedURL)")
                        self.awsArry.append(UploadPDf ?? "")
                    case .failure(let error):
                        print("Failed to upload image: \(error.localizedDescription)")
                    }
        
                 
                    self.currentImageCount += 1
                      if self.currentImageCount < self.totalImageCount {
                          
                          DispatchQueue.main.async {
                              self.getImageURL(images: self.originalImagesArray)
                              print("getImageURL",self.getImageURL)
                          }
                       } else {
                           print("All images uploaded. Final URLs: \(imageUrlArray)")
                           // Handle final uploaded URLs (e.g., send them to the server or update the UI
                           
                           self.convertedImagesUrlArray = self.imageUrlArray
                          
                           }
                          }
           
            case .failure(let error):
                print("Error fetching presigned URL: \(error.localizedDescription)")
            }
        }
        
   
       
    }
    
    
    

    func uploadPDFFileToAWS(pdfData : NSData){
//        self.showLoading()
        let currentTimeStamp = NSString.init(format: "%ld",Date() as CVarArg)
        let imageNameWithoutExtension = NSString.init(format: "vc_%@",currentTimeStamp)
        let imageName = NSString.init(format: "%@%@",imageNameWithoutExtension, ".pdf")
        let ext = imageName as String
        let fileName = imageNameWithoutExtension
        let fileType = ".pdf"
        let imageURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(ext)
        do {
            try pdfData.write(to: imageURL)
        }
        catch {}
        print(imageURL)
       
      
        
      
                       
        
        AWSPreSignedURL.shared.fetchPresignedURL(
            bucket: DefaultsKeys.S3BucketName,
            fileName: imageURL,
            bucketPath: collegeId,
            fileType: "application"
        ) { [self] result in
            switch result {
            case .success(let awsResponse):
                print("Presigned URL fetched: \(awsResponse.data?.presignedUrl)")
                let presignedURL = awsResponse.data?.presignedUrl
                let UploadPDf = awsResponse.data?.fileUrl
              
                AWSUploadManager.shared.uploadPDFAWSUsingPresignedURL(pdfData: pdfData as Data, presignedURL:presignedURL! ){ [self] result in
                    
                    switch result {
                    case .success(let uploadedURL):
                        print("Image uploaded successfully: \(uploadedURL)")
                        self.awsArry.append(UploadPDf ?? "")
                    case .failure(let error):
                        print("Failed to upload image: \(error.localizedDescription)")
                    }
        
                   
                    
                   
                    
                    awsArry.append(UploadPDf!)
                    let imageDict = NSMutableDictionary()
                    imageDict["FileName"] = UploadPDf
                    self.imageUrlArray.add(imageDict)
                    self.convertedImagesUrlArray = self.imageUrlArray
                    
                    
                    
//                    
//                    if  MenuType == "5"{
//                        
//                        ImagePdfParticular(ImageFile: awsArry)
//                        
//                        
//                    }
//                    
//                    else if MenuType == "6"      ||   MenuType == "6" {
//                        
//                        
//                        assigmentImagePdf(imageArry : awsArry)
//                        
//                        
//                        
//                    }
//                    
//                    else if  MenuType == "1"{
//                        
//                        self.NoticeSendSmsToParticular(ImageFile: awsArry)
//                        //
//                        
//                        
//                  
//                }
                             
                   
                          }
           
            case .failure(let error):
                print("Error fetching presigned URL: \(error.localizedDescription)")
            }
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // AWS image Upload Part
    
    
//    func getImageURL(images : [UIImage]){
//        self.originalImagesArray = images
//        self.totalImageCount = images.count
//        if currentImageCount < images.count{
//            uploadAWS(image: images[currentImageCount])
//            
//        }
//    }
//    
//    
//    
//    
//    
//    func uploadAWS(image : UIImage){
//        
//        
//        
//        
//        var colgId : String!
//        let defaults = UserDefaults.standard
//        colgId = defaults.string(forKey: DefaultsKeys.collegeid)
//        
//        let S3BucketName =  DefaultsKeys.S3BucketName
//        let CognitoPoolID =  DefaultsKeys.CognitoPoolID
//        let Region = AWSRegionType.APSouth1
//        
//        let credentialsProvider = AWSCognitoCredentialsProvider(regionType:Region,identityPoolId:CognitoPoolID)
//        let configuration = AWSServiceConfiguration(region:Region, credentialsProvider:credentialsProvider)
//        AWSServiceManager.default().defaultServiceConfiguration = configuration
//        
//        let currentTimeStamp = NSString.init(format: "%ld",Date() as CVarArg)
//        let imageNameWithoutExtension = NSString.init(format: "vc_%@",currentTimeStamp)
//        let imageName = NSString.init(format: "%@%@",imageNameWithoutExtension, ".jpg")
//        let dateFormatter = DateFormatter()
//        
//        dateFormatter.dateFormat = "dd-MM-yyyy"
//        
//        let  currentDate =   dateFormatter.string(from: Date())
//        
//        
//        
//        
//        
//        
//        let ext = imageName as String
//        
//        let fileName = imageNameWithoutExtension
//        let fileType = ".jpg"
//        
//        let imageURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(ext)
//        let data = image.jpegData(compressionQuality: 0.9)
//        do {
//            try data?.write(to: imageURL)
//        }
//        catch {}
//        
//        print(imageURL)
//        
//        let uploadRequest = AWSS3TransferManagerUploadRequest()
//        uploadRequest?.body = imageURL
//        uploadRequest?.key = colgId + "/" + currentDate +  "/" + "File_" + ext
//        uploadRequest?.bucket = S3BucketName
//        uploadRequest?.contentType = ".jpg"
//        
//        
//        // upload
//        
//        let transferManager = AWSS3TransferManager.default()
//        transferManager.upload(uploadRequest!).continueWith { [self] (task) -> AnyObject? in
//            
//            if let error = task.error {
//                print("Upload failed : (\(error))")
//            }
//            
//            if task.result != nil {
//                
//                let url = AWSS3.default().configuration.endpoint.url
//                let publicURL = url?.appendingPathComponent((uploadRequest?.bucket!)!).appendingPathComponent((uploadRequest?.key!)!)
//                if  let absoluteString = publicURL?.absoluteString {
//                    print("Uploaded to:\(absoluteString)")
//                    print("Uploaded to:\(absoluteString)")
//                    
//                    absoluteStringImg = absoluteString
//                    awsArry.append(absoluteStringImg)
//                    let imageDict = NSMutableDictionary()
//                    imageDict["FileName"] = absoluteString
//                    self.imageUrlArray.add(imageDict)
//                    self.currentImageCount = self.currentImageCount + 1
//                    if self.currentImageCount < self.totalImageCount{
//                        DispatchQueue.main.async {
//                            self.getImageURL(images: self.originalImagesArray)
//                        }
//                    }else{
//                        self.convertedImagesUrlArray = self.imageUrlArray
//                        
//                        
//                    }
//                    
//                    
//                    
//                    
//                }
//            }
//            else {
//                print("Unexpected empty result.")
//            }
//            return nil
//        }
//    }
//    
//    
//    
//    func uploadPDFFileToAWS(pdfData : NSData){
//        
//        
//        
//        var colgId : String!
//        let defaults = UserDefaults.standard
//        colgId = defaults.string(forKey: DefaultsKeys.collegeid)
//        
//        
//        let S3BucketName =  DefaultsKeys.S3BucketName
//        let CognitoPoolID =  DefaultsKeys.CognitoPoolID
//        let Region = AWSRegionType.APSouth1
//        
//        let credentialsProvider = AWSCognitoCredentialsProvider(regionType:Region,identityPoolId:CognitoPoolID)
//        let configuration = AWSServiceConfiguration(region:Region, credentialsProvider:credentialsProvider)
//        AWSServiceManager.default().defaultServiceConfiguration = configuration
//        
//        // url for image in the bundle
//        
//        let currentTimeStamp = NSString.init(format: "%ld",Date() as CVarArg)
//        let imageNameWithoutExtension = NSString.init(format: "vc_%@",currentTimeStamp)
//        let imageName = NSString.init(format: "%@%@",imageNameWithoutExtension, ".pdf")
//        
//        
//        
//        let ext = imageName as String
//        
//        
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "dd-MM-yyyy"
//        
//        let  currentDate =   dateFormatter.string(from: Date())
//        
//        
//        let fileName = imageNameWithoutExtension
//        let fileType = ".pdf"
//        
//        let imageURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(ext)
//        
//        do {
//            try pdfData.write(to: imageURL)
//        }
//        catch {}
//        
//        print(imageURL)
//        
//        let uploadRequest = AWSS3TransferManagerUploadRequest()
//        uploadRequest?.body = imageURL
//        uploadRequest?.key = colgId + "/" + currentDate +  "/" + "File_" + ext
//        uploadRequest?.bucket = S3BucketName
//        
//        uploadRequest?.contentType = "application/pdf"
//        // upload
//        
//        let transferManager = AWSS3TransferManager.default()
//        transferManager.upload(uploadRequest!).continueWith { [self] (task) -> AnyObject? in
//            
//            if let error = task.error {
//                print("Upload failed : (\(error))")
//                
//            }
//            
//            if task.result != nil {
//                let url = AWSS3.default().configuration.endpoint.url
//                let publicURL = url?.appendingPathComponent((uploadRequest?.bucket!)!).appendingPathComponent((uploadRequest?.key!)!)
//                if let absoluteString = publicURL?.absoluteString {
//                    print("Uploaded to:\(absoluteString)")
//                    
//                    
//                    awsArry.append(absoluteString)
//                    let imageDict = NSMutableDictionary()
//                    imageDict["FileName"] = absoluteString
//                    self.imageUrlArray.add(imageDict)
//                    self.convertedImagesUrlArray = self.imageUrlArray
//                    
//                    
//                }
//            }
//            else {
//                //                
//                print("Unexpected empty result.")
//            }
//            return nil
//        }
//    }
//    
    
    
}



