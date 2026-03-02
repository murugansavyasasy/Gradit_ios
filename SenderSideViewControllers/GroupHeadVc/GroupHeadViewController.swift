//
//  GroupHeadViewController.swift
//  Vs_GradItCollege
//
//  Created by admin on 27/11/23.
//

import UIKit
import ObjectMapper
import KRProgressHUD
import Alamofire
import iOSDropDown
import AWSCore
import AWSS3
@available(iOS 16.0, *)
class GroupHeadViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UISearchBarDelegate {
    
    @IBOutlet weak var defaultSendVoiceEmer: UILabel!
    @IBOutlet weak var replySwitch: UISwitch!
    @IBOutlet weak var staffDefaultLbl: UILabel!
    @IBOutlet weak var studentLeadingCon: NSLayoutConstraint!
    @IBOutlet weak var alldefaultLbl: UILabel!
    @IBOutlet weak var sendView: UIViewX!
    @IBOutlet weak var ViewConstains: NSLayoutConstraint!
    @IBOutlet weak var searchOverllAllView: UIView!
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var staffLeadingCon: NSLayoutConstraint!
    
    @IBOutlet weak var courseViewLeadingCon: NSLayoutConstraint!
    @IBOutlet weak var AllViewTopCon: NSLayoutConstraint!
    @IBOutlet weak var topIdentificationLabel: UILabel!
    @IBOutlet weak var entierClgLbl: UILabel!
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var departmentLabel: UILabel!
    @IBOutlet weak var devisionTabel: UILabel!
    @IBOutlet weak var entireClgView: UIViewX!
    @IBOutlet weak var groupView: UIViewX!
    @IBOutlet weak var devisionView: UIViewX!
    @IBOutlet weak var departmentDropDownText: DropDown!
    @IBOutlet weak var devisionDropDownText: DropDown!
    @IBOutlet weak var collegeDropDownText: DropDown!
    @IBOutlet weak var parentDefaultLbl: UILabel!
    @IBOutlet weak var allCheckbox: CheckBoxTwo!
    @IBOutlet weak var staffCheckBoxView: CheckBoxTwo!
    @IBOutlet weak var parentCheckBoxView: CheckBoxTwo!
    @IBOutlet weak var studentAllCheckBox: CheckBoxTwo!
    @IBOutlet weak var targetAllCheckBoxView: CheckBoxTwo!
  
    @IBOutlet weak var cancelView: UIViewX!
    @IBOutlet weak var topAllView: UIView!
    @IBOutlet weak var yourClassesView: UIViewX!
    @IBOutlet weak var courseView: UIViewX!
    @IBOutlet weak var departmentView: UIViewX!
   
    @IBOutlet weak var couseDropView: UIViewX!
    @IBOutlet weak var tv: UITableView!
    
   
    @IBOutlet weak var yourClassLabel: UILabel!
    @IBOutlet weak var devisionDropVieww: UIViewX!
    @IBOutlet weak var collegedropView: UIViewX!
    
    @IBOutlet weak var stafLeadingCon: NSLayoutConstraint!
    @IBOutlet weak var allBtn: UIButton!
    @IBOutlet weak var viewTop: NSLayoutConstraint!
    var clgListDataList : [clgListDataDetails] = []
    var devisionRefName : [getDivisonDataDetails] = []
    var deparmentRefName : [RepienceDeparmentDataDetails] = []
    var entierRefName : [EntiercollegeDataDetails] = []
    var groupRefName : [getGroupDataDetails] = []
    var courseRefName : [getCourseDataDetails] = []
    var courseRefName1 : [getCourseDataDetails] = []
    var particularSms : [NoticePArticularResponce] = []
  
    var titlesTextField : String!
    var discreptionss : String!
    var eventParticulae : [EventParticularResponce] = []
    var imagePdfEniter : [sendImagePdfDataDetails] = []
    
    var ImagePdfFleName :  [FileNameImage] = []
    var videoUploadEntier : [EntierVideoUploadDataDetails] = []
    var voiceUploadss : [VoiceEntierDataDetails] = []
    
    
    
    var particularSmsComunication : [SmsdataDetails] = []
    var sentEntierImagePdf : [sendImagePdfDataDetails] = []
    var assigmentImagPdf : [assigmentImagePdfResponce] = []
    
    var sendVideoPart : [ParticularVideoUploadRespData] = []
    var imagePdfEniterParticular : [sendImagePdfPartiDataDetails] = []
    
   
    var priority : String!
    var collegeId : Int!
    var  memberId  : String!
    var parentTargetEnagbel : String!
    var identifier  = "SelectRespienceCellTableViewCell"
  
    
    var DateLabels : String!
    
    
    var clgId : String!
    
    
    
    var resiverType = "5"
    
    
    var resivre : String!
    var nameString : String!
    var dropItemsName : String!
    
    
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
    
    var fileType : String!
    
    var  AssigmentnameString = ""
    
    //
    var AssigmentSelectedIDString =  ""
    var   AssigemtcourseId = ""
    var  AssigemtyearIdsSpefy = ""
    var  AssigemtsectionID = ""
    var AssigemtSubjectId = ""
    var assigemtDeparmentId = ""
    
    var is_read_enabled = ""
    var is_write_enabled = ""
    var strs : [String] = []
 
    var courseTypeId : String!
    var ClgListClgId : String!
    var clgIdArry: [String] = []
    var clgIdForClgList = ""
    var IDforStaffCheck = ""
    var VenuTestField : String!
    var checkboxcount : [String] = []
    var refId : String!
    var devisionDropDownList : [String] = []
    var couseDropDownList : [String] = []
    var deparmentRefNam1 : [RepienceDeparmentDataDetails] = []
    var departMentRefrenceId : String!
    var collegeRefID : String!
    var clgListDataLis1 : [clgListDataDetails] = []
    var clone_listDepartment : [RepienceDeparmentDataDetails] = []
    var filtered_listDepartment : [RepienceDeparmentDataDetails] = []
    var filtered_listDepartment1 : [RepienceDeparmentDataDetails] = []
    var clone_listDepartment1 : [RepienceDeparmentDataDetails] = []
    var filtered_listCourse : [getCourseDataDetails] = []
    var clone_listCourse : [getCourseDataDetails] = []
    var filtered_listCourse1 : [getCourseDataDetails] = []
    var clone_listCourse1 : [getCourseDataDetails] = []
    var AlertMessage : String!
    var isFilter : Bool = false
    
    var VoiceHstryId : String!
    var voiceHstryHeaderId : String!
    var CallEnabel : Int!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        parentDefaultLbl.isHidden = true
        parentCheckBoxView.isHidden = true
        devisionDropVieww.isHidden = true
        couseDropView.isHidden = true
        searchbar.delegate = self
        collegedropView.isHidden = true
        AllViewTopCon.constant = -125
        courseViewLeadingCon.constant = -125
        yourClassesView.isHidden = true
        searchOverllAllView.isHidden = true
        targetAllCheckBoxView.isHidden = true
        alldefaultLbl.isHidden = true
        studentLeadingCon.constant = -40
        print("is_read_enabledis_read_enabled",is_read_enabled)
        print("is_write_enabledis_write_enabled",is_write_enabled)
        let defaults = UserDefaults.standard
        
        memberId = defaults.string(forKey: DefaultsKeys.memberid)
        
        collegeId = defaults.integer(forKey: DefaultsKeys.collegeid)
        priority = defaults.string(forKey: DefaultsKeys.priority)
        parentTargetEnagbel = defaults.string(forKey: DefaultsKeys.is_parent_target_enabled)
        CallEnabel = defaults.integer(forKey: DefaultsKeys.is_allow_to_make_call)
        print("tyylyly",CallEnabel)
        
        
        
        if CallEnabel == 1 && VoiceHstryId == "2"{
            
            defaultSendVoiceEmer.isHidden = false
            replySwitch.isHidden = false
        }
        
