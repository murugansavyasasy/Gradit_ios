//
//  HodRespienViewController.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 13/03/23.
//

import UIKit
import DropDown
import ObjectMapper
import Alamofire
import KRProgressHUD
import AWSS3

@available(iOS 16.0, *)
class HodRespienViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var replySwitch: UISwitch!
    @IBOutlet weak var targetDefaultLabel: UILabel!
    
    @IBOutlet weak var TargetViewHeight: NSLayoutConstraint!
    @IBOutlet weak var selectTopDefaultLabels: UILabel!
    @IBOutlet weak var studentDefaultLabl: UILabel!
    @IBOutlet weak var parentDefaultLabel: UILabel!
    @IBOutlet weak var sendView: UIViewX!
    @IBOutlet weak var selectDropDownView: UIViewX!
    
    @IBOutlet weak var entierDefaultLbl: UILabel!
    @IBOutlet weak var cancelView: UIViewX!
    
    @IBOutlet weak var tvTop: NSLayoutConstraint!
    @IBOutlet weak var parentChkBox: CheckBoxTwo!
    @IBOutlet weak var studentChkBox: CheckBoxTwo!
    @IBOutlet weak var tv: UITableView!
    
    @IBOutlet weak var selectDropDownLabl: UILabel!
    @IBOutlet weak var enierSecChkBox: CheckBoxTwo!
    
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    
    @IBOutlet weak var selectSpecifyStudView: UIView!
    
    var identifier = "HodRespienTableViewCell"
    
    var ParticalStaffRef : [particualrDataDetails] = []
    var tutorRef : [TutorDataDetails] = []
    var particularSms : [SmsdataDetails] = []
    var MenuRefName :[menuApiDataDetails] = []
    var  entierRefName : [EntiercollegeDataDetails] = []
    var particularSmss : NoticePArticularResponce?
    var eventParticulae : [EventParticularResponce] = []
    
    var sentEntierImagePdf : [sendImagePdfDataDetails] = []
    var assigmentImagPdf : assigmentImagePdfResponce?
    var imagePdfEniter : [sendImagePdfPartiDataDetails] = []
    var sendVideoPart : [ParticularVideoUploadRespData] = []
    var voiceParticular : [VoiceParticalrDataDetails] = []
    var  SectionAndSubjctId : [String] = []
    var titlesTextField : String!
    var discreptionss : String!
    var DateLabels : String!
    var memberId : String!
    
    var clgId : String!
    
    var priority : String!
    
    var resiverType = "5"
    
    
    var resivre : String!
    var nameString : String!
    var sectionAndSubject : String!
    var dropItemsName : String!
    let dropDown = DropDown()
    
    var  tiltedArray : [String] = []
    
    var venumtextField : String!
    
    var deptid : String! = ""
    
    var courseId : String! = ""
    
    var yearIdsSpefy  = ""
    
    var sectionID = ""
    
    var SubjectId : String! = ""
    
    var AssigmentMenuAwsUrl : String!
    
    var AssigmentFileType : String!
    
    var imageFileType : String!
    var awsurl : String!
    
    var assigmentHeaderId : String!
    
    var videoURL : String!
    
    var videoIframe : String!
    
    var videoType : String!
    
    var voiceUrl : URL!
    
    var voiceDuration : String!
    
    var voiceReplyType : String!
    
    var assigmentDate : String!
    
    var EventTime : String!
    
    var str : [String] = []
    
    var strName : [String] = []
    var awsArry : [String] = []
    
    
    var SelectedIDString : String!
    
    var CheckBoxId : String!
    
    
    var photoArray = [UIImage]()
    
    var imagePicker = UIImagePickerController()
    var currentImageCount = 0
    var totalImageCount = 0
    var originalImagesArray = [UIImage]()
    var absoluteStringImg : String!
    var imageUrlArray = NSMutableArray()
    var convertedImagesUrlArray = NSMutableArray()
    var pdfData : Data? = nil
    var yearIdarry : [String] = []
    var is_parent_target_enabled = ""
    
    var deparmentIdArry  : [String] = []
    
    var deptidTutor : String! = ""
    
    var courseIdTutor : String! = ""
    
    var yearIdsSpefyTutor  = ""
    
    var sectionIDTutor = ""
    
    var deparmentIdArryTutor  : [String] = []
    var yearIdarryTutor : [String] = []
    var CourseIdArrayTutor : [String] = []
    var CourseIdArryar : [String] = []
    
    
    var SubjectIdForSpeficStudent : String!
    var  AssigmentnameString = ""
    
    //
    var AssigmentSelectedIDString =  ""
    var   AssigemtcourseId = ""
    var  AssigemtyearIdsSpefy = ""
    var  AssigemtsectionID = ""
    var AssigemtSubjectId = ""
    var assigemtDeparmentId = ""
    
    var is_read_enabled : String!
    var is_write_enabled : String!
    
    var VoiceHstryId = ""
    var voiceHstryHeaderId : String!
    var CallEnabel : Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Received voiceUrl:", voiceUrl)
        overrideUserInterfaceStyle = .light
        //
        //
        let defaults = UserDefaults.standard
        
        memberId = defaults.string(forKey: DefaultsKeys.memberid)
        clgId = defaults.string(forKey: DefaultsKeys.collegeid)
        priority = defaults.string(forKey: DefaultsKeys.priority)
        deptid = defaults.string(forKey: DefaultsKeys.deptid)
        is_parent_target_enabled = defaults.string(forKey: DefaultsKeys.is_parent_target_enabled)!
        CallEnabel = defaults.integer(forKey: DefaultsKeys.is_allow_to_make_call)
        print("tyylyly",VoiceHstryId)
        
        
        
        if CallEnabel == 1 && VoiceHstryId == "2"{
            
            entierDefaultLbl.isHidden = false
            replySwitch.isHidden = false
        }
        
        else{
            
            entierDefaultLbl.isHidden = true
            replySwitch.isHidden = true
            
        }
        
        
        let rownib = UINib(nibName: identifier, bundle: nil)
        tv.register(rownib, forCellReuseIdentifier: identifier)
        
        
        if resivre == "6"{
            
            
            selectDropDownView.isHidden = true
            selectTopDefaultLabels.text = "Select Target"
            tvTop.constant = -40
            
            studentChkBox.isHidden = true
            targetDefaultLabel.isHidden = true
            parentChkBox.isHidden = true
            studentDefaultLabl.isHidden = true
            parentDefaultLabel.isHidden = true
            subject()
            
        }
        
        else if resivre == "8"{
            
            
            selectTopDefaultLabels.text = "Select Target"
            selectDropDownView.isHidden = true
            tvTop.constant = -40
            
            studentChkBox.isHidden = true
            targetDefaultLabel.isHidden = true
            parentChkBox.isHidden = true
            studentDefaultLabl.isHidden = true
            parentDefaultLabel.isHidden = true
            
            subject()
            
        }
        
        else{
            
            selectTopDefaultLabels.text = "Select Subject/Tutor"
            selectDropDownView.isHidden = false
            
            studentChkBox.isHidden = false
            targetDefaultLabel.isHidden = false
            studentDefaultLabl.isHidden = false
            
            
            if is_parent_target_enabled == "0"{
                
                
                parentChkBox.isHidden = true
                parentDefaultLabel.isHidden = true
                
            }
            
            
            else{
                
                
                
                parentChkBox.isHidden = false
                parentDefaultLabel.isHidden = false
                
                
                
            }
            
            
            
            
            
        }
        
        
        if priority == "p1" {
            
            
            print("PrincipalVieewwColor")
            view.backgroundColor = UIColor(named: "Principal" )
            
            
        }else if priority == "p4" {
            
            print("StudentVieewwColor")
            view.backgroundColor = UIColor(named: "studentViewColors")
            
            
            
            
        } else if priority == "p3" ||  priority == "p2" {
            
            print("HooodddVieewwColor")
            view.backgroundColor = UIColor(named: "Teaching Staff")
            
            
            
        }
        else if priority == "p5"{
            
            
            
            view.backgroundColor = UIColor(named: "FatherColor")
            
            
            
            
        }
        
        else if priority == "p6"{
            
            
            
            view.backgroundColor = UIColor(named: "Teaching Staff")
            
            
            
        }
        
        
        else if priority == "p7"{
            
            
            
            view.backgroundColor = UIColor(named: "univercityColorCod")
            
            
            
        }
        
        
        
        
        
        let send = UITapGestureRecognizer(target: self, action: #selector(sendVc))
        sendView.addGestureRecognizer(send)
        
        
        let selectdrop = UITapGestureRecognizer(target: self, action: #selector(selectDropVc))
        selectDropDownView.addGestureRecognizer(selectdrop)
        
        
        let cancel = UITapGestureRecognizer(target: self, action: #selector(cancelVc))
        cancelView.addGestureRecognizer(cancel)
        
        
        replySwitch.addTarget(self, action: #selector(switchIsChanged), for: UIControl.Event.valueChanged)
        
        
        
    }
    
    
    
    @IBAction func switchIsChanged(mySwitch: UISwitch) {
        
        
        
        if replySwitch.isOn == true {
            
            voiceReplyType = "1"
            
            print("UISwitch is ON")
            
            
            
            
        }else{
            
            voiceReplyType = "0"
            
            print("UISwitch is OFF")
            
            
            
        }
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dropItemsName == "Subject"{
            return ParticalStaffRef.count
        }
        
        else if dropItemsName == "Tutor"{
            
            
            return tutorRef.count
        }
        
        return ParticalStaffRef.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as!
        
        HodRespienTableViewCell
        
        
        cell.selectionStyle = .none
        
        
        print("resivre",resivre)
        if resivre == "6"{
            
            
            cell.CheckImageView.isHidden = false
            cell.checkBoxView.isHidden = true
            cell.checkImageTop.constant = 46
            
            let subject : particualrDataDetails = ParticalStaffRef[indexPath.row]
            
            
            
            if(AssigmentSelectedIDString == subject.subjectid){
                
                
                
                cell.CheckImageView.image = UIImage(named: "done")
                
            }
            
            else{
                
                
                
                
                cell.CheckImageView.image = UIImage(named: "checkboxs")
                
            }
            
            cell.SecLabel.text = subject.sectionname
            cell.SemesterLabel.text = subject.semestername
            cell.SubjectNameLabel.text = subject.subjectname
            cell.courseNameLabel.text = subject.coursename
            cell.yearLabel.text = subject.yearname
            
            
            
            let selectSpecify = SpecifyCell(target: self, action: #selector(SelectSpecifyVc))
            selectSpecify.sectionId = subject.sectionid
            selectSpecify.DepartMentId = subject.departmentid
            selectSpecify.yearID = subject.yearid
            selectSpecify.courseId = subject.courseid
            selectSpecify.subjectId = subject.subjectid
            selectSpecifyStudView.addGestureRecognizer(selectSpecify)
            
            
            
        }
        
        
        
        
        
        
        
        
        else if resivre == "8"{
            
            
            cell.CheckImageView.isHidden = false
            cell.checkBoxView.isHidden = true
            cell.checkImageTop.constant = 46
            
            
            let subject : particualrDataDetails = ParticalStaffRef[indexPath.row]
            
            
            
            
            cell.SecLabel.text = subject.sectionname
            cell.SemesterLabel.text = subject.semestername
            cell.SubjectNameLabel.text = subject.subjectname
            cell.courseNameLabel.text = subject.coursename
            cell.yearLabel.text = subject.yearname
            
            print("sectionIDsectionID",sectionID)
            //
            
            if(AssigmentSelectedIDString == subject.subjectid){
                
                
                
                
                
                cell.CheckImageView.image = UIImage(named: "done")
            }
            
            else{
                
                
                cell.CheckImageView.image = UIImage(named: "checkboxs")
                
                
            }
            
            let selectSpecify = SpecifyCell(target: self, action: #selector(SelectSpecifyVc))
            selectSpecify.sectionId = subject.sectionid
            selectSpecify.DepartMentId = subject.departmentid
            selectSpecify.yearID = subject.yearid
            selectSpecify.courseId = subject.courseid
            selectSpecify.subjectId = subject.subjectid
            selectSpecifyStudView.addGestureRecognizer(selectSpecify)
        }
        
        
        
        
        
        
        
        
        
        else{
            if dropItemsName == "Subject"{
                
                cell.CheckImageView.isHidden = true
                cell.checkBoxView.isChecked = false
                let subject : particualrDataDetails = ParticalStaffRef[indexPath.row]
                
                
                
                cell.SecLabel.text = subject.sectionname
                cell.SemesterLabel.text = subject.semestername
                cell.SubjectNameLabel.text = subject.subjectname
                cell.courseNameLabel.text = subject.coursename
                cell.yearLabel.text = subject.yearname
                
                
                print("sectionIDsectionI121D",subject.sectionid)
                
                //CheckBoxGesturess
                let check = CheckBoxGest(target: self, action:#selector(sbjectVc))
                
                check.checkBoxss = cell.checkBoxView
                check.memberName = subject.sectionid
                check.courseId = subject.courseid
                check.yearID = subject.yearid
                check.deparMentId = subject.departmentid
                check.subjectIDs = subject.subjectid
                check.pos = indexPath.row
                cell.checkBoxView.addGestureRecognizer(check)
                
                
                let selectSpecify = SpecifyCell(target: self, action: #selector(SelectSpecifyVc))
                selectSpecify.sectionId = subject.sectionid
                selectSpecify.DepartMentId = subject.departmentid
                selectSpecify.yearID = subject.yearid
                selectSpecify.courseId = subject.courseid
                selectSpecify.subjectId = subject.subjectid
                selectSpecifyStudView.addGestureRecognizer(selectSpecify)
                
                
                
            }
            
            
            
            
            
            
            
            
            else if dropItemsName == "Tutor" {
                
                cell.CheckImageView.isHidden = true
                
                cell.checkBoxView.isChecked = false
                
                let tutor : TutorDataDetails = tutorRef[indexPath.row]
                
                cell.SecLabel.text = tutor.sectionname
                cell.SemesterLabel.text = tutor.semestername
                cell.SubjectNameLabel.text = tutor.subjectname
                cell.courseNameLabel.text = tutor.coursename
                cell.yearLabel.text = tutor.yearname
                
                
                
                
                let check = CheckBoxGestTutor(target: self, action:#selector(TutorVc))
                check.checkBoxss = cell.checkBoxView
                check.memberName = tutor.sectionid
                check.courseId = tutor.courseid
                check.yearID = tutor.yearid
                check.deparMentId = tutor.departmentid
                
                
                cell.checkBoxView.addGestureRecognizer(check)
                
                
                let selectSpecify = SpecifyCell(target: self, action: #selector(SelectSpecifyVc))
                selectSpecify.sectionId = tutor.sectionid
                selectSpecify.DepartMentId = tutor.departmentid
                selectSpecify.yearID = tutor.yearid
                selectSpecify.courseId = tutor.courseid
                selectSpecify.subjectId = tutor.subjectid
                selectSpecifyStudView.addGestureRecognizer(selectSpecify)
            }
        }
        
        return cell
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let currentCell = tableView.cellForRow(at: indexPath) as! HodRespienTableViewCell
        
        
        
        
        if resivre == "6"  ||  resivre == "8"{
            
            
            
            
            
            let subject : particualrDataDetails = ParticalStaffRef[indexPath.row]
            
            currentCell.CheckImageView.isHidden = false
            currentCell.CheckImageView.image = UIImage(named: "done")
            nameString = subject.sectionid
            
            //
            AssigmentSelectedIDString = subject.subjectid ?? ""
            AssigemtcourseId = subject.courseid ?? ""
            AssigemtyearIdsSpefy = subject.yearid ?? ""
            AssigemtsectionID = subject.sectionid ?? ""
            AssigemtSubjectId = subject.subjectid ?? ""
            assigemtDeparmentId = subject.departmentid ?? ""
            SubjectIdForSpeficStudent = subject.subjectid
            
            tv.reloadData()   // important
            
        }
        
        
        
        
        
        else{
            
            
            print("fvfdv")
            
        }
        
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    
    
    
    @IBAction func AttendanceSbjectVc(gestur : CheckBoxGest){
        
        
        
        
        
        
    }
    
    
    @IBAction func sbjectVc(gestur : CheckBoxGest){
        
        
        
        
        
        
        
        
        
        if gestur.checkBoxss.isChecked == true{
            
            
            gestur.checkBoxss.isChecked = false
            
            
            
            
            if(DefaultsKeys.resiverId.contains(gestur.memberName)){
                
                
                
                
                
                
                
                if let index = DefaultsKeys.resiverId.firstIndex(of: gestur.memberName) {
                    
                    
                    print("indexxxxxxxxxxssssas",index)
                    DefaultsKeys.resiverId.remove(at: index)
                    
                    
                    
                }
                
                
                print("hhhhhhhhhhhhhhhhh", DefaultsKeys.resiverId)
                
            }
            
            
            
            
            
            
            if (SectionAndSubjctId.contains(gestur.memberName + ":" + gestur.subjectIDs)){
                
                
                if let index = SectionAndSubjctId.firstIndex(of: gestur.memberName + ":" + gestur.subjectIDs) {
                    
                    
                    
                    SectionAndSubjctId.remove(at: index)
                    
                    
                    
                }
                
            }
            
            
            nameString =   DefaultsKeys.resiverId.joined(separator: "~")
            
            sectionAndSubject = SectionAndSubjctId.joined(separator: "~")
            
            
            if(yearIdarry.contains(gestur.yearID)){
                
                
                
                
                
                
                
                if let index = yearIdarry.firstIndex(of: gestur.yearID) {
                    
                    
                    
                    yearIdarry.remove(at: index)
                    
                    
                    
                }
                
            }
            
            
            
            
            yearIdsSpefy = yearIdarry.joined(separator: ",")
            
            
            
            
            if(deparmentIdArry.contains(gestur.deparMentId)){
                
                
                
                
                
                
                
                if let index = deparmentIdArry.firstIndex(of: gestur.deparMentId) {
                    
                    
                    
                    deparmentIdArry.remove(at: index)
                    
                    
                    
                }
                
            }
            
            
            
            deptid = deparmentIdArry.joined(separator: ",")
            
            
            
            
            
            if(CourseIdArryar.contains(gestur.courseId)){
                
                
                
                
                
                
                
                if let index = CourseIdArryar.firstIndex(of: gestur.courseId) {
                    
                    
                    
                    CourseIdArryar.remove(at: index)
                    
                    
                    
                }
                
            }
            
            courseId = CourseIdArryar.joined(separator: "~")
            
            
            
            print("yearunckeck",yearIdsSpefy)
            
            
            
            
            
            
            
            
            
            
            
            
        }else{
            
            gestur.checkBoxss.isChecked = true
            
            
            SectionAndSubjctId.append(gestur.memberName + ":" + gestur.subjectIDs)
            DefaultsKeys.resiverId.append(gestur.memberName)
            
            SubjectIdForSpeficStudent = gestur.subjectIDs
            
            print("efaultsKeys.resiverId1234567",DefaultsKeys.resiverId)
            
            nameString =    DefaultsKeys.resiverId.joined(separator: "~")
            sectionAndSubject = SectionAndSubjctId.joined(separator: "~")
            print("sectionAndSubject",sectionAndSubject)
            
            
            yearIdarry.append(gestur.yearID)
            
            yearIdsSpefy = yearIdarry.joined(separator: ",")
            
            
            
            deparmentIdArry.append(gestur.deparMentId)
            
            deptid = deparmentIdArry.joined(separator: ",")
            
            CourseIdArryar.append(gestur.courseId)
            courseId = CourseIdArryar.joined(separator: ",")
            
            
            
            
        }
        
        
        
        
    }
    
    
    
    
    @IBAction func TutorVc(gestur : CheckBoxGestTutor){
        
        
        
        
        if gestur.checkBoxss.isChecked == true{
            
            
            gestur.checkBoxss.isChecked = false
            
            
            
            if(DefaultsKeys.resiverId.contains(gestur.memberName)){
                
                
                
                
                
                
                
                if let index = DefaultsKeys.resiverId.firstIndex(of: gestur.memberName) {
                    
                    
                    
                    DefaultsKeys.resiverId.remove(at: index)
                    
                    
                    
                }
                
                
            }
            
            nameString =   DefaultsKeys.resiverId.joined(separator: "~")
            if(yearIdarryTutor.contains(gestur.yearID)){
                
                
                
                
                
                
                
                if let index = yearIdarryTutor.firstIndex(of: gestur.yearID) {
                    
                    
                    
                    yearIdarryTutor.remove(at: index)
                    
                    
                }
                
            }
            
            
            
            
            yearIdsSpefyTutor = yearIdarryTutor.joined(separator: ",")
            
            
            
            
            if(deparmentIdArryTutor.contains(gestur.deparMentId)){
                
                
                
                
                
                
                
                if let index = deparmentIdArryTutor.firstIndex(of: gestur.deparMentId) {
                    
                    
                    
                    deparmentIdArryTutor.remove(at: index)
                    
                    
                    
                }
                
            }
            
            
            
            deptidTutor = deparmentIdArryTutor.joined(separator: ",")
            
            
            
            if(CourseIdArrayTutor.contains(gestur.courseId)){
                
                
                
                
                
                
                
                if let index = CourseIdArrayTutor.firstIndex(of: gestur.courseId) {
                    
                    
                    
                    CourseIdArrayTutor.remove(at: index)
                    
                    
                    
                }
                
            }
            
            
            courseIdTutor = CourseIdArrayTutor.joined(separator: ",")
            
            print("yearunckeck",yearIdsSpefy)
            
            
        }else{
            
            gestur.checkBoxss.isChecked = true
            
            DefaultsKeys.resiverId.append(gestur.memberName)
            
            nameString =   DefaultsKeys.resiverId.joined(separator: "~")
            
            yearIdarryTutor.append(gestur.yearID)
            
            yearIdsSpefyTutor = yearIdarryTutor.joined(separator: ",")
            
            deparmentIdArryTutor.append(gestur.deparMentId)
            
            deptidTutor = deparmentIdArryTutor.joined(separator: ",")
            
            CourseIdArrayTutor.append(gestur.courseId)
            courseIdTutor = CourseIdArrayTutor.joined(separator: ",")
        }
    }
    
    
    
    func subject(){
        
        var subj = ParticularStaffModal()
        
        subj.collegeid = clgId
        subj.staffid = memberId
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.GetSubjectListforparticularstaff,
            httpMethod: .post,
            queryParam: nil,
            requestBody: subj
        ) {[weak self] (result:Result<particularStaffResponce, Error>) in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let success):
                if success.Status == 1{
                    
                    ParticalStaffRef = success.data ?? []
                    
                    tv.delegate = self
                    tv.dataSource = self
                    tv.reloadData()
                } else{
                    
                    let refreshAlert = UIAlertController(title: "", message: success.Message, preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        
                    }))
                    
                    self.present(refreshAlert, animated: true, completion: nil)
                    
                    tv.delegate = self
                    tv.dataSource = self
                    tv.reloadData()
                }
            case .failure(let failure):
                print("Error:",failure.localizedDescription)
            }
            
        }
    }
    
    func Tutor(){
        
        var Tutors = TutorModal()
        
        Tutors.collegeid = clgId
        Tutors.staffid = memberId
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.GetClassListForTutor,
            httpMethod: .post,
            queryParam: nil,
            requestBody: Tutors
        ) {[weak self] (result:Result<TutorResponce, Error>) in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let success):
                
                if success.Status == 1{
                    
                    tutorRef = success.data ?? []
                    
                    tv.delegate = self
                    tv.dataSource = self
                    tv.reloadData()
                } else{
                    
                    let refreshAlert = UIAlertController(title: "", message: success.Message, preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        
                    }))
                    
                    self.present(refreshAlert, animated: true, completion: nil)
                    
                    tv.delegate = self
                    tv.dataSource = self
                    tv.reloadData()
                }
            case .failure(let failure):
                print("Error:",failure.localizedDescription)
            }
            
        }
        
    }
    
    
    
    func HistoryVoiceSendParticular() {
        
        var voiceUpload = VoiceHstryModal()
        
        voiceUpload.staffid = memberId
        voiceUpload.description = discreptionss
        voiceUpload.callertype = priority
        voiceUpload.collegeid = clgId
        voiceUpload.forwarding_voice_id = voiceHstryHeaderId
        voiceUpload.receiverid =  nameString
        voiceUpload.receivertype = resiverType
        voiceUpload.subjectid = sectionAndSubject
        if is_parent_target_enabled == "0"{
            voiceUpload.isparent = false
        }else{
            voiceUpload.isparent = parentChkBox.isChecked
        }
        voiceUpload.isemergencyvoice = voiceReplyType
        voiceUpload.isstaff = false
        voiceUpload.isstudent = studentChkBox.isChecked
        
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
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] (action: UIAlertAction!) in
                        
                        if self?.priority == "p2" || self?.priority == "p3" {
                            
                            let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
                            vc.is_read_enabled = "1"
                            vc.is_write_enabled = "1"
                            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                            
                            vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
                            vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                            vc.strName = self?.strName ?? []
                            vc.str = self?.str ?? []
                            
                            vc.modalPresentationStyle = .fullScreen
                            self?.present(vc, animated: true , completion: nil)
                            
                        } else  if self?.priority == "p7" {
                            
                            let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
                            vc.is_read_enabled = "1"
                            vc.is_write_enabled = "1"
                            vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
                            
                            vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
                            vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                            vc.strName = self?.strName ?? []
                            vc.str = self?.str ?? []
                            
                            vc.modalPresentationStyle = .fullScreen
                            self?.present(vc, animated: true , completion: nil)
                            
                        } else{
                            
                            let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
                            vc.is_read_enabled = "1"
                            vc.is_write_enabled = "1"
                            vc.view.backgroundColor = UIColor(named: "Principal" )
                            
                            vc.CommuniSegementName.backgroundColor = UIColor(named: "UnSelector")
                            vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "Selector")
                            
                            vc.strName = self?.strName ?? []
                            vc.str = self?.str ?? []
                            vc.modalPresentationStyle = .fullScreen
                            self?.present(vc, animated: true , completion: nil)
                            
                        }
                        
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
    
    
    
    @IBAction func sendVc(){
        
        
        
        
        if nameString == nil{
            
            let refreshAlert = UIAlertController(title: "", message: "Select Your Receiver Type", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
                
            }))
            
            present(refreshAlert, animated: true, completion: nil)
            
        }
        
        
        
        
        
        else if nameString == ""{
            
            
            
            let refreshAlert = UIAlertController(title: "", message: "Select Your Receiver Type", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
                
            }))
            
            
            
            
            present(refreshAlert, animated: true, completion: nil)
            
            
            
        }
        
        
        
        else{
            
            if (studentChkBox.isChecked == true) || (parentChkBox.isChecked == true){
                
                
                
                
                let refreshAlert = UIAlertController(title: "", message: "Are you sure you want to submit?", preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in
                    
                    if self.resivre == "1"{
                        
                        
                        if imageFileType == "pdf"{
                            
                            
                            
                            uploadPDFFileToAWS(pdfData :  pdfData as! NSData)
                        }
                        
                        else{
                            
                            
                            
                            
                            getImageURL(images: photoArray)
                            
                            
                            
                            DispatchQueue.main.asyncAfter(deadline: .now()+4.3) { [self] in
                                
                                KRProgressHUD.dismiss()
                                
                                NoticeSendSmsToParticular(ImageFile: awsArry)
                                
                            }
                            
                        }
                        
                        print("Notice")
                    }
                    
                    else if self.resivre == "2"{
                        
                        print("video")
                        
                        self.SendVideoToParticular()
                        
                    }
                    
                    else if self.resivre == "3"{
                        
                        
                        print("event")
                        
                        self.EventParticular()
                    }
                    
                    else if self.resivre == "4"{
                        
                        
                        print("communication")
                        self.SendSmsToParticular()
                        
                        
                    }
                    
                    
                    else if self.resivre == "5"{
                        print("imagePdf",pdfData)
                        
                        if imageFileType == "3"{
                            
                            uploadPDFFileToAWS(pdfData: pdfData! as NSData)
                        }
                        else{
                            
                            
                            //
                            
                            
                            
                            getImageURL(images: photoArray)
                            
                            
                            
                            DispatchQueue.main.asyncAfter(deadline: .now()+4.3) { [self] in
                                
                                KRProgressHUD.dismiss()
                                
                                
                                
                                
                                
                                ImagePdfParticular(ImageFile: awsArry)
                                
                            }
                            
                        }
                        
                        
                    }
                    
                    
                    
                    else if self.resivre == "11"{
                        
                        print("reseiveeeeeeeewwwwwwwww",VoiceHstryId)
                        if VoiceHstryId == "1"{
                            self.multypartAudio()
                        }else if VoiceHstryId == "2"{
                            
                            self.HistoryVoiceSendParticular()
                        }
                        
                    }
                    
                }))
                
                
                refreshAlert.addAction(UIAlertAction(title: "CANCEL", style: .default, handler: { (action: UIAlertAction!) in
                    
                    
                }))
                
                self.present(refreshAlert, animated: true, completion: nil)
                
                
                
                
            }
            
            else{
                
                
                
                
                if resivre == "6"  {
                    
                    
                    let refreshAlert = UIAlertController(title: "", message: "Are you sure you want to submit?", preferredStyle: UIAlertController.Style.alert)
                    
                    
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in
                        
                        
                        
                        
                        if AssigmentFileType == "pdf"{
                            
                            
                            uploadPDFFileToAWS(pdfData: pdfData as! NSData)
                            
                        }
                        
                        else if AssigmentFileType == "Text"{
                            
                            
                            
                            
                            AssigmentText()
                        }
                        else{
                            
                            
                            
                            getImageURL(images: photoArray)
                            
                            DispatchQueue.main.asyncAfter(deadline: .now()+4.3) { [self] in
                                
                                KRProgressHUD.dismiss()
                                
                                
                                
                                
                                
                                assigmentImagePdf(imageArry:awsArry )
                                
                            }
                            
                            
                        }
                        
                        
                    }))
                    
                    
                    refreshAlert.addAction(UIAlertAction(title: "CANCEL", style: .default, handler: { (action: UIAlertAction!) in
                        
                        
                    }))
                    
                    self.present(refreshAlert, animated: true, completion: nil)
                    
                    
                    
                }
                
                
                else if resivre == "8"{
                    
                    
                    let refreshAlert = UIAlertController(title: "", message: "Are you sure you want to submit?", preferredStyle: UIAlertController.Style.alert)
                    
                    
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in
                        
                        
                        
                        
                        
                        
                        if AssigmentFileType == "pdf"{
                            
                            
                            uploadPDFFileToAWS(pdfData: pdfData! as NSData )
                            
                        }
                        
                        else if AssigmentFileType == "Text"{
                            
                            
                            AssigmentText()
                            
                        }
                        else{
                            
                            
                            
                            getImageURL(images: photoArray)
                            
                            DispatchQueue.main.asyncAfter(deadline: .now()+4.3) { [self] in
                                
                                KRProgressHUD.dismiss()
                                
                                
                                
                                
                                
                                assigmentImagePdf(imageArry:awsArry )
                                
                            }
                            
                            
                        }
                        
                        
                        
                    }))
                    
                    
                    refreshAlert.addAction(UIAlertAction(title: "CANCEL", style: .default, handler: { (action: UIAlertAction!) in
                        
                        
                    }))
                    
                    self.present(refreshAlert, animated: true, completion: nil)
                    
                }
                
                else {
                    
                    
                    let refreshAlert = UIAlertController(title: "", message: "Select Target", preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        
                        
                    }))
                    
                    
                    
                    
                    self.present(refreshAlert, animated: true, completion: nil)
                    
                }
                
                
                
                
                
                
                
                
                
                
            }
            
            //        }
            
            
        }
        
        
    }
    
    
    
    @IBAction func selectDropVc(){
        
        
        
        yearIdarry.removeAll()
        yearIdarryTutor.removeAll()
        deparmentIdArry.removeAll()
        deparmentIdArryTutor.removeAll()
        CourseIdArryar.removeAll()
        CourseIdArrayTutor.removeAll()
        DefaultsKeys.resiverId.removeAll()
        
        let myArray = ["Subject","Tutor"]
        
        dropDown.dataSource = myArray//4
        dropDown.anchorView = selectDropDownView //5
        
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        
        dropDown.direction = .bottom
        DropDown.appearance().backgroundColor = UIColor.white
        dropDown.show() //7
        
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.selectDropDownLabl.text = item
            
            dropItemsName = item
            
            if item == "Subject"{
                
                print("Subject")
                
                DefaultsKeys.resiverId.removeAll()
                subject()
                
            }
            
            
            
            else if item == "Tutor"{
                print("Tutor")
                DefaultsKeys.resiverId.removeAll()
                Tutor()
                
            }
            
            
            
        }
        
    }
    
    @IBAction func SelectSpecifyVc( ges : SpecifyCell){
        
        
        if resivre == "8"  || resivre == "6"{
            
            
            
            if nameString == nil{
                
                
                
                let refreshAlert = UIAlertController(title: "", message: "Select any one section.", preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    
                    
                }))
                
                
                
                
                self.present(refreshAlert, animated: true, completion: nil)
                
                
                
            }
            
            
            else {
                
                
                
                print(" ges.subjectId ges.subjectId", SubjectIdForSpeficStudent)
                
                
                let vc  = SpecificStudentViewController(nibName: nil, bundle: nil)
                vc.textTitle = titlesTextField
                vc.TextDiscrition = discreptionss
                vc.MenuType = resivre
                vc.subjectID = AssigemtSubjectId
                vc.AssigmentAwsURl = AssigmentMenuAwsUrl
                vc.eventDate = DateLabels
                vc.imageFileType = imageFileType
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                vc.ItemName = dropItemsName
                vc.courseId = AssigemtcourseId
                vc.YearId = AssigemtyearIdsSpefy
                vc.departmentId = assigemtDeparmentId
                
                vc.sectionId = nameString
                vc.eventVenu = venumtextField
                vc.awsurl = awsurl
                vc.assigmentForwardHeaderId = assigmentHeaderId
                vc.videoUrl = videoURL
                vc.iframeVideo = videoIframe
                vc.EventTime = EventTime
                vc.awsArry = awsArry
                vc.assigmentDate = assigmentDate
                vc.AssigmentFileType = AssigmentFileType
                vc.strs = str
                vc.strName = strName
                vc.awsArry = awsArry
                vc.pdfData = pdfData
                vc.photoArray = photoArray
                vc.VoiceHstryId = VoiceHstryId
                vc.voiceHstryHeaderId = voiceHstryHeaderId
                vc.subjectIdForStuddent = SubjectIdForSpeficStudent
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true,completion: nil)
                
                
                
                
            }
            
        }
        
        
        
        
        else{
            
            
            if dropItemsName == "Subject" {
                
                
                print("DefaultsKeys.resiverId", DefaultsKeys.resiverId)
                if DefaultsKeys.resiverId.count == 1 {
                    
                    
                    print(" ges.subjectId ges.subjectId", SubjectIdForSpeficStudent)
                    let vc  = SpecificStudentViewController(nibName: nil, bundle: nil)
                    
                    
                    vc.textTitle = titlesTextField
                    vc.TextDiscrition = discreptionss
                    vc.MenuType = resivre
                    vc.subjectID = SubjectId
                    vc.AssigmentAwsURl = AssigmentMenuAwsUrl
                    vc.eventDate = DateLabels
                    vc.imageFileType = imageFileType
                    //
                    vc.ItemName = dropItemsName
                    
                    vc.is_read_enabled = is_read_enabled
                    vc.is_write_enabled = is_write_enabled
                    vc.courseId = courseId
                    vc.YearId = yearIdsSpefy
                    vc.departmentId = deptid
                    vc.sectionId = nameString
                    //
                    vc.eventVenu = venumtextField
                    vc.awsurl = awsurl
                    vc.assigmentForwardHeaderId = assigmentHeaderId
                    vc.videoUrl = videoURL
                    vc.iframeVideo = videoIframe
                    vc.voiceURl = voiceUrl
                    vc.voiceDuration = voiceDuration
                    vc.strs = str
                    vc.strName = strName
                    vc.EventTime = EventTime
                    vc.awsArry = awsArry
                    vc.assigmentDate = assigmentDate
                    vc.AssigmentFileType = AssigmentFileType
                    vc.pdfData = pdfData
                    vc.photoArray = photoArray
                    vc.VoiceHstryId = VoiceHstryId
                    vc.voiceHstryHeaderId = voiceHstryHeaderId
                    
                    vc.subjectIdForStuddent = SubjectIdForSpeficStudent
                    vc.modalPresentationStyle = .fullScreen
                    present(vc, animated: true,completion: nil)
                    
                    //
                }
                //
                //
                else {
                    
                    
                    let refreshAlert = UIAlertController(title: "", message: "Select any one section.", preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        
                        
                    }))
                    
                    
                    
                    
                    self.present(refreshAlert, animated: true, completion: nil)
                    
                    
                    
                    
                }
                
            }else if dropItemsName == "Tutor"{
                
                if DefaultsKeys.resiverId.count == 1 {
                    let vc  = SpecificStudentViewController(nibName: nil, bundle: nil)
                    
                    vc.textTitle = titlesTextField
                    vc.MenuType = resivre
                    vc.TextDiscrition = discreptionss
                    vc.subjectID = SubjectId
                    vc.AssigmentAwsURl = AssigmentMenuAwsUrl
                    vc.eventDate = DateLabels
                    vc.ItemName = dropItemsName
                    vc.is_read_enabled = is_read_enabled
                    vc.is_write_enabled = is_write_enabled
                    
                    vc.courseId = courseIdTutor
                    vc.YearId = yearIdsSpefyTutor
                    vc.departmentId = deptidTutor
                    vc.sectionId = nameString
                    vc.eventVenu = venumtextField
                    vc.imageFileType = imageFileType
                    vc.awsurl = awsurl
                    vc.videoUrl = videoURL
                    vc.iframeVideo = videoIframe
                    vc.voiceURl = voiceUrl
                    vc.strs = str
                    vc.strName = strName
                    vc.voiceDuration = voiceDuration
                    vc.EventTime = EventTime
                    vc.awsArry = awsArry
                    vc.assigmentDate = assigmentDate
                    vc.AssigmentFileType = AssigmentFileType
                    vc.pdfData = pdfData
                    vc.photoArray = photoArray
                    vc.VoiceHstryId = VoiceHstryId
                    vc.voiceHstryHeaderId = voiceHstryHeaderId
                    vc.subjectIdForStuddent = ges.subjectId
                    vc.modalPresentationStyle = .fullScreen
                    present(vc, animated: true,completion: nil)
                }
                
                
                else {
                    
                    
                    let refreshAlert = UIAlertController(title: "", message: "Select any one section.", preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        
                        
                    }))
                    
                    
                    
                    
                    self.present(refreshAlert, animated: true, completion: nil)
                    
                    
                    
                    
                }
                
            }
            
            
            
            
        }
        
        
        
        
        
        
        
        
        
    }
    
    
    
    func multypartAudio() {
        
        KRProgressHUD.show()
        
        let vimeoVideoEndpoint = "https://gradit.voicesnap.com/api/AppDetailsBal/SendFileToParticularType"
        let vimeoVideoEndpointTutor = "https://gradit.voicesnap.com/api/AppDetailsBal/SendFileToParticularTypeFromTutor"
        
        let endPointUrl = dropItemsName == "Subject" ? vimeoVideoEndpoint : vimeoVideoEndpointTutor
        
        var voiceUpload = particularVoiceUploadMoad()
        
        voiceUpload.staffid = memberId
        voiceUpload.description = discreptionss
        voiceUpload.callertype = priority
        voiceUpload.collegeid = clgId
        voiceUpload.fileduration = voiceDuration
        voiceUpload.filetype = "1"
        voiceUpload.isemergencyvoice = voiceReplyType
        voiceUpload.isparent = parentChkBox.isChecked
        voiceUpload.isstaff = false
        voiceUpload.isstudent = studentChkBox.isChecked
        voiceUpload.receiverid = nameString
        voiceUpload.receivertype = resiverType
        voiceUpload.subjectid = sectionAndSubject
        
        let voiceUploadStr: String

        do {
            let jsonData = try JSONEncoder().encode(voiceUpload)
            voiceUploadStr = String(data: jsonData, encoding: .utf8) ?? ""
        } catch {
            print("Encoding error:", error)
            return
        }
        
        let param = ["info": voiceUploadStr]
        
        MultipartManager.shared.uploadVoice(
            url: endPointUrl,
            fileURL: voiceUrl,
            infoJSONString: voiceUploadStr
        ) {[weak self] (result)  in
            
            guard let self = self else { return }
            KRProgressHUD.dismiss()
            switch result {
                    
                case .success(let json):
                    
                    print("json", json)
                    
                    if let status = json["Status"] as? Int {
                        
                        let message = json["Message"] as! String
                        
                        let refreshAlert = UIAlertController(title: "", message: message, preferredStyle: .alert)
                        
                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
                            
                            guard let self = self else { return }
                            
                            if priority == "p2" || priority == "p3" {
                                
                                let vc = SenderCommunicationHomePageViewController()
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
                                
                                let vc = SenderCommunicationHomePageViewController()
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
                        
                        DispatchQueue.main.async {
                            self.present(refreshAlert, animated: true)
                        }
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
        
//        let voiceUploadStr = voiceUpload.toJSONString()
//        
//        if dropItemsName == "Subject" {
//            
//            
//            AF.upload(multipartFormData: { [self] (multipartFormData) in
//                KRProgressHUD.show()
//                
//                
//                var videoU : String!
//                
//                let pathURL = voiceUrl
//                
//                let pathString = pathURL!.path
//                
//                multipartFormData.append(URL(fileURLWithPath: pathString), withName: "file")
//                
//                multipartFormData.append(Data(voiceUploadStr!.description.utf8), withName: "info")
//                
//                
//                
//                print("parameters.description.utf8",voiceUploadStr!.description.utf8)
//                
//                
//            },to: vimeoVideoEndpoint).responseJSON{
//                //
//                res in
                
//                
//                KRProgressHUD.dismiss()
//                
//                
//                print("vimeoVideoEndpointvimeoVideoEndpoint",vimeoVideoEndpoint)
//                let json_str = String(data: res.data!, encoding: .utf8)
//                
//                print("json \(json_str!)")
//                
//                
//                
//                do {
//                    if let json = try JSONSerialization.jsonObject(with: res.data!, options: []) as? [String: Any] {
//                        if let status = json["Status"] as? Int {
//                            print("Status: \(status)")
//                            
//                            if status == 1 {
//                                
//                                
//                                let a = json["Message"]
//                                
//                                
//                                let refreshAlert = UIAlertController(title: "", message: a as! String, preferredStyle: UIAlertController.Style.alert)
//                                
//                                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in
//                                    
//                                    
//                                    if priority == "p2" || priority == "p3" {
//                                        
//                                        let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
//                                        vc.is_read_enabled = "1"
//                                        vc.is_write_enabled = "1"
//                                        vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
//                                        
//                                        vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
//                                        vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
//                                        vc.strName = self.strName
//                                        vc.str = self.str
//                                        
//                                        vc.modalPresentationStyle = .fullScreen
//                                        self.present(vc, animated: true , completion: nil)
//                                        
//                                    }
//                                    
//                                    
//                                    else  if priority == "p7" {
//                                        
//                                        let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
//                                        vc.is_read_enabled = "1"
//                                        vc.is_write_enabled = "1"
//                                        vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
//                                        
//                                        vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
//                                        vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
//                                        vc.strName = self.strName
//                                        vc.str = self.str
//                                        
//                                        vc.modalPresentationStyle = .fullScreen
//                                        self.present(vc, animated: true , completion: nil)
//                                        
//                                    }
//                                    
//                                    
//                                    else{
//                                        
//                                        let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
//                                        vc.is_read_enabled = "1"
//                                        vc.is_write_enabled = "1"
//                                        vc.view.backgroundColor = UIColor(named: "Principal" )
//                                        
//                                        vc.CommuniSegementName.backgroundColor = UIColor(named: "UnSelector")
//                                        vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "Selector")
//                                        
//                                        vc.strName = self.strName
//                                        vc.str = self.str
//                                        vc.modalPresentationStyle = .fullScreen
//                                        self.present(vc, animated: true , completion: nil)
//                                        
//                                    }
//                                    
//                                    
//                                    
//                                    
//                                }))
//                                
//                                
//                                
//                                self.present(refreshAlert, animated: true, completion: nil)
//                                
//                                
//                            }
//                            else {
//                                
//                                
//                                
//                                let a = json["Message"]
//                                
//                                let refreshAlert = UIAlertController(title: "", message: a as! String, preferredStyle: UIAlertController.Style.alert)
//                                
//                                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in
//                                    
//                                    
//                                    if priority == "p2" || priority == "p3" {
//                                        
//                                        let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
//                                        vc.is_read_enabled = "1"
//                                        vc.is_write_enabled = "1"
//                                        vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
//                                        
//                                        vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
//                                        vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
//                                        vc.strName = self.strName
//                                        vc.str = self.str
//                                        
//                                        vc.modalPresentationStyle = .fullScreen
//                                        self.present(vc, animated: true , completion: nil)
//                                        
//                                    }
//                                    
//                                    else  if priority == "p7" {
//                                        
//                                        let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
//                                        vc.is_read_enabled = "1"
//                                        vc.is_write_enabled = "1"
//                                        vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
//                                        
//                                        vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
//                                        vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
//                                        vc.strName = self.strName
//                                        vc.str = self.str
//                                        
//                                        vc.modalPresentationStyle = .fullScreen
//                                        self.present(vc, animated: true , completion: nil)
//                                        
//                                    }
//                                    
//                                    
//                                    else{
//                                        
//                                        let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
//                                        vc.is_read_enabled = "1"
//                                        vc.is_write_enabled = "1"
//                                        vc.view.backgroundColor = UIColor(named: "Principal" )
//                                        
//                                        vc.CommuniSegementName.backgroundColor = UIColor(named: "UnSelector")
//                                        vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "Selector")
//                                        
//                                        vc.strName = self.strName
//                                        vc.str = self.str
//                                        vc.modalPresentationStyle = .fullScreen
//                                        self.present(vc, animated: true , completion: nil)
//                                        
//                                    }
//                                    
//                                    
//                                    
//                                    
//                                }))
//                                
//                                
//                                
//                                self.present(refreshAlert, animated: true, completion: nil)
//                                
//                            }
//                            
//                        }
//                    }
//                } catch {
//                    print("Error parsing JSON: \(error)")
//                }
//                
//            }
//            
//            
//        }
        
        
        
//        else{
//            
//            
//            
//            AF.upload(multipartFormData: { [self] (multipartFormData) in
//                KRProgressHUD.show()
//                
//                
//                
//                var videoU : String!
//                
//                let pathURL = voiceUrl
//                
//                let pathString = pathURL!.path
//                
//                multipartFormData.append(URL(fileURLWithPath: pathString), withName: "file")
//                
//                multipartFormData.append(Data(voiceUploadStr!.description.utf8), withName: "info")
//                
//                
//                
//                print("parameters.description.utf8",voiceUploadStr!.description.utf8)
//                
//                
//            },to: vimeoVideoEndpointTutor).responseJSON{
//                //
//                res in
//                
//                
//                KRProgressHUD.dismiss()
//                
//                
//                print("vimeoVideoEndpointTutor",vimeoVideoEndpointTutor)
//                
//                
//                let json_str = String(data: res.data!, encoding: .utf8)
//                
//                print("json \(json_str!)")
//                
//                
//                
//                do {
//                    if let json = try JSONSerialization.jsonObject(with: res.data!, options: []) as? [String: Any] {
//                        if let status = json["Status"] as? Int {
//                            print("Status: \(status)")
//                            
//                            if status == 1 {
//                                
//                                
//                                let a = json["Message"]
//                                
//                                
//                                let refreshAlert = UIAlertController(title: "", message: a as! String, preferredStyle: UIAlertController.Style.alert)
//                                
//                                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in
//                                    
//                                    
//                                    if priority == "p2" || priority == "p3" {
//                                        
//                                        let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
//                                        vc.is_read_enabled = is_read_enabled
//                                        vc.is_write_enabled = is_write_enabled
//                                        vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
//                                        
//                                        vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
//                                        vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
//                                        vc.strName = self.strName
//                                        vc.str = self.str
//                                        
//                                        vc.modalPresentationStyle = .fullScreen
//                                        self.present(vc, animated: true , completion: nil)
//                                        
//                                    }
//                                    
//                                    else  if priority == "p7" {
//                                        
//                                        let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
//                                        vc.is_read_enabled = is_read_enabled
//                                        vc.is_write_enabled = is_write_enabled
//                                        vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
//                                        
//                                        vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
//                                        vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
//                                        vc.strName = self.strName
//                                        vc.str = self.str
//                                        
//                                        vc.modalPresentationStyle = .fullScreen
//                                        self.present(vc, animated: true , completion: nil)
//                                        
//                                    }
//                                    
//                                    else{
//                                        
//                                        let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
//                                        vc.is_read_enabled = is_read_enabled
//                                        vc.is_write_enabled = is_write_enabled
//                                        vc.view.backgroundColor = UIColor(named: "Principal" )
//                                        
//                                        vc.CommuniSegementName.backgroundColor = UIColor(named: "UnSelector")
//                                        vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "Selector")
//                                        
//                                        vc.strName = self.strName
//                                        vc.str = self.str
//                                        vc.modalPresentationStyle = .fullScreen
//                                        self.present(vc, animated: true , completion: nil)
//                                        
//                                    }
//                                    
//                                    
//                                    
//                                    
//                                }))
//                                
//                                
//                                
//                                self.present(refreshAlert, animated: true, completion: nil)
//                                
//                                
//                            }
//                            else {
//                                
//                                
//                                
//                                let a = json["Message"]
//                                
//                                let refreshAlert = UIAlertController(title: "", message: a as! String, preferredStyle: UIAlertController.Style.alert)
//                                
//                                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in
//                                    
//                                    
//                                    if priority == "p2" || priority == "p3" {
//                                        
//                                        let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
//                                        vc.is_read_enabled = is_read_enabled
//                                        vc.is_write_enabled = is_write_enabled
//                                        vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
//                                        
//                                        vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
//                                        vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
//                                        vc.strName = self.strName
//                                        vc.str = self.str
//                                        
//                                        vc.modalPresentationStyle = .fullScreen
//                                        self.present(vc, animated: true , completion: nil)
//                                        
//                                    }
//                                    
//                                    else  if priority == "p7" {
//                                        
//                                        let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
//                                        vc.is_read_enabled = is_read_enabled
//                                        vc.is_write_enabled = is_write_enabled
//                                        vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
//                                        
//                                        vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
//                                        vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
//                                        vc.strName = self.strName
//                                        vc.str = self.str
//                                        
//                                        vc.modalPresentationStyle = .fullScreen
//                                        self.present(vc, animated: true , completion: nil)
//                                        
//                                    }
//                                    else{
//                                        
//                                        let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
//                                        vc.is_read_enabled = is_read_enabled
//                                        vc.is_write_enabled = is_write_enabled
//                                        vc.view.backgroundColor = UIColor(named: "Principal" )
//                                        
//                                        vc.CommuniSegementName.backgroundColor = UIColor(named: "UnSelector")
//                                        vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "Selector")
//                                        
//                                        vc.strName = self.strName
//                                        vc.str = self.str
//                                        vc.modalPresentationStyle = .fullScreen
//                                        self.present(vc, animated: true , completion: nil)
//                                        
//                                    }
//                                    
//                                    
//                                    
//                                    
//                                }))
//                                
//                                
//                                
//                                self.present(refreshAlert, animated: true, completion: nil)
//                                
//                                
//                                
//                                
//                                
//                                
//                                
//                            }
//                            
//                        }
//                    }
//                } catch {
//                    print("Error parsing JSON: \(error)")
//                }
//                
//                
//                
//            }
//            
//            
//            
//            
//        }
        
        
        
        
        
        
        
        
    }
    
    
    func SendVideoToParticular() {
        
        var uploadvideo = ParticularVideoUploadModal()
        
        uploadvideo.isparent = parentChkBox.isChecked
        uploadvideo.callertype = priority
        uploadvideo.url = videoURL
        uploadvideo.collegeid = clgId
        uploadvideo.description = discreptionss
        uploadvideo.iframe = videoIframe
        uploadvideo.subjectid = sectionAndSubject
        uploadvideo.isstaff = false
        uploadvideo.isstudent = studentChkBox.isChecked
        uploadvideo.staffid = memberId
        uploadvideo.title = titlesTextField
        uploadvideo.receiverid = nameString
        uploadvideo.receivertype = resiverType
        
        print("yearAndSectionModalStr", uploadvideo)
        
        
        if dropItemsName == "Subject" {
            
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
                                
                            } else if self.priority == "p7" {
                                
                                let vc = SenderVideoHomePageViewController()
                                vc.is_read_enabled = self.is_read_enabled
                                vc.is_write_enabled = self.is_write_enabled
                                vc.view.backgroundColor = UIColor(named: "univercityColorCod")
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
                                
                            } else if self.priority == "p7" {
                                
                                let vc = SenderVideoHomePageViewController()
                                vc.is_read_enabled = self.is_read_enabled
                                vc.is_write_enabled = self.is_write_enabled
                                vc.view.backgroundColor = UIColor(named: "univercityColorCod")
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
            
        } else {
            
            APiCallManager.shared.callApi(
                url: APIEndpoints.SendVideoToParticularTypeFromTutor,
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
                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default))
                        
                        self.present(refreshAlert, animated: true)
                        
                        self.tv.dataSource = self
                        self.tv.delegate = self
                        self.tv.reloadData()
                        
                    } else {
                        
                        let refreshAlert = UIAlertController(title: "", message: particular.Message, preferredStyle: .alert)
                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default))
                        
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
    }
    
    func SendSmsToParticular() {
        
        
        KRProgressHUD.show()
        
        var particular = SendSmsToParticularModal()
        
        particular.collegeid = clgId
        
        particular.staffid = memberId
        
        particular.description = discreptionss
        
        particular.callertype = priority
        
        particular.receivertype = resiverType
        
        particular.isparent = parentChkBox.isChecked
        particular.subjectid = sectionAndSubject
        particular.isstaff = false
        particular.isstudent = studentChkBox.isChecked
        particular.receiverid = nameString
        
        particular.messagecontent = titlesTextField
        
        particular.filetype = "1"
        
//        let particularStr = particular.toJSONString()
//        
//        print("yearAndSectionModalStr14",particularStr)
        
        
        if dropItemsName == "Subject"{
            
            APiCallManager.shared.callApi(
                    url: APIEndpoints.SendSMSToParticularType,
                    httpMethod: .post,
                    queryParam: nil,
                    requestBody: particular
                ) {[weak self] (result:Result<senderParticularResponce, Error>) in
                        
                    guard let self = self else { return }
                    
                    switch result {
                    case .success(let success):
                        if success.Status == 1 {
                            KRProgressHUD.dismiss()
                            particularSms  = success.data ?? []
                            
                            let refreshAlert = UIAlertController(title: "", message:  success.Message, preferredStyle: UIAlertController.Style.alert)
                            
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
                                    
                                }else if self?.priority == "p7" {
                                    
                                    let vc = CommuniSMSViewController(nibName: nil, bundle: nil)
                                    vc.is_read_enabled = self?.is_read_enabled ?? ""
                                    vc.is_write_enabled = self?.is_write_enabled ?? ""
                                    vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
                                    
                                    vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
                                    vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                                    
                                    vc.str = self?.str ?? []
                                    vc.strName = self?.strName ?? []
                                    vc.modalPresentationStyle = .fullScreen
                                    self?.present(vc, animated: true , completion: nil)
                                    
                                }else{
                                    
                                    let vc = CommuniSMSViewController(nibName: nil, bundle: nil)
                                    vc.is_read_enabled = self?.is_read_enabled ?? ""
                                    vc.is_write_enabled = self?.is_write_enabled ?? ""
                                    vc.view.backgroundColor = UIColor(named: "Principal" )
                                    
                                    vc.CommuniSegementName.backgroundColor = UIColor(named: "UnSelector")
                                    vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "Selector")
                                    
                                    vc.str = self?.str ?? []
                                    vc.strName = self?.strName ?? []
                                    vc.modalPresentationStyle = .fullScreen
                                    self?.present(vc, animated: true , completion: nil)
                                    
                                }
                            }))
                            
                            self.present(refreshAlert, animated: true, completion: nil)
                            
                            tv.dataSource = self
                            tv.delegate = self
                            tv.reloadData()
                            
                        }else{
                            
                            KRProgressHUD.dismiss()
                            
                            
                            let refreshAlert = UIAlertController(title: "", message:  success.Message, preferredStyle: UIAlertController.Style.alert)
                            
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
                                else if self?.priority == "p7" {
                                    
                                    let vc = CommuniSMSViewController(nibName: nil, bundle: nil)
                                    vc.is_read_enabled = self?.is_read_enabled ?? ""
                                    vc.is_write_enabled = self?.is_write_enabled ?? ""
                                    vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
                                    
                                    vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
                                    vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                                    
                                    vc.str = self?.str ?? []
                                    vc.strName = self?.strName ?? []
                                    vc.modalPresentationStyle = .fullScreen
                                    self?.present(vc, animated: true , completion: nil)
                                    
                                }
                                else{
                                    
                                    let vc = CommuniSMSViewController(nibName: nil, bundle: nil)
                                    vc.is_read_enabled = self?.is_read_enabled ?? ""
                                    vc.is_write_enabled = self?.is_write_enabled ?? ""
                                    vc.view.backgroundColor = UIColor(named: "Principal" )
                                    
                                    vc.CommuniSegementName.backgroundColor = UIColor(named: "UnSelector")
                                    vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "Selector")
                                    
                                    vc.str = self?.str ?? []
                                    vc.strName = self?.strName ?? []
                                    vc.modalPresentationStyle = .fullScreen
                                    self?.present(vc, animated: true , completion: nil)
                                    
                                }
                            }))
                            
                            self.present(refreshAlert, animated: true, completion: nil)
                            
                            tv.dataSource = self
                            tv.delegate = self
                            tv.reloadData()
                        }
                    case .failure(let failure):
                         print("Error:",failure.localizedDescription)
                    }
                    
                    }
            
        }else{
            
            
            APiCallManager.shared.callApi(
                    url: APIEndpoints.SendSMSToParticularTypeFromTutor,
                    httpMethod: .post,
                    queryParam: nil,
                    requestBody: particular
                ) {[weak self] (result:Result<senderParticularResponce, Error>) in
                        
                    guard let self = self else { return }
                    
                    switch result {
                    case .success(let particular):
                        
                        if particular.Status == 1 {
                            
                            KRProgressHUD.dismiss()
                            particularSms  = particular.data ?? []
                            
                            let refreshAlert = UIAlertController(title: "", message:  particular.Message, preferredStyle: UIAlertController.Style.alert)
                            
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
                                    
                                }else if self?.priority == "p7" {
                                    
                                    let vc = CommuniSMSViewController(nibName: nil, bundle: nil)
                                    vc.is_read_enabled = self?.is_read_enabled ?? ""
                                    vc.is_write_enabled = self?.is_write_enabled ?? ""
                                    vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
                                    
                                    vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
                                    vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                                    
                                    vc.str = self?.str ?? []
                                    vc.strName = self?.strName ?? []
                                    vc.modalPresentationStyle = .fullScreen
                                    self?.present(vc, animated: true , completion: nil)
                                    
                                }else{
                                    
                                    let vc = CommuniSMSViewController(nibName: nil, bundle: nil)
                                    vc.is_read_enabled = self?.is_read_enabled ?? ""
                                    vc.is_write_enabled = self?.is_write_enabled ?? ""
                                    vc.view.backgroundColor = UIColor(named: "Principal" )
                                    
                                    vc.CommuniSegementName.backgroundColor = UIColor(named: "UnSelector")
                                    vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "Selector")
                                    
                                    vc.str = self?.str ?? []
                                    vc.strName = self?.strName ?? []
                                    vc.modalPresentationStyle = .fullScreen
                                    self?.present(vc, animated: true , completion: nil)
                                    
                                }
                            }))
                            
                            self.present(refreshAlert, animated: true, completion: nil)
                            
                            tv.dataSource = self
                            tv.delegate = self
                            tv.reloadData()
                            
                        }else{
                            
                            KRProgressHUD.dismiss()
                            
                            let refreshAlert = UIAlertController(title: "", message:  particular.Message, preferredStyle: UIAlertController.Style.alert)
                            
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
                                    
                                }else if self?.priority == "p7" {
                                    
                                    let vc = CommuniSMSViewController(nibName: nil, bundle: nil)
                                    vc.is_read_enabled = self?.is_read_enabled ?? ""
                                    vc.is_write_enabled = self?.is_write_enabled ?? ""
                                    vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
                                    
                                    vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
                                    vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                                    
                                    vc.str = self?.str ?? []
                                    vc.strName = self?.strName ?? []
                                    vc.modalPresentationStyle = .fullScreen
                                    self?.present(vc, animated: true , completion: nil)
                                    
                                }else{
                                    
                                    let vc = CommuniSMSViewController(nibName: nil, bundle: nil)
                                    vc.is_read_enabled = self?.is_read_enabled ?? ""
                                    vc.is_write_enabled = self?.is_write_enabled ?? ""
                                    vc.view.backgroundColor = UIColor(named: "Principal" )
                                    
                                    vc.CommuniSegementName.backgroundColor = UIColor(named: "UnSelector")
                                    vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "Selector")
                                    
                                    vc.str = self?.str ?? []
                                    vc.strName = self?.strName ?? []
                                    vc.modalPresentationStyle = .fullScreen
                                    self?.present(vc, animated: true , completion: nil)
                                    
                                }
                            }))
                            
                            self.present(refreshAlert, animated: true, completion: nil)
                            
                            
                            tv.dataSource = self
                            tv.delegate = self
                            tv.reloadData()
                        }
                        
                    case .failure(let failure):
                         print("Error:",failure.localizedDescription)
                    }
                    
                    }
        }
    }
    
    
    func NoticeSendSmsToParticular(ImageFile: [String]) {
        
        KRProgressHUD.show()
        
        var imageAryy: [FiletypeDataDetails] = []
        
        for i in ImageFile {
            var imageAws = FiletypeDataDetails()
            imageAws.filepath = i
            imageAws.filetype = imageFileType
            imageAryy.append(imageAws)
        }
        
        var particularNotice = NoticeBoardPartiModal()
        
        particularNotice.noticeboardid = "0"
        particularNotice.description = discreptionss
        particularNotice.subjectid = sectionAndSubject
        particularNotice.receivertype = resiverType
        particularNotice.isstaff = true
        
        if is_parent_target_enabled == "0" {
            particularNotice.isparent = false
        } else {
            particularNotice.isparent = parentChkBox.isChecked
        }
        
        particularNotice.isstudent = studentChkBox.isChecked
        particularNotice.processtype = "add"
        particularNotice.receiveridlist = nameString
        particularNotice.topic = titlesTextField
        particularNotice.colgid = clgId
        particularNotice.staffid = memberId
        particularNotice.callertype = priority
        particularNotice.files = imageAryy
        
        print("particularNoticeparticularNoticeparticularNotice", particularNotice)
        
        
        if dropItemsName == "Subject" {
            
            APiCallManager.shared.callApi(
                url: APIEndpoints.ManageNoticeBoard,
                httpMethod: .post,
                queryParam: nil,
                requestBody: particularNotice
            ) { [weak self] (result: Result<NoticePArticularResponce, Error>) in
                
                guard let self = self else { return }
                
                switch result {
                    
                case .success(let particularss):
                        
                        self.particularSmss = particularss
                        
                        if particularss.Status == 1 {
                            
                            KRProgressHUD.dismiss()
                            
                            let refreshAlert = UIAlertController(title: "", message: particularss.Message, preferredStyle: .alert)
                            
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
                                    
                                } else if self.priority == "p7" {
                                    
                                    let vc = SenderGraditNoticeBoardMenuViewController()
                                    vc.is_read_enabled = self.is_read_enabled
                                    vc.is_write_enabled = self.is_write_enabled
                                    vc.view.backgroundColor = UIColor(named: "univercityColorCod")
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
                            
                            self.tv.dataSource = self
                            self.tv.delegate = self
                            self.tv.reloadData()
                            
                        } else {
                            
                            KRProgressHUD.dismiss()
                            
                            let refreshAlert = UIAlertController(title: "", message: particularss.Message, preferredStyle: .alert)
                            
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
                                    
                                } else if self.priority == "p7" {
                                    
                                    let vc = SenderGraditNoticeBoardMenuViewController()
                                    vc.is_read_enabled = self.is_read_enabled
                                    vc.is_write_enabled = self.is_write_enabled
                                    vc.view.backgroundColor = UIColor(named: "univercityColorCod")
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
                            
                            self.tv.dataSource = self
                            self.tv.delegate = self
                            self.tv.reloadData()
                        }
                    
                case .failure(let error):
                    KRProgressHUD.dismiss()
                    print("API Error:", error.localizedDescription)
                }
            }
            
        } else {
            
            APiCallManager.shared.callApi(
                url: APIEndpoints.ManageNoticeBoardFromTutor ,
                httpMethod: .post,
                queryParam: nil,
                requestBody: particularNotice
            ) { [weak self] (result: Result<NoticePArticularResponce, Error>) in
                
                guard let self = self else { return }
                
                switch result {
                    
                case .success(let particularss):
                        
                        self.particularSmss = particularss
                        
                        if particularss.Status == 1 {
                            
                            KRProgressHUD.dismiss()
                            
                            let refreshAlert = UIAlertController(title: "", message: particularss.Message, preferredStyle: .alert)
                            
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
                                    
                                } else if self.priority == "p7" {
                                    
                                    let vc = SenderGraditNoticeBoardMenuViewController()
                                    vc.is_read_enabled = self.is_read_enabled
                                    vc.is_write_enabled = self.is_write_enabled
                                    vc.view.backgroundColor = UIColor(named: "univercityColorCod")
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
                            
                            self.tv.dataSource = self
                            self.tv.delegate = self
                            self.tv.reloadData()
                            
                        } else {
                            
                            KRProgressHUD.dismiss()
                            
                            let refreshAlert = UIAlertController(title: "", message: particularss.Message, preferredStyle: .alert)
                            
                            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default))
                            
                            self.present(refreshAlert, animated: true)
                            
                            self.tv.dataSource = self
                            self.tv.delegate = self
                            self.tv.reloadData()
                        }
                    
                    
                case .failure(let error):
                    KRProgressHUD.dismiss()
                    print("API Error:", error.localizedDescription)
                }
            }
        }
    }
    
    func EventParticular() {
        
        KRProgressHUD.show()
        
        var particular = EventParticualrModal()
        
        particular.eventid = "0"
        particular.eventbody = discreptionss
        particular.eventdate = DateLabels
        particular.eventvenue = venumtextField
        particular.eventtime = EventTime
        particular.eventtopic = titlesTextField
        
        particular.processtype = "add"
        particular.collegeid = clgId
        particular.staffid = memberId
        particular.Callertype = priority
        particular.subjectid = sectionAndSubject
        particular.receivertype = resiverType
        
        if is_parent_target_enabled == "0" {
            particular.isparent = false
        } else {
            particular.isparent = parentChkBox.isChecked
        }
        
        particular.isstaff = false
        particular.isstudent = studentChkBox.isChecked
        particular.receiveridlist = nameString
        
        print("yearAndSectionModalStr", particular)
        
        
        if dropItemsName == "Subject" {
            
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
                            KRProgressHUD.dismiss()
                            
                            let refreshAlert = UIAlertController(title: "", message: response.Message, preferredStyle: .alert)
                            
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
                                    
                                } else if self.priority == "p7" {
                                    
                                    let vc = SenderEventHomePageViewController()
                                    vc.is_read_enabled = self.is_read_enabled
                                    vc.is_write_enabled = self.is_write_enabled
                                    vc.view.backgroundColor = UIColor(named: "univercityColorCod")
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
                            
                        } else {
                            
                            KRProgressHUD.dismiss()
                            
                            let refreshAlert = UIAlertController(title: "", message: response.Message, preferredStyle: .alert)
                            
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
                                    
                                } else if self.priority == "p7" {
                                    
                                    let vc = SenderEventHomePageViewController()
                                    vc.is_read_enabled = self.is_read_enabled
                                    vc.is_write_enabled = self.is_write_enabled
                                    vc.view.backgroundColor = UIColor(named: "univercityColorCod")
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
                    KRProgressHUD.dismiss()
                    print(error.localizedDescription)
                }
            }
            
        } else {
            
            APiCallManager.shared.callApi(
                url: APIEndpoints.ManageEventsFromTutor,
                httpMethod: .post,
                queryParam: nil,
                requestBody: particular
            ) { [weak self] (result: Result<EventParticularResponce, Error>) in
                
                guard let self = self else { return }
                
                switch result {
                    
                case .success(let response):
                        
                        if response.Status == 1 {
                            KRProgressHUD.dismiss()
                            
                            let refreshAlert = UIAlertController(title: "", message: response.Message, preferredStyle: .alert)
                            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default))
                            
                            self.present(refreshAlert, animated: true)
                            
                            self.tv.dataSource = self
                            self.tv.delegate = self
                            self.tv.reloadData()
                            
                        } else {
                            
                            KRProgressHUD.dismiss()
                            
                            let refreshAlert = UIAlertController(title: "", message: response.Message, preferredStyle: .alert)
                            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default))
                            
                            self.present(refreshAlert, animated: true)
                            
                            self.tv.dataSource = self
                            self.tv.delegate = self
                            self.tv.reloadData()
                        }
                    
                case .failure(let error):
                    KRProgressHUD.dismiss()
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func AssigmentText(){
        
        if resivre == "6"{
            
            var assigmet : [FileNameArray] = []
            
            for i in awsArry{
                var imagePdfFileArry = FileNameArray()
                imagePdfFileArry.FileName = i
                assigmet.append(imagePdfFileArry)
            }
            
            var imagePdf = assigmentImagePdfModal()
            
            imagePdf.collegeid = clgId
            imagePdf.sectionid = nameString
            imagePdf.processtype = "add"
            imagePdf.staffid = memberId
            imagePdf.assignmentdescription = discreptionss
            imagePdf.assignmentid = "0"
            imagePdf.assignmenttopic = titlesTextField
            imagePdf.assignmenttype = AssigmentFileType
            imagePdf.callertype = priority
            imagePdf.courseid = AssigemtcourseId
            imagePdf.receiverid = nameString
            imagePdf.receivertype = "1"
            imagePdf.deptid = deptid
            imagePdf.subjectid = AssigemtSubjectId
            imagePdf.yearid = AssigemtyearIdsSpefy
            imagePdf.submissiondate = assigmentDate
            imagePdf.fileNameArray = assigmet
            
            print("imagePdfStrs", imagePdf)
            
            
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
                            
                            _ = SweetAlert().showAlert("", subTitle: particularss.Message, style: .none, buttonTitle: "Ok", buttonColor: .gray) { [self] okclick in
                                
                                if okclick {
                                    
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
                                        
                                    } else if self.priority == "p7" {
                                        
                                        let vc = SenderAssigmentHomePageViewController()
                                        vc.is_read_enabled = self.is_read_enabled
                                        vc.is_write_enabled = self.is_write_enabled
                                        vc.view.backgroundColor = UIColor(named: "univercityColorCod")
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
                                }
                            }
                            
                            tv.dataSource = self
                            tv.delegate = self
                            tv.reloadData()
                            
                        } else {
                            
                            _ = SweetAlert().showAlert("", subTitle: particularss.Message, style: .none, buttonTitle: "Ok", buttonColor: .gray) { [self] okclick in
                                
                                if okclick {
                                    
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
                                        
                                    } else if self.priority == "p7" {
                                        
                                        let vc = SenderAssigmentHomePageViewController()
                                        vc.is_read_enabled = self.is_read_enabled
                                        vc.is_write_enabled = self.is_write_enabled
                                        vc.view.backgroundColor = UIColor(named: "univercityColorCod")
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
                                }
                            }
                            
                            tv.dataSource = self
                            tv.delegate = self
                            tv.reloadData()
                        }
                    
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        }
        
        else{
            
            var assigmet : [FileNameArray] = []
            
            for i in awsArry{
                var imagePdfFileArry = FileNameArray()
                imagePdfFileArry.FileName = i
                assigmet.append(imagePdfFileArry)
            }
            
            var imagePdf = assigmentImagePdfModal()
            
            imagePdf.collegeid = clgId
            imagePdf.sectionid = nameString
            imagePdf.processtype = "add"
            imagePdf.staffid = memberId
            imagePdf.assignmentid = assigmentHeaderId
            imagePdf.assignmentdescription = discreptionss
            imagePdf.assignmenttopic = titlesTextField
            imagePdf.assignmenttype = AssigmentFileType
            imagePdf.callertype = priority
            imagePdf.courseid = AssigemtcourseId
            imagePdf.receiverid = nameString
            imagePdf.receivertype = "1"
            imagePdf.deptid = deptid
            imagePdf.subjectid = AssigemtSubjectId
            imagePdf.yearid = AssigemtyearIdsSpefy
            imagePdf.submissiondate = assigmentDate
            imagePdf.fileNameArray = assigmet
            
            print("imagePdfStrs", imagePdf)
            
            
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
                        
                        let refreshAlert = UIAlertController(title: "", message: particularss.Message, preferredStyle: .alert)
                        
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
                                
                            } else if self.priority == "p7" {
                                
                                let vc = SenderAssigmentHomePageViewController()
                                vc.is_read_enabled = self.is_read_enabled
                                vc.is_write_enabled = self.is_write_enabled
                                vc.view.backgroundColor = UIColor(named: "univercityColorCod")
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
    }
    
    
    
    func assigmentImagePdf(imageArry : [String]){
        
        if resivre == "6"{
            
            var assigmet : [FileNameArray] = []
            
            for i in imageArry{
                var imagePdfFileArry = FileNameArray()
                imagePdfFileArry.FileName = i
                assigmet.append(imagePdfFileArry)
            }
            
            var imagePdf = assigmentImagePdfModal()
            
            imagePdf.collegeid = clgId
            imagePdf.sectionid = nameString
            imagePdf.processtype = "add"
            imagePdf.staffid = memberId
            imagePdf.assignmentdescription = discreptionss
            imagePdf.assignmentid = "0"
            imagePdf.assignmenttopic = titlesTextField
            imagePdf.assignmenttype = AssigmentFileType
            imagePdf.callertype = priority
            imagePdf.courseid = AssigemtcourseId
            imagePdf.receiverid = nameString
            imagePdf.receivertype = "1"
            imagePdf.deptid = deptid
            imagePdf.subjectid = AssigemtSubjectId
            imagePdf.yearid = AssigemtyearIdsSpefy
            imagePdf.submissiondate = assigmentDate
            imagePdf.fileNameArray = assigmet
            
            print("imagePdfStrs", imagePdf)
            
            
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
                            
                            _ = SweetAlert().showAlert("", subTitle: particularss.Message, style: .none, buttonTitle: "Ok", buttonColor: .gray) { [self] okclick in
                                
                                if okclick {
                                    
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
                                        
                                    } else if self.priority == "p7" {
                                        
                                        let vc = SenderAssigmentHomePageViewController()
                                        vc.is_read_enabled = self.is_read_enabled
                                        vc.is_write_enabled = self.is_write_enabled
                                        vc.view.backgroundColor = UIColor(named: "univercityColorCod")
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
                                }
                            }
                            
                            tv.dataSource = self
                            tv.delegate = self
                            tv.reloadData()
                            
                        } else {
                            
                            _ = SweetAlert().showAlert("", subTitle: particularss.Message, style: .none, buttonTitle: "Ok", buttonColor: .gray) { [self] okclick in
                                
                                if okclick {
                                    
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
                                        
                                    } else if self.priority == "p7" {
                                        
                                        let vc = SenderAssigmentHomePageViewController()
                                        vc.is_read_enabled = self.is_read_enabled
                                        vc.is_write_enabled = self.is_write_enabled
                                        vc.view.backgroundColor = UIColor(named: "univercityColorCod")
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
                                }
                            }
                            
                            tv.dataSource = self
                            tv.delegate = self
                            tv.reloadData()
                        }
                    
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        }
        
        else{
            
            var assigmet : [FileNameArray] = []
            
            for i in awsArry{
                var imagePdfFileArry = FileNameArray()
                imagePdfFileArry.FileName = i
                assigmet.append(imagePdfFileArry)
            }
            
            var imagePdf = assigmentImagePdfModal()
            
            imagePdf.collegeid = clgId
            imagePdf.sectionid = nameString
            imagePdf.processtype = "add"
            imagePdf.staffid = memberId
            imagePdf.assignmentid = assigmentHeaderId
            imagePdf.assignmentdescription = discreptionss
            imagePdf.assignmenttopic = titlesTextField
            imagePdf.assignmenttype = AssigmentFileType
            imagePdf.callertype = priority
            imagePdf.courseid = AssigemtcourseId
            imagePdf.receiverid = nameString
            imagePdf.receivertype = "1"
            imagePdf.deptid = deptid
            imagePdf.subjectid = AssigemtSubjectId
            imagePdf.yearid = AssigemtyearIdsSpefy
            imagePdf.submissiondate = assigmentDate
            imagePdf.fileNameArray = assigmet
            
            print("imagePdfStrs", imagePdf)
            
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
                        
                        let refreshAlert = UIAlertController(title: "", message: particularss.Message, preferredStyle: .alert)
                        
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
                                
                            } else if self.priority == "p7" {
                                
                                let vc = SenderAssigmentHomePageViewController()
                                vc.is_read_enabled = self.is_read_enabled
                                vc.is_write_enabled = self.is_write_enabled
                                vc.view.backgroundColor = UIColor(named: "univercityColorCod")
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
    }
    
    func ImagePdfParticular(ImageFile : [String]){
        
        var imageAryy : [FileNameImages] = []
        
        for i in ImageFile{
            var imageAws = FileNameImages()
            imageAws.FileName = i
            imageAryy.append(imageAws)
        }
        
        var sendImagePdfEntier = ImagePdfPartResponce()
        
        sendImagePdfEntier.title = titlesTextField
        sendImagePdfEntier.receiverid = nameString
        sendImagePdfEntier.receivertype = resiverType
        sendImagePdfEntier.callertype = priority
        sendImagePdfEntier.collegeid = clgId
        sendImagePdfEntier.Description = discreptionss
        sendImagePdfEntier.Staffid = memberId
        sendImagePdfEntier.fileduration = "0"
        sendImagePdfEntier.filetype = imageFileType
        sendImagePdfEntier.subjectid = sectionAndSubject
        
        if is_parent_target_enabled == "0"{
            sendImagePdfEntier.isparent = false
        }
        else{
            sendImagePdfEntier.isparent = parentChkBox.isChecked
        }
        
        sendImagePdfEntier.isstudent = studentChkBox.isChecked
        sendImagePdfEntier.isstaff = false
        
        sendImagePdfEntier.FileNameArray = imageAryy
        
        print("yearAndSectionModalStr", sendImagePdfEntier)
        
        if dropItemsName == "Subject"{
            
            APiCallManager.shared.callApi(
                url: APIEndpoints.SendImageOrPDFToParticularTypeWithCloudURL,
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
                            
                        }
                        else if self.priority == "p7"{
                            
                            let vc = SenderImagePdfHomePageViewController()
                            vc.is_read_enabled = self.is_read_enabled
                            vc.is_write_enabled = self.is_write_enabled
                            vc.view.backgroundColor = UIColor(named: "univercityColorCod")
                            vc.imageSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                            vc.imageSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                            vc.str = self.str
                            vc.strName = self.strName
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true)
                            
                        }
                        else{
                            
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
                    self.tv.reloadData()
                    
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        }
        
        else {
            
            APiCallManager.shared.callApi(
                url: APIEndpoints.SendImageOrPDFToParticularTypeWithCloudURLFromTutor,
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
                            
                        }
                        else if self.priority == "p7"{
                            
                            let vc = SenderImagePdfHomePageViewController()
                            vc.is_read_enabled = self.is_read_enabled
                            vc.is_write_enabled = self.is_write_enabled
                            vc.view.backgroundColor = UIColor(named: "univercityColorCod")
                            vc.imageSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                            vc.imageSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                            vc.str = self.str
                            vc.strName = self.strName
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true)
                            
                        }
                        else{
                            
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
                    self.tv.reloadData()
                    
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
    
    @IBAction func cancelVc(){
        
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
            bucketPath: memberId,
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
            bucketPath: memberId,
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
                    
                    
                    
                    if  resivre == "5"{
                        
                        ImagePdfParticular(ImageFile: awsArry)
                        
                        
                    }
                    
                    else if resivre == "6"      ||   resivre == "6" {
                        
                        
                        assigmentImagePdf(imageArry : awsArry)
                        
                        
                        
                    }
                    
                    else if resivre == "1"{
                        
                        NoticeSendSmsToParticular(ImageFile: awsArry)
                        
                    }
                             
                   
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
//        KRProgressHUD.show()
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
//                
//                KRProgressHUD.dismiss()
//            }
//            
//            if task.result != nil {
//                
//                let url = AWSS3.default().configuration.endpoint.url
//                let publicURL = url?.appendingPathComponent((uploadRequest?.bucket!)!).appendingPathComponent((uploadRequest?.key!)!)
//                if  let absoluteString = publicURL?.absoluteString {
//                    print("Uploaded to:\(absoluteString)")
//                    
//                    
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
//                KRProgressHUD.dismiss()
//                print("Unexpected empty result.")
//            }
//            return nil
//        }
//    }
//    
//    
//    
//    func uploadPDFFileToAWS(pdfData : Data){
//        //        self.showLoading()
//        
//        
//        KRProgressHUD.show()
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
//                KRProgressHUD.dismiss()
//            }
//            
//            if task.result != nil {
//                let url = AWSS3.default().configuration.endpoint.url
//                let publicURL = url?.appendingPathComponent((uploadRequest?.bucket!)!).appendingPathComponent((uploadRequest?.key!)!)
//                if let absoluteString = publicURL?.absoluteString {
//                    print("Uploaded to:\(absoluteString)")
//                    
//                    awsArry.append(absoluteString)
//                    let imageDict = NSMutableDictionary()
//                    imageDict["FileName"] = absoluteString
//                    self.imageUrlArray.add(imageDict)
//                    self.convertedImagesUrlArray = self.imageUrlArray
//                    
//                    
//                    
//                    if  resivre == "5"{
//                        
//                        ImagePdfParticular(ImageFile: awsArry)
//                        
//                        
//                    }
//                    
//                    else if resivre == "6"      ||   resivre == "6" {
//                        
//                        
//                        assigmentImagePdf(imageArry : awsArry)
//                        
//                        
//                        
//                    }
//                    
//                    else if resivre == "1"{
//                        
//                        NoticeSendSmsToParticular(ImageFile: awsArry)
//                        
//                    }
//                    
//                    
//                }
//            }
//            else {
//                //
//                
//                KRProgressHUD.dismiss()
//                print("Unexpected empty result.")
//            }
//            return nil
//        }
//    }
//    
    
    
}

class CheckBoxGest : UITapGestureRecognizer {
    
    var pos : Int!
    
    var memberName : String!
    
    var checkBoxss : CheckBoxTwo!
    
    var deparMentId : String!
    var courseId : String!
    var yearID : String!
    
    var subjectIDs : String!
    
}



class CheckBoxGestTutor : UITapGestureRecognizer {
    
    var pos : Int!
    
    var memberName : String!
    
    var checkBoxss : CheckBoxTwo!
    
    var courseId : String!
    var yearID : String!
    var deparMentId : String!
    
    
}




class SpecifyCell : UITapGestureRecognizer {
    
    var pos : Int!
    
    var sectionId : String!
    
    var DepartMentId : String!
    var yearID : String!
    var courseId : String!
    var subjectId : String!
    
}
