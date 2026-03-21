//
//  MyDeparmentViewController.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 14/03/23.
//

import UIKit
import ObjectMapper
import DropDown
import Alamofire
import KRProgressHUD
import AWSS3
@available(iOS 16.0, *)
class MyDeparmentViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var specifyStudView: UIViewX!
    @IBOutlet weak var entierDepartView: UIViewX!
    
    @IBOutlet weak var staffDeafultlbl: UILabel!
    @IBOutlet weak var entierDepartLabel: UILabel!
    @IBOutlet weak var tabelTop: NSLayoutConstraint!
    
    @IBOutlet weak var targetTop: NSLayoutConstraint!
    @IBOutlet weak var allCheckbox: CheckBoxTwo!
    @IBOutlet weak var YearDropDowView: UIViewX!
    
    @IBOutlet weak var parentchck: CheckBoxTwo!
    
    @IBOutlet weak var sendView: UIViewX!
    
    @IBOutlet weak var staffTraling: NSLayoutConstraint!
    
    @IBOutlet weak var studentChck: CheckBoxTwo!
    @IBOutlet weak var yearSectionLabel: UILabel!
    
    @IBOutlet weak var courseLabel: UILabel!
    
    
    @IBOutlet weak var yearDropdownLabel: UILabel!
    @IBOutlet weak var entierDepartmentChkBx: CheckBoxTwo!
    
    @IBOutlet weak var cancelView: UIViewX!
    
    @IBOutlet weak var courseView: UIViewX!
    
    @IBOutlet weak var allChckbox: CheckBoxTwo!
    @IBOutlet weak var tv: UITableView!
    
    @IBOutlet weak var staffChckbox: CheckBoxTwo!
    @IBOutlet weak var YearView: UIViewX!
    
    @IBOutlet weak var paresntDefaultLbl: UILabel!
    var identifier = "MydeparmentTvCellTableViewCell"
    var identifer2 = "MydeparmentHeaderFooterView"
    
    var courseRefName : [getCourseDataDetails] = []
    var yearRefName : [YearAndSectionListData] = []
    var yreRef : [sectionDetailsData] = []
    var particularSms : [SmsdataDetails] = []
    var  imagePdfEniter : [sendImagePdfPartiDataDetails] = []
    var assigmentImagPdf : assigmentImagePdfResponce?
    var sendVideoPart : [ParticularVideoUploadRespData] = []
    
    var entierRefName : [EntiercollegeDataDetails] = []
    var particularSmsEnt : NoticePArticularResponce?
    var imagePdfEniterEnt : [sendImagePdfDataDetails] = []
    var assigmentImagPdfEnt : [assigmentImagePdfResponce] = []
    var titlesText : String!
    
    var nameString  : String!
    var yearAndSectionNameString : String!
    var discreptionsTextField : String!
    var SectionId : [String] = []
    var resiverId : [String] = []
    var yearAndSecResiverId : [Int] = []
    var counts : [String] = []
    var myString : [String] = []
    let dropDown = DropDown()
    var memberId : String!
    var collegeId : String!
    var departmentId : String!
    var course : String!
    var priority : String!
    
    var Receivertype = "2"
    
    var resivre : String!
    
    var sections : String!
    var aws : String!
    var imagePdfFileType : String!
    var eventDate : String!
    var eventVenu : String!
    var sectionHeaderId : String!
    var assigmentDate : String!
    
    var videoVimeoUrl : String!
    
    var videoIframe : String!
    
    var videoUploadEntier : [EntierVideoUploadDataDetails] = []
    
    var AssigmentFileType : String!
    
    var AssigmentMenuAwsUrl : String!
    
    var voiceDuration : String!
    var voiceReplyType : String!
    var voiceURl : URL!
    
    var str : [String] = []
    var strName : [String] = []
    
    var EntierdepartId : String!
    
    
    var sectionId : String!
    var courseId : String!
    
    var EventTime : String!
    
    var imagePicker = UIImagePickerController()
    var currentImageCount = 0
    var totalImageCount = 0
    var originalImagesArray = [UIImage]()
    var absoluteStringImg : String!
    var imageUrlArray = NSMutableArray()
    var convertedImagesUrlArray = NSMutableArray()
    
    var photoArray = [UIImage]()
    var pdfData : Data? = nil
    
    var awsArry : [String] = []
    
    var YearIDArry : [String] = []
    var sectionIDForSpecify = ""
    var YearIDForSpecify = ""
    var is_parent_target_enabled : String!
    var is_read_enabled : String!
    var is_write_enabled : String!
    var VoiceHstryId : String!
    var voiceHstryHeaderId : String!
    var YearIdForSpeficStudent  : Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        
        print("jresivre,",photoArray)
        
        YearDropDowView.isHidden = true
        tv.isHidden = true
        specifyStudView.isHidden = true
        targetTop.constant = -40
        let defaults = UserDefaults.standard
        
        course = defaults.string(forKey: DefaultsKeys.courseid)
        
        memberId = defaults.string(forKey: DefaultsKeys.memberid)
        
        collegeId = defaults.string(forKey: DefaultsKeys.collegeid)
        departmentId = defaults.string(forKey: DefaultsKeys.deptid)
        
        priority = defaults.string(forKey: DefaultsKeys.priority)
        
        is_parent_target_enabled = defaults.string(forKey: DefaultsKeys.is_parent_target_enabled)!
        
        
        if  is_parent_target_enabled == "0"{
            
            
            
            parentchck.isHidden = true
            
            
            paresntDefaultLbl.isHidden = true
            
            staffTraling.constant = -80
        }
        
        else{
            
            paresntDefaultLbl.isHidden = false
            
            parentchck.isHidden = false
            
            staffTraling.constant = 10
        }
        
        
        let rownib = UINib(nibName: identifier, bundle: nil)
        tv.register(rownib, forCellReuseIdentifier: identifier)
        
        let rownib2 = UINib(nibName: identifer2, bundle: nil)
        tv.register(rownib2, forHeaderFooterViewReuseIdentifier: identifer2)
        
        
        let cancel = UITapGestureRecognizer(target: self, action: #selector(CancelVc))
        
        cancelView.addGestureRecognizer(cancel)
        
        
        let course = UITapGestureRecognizer(target: self, action: #selector(courseVc))
        
        courseView.addGestureRecognizer(course)
        
        
        let send = UITapGestureRecognizer(target: self, action: #selector(sendVc))
        
        sendView.addGestureRecognizer(send)
        
        
        let yearView = UITapGestureRecognizer(target: self, action: #selector(YearVc))
        
        YearView.addGestureRecognizer(yearView)
        
        
        let year = UITapGestureRecognizer(target: self, action: #selector(DropDownVc))
        
        YearDropDowView.addGestureRecognizer(year)
        
        
        let entierDepart = UITapGestureRecognizer(target: self, action: #selector(DepartmentVc))
        
        entierDepartView.addGestureRecognizer(entierDepart)
        
        
        
        let Allbox = UITapGestureRecognizer(target: self, action: #selector(allCheckboxvc))
        allCheckbox.addGestureRecognizer(Allbox)
        
        let studentCheckBox = UITapGestureRecognizer(target: self, action: #selector(StudentCheckBoxVc))
        studentChck.addGestureRecognizer(studentCheckBox)
        
        let parentCheckBox = UITapGestureRecognizer(target: self, action: #selector(parentCheckBoxVc))
        parentchck.addGestureRecognizer(parentCheckBox)
        
        
        let staffCheckBox = UITapGestureRecognizer(target: self, action: #selector(staffCheckBoxVC))
        staffChckbox.addGestureRecognizer(staffCheckBox)
        
    }
    
    
    
    
    @IBAction func StudentCheckBoxVc(){
        
        
        if studentChck.isChecked == true{
            
            
            
            studentChck.isChecked = false
            
            
            studentChck.setImage(UIImage.init(named: "checkboxs"), for: .normal)
            
            
            allCheckbox.isChecked = false
            
        }
        //
        else if studentChck.isChecked == false{
            
            
            studentChck.isChecked = true
            print("okkkd",studentChck.isChecked)
            studentChck.setImage(UIImage.init(named: "done"), for: .normal)
            
            
            if is_parent_target_enabled == "0"{
                
                if   studentChck.isChecked == true   && staffChckbox.isChecked == true{
                    
                    allCheckbox.isChecked = true
                    
                }
                
            }
            
            else{
                
                
                if   studentChck.isChecked == true  && parentchck.isChecked == true && studentChck.isChecked == true{
                    
                    allCheckbox.isChecked = true
                    
                }
            }
            
            //
            
        }
        
        
        
        
        
    }
    
    
    @IBAction func parentCheckBoxVc(){
        
        
        
        if parentchck.isChecked == true{
            
            parentchck.isChecked = false
            parentchck.setImage(UIImage.init(named: "checkboxs"), for: .normal)
            //
            allCheckbox.isChecked = false
            
            print("UNCheck")
            
            
        } else if parentchck.isChecked == false  {
            
            parentchck.isChecked = true
            parentchck.setImage(UIImage.init(named: "done"), for: .normal)
            
            
            
            if is_parent_target_enabled == "0"{
                
                if   studentChck.isChecked == true   && staffChckbox.isChecked == true{
                    
                    allCheckbox.isChecked = true
                    
                }
                
            }
            
            else{
                
                
                if   studentChck.isChecked == true  && parentchck.isChecked == true && studentChck.isChecked == true{
                    
                    allCheckbox.isChecked = true
                    
                }
            }
            
            
            
            
        }
        
        
        
        
    }
    
    
    
    @IBAction func staffCheckBoxVC(){
        
        
        
        
        if staffChckbox.isChecked == true {
            
            staffChckbox.isChecked = false
            staffChckbox.setImage(UIImage.init(named: "checkboxs"), for: .normal)
            allCheckbox.isChecked = false
            
        } else if  staffChckbox.isChecked == false {
            
            staffChckbox.isChecked = true
            staffChckbox.setImage(UIImage.init(named: "done"), for: .normal)
            
            
            
            if is_parent_target_enabled == "0"{
                
                if   studentChck.isChecked == true   && staffChckbox.isChecked == true{
                    
                    allCheckbox.isChecked = true
                    
                }
                
            }
            
            else{
                
                
                if   studentChck.isChecked == true  && parentchck.isChecked == true && studentChck.isChecked == true{
                    
                    allCheckbox.isChecked = true
                    
                }
            }
            
        }
        
        
        
    }
    
    
    
    
    @IBAction func SpecifyVc(ges:specifyStu){
        
        
        if resiverId.count == 1{
            
            
            
            let vc  = SpecificStudentViewController(nibName: nil, bundle: nil)
            vc.textTitle = titlesText
            vc.TextDiscrition = discreptionsTextField
            vc.MenuType = resivre
            
            vc.eventDate = eventDate
            vc.imageFileType = imagePdfFileType
            
            vc.HodYearSpefiy = "12"
            
            vc.courseId = courseId
            
            
            vc.YearId = String(YearIdForSpeficStudent)
            vc.departmentId = departmentId
            vc.sectionId = sectionIDForSpecify
            
            vc.eventVenu = eventVenu
            vc.awsurl = aws
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.videoUrl = videoVimeoUrl
            vc.iframeVideo = videoIframe
            vc.strs = str
            vc.strName = strName
            vc.photoArray = photoArray
            vc.pdfData = pdfData
            vc.VoiceHstryId =  VoiceHstryId
            vc.voiceHstryHeaderId = voiceHstryHeaderId
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true,completion: nil)
            
            //
        }
        
        
        
        else {
            
            
            
            
            
            let refreshAlert = UIAlertController(title: "", message: "Please Select Any One Section", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
                
            }))
            
            
            present(refreshAlert, animated: true, completion: nil)
            
            
        }
    }
    
    
    
    @IBAction func allCheckboxvc(){
        
        
        
        if allCheckbox.isChecked == true{
            //
            //
            //
            allCheckbox.isChecked = false
            allCheckbox.setImage(UIImage.init(named: "checkboxs"), for: .normal)
            parentchck.isChecked = false
            staffChckbox.isChecked =  false
            studentChck.isChecked = false
            
            
            print("UNCheck")
            
            
        } else if allCheckbox.isChecked == false  {
            
            allCheckbox.isChecked = true
            allCheckbox.setImage(UIImage.init(named: "done"), for: .normal)
            //
            parentchck.isChecked = true
            staffChckbox.isChecked =  true
            studentChck.isChecked = true
            print("Check")
            
            
            
        }
        
        
        
        
    }
    
    
    @IBAction func sendVc(){
        
        
        
        if (parentchck.isChecked == false) && (studentChck.isChecked == false) && (staffChckbox.isChecked == false) {
            
            
            
            
            
            
            let refreshAlert = UIAlertController(title: "", message: "Please Select Target", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
                
            }))
            
            
            present(refreshAlert, animated: true, completion: nil)
            
        }
        
        
        
        
        
        else if nameString == ""{
            
            
            
            let refreshAlert = UIAlertController(title: "", message: "Please Select Target", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
                
            }))
            
            
            present(refreshAlert, animated: true, completion: nil)
            
            
            
        }
        
        else if EntierdepartId == "1"{
            
            
            
            let refreshAlert = UIAlertController(title: "", message: "Are you sure you want to submit?", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in
                
                if self.resivre == "1"{
                    
                    
                    
                    
                    if imagePdfFileType == "3"{
                        
                        
                        uploadPDFFileToAWS(pdfData : pdfData! as NSData)
                    }
                    
                    else{
                        
                        
                        
                        
                        
                        getImageURL(images: photoArray)
                        
                        
                        
                        DispatchQueue.main.asyncAfter(deadline: .now()+4.3) { [self] in
                            
                            KRProgressHUD.dismiss()
                            
                            
                            
                            
                            
                            self.NoticeSendSmsEntier(ImageFile: awsArry)
                            
                        }
                        
                        
                    }
                }
                
                else if self.resivre == "2"{
                    
                    print("video")
                    
                    self.SendVideoToParticular()
                    
                    
                }
                
                else if self.resivre == "3"{
                    
                    
                    
                    self.EventEntier()
                    
                }
                
                else if self.resivre == "4"{
                    
                    
                    print("communication")
                    
                    
                    self.SendSmsToParticular()
                }
                
                
                else if self.resivre == "5"{
                    print("imagePdf")
                    
                    
                    if imagePdfFileType == "3"{
                        
                        
                        uploadPDFFileToAWS(pdfData : pdfData! as NSData)
                    }
                    
                    else{
                        
                        
                        
                        
                        
                        getImageURL(images: photoArray)
                        
                        
                        
                        DispatchQueue.main.asyncAfter(deadline: .now()+4.3) { [self] in
                            
                            KRProgressHUD.dismiss()
                            
                            
                            
                            
                            
                            ImagePdfParticular(ImageFile: awsArry)
                            
                        }
                        
                        
                    }
                }
                
                
                else if self.resivre == "6" || resivre == "8"{
                    print("assigment")
                    
                    
                    if AssigmentFileType == "pdf"{
                        
                        
                        uploadPDFFileToAWS(pdfData: pdfData! as NSData)
                        
                    }
                    
                    else if AssigmentFileType == "Text"{
                        
                        
                        assigmentImagePdf()
                        
                    }
                    
                    else{
                        
                        
                        
                        getImageURL(images: photoArray)
                        
                    }
                }
                
                
                else if self.resivre == "11"{
                    
                    if VoiceHstryId == "1"{
                        
                        self.multypartAudio()
                    }else if VoiceHstryId == "2"{
                        
                        self.HistoryVoiceSendParticular()
                    }
                }
                
                
                
                
            }))
            
            
            refreshAlert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: { (action: UIAlertAction!) in
                print("Handle Cancel Logic here")
            }))
            
            present(refreshAlert, animated: true, completion: nil)
            
            
            
            
            
            
            
            
        }
        
        
        
        else {
            
            
            print("tyuioiugfgio", nameString)
            
            if nameString == nil {
                
                
                
                
                let refreshAlert = UIAlertController(title: "", message: "Please Select Target", preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    
                    
                }))
                
                
                present(refreshAlert, animated: true, completion: nil)
                
                
                
                
            }
            
            
            
            else if nameString == ""{
                
                
                
                let refreshAlert = UIAlertController(title: "", message: "Please Select Target", preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    
                    
                }))
                
                
                present(refreshAlert, animated: true, completion: nil)
                
                
                
                
            }
            
            
            else {
                
                
                let refreshAlert = UIAlertController(title: "", message: "Are you sure you want to submit?", preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in
                    
                    if self.resivre == "1"{
                        
                        print("Notice")
                        
                        
                        
                        if imagePdfFileType == "3"{
                            
                            
                            uploadPDFFileToAWS(pdfData : pdfData! as NSData)
                        }
                        
                        else{
                            
                            
                            
                            
                            
                            getImageURL(images: photoArray)
                            
                            
                            
                            DispatchQueue.main.asyncAfter(deadline: .now()+4.3) { [self] in
                                
                                KRProgressHUD.dismiss()
                                
                                
                                
                                
                                
                                self.NoticeSendSmsEntier(ImageFile: awsArry)
                                
                            }
                            
                            
                        }
                        
                    }
                    
                    else if self.resivre == "2"{
                        
                        print("video")
                        
                        self.SendVideoToParticular()
                        
                        
                    }
                    
                    else if self.resivre == "3"{
                        
                        
                        print("event545454454")
                        
                        self.EventEntier()
                        
                    }
                    
                    else if self.resivre == "4"{
                        
                        
                        print("communication")
                        
                        
                        
                        self.SendSmsToParticular()
                    }
                    
                    
                    else if self.resivre == "5"{
                        print("imagePdf")
                        
                        
                        if imagePdfFileType == "3"{
                            print("rrreefdsds")
                            
                            uploadPDFFileToAWS(pdfData : pdfData! as NSData)
                        }
                        
                        else{
                            
                            print("rrreereewew")
                            getImageURL(images : photoArray)
                            DispatchQueue.main.asyncAfter(deadline: .now()+4.3) { [self] in
                                
                                KRProgressHUD.dismiss()
                                
                                
                                
                                
                                
                                ImagePdfParticular(ImageFile: awsArry)
                                
                            }
                            
                        }
                        
                        
                    }
                    
                    
                    else if self.resivre == "6" || resivre == "8"{
                        print("assigment")
                        
                        
                        if AssigmentFileType == "pdf"{
                            
                            
                            uploadPDFFileToAWS(pdfData: pdfData! as NSData)
                            
                        }
                        
                        else if AssigmentFileType == "Text"{
                            
                            
                            assigmentImagePdf()
                            
                        }
                        
                        else{
                            
                            
                            
                            getImageURL(images: photoArray)
                            
                        }
                    }
                    
                    
                    else if self.resivre == "11"{
                        
                        if VoiceHstryId == "1"{
                            
                            self.multypartAudio()
                        }else if VoiceHstryId == "2"{
                            
                            self.HistoryVoiceSendParticular()
                        }
                    }
                    
                    
                    
                    
                }))
                
                
                refreshAlert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: { (action: UIAlertAction!) in
                    print("Handle Cancel Logic here")
                }))
                
                present(refreshAlert, animated: true, completion: nil)
                
                
                
            }
        }
        
    }
    
    func HistoryVoiceSendParticular() {
        
        var voiceUpload = VoiceHstryModal()
        
        voiceUpload.staffid = memberId
        voiceUpload.description = discreptionsTextField
        voiceUpload.callertype = priority
        voiceUpload.collegeid = collegeId
        voiceUpload.forwarding_voice_id = voiceHstryHeaderId
        
        if EntierdepartId == "1"{
            voiceUpload.receiverid = departmentId
            voiceUpload.receivertype = "3"
        }else if EntierdepartId == "2"{
            voiceUpload.receivertype = "2"
            voiceUpload.receiverid = nameString
        }else if EntierdepartId == "3"{
            voiceUpload.receiverid = nameString
            voiceUpload.receivertype = "5"
        }
        
        if is_parent_target_enabled == "0"{
            
            voiceUpload.isparent = false
        }else{
            
            voiceUpload.isparent = parentchck.isChecked
        }
        
        voiceUpload.isemergencyvoice = voiceReplyType
        voiceUpload.isstaff = false
        voiceUpload.isstudent = studentChck.isChecked
        
        
        APiCallManager.shared.callApi(
                url: APIEndpoints.SendVoiceToParticularTypeFromHistory,
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
    
    
    
//    func multypartAudio() {
//        
//        
//        var vimeoVideoEndpoint = "https://gradit.voicesnap.com/api/AppDetailsBal/SendFileToParticularType"
//        
//        var voiceUpload = particularVoiceUploadMoad()
//        
//        voiceUpload.staffid = memberId
//        voiceUpload.description = discreptionsTextField
//        voiceUpload.callertype = priority
//        voiceUpload.collegeid = collegeId
//        voiceUpload.fileduration = voiceDuration
//        voiceUpload.filetype = "1"
//        voiceUpload.isemergencyvoice = voiceReplyType
//        voiceUpload.isparent = parentchck.isChecked
//        voiceUpload.isstaff = false
//        voiceUpload.isstudent = studentChck.isChecked
//        
//        if EntierdepartId == "1"{
//            
//            voiceUpload.receiverid = departmentId
//            
//            voiceUpload.receivertype = "3"
//        }
//        
//        else if EntierdepartId == "2"{
//            
//            voiceUpload.receivertype = "2"
//            voiceUpload.receiverid = nameString
//        }
//        
//        else if EntierdepartId == "3"{
//            
//            voiceUpload.receiverid = nameString
//            
//            voiceUpload.receivertype = "5"
//        }
//        
//        let voiceUploadStr = voiceUpload.toJSONString()
//        
//        print("chatSenderStr",voiceUpload)
//        
//        
//        AF.upload(multipartFormData: { [self] (multipartFormData) in
//            
//            KRProgressHUD.show()
//            
//            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//                
//                KRProgressHUD.dismiss()
//                
//            }
//            
//            var videoU : String!
//            
//            let pathURL = voiceURl
//            
//            let pathString = pathURL!.path
//            
//            multipartFormData.append(URL(fileURLWithPath: pathString), withName: "file")
//            
//            multipartFormData.append(Data(voiceUploadStr!.description.utf8), withName: "info")
//            
//            print("parameters.description.utf8",voiceUploadStr!.description.utf8)
//            
//            
//        },to: vimeoVideoEndpoint).responseJSON{
//           
//            res in
//            
//            let json_str = String(data: res.data!, encoding: .utf8)
//            
//            print("json \(json_str!)")
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
//                            let refreshAlert = UIAlertController(title: "", message: a as! String, preferredStyle: UIAlertController.Style.alert)
//                            
//                            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in
//                                
//                                if priority == "p2" || priority == "p3" {
//                                    
//                                    let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
//                                    vc.is_read_enabled = is_read_enabled
//                                    vc.is_write_enabled = is_write_enabled
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
//                                }else{
//                                    
//                                    let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
//                                    vc.is_read_enabled = is_read_enabled
//                                    vc.is_write_enabled = is_write_enabled
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
//                            }))
//                            
//                            self.present(refreshAlert, animated: true, completion: nil)
//                            
//                        }
//                        else {
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
//                                    vc.is_read_enabled = is_read_enabled
//                                    vc.is_write_enabled = is_write_enabled
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
//                                }else{
//                                    
//                                    let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
//                                    vc.is_read_enabled = is_read_enabled
//                                    vc.is_write_enabled = is_write_enabled
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
//                            }))
//                            
//                            self.present(refreshAlert, animated: true, completion: nil)
//                            
//                        }
//                        
//                    }
//                }
//            } catch {
//                print("Error parsing JSON: \(error)")
//            }
//            
//        }
//        
//    }
    
    func multypartAudio() {
        
        let vimeoVideoEndpoint = "https://gradit.voicesnap.com/api/AppDetailsBal/SendFileToParticularType"
        
        var voiceUpload = particularVoiceUploadMoad()
        
        voiceUpload.staffid = memberId
        voiceUpload.description = discreptionsTextField
        voiceUpload.callertype = priority
        voiceUpload.collegeid = collegeId
        voiceUpload.fileduration = voiceDuration
        voiceUpload.filetype = "1"
        voiceUpload.isemergencyvoice = voiceReplyType
        voiceUpload.isparent = parentchck.isChecked
        voiceUpload.isstaff = false
        voiceUpload.isstudent = studentChck.isChecked
        
        if EntierdepartId == "1"{
            voiceUpload.receiverid = departmentId
            voiceUpload.receivertype = "3"
        }
        else if EntierdepartId == "2"{
            voiceUpload.receivertype = "2"
            voiceUpload.receiverid = nameString
        }
        else if EntierdepartId == "3"{
            voiceUpload.receiverid = nameString
            voiceUpload.receivertype = "5"
        }
        
        // Codable instead of toJSONString
        let voiceUploadStr: String
        do {
            let jsonData = try JSONEncoder().encode(voiceUpload)
            voiceUploadStr = String(data: jsonData, encoding: .utf8) ?? ""
        } catch {
            print("Encoding error:", error)
            return
        }
        
        print("chatSenderStr", voiceUpload)
        
        KRProgressHUD.show()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            KRProgressHUD.dismiss()
        }
        
        MultipartManager.shared.uploadVoice(
            url: vimeoVideoEndpoint,
            fileURL: voiceURl!,
            infoJSONString: voiceUploadStr,
            
        ) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
                
            case .success(let json):
                
                print("json", json)
                
                if let status = json["Status"] as? Int {
                    
                    DispatchQueue.main.async {
                        
                        if status == 1 {
                            
                            let a = json["Message"]
                            
                            let refreshAlert = UIAlertController(title: "", message: a as? String, preferredStyle: .alert)
                            
                            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
                                
                                guard let self = self else { return }
                                
                                if priority == "p2" || priority == "p3" {
                                    
                                    let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
                                    vc.is_read_enabled = is_read_enabled
                                    vc.is_write_enabled = is_write_enabled
                                    vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                                    vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
                                    vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                                    vc.strName = self.strName
                                    vc.str = self.str
                                    vc.modalPresentationStyle = .fullScreen
                                    self.present(vc, animated: true)
                                    
                                } else {
                                    
                                    let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
                                    vc.is_read_enabled = is_read_enabled
                                    vc.is_write_enabled = is_write_enabled
                                    vc.view.backgroundColor = UIColor(named: "Principal")
                                    vc.CommuniSegementName.backgroundColor = UIColor(named: "UnSelector")
                                    vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "Selector")
                                    vc.strName = self.strName
                                    vc.str = self.str
                                    vc.modalPresentationStyle = .fullScreen
                                    self.present(vc, animated: true)
                                }
                            }))
                            
                            self.present(refreshAlert, animated: true)
                            
                        } else {
                            
                            let a = json["Message"]
                            
                            let refreshAlert = UIAlertController(title: "", message: a as? String, preferredStyle: .alert)
                            
                            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
                                
                                guard let self = self else { return }
                                
                                if priority == "p2" || priority == "p3" {
                                    
                                    let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
                                    vc.is_read_enabled = is_read_enabled
                                    vc.is_write_enabled = is_write_enabled
                                    vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                                    vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
                                    vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                                    vc.strName = self.strName
                                    vc.str = self.str
                                    vc.modalPresentationStyle = .fullScreen
                                    self.present(vc, animated: true)
                                    
                                } else {
                                    
                                    let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
                                    vc.is_read_enabled = is_read_enabled
                                    vc.is_write_enabled = is_write_enabled
                                    vc.view.backgroundColor = UIColor(named: "Principal")
                                    vc.CommuniSegementName.backgroundColor = UIColor(named: "UnSelector")
                                    vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "Selector")
                                    vc.strName = self.strName
                                    vc.str = self.str
                                    vc.modalPresentationStyle = .fullScreen
                                    self.present(vc, animated: true)
                                }
                            }))
                            
                            self.present(refreshAlert, animated: true)
                        }
                    }
                }
                
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
        imagePdf.sectionid = sections
        imagePdf.processtype = "add"
        imagePdf.staffid = memberId
        imagePdf.assignmentdescription = discreptionsTextField
        imagePdf.assignmentid = "0"
        imagePdf.assignmenttopic = titlesText
        imagePdf.assignmenttype = AssigmentFileType
        imagePdf.callertype = priority
        imagePdf.courseid = ""
        imagePdf.receiverid = ""
        imagePdf.receivertype = "1"
        imagePdf.subjectid = "144"
        imagePdf.yearid = ""
        imagePdf.submissiondate = assigmentDate
        imagePdf.fileNameArray = assigmet
        
        print("yearAndSectionModalStr11", imagePdf)
        
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.ManageAssignmentWithCloudURL,
            httpMethod: .post,
            queryParam: nil,
            requestBody: imagePdf
        ) { [weak self] (result: Result<assigmentImagePdfResponce, Error>) in
            
            guard let self = self else { return }
            
            switch result {
                
            case .success(let particularss):
                
                
                    
                    self.assigmentImagPdf = particularss
                    
                    let refreshAlert = UIAlertController(
                        title: "",
                        message: particularss.Message,
                        preferredStyle: .alert
                    )
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                        
                        if self.priority == "p2" || self.priority == "p3" {
                            
                            let vc = SenderAssigmentHomePageViewController()
                            vc.is_read_enabled = self.is_read_enabled
                            vc.is_write_enabled = self.is_write_enabled
                            vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                            vc.assigmentSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                            vc.assigmentSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                            vc.str = self.str
                            vc.strName = self.strName
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true)
                            
                        } else {
                            
                            let vc = SenderAssigmentHomePageViewController()
                            vc.is_read_enabled = self.is_read_enabled
                            vc.is_write_enabled = self.is_write_enabled
                            vc.view.backgroundColor = UIColor(named: "Principal")
                            vc.assigmentSegmentName.backgroundColor = UIColor(named: "UnSelector")
                            vc.assigmentSegmentName.selectedSegmentTintColor = UIColor(named: "Selector")
                            vc.str = self.str
                            vc.strName = self.strName
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true)
                        }
                    })
                    
                    self.present(refreshAlert, animated: true)
                    
                    self.tv.dataSource = self
                    self.tv.delegate = self
                    self.tv.reloadData()
                
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    func SendVideoToParticular() {
        
        var uploadvideo = ParticularVideoUploadModal()
        
        uploadvideo.isparent = parentchck.isChecked
        uploadvideo.callertype = priority
        uploadvideo.url = videoVimeoUrl
        uploadvideo.collegeid = collegeId
        uploadvideo.description = discreptionsTextField
        uploadvideo.iframe = videoIframe
        
        uploadvideo.isstaff = false
        uploadvideo.isstudent = studentChck.isChecked
        uploadvideo.staffid = memberId
        uploadvideo.title = titlesText
        
        if EntierdepartId == "1"{
            uploadvideo.receiverid = departmentId
            uploadvideo.receivertype = "3"
            
        } else if EntierdepartId == "2"{
            uploadvideo.receivertype = "2"
            uploadvideo.receiverid = nameString
            
        } else if EntierdepartId == "3"{
            uploadvideo.receiverid = nameString
            uploadvideo.receivertype = "5"
        }
        
        print("yearAndSectionModalStr", uploadvideo)
        
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.SendVideoToParticularType,
            httpMethod: .post,
            queryParam: nil,
            requestBody: uploadvideo
        ) { [weak self] (result: Result<ParticularVideoUploadResp, Error>) in
            
            guard let self = self else { return }
            
            switch result {
                
            case .success(let particular):
                
                self.sendVideoPart = particular.data ?? []
                
                if particular.Status == 1 {
                    
                    let refreshAlert = UIAlertController(title: "", message: particular.Message, preferredStyle: .alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                        
                        if self.priority == "p2" || self.priority == "p3" {
                            
                            let vc = SenderVideoHomePageViewController()
                            vc.is_read_enabled = self.is_read_enabled
                            vc.is_write_enabled = self.is_write_enabled
                            vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                            vc.str = self.str
                            vc.strName = self.strName
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true)
                            
                        } else {
                            
                            let vc = SenderVideoHomePageViewController()
                            vc.is_read_enabled = self.is_read_enabled
                            vc.is_write_enabled = self.is_write_enabled
                            vc.view.backgroundColor = UIColor(named: "Principal")
                            vc.str = self.str
                            vc.strName = self.strName
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true)
                        }
                    })
                    
                    self.present(refreshAlert, animated: true)
                    
                    self.tv.dataSource = self
                    self.tv.delegate = self
                    self.tv.reloadData()
                    
                } else {
                    
                    let refreshAlert = UIAlertController(title: "", message: particular.Message, preferredStyle: .alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                        
                        if self.priority == "p2" || self.priority == "p3" {
                            
                            let vc = SenderVideoHomePageViewController()
                            vc.is_read_enabled = self.is_read_enabled
                            vc.is_write_enabled = self.is_write_enabled
                            vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                            vc.str = self.str
                            vc.strName = self.strName
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true)
                            
                        } else {
                            
                            let vc = SenderVideoHomePageViewController()
                            vc.is_read_enabled = self.is_read_enabled
                            vc.is_write_enabled = self.is_write_enabled
                            vc.view.backgroundColor = UIColor(named: "Principal")
                            vc.str = self.str
                            vc.strName = self.strName
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true)
                        }
                    })
                    
                    self.present(refreshAlert, animated: true)
                    
                    self.tv.dataSource = self
                    self.tv.delegate = self
                    self.tv.reloadData()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func DropDownVc(){
        
        
        var GetCourseRequestModal = getCourseModal()
        
        GetCourseRequestModal.user_id = memberId
        GetCourseRequestModal.college_id = collegeId
        GetCourseRequestModal.dept_id = departmentId
        
        
        APiCallManager.shared.callApi(
                url: APIEndpoints.GetCoursesByDepartment,
                httpMethod: .post,
                queryParam: nil,
                requestBody: GetCourseRequestModal
            ) {[weak self] (result:Result<getCourseResponce, Error>) in
                    
                guard let self = self else { return }
                
                switch result {
                case .success(let success):
                    courseRefName = success.data ?? []
                    
                    var addAryy: [String] = [ ]
                    var itemAryy: [String] = [ ]
                    
                    
                    courseRefName.forEach {(arrType)  in
                        addAryy.append((arrType.course_id ?? ""))
                        itemAryy.append(arrType.course_name ?? "")
                    }
                    
                    
                    dropDown.dataSource = itemAryy//4
                    dropDown.anchorView = YearDropDowView //5
                    
                    dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
                    //
                    dropDown.direction = .bottom
                    DropDown.appearance().backgroundColor = UIColor.white
                    dropDown.show() //7
                    
                    dropDown.selectionAction = { [weak self] (index:Int, item: String) in
                        print("Selected item: \(item) at index: \(index)")
                        
                        self?.tv.isHidden = false
                        
                        var yearAndSectionModal = YearAndSectionListforAppModal()
                        
                        yearAndSectionModal.idcourse = addAryy[index]
                        
                        yearAndSectionModal.idcollege = self?.collegeId
                        
                        yearAndSectionModal.clgprocessby = self?.memberId
                        
                        self?.courseId = addAryy[index]
                        
                        APiCallManager.shared.callApi(
                            url: APIEndpoints.YearAndSectionListforApp,
                            httpMethod: .post,
                            queryParam: nil,
                            requestBody: yearAndSectionModal
                        ) { [weak self] (result: Result<YearAndSectionListforAppResponse, Error>) in
                            
                            switch result {
                                
                            case .success(let yearAndSectionResponse):
                                
                                if yearAndSectionResponse.Status == 1 {
                                    
                                    self?.yearRefName = yearAndSectionResponse.data ?? []
                                    
                                    for i in yearAndSectionResponse.data ?? []{
                                    
                                        self?.counts.append(i.yearname ?? "")
                                        self?.yreRef = i.sectiondetails ?? []
                                          
                                    }
                                    
                                    self?.tv.dataSource = self
                                    self?.tv.delegate = self
                                    self?.tv.reloadData()
                                    
                                }
                                else{
                                    
                                    let refreshAlert = UIAlertController(title: "", message:yearAndSectionResponse.Message, preferredStyle: UIAlertController.Style.alert)
                                    
                                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                                       
                                    }))
                                    
                                    self?.present(refreshAlert, animated: true, completion: nil)
                                    
                                    self?.tv.dataSource = self
                                    self?.tv.delegate = self
                                    self?.tv.reloadData()
                                }
                                
                            case .failure(let error):
                                print(error.localizedDescription)
                            }
                        }
                        
                        self?.myString.removeAll()
                        
                        self?.yearDropdownLabel.text = item
                          
                    }
                case .failure(let failure):
                     print("Error:",failure.localizedDescription)
                }
                
                }
    }
    
    
    @IBAction func courseVc(){
        
        
        EntierdepartId = "2"
        resiverId.removeAll()
        staffDeafultlbl.isHidden = true
        staffChckbox.isHidden = true
        
        if courseView.isUserInteractionEnabled ==  true {
            courseView.isUserInteractionEnabled = true
            YearDropDowView.isHidden = true
            tv.isHidden = false
            tabelTop.constant = -50
            
            //
            YearView.backgroundColor = UIColor.white
            yearSectionLabel.textColor = UIColor(named: "clickView")
            entierDepartView.backgroundColor = UIColor.white
            entierDepartLabel.textColor = UIColor(named: "clickView")
            ////
            courseView.backgroundColor = UIColor(named: "selectColor")
            
            print("courseView1")
            GetCourseResponse()
        }
        
        
        else{
            
            
            print("courseView2")
            YearView.isUserInteractionEnabled = false
            
            entierDepartView.isUserInteractionEnabled = false
            YearView.backgroundColor = UIColor.white
            yearSectionLabel.textColor = UIColor(named: "clickView")
            entierDepartLabel.backgroundColor = UIColor.white
            entierDepartLabel.textColor = UIColor(named: "clickView")
            
            
            
        }
        
        
        
        
    }
    
    
    
    @IBAction func YearVc(){
        
        EntierdepartId = "3"
        resiverId.removeAll()
        
        staffDeafultlbl.isHidden = true
        staffChckbox.isHidden = true
        if YearView.isUserInteractionEnabled ==  true {
            courseView.isUserInteractionEnabled = true
            YearDropDowView.isHidden = false
            yearDropdownLabel.text = "-Select Course-"
            tv.isHidden = true
            tabelTop.constant = 8
            
            specifyStudView.isHidden = false
            targetTop.constant = 0
            YearView.backgroundColor = UIColor(named: "selectColor")
            
            courseView.backgroundColor = UIColor.white
            courseLabel.textColor = UIColor(named: "clickView")
            entierDepartView.backgroundColor = UIColor.white
            entierDepartLabel.textColor = UIColor(named: "clickView")
            //
            
            
            print("YearViewYearView1")
            
        }
        
        
        else{
            
            print("YearViewYearView2")
            
            
            specifyStudView.isHidden = true
            targetTop.constant = -40
            courseView.isUserInteractionEnabled = false
            entierDepartView.isUserInteractionEnabled = false
            courseView.backgroundColor = UIColor.white
            courseLabel.textColor = UIColor(named: "clickView")
            entierDepartLabel.backgroundColor = UIColor.white
            entierDepartLabel.textColor = UIColor(named: "clickView")
            
        }
        
        
        
        
        
    }
    
    
    @IBAction func DepartmentVc(){
        
        
        EntierdepartId = "1"
        
        
        
        staffDeafultlbl.isHidden = false
        staffChckbox.isHidden = false
        
        
        if entierDepartView.isUserInteractionEnabled ==  true {
            
            
            
            
            
            courseView.isUserInteractionEnabled = true
            YearDropDowView.isHidden = true
            
            tv.isHidden = true
            
            specifyStudView.isHidden = true
            targetTop.constant = -40
            entierDepartView.backgroundColor = UIColor(named: "selectColor")
            
            print("eniertviewwww",entierDepartView.backgroundColor)
            courseView.backgroundColor = UIColor.white
            courseLabel.textColor = UIColor(named: "clickView")
            YearView.backgroundColor = UIColor.white
            yearSectionLabel.textColor = UIColor(named: "clickView")
            
            print("entierDepartViewClick1")
        }
        
        
        else{
            
            print("entierDepartViewClick2")
            courseView.isUserInteractionEnabled = false
            YearView.isUserInteractionEnabled = false
            courseView.backgroundColor = UIColor.white
            courseLabel.textColor = UIColor(named: "clickView")
            YearView.backgroundColor = UIColor.white
            yearSectionLabel.textColor = UIColor(named: "clickView")
            
        }
        
        
        
        
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //
        if   courseView.backgroundColor == UIColor(named: "selectColor"){
            
            return 1
        }
        //
        
        else if   YearView.backgroundColor == UIColor(named: "selectColor"){
            
            return yearRefName.count
        }
        //
        //
        //
        //
        return 0
        //
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: identifer2) as!
        MydeparmentHeaderFooterView
        
        if   courseView.backgroundColor == UIColor(named: "selectColor"){
            
            
            cell.YearLabel.isHidden = true
            
            
            
            print("Helosdd")
            
            
        }
        
        else if   YearView.backgroundColor == UIColor(named: "selectColor"){
            
            
            cell.YearLabel.isHidden = false
            let year : YearAndSectionListData = yearRefName[section]
            
            YearIDArry.append(String(year.yearid ?? 0))
            print("YearIDArryYearIDArryYearIDArryYearIDArry",YearIDArry)
            cell.YearLabel.text = year.yearname
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        
        if   courseView.backgroundColor == UIColor(named: "selectColor"){
            
            print("rfwdd",courseRefName.count)
            return courseRefName.count
            
            
            
        }
        
        
        
        else if   YearView.backgroundColor == UIColor(named: "selectColor"){
            
            
            
            return yearRefName[section].sectiondetails?.count ?? 0
            
            
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as!
        MydeparmentTvCellTableViewCell
        
        if   courseView.backgroundColor == UIColor(named: "selectColor"){
            
            cell.sectionCourseChck.isChecked = false
            let course : getCourseDataDetails = courseRefName[indexPath.row]
            
            
            cell.sectionLabel.text = course.course_name
            
            let selectedGestures = CheckBoxclickMyDepartMent(target: self, action: #selector(changeSelection))
            
            selectedGestures.MyDepartcheckBoxss = cell.sectionCourseChck
            //
            selectedGestures.MyDepartmemberNames = course.course_id
            selectedGestures.MyDepartposs = indexPath.row
            cell.sectionCourseChck.addGestureRecognizer(selectedGestures)
        
            
        }
        
        
        
        
        else if   YearView.backgroundColor == UIColor(named: "selectColor"){
            
            
            
            
            cell.sectionCourseChck.isChecked = false
            
            
            let secion : sectionDetailsData = yreRef[indexPath.row]
            
            
            cell.sectionLabel.text =  yearRefName[indexPath.section].sectiondetails?[indexPath.row].sectionname
            
            
            let selectedGestures = CheckBoxclickMyDepartMent2(target: self, action: #selector(changesecitonVc))
            
            
            selectedGestures.MyDepartcheckBoxss = cell.sectionCourseChck
            selectedGestures.MyDepartmemberNames =  (yearRefName[indexPath.section].sectiondetails?[indexPath.row].sectionid)
            
            selectedGestures.YearId = String((yearRefName[indexPath.section].yearid ?? 0))
            cell.sectionCourseChck.addGestureRecognizer(selectedGestures)
            
            
            
            print("ffgfgfdfddfdsdfds",String((yearRefName[indexPath.section].yearid ?? 0)))
            
            
            let specify = specifyStu(target: self, action: #selector(SpecifyVc))
            
            
            specify.YearId = String((yearRefName[indexPath.section].yearid ?? 0))
            specify.sectionId = String((yearRefName[indexPath.section].sectiondetails?[indexPath.row].sectionid ?? 0))
            
            specifyStudView.addGestureRecognizer(specify)
            
            
            
            
            
            
            
        }
        
        
        
        
        
        return cell
        
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
    }
    
    
    
    @IBAction func changeSelection(gestur : CheckBoxclickMyDepartMent){
        
        
        if gestur.MyDepartcheckBoxss.isChecked == true{
            
            
            gestur.MyDepartcheckBoxss.setImage(UIImage.init(named: "checkboxs"), for: .normal)
            
            if(resiverId.contains(gestur.MyDepartmemberNames)){
                
                if let index = resiverId.firstIndex(of: gestur.MyDepartmemberNames) {
                    resiverId.remove(at: index)
                }
                
                
            }
            
            print("revisserfrfrffc",nameString)
            gestur.MyDepartcheckBoxss.isChecked = false
            
            nameString = resiverId.joined(separator: "~")
            
        }
        
        
        else{
            
            
            gestur.MyDepartcheckBoxss.isChecked = true
            
            resiverId.append(gestur.MyDepartmemberNames)
            
            nameString = resiverId.joined(separator: "~")
            
            print("resiverId.append(gestur.memberName12)",nameString)
            
            
            
            
        }
        
        
        
        
        
        
        
    }
    
    @IBAction func changesecitonVc(gestur : CheckBoxclickMyDepartMent2){
        
        
        
        
        if gestur.MyDepartcheckBoxss.isChecked == true{
            
            
            gestur.MyDepartcheckBoxss.isChecked = false
            gestur.MyDepartcheckBoxss.setImage(UIImage.init(named: "checkboxs"), for: .normal)
            
            
            var strss = String(gestur.MyDepartmemberNames)
            //
            if(resiverId.contains(strss)){
                
                if let index = resiverId.firstIndex(of: strss) {
                    resiverId.remove(at: index)
                }
                
                
            }
            nameString =  resiverId.joined(separator: "~")
            
            if resiverId.count == 1{
                //
                specifyStudView.isHidden = false
                //
                specifyStudView.isUserInteractionEnabled = true
                
                specifyStudView.isHidden = false
            }
            
            
            else if resiverId.count == 0{
                
                specifyStudView.isHidden = false
                
            }
            else{
                
                
                specifyStudView.isHidden = true
                
            }
            
            
        }
        
        
        else{
            
            
            
            for i in yearRefName{
                
                for zz in i.sectiondetails ?? []{
                    
                    
                    if zz.sectionid ==  gestur.MyDepartmemberNames{
                        
                        YearIdForSpeficStudent = i.yearid
                        print("yearrrrrrrIddddddddddddd",i.yearid)
                    }
                    
                    
                }
                
            }
            
            
            
            
            
            
            
            
            gestur.MyDepartcheckBoxss.setImage(UIImage.init(named: "done"), for: .normal)
            
            
            var strss = String(gestur.MyDepartmemberNames)
            resiverId.append(strss)
            
            
            nameString = resiverId.joined(separator: "~")
            
            
            
            
            print("resiverId.append(gestur.memberName567)",resiverId)
            
            gestur.MyDepartcheckBoxss.isChecked = true
            
            
            sectionIDForSpecify = strss
            YearIDForSpecify = gestur.YearId
            
            
            if resiverId.count == 1{
                //
                specifyStudView.isHidden = false
                
                specifyStudView.isUserInteractionEnabled = true
                
                specifyStudView.isHidden = false
            }
            
            else if resiverId.count == 0{
                
                specifyStudView.isHidden = false
                
            }
            else{
                
                
                specifyStudView.isHidden = true
                
                
            }
            
            
        }
        
        
        
        
        
        
    }
    
    
    
    
    @IBAction func CancelVc(){
        
        
        dismiss(animated: true)
        
        
        
    }
    
    
    
    
    
    
    
    
    func GetCourseResponse() {
        
        var GetCourseRequestModal = getCourseModal()
        
        GetCourseRequestModal.user_id = memberId
        GetCourseRequestModal.college_id = collegeId
        GetCourseRequestModal.dept_id = departmentId
        
        APiCallManager.shared.callApi(
                url: APIEndpoints.GetCoursesByDepartment,
                httpMethod: .post,
                queryParam: nil,
                requestBody: GetCourseRequestModal
            ) {[weak self] (result:Result<getCourseResponce, Error>) in
                    
                guard let self = self else { return }
                
                switch result {
                case .success(let GetCourseResponse):
                    
                    if GetCourseResponse.Status == 1 {
                        
                        courseRefName = GetCourseResponse.data ?? []
                        tv.dataSource = self
                        tv.delegate = self
                        tv.reloadData()
                    }else{
                        
                        let refreshAlert = UIAlertController(title: "", message:GetCourseResponse.Message, preferredStyle: UIAlertController.Style.alert)
                        
                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in
                            
                        }))
                        
                        present(refreshAlert, animated: true, completion: nil)
                        
                        tv.dataSource = self
                        tv.delegate = self
                        tv.reloadData()
                        
                    }
                    
                case .failure(let failure):
                     print("Error:",failure.localizedDescription)
                }
                
                }
        
    }
    
    
    
    func SendSmsToParticular() {
        
        var particular = SendSmsToParticularModal()
        
        particular.collegeid = collegeId
        particular.staffid = memberId
        particular.description = discreptionsTextField
        particular.callertype = priority
        
        if EntierdepartId == "1"{
            
            particular.receiverid = departmentId
            
            particular.receivertype = "3"
        }
        
        else if EntierdepartId == "2"{
            
            particular.receivertype = "2"
            particular.receiverid = nameString
        }
        
        else if EntierdepartId == "3"{
            
            particular.receiverid = nameString
            
            particular.receivertype = "5"
        }
        
        if  is_parent_target_enabled == "0"{
            
            particular.isparent = false
        }
        
        else{
            
            particular.isparent = parentchck.isChecked
        }
        
        particular.isstaff = staffChckbox.isChecked
        particular.isstudent = studentChck.isChecked
        
        particular.messagecontent = titlesText
        particular.filetype = "1"
        
        
        APiCallManager.shared.callApi(
                url: APIEndpoints.SendSMSToParticularType,
                httpMethod: .post,
                queryParam: nil,
                requestBody: particular
            ) {[weak self] (result:Result<senderParticularResponce, Error>) in
                    
                guard let self = self else { return }
                
                switch result {
                case .success(let particular):
                    
                    if particular.Status == 1 {
                        
                        particularSms  = particular.data ?? []
                        
                        let refreshAlert = UIAlertController(title: "", message:particular.Message, preferredStyle: UIAlertController.Style.alert)
                        
                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] (action: UIAlertAction!) in
                            
                            if self?.priority == "p2" ||  self?.priority == "p3" {
                                
                                let vc = CommuniSMSViewController(nibName: nil, bundle: nil)
                                vc.is_read_enabled =  self?.is_read_enabled ?? ""
                                vc.is_write_enabled =  self?.is_write_enabled ?? ""
                                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                                vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
                                vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                                vc.str =  self?.str ?? []
                                vc.strName =  self?.strName ?? []
                                vc.modalPresentationStyle = .fullScreen
                                self?.present(vc, animated: true , completion: nil)
                                
                            }else{
                                
                                let vc = CommuniSMSViewController(nibName: nil, bundle: nil)
                                
                                vc.is_read_enabled =  self?.is_read_enabled ?? ""
                                vc.is_write_enabled =  self?.is_write_enabled ?? ""
                                vc.view.backgroundColor = UIColor(named: "Principal" )
                                vc.CommuniSegementName.backgroundColor = UIColor(named: "UnSelector")
                                vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "Selector")
                                vc.str =  self?.str ?? []
                                vc.strName =  self?.strName ?? []
                                vc.modalPresentationStyle = .fullScreen
                                self?.present(vc, animated: true , completion: nil)
                                
                            }
                        }))
                        
                        present(refreshAlert, animated: true, completion: nil)
                        
                        tv.dataSource = self
                        tv.delegate = self
                        
                    }else{
                        
                        let refreshAlert = UIAlertController(title: "", message:particular.Message, preferredStyle: UIAlertController.Style.alert)
                        
                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] (action: UIAlertAction!) in
                            
                            if  self?.priority == "p2" ||  self?.priority == "p3" {
                                
                                let vc = CommuniSMSViewController(nibName: nil, bundle: nil)
                                vc.is_read_enabled =  self?.is_read_enabled ?? ""
                                vc.is_write_enabled =  self?.is_write_enabled ?? ""
                                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                                vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
                                vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                                vc.str =  self?.str ?? []
                                vc.strName =  self?.strName ?? []
                                vc.modalPresentationStyle = .fullScreen
                                self?.present(vc, animated: true , completion: nil)
                                
                            }else{
                                
                                let vc = CommuniSMSViewController(nibName: nil, bundle: nil)
                                vc.is_read_enabled =  self?.is_read_enabled ?? ""
                                vc.is_write_enabled =  self?.is_write_enabled ?? ""
                                
                                vc.view.backgroundColor = UIColor(named: "Principal" )
                                vc.CommuniSegementName.backgroundColor = UIColor(named: "UnSelector")
                                vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "Selector")
                                vc.str =  self?.str ?? []
                                vc.strName =  self?.strName ?? []
                                vc.modalPresentationStyle = .fullScreen
                                self?.present(vc, animated: true , completion: nil)
                                
                            }
                            
                        }))
                        
                        present(refreshAlert, animated: true, completion: nil)
                        
                        tv.dataSource = self
                        tv.delegate = self
                        tv.reloadData()
                    }
                    
                case .failure(let failure):
                     print("Error:",failure.localizedDescription)
                }
                
                }
    }
    
    
    
    func ImagePdfParticular(ImageFile: [String]){
        
        print("fdfddsx")
        
        var imageAryy : [FileNameImages] = []
        
        for i in ImageFile{
            var imageAws = FileNameImages()
            imageAws.FileName = i
            imageAryy.append(imageAws)
        }
        
        var sendImagePdfEntier = ImagePdfPartResponce()
        
        sendImagePdfEntier.Staffid = memberId
        sendImagePdfEntier.collegeid = collegeId
        sendImagePdfEntier.callertype = priority
        
        if is_parent_target_enabled == "0"{
            sendImagePdfEntier.isparent = false
        }
        else{
            sendImagePdfEntier.isparent = parentchck.isChecked
        }
        
        sendImagePdfEntier.isstudent = studentChck.isChecked
        sendImagePdfEntier.isstaff = staffChckbox.isChecked
        sendImagePdfEntier.fileduration = "0"
        sendImagePdfEntier.Description = discreptionsTextField
        sendImagePdfEntier.title = titlesText
        sendImagePdfEntier.filetype = imagePdfFileType
        
        if EntierdepartId == "1"{
            sendImagePdfEntier.receiverid = departmentId
            sendImagePdfEntier.receivertype = "3"
        }
        else if EntierdepartId == "2"{
            sendImagePdfEntier.receivertype = "2"
            sendImagePdfEntier.receiverid = nameString
        }
        else if EntierdepartId == "3"{
            sendImagePdfEntier.receiverid = nameString
            sendImagePdfEntier.receivertype = "5"
        }
        
        sendImagePdfEntier.FileNameArray = imageAryy
        
        print("yearAndSectionModalStr", sendImagePdfEntier)
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.SendImageOrPDFToEntireCollegeWithCloudURL,
            httpMethod: .post,
            queryParam: nil,
            requestBody: sendImagePdfEntier
        ) { [weak self] (result: Result<SendImagePdfPartiResponce, Error>) in
            
            guard let self = self else { return }
            
            switch result {
                
            case .success(let enierImagePdf):
                
                self.imagePdfEniter = enierImagePdf.data ?? []
                
                let refreshAlert = UIAlertController(
                    title: "",
                    message: enierImagePdf.Message,
                    preferredStyle: .alert
                )
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    
                    if self.priority == "p2" || self.priority == "p3" {
                        
                        let vc = SenderImagePdfHomePageViewController()
                        vc.is_read_enabled = self.is_read_enabled
                        vc.is_write_enabled = self.is_write_enabled
                        vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                        vc.imageSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                        vc.imageSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                        vc.str = self.str
                        vc.strName = self.strName
                        vc.modalPresentationStyle = .fullScreen
                        
                        self.present(vc, animated: true)
                        
                    } else {
                        
                        let vc = SenderImagePdfHomePageViewController()
                        vc.is_read_enabled = self.is_read_enabled
                        vc.is_write_enabled = self.is_write_enabled
                        vc.view.backgroundColor = UIColor(named: "Principal")
                        vc.imageSegmentName.backgroundColor = UIColor(named: "UnSelector")
                        vc.imageSegmentName.selectedSegmentTintColor = UIColor(named: "Selector")
                        vc.str = self.str
                        vc.strName = self.strName
                        vc.modalPresentationStyle = .fullScreen
                        
                        self.present(vc, animated: true)
                    }
                }))
                
                self.present(refreshAlert, animated: true)
                
                self.tv.dataSource = self
                self.tv.delegate = self
                
                if enierImagePdf.Status != 1 {
                    self.tv.reloadData()
                }
                
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    func NoticeSendSmsEntier(ImageFile: [String]) {
        
        var imageAryy: [FiletypeDataDetails] = []
        
        for i in ImageFile {
            var imageAws = FiletypeDataDetails()
            imageAws.filepath = i
            imageAws.filetype = imagePdfFileType
            imageAryy.append(imageAws)
        }
        
        var particularNotice = NoticeBoardPartiModal()
        
        particularNotice.noticeboardid = "0"
        
        particularNotice.description = discreptionsTextField
        particularNotice.isstaff = false
        particularNotice.isstudent = studentChck.isChecked
        
        if is_parent_target_enabled == "0" {
            particularNotice.isparent = false
        } else {
            particularNotice.isparent = parentchck.isChecked
        }
        
        particularNotice.processtype = "add"
        
        if EntierdepartId == "1" {
            particularNotice.receiveridlist = departmentId
            particularNotice.receivertype = "3"
        }
        else if EntierdepartId == "2" {
            particularNotice.receivertype = "2"
            particularNotice.receiveridlist = nameString
        }
        else if EntierdepartId == "3" {
            particularNotice.receiveridlist = nameString
            particularNotice.receivertype = "5"
        }
        
        particularNotice.topic = titlesText
        particularNotice.colgid = collegeId
        particularNotice.staffid = memberId
        particularNotice.callertype = priority
        particularNotice.files = imageAryy
        
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.ManageNoticeBoard,
            httpMethod: .post,
            queryParam: nil,
            requestBody: particularNotice
        ) { [weak self] (result: Result<NoticePArticularResponce, Error>) in
            
            guard let self = self else { return }
            
            switch result {
                
            case .success(let response):
                    
                    let refreshAlert = UIAlertController(
                        title: "",
                        message: response.Message,
                        preferredStyle: .alert
                    )
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                        
                        if self.priority == "p2" || self.priority == "p3" {
                            
                            let vc = SenderGraditNoticeBoardMenuViewController()
                            vc.is_read_enabled = self.is_read_enabled
                            vc.is_write_enabled = self.is_write_enabled
                            vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                            vc.noticeSegments.backgroundColor = UIColor(named: "HodUnSelector")
                            vc.noticeSegments.selectedSegmentTintColor = UIColor(named: "HodSelector")
                            vc.str = self.str
                            vc.strName = self.strName
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true)
                            
                        } else {
                            
                            let vc = SenderGraditNoticeBoardMenuViewController()
                            vc.is_read_enabled = self.is_read_enabled
                            vc.is_write_enabled = self.is_write_enabled
                            vc.view.backgroundColor = UIColor(named: "Principal")
                            vc.noticeSegments.backgroundColor = UIColor(named: "UnSelector")
                            vc.noticeSegments.selectedSegmentTintColor = UIColor(named: "Selector")
                            vc.str = self.str
                            vc.strName = self.strName
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true)
                        }
                    })
                    
                    self.present(refreshAlert, animated: true)
                    
                    if response.Status == 1 {
                        self.tv.dataSource = self
                        self.tv.delegate = self
                    } else {
                        self.tv.dataSource = self
                        self.tv.delegate = self
                        self.tv.reloadData()
                    }
                
                
            case .failure(let error):
                print("API Error:", error.localizedDescription)
            }
        }
    }
    
    
    func EventEntier() {
        
        var particular = EventParticualrModal()
        print("events")
        
        particular.eventid = "0"
        particular.eventbody = titlesText
        particular.eventdate = eventDate
        particular.eventvenue = eventVenu
        particular.eventtime = EventTime
        particular.eventtopic = discreptionsTextField
        
        particular.processtype = "add"
        particular.collegeid = collegeId
        particular.staffid = memberId
        particular.Callertype = priority
        
        if is_parent_target_enabled == "0" {
            particular.isparent = false
        } else {
            particular.isparent = parentchck.isChecked
        }
        
        particular.isstaff = false
        particular.isstudent = studentChck.isChecked
        
        if EntierdepartId == "1" {
            particular.receiveridlist = departmentId
            particular.receivertype = "3"
        }
        
        else if EntierdepartId == "2" {
            particular.receivertype = "2"
            particular.receiveridlist = nameString
        }
        
        else if EntierdepartId == "3" {
            particular.receiveridlist = nameString
            particular.receivertype = "5"
        }
        
        print("yearAndSectionModalStr", particular)
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.ManageEvents,
            httpMethod: .post,
            queryParam: nil,
            requestBody: particular
        ) { [weak self] (result: Result<EventParticularResponce, Error>) in
            
            guard let self = self else { return }
            
            switch result {
                
            case .success(let response):
                
              
                    
                    if response.Status == 1 {
                        
                        let refreshAlert = UIAlertController(
                            title: "",
                            message: response.Message,
                            preferredStyle: .alert
                        )
                        
                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                            
                            if self.priority == "p2" || self.priority == "p3" {
                                
                                let vc = SenderEventHomePageViewController()
                                vc.is_read_enabled = self.is_read_enabled
                                vc.is_write_enabled = self.is_write_enabled
                                vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                                vc.eventSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                                vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                                vc.str = self.str
                                vc.strName = self.strName
                                vc.modalPresentationStyle = .fullScreen
                                self.present(vc, animated: true)
                                
                            } else {
                                
                                let vc = SenderEventHomePageViewController()
                                vc.is_read_enabled = self.is_read_enabled
                                vc.is_write_enabled = self.is_write_enabled
                                vc.view.backgroundColor = UIColor(named: "Principal")
                                vc.eventSegmentName.backgroundColor = UIColor(named: "UnSelector")
                                vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "Selector")
                                vc.str = self.str
                                vc.strName = self.strName
                                vc.modalPresentationStyle = .fullScreen
                                self.present(vc, animated: true)
                            }
                        })
                        
                        self.present(refreshAlert, animated: true)
                        
                        self.tv.dataSource = self
                        self.tv.delegate = self
                        
                    } else {
                        
                        let refreshAlert = UIAlertController(
                            title: "",
                            message: response.Message,
                            preferredStyle: .alert
                        )
                        
                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                            
                            if self.priority == "p2" || self.priority == "p3" {
                                
                                let vc = SenderEventHomePageViewController()
                                vc.is_read_enabled = self.is_read_enabled
                                vc.is_write_enabled = self.is_write_enabled
                                vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                                vc.eventSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                                vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                                vc.str = self.str
                                vc.strName = self.strName
                                vc.modalPresentationStyle = .fullScreen
                                self.present(vc, animated: true)
                                
                            } else {
                                
                                let vc = SenderEventHomePageViewController()
                                vc.is_read_enabled = self.is_read_enabled
                                vc.is_write_enabled = self.is_write_enabled
                                vc.view.backgroundColor = UIColor(named: "Principal")
                                vc.eventSegmentName.backgroundColor = UIColor(named: "UnSelector")
                                vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "Selector")
                                vc.str = self.str
                                vc.strName = self.strName
                                vc.modalPresentationStyle = .fullScreen
                                self.present(vc, animated: true)
                            }
                        })
                        
                        self.present(refreshAlert, animated: true)
                        
                        self.tv.dataSource = self
                        self.tv.delegate = self
                        self.tv.reloadData()
                    }
                
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
//    func multypartAudioEntierDepart() {
//        
//        var vimeoVideoEndpoint = "https://gradit.voicesnap.com/api/AppDetailsBal/SendFileToEntireCollege"
//        
//        var voiceUpload = voiceUploadEntierModal()
//        
//        voiceUpload.staffid = memberId
//        voiceUpload.description = discreptionsTextField
//        voiceUpload.callertype = priority
//        voiceUpload.collegeid = collegeId
//        voiceUpload.fileduration = voiceDuration
//        voiceUpload.filetype = "1"
//        voiceUpload.isemergencyvoice = voiceReplyType
//        
//        if  is_parent_target_enabled == "0"{
//            
//            voiceUpload.isparent = false
//        }else{
//            
//            voiceUpload.isparent = parentchck.isChecked
//        }
//        
//        voiceUpload.isstaff = staffChckbox.isChecked
//        voiceUpload.isstudent = studentChck.isChecked
//        
//        let voiceUploadStr = voiceUpload.toJSONString()
//        
//        print("chatSenderStr",voiceUpload)
//       
//        
//        AF.upload(multipartFormData: { [self] (multipartFormData) in
//            
//            var videoU : String!
//            
//            let pathURL = voiceURl
//            
//            let pathString = pathURL!.path
//            
//            multipartFormData.append(URL(fileURLWithPath: pathString), withName: "file")
//            
//            multipartFormData.append(Data(voiceUploadStr!.description.utf8), withName: "info")
//            
//            print("parameters.description.utf8",voiceUploadStr!.description.utf8)
//            
//            KRProgressHUD.show()
//        },to: vimeoVideoEndpoint).responseJSON{
//            //
//            res in
//            
//            print(res)
//            
//            let json_str = String(data: res.data!, encoding: .utf8)
//            
//            print("json \(json_str!)")
//            
//        }
//       
//    }
    
    func multypartAudioEntierDepart() {
        
        var vimeoVideoEndpoint = "https://gradit.voicesnap.com/api/AppDetailsBal/SendFileToEntireCollege"
        
        var voiceUpload = voiceUploadEntierModal()
        
        voiceUpload.staffid = memberId
        voiceUpload.description = discreptionsTextField
        voiceUpload.callertype = priority
        voiceUpload.collegeid = collegeId
        voiceUpload.fileduration = voiceDuration
        voiceUpload.filetype = "1"
        voiceUpload.isemergencyvoice = voiceReplyType
        
        if is_parent_target_enabled == "0"{
            voiceUpload.isparent = false
        }else{
            voiceUpload.isparent = parentchck.isChecked
        }
        
        voiceUpload.isstaff = staffChckbox.isChecked
        voiceUpload.isstudent = studentChck.isChecked
        
        // ✅ Replace toJSONString()
        let voiceUploadStr: String
        do {
            let jsonData = try JSONEncoder().encode(voiceUpload)
            voiceUploadStr = String(data: jsonData, encoding: .utf8) ?? ""
        } catch {
            print(error)
            return
        }
        
        print("chatSenderStr", voiceUpload)
        
        KRProgressHUD.show()
        
        MultipartManager.shared.uploadVoice(
            url: vimeoVideoEndpoint,
            fileURL: voiceURl!,
            infoJSONString: voiceUploadStr
        ) { result in
            
            switch result {
                
            case .success(let json):
                
                print(json)
                
                if let data = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted),
                   let jsonStr = String(data: data, encoding: .utf8) {
                    print("json \(jsonStr)")
                }
                
                let message = json["Message"] as! String
                
                let refreshAlert = UIAlertController(title: "", message: message, preferredStyle: .alert)
                               
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    
                }))
                
                self.present(refreshAlert, animated: true)
                
                
            case .failure(let error):
                print(error.localizedDescription)
                
                let refreshAlert = UIAlertController(title: "", message: error.localizedDescription, preferredStyle: .alert)
                               
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    
                }))
                
                self.present(refreshAlert, animated: true)
            }
            
            KRProgressHUD.dismiss()
        }
    }
    
    
    func videoUploadEntierDepartment(){
        
        var uploadvideo = EntierVideoUpload()
        
        uploadvideo.callertype = priority
        uploadvideo.url = videoVimeoUrl
        uploadvideo.collegeid = collegeId
        uploadvideo.description = discreptionsTextField
        uploadvideo.iframe = videoIframe
        
        uploadvideo.isstaff = staffChckbox.isChecked
        
        if is_parent_target_enabled == "0"{
            uploadvideo.isparent = false
        }
        else{
            uploadvideo.isparent = parentchck.isChecked
        }
        
        uploadvideo.isstudent = studentChck.isChecked
        uploadvideo.staffid = memberId
        uploadvideo.title = titlesText
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
                            vc.is_read_enabled = self.is_read_enabled
                            vc.is_write_enabled = self.is_write_enabled
                            vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                            vc.str = self.str
                            vc.strName = self.strName
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true)
                            
                        } else {
                            
                            let vc = SenderVideoHomePageViewController()
                            vc.is_read_enabled = self.is_read_enabled
                            vc.is_write_enabled = self.is_write_enabled
                            vc.view.backgroundColor = UIColor(named: "Principal")
                            vc.str = self.str
                            vc.strName = self.strName
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true)
                        }
                    }))
                    
                    self.present(refreshAlert, animated: true)
                    
                    self.tv.dataSource = self
                    self.tv.delegate = self
                    
                } else {
                    
                    let refreshAlert = UIAlertController(
                        title: "",
                        message: particular.Message,
                        preferredStyle: .alert
                    )
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                        
                        if self.priority == "p2" || self.priority == "p3" {
                            
                            let vc = SenderVideoHomePageViewController()
                            vc.is_read_enabled = self.is_read_enabled
                            vc.is_write_enabled = self.is_write_enabled
                            vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                            vc.str = self.str
                            vc.strName = self.strName
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true)
                            
                        } else {
                            
                            let vc = SenderVideoHomePageViewController()
                            vc.is_read_enabled = self.is_read_enabled
                            vc.is_write_enabled = self.is_write_enabled
                            vc.view.backgroundColor = UIColor(named: "Principal")
                            vc.str = self.str
                            vc.strName = self.strName
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true)
                        }
                    }))
                    
                    self.present(refreshAlert, animated: true)
                    
                    self.tv.dataSource = self
                    self.tv.delegate = self
                }
                
            case .failure(let error):
                print("API Error:", error.localizedDescription)
            }
        }
    }
    
    func CommunicationEntierDepart(){
        
        var entier = EntierCollegeModal()
        
        entier.collegeid = collegeId
        entier.staffid = memberId
        entier.filetype = "1"
        entier.callertype = priority
        if  is_parent_target_enabled == "0"{
            entier.isparent = false
        }
        else{
            entier.isparent = parentchck.isChecked
        }
        entier.isstaff = staffChckbox.isChecked
        entier.isstudent = studentChck.isChecked
        entier.messagecontent = titlesText
        entier.description = discreptionsTextField
        
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
                        
                        let refreshAlert = UIAlertController(title: "", message:success.Message, preferredStyle: UIAlertController.Style.alert)
                        
                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] (action: UIAlertAction!) in
                            
                            if self?.priority == "p2" || self?.priority == "p3" {
                                
                                let vc = CommuniSMSViewController(nibName: nil, bundle: nil)
                                vc.is_read_enabled = self?.is_read_enabled ?? ""
                                vc.is_write_enabled = self?.is_write_enabled ?? ""
                                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                                
                                vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
                                vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                                
                                vc.str = self?.str ?? []
                                vc.strName = self?.strName ?? []
                                vc.modalPresentationStyle = .fullScreen
                                self?.present(vc, animated: true , completion: nil)
                                
                            }
                            
                        }))
                        
                        present(refreshAlert, animated: true, completion: nil)
                    }else {
                        
                        let refreshAlert = UIAlertController(title: "", message:success.Message, preferredStyle: UIAlertController.Style.alert)
                        
                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        }))
                        
                        present(refreshAlert, animated: true, completion: nil)
                    }
                    
                    tv.dataSource = self
                    tv.delegate = self
                    
                case .failure(let failure):
                     print("Error:",failure.localizedDescription)
                    let refreshAlert = UIAlertController(title: "", message:failure.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    }))
                    
                    present(refreshAlert, animated: true, completion: nil)
                }
                
                }
    }
    
    func NoticeSendSmsEntierDepartment() {
        
        var particularNotice = NoticeBoardPartiModal()
        
        particularNotice.noticeboardid = "0"
        particularNotice.description = discreptionsTextField
        particularNotice.receivertype = "1"
        particularNotice.isstaff = staffChckbox.isChecked
        
        if is_parent_target_enabled == "0" {
            particularNotice.isparent = false
        } else {
            particularNotice.isparent = parentchck.isChecked
        }
        
        particularNotice.isstudent = studentChck.isChecked
        particularNotice.processtype = "add"
        particularNotice.receiveridlist = ""
        particularNotice.topic = titlesText
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
                
            case .success(let response):
                    
                    if response.Status == 1 {
                        
                        self.particularSmsEnt = response
                        
                        let refreshAlert = UIAlertController(
                            title: "",
                            message: response.Message,
                            preferredStyle: .alert
                        )
                        
                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                            
                            if self.priority == "p2" || self.priority == "p3" {
                                
                                let vc = SenderGraditNoticeBoardMenuViewController()
                                vc.is_read_enabled = self.is_read_enabled
                                vc.is_write_enabled = self.is_write_enabled
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
                        
                        self.tv.dataSource = self
                        self.tv.delegate = self
                        
                    } else {
                        
                        let refreshAlert = UIAlertController(
                            title: "",
                            message: response.Message,
                            preferredStyle: .alert
                        )
                        
                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                            
                            if self.priority == "p2" || self.priority == "p3" {
                                
                                let vc = SenderGraditNoticeBoardMenuViewController()
                                vc.is_read_enabled = self.is_read_enabled
                                vc.is_write_enabled = self.is_write_enabled
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
                        
                        self.tv.dataSource = self
                        self.tv.delegate = self
                    }
                
                
            case .failure(let error):
                print("API Error:", error.localizedDescription)
            }
        }
    }
    
    func EventEntierDepartment() {
        
        var particular = EventParticualrModal()
        
        particular.eventid = "0"
        particular.eventbody = titlesText
        particular.eventdate = eventDate
        particular.eventvenue = eventVenu
        particular.eventtime = EventTime
        particular.eventtopic = discreptionsTextField
        
        particular.processtype = "add"
        particular.collegeid = collegeId
        particular.staffid = memberId
        particular.Callertype = priority
        particular.receivertype = "1"
        
        if is_parent_target_enabled == "0" {
            particular.isparent = false
        } else {
            particular.isparent = parentchck.isChecked
        }
        
        particular.isstaff = staffChckbox.isChecked
        particular.isstudent = studentChck.isChecked
        particular.receiveridlist = ""
        
        print("yearAndSectionModalStr", particular)
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.ManageEvents,
            httpMethod: .post,
            queryParam: nil,
            requestBody: particular
        ) { [weak self] (result: Result<EventParticularResponce, Error>) in
            
            guard let self = self else { return }
            
            switch result {
                
            case .success(let response):
                
              
                    
                    if response.Status == 1 {
                        
                        let refreshAlert = UIAlertController(
                            title: "",
                            message: response.Message,
                            preferredStyle: .alert
                        )
                        
                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                            
                            if self.priority == "p2" || self.priority == "p3" {
                                
                                let vc = SenderEventHomePageViewController()
                                vc.is_read_enabled = self.is_read_enabled
                                vc.is_write_enabled = self.is_write_enabled
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
                        
                        self.tv.dataSource = self
                        self.tv.delegate = self
                        
                    } else {
                        
                        if self.priority == "p2" || self.priority == "p3" {
                            
                            let vc = SenderEventHomePageViewController()
                            vc.is_read_enabled = self.is_read_enabled
                            vc.is_write_enabled = self.is_write_enabled
                            vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                            vc.eventSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                            vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                            vc.strName = self.strName
                            vc.str = self.str
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true)
                        }
                        
                        self.tv.dataSource = self
                        self.tv.delegate = self
                    }
                
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func ImagePdfEntierDepartMent(){
        
        print("fdfddsx")
        
        var imageAryy : [FileNameImage] = []
        
        for i in awsArry{
            var imageAws = FileNameImage()
            imageAws.FileName = i
            imageAryy.append(imageAws)
        }
        
        var sendImagePdfEntier = SendImagePdfModal()
        
        sendImagePdfEntier.Staffid = memberId
        print("senderscszsz", memberId)
        
        sendImagePdfEntier.collegeid = collegeId
        sendImagePdfEntier.callertype = priority
        
        if is_parent_target_enabled == "0"{
            sendImagePdfEntier.isparent = false
        } else {
            sendImagePdfEntier.isparent = parentchck.isChecked
        }
        
        sendImagePdfEntier.isstudent = studentChck.isChecked
        sendImagePdfEntier.isstaff = staffChckbox.isChecked
        sendImagePdfEntier.fileduration = "0"
        sendImagePdfEntier.Description = discreptionsTextField
        sendImagePdfEntier.title = titlesText
        sendImagePdfEntier.filetype = imagePdfFileType
        print("filtyo", imagePdfFileType)
        
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
                
                self.imagePdfEniterEnt = enierImagePdf.data ?? []
                
                let refreshAlert = UIAlertController(
                    title: "",
                    message: enierImagePdf.Message,
                    preferredStyle: .alert
                )
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                    
                    if self.priority == "p2" || self.priority == "p3" {
                        
                        let vc = SenderImagePdfHomePageViewController()
                        vc.is_read_enabled = self.is_read_enabled
                        vc.is_write_enabled = self.is_write_enabled
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
                
                self.tv.dataSource = self
                self.tv.delegate = self
                
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func assigmentImagePdfEntierDepart(){
        
        var imagePdfFileArry = FileNameArray()
        imagePdfFileArry.FileName = AssigmentMenuAwsUrl
        
        var imagePdf = assigmentImagePdfModal()
        
        imagePdf.collegeid = collegeId
        imagePdf.sectionid = ""
        imagePdf.processtype = "add"
        imagePdf.staffid = memberId
        imagePdf.assignmentdescription = discreptionsTextField
        imagePdf.assignmentid = "0"
        imagePdf.assignmenttopic = titlesText
        imagePdf.assignmenttype = AssigmentFileType
        imagePdf.callertype = priority
        imagePdf.courseid = ""
        imagePdf.receiverid = ""
        imagePdf.receivertype = "1"
        imagePdf.subjectid = "144"
        imagePdf.yearid = ""
        imagePdf.submissiondate = assigmentDate
        imagePdf.fileNameArray = [imagePdfFileArry]
        
        print("yearAndSectionModalStr", imagePdf)
        
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.ManageAssignmentWithCloudURL,
            httpMethod: .post,
            queryParam: nil,
            requestBody: imagePdf
        ) { [weak self] (result: Result<assigmentImagePdfResponce, Error>) in
            
            guard let self = self else { return }
            
            switch result {
                
            case .success(let particularss):
                
              
                    
                    self.assigmentImagPdf = particularss
                    
                    if particularss.Status == 1 {
                        
                        let refreshAlert = UIAlertController(
                            title: "",
                            message: particularss.Message,
                            preferredStyle: .alert
                        )
                        
                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                            
                            if self.priority == "p2" || self.priority == "p3" {
                                
                                let vc = SenderAssigmentHomePageViewController()
                                vc.is_read_enabled = self.is_read_enabled
                                vc.is_write_enabled = self.is_write_enabled
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
                        
                        self.tv.dataSource = self
                        self.tv.delegate = self
                        
                    } else {
                        
                        let refreshAlert = UIAlertController(
                            title: "",
                            message: particularss.Message,
                            preferredStyle: .alert
                        )
                        
                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                            
                            if self.priority == "p2" || self.priority == "p3" {
                                
                                let vc = SenderAssigmentHomePageViewController()
                                vc.is_read_enabled = self.is_read_enabled
                                vc.is_write_enabled = self.is_write_enabled
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
                        
                        self.tv.dataSource = self
                        self.tv.delegate = self
                    }
                
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
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
        KRProgressHUD.show()
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
        
        
//        var bucketName = ""
//        if countryCoded == "1" {
//
//        bucketName = DefaultsKeys.bucketNameIndia
//        }else  {
//        bucketName = DefaultsKeys.bucketNameBangkok
//        }
                       
        
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
                let Uploadimages = awsResponse.data?.fileUrl
                AWSUploadManager.shared.uploadImageToAWS(image: image, presignedURL: presignedURL!) { result in
                    switch result {
                    case .success(let uploadedURL):
                        print("Image uploaded successfully: \(uploadedURL)")
                        self.awsArry.append(Uploadimages ?? "")
                      
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
                           KRProgressHUD.dismiss()
                           }
                          }
           
            case .failure(let error):
                print("Error fetching presigned URL: \(error.localizedDescription)")
            }
        }
        
   
       
    }
    
    

    
    
    
    
    
    // AWS PDF Upload Part
    
    
    
    
    
    
    func uploadPDFFileToAWS(pdfData : NSData){
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
        
        // url for image in the bundle
        
        let currentTimeStamp = NSString.init(format: "%ld",Date() as CVarArg)
        let imageNameWithoutExtension = NSString.init(format: "vc_%@",currentTimeStamp)
        let imageName = NSString.init(format: "%@%@",imageNameWithoutExtension, ".pdf")
        
        
        
        let ext = imageName as String
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        let  currentDate =   dateFormatter.string(from: Date())
        
        
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
                    
                    
                    
                    if resivre == "5"{
                        
                        
                        ImagePdfParticular(ImageFile: awsArry)
                    }
                    
                    else if resivre == "1"{
                        
                        NoticeSendSmsEntier(ImageFile: awsArry)
                    }
                    
                }
            case .failure(let error):
                print("Error fetching presigned URL: \(error.localizedDescription)")
            }
            }
        
        
        
        
        
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
//                KRProgressHUD.dismiss()
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
//                    
//                  
//                    
//                }
//            }
//            else {
//                
//                KRProgressHUD.dismiss()
//                
//                print("Unexpected empty result.")
//            }
//            return nil
        }
  
    
    
    
    
    
    
    
    
}

class CheckBoxclickMyDepartMent : UITapGestureRecognizer {
    
    var MyDepartposs : Int!
    
    var MyDepartmemberNames : String!
    
    var MyDepartsecionId : Int!
    
    var MyDepartcheckBoxss : CheckBoxTwo!
    
    
}


class CheckBoxclickMyDepartMent2 : UITapGestureRecognizer {
    
    var MyDepartposs : Int!
    
    var MyDepartmemberNames : Int!
    
    var MyDepartsecionId : Int!
    
    var yearID : String!
    
    var MyDepartcheckBoxss : CheckBoxTwo!
    
    var sectionId : String!
    var YearId : String!
    
    
}

class specifyStu : UITapGestureRecognizer{
    
    
    
    var sectionId : String!
    var YearId : String!
    
}