        else{
            
            defaultSendVoiceEmer.isHidden = true
            replySwitch.isHidden = true
           
        }
        
        
        if parentTargetEnagbel == "0"{
            
            parentDefaultLbl.isHidden = true
            parentCheckBoxView.isHidden = true
            staffLeadingCon.constant = -80
            
        }
        else{
            
            parentDefaultLbl.isHidden = false
            parentCheckBoxView.isHidden = false
            
            
        }
        EntierclgViewVc()
     let Allbox = UITapGestureRecognizer(target: self, action: #selector(allCheckboxvc))
        targetAllCheckBoxView.addGestureRecognizer(Allbox)
        
        
        
        let send = UITapGestureRecognizer(target: self, action: #selector(SendVc))
        sendView.addGestureRecognizer(send)
        
        let devision = UITapGestureRecognizer(target: self, action: #selector(devisionVc))
        
        
        devisionView.addGestureRecognizer(devision)
        
        
        
        
        
        let department = UITapGestureRecognizer(target: self, action: #selector(departmentVc))
        
        
        departmentView.addGestureRecognizer(department)
        
        
        let cancels = UITapGestureRecognizer(target: self, action: #selector(CancelVc))
        
        
        cancelView.addGestureRecognizer(cancels)
        
        
         
        let entierclgview = UITapGestureRecognizer(target: self, action: #selector(EntierclgViewVc))
        
        
        entireClgView.addGestureRecognizer(entierclgview)
        
        let course = UITapGestureRecognizer(target: self, action: #selector(course))
        
        
        courseView.addGestureRecognizer(course)
        
        
        
        
        let groups = UITapGestureRecognizer(target: self, action: #selector(groupVC))
        
        
        groupView.addGestureRecognizer(groups)
        
        
        let parentCheck = UITapGestureRecognizer(target: self, action: #selector(parentCheckVc))
        
        
        parentCheckBoxView.addGestureRecognizer(parentCheck)
        
        let studentCheck = UITapGestureRecognizer(target: self, action: #selector(studentCheckVc))
        
        
        studentAllCheckBox.addGestureRecognizer(studentCheck)
        
        let staff = UITapGestureRecognizer(target: self, action: #selector(StaffCheckVc))
        
        
        staffCheckBoxView.addGestureRecognizer(staff)
        
        replySwitch.addTarget(self, action: #selector(switchIsChanged), for: UIControl.Event.valueChanged)
        
       
        let rownib = UINib(nibName: identifier, bundle: nil)
        tv.register(rownib, forCellReuseIdentifier: identifier)
//
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
   
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        
       
        
      if departmentView.backgroundColor == UIColor(named: "selectColor"){
            
            if departMentRefrenceId == "2" {
                
                filtered_listDepartment1  = Mapper<RepienceDeparmentDataDetails>().mapArray(JSONString: clone_listDepartment1.toJSONString()!)!
                
                
                
                
                
                
                if !searchText.isEmpty{
//
                    deparmentRefNam1 = filtered_listDepartment1.filter {
                        
                        
                        
                        $0.department_code.lowercased().contains(searchText.lowercased()) || $0.department_name.lowercased().contains(searchText.lowercased()) ||
                        $0.department_id.lowercased().contains(searchText.lowercased())
                        //
                    }
                    
                    
                    
                }else{
                    
//
                    deparmentRefNam1 = filtered_listDepartment1
                    
                    print("pendingOrder")
                    
                }
                
                
                
                if deparmentRefNam1.count > 0{
                    
                    print ("searchListPendigCount",deparmentRefNam1.count)
                    
                    topAllView.isHidden = false
                    
                    tv.alpha = 1
                    
                }else{
                    
                    topAllView.isHidden = true
                    tv.alpha = 0
                    
                }
                
                
                
                tv.reloadData()
                
                
                
            }
            else{
                filtered_listDepartment  = Mapper<RepienceDeparmentDataDetails>().mapArray(JSONString: clone_listDepartment.toJSONString()!)!
                
                
                
                
                
                
                if !searchText.isEmpty{
                                    isFilter = true
                    deparmentRefName = filtered_listDepartment.filter {
                        
                        
                        
                        $0.department_code.lowercased().contains(searchText.lowercased()) || $0.department_name.lowercased().contains(searchText.lowercased()) ||
                        $0.department_id.lowercased().contains(searchText.lowercased())
                        //
                    }
                    
                    
                    
                }else{
                    
                                    isFilter = false
                    deparmentRefName = filtered_listDepartment
                    
                    print("pendingOrder")
                    
                }
                
                
                
                if deparmentRefName.count > 0{
                    
                    print ("searchListPendigCount",deparmentRefName.count)
                    
                    
                    topAllView.isHidden = false
                    tv.alpha = 1
                    
                }else{
                    
                    topAllView.isHidden = true
                    tv.alpha = 0
                    
                }
                
                
                
                tv.reloadData()
                
                
            }
           
            
        }
        
        else if groupView.backgroundColor == UIColor(named: "selectColor"){
            

            
            
        }
        
        else if courseView.backgroundColor == UIColor(named: "selectColor"){
            
            if departMentRefrenceId == "2"{
                
                filtered_listCourse1  = Mapper<getCourseDataDetails>().mapArray(JSONString: clone_listCourse1.toJSONString()!)!
                
                
                
                
                
                
                if !searchText.isEmpty{
                    isFilter = true
                    courseRefName1 = filtered_listCourse1.filter {
                        
                        
                        
                        $0.course_name.lowercased().contains(searchText.lowercased()) || $0.course_id.lowercased().contains(searchText.lowercased()) ||
                        $0.course_code.lowercased().contains(searchText.lowercased())
                        //
                    }
                    
                    
                    
                }else{
                    
                    isFilter = false
                    courseRefName1 = filtered_listCourse1
                    
                    print("pendingOrder")
                    
                }
                
                
                
                if courseRefName1.count > 0{
                    
                    print ("searchListPendigCount",courseRefName1.count)
                    
                    topAllView.isHidden = false
                    
                    tv.alpha = 1
                    
                }else{
                    
                    topAllView.isHidden = true
                    tv.alpha = 0
                    
                }
                
                
                
                tv.reloadData()
                
                
                
                
            
                
                
            }
            
            else{
                
                filtered_listCourse  = Mapper<getCourseDataDetails>().mapArray(JSONString: clone_listCourse.toJSONString()!)!
                
                
                
                
                
                
                if !searchText.isEmpty{
                    isFilter = true
                    courseRefName = filtered_listCourse.filter {
                        
                        
                        
                        $0.course_name.lowercased().contains(searchText.lowercased()) || $0.course_id.lowercased().contains(searchText.lowercased()) ||
                        $0.course_code.lowercased().contains(searchText.lowercased())
                        //
                    }
                    
                    
                    
                }else{
                    
                    isFilter = false
                    courseRefName = filtered_listCourse
                    
                    print("pendingOrder")
                    
                }
                
                
                
                if courseRefName.count > 0{
                    
                    print ("searchListPendigCount",courseRefName.count)
                    
                    topAllView.isHidden = false
                    
                    tv.alpha = 1
                    
                }else{
                    
                    topAllView.isHidden = true
                    tv.alpha = 0
                    
                }
                
                
                
                tv.reloadData()
                
                
                
                
            }
            
        }
            
          
     
        
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        print("scrollViewWillBeginDragging")
        searchbar.endEditing(true)
        
    }
    
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchBarSearchButtonClicked")
        searchbar.resignFirstResponder()
        
    }
    
    
    
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        

     if departmentView.backgroundColor == UIColor(named: "selectColor"){
            
            if departMentRefrenceId == "2" {
                dropDowVC()
                
                print("searchBarCancelButtonClicked22222")
            }
            
            else{
                
                searchBar.resignFirstResponder()
                print("searchBarCancelButtonClicked22222")
                
                //            print("TutorTutor",studentRef.count)
                
                tv.alpha = 1
                
                DepartVc()
                
                self.tv.reloadData()
                
            }
        }
        
        else if courseView.backgroundColor == UIColor(named: "selectColor"){
            
            if departMentRefrenceId == "2" {
                dropDowVC()
                
                print("searchBarCancelButtonClicked22222")
            }
            
            else{
                
                searchBar.resignFirstResponder()
                print("searchBarCancelButtonClicked22222")
                
                //            print("TutorTutor",studentRef.count)
                
                tv.alpha = 1
                
                CoursedropApi()
                
                self.tv.reloadData()
                
            }
        }
        
        
        else if groupView.backgroundColor == UIColor(named: "selectColor"){
            
            
        }
        
    }
    
  

    
    
    @IBAction func CancelVc() {
        
        dismiss(animated: true)
        
    }
    @IBAction func EntierclgViewVc() {
        
        AlertMessage = "Selected college count :"
        staffCheckBoxView.isHidden = false
        staffDefaultLbl.isHidden = false
        collegedropView.isHidden = true
        devisionDropVieww.isHidden = true
        couseDropView.isHidden = true
        collegeRefID = "1"
        AllViewTopCon.constant = -170
        searchOverllAllView.isHidden = true
        if(DefaultsKeys.resiverId.count>0){
            DefaultsKeys.resiverId.removeAll()
        }
        
        
        
       
            
            
            if entireClgView.isUserInteractionEnabled == true {
                
//
                entireClgView.backgroundColor = UIColor(named: "selectColor")
                
                entierClgLbl.textColor = UIColor.white
   
                devisionTabel.textColor = UIColor.white
                departmentLabel.textColor = UIColor(named: "clickView")
                courseLabel.textColor = UIColor(named: "clickView")
                yourClassLabel.textColor = UIColor(named: "clickView")
                groupLabel.textColor = UIColor(named: "clickView")
                devisionTabel.textColor = UIColor(named: "clickView")
                departmentView.backgroundColor = UIColor.white
                courseView.backgroundColor = UIColor.white
                yourClassesView.backgroundColor = UIColor.white
                groupView.backgroundColor = UIColor.white
                devisionView.backgroundColor = UIColor.white
                departmentView.isUserInteractionEnabled = true
                
                CollegeVc()
            }else {
                
                entireClgView.isUserInteractionEnabled = false
                
                
                print("clickedOff")
                
            }
       
        
    }
    @IBAction func devisionVc() {
        
        staffCheckBoxView.isHidden = false
        staffDefaultLbl.isHidden = false
        AlertMessage = "Selected division count :"
        AllViewTopCon.constant = -90
        collegedropView.isHidden = false
        tv.isHidden = true
        topAllView.isHidden = true
        searchOverllAllView.isHidden = true

        collegeDropDownText.text = "---Select College---"
        if(DefaultsKeys.resiverId.count>0){
            DefaultsKeys.resiverId.removeAll()
        }
        
        
       
            
            if devisionView.isUserInteractionEnabled == true {
              
                
//                dropDownView.isHidden = true
//                courseDropDownView.isHidden = true
//                tv.isHidden = false
//                tvTop.isHidden = false
//                
                devisionView.backgroundColor = UIColor(named: "selectColor")
                devisionTabel.textColor = UIColor.white
                
                
                departmentLabel.textColor = UIColor(named: "clickView")
                courseLabel.textColor = UIColor(named: "clickView")
                yourClassLabel.textColor = UIColor(named: "clickView")
                groupLabel.textColor = UIColor(named: "clickView")
                entierClgLbl.textColor = UIColor(named: "clickView")
                departmentView.backgroundColor = UIColor.white
                courseView.backgroundColor = UIColor.white
                yourClassesView.backgroundColor = UIColor.white
                groupView.backgroundColor = UIColor.white
                entireClgView.backgroundColor = UIColor.white
                
//                devision()
                
                entierVc()
                
                
                
                
                
            }else {
                
                devisionView.isUserInteractionEnabled = false
                
                print("clickedOff")
                
            }
            
            
            
       
    }
    
    
    
    
    @IBAction func departmentVc (){
        refId = "0"
        
        staffCheckBoxView.isHidden = false
        staffDefaultLbl.isHidden = false
        
        searchOverllAllView.isHidden = false
        AlertMessage = "Selected department count :"
        AllViewTopCon.constant = -50
        collegedropView.isHidden = false
       tv.isHidden = true
        topAllView.isHidden = true
        
        
        collegeDropDownText.text = "--- Selecte College ---"
       
        devisionDropDownText.text =  "--- Select Devision ---"

        devisionDropDownText.checkMarkEnabled = false
        collegeDropDownText.checkMarkEnabled = false
        if(DefaultsKeys.resiverId.count>0){
            DefaultsKeys.resiverId.removeAll()
        }
        
        
       
            
            
            if departmentView.isUserInteractionEnabled == true{
               
               
                departmentView.backgroundColor = UIColor(named: "selectColor")
                courseLabel.textColor = UIColor(named: "clickView")
                devisionTabel.textColor = UIColor(named: "clickView")
                yourClassLabel.textColor = UIColor(named: "clickView")
                groupLabel.textColor = UIColor(named: "clickView")
                entierClgLbl.textColor = UIColor(named: "clickView")
                devisionView.backgroundColor = UIColor.white
                courseView.backgroundColor = UIColor.white
                departmentLabel.textColor = UIColor.white
                yourClassesView.backgroundColor = UIColor.white
                groupView.backgroundColor = UIColor.white
                entireClgView.backgroundColor = UIColor.white
                
               entierVc()
            }else {
                
                departmentView.isUserInteractionEnabled = false
                
                
                print("clickedOff")
                
            }
            
            
       
    

    }
 
    @IBAction func course(){
        
        refId = "1"
        AlertMessage = "Selected course count :"
        collegeDropDownText.text = "--- Selecte College ---"
        departmentDropDownText.text =  "--- Select Depatrment ---"
        devisionDropDownText.text =  "--- Select Division ---"
        AllViewTopCon.constant = 5
        collegedropView.isHidden = false
        tv.isHidden = true
        topAllView.isHidden = true
        searchOverllAllView.isHidden = false
        
        staffCheckBoxView.isHidden = true
        staffDefaultLbl.isHidden = true
        
        if(DefaultsKeys.resiverId.count>0){
            DefaultsKeys.resiverId.removeAll()
        }
        
           
            
            if courseView.isUserInteractionEnabled == true {
                //
              
                tv.isHidden = true
                courseView.backgroundColor = UIColor(named: "selectColor")
                courseLabel.textColor = UIColor.white
                departmentLabel.textColor = UIColor(named: "clickView")
                devisionTabel.textColor = UIColor(named: "clickView")
                yourClassLabel.textColor = UIColor(named: "clickView")
                courseLabel.textColor = UIColor.white
                groupLabel.textColor = UIColor(named: "clickView")
                entierClgLbl.textColor = UIColor(named: "clickView")
                devisionView.backgroundColor = UIColor.white
                departmentView.backgroundColor = UIColor.white
                yourClassesView.backgroundColor = UIColor.white
                groupView.backgroundColor = UIColor.white
                entireClgView.backgroundColor = UIColor.white
                
           
                
                entierVc()
                
            }else {
                
                courseView.isUserInteractionEnabled = false
                
                
                
            }
            
        
        
        
        
        
        
    }
    
    
    
    @IBAction func groupVC() {
        
        AlertMessage = "Selected group count :"
        staffCheckBoxView.isHidden = true
        staffDefaultLbl.isHidden = true
       allBtn.setImage(UIImage.init(named: "checkboxs"), for: .normal)
        allBtn.isSelected = false
        collegedropView.isHidden = false
        tv.isHidden = true
        topAllView.isHidden = true
        devisionDropVieww.isHidden = true
        couseDropView.isHidden = true
        collegeDropDownText.text = "--- Selecte College ---"
        searchOverllAllView.isHidden = true
        if(DefaultsKeys.resiverId.count>0){
            DefaultsKeys.resiverId.removeAll()
        }
        
        if   groupView.isUserInteractionEnabled == true {
            

            groupView.backgroundColor = UIColor(named: "selectColor")
            
            departmentLabel.textColor = UIColor(named: "clickView")
            courseLabel.textColor = UIColor(named: "clickView")
            devisionTabel.textColor = UIColor(named: "clickView")
            yourClassLabel.textColor = UIColor(named: "clickView")
            entierClgLbl.textColor = UIColor(named: "clickView")
            
            
            
            
            entireClgView.backgroundColor = UIColor.white
            yourClassesView.backgroundColor = UIColor.white
            courseView.backgroundColor = UIColor.white
            groupLabel.textColor = UIColor.white
            
            devisionView.backgroundColor = UIColor.white
            departmentView.backgroundColor = UIColor.white
            
            
            print("group")
            
            entierVc()
           
            
        }else {
            
            groupView.isUserInteractionEnabled = false
            
            
            print("clickedOff")
            
        }
        
        
        
        
    }
    
    
    
    func CoursedropApi(){
        
        let course =  getCourseModal()
        
        course.user_id = memberId
        course.college_id = clgIdForClgList
        course.dept_id = "0"
        
        let coursestr = course.toJSONString()
        GetCourseRequest.call_request(param: coursestr!){ [self]
            
            (res) in
           
            let cour : getCourseResponce  = Mapper<getCourseResponce>().map(JSONString: res)!
            
            devisionDropDownList.removeAll()
            clone_listCourse.removeAll()
            if cour.Status == 1 {
                courseRefName = cour.data
                for i in cour.data{
                    
                    
                    devisionDropDownList.append(i.division_name)
                    
                    clone_listCourse.append(i)
                    
                    
                }
                
                
                var newArray: [String] = []
                newArray = ["--All Division--"]
                for element in devisionDropDownList {
                    // Check if the element is not already in the new array
                    if !newArray.contains(element) {
                        // Add the unique element to the new array
                        newArray.append(element)
                    }
                }
                
                devisionDropDownText.optionArray = newArray
                
                dropDowVC()
                tv.isHidden = false
                topAllView.isHidden = false
                tv.delegate = self
                tv.dataSource = self
                tv.reloadData()
            }
            
            else{
                
                
                
            }
        }
        
    }
    @IBAction func CoursedropDowVC(){
        
      couseDropView.isHidden = false
        
        DefaultsKeys.resiverId.removeAll()
        let deparment = DepartmentModal()
        
        deparment.user_id = memberId
        
        deparment.college_id = clgIdForClgList
        
        deparment.div_id =  "0"
        
        
        
        let deparmentstr = deparment.toJSONString()
        print("deparmentstr",deparmentstr)
        RepienceDeparmentRequest.call_request(param: deparmentstr!){ [self]
            
            (res) in
            
            let depart : RepienceDeparmentResponce  = Mapper<RepienceDeparmentResponce>().map(JSONString: res)!
            
            deparmentRefName = depart.data
            
            
            var addAryy: [String] = [ ]
            var itemAryy: [String] = [ ]
            
            
            depart.data .forEach {(arrType)  in
                addAryy.append((arrType.department_name))
                
            }
            
            departmentDropDownText.optionArray = addAryy
           
            departmentDropDownText.isSearchEnable = true
           
            var idArray : [String] = []
            deparmentRefName.forEach {(arrType)  in
                idArray.append((arrType.department_id))
                
            }
            
           
            departmentDropDownText.didSelect{ [self](selectedText , index ,id) in
                
               
                
                self.departmentDropDownText.text = selectedText
              
                allBtn.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                allBtn.isSelected = false
                
                if(DefaultsKeys.resiverId.count>0){
                    DefaultsKeys.resiverId.removeAll()
                }
                
                let course =  getCourseModal()
                
                course.user_id = memberId
                course.college_id = clgIdForClgList
                course.dept_id = idArray[index]
                
                print("fhfytghfg",idArray[index])
                
                
                let coursestr = course.toJSONString()
                GetCourseRequest.call_request(param: coursestr!){ [self]
                    
                    (res) in
                   
                    let cour : getCourseResponce  = Mapper<getCourseResponce>().map(JSONString: res)!
                    
                    if cour.Status == 1 {
                        courseRefName = cour.data
                        tv.isHidden = false
                        topAllView.isHidden = false
                        tv.delegate = self
                        tv.dataSource = self
                        tv.reloadData()
                    }
                    
                    else{
                        
                        
                        
                    }
                }
                
                
            }
       
        }
        
    }
    
    
    func DepartVc(){
        
        let deparment = DepartmentModal()
        
        deparment.user_id = memberId
        
        deparment.college_id = clgIdForClgList
        deparment.div_id =  "0"
        
        let deparmentstr = deparment.toJSONString()
        print("deparmentstr",deparmentstr)
        RepienceDeparmentRequest.call_request(param: deparmentstr!){ [self]
            
            (res) in
            
            
            
            let depart : RepienceDeparmentResponce  = Mapper<RepienceDeparmentResponce>().map(JSONString: res)!
            
            if depart.Status == 1{
                deparmentRefName = depart.data
                clone_listDepartment = depart.data
                
                tv.isHidden = false
                
                if refId == "1"{
                    
                    topAllView.isHidden = true
                }else{
                    topAllView.isHidden = false
                }
                
              
                for i in depart.data{
                    
                    
                    devisionDropDownList.append(i.division_name)
                    
                    
                    
                    
                }
                
                
                var newArray: [String] = []
                newArray = ["--All Division--"]
                for element in devisionDropDownList {
                    // Check if the element is not already in the new array
                    if !newArray.contains(element) {
                        // Add the unique element to the new array
                        newArray.append(element)
                    }
                }
                
                devisionDropDownText.optionArray = newArray
                
                dropDowVC()
                allBtn.isHidden = false
                tv.dataSource = self
                tv.delegate = self
                tv.reloadData()
            }
            
            
            else{
                
                
                tv.dataSource = self
                tv.delegate = self
                tv.reloadData()
                
                
            }
        }
        
        
        
    }
    
    
    
    @IBAction func dropDowVC(){
        
        allBtn.setImage(UIImage.init(named: "checkboxs"), for: .normal)
        allBtn.isSelected = false
        
        if departmentView.backgroundColor == UIColor(named: "selectColor"){
            
            devisionDropDownText.placeholder =  "--- Select Division ---"
            collegeDropDownText.placeholder = "--- Select College ---"
           

//               
                devisionDropDownText.isSearchEnable = true
//
                devisionDropDownText.didSelect{ [self](selectedText , index ,id) in
                    
                    deparmentRefNam1.removeAll()
                    clone_listDepartment1.removeAll()
                    for i in  deparmentRefName{
                        
                        
                        
                        if index == 0{
                            allBtn.isSelected = false
                            allBtn.isHidden = false
                            topAllView.isHidden = false
                            departMentRefrenceId = "1"
                            tv.isHidden = false
                          
                            
                                                       tv.dataSource = self
                                                       tv.delegate = self
                                                       tv.reloadData()
                        }
                        
                        
                        else{
                        if selectedText == i.division_name{
                            
                            departMentRefrenceId = "2"
                            deparmentRefNam1.append(i)
                            clone_listDepartment1.append(i)
                            
                        }
                            tv.isHidden = false
                            topAllView.isHidden = true
                            allBtn.isSelected = true
                                                       tv.dataSource = self
                                                       tv.delegate = self
                                                       tv.reloadData()
                    }
                        
                        
                    }
                    
                    
                    self.devisionDropDownText.text = selectedText
                    
                   
                    
                    
                }

            
        }
        
        
//        
        else if courseView.backgroundColor == UIColor(named: "selectColor"){
                   
            devisionDropDownText.didSelect{ [self](selectedText , index ,id) in
                
                courseRefName1.removeAll()
                couseDropDownList.removeAll()
//                clone_listDepartment1.removeAll()
                for i in  courseRefName{
                    
                    
                    
                    if index == 0{
                        
                        departMentRefrenceId = "1"
                        
                        
                        tv.isHidden = false
                      topAllView.isHidden = false
                        allBtn.isHidden = false
                           
                                                   
                    }
                    
                    
                    else{
                    if selectedText == i.division_name{
                        
                        departMentRefrenceId = "2"
                        courseRefName1.append(i)
                        couseDropDownList.append(i.department_name)
                        clone_listCourse1.append(i)
                        
                        tv.isHidden = false
                        topAllView.isHidden = true
                        allBtn.isHidden = true
                                                   tv.dataSource = self
                                                   tv.delegate = self
                                                   tv.reloadData()
                        
                    }
                    
                }
                    
                    
                }
                
              
                self.devisionDropDownText.text = selectedText
                
                
                var newArray: [String] = []
                newArray = ["--All Department--"]
                for element in couseDropDownList {
                    // Check if the element is not already in the new array
                    if !newArray.contains(element) {
                        // Add the unique element to the new array
                        newArray.append(element)
                    }
                }
                
                departmentDropDownText.optionArray = newArray
                
               
               
                
                courseDropVc()
            }
            
        }

        
    }
    
    
    
    func courseDropVc(){
        
        couseDropView.isHidden = false
        

       
        departmentDropDownText.isSearchEnable = true
       
       
        departmentDropDownText.didSelect{ [self](selectedText , index ,id) in
            
            courseRefName1.removeAll()
           
            for i in courseRefName{
                
                
                
                
                
                if index == 0{
                    
                    departMentRefrenceId = "1"
                    topAllView.isHidden = false
                    allBtn.isHidden = false
                       
                                
                }
                
                
                else{
                if selectedText == i.department_name{
                    
                    departMentRefrenceId = "2"
                    courseRefName1.append(i)
                    
//                        clone_listDepartment1.append(i)
                    
                            
                   
                    topAllView.isHidden = true
                    
                    allBtn.isHidden = true
                    tv.dataSource = self
                    tv.delegate = self
                    tv.reloadData()

                    
                }
                
            }
                
            }
            
            
            
        }
        
    }
    
    
    func devision(){
        
       
 
        let devisions = getDivisionModal()
        
        devisions.college_id = clgIdForClgList
        devisions.user_id =  memberId
        
        let devisionstr = devisions.toJSONString()
        
        print("devisionstrdevisionstr",devisionstr)
        DivisionRequest.call_request(param: devisionstr!){ [self]
            
            (res) in
            
            
            
            let devisin : GetDivisionResponce  = Mapper<GetDivisionResponce>().map(JSONString: res)!
           
           
            
            if devisin.Status == 1 {
                
                
                devisionRefName = devisin.data
                for i in devisin.data{
                    
                    
                    strs.append(i.division_name)
                    //
                    
                    
                    
                }
                
               
                tv.isHidden = false
                topAllView.isHidden = false
               
                tv.isHidden  = false
               
                tv.delegate = self
                tv.dataSource = self
                tv.reloadData()
            }
            
            

        }
        
        
    }
    
    
    
    
    
    
    func Group(){
        
        allBtn.setImage(UIImage.init(named: "checkboxs"), for: .normal)
        allBtn.isSelected = false
        
        
        let groups = GetGroupModal()
        
        groups.idcollege = clgIdForClgList
        let groupstr = groups.toJSONString()
        GetGroupRequest.call_request(param: groupstr!){ [self]
            
            (res) in
            
            
            
            print("groupstr",groupstr)
            let groupe : GetGroupResponce  = Mapper<GetGroupResponce>().map(JSONString: res)!
            
            
            
            if groupe.Status == 1 {
                groupRefName = groupe.data
                topAllView.isHidden = false
                AllViewTopCon.constant = -90
              tv.isHidden = false
                tv.delegate = self
                tv.dataSource = self
                tv.reloadData()
            }
            
            
            else {
                
                
                tv.isHidden = true
                tv.delegate = self
                tv.dataSource = self
                tv.reloadData()
                
            }
            
            
            
            
            
        }
        
        
    }
    
    
    
    
    @IBAction func allCheckboxvc(){
        
        
        
        
        
        
        if parentTargetEnagbel == "0"{
            
            

            if targetAllCheckBoxView.isChecked == true{
                
                
               
                
                
                targetAllCheckBoxView.isChecked = false
                targetAllCheckBoxView.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                parentCheckBoxView.isChecked = false
                staffCheckBoxView.isChecked =  false
                studentAllCheckBox.isChecked = false
                
                
                
                
                print("UNCheck")
                
                
            } else if targetAllCheckBoxView.isChecked == false  {
                
            targetAllCheckBoxView.isChecked = true
                targetAllCheckBoxView.setImage(UIImage.init(named: "done"), for: .normal)
                staffCheckBoxView.isChecked =  true
                parentCheckBoxView.isChecked = false
                studentAllCheckBox.isChecked =  true
                
                
                
                
                
            }
            
            
            
        } else{
            
            
            if targetAllCheckBoxView.isChecked == true{
               
                targetAllCheckBoxView.isChecked = false
                targetAllCheckBoxView.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                parentCheckBoxView.isChecked = false
                staffCheckBoxView.isChecked =  false
                studentAllCheckBox.isChecked = false
                
                
                print("UNCheck")
                
                
            } else if targetAllCheckBoxView.isChecked == false  {
                
                
                targetAllCheckBoxView.isChecked = true
                targetAllCheckBoxView.setImage(UIImage.init(named: "done"), for: .normal)
                staffCheckBoxView.isChecked =  true
                parentCheckBoxView.isChecked = true
                studentAllCheckBox.isChecked =  true
                
            }
            
            
        }
        
        
        
        
    }
    
    
    @IBAction func studentCheckVc(){
        
        
        
       
        
        
     
            
            if studentAllCheckBox.isChecked == true{
                
                studentAllCheckBox.isChecked = false
                studentAllCheckBox.setImage(UIImage.init(named: "checkboxs"), for: .normal)
               
              
                print("UNCheck")
                
                if parentTargetEnagbel == "0"{
                    if   studentAllCheckBox.isChecked == true || staffCheckBoxView.isChecked == true{
                        
                        targetAllCheckBoxView.isChecked = false
                        
                    }
                }else{
                    
                    
                    if   studentAllCheckBox.isChecked == true  || parentCheckBoxView.isChecked == true || staffCheckBoxView.isChecked == true{
                        
                        targetAllCheckBoxView.isChecked = false
                        
                    }
                    
                }
                
            } else if targetAllCheckBoxView.isChecked == false  {
                
                studentAllCheckBox.isChecked = true
                studentAllCheckBox.setImage(UIImage.init(named: "done"), for: .normal)
                
                if parentTargetEnagbel == "0"{
                    if   studentAllCheckBox.isChecked == true  && staffCheckBoxView.isChecked == true{
                        
                        targetAllCheckBoxView.isChecked = true
                        
                    }
                }else{
                    
                    
                    if   studentAllCheckBox.isChecked == true  && parentCheckBoxView.isChecked == true && staffCheckBoxView.isChecked == true{
                        
                        targetAllCheckBoxView.isChecked = true
                        
                    }
                    
                }
               
            }
            
            
            
       
        
        
    }
    
    
    @IBAction func parentCheckVc(){
        
        
        
        
        
            
            if parentCheckBoxView.isChecked == true{
                
                parentCheckBoxView.isChecked = false
                parentCheckBoxView.setImage(UIImage.init(named: "checkboxs"), for: .normal)
               
                
                
                if parentTargetEnagbel == "0"{
                    if   studentAllCheckBox.isChecked == true || staffCheckBoxView.isChecked == true{
                        
                        targetAllCheckBoxView.isChecked = false
                        
                    }
                }else{
                    
                    
                    if   studentAllCheckBox.isChecked == true  || parentCheckBoxView.isChecked == true || staffCheckBoxView.isChecked == true{
                        
                        targetAllCheckBoxView.isChecked = false
                        
                    }
                    
                }
                
            } else if parentCheckBoxView.isChecked == false  {
                
                parentCheckBoxView.isChecked = true
                parentCheckBoxView.setImage(UIImage.init(named: "done"), for: .normal)
               
                if parentTargetEnagbel == "0"{
                    if   studentAllCheckBox.isChecked == true  && staffCheckBoxView.isChecked == true{
                        
                        targetAllCheckBoxView.isChecked = true
                        
                    }
                }else{
                    
                    
                    if   studentAllCheckBox.isChecked == true  && parentCheckBoxView.isChecked == true && staffCheckBoxView.isChecked == true{
                        
                        targetAllCheckBoxView.isChecked = true
                        
                    }
                    
                }
                
            }
            
            
    
        
        
    }
    
    
    @IBAction func StaffCheckVc(){
        
        
        
        
      
            
            if staffCheckBoxView.isChecked == true{
                
                staffCheckBoxView.isChecked = false
                staffCheckBoxView.setImage(UIImage.init(named: "checkboxs"), for: .normal)
             
                
                print("UNCheck")
                
                
                if parentTargetEnagbel == "0"{
                    if   studentAllCheckBox.isChecked == true || staffCheckBoxView.isChecked == true{
                        
                        targetAllCheckBoxView.isChecked = false
                        
                    }
                }else{
                    
                    
                    if   studentAllCheckBox.isChecked == true  || parentCheckBoxView.isChecked == true || staffCheckBoxView.isChecked == true{
                        
                        targetAllCheckBoxView.isChecked = false
                        
                    }
                    
                }
                
                
            } else if staffCheckBoxView.isChecked == false  {
                
                staffCheckBoxView.isChecked = true
                staffCheckBoxView.setImage(UIImage.init(named: "done"), for: .normal)
                
                
                
                if parentTargetEnagbel == "0"{
                    if   studentAllCheckBox.isChecked == true  && staffCheckBoxView.isChecked == true{
                        
                        targetAllCheckBoxView.isChecked = true
                        
                    }
                }else{
                    
                    
                    if   studentAllCheckBox.isChecked == true  && parentCheckBoxView.isChecked == true && staffCheckBoxView.isChecked == true{
                        
                        targetAllCheckBoxView.isChecked = true
                        
                    }
                    
                }
            }
            
            
       
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        
       
            
            if entireClgView.backgroundColor == UIColor(named: "selectColor"){
               
                    
                    return clgListDataList.count
               
                
            }
            
            else  if devisionView.backgroundColor == UIColor(named: "selectColor"){
                
                print("devisionRefNameerrrr")
                return devisionRefName.count
            }
            
            else if departmentView.backgroundColor == UIColor(named: "selectColor"){
                
                print("departsdfgfd")
                
                if departMentRefrenceId == "2"{
                    
                    return deparmentRefNam1.count
                }
                else{
                    
                    return deparmentRefName.count
                }
                
               
                
            }
            
            else if groupView.backgroundColor == UIColor(named: "selectColor"){
                
                return groupRefName.count
                
            }
            
            else if courseView.backgroundColor == UIColor(named: "selectColor"){
                
             
                
                if departMentRefrenceId == "2"{
                    print("thiid333333",courseRefName.count)
                    return courseRefName1.count                }
                else{
                    print("thiid444444444",courseRefName.count)
                    return courseRefName.count
                }
               
                
            }
            
       
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as!
        
        SelectRespienceCellTableViewCell
        
        
        
        
        
     
            
            if entireClgView.backgroundColor == UIColor(named: "selectColor"){
                resiverType = "9"
                
                
                
                let clg : clgListDataDetails =  clgListDataList[indexPath.row]
                
                print("cdxzcdx",strs.count)
                
                
                cell.nameLabel.text = clg.college_name
                
                
                
                if clg.isSelected == true
                {
                    
                    cell.checkboxess.isChecked = true
                    
                }else
                {
                    
                    
                    
                    cell.checkboxess.isChecked = false
                }
                let selectedGesture = ClglistChckBox(target: self, action: #selector(changeSelection))
                selectedGesture.checkBoxss = cell.checkboxess
                selectedGesture.memberidssss = String(clg.college_id)
                selectedGesture.bool = clg.isSelected
                selectedGesture.pos = indexPath.row
                cell.checkboxess.addGestureRecognizer(selectedGesture)
                
                
            }
            
            
            
            else  if devisionView.backgroundColor == UIColor(named: "selectColor"){
                
                resiverType = "8"
                
                
                
                let devi : getDivisonDataDetails = devisionRefName[indexPath.row]
                
//                print("cdxzcdx",strs.count)
                
                cell.nameLabel.text = devi.division_name
                
                
                
                if devi.isSelected == true
                {
                    
                    cell.checkboxess.isChecked = true
                    
                }else
                {
                    
                    
                    
                    cell.checkboxess.isChecked = false
                }
                let selectedGesture = ClglistChckBox(target: self, action: #selector(changeSelection))
                selectedGesture.checkBoxss = cell.checkboxess
                selectedGesture.memberidssss = devi.division_id
                selectedGesture.bool = devi.isSelected
                selectedGesture.pos = indexPath.row
                cell.checkboxess.addGestureRecognizer(selectedGesture)
                
                ClgListClgId = ""
                
                clgIdArry.removeAll()
                
            }
            
            else if departmentView.backgroundColor == UIColor(named: "selectColor"){
                
                resiverType = "3"
                
              
                
                if(isFilter){
                    
                    if filtered_listDepartment.count == DefaultsKeys.resiverId.count{
                        
                        
                        allBtn.isSelected = true
                        allBtn.setImage(UIImage.init(named: "done"), for: .normal)
                        
                    }
                    
                    
                    else{
                        
                        allBtn.isSelected = false
                        allBtn.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                        
                    }
                    
                }else{
                    
                    
                    if deparmentRefName.count == DefaultsKeys.resiverId.count{
                        
                        
                        allBtn.isSelected = true
                        allBtn.setImage(UIImage.init(named: "done"), for: .normal)
                        
                    }
                    
                    
                    else{
                        
                        allBtn.isSelected = false
                        allBtn.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                        
                    }
                }
                
                
                if DefaultsKeys.resiverId.count == 0{
                    if departMentRefrenceId == "2"{
                        
                        let depart : RepienceDeparmentDataDetails = deparmentRefNam1[indexPath.row]
                        
                        cell.nameLabel.text = depart.department_name
                        
                        cell.checkboxess.isChecked = false
                        
                        
                        
                        print("resverIdss",DefaultsKeys.resiverId)
                        
                        if depart.isSelected == true
                        {
                            
                            cell.checkboxess.isChecked = true
                            
                        }else
                        {
                            
                            
                            cell.checkboxess.isChecked = false
                        }
                        let selectedGesture = ClglistChckBox(target: self, action: #selector(changeSelection))
                        selectedGesture.checkBoxss = cell.checkboxess
                        selectedGesture.memberidssss = depart.department_id
                        selectedGesture.bool = depart.isSelected
                        selectedGesture.pos = indexPath.row
                        cell.checkboxess.addGestureRecognizer(selectedGesture)
                        
                        ClgListClgId = ""
                        clgIdArry.removeAll()
                        
                        
                        
                    }
                    else{
                        
                        let depart : RepienceDeparmentDataDetails = deparmentRefName[indexPath.row]
                        
                        cell.nameLabel.text = depart.department_name
                        
                        cell.checkboxess.isChecked = false
                        
                        
                        
                        print("resverIdss",DefaultsKeys.resiverId)
                        
                        if depart.isSelected == true
                        {
                            
                            cell.checkboxess.isChecked = true
                            
                        }else
                        {
                            
                            
                            cell.checkboxess.isChecked = false
                        }
                        let selectedGesture = ClglistChckBox(target: self, action: #selector(changeSelection))
                        selectedGesture.checkBoxss = cell.checkboxess
                        selectedGesture.memberidssss = depart.department_id
                        selectedGesture.bool = depart.isSelected
                        selectedGesture.pos = indexPath.row
                        cell.checkboxess.addGestureRecognizer(selectedGesture)
                        
                        ClgListClgId = ""
                        clgIdArry.removeAll()
                        
                    }
                    
                }
                
                
                
                else{
                    
                    
                    
                    if departMentRefrenceId == "2"{
                        
                        let depart : RepienceDeparmentDataDetails = deparmentRefNam1[indexPath.row]
                        
                        cell.nameLabel.text = depart.department_name
                        
                        cell.checkboxess.isChecked = false
                        
                        
                        
                        print("resverIdss",DefaultsKeys.resiverId)
                        
                        if depart.isSelected == true
                        {
                            
                            cell.checkboxess.isChecked = true
                            
                        }else
                        {
                            
                            
                            cell.checkboxess.isChecked = false
                        }
                        let selectedGesture = ClglistChckBox(target: self, action: #selector(changeSelection))
                        selectedGesture.checkBoxss = cell.checkboxess
                        selectedGesture.memberidssss = depart.department_id
                        selectedGesture.bool = depart.isSelected
                        selectedGesture.pos = indexPath.row
                        cell.checkboxess.addGestureRecognizer(selectedGesture)
                        
                        ClgListClgId = ""
                        clgIdArry.removeAll()
                        
                        if  DefaultsKeys.resiverId.contains(depart.department_id){
                           
                            
                            cell.checkboxess.setImage(UIImage.init(named: "done"), for: .normal)
                        }else{
                            
                            cell.checkboxess.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                        }
                        
                    }
                    else{
                        
                        let depart : RepienceDeparmentDataDetails = deparmentRefName[indexPath.row]
                        
                        cell.nameLabel.text = depart.department_name
                        
                        cell.checkboxess.isChecked = false
                        
                        
                        
                        print("resverIdss",DefaultsKeys.resiverId)
                        
                        if depart.isSelected == true
                        {
                            
                            cell.checkboxess.isChecked = true
                            
                        }else
                        {
                            
                            
                            cell.checkboxess.isChecked = false
                        }
                        let selectedGesture = ClglistChckBox(target: self, action: #selector(changeSelection))
                        selectedGesture.checkBoxss = cell.checkboxess
                        selectedGesture.memberidssss = depart.department_id
                        selectedGesture.bool = depart.isSelected
                        selectedGesture.pos = indexPath.row
                        cell.checkboxess.addGestureRecognizer(selectedGesture)
                        
                        ClgListClgId = ""
                        clgIdArry.removeAll()
                        
                        
                        if  DefaultsKeys.resiverId.contains(depart.department_id){
                           
                            
                            cell.checkboxess.setImage(UIImage.init(named: "done"), for: .normal)
                        }else{
                            
                            cell.checkboxess.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                        }
                        
                    }
                }
                
            }
            
            else if groupView.backgroundColor == UIColor(named: "selectColor"){
                
                resiverType = "6"
                
                let group : getGroupDataDetails = groupRefName[indexPath.row]
                cell.nameLabel.text = group.groupname
                cell.checkboxess.isChecked = false
                
                
                let defaults = String(group.groupid)
                
                if group.isSelected == true
                {
                    
                    cell.checkboxess.isChecked = true
                    
                }else
                {
                    
                    
                    
                    
                    cell.checkboxess.isChecked = false
                }
                let selectedGesture = ClglistChckBox(target: self, action: #selector(changeSelection))
                selectedGesture.checkBoxss = cell.checkboxess
                selectedGesture.memberidssss = defaults
                selectedGesture.bool = group.isSelected
                selectedGesture.pos = indexPath.row
                cell.checkboxess.addGestureRecognizer(selectedGesture)
                
                
                ClgListClgId = ""
                clgIdArry.removeAll()
            }
            
            
            
        else if courseView.backgroundColor == UIColor(named: "selectColor"){
            resiverType = "2"
            
            
            if(isFilter){
                
                if filtered_listCourse.count == DefaultsKeys.resiverId.count{
                    
                    
                    allBtn.isSelected = true
                    allBtn.setImage(UIImage.init(named: "done"), for: .normal)
                    
                }
                
                
                else{
                    
                    allBtn.isSelected = false
                    allBtn.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                    
                }
                
            }else{
                
                
                if courseRefName.count == DefaultsKeys.resiverId.count{
                    
                    
                    allBtn.isSelected = true
                    allBtn.setImage(UIImage.init(named: "done"), for: .normal)
                    
                }
                
                
                else{
                    
                    allBtn.isSelected = false
                    allBtn.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                    
                }
            }
            
            
            
            
            if DefaultsKeys.resiverId.count == 0{
                
                if departMentRefrenceId == "2"{
                    let coursee : getCourseDataDetails = courseRefName1[indexPath.row]
                    cell.nameLabel.text = coursee.course_name
                    cell.checkboxess.isChecked = false
                    
                    
                    if coursee.isSelected == true
                    {
                        
                        cell.checkboxess.isChecked = true
                        
                    }else
                    {
                        
                        
                        
                        cell.checkboxess.isChecked = false
                    }
                    
                    
                    
                    let selectedGesture = ClglistChckBox(target: self, action: #selector(changeSelection))
                    selectedGesture.checkBoxss = cell.checkboxess
                    selectedGesture.memberidssss = coursee.course_id
                    selectedGesture.bool = coursee.isSelected
                    selectedGesture.pos = indexPath.row
                    cell.checkboxess.addGestureRecognizer(selectedGesture)
                    
                    ClgListClgId = ""
                    clgIdArry.removeAll()
                }
                
                else{
                    let coursee : getCourseDataDetails = courseRefName[indexPath.row]
                    cell.nameLabel.text = coursee.course_name
                    cell.checkboxess.isChecked = false
                    
                    
                    if coursee.isSelected == true
                    {
                        
                        cell.checkboxess.isChecked = true
                        
                    }else
                    {
                        
                        
                        
                        cell.checkboxess.isChecked = false
                    }
                    
                    
                    
                    let selectedGesture = ClglistChckBox(target: self, action: #selector(changeSelection))
                    selectedGesture.checkBoxss = cell.checkboxess
                    selectedGesture.memberidssss = coursee.course_id
                    selectedGesture.bool = coursee.isSelected
                    selectedGesture.pos = indexPath.row
                    cell.checkboxess.addGestureRecognizer(selectedGesture)
                    
                    ClgListClgId = ""
                    clgIdArry.removeAll()
                }
            }
            
            
            
            else{
                
                
                if departMentRefrenceId == "2"{
                    let coursee : getCourseDataDetails = courseRefName1[indexPath.row]
                    cell.nameLabel.text = coursee.course_name
                    cell.checkboxess.isChecked = false
                    
                    
                    if coursee.isSelected == true
                    {
                        
                        cell.checkboxess.isChecked = true
                        
                    }else
                    {
                        
                        
                        
                        cell.checkboxess.isChecked = false
                    }
                    
                    
                    
                    let selectedGesture = ClglistChckBox(target: self, action: #selector(changeSelection))
                    selectedGesture.checkBoxss = cell.checkboxess
                    selectedGesture.memberidssss = coursee.course_id
                    selectedGesture.bool = coursee.isSelected
                    selectedGesture.pos = indexPath.row
                    cell.checkboxess.addGestureRecognizer(selectedGesture)
                    
                    ClgListClgId = ""
                    clgIdArry.removeAll()
                    
                    if  DefaultsKeys.resiverId.contains(coursee.course_id){
                       
                        
                        cell.checkboxess.setImage(UIImage.init(named: "done"), for: .normal)
                    }else{
                        
                        cell.checkboxess.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                    }
                }
                
                else{
                    let coursee : getCourseDataDetails = courseRefName[indexPath.row]
                    cell.nameLabel.text = coursee.course_name
                    cell.checkboxess.isChecked = false
                    
                    
                    if coursee.isSelected == true
                    {
                        
                        cell.checkboxess.isChecked = true
                        
                    }else
                    {
                        
                        
                        
                        cell.checkboxess.isChecked = false
                    }
                    
                    
                    
                    let selectedGesture = ClglistChckBox(target: self, action: #selector(changeSelection))
                    selectedGesture.checkBoxss = cell.checkboxess
                    selectedGesture.memberidssss = coursee.course_id
                    selectedGesture.bool = coursee.isSelected
                    selectedGesture.pos = indexPath.row
                    cell.checkboxess.addGestureRecognizer(selectedGesture)
                    
                    ClgListClgId = ""
                    clgIdArry.removeAll()
                    if  DefaultsKeys.resiverId.contains(coursee.course_id){
                       
                        
                        cell.checkboxess.setImage(UIImage.init(named: "done"), for: .normal)
                    }else{
                        
                        cell.checkboxess.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                    }
                }
                
            }
        }
      
        return cell
        
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    
    
    
    @IBAction func changeSelection(gesture : ClglistChckBox ){
        
        
       
      
            
            if entireClgView.backgroundColor == UIColor(named: "selectColor"){
                
                if gesture.checkBoxss.isChecked == true{
                    
                    
                    
                    gesture.checkBoxss.isChecked = false
                    allBtn.isSelected = false
                    //
                    allBtn.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                    //
                    
                    
                    if(DefaultsKeys.resiverId.contains(gesture.memberidssss)){
                        
                        if let index = DefaultsKeys.resiverId.firstIndex(of: gesture.memberidssss) {
                            DefaultsKeys.resiverId.remove(at: index)
                        }
                        
                        
                    }
                    
                    
                    if(clgIdArry.contains(gesture.memberidssss)){
                        
                        if let index = clgIdArry.firstIndex(of: gesture.memberidssss) {
                            clgIdArry.remove(at: index)
                        }
                        
                        
                    }
                    
                    
                }else{
                    
                    
                    gesture.checkBoxss.isChecked = true
                    
                    ClgListClgId =  gesture.memberidssss
                    collegeId = Int(ClgListClgId)
                   
                    if(!DefaultsKeys.resiverId.contains(gesture.memberidssss)){
                        DefaultsKeys.resiverId.append(gesture.memberidssss)
                    }
                    
                    if(!clgIdArry.contains(gesture.memberidssss)){
                        clgIdArry.append(gesture.memberidssss)
                    }
                    
                    
                    
                    if clgListDataList.count == DefaultsKeys.resiverId.count{
                        
                        
                        allBtn.isSelected = true
                        //
                        allBtn.setImage(UIImage.init(named: "done"), for: .normal)
                        
                        
                        
                    }
                    
                    
                    else{
                        
                        
                        allBtn.isSelected = false
                        //
                        allBtn.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                        
                        
                        
                    }
                    
                }
            }
            
            
           else if devisionView.backgroundColor == UIColor(named: "selectColor"){
                
                if gesture.checkBoxss.isChecked == true{
                    
                    
                    
                    gesture.checkBoxss.isChecked = false
                    allBtn.isSelected = false
                    //
                    allBtn.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                    //
                    
                    
                    if(DefaultsKeys.resiverId.contains(gesture.memberidssss)){
                        
                        if let index = DefaultsKeys.resiverId.firstIndex(of: gesture.memberidssss) {
                            DefaultsKeys.resiverId.remove(at: index)
                        }
                        
                        
                    }
                    
                    
                    
                    
                }else{
                    
                    
                    gesture.checkBoxss.isChecked = true
                    
                    if(!DefaultsKeys.resiverId.contains(gesture.memberidssss)){
                        DefaultsKeys.resiverId.append(gesture.memberidssss)
                    }
                    
                   
                }
                
            }
            
            
            
            else if courseView.backgroundColor == UIColor(named: "selectColor"){
                
                if gesture.checkBoxss.isChecked == true{
                    
                    gesture.checkBoxss.isChecked = false
                    allBtn.isSelected = false
                    
                    allBtn.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                    
                    if(DefaultsKeys.resiverId.contains(gesture.memberidssss)){
                        
                        if let index = DefaultsKeys.resiverId.firstIndex(of: gesture.memberidssss) {
                            DefaultsKeys.resiverId.remove(at: index)
                        }
                        
                        
                    }
                   
                    if(isFilter){
                        
                        if filtered_listCourse.count == DefaultsKeys.resiverId.count{
                            
                            
                            allBtn.isSelected = true
                            allBtn.setImage(UIImage.init(named: "done"), for: .normal)
                            
                        }
                        
                        
                        else{
                            
                            allBtn.isSelected = false
                            allBtn.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                            
                        }
                        
                    }else{
                        
                        
                        if courseRefName.count == DefaultsKeys.resiverId.count{
                            
                            
                            allBtn.isSelected = true
                            allBtn.setImage(UIImage.init(named: "done"), for: .normal)
                            
                        }
                        
                        
                        else{
                            
                            allBtn.isSelected = false
                            allBtn.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                            
                        }
                    }
                    
                    
                    
                }else{
                    
                    
                    gesture.checkBoxss.isChecked = true
                    
                    
                    if(!DefaultsKeys.resiverId.contains(gesture.memberidssss)){
                        DefaultsKeys.resiverId.append(gesture.memberidssss)
                    }
                    
                    print("resiverId12",DefaultsKeys.resiverId)
                    
                    
                    if(isFilter){
                        
                        if filtered_listCourse.count == DefaultsKeys.resiverId.count{
                            
                            
                            allBtn.isSelected = true
                            allBtn.setImage(UIImage.init(named: "done"), for: .normal)
                            
                        }
                        
                        
                        else{
                            
                            allBtn.isSelected = false
                            allBtn.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                            
                        }
                        
                    }else{
                        
                        
                        if courseRefName.count == DefaultsKeys.resiverId.count{
                            
                            
                            allBtn.isSelected = true
                            allBtn.setImage(UIImage.init(named: "done"), for: .normal)
                            
                        }
                        
                        
                        else{
                            
                            allBtn.isSelected = false
                            allBtn.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                            
                        }
                    }
                    
                    
                    
                }
            }
            
            
            
            else if groupView.backgroundColor == UIColor(named: "selectColor"){
                
                if gesture.checkBoxss.isChecked == true{
                    
                    
                    
                    gesture.checkBoxss.isChecked = false
                    allBtn.isSelected = false
                    
                    allBtn.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                    
                    if(DefaultsKeys.resiverId.contains(gesture.memberidssss)){
                        
                        if let index = DefaultsKeys.resiverId.firstIndex(of: gesture.memberidssss) {
                            DefaultsKeys.resiverId.remove(at: index)
                        }
                        
                        
                    }
                    
                    
                    
                    
                    
                    
                    
                }else{
                    
                    
                    gesture.checkBoxss.isChecked = true
                    
                    
                    
                    
                    if(!DefaultsKeys.resiverId.contains(gesture.memberidssss)){
                        DefaultsKeys.resiverId.append(gesture.memberidssss)
                    }
                    
                    
                    
                    
                    
                    
                    if groupRefName.count == DefaultsKeys.resiverId.count{
                        
                        
                        allBtn.isSelected = true
                        //
                        allBtn.setImage(UIImage.init(named: "done"), for: .normal)
                        
                        
                        
                    }
                    
                    
                    else{
                        
                        
                        allBtn.isSelected = false
                        //
                        allBtn.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                        
                        
                        
                    }
                    
                }
            }
            
            
            
            else if departmentView.backgroundColor == UIColor(named: "selectColor"){
                
                if gesture.checkBoxss.isChecked == true{
                    
                    
                    
                    gesture.checkBoxss.isChecked = false
                    
                    
                    
                    
                    allBtn.isSelected = false
                    
                    allBtn.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                    
                    
                    if(DefaultsKeys.resiverId.contains(gesture.memberidssss)){
                        
                        if let index = DefaultsKeys.resiverId.firstIndex(of: gesture.memberidssss) {
                            DefaultsKeys.resiverId.remove(at: index)
                        }
                        
                        
                    }
                    
                    
                    if(isFilter){
                        
                        if filtered_listDepartment.count == DefaultsKeys.resiverId.count{
                            
                            
                            allBtn.isSelected = true
                            allBtn.setImage(UIImage.init(named: "done"), for: .normal)
                            
                        }
                        
                        
                        else{
                            
                            allBtn.isSelected = false
                            allBtn.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                            
                        }
                        
                    }else{
                        
                        
                        if deparmentRefName.count == DefaultsKeys.resiverId.count{
                            
                            
                            allBtn.isSelected = true
                            allBtn.setImage(UIImage.init(named: "done"), for: .normal)
                            
                        }
                        
                        
                        else{
                            
                            allBtn.isSelected = false
                            allBtn.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                            
                        }
                    }
                    
                    
                    
                    
                }else{
                    
                    
                    gesture.checkBoxss.isChecked = true
                    
                    
                    if(!DefaultsKeys.resiverId.contains(gesture.memberidssss)){
                        DefaultsKeys.resiverId.append(gesture.memberidssss)
                    }
                    
                    
                    
                    
                    if(isFilter){
                        
                        if filtered_listDepartment.count == DefaultsKeys.resiverId.count{
                            
                            
                            allBtn.isSelected = true
                            allBtn.setImage(UIImage.init(named: "done"), for: .normal)
                            
                        }
                        
                        
                        else{
                            
                            allBtn.isSelected = false
                            allBtn.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                            
                        }
                        
                    }else{
                        
                        
                        if deparmentRefName.count == DefaultsKeys.resiverId.count{
                            
                            
                            allBtn.isSelected = true
                            allBtn.setImage(UIImage.init(named: "done"), for: .normal)
                            
                        }
                        
                        
                        else{
                            
                            allBtn.isSelected = false
                            allBtn.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                            
                        }
                    }
                    
                    if deparmentRefName.count == DefaultsKeys.resiverId.count{
                        
                        
                        allBtn.isSelected = true
                        //
                        allBtn.setImage(UIImage.init(named: "done"), for: .normal)
                        
                        
                        
                    }
                    
                    
                    else{
                        
                        
                        allBtn.isSelected = false
                        //
                        allBtn.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                        
                        
                        
                    }
                    
                }
            }
            
            
            
       
    }
    
    @IBAction func SendVc(){
        
       
        nameString = DefaultsKeys.resiverId.joined(separator: "~")
      
            
            
            if  entireClgView.backgroundColor == UIColor(named: "selectColor")||devisionView.backgroundColor == UIColor(named: "selectColor") || departmentView.backgroundColor == UIColor(named: "selectColor") || groupView.backgroundColor == UIColor(named: "selectColor") || courseView.backgroundColor == UIColor(named: "selectColor") {
                
                
                
                
                if (staffCheckBoxView.isChecked == true) || (parentCheckBoxView.isChecked == true) || (studentAllCheckBox.isChecked == true) {
                    
                    
                    print("nameStringgfffeder4r433333",nameString)
                    
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
                        
                        
                        
                        
                        let refreshAlert = UIAlertController(title: "Are you sure you want to submit?", message: AlertMessage + String(DefaultsKeys.resiverId.count), preferredStyle: UIAlertController.Style.alert)
                        
                        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [self] (action: UIAlertAction!) in
                            
                            if self.resivre == "1"{
                                
                                
                                print("Notice")
                                
                                self.NoticeSendSmsToParticular()
                                
                                
                            }
                            
                            else if self.resivre == "2"{
                                
                                print("video")
                                
                                self.SendVideoToParticular()
                                
                            }
                            
                            else if self.resivre == "3"{
                                
                                self.EventParticular()
                                print("event545454454")
                                
                                
                                
                                
                                
                            }
                            
                            else if self.resivre == "4"{
                                
                                
                                print("communication")
                                
                                self.SendSmsToParticular()
                            }
                            
                            
                            else if self.resivre == "5"{
                                print("imagePdf")
                                
                                if imageFileType == "3"{
                                    
                                    
                                    
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
                            
                            else if self.resivre == "11"{
                                
                                if VoiceHstryId == "1"{
                                    self.multypartAudioParticular()
                                }else if VoiceHstryId == "2"{
                                    
                                    self.HistoryVoiceSendParticular()
                                }
                               
                                
                            }
                            
                            else if self.resivre == "13"{
                                
                                self.EventParticular()
//                                self.EventEntier()
                                
                            }
                            
                            
                            
                            
                            
                            
                        }))
                        
                        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                            print("Handle Cancel Logic here")
                        }))
                        
                        present(refreshAlert, animated: true, completion: nil)
                        
                        
                        
                        
                        
                        
                    }
                    
                    
                    
                    
                    
                }
                
                else{
                    
                    let refreshAlert = UIAlertController(title: "", message: "Select Target", preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                        
                        
                        
                        
                    }))
                    
                    present(refreshAlert, animated: true, completion: nil)
                    
                    
                }
                
            }
            
            
            
            
       
        
    }
    
   
    
    func HistoryVoiceSendParticular() {
        
        
//        call_request
        
     
        
        let voiceUpload = VoiceHstryModal()
        
        
        voiceUpload.staffid = memberId
        voiceUpload.description = discreptionss
        voiceUpload.callertype = priority
        voiceUpload.collegeid = String(collegeId)
     
        voiceUpload.forwarding_voice_id = voiceHstryHeaderId
        voiceUpload.receiverid =  nameString
        voiceUpload.receivertype = resiverType
        if parentTargetEnagbel == "0"{
            
            
            voiceUpload.isparent = false
        }
        
        
        else{
            
            
            voiceUpload.isparent = parentCheckBoxView.isChecked
        }
        voiceUpload.isemergencyvoice = voiceReplyType
        
        voiceUpload.isstaff = staffCheckBoxView.isChecked
        voiceUpload.isstudent = studentAllCheckBox.isChecked
        
        let voiceUploadStr = voiceUpload.toJSONString()
        
      
        
       
        VoiceHstryParticularReqs.call_request(param: voiceUploadStr!) {
            
            [self]  (res) in
            
            let enierImagePdf : voiceHstryResponce  = Mapper<voiceHstryResponce>().map(JSONString: res)!
            
            
            if enierImagePdf.Status == 1 {
                
                let refreshAlert = UIAlertController(title: "", message: enierImagePdf.Message, preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    
                    
                }))
                
                
                present(refreshAlert, animated: true, completion: nil)
                
            }
            
            
            else{
                
                let refreshAlert = UIAlertController(title: "", message: enierImagePdf.Message, preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    
                    
                }))
                
                
                present(refreshAlert, animated: true, completion: nil)
            }
        }
        
        
    }
    
    
    func CollegeVc(){
        
        
        
        let colglist = clgListModals()
        
        colglist.college_id = collegeId
        colglist.priority = priority
        
        colglist.user_id = memberId
        
        let colgliststr = colglist.toJSONString()
        ClglistRequest.call_request(param: colgliststr!){ [self]
            
            (res) in
            
            
            
            let colglistResp : clgListResponce  = Mapper<clgListResponce>().map(JSONString: res)!
            
            
            if colglistResp.Status == 1 {
                clgListDataList = colglistResp.data
                topAllView.isHidden = false
                tv.isHidden = false
                        tv.dataSource = self
                        tv.delegate = self
                        tv.reloadData()
                    
                }
           
            
            
            else{
                
                
                
                
                let refreshAlert = UIAlertController(title: "", message: colglistResp.Message, preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                    
                    
                    
                    
                }))
                
                present(refreshAlert, animated: true, completion: nil)
            }
        }
        
        
    }
        @IBAction func entierVc(){
            
            devisionDropVieww.isHidden = true
            couseDropView.isHidden = true

            allBtn.isHidden = false
            allBtn.setImage(UIImage.init(named: "checkboxs"), for: .normal)
            allBtn.isSelected = false
            
        
            collegeRefID = "2"
           
                
                    var idArray : [String] = []
                    clgListDataList.forEach {(arrType)  in
                        idArray.append((arrType.college_name))
                        
                    }
                    collegeDropDownText.optionArray = idArray
                   
                    collegeDropDownText.isSearchEnable = true
                   
                    var ClgId : [Int] = []
                    clgListDataList.forEach {(arrType)  in
                        ClgId.append((arrType.college_id))
                        
                    }
                    
                    
                    print("dropDownCollegeClick111111")
                    
                    collegeDropDownText.didSelect{ [self](selectedText , index ,id) in
                        
                        
                        departMentRefrenceId = "1"
                   
                        tv.isHidden = false
                        allBtn.isHidden = false
                        self.collegeDropDownText.text = selectedText
                        
                        
                            
                        print("dropDownCollegeClick")
                        
                        devisionDropDownList.removeAll()
                        
                        devisionDropDownText.text = "--- Select Division ---"
                        departmentDropDownText.text = "--- Select Department ---"
                   
                        
                       
                         if devisionView.backgroundColor == UIColor(named: "selectColor"){
                             clgIdForClgList = String(ClgId[index])
                             
//
                             devision()
                             
                        }
                        
                        else if departmentView.backgroundColor == UIColor(named: "selectColor"){
                            clgIdForClgList = String(ClgId[index])
                            
                            print("clgggrrrrr",String(ClgId[index]))
                            devisionDropVieww.isHidden = false
                           
                            couseDropView.isHidden = true
//
                            DepartVc()
                            
                        }
                        
                        else if groupView.backgroundColor == UIColor(named: "selectColor"){
                            
                            clgIdForClgList = String(ClgId[index])
                            
                            Group()
                        }
                        
                        else if courseView.backgroundColor == UIColor(named: "selectColor"){
                            clgIdForClgList = String(ClgId[index])
                            devisionDropVieww.isHidden = false
                            
                          
//
                            CoursedropApi()
                        }
                        
                        
                    }
              
             
           
            
        }
        
        
    func multypartAudioParticular() {
        
        
        
        
        
        var vimeoVideoEndpoint = "https://gradit.voicesnap.com/api/AppDetailsBal/SendFileToParticularType"
        
        let voiceUpload = particularVoiceUploadMoad()
        
        
        voiceUpload.staffid = memberId
        voiceUpload.description = discreptionss
        voiceUpload.callertype = priority
        voiceUpload.collegeid = String(collegeId)
        voiceUpload.fileduration = voiceDuration
        voiceUpload.filetype = "1"
        voiceUpload.isemergencyvoice = voiceReplyType
        
        if IDforStaffCheck == "1"{
            
            
            voiceUpload.isstaff = false
            
        }
        
        else{
            
            
            voiceUpload.isstaff = staffCheckBoxView.isChecked
        }
        
        
        if parentTargetEnagbel == "0"{
            
            
            voiceUpload.isparent = false
        }
        
        
        else{
            
            
            voiceUpload.isparent = parentCheckBoxView.isChecked
        }
        
        
        voiceUpload.isstudent = studentAllCheckBox.isChecked
        voiceUpload.receiverid = nameString
        voiceUpload.receivertype = resiverType
        
        
        let voiceUploadStr = voiceUpload.toJSONString()
        
        print("chatSenderStr",voiceUpload)
      
        AF.upload(multipartFormData: { [self] (multipartFormData) in
            
            KRProgressHUD.show()
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                
                
                
                KRProgressHUD.dismiss()
                
            }
            
            
            let pathURL = voiceUrl
            
            let pathString = pathURL!.path
            
            multipartFormData.append(URL(fileURLWithPath: pathString), withName: "file")
            
            multipartFormData.append(Data(voiceUploadStr!.description.utf8), withName: "info")
            
            
            
            print("parameters.description.utf8",voiceUploadStr!.description.utf8)
            
            
        },to: vimeoVideoEndpoint).responseJSON{
            //
            
            res in
            
            let json_str = String(data: res.data!, encoding: .utf8)
            
            print("json \(json_str!)")
            
            
            
            do {
                if let json = try JSONSerialization.jsonObject(with: res.data!, options: []) as? [String: Any] {
                    if let status = json["Status"] as? Int {
                        print("Status: \(status)")
                        
                        if status == 1 {
                            
                            
                            let a = json["Message"]
                            
                            
                            
                            
                            
                            
                            let refreshAlert = UIAlertController(title: "", message:  a as! String, preferredStyle: UIAlertController.Style.alert)
                            
                            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in
                                
                                if priority == "p2" || priority == "p3" {
                                    
                                    let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
                                    vc.is_read_enabled = is_read_enabled
                                    vc.is_write_enabled = is_write_enabled
                                    vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                                    
                                    vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
                                    vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                                    vc.strName = self.strName
                                    vc.str = self.str
                                   
                                    vc.modalPresentationStyle = .fullScreen
                                    self.present(vc, animated: true , completion: nil)
                                    
                                }
                                
                                
                               else if priority == "p7" {
                                    
                                    let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
                                   vc.is_read_enabled = is_read_enabled
                                   vc.is_write_enabled = is_write_enabled
                                    vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
                                    
                                    vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
                                    vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                                    vc.strName = self.strName
                                    vc.str = self.str
                                   
                                    vc.modalPresentationStyle = .fullScreen
                                    self.present(vc, animated: true , completion: nil)
                                    
                                }
                                
                                
                                else{
                                    
                                    let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
                                    vc.is_read_enabled = is_read_enabled
                                    vc.is_write_enabled = is_write_enabled
                                    vc.view.backgroundColor = UIColor(named: "Principal" )
                                    
                                    vc.CommuniSegementName.backgroundColor = UIColor(named: "UnSelector")
                                    vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "Selector")
                                    
                                    vc.strName = self.strName
                                    vc.str = self.str
                                    vc.modalPresentationStyle = .fullScreen
                                    self.present(vc, animated: true , completion: nil)
                                    
                                }
                                
                                
                                
                                
                                
                            }))
                            
                            
                            
                            self.present(refreshAlert, animated: true, completion: nil)
                            
                            
                            
                            
                        }
                        else {
                            
                            
                            
                            let a = json["Message"]
                            
                            
                            let refreshAlert = UIAlertController(title: "", message:  a as! String, preferredStyle: UIAlertController.Style.alert)
                            
                            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in
                                
                                if priority == "p2" || priority == "p3" {
                                    
                                    let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
                                    vc.is_read_enabled = is_read_enabled
                                    vc.is_write_enabled = is_write_enabled
                                    vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                                    
                                    vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
                                    vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                                    vc.strName = self.strName
                                    vc.str = self.str
                                   
                                    vc.modalPresentationStyle = .fullScreen
                                    self.present(vc, animated: true , completion: nil)
                                    
                                }
                                
                                else if priority == "p7" {
                                     
                                     let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
                                    vc.is_read_enabled = is_read_enabled
                                    vc.is_write_enabled = is_write_enabled
                                     vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
                                     
                                     vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
                                     vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                                     vc.strName = self.strName
                                     vc.str = self.str
                                   
                                     vc.modalPresentationStyle = .fullScreen
                                     self.present(vc, animated: true , completion: nil)
                                     
                                 }
                                
                                else{
                                    
                                    let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
                                    vc.is_read_enabled = is_read_enabled
                                    vc.is_write_enabled = is_write_enabled
                                    vc.view.backgroundColor = UIColor(named: "Principal" )
                                    
                                    vc.CommuniSegementName.backgroundColor = UIColor(named: "UnSelector")
                                    vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "Selector")
                                    
                                    vc.strName = self.strName
                                    vc.str = self.str
                                    vc.modalPresentationStyle = .fullScreen
                                    self.present(vc, animated: true , completion: nil)
                                    
                                }
                                
                                
                                
                                
                                
                            }))
                            
                            
                            
                            self.present(refreshAlert, animated: true, completion: nil)
                            
                            
                            
                            
                        }
                        
                    }
                }
            } catch {
                print("Error parsing JSON: \(error)")
            }
            
            
            
            
            
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    
    func SendVideoToParticular() {
        
        
        
        
        
        let uploadvideo = ParticularVideoUploadModal()
        
        print("videoURLvideoURL",videoURL)
        uploadvideo.callertype = priority
        uploadvideo.url = videoURL
        uploadvideo.collegeid = String(collegeId)
        uploadvideo.description = discreptionss
        uploadvideo.iframe = videoIframe
        
        if IDforStaffCheck == "1"{
            
            
            uploadvideo.isstaff = false
            
        }
        
        else{
            
            
            uploadvideo.isstaff = staffCheckBoxView.isChecked
        }
        
        
        if parentTargetEnagbel == "0"{
            
            
            uploadvideo.isparent = false
        }
        
        
        else{
            
            
            uploadvideo.isparent = parentCheckBoxView.isChecked
        }
        
        uploadvideo.isstudent = studentAllCheckBox.isChecked
        uploadvideo.staffid = memberId
        uploadvideo.title = titlesTextField
        uploadvideo.receiverid = nameString
        
        uploadvideo.receivertype = resiverType
        
        
        let uploadvideoStr = uploadvideo.toJSONString()
        
        print("yearAndSectionModalStr", uploadvideo.toJSON())
       
        particularVideoReq.call_request(param: uploadvideoStr!) {
            
            [self]  (res) in
            
            
            
        
            
            
            let particular : ParticularVideoUploadResp = Mapper<ParticularVideoUploadResp>().map(JSONString: res)!
            
            
            sendVideoPart = particular.data
            
            if particular.status == 1 {
                
                
                
                
                let refreshAlert = UIAlertController(title: "", message: particular.message, preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in
                    
                    if priority == "p2" || priority == "p3" {
                        
                        let vc = SenderVideoHomePageViewController(nibName: nil, bundle: nil)
                        vc.is_read_enabled = is_read_enabled
                        vc.is_write_enabled = is_write_enabled
                        vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                        vc.strName = strName
                        vc.str = str
                        
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true , completion: nil)
                        
                    }
                    
                    
                   else if priority == "p7" {
                        
                        let vc = SenderVideoHomePageViewController(nibName: nil, bundle: nil)
                       vc.is_read_enabled = is_read_enabled
                       vc.is_write_enabled = is_write_enabled
                        vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
                        vc.strName = strName
                        vc.str = str
                      
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true , completion: nil)
                        
                    }
                    
                    
                    
                    else{
                        
                        let vc = SenderVideoHomePageViewController(nibName: nil, bundle: nil)
                        vc.is_read_enabled = is_read_enabled
                        vc.is_write_enabled = is_write_enabled
                        vc.view.backgroundColor = UIColor(named: "Principal" )
                        vc.strName = strName
                        vc.str = str
                     
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true , completion: nil)
                        
                    }
                    
                }))
                
                
                
                present(refreshAlert, animated: true, completion: nil)
                
                
                
                
                
                
                
                
                
                
                
                tv.dataSource = self
                tv.delegate = self
                tv.reloadData()
                
                
            }
            
            else{
                
                
                
                let refreshAlert = UIAlertController(title: "", message: particular.message, preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    
                    
                }))
                
                
                
                present(refreshAlert, animated: true, completion: nil)
                
                tv.dataSource = self
                tv.delegate = self
                tv.reloadData()
                
                
            }
            
        }
        
        
        
        
    }
    
    func SendSmsToParticular() {
        
        
        
        let particular = SendSmsToParticularModal()
        
        particular.collegeid = String(collegeId)
        
        particular.staffid = memberId
        
        particular.description = discreptionss
        
        particular.callertype = priority
        
        particular.receivertype = resiverType
        
        
        if IDforStaffCheck == "1"{
            
            
            particular.isstaff = false
            
        }
        
        else{
            
            
            particular.isstaff = staffCheckBoxView.isChecked
        }
        
        
        if parentTargetEnagbel == "0"{
            
            
            particular.isparent = false
        }
        
        
        else{
            
            
            particular.isparent = parentCheckBoxView.isChecked
        }
        
        particular.isstudent = studentAllCheckBox.isChecked
        particular.receiverid = nameString
        
        particular.messagecontent = titlesTextField
        
        particular.filetype = "1"
        
        
        
        
        let particularStr = particular.toJSONString()
        
        
        
        print("yearAndSectionModalStr15",particularStr)
        
        sendSmsParticularRequest.call_request(param: particularStr!) {
            
            [self]  (res) in
            
            
            
            
            
            let particular : senderParticularResponce = Mapper<senderParticularResponce>().map(JSONString: res)!
            
            
            
            
            
            
            
            if particular.Status == 1 {
                
                particularSmsComunication  = particular.data
                
                
                
                let refreshAlert = UIAlertController(title: "", message: particular.Message, preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in
                    if priority == "p2" || priority == "p3" {
                        
                        let vc = CommuniSMSViewController(nibName: nil, bundle: nil)
                        vc.is_read_enabled = is_read_enabled
                        vc.is_write_enabled = is_write_enabled
                        vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                        
                        vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
                        vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                      
                        vc.strName = strName
                        vc.str = str
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true , completion: nil)
                        
                    }
                    
                    
                    else if priority == "p7" {
                        
                        let vc = CommuniSMSViewController(nibName: nil, bundle: nil)
                        vc.is_read_enabled = is_read_enabled
                        vc.is_write_enabled = is_write_enabled
                        vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
                        
                        vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
                        vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                       
                        vc.strName = strName
                        vc.str = str
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true , completion: nil)
                        
                    }
                    
                    
                    else{
                        
                        let vc = CommuniSMSViewController(nibName: nil, bundle: nil)
                        vc.is_read_enabled = is_read_enabled
                        vc.is_write_enabled = is_write_enabled
                        vc.view.backgroundColor = UIColor(named: "Principal" )
                        
                        vc.CommuniSegementName.backgroundColor = UIColor(named: "UnSelector")
                        vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "Selector")
                       
                        vc.strName = strName
                        vc.str = str
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true , completion: nil)
                        
                    }
                    
                    
                }))
                
                
                present(refreshAlert, animated: true, completion: nil)
                
                
                
                
                
            }else{
                
                let refreshAlert = UIAlertController(title: "", message: particular.Message, preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in
                    if priority == "p2" || priority == "p3" {
                        
                        let vc = CommuniSMSViewController(nibName: nil, bundle: nil)
                        vc.is_read_enabled = is_read_enabled
                        vc.is_write_enabled = is_write_enabled
                        vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                        
                        vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
                        vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                        
                        vc.strName = strName
                        vc.str = str
                        
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true , completion: nil)
                        
                    }
                    
                    
                   else if priority == "p7" {
                        
                        let vc = CommuniSMSViewController(nibName: nil, bundle: nil)
                       vc.is_read_enabled = is_read_enabled
                       vc.is_write_enabled = is_write_enabled
                        vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
                        
                        vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
                        vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                        
                        vc.strName = strName
                        vc.str = str
                       
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true , completion: nil)
                        
                    }
                    
                    
                    
                    else{
                        
                        let vc = CommuniSMSViewController(nibName: nil, bundle: nil)
                        vc.is_read_enabled = is_read_enabled
                        vc.is_write_enabled = is_write_enabled
                        vc.view.backgroundColor = UIColor(named: "Principal" )
                        
                        vc.CommuniSegementName.backgroundColor = UIColor(named: "UnSelector")
                        vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "Selector")
                      
                        vc.strName = strName
                        vc.str = str
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true , completion: nil)
                        
                    }
                    
                    
                }))
                
                
                present(refreshAlert, animated: true, completion: nil)
                
                
                
                
            }
            
            
            
        }
        
        
        
        
        
    }
    
    
    
    func NoticeSendSmsToParticular() {
        
        
        let particularNotice = NoticeBoardPartiModal()
        
        
        particularNotice.noticeboardid = "0"
        
        particularNotice.description = discreptionss
        
        particularNotice.receivertype = resiverType
        
        if IDforStaffCheck == "1"{
            
            
            particularNotice.isstaff = false
            
        }
        
        else{
            
            
            particularNotice.isstaff = staffCheckBoxView.isChecked
        }
        
        
        if parentTargetEnagbel == "0"{
            
            
            particularNotice.isparent = false
        }
        
        
        else{
            
            
            particularNotice.isparent = parentCheckBoxView.isChecked
        }
        
        particularNotice.isstudent = studentAllCheckBox.isChecked
        
        particularNotice.processtype = "add"
        particularNotice.receiveridlist = nameString
        
        particularNotice.topic = titlesTextField
        
        particularNotice.colgid = String(collegeId)
        
        particularNotice.staffid = memberId
        
        particularNotice.callertype = priority
        
        let particularStrs = particularNotice.toJSONString()
        
        print("rrrrrrtttrtrtrtrt",particularNotice.toJSON())
        NoticeParticularRequest.call_request(param: particularStrs!) {
            
            [self]  (res) in
            
            
            let particularss : [NoticePArticularResponce] = Mapper<NoticePArticularResponce>().mapArray(JSONString: res)!
            
            
            
            
            for i in particularss{
                
                particularSms = particularss
                
                if i.Status == 1 {
                    
                    
                    
                    let refreshAlert = UIAlertController(title: "", message: i.Message, preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in
                        
                        
                        if priority == "p2" || priority == "p3" {
                            
                            let vc = SenderGraditNoticeBoardMenuViewController(nibName: nil, bundle: nil)
                            vc.is_read_enabled = is_read_enabled
                            vc.is_write_enabled = is_write_enabled
                            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                            vc.noticeSegments.backgroundColor = UIColor(named: "HodUnSelector")
                            vc.noticeSegments.selectedSegmentTintColor = UIColor(named: "HodSelector")
                            vc.strName = strName
                            vc.str = str
                          
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true , completion: nil)
                            
                        }
                        
                       else if priority == "p7" {
                            
                            let vc = SenderGraditNoticeBoardMenuViewController(nibName: nil, bundle: nil)
                           vc.is_read_enabled = is_read_enabled
                           vc.is_write_enabled = is_write_enabled
                            vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
                            vc.noticeSegments.backgroundColor = UIColor(named: "HodUnSelector")
                            vc.noticeSegments.selectedSegmentTintColor = UIColor(named: "HodSelector")
                            vc.strName = strName
                            vc.str = str
                          
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true , completion: nil)
                            
                        }
                        
                        
                        else{
                            
                            let vc = SenderGraditNoticeBoardMenuViewController(nibName: nil, bundle: nil)
                            vc.is_read_enabled = is_read_enabled
                            vc.is_write_enabled = is_write_enabled
                            vc.view.backgroundColor = UIColor(named: "Principal" )
                            vc.noticeSegments.backgroundColor = UIColor(named: "UnSelector")
                            vc.noticeSegments.selectedSegmentTintColor = UIColor(named: "Selector")
                            vc.strName = strName
                            vc.str = str
                           
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true , completion: nil)
                            
                        }
                        
                    }))
                    
                    
                    
                    present(refreshAlert, animated: true, completion: nil)
                    
                    
                    
                    //                        tv.dataSource = self
                    //                        tv.delegate = self
                    //                        tv.reloadData()
                    
                    
                }else{
                    
                    
                    let refreshAlert = UIAlertController(title: "", message: i.Message, preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in
                        
                        
                        if priority == "p2" || priority == "p3" {
                            
                            let vc = SenderGraditNoticeBoardMenuViewController(nibName: nil, bundle: nil)
                            vc.is_read_enabled = is_read_enabled
                            vc.is_write_enabled = is_write_enabled
                            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                            vc.noticeSegments.backgroundColor = UIColor(named: "HodUnSelector")
                            vc.noticeSegments.selectedSegmentTintColor = UIColor(named: "HodSelector")
                            vc.strName = strName
                            vc.str = str
                          
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true , completion: nil)
                            
                        }
                        
                        
                        else if priority == "p7" {
                             
                             let vc = SenderGraditNoticeBoardMenuViewController(nibName: nil, bundle: nil)
                            vc.is_read_enabled = is_read_enabled
                            vc.is_write_enabled = is_write_enabled
                             vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
                             vc.noticeSegments.backgroundColor = UIColor(named: "HodUnSelector")
                             vc.noticeSegments.selectedSegmentTintColor = UIColor(named: "HodSelector")
                             vc.strName = strName
                             vc.str = str
                           
                             vc.modalPresentationStyle = .fullScreen
                             self.present(vc, animated: true , completion: nil)
                             
                         }
                        
                        else{
                            
                            let vc = SenderGraditNoticeBoardMenuViewController(nibName: nil, bundle: nil)
                            vc.is_read_enabled = is_read_enabled
                            vc.is_write_enabled = is_write_enabled
                            vc.view.backgroundColor = UIColor(named: "Principal" )
                            vc.noticeSegments.backgroundColor = UIColor(named: "UnSelector")
                            vc.noticeSegments.selectedSegmentTintColor = UIColor(named: "Selector")
                            vc.strName = strName
                            vc.str = str
                           
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true , completion: nil)
                            
                        }
                        
                    }))
                    
                    
                    
                    present(refreshAlert, animated: true, completion: nil)
                    
                    
                    
                }
                
                
                
                
                
                
            }
        }
    }
    
    
    
    func EventParticular(){
        
        
        let particular = EventParticualrModal()
        
        particular.eventid = "0"
        //
        particular.eventbody = discreptionss
        
        particular.eventdate = DateLabels
        
        particular.eventvenue = venumtextField
        
        
        particular.eventtime = EventTime
        particular.eventtopic = titlesTextField
        
        
        
        particular.processtype = "add"
        particular.collegeid = String(collegeId)
        //
        particular.staffid = memberId
        //
        
        
        particular.Callertype = priority
        //
        particular.receivertype = resiverType
        
        if IDforStaffCheck == "1"{
            
            
            particular.isstaff = false
            
        }
        
        else{
            
            
            particular.isstaff = staffCheckBoxView.isChecked
        }
        
        
        if parentTargetEnagbel == "0"{
            
            
            particular.isparent = false
        }
        
        
        else{
            
            
            particular.isparent = parentCheckBoxView.isChecked
        }
        
        particular.isstudent = studentAllCheckBox.isChecked
        particular.receiveridlist = nameString
        
        
        
        let particularStr = particular.toJSONString()
        
        
        //
        print("yearAndSectionModalStr",particular.toJSON())
        
        EventParticularRequest.call_request(param: particularStr!) {
            
            [self]  (res) in
            
            
            
            
            
            let particular : [EventParticularResponce] = Mapper<EventParticularResponce>().mapArray(JSONString: res)!
            
            
            for i in particular{
                
                if i.Status == 1 {
                    
                    
                    
                    let refreshAlert = UIAlertController(title: "", message: i.Message, preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in
                        
                        
                        if priority == "p2" || priority == "p3" {
                            
                            let vc = SenderEventHomePageViewController(nibName: nil, bundle: nil)
                            vc.is_read_enabled = is_read_enabled
                            vc.is_write_enabled = is_write_enabled
                            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                            vc.eventSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                            vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                            vc.strName = strName
                            vc.str = str
                           
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true , completion: nil)
                            
                        }
                        
                        
                        else if priority == "p7" {
                            
                            let vc = SenderEventHomePageViewController(nibName: nil, bundle: nil)
                            vc.is_read_enabled = is_read_enabled
                            vc.is_write_enabled = is_write_enabled
                            vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
                            vc.eventSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                            vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                            vc.strName = strName
                            vc.str = str
                           
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true , completion: nil)
                            
                        }
                        
                        else{
                            
                            let vc = SenderEventHomePageViewController(nibName: nil, bundle: nil)
                            vc.is_read_enabled = is_read_enabled
                            vc.is_write_enabled = is_write_enabled
                            vc.view.backgroundColor = UIColor(named: "Principal" )
                            vc.eventSegmentName.backgroundColor = UIColor(named: "UnSelector")
                            vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "Selector")
                            vc.strName = strName
                            vc.str = str
                           
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true , completion: nil)
                            
                        }
                        
                        
                    }))
                    
                    
                    present(refreshAlert, animated: true, completion: nil)
                    
                    
                    
                    
                }else{
                    
                    let refreshAlert = UIAlertController(title: "", message: i.Message, preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in
                        
                        
                        if priority == "p2" || priority == "p3" {
                            
                            let vc = SenderEventHomePageViewController(nibName: nil, bundle: nil)
                            vc.is_read_enabled = is_read_enabled
                            vc.is_write_enabled = is_write_enabled
                            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                            vc.eventSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                            vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                            vc.strName = strName
                            vc.str = str
                          
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true , completion: nil)
                            
                        }
                        
                        else if priority == "p7" {
                            
                            let vc = SenderEventHomePageViewController(nibName: nil, bundle: nil)
                            vc.is_read_enabled = is_read_enabled
                            vc.is_write_enabled = is_write_enabled
                            vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
                            vc.eventSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                            vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                            vc.strName = strName
                            vc.str = str
                         
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true , completion: nil)
                            
                        }
                        else{
                            
                            let vc = SenderEventHomePageViewController(nibName: nil, bundle: nil)
                            vc.is_read_enabled = is_read_enabled
                            vc.is_write_enabled = is_write_enabled
                            vc.view.backgroundColor = UIColor(named: "Principal" )
                            vc.eventSegmentName.backgroundColor = UIColor(named: "UnSelector")
                            vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "Selector")
                            vc.strName = strName
                            vc.str = str
                           
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true , completion: nil)
                            
                        }
                        
                        
                    }))
                    
                    
                    present(refreshAlert, animated: true, completion: nil)
                    
                    
                }
                
                
                
                
                
                
            }
            
            
        }
        
        
        
    }
    
 
    
    func  ImagePdfParticular(ImageFile: [String]){
        
        
        var imageAryy : [FileNameImages] = []
        
        
        
        for i in ImageFile{
            let imageAws = FileNameImages()
            imageAws.FileName = i
            
            imageAryy.append(imageAws)
        }
        
        
        
        let sendImagePdfEntier = ImagePdfPartResponce()
        
        print("fileTyoee",fileType)
        sendImagePdfEntier.title = titlesTextField
        sendImagePdfEntier.receiverid = nameString
        sendImagePdfEntier.receivertype = resiverType
        sendImagePdfEntier.callertype = priority
        sendImagePdfEntier.collegeid = String(collegeId)
        sendImagePdfEntier.Description = discreptionss
        sendImagePdfEntier.Staffid = memberId
        sendImagePdfEntier.fileduration = "0"
        sendImagePdfEntier.filetype = imageFileType
        if IDforStaffCheck == "1"{
            
            
            sendImagePdfEntier.isstaff = false
            
        }
        
        else{
            
            
            sendImagePdfEntier.isstaff = staffCheckBoxView.isChecked
        }
        
        
        if parentTargetEnagbel == "0"{
            
            
            sendImagePdfEntier.isparent = false
        }
        
        
        else{
            
            
            sendImagePdfEntier.isparent = parentCheckBoxView.isChecked
        }
        
        
        sendImagePdfEntier.isstudent = studentAllCheckBox.isChecked
        
        sendImagePdfEntier.FileNameArray = imageAryy
        let imagePdfStr = sendImagePdfEntier.toJSONString()
        
        print("imagePdfStr",imagePdfStr)
        
        ImagePdfParticularsee.call_request(param: imagePdfStr!) {
            
            [self]  (res) in
            
            let enierImagePdf : SendImagePdfPartiResponce  = Mapper<SendImagePdfPartiResponce>().map(JSONString: res)!
            
            imagePdfEniterParticular = enierImagePdf.data
            if enierImagePdf.Status == 1{
                
                
                let refreshAlert = UIAlertController(title: "", message: enierImagePdf.Message, preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in
                    
                    if priority == "p2" || priority == "p3" {
                        
                        let vc = SenderImagePdfHomePageViewController(nibName: nil, bundle: nil)
                        vc.is_read_enabled = is_read_enabled
                        vc.is_write_enabled = is_write_enabled
                        vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                        
                        vc.imageSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                        vc.imageSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                        vc.strName = strName
                        vc.str = str
                      
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true , completion: nil)
                        
                    }
                    
                    
                   else if priority == "p7" {
                        
                        let vc = SenderImagePdfHomePageViewController(nibName: nil, bundle: nil)
                       vc.is_read_enabled = is_read_enabled
                       vc.is_write_enabled = is_write_enabled
                        vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
                        
                        vc.imageSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                        vc.imageSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                        vc.strName = strName
                        vc.str = str
                    
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true , completion: nil)
                        
                    }
                    
                    
                    else{
                        
                        let vc = SenderImagePdfHomePageViewController(nibName: nil, bundle: nil)
                        vc.is_read_enabled = is_read_enabled
                        vc.is_write_enabled = is_write_enabled
                        vc.view.backgroundColor = UIColor(named: "Principal" )
                        vc.imageSegmentName.backgroundColor = UIColor(named: "UnSelector")
                        vc.imageSegmentName.selectedSegmentTintColor = UIColor(named: "Selector")
                        vc.strName = strName
                        vc.str = str
                       
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true , completion: nil)
                        
                    }
                    
                }))
                
                
                
                
                present(refreshAlert, animated: true, completion: nil)
                
                
            }
            
            
            else{
                
                
                let refreshAlert = UIAlertController(title: "", message: enierImagePdf.Message, preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in
                    
                    if priority == "p2" || priority == "p3" {
                        
                        let vc = SenderImagePdfHomePageViewController(nibName: nil, bundle: nil)
                        vc.is_read_enabled = is_read_enabled
                        vc.is_write_enabled = is_write_enabled
                        vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                        
                        vc.imageSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                        vc.imageSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                        vc.strName = strName
                        vc.str = str
                       
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true , completion: nil)
                        
                    }
                    else if priority == "p7" {
                         
                         let vc = SenderImagePdfHomePageViewController(nibName: nil, bundle: nil)
                        vc.is_read_enabled = is_read_enabled
                        vc.is_write_enabled = is_write_enabled
                         vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
                         
                         vc.imageSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                         vc.imageSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                         vc.strName = strName
                         vc.str = str
                       
                         vc.modalPresentationStyle = .fullScreen
                         self.present(vc, animated: true , completion: nil)
                         
                     }
                    
                    else{
                        
                        let vc = SenderImagePdfHomePageViewController(nibName: nil, bundle: nil)
                        vc.is_read_enabled = is_read_enabled
                        vc.is_write_enabled = is_write_enabled
                        vc.view.backgroundColor = UIColor(named: "Principal" )
                        vc.imageSegmentName.backgroundColor = UIColor(named: "UnSelector")
                        vc.imageSegmentName.selectedSegmentTintColor = UIColor(named: "Selector")
                        vc.strName = strName
                        vc.str = str
                       
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true , completion: nil)
                        
                    }
                    
                }))
                
                
                
                
                present(refreshAlert, animated: true, completion: nil)
                
                
            }
       
        }
        
        
        
    }
    
    
    func getImageURL(images : [UIImage]){
        self.originalImagesArray = images
        self.totalImageCount = images.count
        if currentImageCount < images.count{
            uploadAWS(image: images[currentImageCount])
            
        }
    }
    
    
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
                    awsArry.append(absoluteStringImg)
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
                    
                    
                    
                    
                    
                    
                }
            }
            else {
                KRProgressHUD.dismiss()
                print("Unexpected empty result.")
            }
            return nil
        }
    }
    
    
    func uploadPDFFileToAWS(pdfData : NSData){
        //        self.showLoading()
        
        
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
        
        let uploadRequest = AWSS3TransferManagerUploadRequest()
        uploadRequest?.body = imageURL
        uploadRequest?.key = colgId + "/" + currentDate +  "/" + "File_" + ext
        uploadRequest?.bucket = S3BucketName
      
        uploadRequest?.contentType = "application/pdf"
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
                if let absoluteString = publicURL?.absoluteString {
                    print("Uploaded to:\(absoluteString)")
                   
                    awsArry.append(absoluteString)
                    let imageDict = NSMutableDictionary()
                    imageDict["FileName"] = absoluteString
                    self.imageUrlArray.add(imageDict)
                    self.convertedImagesUrlArray = self.imageUrlArray
                    
                    
                    

                        if resivre == "5"{
                            
                            
                            self.ImagePdfParticular(ImageFile: awsArry)
                            
                        }
                        
                        

                }
            }
            else {
                KRProgressHUD.dismiss()
                print("Unexpected empty result.")
            }
            return nil
        }
    }
    
    
    
    @IBAction func allCheckBoxBtn(_ sender: UIButton) {
        
        
        DefaultsKeys.resiverId.removeAll()
        
      
       
            
            if entireClgView.backgroundColor == UIColor(named: "selectColor"){
                
                
                if sender.isSelected {
                    for i in  clgListDataList{
                        i.isSelected = false
                        sender.isSelected = false
                        print("forPrint",i.college_id)
                        
                        if(DefaultsKeys.resiverId.count > 0){
                            DefaultsKeys.resiverId.removeAll()
                        }
                        
                        sender.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                    }
                }else{
                    
                    for i in  clgListDataList{
                        i.isSelected = true
                        sender.isSelected = true
                        print("forPrint1",i.college_id)
                        
                        if(!DefaultsKeys.resiverId.contains(String(i.college_id))){
                            DefaultsKeys.resiverId.append(String(i.college_id))
                        }
                        
                        sender.setImage(UIImage.init(named: "done"), for: .normal)
                    }
                    
                }
            }
            
           else if devisionView.backgroundColor == UIColor(named: "selectColor"){
                
                if sender.isSelected {
                    for i in  devisionRefName{
                        i.isSelected = false
                        sender.isSelected = false
                        print("forPrint",i.division_id)
                        
                        if(DefaultsKeys.resiverId.count > 0){
                            DefaultsKeys.resiverId.removeAll()
                        }
                        
                        sender.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                    }
                }else{
                    
                    for i in  devisionRefName{
                        i.isSelected = true
                        sender.isSelected = true
                        print("forPrint1",i.division_id)
                        
                        if(!DefaultsKeys.resiverId.contains(i.division_id)){
                            DefaultsKeys.resiverId.append(i.division_id)
                        }
                        
                        sender.setImage(UIImage.init(named: "done"), for: .normal)
                    }
                    
                }
            }
            
            else if departmentView.backgroundColor == UIColor(named: "selectColor"){
                
                
                
                
                if sender.isSelected {
                    for i in  deparmentRefName{
                        i.isSelected = false
                        sender.isSelected = false
                        print("forPrint",i.department_id)
                        
                        
                        if(DefaultsKeys.resiverId.count > 0){
                            DefaultsKeys.resiverId.removeAll()
                        }
                        
                        sender.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                    }
                }else{
                    
                    for i in  deparmentRefName{
                        i.isSelected = true
                        sender.isSelected = true
                        print("forPrint1",i.department_id)
                        
                        if(!DefaultsKeys.resiverId.contains(i.department_id)){
                            DefaultsKeys.resiverId.append(i.department_id)
                        }
                        sender.setImage(UIImage.init(named: "done"), for: .normal)
                    }
                    
                    
                }
                
                
            }
            
            else if groupView.backgroundColor == UIColor(named: "selectColor"){
                
                
                
                
                
                if sender.isSelected {
                    for i in  groupRefName{
                        i.isSelected = false
                        sender.isSelected = false
                        
                        
                        if(DefaultsKeys.resiverId.count > 0){
                            DefaultsKeys.resiverId.removeAll()
                        }
                        sender.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                    }
                    
                    
                    
                    print("resiverId",DefaultsKeys.resiverId)
                }else{
                    
                    for i in  groupRefName{
                        i.isSelected = true
                        sender.isSelected = true
                        print("forPrint1",i.groupid)
                        
                        var str = String(i.groupid)
                        
                        
                        if(!DefaultsKeys.resiverId.contains(str)){
                            DefaultsKeys.resiverId.append(str)
                        }
                        
                        sender.setImage(UIImage.init(named: "done"), for: .normal)
                    }
                    
                    
                    let uniqueArray = Array(Set(DefaultsKeys.resiverId))
                    nameString = uniqueArray.joined(separator: "~")
                    
                }
                
                
            }
            
            else if courseView.backgroundColor == UIColor(named: "selectColor"){
                
                
                
                
                if sender.isSelected {
                    for i in  courseRefName{
                        i.isSelected = false
                        sender.isSelected = false
                        print("forPrint",i.course_id)
                        sender.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                    }
                    
                    if(DefaultsKeys.resiverId.count > 0){
                        DefaultsKeys.resiverId.removeAll()
                    }
                    
                    
                    print("resiverId",DefaultsKeys.resiverId)
                }else{
                    
                    for i in  courseRefName{
                        i.isSelected = true
                        sender.isSelected = true
                        print("forPrint1",i.course_id)
                        
                        if(!DefaultsKeys.resiverId.contains(i.course_id)){
                            DefaultsKeys.resiverId.append(i.course_id)
                        }
                        
                        sender.setImage(UIImage.init(named: "done"), for: .normal)
                    }
                    
                    
                    print("CourseSelectALLL",DefaultsKeys.resiverId)
                    
                    
                    
                }
                
                
            }
            
            print("TutorTutorTutor")
            
            
            
            
        
        tv.reloadData()
        
    }
    
    
    
    
    
        
    
}
    class ClglistChckBox : UITapGestureRecognizer {
        
        var pos : Int!
        
        var memberidssss : String!
        var demoImgg : UIImageView!
        var checkBoxss : CheckBoxTwo!
        
        var bool : Bool!
        
        
    }
