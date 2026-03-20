//
//  SpecificStudentViewController.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 14/03/23.
//

import UIKit
import ObjectMapper
import Alamofire
import KRProgressHUD
import AWSS3
import DropDown

@available(iOS 16.0, *)
class SpecificStudentViewController: UIViewController,UITableViewDelegate,UITableViewDataSource ,UISearchBarDelegate,UITextViewDelegate{
    
    
    @IBOutlet weak var attendanceLineView: UIView!
    @IBOutlet weak var textViewHeight: NSLayoutConstraint!
    @IBOutlet weak var AttendanceTheryHeight: NSLayoutConstraint!
    @IBOutlet weak var partialBtnName: UIButton!
    @IBOutlet weak var theroyBtnName: UIButton!
    
    @IBOutlet weak var generalBtnName: UIButton!
    @IBOutlet weak var allCheckTotalView: UIView!
    
    @IBOutlet weak var pleaseChooseLbl: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var attendanceDropLbl: UILabel!
    @IBOutlet weak var attendanceDropDown: UIViewX!
    @IBOutlet weak var parentDefaultLbl: UILabel!
    @IBOutlet weak var searchbar: UISearchBar!
    
    @IBOutlet weak var attendanceDepartLAbl: UILabel!
    
    @IBOutlet weak var AttendanceViewHigth: NSLayoutConstraint!
    @IBOutlet weak var attendanceSemeLabl: UILabel!
    @IBOutlet weak var attendanceYearLabl: UILabel!
    @IBOutlet weak var TargetView: UIView!
    @IBOutlet weak var selectBtn: UIButton!
    @IBOutlet weak var allCheckBox: CheckBoxTwo!
    @IBOutlet weak var parentChck: CheckBoxTwo!
    
    @IBOutlet weak var AttendanceTextView: UITextView!
    
    @IBOutlet weak var tagetViewHeight: NSLayoutConstraint!
    @IBOutlet weak var attendanceSectionLbl: UILabel!
    @IBOutlet weak var studentChck: CheckBoxTwo!
    @IBOutlet weak var sendView: UIViewX!
    
    @IBOutlet weak var Tv: UITableView!
    @IBOutlet weak var attendanceInfoView: UIView!
    @IBOutlet weak var cancelView: UIViewX!
    
    
    @IBOutlet weak var attendanceSelectallBtn: UIButton!
    @IBOutlet weak var markAllAsDefLbl: UILabel!
    
    @IBOutlet weak var presentAllBtn: UIButton!
    @IBOutlet weak var AbsentAllBtn: UIButton!
    @IBOutlet weak var OndutyAllBtn: UIButton!
    @IBOutlet weak var OnLeaveBtn: UIButton!
    @IBOutlet weak var attendanceStack: UIStackView!
    @IBOutlet weak var SortBtn: UIButton!
    
    
    
    var  identifier = "SpecifyStudentTableViewCell"
    
    var studentRef : [GetstudentListData] = []
    var clone_list : [GetMentorstudentListData] = []
    var clonelist2 : [GetstudentListData] = []
    var studentRefsss = [GetstudentListData]()
    var tutorRefs : [GetMentorstudentListData] = []
    var particularSms : NoticePArticularResponce?
    var eventParticulae : [EventParticularResponce] = []
    var particularComuniSms : [SmsdataDetails] = []
    var assigmentImagPdf : [assigmentImagePdfResponce] = []
    var imagePdfEniter : [sendImagePdfPartiDataDetails] = []
    var attendanceEditsss : [AttendanceEditDataDEtails] = []
    var sendVideoPart : [ParticularVideoUploadRespData] = []
    
    var edit_hours : [editHoursdataDEtaild] = []
    var clonelist3 : [AttendanceEditDataDEtails] = []
    var collegeId : String!
    var departmentId : String!
    var sectionId : String!
    var courseId : String!
    var YearId : String! = ""
    var ItemName : String!
    var stafId : String!
    var resiverId : [String] = []
    var nameString : String!
    var MenuType : String!
    var textTitle : String!
    var searching = false
    var TextDiscrition : String!
    var piroty : String!
    
    
    
    var demoMem : String!
    var resiverType  = "7"
    
    var subjectID : String!
    
    var AssigmentAwsURl : String!
    
    var eventDate : String!
    
    var eventVenu : String!
    
    var imageFileType : String!
    var awsurl: String!
    
    var assigmentForwardHeaderId : String!
    
    var attendancePresent : String!
    
    var attendanceDate : String!
    
    var AttendanceSubjectmemberId : [String] = []
    
    var presentMemberIds : [String] = []
    var absentMemberIds : [String] = []
    var onDutyMemberIds : [String] = []
    var onLeaveMemberIds : [String] = []
    
    var people = [GetstudentListData]()
    var attendanceType : [String] = []
    
    var videoUrl : String!
    
    var iframeVideo : String!
    
    var voiceURl : URL!
    
    var voiceReplyType : String!
    
    var voiceDuration : String!
    
    var filterData : [String] = []
    var str : [String] = []
    
    var studenId : [String] = []
    
    var datas : [String]!
    var strs : [String] = []
    
    var strName : [String] = []
    var indexPathss : Int!
    var HodYearSpefiy : String!
    var EventTime : String!
    var awsArry : [String] = []
    var assigmentDate : String!
    var AssigmentFileType : String!
    
    var AttendancessdepartmentName : String!
    var AttendancessYearName : String!
    var AttendancessSemesterName : String!
    var AttendancessSectionNamw : String!
    
    var RemoveDuplicateValue :  [String] = []
    
    
    var indexPathsections : Int!
    
    
    var AllIDS : String!
    
    
    let dropDown = DropDown()
    let attendanceMarkDropdown = DropDown()
    
    var imagePicker = UIImagePickerController()
    var currentImageCount = 0
    var totalImageCount = 0
    var originalImagesArray = [UIImage]()
    var absoluteStringImg : String!
    var imageUrlArray = NSMutableArray()
    var convertedImagesUrlArray = NSMutableArray()
    
    var photoArray = [UIImage]()
    var pdfData : Data? = nil
    
    var reee : String!
    var idddd : [String] = []
    
    
    var AttendanceABSENTId : [String] = []
    
    var AttendancePresentId : [String] = []
    
    
    
    var EditAttendanceABSENTId : [String] = []
    var EditAttendancePresentId : [String] = []
    var EditAttendanceOnDutyId : [String] = []
    var EditAttendanceOnLeaveId : [String] = []
    
    var ALLLLID : String!
    
    var is_parent_target_enabled = ""
    
    var filtered_list : [GetstudentListData] = []
    var filtered_listTutor : [GetMentorstudentListData] = []
    
    var filtered_listAttendance : [AttendanceEditDataDEtails] = []
    var isFilter : Bool = false
    var is_read_enabled : String!
    var is_write_enabled : String!
    var VoiceHstryId : String!
    var voiceHstryHeaderId : String!
    var attendanceHourDropRef : [Int] = []
    var subjectIdForStuddent : String!
    var inc = 0
    
    var typeofAttendance  = "General"
    
    var SortingDropdown = DropDown()
    var selectedSoringIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // command this line after update
        //        AttendanceTheryHeight.constant = 0
        //        attendanceLineView.isHidden = true
        //        AttendanceTextView.isHidden = true
        // command end
        
        searchbar.delegate = self
        overrideUserInterfaceStyle = .light
        AttendanceTextView.delegate = self
        
        print("helooo",attendanceHourDropRef.count)
        
        let defaults = UserDefaults.standard
        
        
        piroty = defaults.string(forKey: DefaultsKeys.priority)
        stafId = defaults.string(forKey: DefaultsKeys.memberid)
        
        collegeId = defaults.string(forKey: DefaultsKeys.collegeid)
        is_parent_target_enabled = defaults.string(forKey: DefaultsKeys.is_parent_target_enabled)!
        
        selectBtn.setImage(UIImage.init(named: "checkboxs"), for: .normal)
        
        AttendanceTextView.text = "Enter the topic"
        AttendanceTextView.textColor = UIColor.lightGray
        pleaseChooseLbl.isHidden = true
        
        addDoneButtonOnKeyboard()
        
        AttendanceTextView.delegate = self
        
        if  is_parent_target_enabled == "0"{
            
            parentChck.isHidden = true
            parentDefaultLbl.isHidden = true
        }else{
            
            parentDefaultLbl.isHidden = false
            parentChck.isHidden = false
        }
        
        attendanceSelectallBtn.backgroundColor = .systemGray6
        attendanceSelectallBtn.layer.cornerRadius = 8
        attendanceSelectallBtn.layer.shadowColor = UIColor.black.cgColor
        attendanceSelectallBtn.layer.shadowOpacity = 0.4
        attendanceSelectallBtn.layer.shadowOffset = CGSize(width: 2, height: 2)
        attendanceSelectallBtn.layer.shadowRadius = 4
        attendanceSelectallBtn.layer.masksToBounds = false
        
        setupSortDropdown()
        
        if  MenuType == "10"{
            
            allCheckTotalView.isHidden = true
            TargetView.isHidden = true
            attendanceStack.isHidden = false
            SortBtn.isHidden = false
        }else{
            
            allCheckTotalView.isHidden = false
            TargetView.isHidden = false
            generalBtnName.setImage(UIImage(named: "radios"), for: .normal)
            attendanceStack.isHidden = true
            SortBtn.isHidden = true
        }
        
        
        if MenuType == "9" || MenuType == "10"{
            attendanceStack.isHidden = false
            allCheckTotalView.isHidden = true
            SortBtn.isHidden = false
            AttendanceViewHigth.constant = 250
            //            AttendanceViewHigth.constant = 180
            TargetView.isHidden  = true
            tagetViewHeight.constant = 0
            attendanceInfoView.isHidden = false
            attendanceSemeLabl.text = ":" + "  " + AttendancessSemesterName
            attendanceYearLabl.text = ":" + "  " + AttendancessYearName
            attendanceSectionLbl.text = ":" + "  " + AttendancessSectionNamw
            attendanceDepartLAbl.text = ":" + "  " + AttendancessdepartmentName
        }
        
        
        
        else if MenuType == "8"  ||  MenuType == "6"{
            
            
            
            TargetView.isHidden  = true
            tagetViewHeight.constant = 0
            
            
            
            
            AttendanceViewHigth.constant = -150
            
            
            attendanceInfoView.isHidden = true
            
            SortBtn.isHidden = true
            
            
            
        }
        
        else{
            
            TargetView.isHidden  = false
            
            AttendanceViewHigth.constant = -172
            tagetViewHeight.constant = 95
            
            attendanceInfoView.isHidden = true
            SortBtn.isHidden = true
        }
        
        
        
        if MenuType == "8" ||  MenuType == "9"  ||  MenuType == "6"  {
            
            studentListReseponse()
            
            
        }
        
        else if MenuType == "10"{
            
            
            hourLabel.text =  "Choose hours to edit"
            pleaseChooseLbl.isHidden = false
            
            
            
            
        }
        
        if ItemName == "Subject" || HodYearSpefiy == "12"{
            studentListReseponse()
        }
        
        else if ItemName == "Tutor"{
            
            mentorListReseponse()
        }
        let cancel = UITapGestureRecognizer(target: self, action: #selector(cancelVc))
        cancelView.addGestureRecognizer(cancel)
        
        let rownib = UINib(nibName: identifier, bundle: nil)
        Tv.register(rownib, forCellReuseIdentifier: identifier)
        
        
        let send = UITapGestureRecognizer(target: self, action: #selector(sendVc))
        sendView.addGestureRecognizer(send)
        
        
        let Allbox = UITapGestureRecognizer(target: self, action: #selector(allCheckboxvc))
        allCheckBox.addGestureRecognizer(Allbox)
        
        let studentCheckBox = UITapGestureRecognizer(target: self, action: #selector(StudentCheckBoxVc))
        studentChck.addGestureRecognizer(studentCheckBox)
        
        let parentCheckBox = UITapGestureRecognizer(target: self, action: #selector(parentCheckBoxVc))
        parentChck.addGestureRecognizer(parentCheckBox)
        
        let attendDrop = UITapGestureRecognizer(target: self, action: #selector(selectedDropVc))
        attendanceDropDown.addGestureRecognizer(attendDrop)
    }
    
    func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        AttendanceTextView.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction(){
        AttendanceTextView.resignFirstResponder()
    }
    
    
    @IBAction func markAllPresentAct(_ sender: Any) {
        
        if MenuType == "9" {
            presentMemberIds = studentRef.compactMap { $0.memberid }
            absentMemberIds.removeAll()
            onDutyMemberIds.removeAll()
            onLeaveMemberIds.removeAll()
        }else if MenuType == "10" {
            EditAttendancePresentId = attendanceEditsss.compactMap{$0.memberid}
            EditAttendanceABSENTId.removeAll()
            EditAttendanceOnDutyId.removeAll()
            EditAttendanceOnLeaveId.removeAll()
        }
        
        presentAllBtn.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        AbsentAllBtn.setImage(UIImage(systemName: "square"), for: .normal)
        OndutyAllBtn.setImage(UIImage(systemName: "square"), for: .normal)
        OnLeaveBtn.setImage(UIImage(systemName: "square"), for: .normal)
        
        Tv.reloadData()
    }
    
    
    @IBAction func markAllAbsentAct(_ sender: Any) {
        
        if MenuType == "9" {
            absentMemberIds = studentRef.compactMap { $0.memberid }
            presentMemberIds.removeAll()
            onDutyMemberIds.removeAll()
            onLeaveMemberIds.removeAll()
        }else if MenuType == "10" {
            EditAttendanceABSENTId = attendanceEditsss.compactMap{$0.memberid}
            EditAttendancePresentId.removeAll()
            EditAttendanceOnDutyId.removeAll()
            EditAttendanceOnLeaveId.removeAll()
        }
        
        AbsentAllBtn.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        presentAllBtn.setImage(UIImage(systemName: "square"), for: .normal)
        OndutyAllBtn.setImage(UIImage(systemName: "square"), for: .normal)
        OnLeaveBtn.setImage(UIImage(systemName: "square"), for: .normal)
        
        Tv.reloadData()
    }
    
    @IBAction func markAllOndutyAct(_ sender: Any) {
        
        if MenuType == "9" {
            onDutyMemberIds = studentRef.compactMap { $0.memberid }
            presentMemberIds.removeAll()
            absentMemberIds.removeAll()
            onLeaveMemberIds.removeAll()
        }else if MenuType == "10" {
            EditAttendanceOnDutyId = attendanceEditsss.compactMap{$0.memberid}
            EditAttendancePresentId.removeAll()
            EditAttendanceABSENTId.removeAll()
            EditAttendanceOnLeaveId.removeAll()
        }
        
        OndutyAllBtn.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        presentAllBtn.setImage(UIImage(systemName: "square"), for: .normal)
        AbsentAllBtn.setImage(UIImage(systemName: "square"), for: .normal)
        OnLeaveBtn.setImage(UIImage(systemName: "square"), for: .normal)
        
        Tv.reloadData()
    }
    
    @IBAction func markAllOnLeaveAct(_ sender: Any) {
        
        if MenuType == "9" {
            onLeaveMemberIds = studentRef.compactMap { $0.memberid }
            presentMemberIds.removeAll()
            absentMemberIds.removeAll()
            onDutyMemberIds.removeAll()
        }else if MenuType == "10" {
            EditAttendanceOnLeaveId = attendanceEditsss.compactMap{$0.memberid}
            EditAttendancePresentId.removeAll()
            EditAttendanceABSENTId.removeAll()
            EditAttendanceOnDutyId.removeAll()
        }
        
        OnLeaveBtn.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        presentAllBtn.setImage(UIImage(systemName: "square"), for: .normal)
        AbsentAllBtn.setImage(UIImage(systemName: "square"), for: .normal)
        OndutyAllBtn.setImage(UIImage(systemName: "square"), for: .normal)
        
        Tv.reloadData()
    }
    
    
    func check_MarkAll_count() {
        if MenuType == "9" {
            // Reset all first
            presentAllBtn.setImage(UIImage(systemName: "square"), for: .normal)
            AbsentAllBtn.setImage(UIImage(systemName: "square"), for: .normal)
            OndutyAllBtn.setImage(UIImage(systemName: "square"), for: .normal)
            OnLeaveBtn.setImage(UIImage(systemName: "square"), for: .normal)

            if presentMemberIds.count == studentRef.count {
                presentAllBtn.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            } else if absentMemberIds.count == studentRef.count {
                AbsentAllBtn.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            } else if onDutyMemberIds.count == studentRef.count {
                OndutyAllBtn.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            } else if onLeaveMemberIds.count == studentRef.count {
                OnLeaveBtn.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            }

            print("presentIds", presentMemberIds)
            print("AbsentIds", absentMemberIds)
            print("Onduty", onDutyMemberIds)
            print("OnLeave", onLeaveMemberIds)

        } else if MenuType == "10" {
            // Reset all first
            presentAllBtn.setImage(UIImage(systemName: "square"), for: .normal)
            AbsentAllBtn.setImage(UIImage(systemName: "square"), for: .normal)
            OndutyAllBtn.setImage(UIImage(systemName: "square"), for: .normal)
            OnLeaveBtn.setImage(UIImage(systemName: "square"), for: .normal)

            if EditAttendancePresentId.count == attendanceEditsss.count {
                presentAllBtn.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            } else if EditAttendanceABSENTId.count == attendanceEditsss.count {
                AbsentAllBtn.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            } else if EditAttendanceOnDutyId.count == attendanceEditsss.count {
                OndutyAllBtn.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            } else if EditAttendanceOnLeaveId.count == attendanceEditsss.count {
                OnLeaveBtn.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            }

            print("EditpresentIds", EditAttendancePresentId)
            print("EditAbsentIds", EditAttendanceABSENTId)
            print("EditOndutyIds", EditAttendanceOnDutyId)
            print("EditOnLeaveIds", EditAttendanceOnLeaveId)
        }
    }

    @IBAction func SortBtnAct(_ sender: Any) {
        
        SortingDropdown.show()
    }
    
    func setupSortDropdown(){
        
        SortingDropdown.anchorView = SortBtn
        SortingDropdown.bottomOffset = CGPoint(x: 0, y: SortBtn.bounds.height)
       // SortingDropdown.dataSource = ["AdmisNo Asc","AdmisNo Dsc","Name A-Z", "Name Z-A", "RollNo Asc", "RollNo Dsc"]
        SortingDropdown.dataSource = ["Name A-Z", "Name Z-A", "AdmisNo Asc","AdmisNo Dsc","RegNo Asc", "RegNo Dsc"]
        
        SortingDropdown.selectionAction = { [weak self] (index,item) in
            
            self?.SortBtn.setTitle(item, for: .normal)
            self?.selectedSoringIndex = index
            self?.sortData(by: index)
        }
    }
    
    func sortData(by index: Int) {
        
        if MenuType == "9" {
            
            var filteredList = studentRef
            
            switch index {
            case 0: // Name (A–Z)
                filteredList.sort { $0.name?.localizedCaseInsensitiveCompare($1.name ?? "") == .orderedAscending }
            case 1: // Name (Z–A)
                filteredList.sort { $0.name?.localizedCaseInsensitiveCompare($1.name ?? "") == .orderedDescending }
            case 2: // Admission No (A–Z)
                filteredList.sort { $0.admissionno?.localizedStandardCompare($1.admissionno ?? "") == .orderedAscending }
            case 3: // Admission No (Z–A)
                filteredList.sort { $0.admissionno?.localizedStandardCompare($1.admissionno ?? "") == .orderedDescending }
            case 4: // Reg No (A–Z)
                filteredList.sort { $0.regno?.localizedStandardCompare($1.regno ?? "") == .orderedAscending }
            case 5: // Reg No (Z–A)
                filteredList.sort { $0.regno?.localizedStandardCompare($1.regno ?? "") == .orderedDescending }
            default:
                break
            }
            studentRef = filteredList
            
        }else if MenuType == "10"{
            
            var filteredList = attendanceEditsss
            
            switch index {
            case 0: // Name (A–Z)
                filteredList.sort { ($0.membername ?? "").localizedCaseInsensitiveCompare($1.membername ?? "") == .orderedAscending }
            case 1: // Name (Z–A)
                filteredList.sort { ($0.membername ?? "").localizedCaseInsensitiveCompare($1.membername ?? "") == .orderedDescending }
            case 2: // Admission No (A–Z)
                filteredList.sort { ($0.admissionno ?? "").localizedStandardCompare($1.admissionno ?? "") == .orderedAscending }
            case 3: // Admission No (Z–A)
                filteredList.sort { ($0.admissionno ?? "").localizedStandardCompare($1.admissionno ?? "") == .orderedDescending }
            case 4: // Reg No (A–Z)
                filteredList.sort { ($0.rollno ?? "").localizedStandardCompare($1.rollno ?? "") == .orderedAscending }
            case 5: // Reg No (Z–A)
                filteredList.sort { ($0.rollno ?? "").localizedStandardCompare($1.rollno ?? "") == .orderedDescending }
            default:
                break
            }
            
            attendanceEditsss = filteredList
        }
        
        Tv.reloadData()
        
        }
    
    
    @IBAction func selectAcademicYear(_ sender: UIButton) {
        attendanceMarkDropdown.anchorView = sender
        attendanceMarkDropdown.dataSource = ["Present", "Absent", "OD"]
        attendanceMarkDropdown.bottomOffset = CGPoint(x: 0, y: sender.bounds.height)
        attendanceMarkDropdown.show()
        
        attendanceMarkDropdown.selectionAction = { [weak self] index, item in
            sender.setTitle(item, for: .normal)
            
            guard let self = self else { return }
            
            switch index {
            case 0: // Present
                self.presentMemberIds = self.studentRef.compactMap { $0.memberid }
                self.absentMemberIds.removeAll()
                self.onDutyMemberIds.removeAll()
                
            case 1: // Absent
                self.absentMemberIds = self.studentRef.compactMap { $0.memberid }
                self.presentMemberIds.removeAll()
                self.onDutyMemberIds.removeAll()
                
            case 2: // On Duty
                self.onDutyMemberIds = self.studentRef.compactMap { $0.memberid }
                self.absentMemberIds.removeAll()
                self.presentMemberIds.removeAll()
                
            default: break
            }
            
            self.Tv.reloadData()
        }

    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        
        
        print("textviewwwwcount",textView.text)
        
        
        
        
        let height  = AttendanceTextView.contentSize.height
        
        print("fffrr",AttendanceTextView.contentSize.height)
        
        AttendanceViewHigth.constant = 250 + height-20
        
        
        if textView.text == "" {
            
            
            AttendanceViewHigth.constant = 250
            
        }
        
        
        return true
    }
    
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Enter the topic"
            textView.textColor = UIColor.lightGray
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        AttendanceTextView.resignFirstResponder()
        return true
    }
    
    @IBAction func selectedDropVc(){
        
        EditAttendanceABSENTId.removeAll()
        EditAttendancePresentId.removeAll()
        EditAttendanceOnDutyId.removeAll()
        EditAttendanceOnLeaveId.removeAll()
        
        let stringArray = attendanceHourDropRef.map(String.init)
        
        
        let myArray = stringArray
        
        dropDown.dataSource = myArray//4
        dropDown.anchorView = attendanceDropDown //5
        
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        
        dropDown.direction = .bottom
        DropDown.appearance().backgroundColor = UIColor.white
        dropDown.show() //7
        
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.attendanceDropLbl.text = item
            
            
            
            if MenuType == "10"{
                
                for i in  edit_hours {
                    
                    
                    if i.hour == Int(item){
                        AttendanceTextView.textColor = .black
                        AttendanceTextView.text = i.title
                        
                        
                        if i.type == "Practical"{
                            partialBtnName.setImage(UIImage(named: "radios"), for: .normal)
                            generalBtnName.setImage(UIImage(named: "radio-button"), for: .normal)
                            theroyBtnName.setImage(UIImage(named: "radio-button"), for: .normal)
                            typeofAttendance = "Practical"
                            
                            
                        }else if i.type == "General"{
                            
                            generalBtnName.setImage(UIImage(named: "radios"), for: .normal)
                            theroyBtnName.setImage(UIImage(named: "radio-button"), for: .normal)
                            partialBtnName.setImage(UIImage(named: "radio-button"), for: .normal)
                            typeofAttendance = "General"
                            
                            
                        }else if i.type == "Theory"{
                            
                            theroyBtnName.setImage(UIImage(named: "radios"), for: .normal)
                            generalBtnName.setImage(UIImage(named: "radio-button"), for: .normal)
                            partialBtnName.setImage(UIImage(named: "radio-button"), for: .normal)
                            typeofAttendance = "Theory"
                            
                        }
                        
                    }
                    
                    
                }
                attendanceEdits(hoursRef : item)
            }
            
            
            //
        }
        //
        //
    }
    
    
    
    
//    @IBAction func AllboxVC(gesture:CheckBoxSpecify ){
//        
//        
//        
//        if AllcheckBox.isChecked == true{
//            
//            AllcheckBox.isChecked = false
//            AllcheckBox.setImage(UIImage.init(named: "checkboxs"), for: .normal)
//            resiverId.removeLast()
//            
//            
//        } else if AllcheckBox.isChecked == false  {
//            
//            AllcheckBox.isChecked = true
//            
//            gesture.bool = true
//            AllcheckBox.setImage(UIImage.init(named: "done"), for: .normal)
//            gesture.checkBoxss.setImage(UIImage.init(named: "done"), for: .normal)
//            
//            resiverId.append(gesture.memberidssss)
//            
//            
//            nameString =  resiverId.joined(separator: "~")
//            
//        }
//        
//        
//    }
    
    
    @IBAction func allCheckboxvc(){
        
        
        
        
        if allCheckBox.isChecked == true{
            
            allCheckBox.isChecked = false
            allCheckBox.setImage(UIImage.init(named: "checkboxs"), for: .normal)
            parentChck.isChecked = false
            
            studentChck.isChecked = false
            
            
            print("wwwwwwwUNCheck")
            
            
            
            if is_parent_target_enabled == "0"{
                
                if   studentChck.isChecked == true  {
                    
                    allCheckBox.isChecked = true
                    
                    allCheckBox.setImage(UIImage.init(named: "done"), for: .normal)
                    
                }
                
            }
            
            else{
                
                
                if   studentChck.isChecked == true  && parentChck.isChecked == true{
                    
                    allCheckBox.isChecked = true
                    
                    allCheckBox.setImage(UIImage.init(named: "done"), for: .normal)
                    
                }
            }
            
        } else if allCheckBox.isChecked == false  {
            
            allCheckBox.isChecked = true
            
            //
            parentChck.isChecked = true
            
            studentChck.isChecked = true
            print("eeeeeeeeCheck")
            
            
            
            if is_parent_target_enabled == "0"{
                
                if   studentChck.isChecked == true  {
                    
                    allCheckBox.isChecked = true
                    
                    allCheckBox.setImage(UIImage.init(named: "done"), for: .normal)
                    
                }
                
            }
            
            else{
                
                
                if   studentChck.isChecked == true  && parentChck.isChecked == true{
                    
                    allCheckBox.isChecked = true
                    
                    allCheckBox.setImage(UIImage.init(named: "done"), for: .normal)
                    
                }
            }
            
            
        }
        
        
        
        
        
        
        
        
    }
    
    
    
    
    @IBAction func StudentCheckBoxVc(){
        
        
        if studentChck.isChecked == true{
            
            
            
            studentChck.isChecked = false
            //
            
            studentChck.setImage(UIImage.init(named: "checkboxs"), for: .normal)
            
            
            allCheckBox.isChecked = false
            
        }
        //
        else if studentChck.isChecked == false{
            
            
            studentChck.isChecked = true
            print("okkkd",studentChck.isChecked)
            studentChck.setImage(UIImage.init(named: "done"), for: .normal)
            
            
            if is_parent_target_enabled == "0"{
                
                if   studentChck.isChecked == true {
                    
                    allCheckBox.isChecked = true
                    
                }
                
            }
            
            else{
                
                
                if   studentChck.isChecked == true  && parentChck.isChecked == true{
                    
                    allCheckBox.isChecked = true
                    
                }
            }
            
            //
            
        }
        
        
        
        
        
    }
    
    
    @IBAction func parentCheckBoxVc(){
        
        
        
        if parentChck.isChecked == true{
            
            parentChck.isChecked = false
            parentChck.setImage(UIImage.init(named: "checkboxs"), for: .normal)
            //
            allCheckBox.isChecked = false
            
            print("UNCheck")
            
            
        } else if parentChck.isChecked == false  {
            
            parentChck.isChecked = true
            parentChck.setImage(UIImage.init(named: "done"), for: .normal)
            
            
            
            if is_parent_target_enabled == "0"{
                
                if   studentChck.isChecked == true  {
                    
                    allCheckBox.isChecked = true
                    
                }
                
            }
            
            else{
                
                
                if   studentChck.isChecked == true  && parentChck.isChecked == true {
                    
                    allCheckBox.isChecked = true
                    
                }
            }
            
            
            
            
        }
        
        
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if MenuType == "8" || MenuType == "9" || MenuType == "6" {
            
            
            return studentRef.count
            
            
        }
        
        
        else if MenuType == "10"{
            
            print("attendanceEditsss",attendanceEditsss.count)
            return attendanceEditsss.count
            
            
            
        }
        
        else{
            
            if ItemName == "Subject"  || HodYearSpefiy == "12"{
                
                print("ghkj",studentRef.count)
                return studentRef.count
                
            }
            
            else if ItemName == "Tutor"{
                
                print("tutorRefs",tutorRefs.count)
                return tutorRefs.count
                
            }
            
            
            
        }
        
        return 0
         
    }
    
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        if ItemName == "Tutor" {
            
            filtered_listTutor = clone_list
            
            if !searchText.isEmpty {
                
                isFilter = true
                
                tutorRefs = filtered_listTutor.filter {
                    
                    ($0.name ?? "").lowercased().contains(searchText.lowercased()) ||
                    ($0.memberid ?? "").lowercased().contains(searchText.lowercased()) ||
                    ($0.admissionno ?? "").lowercased().contains(searchText.lowercased())
                }
                
            } else {
                
                isFilter = false
                tutorRefs = filtered_listTutor
                print("pendingOrder")
            }
            
            if tutorRefs.count > 0 {
                
                print("searchListPendigCount", tutorRefs.count)
                Tv.alpha = 1
                
            } else {
                
                Tv.alpha = 0
            }
            
            Tv.reloadData()
        }else if ItemName == "Subject" || HodYearSpefiy == "12" {
            
            filtered_list.removeAll()
            filtered_list = clonelist2
            
            if !searchText.isEmpty {
                isFilter = true
                
                studentRef = filtered_list.filter {
                    
                    ($0.name ?? "").lowercased().contains(searchText.lowercased()) ||
                    ($0.memberid ?? "").lowercased().contains(searchText.lowercased()) ||
                    ($0.admissionno ?? "").lowercased().contains(searchText.lowercased())
                }
                
            } else {
                
                isFilter = false
                studentRef = filtered_list
                print("pendingOrder")
            }
            
            if studentRef.count > 0 {
                
                Tv.alpha = 1
                
            } else {
                
                Tv.alpha = 0
            }
            
            Tv.reloadData()
            
        } else if MenuType == "8" || MenuType == "9" || MenuType == "6" {
            
            filtered_list.removeAll()
            filtered_list = clonelist2
            
            if !searchText.isEmpty {
                
                if MenuType == "9" {
                    attendanceStack.isHidden = true
                }
                
                isFilter = true
                
                studentRef = filtered_list.filter {
                    
                    ($0.name ?? "").lowercased().contains(searchText.lowercased()) ||
                    ($0.memberid ?? "").lowercased().contains(searchText.lowercased()) ||
                    ($0.admissionno ?? "").lowercased().contains(searchText.lowercased())
                }
                
            } else {
                
                if MenuType == "9" {
                    attendanceStack.isHidden = false
                }
                
                isFilter = false
                studentRef = filtered_list
                
                print("pendingOrder")
            }
            
            if studentRef.count > 0 {
                
                print("searchListPendigCount", studentRef.count)
                Tv.alpha = 1
                
            } else {
                
                Tv.alpha = 0
            }
            
            if MenuType == "9" {
                check_MarkAll_count()
                sortData(by: selectedSoringIndex)
            }
            
            Tv.reloadData()
        }
        
        
        else if MenuType == "10"{
            
            filtered_listAttendance.removeAll()
            filtered_listAttendance = clonelist3
            
            if !searchText.isEmpty{
                
                attendanceStack.isHidden = true
                isFilter = true
                attendanceEditsss = filtered_listAttendance.filter {
                    
                    ($0.membername ?? "").lowercased().contains(searchText.lowercased()) ||
                    ($0.memberid ?? "").lowercased().contains(searchText.lowercased()) ||
                    ($0.rollno ?? "").lowercased().contains(searchText.lowercased())
                }
                
            }else{
                attendanceStack.isHidden = false
                isFilter = false
                attendanceEditsss = filtered_listAttendance
                
                print("pendingOrderMenuType")
            }
            
            if attendanceEditsss.count > 0{
                
                print ("searchListPendigCount",attendanceEditsss.count)
                
                Tv.alpha = 1
                
            }else{
                
                Tv.alpha = 0
            }
            
            
            check_MarkAll_count()
            sortData(by: selectedSoringIndex)
            Tv.reloadData()
            
        }
        
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        searchbar.endEditing(true)
        
    }
    
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchbar.resignFirstResponder()
        
    }
    
    
    
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        
        
        
        if ItemName == "Tutor"{
            searchBar.resignFirstResponder()
            
            
            print("TutorTutor",studentRef.count)
            
            Tv.alpha = 1
            
            mentorListReseponse()
            
            self.Tv.reloadData()
        }
        
        
        
        else if  ItemName == "Subject" || HodYearSpefiy == "12"{
            
            
            searchBar.resignFirstResponder()
            
            
            print("SubjectSubject",studentRef.count)
            
            Tv.alpha = 1
            
            studentListReseponse()
            
            self.Tv.reloadData()
            
        }
        
        else if MenuType == "8" ||  MenuType == "9"  ||  MenuType == "6"{
            
            
            searchBar.resignFirstResponder()
            
            
            print("SubjectSubject",studentRef.count)
            
            Tv.alpha = 1
            
            studentListReseponse()
            
            if MenuType == "9"{
                check_MarkAll_count()
            }
            
            self.Tv.reloadData()
            
        }
        
        
        else if MenuType == "10"{
            
            searchBar.resignFirstResponder()
            
            
            print("SubjectSubject",studentRef.count)
            
            Tv.alpha = 1
            
                check_MarkAll_count()
            
            self.Tv.reloadData()
            
            
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as!
        
        SpecifyStudentTableViewCell
        
        cell.selectionStyle = .none
        
        
        if  MenuType == "9"    {
            Tv.separatorStyle = .none
            cell.selectedViewAttendance.layer.cornerRadius = 10
            cell.selectedViewAttendance.layer.shadowColor = UIColor.black.cgColor
            cell.selectedViewAttendance.layer.shadowOpacity = 0.2
            cell.selectedViewAttendance.layer.shadowOffset = CGSize(width: 0, height: 2)
            cell.selectedViewAttendance.layer.shadowRadius = 2
            cell.selectedViewAttendance.layer.masksToBounds = false
            cell.SpecifyStudentChck.isHidden = true
            cell.AttenanceLetterView.isHidden = false
            cell.onDutyView.isHidden = false
            nameString = "1"
            
            let student : GetstudentListData = studentRef[indexPath.row]
        
            cell.StudentLabel.text = student.name
            cell.RollNoLbl.text = "Register No: " + (student.regno ?? "")
            cell.admissionNoLbl.text = "Admission No: " + (student.admissionno ?? "")
            cell.admissionNoLbl.isHidden = (student.admissionno ?? "").trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? true : false
            
            if presentMemberIds.contains(student.memberid ?? "") {
                cell.AttendanceAlphabet.text = "P"
                cell.AttendanceAlphabet.setFont(style: .medium, size: 20)
                cell.AttenanceLetterView.backgroundColor = .systemGreen
                cell.Switch.isOn = false
                cell.onLeaveSwitch.isOn = false
            } else if absentMemberIds.contains(student.memberid ?? "") {
                cell.AttendanceAlphabet.text = "A"
                cell.AttendanceAlphabet.setFont(style: .medium, size: 20)
                cell.AttenanceLetterView.backgroundColor = .systemRed
                cell.Switch.isOn = false
                cell.onLeaveSwitch.isOn = false
            } else if onDutyMemberIds.contains(student.memberid ?? "") {
                cell.AttendanceAlphabet.text = "OD"
                cell.AttendanceAlphabet.setFont(style: .medium, size: 15)
                cell.AttenanceLetterView.backgroundColor = .systemYellow
                cell.Switch.isOn = true
                cell.onLeaveSwitch.isOn = false
            }else if onLeaveMemberIds.contains(student.memberid ?? "") {
                cell.AttendanceAlphabet.text = "L"
                cell.AttendanceAlphabet.setFont(style: .medium, size: 20)
                cell.AttenanceLetterView.backgroundColor = .systemCyan
                cell.Switch.isOn = false
                cell.onLeaveSwitch.isOn = true
            }
            
            cell.onAttendanceTap = { [weak self] in
                guard let self = self, let memberId = student.memberid else { return }
                
                if self.presentMemberIds.contains(memberId) {
                    self.presentMemberIds.removeAll { $0 == memberId }
                    self.absentMemberIds.append(memberId)
                } else if self.absentMemberIds.contains(memberId) {
                    self.absentMemberIds.removeAll { $0 == memberId }
                    self.presentMemberIds.append(memberId)
                } else if self.onDutyMemberIds.contains(memberId) {
                    self.onDutyMemberIds.removeAll { $0 == memberId }
                    self.presentMemberIds.append(memberId)
                }else if self.onLeaveMemberIds.contains(memberId){
                    self.onLeaveMemberIds.removeAll{$0 == memberId}
                    self.presentMemberIds.append(memberId)
                }
                
                else {
                    self.presentMemberIds.append(memberId) // default to Present
                }
                
                self.Tv.reloadRows(at: [indexPath], with: .none)
                check_MarkAll_count()
            }
            
            
            cell.onDutyTap = { [weak self] in
                guard let self = self, let memberId = student.memberid else { return }
                
                if self.onDutyMemberIds.contains(memberId) {
                    // If already On Duty → move back to Present
                    self.onDutyMemberIds.removeAll { $0 == memberId }
                    self.presentMemberIds.append(memberId)
                } else {
                    // Move to On Duty
                    self.presentMemberIds.removeAll { $0 == memberId }
                    self.absentMemberIds.removeAll { $0 == memberId }
                    self.onLeaveMemberIds.removeAll { $0 == memberId }
                    self.onDutyMemberIds.append(memberId)
                }
                
                self.Tv.reloadRows(at: [indexPath], with: .none)
                check_MarkAll_count()
            }
            
            cell.onLeaveTap = { [weak self] in
                guard let self = self, let memberId = student.memberid else { return }
                
                if self.onLeaveMemberIds.contains(memberId) {
                    // If already On Duty → move back to Present
                    self.onLeaveMemberIds.removeAll { $0 == memberId }
                    self.presentMemberIds.append(memberId)
                } else {
                    // Move to On Duty
                    self.presentMemberIds.removeAll { $0 == memberId }
                    self.absentMemberIds.removeAll { $0 == memberId }
                    self.onDutyMemberIds.removeAll { $0 == memberId }
                    self.onLeaveMemberIds.append(memberId)
                }
                
                self.Tv.reloadRows(at: [indexPath], with: .none)
                check_MarkAll_count()
            }
    
            
//            cell.imageViewAttendance.image = UIImage(named: "letter-p")
//            //
//            let check = AttendanceCheckBoxSpecify(target: self, action:#selector(AttencanceCheckVc))
//            
//            check.checkBoxss = cell.SpecifyStudentChck
//            
//            check.memberidssss = student.memberid
//            check.IndicatiopnImage =   cell.imageViewAttendance
//            check.pos = indexPath.row
//            
//            cell.selectedViewAttendance.addGestureRecognizer(check)
//            //
//            cell.imageViewAttendance.image = UIImage(named: "letter-p")
//            
//            if(AttendancePresentId.contains(student.memberid)){
//                
//                cell.imageViewAttendance.image = UIImage(named: "letter-p")
//            }
//            else{
//                cell.imageViewAttendance.image = UIImage(named: "letter-a")
//                
//            }
            
        }
        
        
        
        if MenuType == "8" ||  MenuType == "6"   {
            
            cell.imageViewAttendance.isHidden = true
            cell.AttenanceLetterView.isHidden = true
            cell.onDutyView.isHidden = true
            cell.onLeaveView.isHidden = true
            cell.separatorView.isHidden = true
            cell.separatorView2.isHidden = true
            
            let student : GetstudentListData = studentRef[indexPath.row]
            
            
            cell.StudentLabel.text = student.name
            cell.RollNoLbl.text = "Register No: " + (student.regno ?? "")
            cell.admissionNoLbl.isHidden = true
            
            
            
            if student.isSelected == true
                
            {
                
                
                cell.SpecifyStudentChck.isChecked = true
                
                
                
                
            }else
            
            {
                
                cell.SpecifyStudentChck.isChecked = false
                
                
            }
            
            
            
            
           
            
            
            
            let check = CheckBoxSpecify(target: self, action:#selector(SubjectVc))
            
            
            
            check.checkBoxss = cell.SpecifyStudentChck
            
            check.memberidssss = student.memberid
            
            check.pos = indexPath.row
            
            cell.SpecifyStudentChck.addGestureRecognizer(check)
            
            if(resiverId.contains(student.memberid ?? "")){
                
                cell.SpecifyStudentChck.isChecked  = true
            }
            else{
                cell.SpecifyStudentChck.isChecked  = false
                
            }
            
            
        }
        
        else if MenuType == "10"{
            
            Tv.separatorStyle = .none
            nameString = "1"
            
            cell.selectedViewAttendance.layer.cornerRadius = 10
            cell.selectedViewAttendance.layer.shadowColor = UIColor.black.cgColor
            cell.selectedViewAttendance.layer.shadowOpacity = 0.2
            cell.selectedViewAttendance.layer.shadowOffset = CGSize(width: 0, height: 2)
            cell.selectedViewAttendance.layer.shadowRadius = 2
            cell.selectedViewAttendance.layer.masksToBounds = false
            
            let studentsAttendance : AttendanceEditDataDEtails = attendanceEditsss[indexPath.row]
            
            cell.StudentLabel.text = studentsAttendance.membername
            cell.RollNoLbl.text = "Register No: " + (studentsAttendance.rollno ?? "")
            cell.admissionNoLbl.isHidden = (studentsAttendance.admissionno ?? "").trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? true : false
            cell.admissionNoLbl.text = "Admission No: " + (studentsAttendance.admissionno ?? "")
            
            cell.SpecifyStudentChck.isHidden = true
            cell.AttenanceLetterView.isHidden = false
            cell.onDutyView.isHidden = false
            
            
            if(EditAttendancePresentId.contains(studentsAttendance.memberid ?? "")){
                cell.AttendanceAlphabet.text = "P"
                cell.AttendanceAlphabet.setFont(style: .medium, size: 20)
                cell.AttenanceLetterView.backgroundColor = .systemGreen
                cell.Switch.isOn = false
                cell.onLeaveSwitch.isOn = false
            }
            else if (EditAttendanceABSENTId.contains(studentsAttendance.memberid ?? "")) {
                cell.AttendanceAlphabet.text = "A"
                cell.AttendanceAlphabet.setFont(style: .medium, size: 20)
                cell.AttenanceLetterView.backgroundColor = .systemRed
                cell.Switch.isOn = false
                cell.onLeaveSwitch.isOn = false
            }else if (EditAttendanceOnDutyId.contains(studentsAttendance.memberid ?? "")) {
                cell.AttendanceAlphabet.text = "OD"
                cell.AttendanceAlphabet.setFont(style: .medium, size: 15)
                cell.AttenanceLetterView.backgroundColor = .systemYellow
                cell.Switch.isOn = true
                cell.onLeaveSwitch.isOn = false
            }else if (EditAttendanceOnLeaveId.contains(studentsAttendance.memberid ?? "")){
                cell.AttenanceLetterView.backgroundColor = .systemCyan
                cell.AttendanceAlphabet.setFont(style: .medium, size: 20)
                cell.AttendanceAlphabet.text = "L"
                cell.Switch.isOn = false
                cell.onLeaveSwitch.isOn = true
            }
            
            cell.onAttendanceTap = { [weak self] in
                guard let self = self, let memberId = studentsAttendance.memberid else { return }
                
                if self.EditAttendancePresentId.contains(memberId){
                    self.EditAttendancePresentId.removeAll{$0 == memberId}
                    self.EditAttendanceABSENTId.append(memberId)
                }else if self.EditAttendanceABSENTId.contains(memberId) {
                    self.EditAttendanceABSENTId.removeAll { $0 == memberId }
                    self.EditAttendancePresentId.append(memberId)
                }else if self.EditAttendanceOnDutyId.contains(memberId){
                    self.EditAttendanceOnDutyId.removeAll { $0 == memberId }
                    self.EditAttendancePresentId.append(memberId)
                }else if self.EditAttendanceOnLeaveId.contains(memberId){
                    self.EditAttendanceOnLeaveId.removeAll { $0 == memberId }
                    self.EditAttendancePresentId.append(memberId)
                }
                else {
                    self.EditAttendancePresentId.append(memberId) // default to Present
                }
                
                self.Tv.reloadRows(at: [indexPath], with: .none)
                check_MarkAll_count()
            }
            
            
            cell.onDutyTap = { [weak self] in
                    guard let self = self, let memberId = studentsAttendance.memberid else { return }
                    
                if self.EditAttendanceOnDutyId.contains(memberId) {
                        // If already On Duty → move back to Present
                        self.EditAttendanceOnDutyId.removeAll { $0 == memberId }
                    self.EditAttendancePresentId.append(memberId)
                    } else {
                        // Move to On Duty
                        self.EditAttendancePresentId.removeAll { $0 == memberId }
                        self.EditAttendanceABSENTId.removeAll { $0 == memberId }
                        self.EditAttendanceOnLeaveId.removeAll { $0 == memberId }
                        self.EditAttendanceOnDutyId.append(memberId)
                    }
                    
                    self.Tv.reloadRows(at: [indexPath], with: .none)
                check_MarkAll_count()
                }
            
            
            
            cell.onLeaveTap = { [weak self] in
                guard let self = self, let memberId = studentsAttendance.memberid else { return }
                
                if self.EditAttendanceOnLeaveId.contains(memberId) {
                    // If already On Duty → move back to Present
                    self.EditAttendanceOnLeaveId.removeAll { $0 == memberId }
                self.EditAttendancePresentId.append(memberId)
                } else {
                    // Move to On Duty
                    self.EditAttendancePresentId.removeAll { $0 == memberId }
                    self.EditAttendanceABSENTId.removeAll { $0 == memberId }
                    self.EditAttendanceOnDutyId.removeAll { $0 == memberId }
                    self.EditAttendanceOnLeaveId.append(memberId)
                }
                
                self.Tv.reloadRows(at: [indexPath], with: .none)
                check_MarkAll_count()
            }
            
            
            
            
//            let check = AttendanceCheckBoxSpecify(target: self, action:#selector(AttencanceCheckVc))
//            //
//            check.checkBoxss = cell.SpecifyStudentChck
//            
//            check.memberidssss = studentsAttendance.memberid
//            check.IndicatiopnImage =   cell.imageViewAttendance
//            check.pos = indexPath.row
//            
//            cell.selectedViewAttendance.addGestureRecognizer(check)
            
        }
        
        //
        
        
        
        else{
            
            
            if ItemName == "Subject"  || HodYearSpefiy == "12"{
                
                
                indexPathss = indexPath.row
                indexPathsections = indexPath.section
                
                let student : GetstudentListData = studentRef[indexPath.row]
                
                cell.StudentLabel.text = student.name
                cell.RollNoLbl.text = "Register No: " + (student.regno ?? "")
                cell.admissionNoLbl.isHidden = true
                
                cell.imageViewAttendance.isHidden = true
                cell.AttenanceLetterView.isHidden = true
                cell.onDutyView.isHidden = true
                cell.onLeaveView.isHidden = true
                cell.separatorView.isHidden = true
                cell.separatorView2.isHidden = true
                
                let check = CheckBoxSpecify(target: self, action:#selector(SubjectVc))
                
                //
                
                check.checkBoxss = cell.SpecifyStudentChck
                
                check.memberidssss = student.memberid
                
                check.pos = indexPath.row
                
                cell.SpecifyStudentChck.addGestureRecognizer(check)
                
                
                
                if(resiverId.contains(student.memberid ?? "")){
                    
                    cell.SpecifyStudentChck.isChecked  = true
                }
                else{
                    cell.SpecifyStudentChck.isChecked  = false
                    
                }
                
           
            }
            
            
            
            
            
            
            
            
            else if ItemName == "Tutor"{
                
                
                
                cell.imageViewAttendance.isHidden = true
                cell.AttenanceLetterView.isHidden = true
                cell.onDutyView.isHidden = true
                cell.onLeaveView.isHidden = true
                cell.separatorView.isHidden = true
                cell.separatorView2.isHidden = true
                cell.admissionNoLbl.isHidden = true
                
                
                let tutor : GetMentorstudentListData = tutorRefs[indexPath.row]
                
                
                
                cell.StudentLabel.text = tutor.name
                cell.RollNoLbl.text = "Register No: " + (tutor.regno ?? "")
                
                
                cell.imageViewAttendance.isHidden = true
                cell.AttenanceLetterView.isHidden = true
                cell.onDutyView.isHidden = true
                
                let check = CheckBoxSpecify(target: self, action:#selector(TutorVc))
                
                
                
                check.checkBoxss = cell.SpecifyStudentChck
                
                check.memberidssss = tutor.memberid
                
                check.pos = indexPath.row
                
                cell.SpecifyStudentChck.addGestureRecognizer(check)
                
                
                
                if(resiverId.contains(tutor.memberid ?? "")){
                    
                    cell.SpecifyStudentChck.isChecked  = true
                }
                else{
                    cell.SpecifyStudentChck.isChecked  = false
                    
                }
                
            }
            
            
            
        }
        
        
        
        
        return cell
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
    
    
    @IBAction func TutorVc(gestur : CheckBoxSpecify){
        
        
        
        if gestur.checkBoxss.isChecked == true{
            
            
            
            gestur.checkBoxss.isChecked = false
            
            
            
            
            
            
            
            if(resiverId.contains(gestur.memberidssss)){
                
                if let index = resiverId.firstIndex(of: gestur.memberidssss) {
                    resiverId.remove(at: index)
                }
            }
            
            
            
            
            
            if(isFilter){
                
                if filtered_list.count == resiverId.count{
                    
                    
                    selectBtn.isSelected = true
                    selectBtn.setImage(UIImage.init(named: "done"), for: .normal)
                    
                }
                
                
                else{
                    
                    selectBtn.isSelected = false
                    selectBtn.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                    
                }
            }
            
            else{
                
                if tutorRefs.count == resiverId.count{
                    
                    
                    selectBtn.isSelected = true
                    selectBtn.setImage(UIImage.init(named: "done"), for: .normal)
                    
                }
                
                
                else{
                    
                    selectBtn.isSelected = false
                    selectBtn.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                    
                }
            }
            
            
            
            
            
            
        }else{
            
            
            gestur.checkBoxss.isChecked = true
            
            
            
            
            if(!resiverId.contains(gestur.memberidssss)){
                
                resiverId.append(gestur.memberidssss)
                
            }
            
            
            
            if(isFilter){
                
                if filtered_list.count == resiverId.count{
                    
                    
                    selectBtn.isSelected = true
                    selectBtn.setImage(UIImage.init(named: "done"), for: .normal)
                    
                }
                
                
                else{
                    
                    selectBtn.isSelected = false
                    selectBtn.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                    
                }
            }
            
            else{
                
                if tutorRefs.count == resiverId.count{
                    
                    
                    selectBtn.isSelected = true
                    selectBtn.setImage(UIImage.init(named: "done"), for: .normal)
                    
                }
                
                
                else{
                    
                    selectBtn.isSelected = false
                    selectBtn.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                    
                }
            }
            
            
        }
        
        
        
    }
    
    @IBAction func AttencanceCheckVc(gestur : AttendanceCheckBoxSpecify){
        
        if MenuType == "9" {
            
            if gestur.IndicatiopnImage.image == UIImage(named: "letter-p"){
                gestur.IndicatiopnImage.image = UIImage(named: "letter-a")
                print("absentss")
                
                
                
                selectBtn.isSelected = false
                //
                selectBtn.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                AttendanceABSENTId.append(gestur.memberidssss)
                
                
                
                AttendancePresentId = AttendancePresentId.filter { !AttendanceABSENTId.contains($0) }
                
                //
                print("AttendanceABSENTIdAttendanceABSENTIdAttendanceABSENTId",AttendanceABSENTId)
                
                //
                if(isFilter){
                    
                    if filtered_list.count == AttendanceABSENTId.count{
                        
                        
                        selectBtn.isSelected = true
                        selectBtn.setImage(UIImage.init(named: "done"), for: .normal)
                        
                    }
                    
                    
                    else{
                        
                        selectBtn.isSelected = false
                        selectBtn.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                        
                    }
                }
                
                else{
                    
                    if studentRef.count == AttendanceABSENTId.count{
                        
                        
                        selectBtn.isSelected = true
                        selectBtn.setImage(UIImage.init(named: "done"), for: .normal)
                        
                    }
                    
                    
                    else{
                        
                        selectBtn.isSelected = false
                        selectBtn.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                    }
                }
            }
            
            
            else if  gestur.IndicatiopnImage.image == UIImage(named: "letter-a"){
                
                gestur.IndicatiopnImage.image = UIImage(named: "letter-p")
                
                //
                
                print("present")
                
                //
                AttendancePresentId.append(gestur.memberidssss)
                
                
                AttendanceABSENTId = AttendanceABSENTId.filter { !AttendancePresentId.contains($0) }
                
                
                print("AttendancePresentIdAttendancePresentId",AttendancePresentId)
                
                //
                
                if(isFilter){
                    
                    if filtered_list.count == AttendanceABSENTId.count{
                        
                        selectBtn.isSelected = true
                        selectBtn.setImage(UIImage.init(named: "done"), for: .normal)
                        
                    }
                    else{
                        
                        selectBtn.isSelected = false
                        selectBtn.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                        
                    }
                }
                
                else{
                    
                    if studentRef.count == AttendanceABSENTId.count{
                        
                        
                        selectBtn.isSelected = true
                        selectBtn.setImage(UIImage.init(named: "done"), for: .normal)
                        
                    } else{
                        
                        selectBtn.isSelected = false
                        selectBtn.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                    }
                }
            }
        }
        
        else if MenuType == "10"{
            
            
            
            
            
            
            if gestur.IndicatiopnImage.image == UIImage(named: "letter-p"){
                
                
                
                gestur.IndicatiopnImage.image = UIImage(named: "letter-a")
                
                
                
                EditAttendanceABSENTId.append(gestur.memberidssss)
                
                
                
                EditAttendancePresentId = EditAttendancePresentId.filter { !EditAttendanceABSENTId.contains($0) }
                //
                //
                print("PrecentUnck", EditAttendancePresentId )
                
                print("AbsenttttttUnck", EditAttendanceABSENTId )
                
                
                
                nameString = "1"
                
                
                
                
                
                
                
            }
            
            
            else if  gestur.IndicatiopnImage.image == UIImage(named: "letter-a"){
                
                gestur.IndicatiopnImage.image = UIImage(named: "letter-p")
                
                print("Attendancechexk")
                
                
                
                
                EditAttendancePresentId.append(gestur.memberidssss)
                
                
                EditAttendanceABSENTId = EditAttendanceABSENTId.filter { !EditAttendancePresentId.contains($0) }
                
                
                
                print("Abesenttttt",EditAttendanceABSENTId)
                
                nameString = "1"
                
                
                print("PreseNTttttttt",EditAttendancePresentId)
                
                
                
                
                
                
                
                
            }
            
            
        }
        
        
    }
    
    
    
    
    @IBAction func SubjectVc(gestur : CheckBoxSpecify){
        
        
        
        if gestur.checkBoxss.isChecked == true{
            
            
            
            gestur.checkBoxss.isChecked = false
            
            
            
            if(resiverId.contains(gestur.memberidssss)){
                
                if let index = resiverId.firstIndex(of: gestur.memberidssss) {
                    resiverId.remove(at: index)
                }
            }
            
            
            print("StudentIdUNNCheck",resiverId)
            
            
            if(isFilter){
                
                if filtered_list.count == resiverId.count{
                    
                    
                    selectBtn.isSelected = true
                    selectBtn.setImage(UIImage.init(named: "done"), for: .normal)
                    
                }
                
                
                else{
                    
                    selectBtn.isSelected = false
                    selectBtn.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                    
                }
            }
            
            else{
                
                if studentRef.count == resiverId.count{
                    
                    
                    selectBtn.isSelected = true
                    selectBtn.setImage(UIImage.init(named: "done"), for: .normal)
                    
                }
                
                
                else{
                    
                    selectBtn.isSelected = false
                    selectBtn.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                    
                }
            }
            
            
            
            
            
        }else{
            
            
            gestur.checkBoxss.isChecked = true
            
            
            if(!resiverId.contains(gestur.memberidssss)){
                
                resiverId.append(gestur.memberidssss)
                
            }
            
            
            print("StudentIdCheck",resiverId)
            
            
            
            if(isFilter){
                
                if filtered_list.count == resiverId.count{
                    
                    
                    selectBtn.isSelected = true
                    selectBtn.setImage(UIImage.init(named: "done"), for: .normal)
                    
                }
                
                
                else{
                    
                    selectBtn.isSelected = false
                    selectBtn.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                    
                }
            }
            
            else{
                
                if studentRef.count == resiverId.count{
                    
                    
                    selectBtn.isSelected = true
                    selectBtn.setImage(UIImage.init(named: "done"), for: .normal)
                    
                }
                
                
                else{
                    
                    selectBtn.isSelected = false
                    selectBtn.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                    
                }
            }
            
            
        }
        
        
        
    }
    
    
    func NoticeSendSmsToParticular(ImageFile: [String]) {
        
        var imageAryy: [FiletypeDataDetails] = []
        
        for i in ImageFile {
            var imageAws = FiletypeDataDetails()
            imageAws.filepath = i
            imageAws.filetype = imageFileType
            imageAryy.append(imageAws)
        }
        
        var particularNotice = NoticeBoardPartiModal()
        
        particularNotice.noticeboardid = "0"
        particularNotice.description = TextDiscrition
        particularNotice.receivertype = "7"
        particularNotice.isstaff = false
        particularNotice.isstudent = studentChck.isChecked
        
        if is_parent_target_enabled == "0" {
            particularNotice.isparent = false
        } else {
            particularNotice.isparent = parentChck.isChecked
        }
        
        particularNotice.processtype = "add"
        particularNotice.receiveridlist = nameString
        particularNotice.topic = textTitle
        particularNotice.colgid = collegeId
        particularNotice.staffid = stafId
        particularNotice.callertype = piroty
        particularNotice.files = imageAryy
        
        
        if ItemName == "Subject" || HodYearSpefiy == "12" {
            
            APiCallManager.shared.callApi(
                url: APIEndpoints.ManageNoticeBoard,
                httpMethod: .post,
                queryParam: nil,
                requestBody: particularNotice
            ) { [weak self] (result: Result<NoticePArticularResponce, Error>) in
                
                guard let self = self else { return }
                
                switch result {
                    
                case .success(let particularss):
                        
                        self.particularSms = particularss
                        
                        if particularss.Status == 1 {
                            
                            let refreshAlert = UIAlertController(title: "", message: particularss.Message, preferredStyle: .alert)
                            
                            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                                
                                if self.piroty == "p2" || self.piroty == "p3" {
                                    
                                    let vc = SenderGraditNoticeBoardMenuViewController()
                                    vc.is_read_enabled = self.is_read_enabled
                                    vc.is_write_enabled = self.is_write_enabled
                                    vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                                    vc.noticeSegments.backgroundColor = UIColor(named: "HodUnSelector")
                                    vc.noticeSegments.selectedSegmentTintColor = UIColor(named: "HodSelector")
                                    vc.str = self.strs
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
                                    vc.str = self.strs
                                    vc.strName = self.strName
                                    vc.modalPresentationStyle = .fullScreen
                                    self.present(vc, animated: true)
                                }
                            })
                            
                            self.present(refreshAlert, animated: true)
                            
                        } else {
                            
                            let refreshAlert = UIAlertController(title: "", message: particularss.Message, preferredStyle: .alert)
                            
                            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                                
                                if self.piroty == "p2" || self.piroty == "p3" {
                                    
                                    let vc = SenderGraditNoticeBoardMenuViewController()
                                    vc.is_read_enabled = self.is_read_enabled
                                    vc.is_write_enabled = self.is_write_enabled
                                    vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                                    vc.noticeSegments.backgroundColor = UIColor(named: "HodUnSelector")
                                    vc.noticeSegments.selectedSegmentTintColor = UIColor(named: "HodSelector")
                                    vc.str = self.strs
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
                                    vc.str = self.strs
                                    vc.strName = self.strName
                                    vc.modalPresentationStyle = .fullScreen
                                    self.present(vc, animated: true)
                                }
                            })
                            
                            self.present(refreshAlert, animated: true)
                        }
                    
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        } else {
            
            APiCallManager.shared.callApi(
                url: APIEndpoints.ManageNoticeBoardFromTutor,
                httpMethod: .post,
                queryParam: nil,
                requestBody: particularNotice
            ) { [weak self] (result: Result<NoticePArticularResponce, Error>) in
                
                guard let self = self else { return }
                
                switch result {
                    
                case .success(let particularss):
                        
                        self.particularSms = particularss
                        
                        if particularss.Status == 1 {
                            
                            let refreshAlert = UIAlertController(title: "", message: particularss.Message, preferredStyle: .alert)
                            
                            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                                
                                if self.piroty == "p2" || self.piroty == "p3" {
                                    
                                    let vc = SenderGraditNoticeBoardMenuViewController()
                                    vc.is_read_enabled = self.is_read_enabled
                                    vc.is_write_enabled = self.is_write_enabled
                                    vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                                    vc.noticeSegments.backgroundColor = UIColor(named: "HodUnSelector")
                                    vc.noticeSegments.selectedSegmentTintColor = UIColor(named: "HodSelector")
                                    vc.str = self.strs
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
                                    vc.str = self.strs
                                    vc.strName = self.strName
                                    vc.modalPresentationStyle = .fullScreen
                                    self.present(vc, animated: true)
                                }
                            })
                            
                            self.present(refreshAlert, animated: true)
                            
                        } else {
                            
                            let refreshAlert = UIAlertController(title: "", message: particularss.Message, preferredStyle: .alert)
                            
                            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                                
                                if self.piroty == "p2" || self.piroty == "p3" {
                                    
                                    let vc = SenderGraditNoticeBoardMenuViewController()
                                    vc.is_read_enabled = self.is_read_enabled
                                    vc.is_write_enabled = self.is_write_enabled
                                    vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                                    vc.noticeSegments.backgroundColor = UIColor(named: "HodUnSelector")
                                    vc.noticeSegments.selectedSegmentTintColor = UIColor(named: "HodSelector")
                                    vc.str = self.strs
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
                                    vc.str = self.strs
                                    vc.strName = self.strName
                                    vc.modalPresentationStyle = .fullScreen
                                    self.present(vc, animated: true)
                                }
                            })
                            
                            self.present(refreshAlert, animated: true)
                        }
                    
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
    @IBAction func sendVc(){
        
        
        if MenuType == "9" || MenuType == "10"{
            
            nameString = "1"
        } else{
            
            nameString = resiverId.joined(separator: "~")
            
        }
        
        if nameString == nil  ||  nameString ==  "" {
            
            let refreshAlert = UIAlertController(title: "", message: "Select Student", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
                
            }))
            
            
            present(refreshAlert, animated: true, completion: nil)
            
        }else{
            
            if (studentChck.isChecked == true) || (parentChck.isChecked == true){
                
                let refreshAlert = UIAlertController(title: "", message: "Are you sure you want to submit?", preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in
                    
                    if self.MenuType == "1"{
                        
                        if imageFileType == "pdf"{
                            print("rrreefdsds")
                            
                            uploadPDFFileToAWS(pdfData : pdfData! as Data as NSData)
                        }else{
                            
                            getImageURL(images: photoArray)
                            
                            DispatchQueue.main.asyncAfter(deadline: .now()+4.3) { [self] in
                                
                                KRProgressHUD.dismiss()
                                
                                self.NoticeSendSmsToParticular(ImageFile: awsArry)
                            }
                        }
                        
                    }else if self.MenuType == "2"{
                        
                        print("video")
                        
                        self.SendVideoToParticular()
                        
                    }else if self.MenuType == "3"{
                        
                        
                        print("event545454454")
                        self.EventParticular()
                    }else if self.MenuType == "4"{
                        
                        print("communication")
                        
                        self.SendSmsToParticular()
                        
                    }else if self.MenuType == "5"{
                        print("imagePdf")
                        
                        if imageFileType == "3"{
                            print("rrreefdsds")
                            
                            uploadPDFFileToAWS(pdfData : pdfData! as NSData)
                        }
                        
                        else{
                            
                            getImageURL(images: photoArray)
                            
                            DispatchQueue.main.asyncAfter(deadline: .now()+4.3) { [self] in
                                
                                KRProgressHUD.dismiss()
                                
                                ImagePdfParticular(ImageFile: awsArry)
                                
                            }
                        }
                          
                    }else if self.MenuType == "11"{
                        
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
                
                
            }else if HodYearSpefiy == "12"{
                
                let refreshAlert = UIAlertController(title: "", message: "Are you sure you want to submit?", preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "YES", style: .default, handler: { [self] (action: UIAlertAction!) in
                    
                    
                    if self.MenuType == "1"{
                        
                        
                        print("Notice")
                        
                        if imageFileType == "3"{
                            print("rrreefdsds")
                            
                            uploadPDFFileToAWS(pdfData : pdfData!  as NSData)
                        }
                        
                        else{
                            
                            getImageURL(images: photoArray)
                            
                            DispatchQueue.main.asyncAfter(deadline: .now()+4.3) { [self] in
                                
                                KRProgressHUD.dismiss()
                                
                                self.NoticeSendSmsToParticular(ImageFile: awsArry)
                            }
                        }
                        
                    }
                    
                    else if self.MenuType == "2"{
                        
                        print("video")
                        
                        self.SendVideoToParticular()
                        
                    }
                    
                    else if self.MenuType == "3"{
                        
                        
                        print("event545454454")
                        self.EventParticular()
                    }
                    
                    else if self.MenuType == "4"{
                        
                        print("communication")
                        
                        self.SendSmsToParticular()
                        
                    }else if self.MenuType == "5"{
                        print("imagePdf")
                        
                        if imageFileType == "3"{
                            print("rrreefdsds")
                            
                            uploadPDFFileToAWS(pdfData : pdfData!  as NSData)
                            
                        }
                        
                        else{
                            
                            
                            getImageURL(images: photoArray)
                            
                            DispatchQueue.main.asyncAfter(deadline: .now()+4.3) { [self] in
                                
                                KRProgressHUD.dismiss()
                                
                                ImagePdfParticular(ImageFile: awsArry)
                                
                            }
                            
                        }
                        
                    }else if self.MenuType == "11"{
                        
                        if VoiceHstryId == "1"{
                            
                            self.multypartAudio()
                        }else if VoiceHstryId == "2"{
                            
                            self.HistoryVoiceSendParticular()
                        }
                        
                    }
                    
                    
                }))
                
                
                refreshAlert.addAction(UIAlertAction(title: "NO", style: .cancel, handler: { (action: UIAlertAction!) in
                    print("Handle Cancel Logic here")
                }))
                
                present(refreshAlert, animated: true, completion: nil)
                 
                
            }
            
            else if self.MenuType == "10"{
                
                
                if attendanceDropLbl.text == "Select hours"{
                    
                    let refreshAlert = UIAlertController(title: "Enter the Attendance Hour", message: "Click ok to confirm", preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        
                        
                    }))
                    
                    present(refreshAlert, animated: true, completion: nil)
                }
                
                
                else{
                    
                    let counts = String(EditAttendanceABSENTId.count)
                    
                    let refreshAlert = UIAlertController(title: "Total absent students : " + counts, message: "Click ok to confirm", preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in
                        
                        self.editAttendMark()
                        
                    }))
                    
                    
                    refreshAlert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: { [self] (action: UIAlertAction!) in
                        print("Handle Cancel Logic here")
                        
                        print("AttendanceTextView.textAttendanceTextView.text",AttendanceTextView.text)
                        
                        print("typeofAttendancetypeofAttendance",typeofAttendance)
                        
                    }))
                    
                    present(refreshAlert, animated: true, completion: nil)
                    
                }
                
            }else if self.MenuType == "9"{
                
                if attendanceDropLbl.text == "Select hours"{
                    
                    let refreshAlert = UIAlertController(title: "Enter the Attendance Hour", message: "Click ok to confirm", preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        
                    }))
                    
                    present(refreshAlert, animated: true, completion: nil)
                }else{
                    let counts = String(absentMemberIds.count)
                    
                    let refreshAlert = UIAlertController(title: "Total absent students : " + counts, message: "Click ok to confirm", preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        
                        self.attendanceMarking()
                        
                    }))
                    
                    
                    refreshAlert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: { (action: UIAlertAction!) in
                        print("Handle Cancel Logic here")
                        
                    }))
                    
                    present(refreshAlert, animated: true, completion: nil)
                    
                }
            }else{
                
                if  MenuType == "6"  ||  HodYearSpefiy == "12"{
                    
                    
                    let refreshAlert = UIAlertController(title: "", message: "Are you sure you want to submit?", preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in
                        
                        
                        if AssigmentFileType == "pdf"{
                            
                            
                            uploadPDFFileToAWS(pdfData: pdfData! as NSData)
                            
                        }
                        
                        else if AssigmentFileType == "Text"{
                            
                            assigmentText()
                            
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
                    
                    present(refreshAlert, animated: true, completion: nil)
                    
                }
                if  MenuType == "8" ||  HodYearSpefiy == "12" {
                    
                    
                    let refreshAlert = UIAlertController(title: "", message: "Are you sure you want to submit?", preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in
                        
                        if AssigmentFileType == "pdf"{
                            
                            uploadPDFFileToAWS(pdfData: pdfData! as NSData)
                            
                        }
                        
                        else if AssigmentFileType == "Text"{
                            
                            assigmentText()
                            
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
                    
                    present(refreshAlert, animated: true, completion: nil)
                     
                }
                
                let refreshAlert = UIAlertController(title: "", message: "Select Target", preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    
                }))
                
                present(refreshAlert, animated: true, completion: nil)
                 
            }
            
        }
        
    }
    
    
    func HistoryVoiceSendParticular() {
        
        var voiceUpload = VoiceHstryModal()
        
        voiceUpload.staffid = stafId
        voiceUpload.description = TextDiscrition
        voiceUpload.callertype = piroty
        voiceUpload.collegeid = collegeId
        voiceUpload.forwarding_voice_id = voiceHstryHeaderId
        voiceUpload.receiverid =  nameString
        voiceUpload.receivertype = resiverType
        if is_parent_target_enabled == "0"{
            
            voiceUpload.isparent = false
        }else{
             
            voiceUpload.isparent = parentChck.isChecked
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
                        
                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] (action: UIAlertAction!) in
                            
                            if self?.piroty == "p2" || self?.piroty == "p3" {
                                
                                let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
                                vc.is_read_enabled = "1"
                                vc.is_write_enabled = "1"
                                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                                
                                vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
                                vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                                vc.strName = self?.strName ?? []
                                vc.str = self?.strs ?? []
                                
                                vc.modalPresentationStyle = .fullScreen
                                self?.present(vc, animated: true , completion: nil)
                                
                            }else  if self?.piroty == "p7" {
                                
                                let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
                                vc.is_read_enabled = "1"
                                vc.is_write_enabled = "1"
                                vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
                                
                                vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
                                vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                                vc.strName = self?.strName ?? []
                                vc.str = self?.strs ?? []
                                
                                vc.modalPresentationStyle = .fullScreen
                                self?.present(vc, animated: true , completion: nil)
                            }else{
                                
                                let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
                                vc.is_read_enabled = "1"
                                vc.is_write_enabled = "1"
                                vc.view.backgroundColor = UIColor(named: "Principal" )
                                
                                vc.CommuniSegementName.backgroundColor = UIColor(named: "UnSelector")
                                vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "Selector")
                                
                                vc.strName = self?.strName ?? []
                                vc.str = self?.strs ?? []
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
    
    
    
    
    
//    func multypartAudio() {
//        
//        var vimeoVideoEndpoint = "https://gradit.voicesnap.com/api/AppDetailsBal/SendFileToParticularType"
//        var vimeoVideoEndpointTutor = "https://gradit.voicesnap.com/api/AppDetailsBal/SendFileToParticularTypeFromTutor"
//        
//        
//        var voiceUpload = particularVoiceUploadMoad()
//        
//        voiceUpload.staffid = stafId
//        voiceUpload.description = TextDiscrition
//        voiceUpload.callertype = piroty
//        voiceUpload.collegeid = collegeId
//        voiceUpload.fileduration = voiceDuration
//        voiceUpload.filetype = "1"
//        voiceUpload.isemergencyvoice = voiceReplyType
//        
//        if is_parent_target_enabled == "0"{
//            
//            voiceUpload.isparent = false
//            
//        } else{
//            
//            voiceUpload.isparent = parentChck.isChecked
//        }
//        
//        voiceUpload.isstaff = false
//        voiceUpload.isstudent = studentChck.isChecked
//        voiceUpload.receiverid = nameString
//        voiceUpload.receivertype = resiverType
//        
//        
//        let voiceUploadStr = voiceUpload.toJSONString()
//        
//        print("voiceUploadStr",voiceUploadStr)
//        //
//        
//        if ItemName == "Subject" || HodYearSpefiy == "12"{
//            
//            AF.upload(multipartFormData: { [self] (multipartFormData) in
//                KRProgressHUD.show()
//                
//                var videoU : String!
//                
//                let pathURL = voiceURl
//                
//                let pathString = pathURL!.path
//                
//                multipartFormData.append(URL(fileURLWithPath: pathString), withName: "file")
//                
//                multipartFormData.append(Data(voiceUploadStr!.description.utf8), withName: "info")
//                
//                print("parameters.description.utf8",voiceUploadStr!.description.utf8)
//                
//            },to: vimeoVideoEndpoint).responseJSON{
//                //
//                res in
//                
//                
//                KRProgressHUD.dismiss()
//                
//                let json_str = String(data: res.data!, encoding: .utf8)
//                
//                print("json \(json_str!)")
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
//                                    if piroty == "p2" || piroty == "p3" {
//                                        
//                                        let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
//                                        vc.is_read_enabled = is_read_enabled
//                                        vc.is_write_enabled = is_write_enabled
//                                        
//                                        vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
//                                        
//                                        vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
//                                        vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
//                                        vc.strName = self.strName
//                                        vc.str = self.strs
//                                        
//                                        vc.modalPresentationStyle = .fullScreen
//                                        self.present(vc, animated: true , completion: nil)
//                                        
//                                    } else{
//                                        
//                                        let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
//                                        vc.is_read_enabled = is_read_enabled
//                                        vc.is_write_enabled = is_write_enabled
//                                        
//                                        vc.view.backgroundColor = UIColor(named: "Principal" )
//                                        
//                                        vc.CommuniSegementName.backgroundColor = UIColor(named: "UnSelector")
//                                        vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "Selector")
//                                        
//                                        vc.strName = self.strName
//                                        vc.str = self.strs
//                                        
//                                        
//                                        vc.modalPresentationStyle = .fullScreen
//                                        self.present(vc, animated: true , completion: nil)
//                                        
//                                    }
//                                    
//                                }))
//                                
//                                self.present(refreshAlert, animated: true, completion: nil)
//                                   
//                            }else {
//                                
//                                let a = json["Message"]
//                                
//                                let refreshAlert = UIAlertController(title: "", message: a as! String, preferredStyle: UIAlertController.Style.alert)
//                                
//                                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in
//                                    
//                                    
//                                    if piroty == "p2" || piroty == "p3" {
//                                        
//                                        let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
//                                        vc.is_read_enabled = is_read_enabled
//                                        vc.is_write_enabled = is_write_enabled
//                                        
//                                        vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
//                                        
//                                        vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
//                                        vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
//                                        vc.strName = self.strName
//                                        vc.str = self.strs
//                                        
//                                        
//                                        vc.modalPresentationStyle = .fullScreen
//                                        self.present(vc, animated: true , completion: nil)
//                                        
//                                    } else{
//                                        
//                                        let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
//                                        vc.is_read_enabled = is_read_enabled
//                                        vc.is_write_enabled = is_write_enabled
//                                        
//                                        vc.view.backgroundColor = UIColor(named: "Principal" )
//                                        
//                                        vc.CommuniSegementName.backgroundColor = UIColor(named: "UnSelector")
//                                        vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "Selector")
//                                        
//                                        vc.strName = self.strName
//                                        vc.str = self.strs
//                                        
//                                        vc.modalPresentationStyle = .fullScreen
//                                        self.present(vc, animated: true , completion: nil)
//                                        
//                                    }
//                                    
//                                }))
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
//        } else{
//            
//            AF.upload(multipartFormData: { [self] (multipartFormData) in
//                KRProgressHUD.show()
//                
//                var videoU : String!
//                
//                let pathURL = voiceURl
//                
//                let pathString = pathURL!.path
//                
//                multipartFormData.append(URL(fileURLWithPath: pathString), withName: "file")
//                
//                multipartFormData.append(Data(voiceUploadStr!.description.utf8), withName: "info")
//                
//                print("parameters.description.utf8",voiceUploadStr!.description.utf8)
//                
//                
//            },to: vimeoVideoEndpointTutor).responseJSON{
//                //
//                res in
//                
//                KRProgressHUD.dismiss()
//                
//                let json_str = String(data: res.data!, encoding: .utf8)
//                
//                print("json \(json_str!)")
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
//                                    if piroty == "p2" || piroty == "p3" {
//                                        
//                                        let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
//                                        vc.is_read_enabled = is_read_enabled
//                                        vc.is_write_enabled = is_write_enabled
//                                        
//                                        vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
//                                        
//                                        vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
//                                        vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
//                                        vc.strName = self.strName
//                                        vc.str = self.strs
//                                        
//                                        vc.modalPresentationStyle = .fullScreen
//                                        self.present(vc, animated: true , completion: nil)
//                                        
//                                    }else{
//                                        
//                                        let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
//                                        vc.is_read_enabled = is_read_enabled
//                                        vc.is_write_enabled = is_write_enabled
//                                        
//                                        vc.view.backgroundColor = UIColor(named: "Principal" )
//                                        
//                                        vc.CommuniSegementName.backgroundColor = UIColor(named: "UnSelector")
//                                        vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "Selector")
//                                        
//                                        vc.strName = self.strName
//                                        vc.str = self.strs
//                                        
//                                        
//                                        vc.modalPresentationStyle = .fullScreen
//                                        self.present(vc, animated: true , completion: nil)
//                                        
//                                    }
//                                    
//                                    
//                                }))
//                                
//                                self.present(refreshAlert, animated: true, completion: nil)
//                                
//                            }
//                            else {
//                                
//                                let a = json["Message"]
//                                
//                                let refreshAlert = UIAlertController(title: "", message: a as! String, preferredStyle: UIAlertController.Style.alert)
//                                
//                                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in
//                                    
//                                    
//                                    if piroty == "p2" || piroty == "p3" {
//                                        
//                                        let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
//                                        vc.is_read_enabled = is_read_enabled
//                                        vc.is_write_enabled = is_write_enabled
//                                        
//                                        vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
//                                        
//                                        vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
//                                        vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
//                                        vc.strName = self.strName
//                                        vc.str = self.strs
//                                        vc.is_read_enabled = is_read_enabled
//                                        vc.is_write_enabled = is_write_enabled
//                                        
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
//                                        vc.str = self.strs
//                                        
//                                        vc.modalPresentationStyle = .fullScreen
//                                        self.present(vc, animated: true , completion: nil)
//                                        
//                                    }
//                                    
//                                }))
//                                
//                                self.present(refreshAlert, animated: true, completion: nil)
//                                
//                            }
//                        }
//                    }
//                } catch {
//                    print("Error parsing JSON: \(error)")
//                }
//            }
//        }
//    }
    
    func multypartAudio() {
        
        let vimeoVideoEndpoint = "https://gradit.voicesnap.com/api/AppDetailsBal/SendFileToParticularType"
        let vimeoVideoEndpointTutor = "https://gradit.voicesnap.com/api/AppDetailsBal/SendFileToParticularTypeFromTutor"
        
        var voiceUpload = particularVoiceUploadMoad()
        
        voiceUpload.staffid = stafId
        voiceUpload.description = TextDiscrition
        voiceUpload.callertype = piroty
        voiceUpload.collegeid = collegeId
        voiceUpload.fileduration = voiceDuration
        voiceUpload.filetype = "1"
        voiceUpload.isemergencyvoice = voiceReplyType
        
        if is_parent_target_enabled == "0"{
            voiceUpload.isparent = false
        } else{
            voiceUpload.isparent = parentChck.isChecked
        }
        
        voiceUpload.isstaff = false
        voiceUpload.isstudent = studentChck.isChecked
        voiceUpload.receiverid = nameString
        voiceUpload.receivertype = resiverType
        
        // ✅ Codable conversion
        let voiceUploadStr: String
        do {
            let jsonData = try JSONEncoder().encode(voiceUpload)
            voiceUploadStr = String(data: jsonData, encoding: .utf8) ?? ""
        } catch {
            print("Encoding error:", error)
            return
        }
        
        print("voiceUploadStr", voiceUploadStr)
        
        let isMainAPI = (ItemName == "Subject" || HodYearSpefiy == "12")
        let finalURL = isMainAPI ? vimeoVideoEndpoint : vimeoVideoEndpointTutor
        
        KRProgressHUD.show()
        
        MultipartManager.shared.uploadVoice(
            url: finalURL,
            fileURL: voiceURl!,
            infoJSONString: voiceUploadStr,
            
            
        ) { [weak self] result in
            
            guard let self = self else { return }
            
            KRProgressHUD.dismiss()
            
            switch result {
                
            case .success(let json):
                
                print("json \(json)")
                
                if let status = json["Status"] as? Int {
                    print("Status: \(status)")
                    
                    DispatchQueue.main.async {
                        
                        let message = json["Message"] as! String
                        
                        let refreshAlert = UIAlertController(title: "", message: message, preferredStyle: .alert)
                        
                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
                            
                            guard let self = self else { return }
                            
                            if piroty == "p2" || piroty == "p3" {
                                
                                let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
                                vc.is_read_enabled = is_read_enabled
                                vc.is_write_enabled = is_write_enabled
                                vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                                vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
                                vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                                vc.strName = self.strName
                                vc.str = self.strs
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
                                vc.str = self.strs
                                vc.modalPresentationStyle = .fullScreen
                                self.present(vc, animated: true)
                            }
                        }))
                        
                        self.present(refreshAlert, animated: true)
                    }
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func SendVideoToParticular() {
        
        var uploadvideo = ParticularVideoUploadModal()
        
        uploadvideo.callertype = piroty
        uploadvideo.url = videoUrl
        uploadvideo.collegeid = collegeId
        uploadvideo.description = TextDiscrition
        uploadvideo.iframe = iframeVideo
        
        if is_parent_target_enabled == "0"{
            uploadvideo.isparent = false
        } else{
            uploadvideo.isparent = parentChck.isChecked
        }
        
        uploadvideo.isstaff = false
        uploadvideo.isstudent = studentChck.isChecked
        uploadvideo.staffid = stafId
        uploadvideo.title = textTitle
        uploadvideo.receiverid = nameString
        uploadvideo.receivertype = resiverType
        
        print("yearAndSectionModalStr", uploadvideo)
        
        
        if ItemName == "Subject" || HodYearSpefiy == "12" {
            
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
                        
                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default){ _ in
                            
                            if self.piroty == "p2" || self.piroty == "p3" {
                                
                                let vc = SenderVideoHomePageViewController()
                                vc.is_read_enabled = self.is_read_enabled
                                vc.is_write_enabled = self.is_write_enabled
                                vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                                vc.str = self.strs
                                vc.strName = self.strName
                                vc.modalPresentationStyle = .fullScreen
                                self.present(vc, animated: true)
                                
                            } else {
                                
                                let vc = SenderVideoHomePageViewController()
                                vc.is_read_enabled = self.is_read_enabled
                                vc.is_write_enabled = self.is_write_enabled
                                vc.view.backgroundColor = UIColor(named: "Principal")
                                vc.str = self.strs
                                vc.strName = self.strName
                                vc.modalPresentationStyle = .fullScreen
                                self.present(vc, animated: true)
                            }
                        })
                        
                        self.present(refreshAlert, animated: true)
                        
                    } else {
                        
                        let refreshAlert = UIAlertController(title: "", message: particular.Message, preferredStyle: .alert)
                        
                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default){ _ in
                            
                            if self.piroty == "p2" || self.piroty == "p3" {
                                
                                let vc = SenderVideoHomePageViewController()
                                vc.is_read_enabled = self.is_read_enabled
                                vc.is_write_enabled = self.is_write_enabled
                                vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                                vc.str = self.strs
                                vc.strName = self.strName
                                vc.modalPresentationStyle = .fullScreen
                                self.present(vc, animated: true)
                                
                            } else {
                                
                                let vc = SenderVideoHomePageViewController()
                                vc.is_read_enabled = self.is_read_enabled
                                vc.is_write_enabled = self.is_write_enabled
                                vc.view.backgroundColor = UIColor(named: "Principal")
                                vc.str = self.strs
                                vc.strName = self.strName
                                vc.modalPresentationStyle = .fullScreen
                                self.present(vc, animated: true)
                            }
                        })
                        
                        self.present(refreshAlert, animated: true)
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
                        
                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default){ _ in
                            
                            if self.piroty == "p2" || self.piroty == "p3" {
                                
                                let vc = SenderVideoHomePageViewController()
                                vc.is_read_enabled = self.is_read_enabled
                                vc.is_write_enabled = self.is_write_enabled
                                vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                                vc.str = self.strs
                                vc.strName = self.strName
                                vc.modalPresentationStyle = .fullScreen
                                self.present(vc, animated: true)
                                
                            } else {
                                
                                let vc = SenderVideoHomePageViewController()
                                vc.is_read_enabled = self.is_read_enabled
                                vc.is_write_enabled = self.is_write_enabled
                                vc.view.backgroundColor = UIColor(named: "Principal")
                                vc.str = self.strs
                                vc.strName = self.strName
                                vc.modalPresentationStyle = .fullScreen
                                self.present(vc, animated: true)
                            }
                        })
                        
                        self.present(refreshAlert, animated: true)
                        
                    } else {
                        
                        let refreshAlert = UIAlertController(title: "", message: particular.Message, preferredStyle: .alert)
                        
                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default){ _ in
                            
                            if self.piroty == "p2" || self.piroty == "p3" {
                                
                                let vc = SenderVideoHomePageViewController()
                                vc.is_read_enabled = self.is_read_enabled
                                vc.is_write_enabled = self.is_write_enabled
                                vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                                vc.str = self.strs
                                vc.strName = self.strName
                                vc.modalPresentationStyle = .fullScreen
                                self.present(vc, animated: true)
                                
                            } else {
                                
                                let vc = SenderVideoHomePageViewController()
                                vc.is_read_enabled = self.is_read_enabled
                                vc.is_write_enabled = self.is_write_enabled
                                vc.view.backgroundColor = UIColor(named: "Principal")
                                vc.str = self.strs
                                vc.strName = self.strName
                                vc.modalPresentationStyle = .fullScreen
                                self.present(vc, animated: true)
                            }
                        })
                        
                        self.present(refreshAlert, animated: true)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
    func EventParticular(){
        
        var particular = EventParticualrModal()
        
        print("events")
        particular.eventid = "0"
        
        particular.eventbody = TextDiscrition
        particular.eventdate = eventDate
        particular.eventvenue = eventVenu
        particular.eventtime = EventTime
        particular.eventtopic = textTitle
        
        particular.processtype = "add"
        particular.collegeid = collegeId
        particular.staffid = stafId
        particular.Callertype = piroty
        particular.receivertype = resiverType
        
        if is_parent_target_enabled == "0"{
            particular.isparent = false
        } else {
            particular.isparent = parentChck.isChecked
        }
        
        particular.isstaff = false
        particular.isstudent = studentChck.isChecked
        particular.receiveridlist = nameString
        
        
        if ItemName == "Subject" || HodYearSpefiy == "12"{
            
            APiCallManager.shared.callApi(
                url: APIEndpoints.ManageEvents,
                httpMethod: .post,
                queryParam: nil,
                requestBody: particular
            ) { [weak self] (result: Result<[EventParticularResponce], Error>) in
                
                guard let self = self else { return }
                
                switch result {
                    
                case .success(let response):
                    
                    for i in response{
                        
                        if i.Status == 1 {
                            
                            let refreshAlert = UIAlertController(title: "", message: i.Message, preferredStyle: .alert)
                            
                            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default){ _ in
                                
                                if self.piroty == "p2" || self.piroty == "p3" {
                                    
                                    let vc = SenderEventHomePageViewController()
                                    vc.is_read_enabled = self.is_read_enabled
                                    vc.is_write_enabled = self.is_write_enabled
                                    vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                                    vc.eventSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                                    vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                                    vc.str = self.strs
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
                                    vc.str = self.strs
                                    vc.strName = self.strName
                                    vc.modalPresentationStyle = .fullScreen
                                    self.present(vc, animated: true)
                                }
                            })
                            
                            self.present(refreshAlert, animated: true)
                            
                            self.Tv.dataSource = self
                            self.Tv.delegate = self
                            self.Tv.reloadData()
                            
                        } else {
                            
                            let refreshAlert = UIAlertController(title: "", message: i.Message, preferredStyle: .alert)
                            
                            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default){ _ in
                                
                                if self.piroty == "p2" || self.piroty == "p3" {
                                    
                                    let vc = SenderEventHomePageViewController()
                                    vc.is_read_enabled = self.is_read_enabled
                                    vc.is_write_enabled = self.is_write_enabled
                                    vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                                    vc.eventSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                                    vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                                    vc.str = self.strs
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
                                    vc.str = self.strs
                                    vc.strName = self.strName
                                    vc.modalPresentationStyle = .fullScreen
                                    self.present(vc, animated: true)
                                }
                            })
                            
                            self.present(refreshAlert, animated: true)
                        }
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        } else {
            
            print("particularStr", particular)
            
            APiCallManager.shared.callApi(
                url: APIEndpoints.ManageEventsFromTutor,
                httpMethod: .post,
                queryParam: nil,
                requestBody: particular
            ) { [weak self] (result: Result<[EventParticularResponce], Error>) in
                
                guard let self = self else { return }
                
                switch result {
                    
                case .success(let response):
                    
                    for i in response{
                        
                        if i.Status == 1 {
                            
                            let refreshAlert = UIAlertController(title: "", message: i.Message, preferredStyle: .alert)
                            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default))
                            self.present(refreshAlert, animated: true)
                            
                        } else {
                            
                            let refreshAlert = UIAlertController(title: "", message: i.Message, preferredStyle: .alert)
                            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default))
                            self.present(refreshAlert, animated: true)
                        }
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func studentListReseponse() {
        
        var studentModal = GetstudentListforappModal()
        
        studentModal.staffid = stafId
        studentModal.collegeid = collegeId
        studentModal.courseid = courseId
        studentModal.dept_id = departmentId
        studentModal.sectionid = sectionId
        studentModal.yearid = YearId
        studentModal.subjectid = subjectIdForStuddent
        
        APiCallManager.shared.callApi(
                url: APIEndpoints.GetstudentListforapp,
                httpMethod: .post,
                queryParam: nil,
                requestBody: studentModal
            ) {[weak self] (result:Result<GetstudentListforappResponse, Error>) in
                    
                guard let self = self else { return }
                
                switch result {
                case .success(let success):
                    if success.Status == 1 {
                        
                        studentRef = success.data ?? []
                        clonelist2 = success.data ?? []
                        
                        presentMemberIds =  success.data?.compactMap {$0.memberid} ?? []
                        
                        for i in success.data ?? []{
                            
                            AttendancePresentId.append(i.memberid ?? "")
                        }
                        
                        check_MarkAll_count()
                        print("Present List",AttendancePresentId)
                        Tv.delegate = self
                        Tv.dataSource = self
                        Tv.reloadData()
                        
                    }else{
                        
                        let refreshAlert = UIAlertController(title: "", message: success.Message, preferredStyle: UIAlertController.Style.alert)
                        
                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                            
                        }))
                        
                        self.present(refreshAlert, animated: true, completion: nil)
                        
                        Tv.delegate = self
                        Tv.dataSource = self
                        Tv.reloadData()
                    }
                case .failure(let failure):
                     print("Error:",failure.localizedDescription)
                }
                
                }
    }
    
    func mentorListReseponse() {

        var mentorModal = GetMentorstudentListforappModal()

        mentorModal.collegeid = collegeId
        mentorModal.staffid = stafId
        mentorModal.deptid = departmentId
        mentorModal.sectionid = sectionId
        mentorModal.yearid = YearId

        print("mentorModalStr", mentorModal)

        APiCallManager.shared.callApi(
            url: APIEndpoints.GetMentorstudentListforapp,
            httpMethod: .post,
            queryParam: nil,
            requestBody: mentorModal
        ) { [weak self] (result: Result<GetMentorstudentListforappResponse, Error>) in

            guard let self = self else { return }

            switch result {

            case .success(let mentorModalResponse):

                if mentorModalResponse.Status == 1 {

                    self.tutorRefs = mentorModalResponse.data ?? []
                    self.clone_list = mentorModalResponse.data ?? []
                    self.Tv.delegate = self
                    self.Tv.dataSource = self
                    self.Tv.reloadData()

                } else {

                    let refreshAlert = UIAlertController(
                        title: "",
                        message: mentorModalResponse.Message,
                        preferredStyle: UIAlertController.Style.alert
                    )

                    refreshAlert.addAction(
                        UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        })
                    )

                    self.present(refreshAlert, animated: true, completion: nil)

                    self.Tv.delegate = self
                    self.Tv.dataSource = self
                    self.Tv.reloadData()
                }

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    func SendSmsToParticular() {
        
        var particular = SendSmsToParticularModal()
        
        particular.collegeid = collegeId
        particular.staffid = stafId
        particular.description = textTitle
        particular.callertype = piroty
        particular.receivertype = resiverType
        
        if is_parent_target_enabled == "0"{
            
            particular.isparent = false
        }else{
            particular.isparent = parentChck.isChecked
        }
        
        particular.isstaff = false
        particular.isstudent = studentChck.isChecked
        particular.receiverid = nameString
        particular.messagecontent = TextDiscrition
        particular.filetype = "1"
    
        
//        let particularStr = particular.toJSONString()
//        print("yearAndSectionModalStr12",particularStr)
        
        if ItemName == "Subject" || HodYearSpefiy == "12"{
            
            
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
                            
                            particularComuniSms  = particular.data ?? []
                            
                            let refreshAlert = UIAlertController(title: "", message: particular.Message, preferredStyle: UIAlertController.Style.alert)
                            
                            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] (action: UIAlertAction!) in
                                
                                if self?.piroty == "p2" || self?.piroty == "p3" {
                                    
                                    let vc = CommuniSMSViewController(nibName: nil, bundle: nil)
                                    vc.is_read_enabled = self?.is_read_enabled ?? ""
                                    vc.is_write_enabled = self?.is_write_enabled ?? ""
                                    vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                                    
                                    vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
                                    vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                                    
                                    vc.str = self?.strs ?? []
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
                                    
                                    vc.str = self?.strs ?? []
                                    vc.strName = self?.strName ?? []
                                    vc.modalPresentationStyle = .fullScreen
                                    self?.present(vc, animated: true , completion: nil)
                                    
                                }
                            }))
                            
                            self.present(refreshAlert, animated: true, completion: nil)
                             
                        }else{
                            
                            
                            let refreshAlert = UIAlertController(title: "", message: particular.Message, preferredStyle: UIAlertController.Style.alert)
                            
                            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] (action: UIAlertAction!) in
                                
                                if self?.piroty == "p2" || self?.piroty == "p3" {
                                    
                                    let vc = CommuniSMSViewController(nibName: nil, bundle: nil)
                                    vc.is_read_enabled = self?.is_read_enabled ?? ""
                                    vc.is_write_enabled = self?.is_write_enabled ?? ""
                                    vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                                    
                                    vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
                                    vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                                    
                                    vc.str = self?.strs ?? []
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
                                    
                                    vc.str = self?.strs ?? []
                                    vc.strName = self?.strName ?? []
                                    
                                    vc.modalPresentationStyle = .fullScreen
                                    self?.present(vc, animated: true , completion: nil)
                                    
                                }
                                
                            }))
                            
                            self.present(refreshAlert, animated: true, completion: nil)
                              
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
                            
                            particularComuniSms  = particular.data ?? []
                            
                            
                            let refreshAlert = UIAlertController(title: "", message: particular.Message, preferredStyle: UIAlertController.Style.alert)
                            
                            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: {[weak self] (action: UIAlertAction!) in
                                
                                
                                if self?.piroty == "p2" || self?.piroty == "p3" {
                                    
                                    let vc = CommuniSMSViewController(nibName: nil, bundle: nil)
                                    vc.is_read_enabled = self?.is_read_enabled ?? ""
                                    vc.is_write_enabled = self?.is_write_enabled ?? ""
                                    vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                                    
                                    vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
                                    vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                                    
                                    vc.str = self?.strs ?? []
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
                                    
                                    vc.str = self?.strs ?? []
                                    vc.strName = self?.strName ?? []
                                    
                                    vc.modalPresentationStyle = .fullScreen
                                    self?.present(vc, animated: true , completion: nil)
                                    
                                }
                                
                            }))
                            
                            self.present(refreshAlert, animated: true, completion: nil)
                              
                        }else{
                            
                            let refreshAlert = UIAlertController(title: "", message: particular.Message, preferredStyle: UIAlertController.Style.alert)
                            
                            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: {[weak self] (action: UIAlertAction!) in
                                
                                if self?.piroty == "p2" || self?.piroty == "p3" {
                                    
                                    let vc = CommuniSMSViewController(nibName: nil, bundle: nil)
                                    vc.is_read_enabled = self?.is_read_enabled ?? ""
                                    vc.is_write_enabled = self?.is_write_enabled ?? ""
                                    vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                                    
                                    vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
                                    vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                                    
                                    vc.str = self?.strs ?? []
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
                                    
                                    vc.str = self?.strs ?? []
                                    vc.strName = self?.strName ?? []
                                    
                                    vc.modalPresentationStyle = .fullScreen
                                    self?.present(vc, animated: true , completion: nil)
                                    
                                }
                                
                                
                            }))
                            self.present(refreshAlert, animated: true, completion: nil)
                            
                        }
                        
                    case .failure(let failure):
                         print("Error:",failure.localizedDescription)
                    }
                    
                    }

        }
    }
    
    
    func assigmentText(){
        
        if MenuType == "6"{
            
            var assigmet : [FileNameArray] = []
            
            for i in awsArry{
                var imagePdfFileArry = FileNameArray()
                imagePdfFileArry.FileName = i
                assigmet.append(imagePdfFileArry)
            }
            
            var imagePdf = assigmentImagePdfModal()
            
            imagePdf.collegeid = collegeId
            imagePdf.sectionid = sectionId
            imagePdf.processtype = "add"
            imagePdf.staffid = stafId
            imagePdf.assignmentdescription = TextDiscrition
            imagePdf.assignmentid = "0"
            imagePdf.assignmenttopic = textTitle
            imagePdf.assignmenttype = AssigmentFileType
            imagePdf.callertype = piroty
            imagePdf.courseid = courseId
            imagePdf.receiverid = nameString
            imagePdf.receivertype = "2"
            imagePdf.deptid = departmentId
            imagePdf.subjectid = subjectID
            imagePdf.yearid = YearId
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
                        
                        let refreshAlert = UIAlertController(title: "", message: i.Message, preferredStyle: .alert)
                        
                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                            
                            if self.piroty == "p2" || self.piroty == "p3" {
                                
                                let vc = SenderAssigmentHomePageViewController()
                                vc.is_read_enabled = self.is_read_enabled
                                vc.is_write_enabled = self.is_write_enabled
                                vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                                vc.assigmentSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                                vc.assigmentSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                                vc.str = self.strs
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
                                vc.str = self.strs
                                vc.strName = self.strName
                                vc.modalPresentationStyle = .fullScreen
                                self.present(vc, animated: true)
                            }
                        })
                        
                        self.present(refreshAlert, animated: true)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        } else {
            
            var assigmet : [FileNameArray] = []
            
            for i in awsArry{
                var imagePdfFileArry = FileNameArray()
                imagePdfFileArry.FileName = i
                assigmet.append(imagePdfFileArry)
            }
            
            var imagePdf = assigmentImagePdfModal()
            
            imagePdf.collegeid = collegeId
            imagePdf.sectionid = sectionId
            imagePdf.processtype = "add"
            imagePdf.staffid = stafId
            imagePdf.assignmentdescription = TextDiscrition
            imagePdf.assignmentid = assigmentForwardHeaderId
            imagePdf.assignmenttopic = textTitle
            imagePdf.assignmenttype = AssigmentFileType
            imagePdf.callertype = piroty
            imagePdf.courseid = courseId
            imagePdf.receiverid = nameString
            imagePdf.receivertype = "2"
            imagePdf.deptid = departmentId
            imagePdf.subjectid = subjectID
            imagePdf.yearid = YearId
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
                        
                        let refreshAlert = UIAlertController(title: "", message: i.Message, preferredStyle: .alert)
                        
                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                            
                            if self.piroty == "p2" || self.piroty == "p3" {
                                
                                let vc = SenderAssigmentHomePageViewController()
                                vc.is_read_enabled = self.is_read_enabled
                                vc.is_write_enabled = self.is_write_enabled
                                vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                                vc.assigmentSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                                vc.assigmentSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                                vc.str = self.strs
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
                                vc.str = self.strs
                                vc.strName = self.strName
                                vc.modalPresentationStyle = .fullScreen
                                self.present(vc, animated: true)
                            }
                        })
                        
                        self.present(refreshAlert, animated: true)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func assigmentImagePdf(imageArry:[String] ){
        
        if MenuType == "6"{
            
            var assigmet : [FileNameArray] = []
            
            for i in imageArry{
                var imagePdfFileArry = FileNameArray()
                imagePdfFileArry.FileName = i
                assigmet.append(imagePdfFileArry)
            }
            
            var imagePdf = assigmentImagePdfModal()
            
            imagePdf.collegeid = collegeId
            imagePdf.sectionid = sectionId
            imagePdf.processtype = "add"
            imagePdf.staffid = stafId
            imagePdf.assignmentdescription = TextDiscrition
            imagePdf.assignmentid = "0"
            imagePdf.assignmenttopic = textTitle
            imagePdf.assignmenttype = AssigmentFileType
            imagePdf.callertype = piroty
            imagePdf.courseid = courseId
            imagePdf.receiverid = nameString
            imagePdf.receivertype = "2"
            imagePdf.deptid = departmentId
            imagePdf.subjectid = subjectID
            imagePdf.yearid = YearId
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
                        
                        let refreshAlert = UIAlertController(title: "", message: i.Message, preferredStyle: .alert)
                        
                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                            
                            if self.piroty == "p2" || self.piroty == "p3" {
                                
                                let vc = SenderAssigmentHomePageViewController()
                                vc.is_read_enabled = self.is_read_enabled
                                vc.is_write_enabled = self.is_write_enabled
                                vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                                vc.assigmentSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                                vc.assigmentSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                                vc.str = self.strs
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
                                vc.str = self.strs
                                vc.strName = self.strName
                                vc.modalPresentationStyle = .fullScreen
                                self.present(vc, animated: true)
                            }
                        })
                        
                        self.present(refreshAlert, animated: true)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        } else {
            
            var assigmet : [FileNameArray] = []
            
            for i in imageArry{
                var imagePdfFileArry = FileNameArray()
                imagePdfFileArry.FileName = i
                assigmet.append(imagePdfFileArry)
            }
            
            var imagePdf = assigmentImagePdfModal()
            
            imagePdf.collegeid = collegeId
            imagePdf.sectionid = sectionId
            imagePdf.processtype = "add"
            imagePdf.staffid = stafId
            imagePdf.assignmentdescription = TextDiscrition
            imagePdf.assignmentid = assigmentForwardHeaderId
            imagePdf.assignmenttopic = textTitle
            imagePdf.assignmenttype = AssigmentFileType
            imagePdf.callertype = piroty
            imagePdf.courseid = courseId
            imagePdf.receiverid = nameString
            imagePdf.receivertype = "2"
            imagePdf.deptid = departmentId
            imagePdf.subjectid = subjectID
            imagePdf.yearid = YearId
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
                        
                        let refreshAlert = UIAlertController(title: "", message: i.Message, preferredStyle: .alert)
                        
                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                            
                            if self.piroty == "p2" || self.piroty == "p3" {
                                
                                let vc = SenderAssigmentHomePageViewController()
                                vc.is_read_enabled = self.is_read_enabled
                                vc.is_write_enabled = self.is_write_enabled
                                vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                                vc.assigmentSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                                vc.assigmentSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                                vc.str = self.strs
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
                                vc.str = self.strs
                                vc.strName = self.strName
                                vc.modalPresentationStyle = .fullScreen
                                self.present(vc, animated: true)
                            }
                        })
                        
                        self.present(refreshAlert, animated: true)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func editAttendMark(){
        
        var sss : [presentListDataDetails] = []
        var ttt : [absentlistdataDetails] = []
        var OD : [onDutylistdataDetails] = []
        var OL : [onLeavelistdataDetails] = []
        
        
        for i in EditAttendancePresentId{
            
            var presents = presentListDataDetails()
            
            presents.presentmemberid = i
            
            sss.append(presents)
            
        }
        
        
        
        for i in EditAttendanceABSENTId{
            
            var abesentss = absentlistdataDetails()
            
            abesentss.absentmemberid = i
            ttt.append(abesentss)
            
        }
        
        for i in EditAttendanceOnDutyId{
            
            var onduties = onDutylistdataDetails()
            onduties.odmemberid = i
            OD.append(onduties)
        }
        
        for i in EditAttendanceOnLeaveId{
            
            var onleaves = onLeavelistdataDetails()
            onleaves.leavememberid = i
            OL.append(onleaves)
        }
        
        var attendanceMark = attendanceMarkigModal()
        attendanceMark.collegeid = collegeId
        attendanceMark.sectionid = sectionId
        attendanceMark.userid =  stafId
        attendanceMark.subjectid = subjectID
        attendanceMark.processtype = "edit"
        attendanceMark.date = attendanceDate
        attendanceMark.type = typeofAttendance
        attendanceMark.title = AttendanceTextView.text
        attendanceMark.presentlist = sss
        attendanceMark.attendance_hours = attendanceDropLbl.text
        
        attendanceMark.absentlist = ttt
        attendanceMark.odlist = OD
        attendanceMark.leavelist = OL
        
        print("yearAndSectionModalStr",attendanceMark)
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.MarkHourWiseAttendance,
            httpMethod: .post,
            queryParam: nil,
            requestBody: attendanceMark
        ) { [weak self] (result: Result<MarkAttendanceResponce, Error>) in
            
            guard let self = self else { return }
            
            switch result {
                
            case .success(let attendanceMarking):
                
                if attendanceMarking.Status == 1{
                    
                    let refreshAlert = UIAlertController(title: "", message: attendanceMarking.Message, preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] (action: UIAlertAction!) in
                        
                        guard let self = self else { return }
                        
                        if piroty == "p2" || piroty == "p3" {
                            
                            let vc = SenderAttendanceVcViewController(nibName: nil, bundle: nil)
                            vc.is_read_enabled = is_read_enabled
                            vc.is_write_enabled = is_write_enabled
                            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                            vc.segmentName.backgroundColor = UIColor(named: "HodUnSelector")
                            vc.segmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                            vc.str = strs
                            vc.strName = strName
                            
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true , completion: nil)
                            
                        }
                        else{
                            
                            let vc = SenderAttendanceVcViewController(nibName: nil, bundle: nil)
                            vc.is_read_enabled = is_read_enabled
                            vc.is_write_enabled = is_write_enabled
                            vc.view.backgroundColor = UIColor(named: "Principal" )
                            vc.segmentName.backgroundColor = UIColor(named: "UnSelector")
                            vc.segmentName.selectedSegmentTintColor = UIColor(named: "Selector")
                            vc.str = strs
                            vc.strName = strName
                            
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true , completion: nil)
                            
                        }
                        
                    }))
                    
                    self.present(refreshAlert, animated: true, completion: nil)
                }
                
                else{
                    
                    let refreshAlert = UIAlertController(title: "", message: attendanceMarking.Message, preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] (action: UIAlertAction!) in
                        
                        guard let self = self else { return }
                        
                        if piroty == "p2" || piroty == "p3" {
                            
                            let vc = SenderAttendanceVcViewController(nibName: nil, bundle: nil)
                            vc.is_read_enabled = is_read_enabled
                            vc.is_write_enabled = is_write_enabled
                            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                            vc.segmentName.backgroundColor = UIColor(named: "HodUnSelector")
                            vc.segmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                            vc.str = strs
                            vc.strName = strName
                            
                            
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true , completion: nil)
                            
                        }
                        
                        else{
                            
                            let vc = SenderAttendanceVcViewController(nibName: nil, bundle: nil)
                            vc.is_read_enabled = is_read_enabled
                            vc.is_write_enabled = is_write_enabled
                            vc.view.backgroundColor = UIColor(named: "Principal" )
                            vc.segmentName.backgroundColor = UIColor(named: "UnSelector")
                            vc.segmentName.selectedSegmentTintColor = UIColor(named: "Selector")
                            vc.str = strs
                            vc.strName = strName
                            
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true , completion: nil)
                            
                        }
                        
                    }))
                    
                    self.present(refreshAlert, animated: true, completion: nil)
                    
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    
    func attendanceMarking(){
        
        
        if AttendanceTextView.text == "Enter the topic"{
            
            AttendanceTextView.text = ""
            
        }
        
        var sss : [presentListDataDetails] = []
        var ttt : [absentlistdataDetails] = []
        
        let presentList: [presentListDataDetails] = presentMemberIds.map { id in
            var detail = presentListDataDetails()
            detail.presentmemberid = id
            return detail
        }
        
        
        let absentList: [absentlistdataDetails] = absentMemberIds.map { id in
            var detail = absentlistdataDetails()
            detail.absentmemberid = id
            return detail
        }
        
        let OdList: [onDutylistdataDetails] = onDutyMemberIds.map { id in
            var detail = onDutylistdataDetails()
            detail.odmemberid = id
            return detail
        }
        
        let leaveList: [onLeavelistdataDetails] = onLeaveMemberIds.map { id in
            var detail = onLeavelistdataDetails()
            detail.leavememberid = id
            return detail
        }
        
        for i in AttendancePresentId{
            
            
            var presents = presentListDataDetails()
            
            presents.presentmemberid = i
            
            
            sss.append(presents)
        }
        
        
        
        for i in AttendanceABSENTId{
            
            var abesentss = absentlistdataDetails()
            
            abesentss.absentmemberid = i
            
            ttt.append(abesentss)
        }
        
        
        
        var attendanceMark = attendanceMarkigModal()
        attendanceMark.collegeid = collegeId
        attendanceMark.sectionid = sectionId
        attendanceMark.userid =  stafId
        attendanceMark.subjectid = subjectID
        attendanceMark.type = typeofAttendance
        attendanceMark.title = AttendanceTextView.text
        attendanceMark.processtype = "add"
        attendanceMark.date = attendanceDate
        attendanceMark.attendance_hours = attendanceDropLbl.text
        attendanceMark.presentlist = presentList
        attendanceMark.absentlist = absentList
        attendanceMark.odlist = OdList
        attendanceMark.leavelist = leaveList
        
        print("yearAndSectionModalStr",attendanceMark)
        
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.MarkHourWiseAttendance,
            httpMethod: .post,
            queryParam: nil,
            requestBody: attendanceMark
        ) { [weak self] (result: Result<MarkAttendanceResponce, Error>) in
            
            guard let self = self else { return }
            
            switch result {
                
            case .success(let attendanceMarking):
                
                if attendanceMarking.Status == 1{
                    
                    let refreshAlert = UIAlertController(title: "", message: attendanceMarking.Message, preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] (action: UIAlertAction!) in
                        
                        guard let self = self else { return }
                        
                        if piroty == "p2" || piroty == "p3" {
                            
                            let vc = SenderAttendanceVcViewController(nibName: nil, bundle: nil)
                            vc.is_read_enabled = is_read_enabled
                            vc.is_write_enabled = is_write_enabled
                            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                            vc.segmentName.backgroundColor = UIColor(named: "HodUnSelector")
                            vc.segmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                            vc.str = strs
                            vc.strName = strName
                            
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true , completion: nil)
                            
                        } else{
                            
                            let vc = SenderAttendanceVcViewController(nibName: nil, bundle: nil)
                            vc.is_read_enabled = is_read_enabled
                            vc.is_write_enabled = is_write_enabled
                            vc.view.backgroundColor = UIColor(named: "Principal" )
                            vc.segmentName.backgroundColor = UIColor(named: "UnSelector")
                            vc.segmentName.selectedSegmentTintColor = UIColor(named: "Selector")
                            vc.str = strs
                            vc.strName = strName
                            
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true , completion: nil)
                            
                        }
                        
                    }))
                    
                    self.present(refreshAlert, animated: true, completion: nil)
                    
                    
                }else{
                    
                    let refreshAlert = UIAlertController(title: "", message: attendanceMarking.Message, preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] (action: UIAlertAction!) in
                        
                        guard let self = self else { return }
                        
                        if piroty == "p2" || piroty == "p3" {
                            
                            let vc = SenderAttendanceVcViewController(nibName: nil, bundle: nil)
                            vc.is_read_enabled = is_read_enabled
                            vc.is_write_enabled = is_write_enabled
                            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                            vc.segmentName.backgroundColor = UIColor(named: "HodUnSelector")
                            vc.segmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                            vc.str = strs
                            vc.strName = strName
                            
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true , completion: nil)
                            
                        }
                        
                        
                        else{
                            
                            let vc = SenderAttendanceVcViewController(nibName: nil, bundle: nil)
                            vc.is_read_enabled = is_read_enabled
                            vc.is_write_enabled = is_write_enabled
                            vc.view.backgroundColor = UIColor(named: "Principal" )
                            vc.segmentName.backgroundColor = UIColor(named: "UnSelector")
                            vc.segmentName.selectedSegmentTintColor = UIColor(named: "Selector")
                            vc.str = strs
                            vc.strName = strName
                            
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true , completion: nil)
                            
                        }
                        
                    }))
                    
                    self.present(refreshAlert, animated: true, completion: nil)
                     
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    
    func ImagePdfParticular(ImageFile: [String]) {

        print("fdfddsx")

        var imageAryy: [FileNameImages] = []

        for i in ImageFile {
            var imageAws = FileNameImages()
            imageAws.FileName = i
            imageAryy.append(imageAws)
        }

        var sendImagePdfEntier = ImagePdfPartResponce()

        sendImagePdfEntier.Staffid = stafId
        sendImagePdfEntier.collegeid = collegeId
        sendImagePdfEntier.callertype = piroty

        if is_parent_target_enabled == "0" {
            sendImagePdfEntier.isparent = false
        } else {
            sendImagePdfEntier.isparent = parentChck.isChecked
        }

        sendImagePdfEntier.isstudent = studentChck.isChecked
        sendImagePdfEntier.isstaff = false
        sendImagePdfEntier.fileduration = "0"
        sendImagePdfEntier.Description = TextDiscrition
        sendImagePdfEntier.title = textTitle
        sendImagePdfEntier.filetype = imageFileType
        sendImagePdfEntier.receivertype = resiverType
        sendImagePdfEntier.receiverid = nameString
        sendImagePdfEntier.FileNameArray = imageAryy

        print("yearAndSectionModalStr", sendImagePdfEntier)

        if ItemName == "Subject" || HodYearSpefiy == "12" {

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

                        if self.piroty == "p2" || self.piroty == "p3" {

                            let vc = SenderImagePdfHomePageViewController()
                            vc.is_read_enabled = self.is_read_enabled
                            vc.is_write_enabled = self.is_write_enabled
                            vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                            vc.imageSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                            vc.imageSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                            vc.str = self.strs
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
                            vc.str = self.strs
                            vc.strName = self.strName
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true)
                        }
                    }))

                    self.present(refreshAlert, animated: true)

                case .failure(let error):
                    print("API Error:", error.localizedDescription)
                }
            }

        } else {

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

                        if self.piroty == "p2" || self.piroty == "p3" {

                            let vc = SenderImagePdfHomePageViewController()
                            vc.is_read_enabled = self.is_read_enabled
                            vc.is_write_enabled = self.is_write_enabled
                            vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                            vc.imageSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                            vc.imageSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                            vc.str = self.strs
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
                            vc.str = self.strs
                            vc.strName = self.strName
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true)
                        }
                    }))

                    self.present(refreshAlert, animated: true)

                case .failure(let error):
                    print("API Error:", error.localizedDescription)
                }
            }
        }
    }
    
    
    func attendanceEdits(hoursRef : String){
        
        print("this attencedce")
        
        pleaseChooseLbl.isHidden = true
        
        if MenuType == "10"{
            
            TargetView.isHidden = true
        }
        
        else {
            
            TargetView.isHidden = false
        }
        
        var attendanceEdit = attendanceEditModal()
        
        attendanceEdit.sectionid = sectionId
        attendanceEdit.subjectid = subjectID
        attendanceEdit.attendancehour = hoursRef
        attendanceEdit.userid = stafId
        attendanceEdit.appid = "2"
        
        
        print("yearAndSectionModalStr",attendanceEdit)
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.GetStudentsForHourwiseAttendanceEdit,
            httpMethod: .post,
            queryParam: nil,
            requestBody: attendanceEdit
        ) { [weak self] (result: Result<attendanceEditResponce, Error>) in
            
            guard let self = self else { return }
            
            switch result {
                
            case .success(let particular):
                
                if particular.Status == 1 {
                    
                    self.attendanceEditsss  = particular.data ?? []
                    self.clonelist3 = particular.data ?? []
                    
                    for i in particular.data ?? []{
                        
                        if i.attendancetype == "Present"{
                            
                            self.EditAttendancePresentId.append(i.memberid ?? "")
                            
                        }
                        else if i.attendancetype == "Absent"{
                            
                            self.EditAttendanceABSENTId.append(i.memberid ?? "")
                            
                        }else if i.attendancetype == "OnDuty"{
                            self.EditAttendanceOnDutyId.append(i.memberid ?? "")
                        }else if i.attendancetype == "OnLeave"{
                            self.EditAttendanceOnLeaveId.append(i.memberid ?? "")
                        }
                    }
                    
                    self.check_MarkAll_count()
                    self.Tv.dataSource = self
                    self.Tv.delegate = self
                    self.Tv.reloadData()
                    
                }else{
                    
                    let refreshAlert = UIAlertController(title: "", message: particular.Message, preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        
                    }))
                    
                    self.present(refreshAlert, animated: true, completion: nil)
                    
                    self.Tv.dataSource = self
                    self.Tv.delegate = self
                    self.Tv.reloadData()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    
    
    
    
    @IBAction func selectAllAction(_ sender: UIButton) {
        
        ALLLLID = "1"
        resiverId.removeAll()
        AttendancePresentId.removeAll()
        AttendanceABSENTId.removeAll()
        
        if ItemName == "Subject"  || HodYearSpefiy == "12"{
            
            if sender.isSelected  == true {
                
                for index in studentRef.indices{
                    
                    studentRef[index].isSelected = false
                    sender.isSelected = false
                    
                    print("forPrint",studentRef[index].memberid)
                    
                    if(resiverId.count > 0){
                        resiverId.removeAll()
                    }
                    
                    sender.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                }
                
                print("SelctAlll",resiverId)
            }else{
                
                for index in  studentRef.indices{
                    studentRef[index].isSelected = true
                    sender.isSelected = true
                    
                    if(!resiverId.contains(studentRef[index].memberid ?? "")){
                        resiverId.append(studentRef[index].memberid ?? "")
                    }
                    
                    sender.setImage(UIImage.init(named: "done"), for: .normal)
                }
                print("SelctAlll",resiverId)
            }
        }else if  ItemName == "Tutor"{
            
            print("TutorTutorTutor")
            if sender.isSelected {
                for index in tutorRefs.indices{
                    studentRef[index].isSelected = false
                    sender.isSelected = false
                    print("forPrint",studentRef[index].memberid)
                    
                    if(resiverId.count > 0){
                        resiverId.removeAll()
                        
                    }
                    sender.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                }
            }else{
                
                for index in  tutorRefs.indices{
                    tutorRefs[index].isSelected = true
                    sender.isSelected = true
                    
                    if(!resiverId.contains( tutorRefs[index].memberid ?? "")){
                        resiverId.append( tutorRefs[index].memberid ?? "")
                    }
                    
                    sender.setImage(UIImage.init(named: "done"), for: .normal)
                }
                
                nameString =  resiverId.joined(separator: "~")
            }
        }
        
        else if MenuType == "9"{
            
            nameString = "1"
            if sender.isSelected {
                for index in  studentRef.indices{
                    studentRef[index].isSelected = false
                    sender.isSelected = false
                    
                    AttendanceABSENTId.removeAll()
                    
                    AttendancePresentId.append(studentRef[index].memberid ?? "")
                    
                    
                    sender.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                }
            }else{
                
                for index in  studentRef.indices{
                    studentRef[index].isSelected = true
                    sender.isSelected = true
                    print("forPrint1",studentRef[index].memberid)
                    
                    AttendanceABSENTId.append(studentRef[index].memberid ?? "")
                    
                    AttendancePresentId.removeAll()
                    
                    sender.setImage(UIImage.init(named: "done"), for: .normal)
                }
            }
        }
        
        else if MenuType == "8" ||  MenuType == "6" || HodYearSpefiy == "12"{
            
            if sender.isSelected {
                for index in studentRef.indices{
                    studentRef[index].isSelected = false
                    sender.isSelected = false
                    print("forPrint",studentRef[index].memberid)
                    
                    
                    if(resiverId.count > 0){
                        resiverId.removeAll()
                    }
                    
                    sender.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                }
                
                print("SelctAlll",resiverId)
            }else{
                
                for index in  studentRef.indices{
                    studentRef[index].isSelected = true
                    sender.isSelected = true
                    print("forPrint1",studentRef[index].memberid)
                    
                    if(!resiverId.contains(studentRef[index].memberid ?? "")){
                        resiverId.append(studentRef[index].memberid ?? "")
                        
                    }
                    
                    
                    sender.setImage(UIImage.init(named: "done"), for: .normal)
                }
                
                print("SelctAlll",resiverId)
                
            }
            
        }
        
        Tv.reloadData()
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    @IBAction func cancelVc(){
        
        dismiss(animated: true)
        
    }
    
    
    
    // Upload Image To Aws File.
    
    
    
    
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
            bucketPath: collegeId,
            fileType: "image"
        ) { [self] result in
            switch result {
            case .success(let awsResponse):
                
                print("Presigned URL fetched: \(awsResponse.data?.presignedUrl ?? "")")
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
                    
                    
                    
                    
                    if  MenuType == "5"{
                        
                        ImagePdfParticular(ImageFile: awsArry)
                        
                        
                    }
                    
                    else if MenuType == "6"      ||   MenuType == "6" {
                        
                        
                        assigmentImagePdf(imageArry : awsArry)
                        
                        
                        
                    }
                    
                    else if  MenuType == "1"{
                        
                        self.NoticeSendSmsToParticular(ImageFile: awsArry)
                        //
                        
                        
                        
                    }
                    
                    
                }
                
            case .failure(let error):
                print("Error fetching presigned URL: \(error.localizedDescription)")
            }
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //    func getImageURL(images : [UIImage]){
    //
    //
    //        self.originalImagesArray = images
    //        self.totalImageCount = images.count
    //        if currentImageCount < images.count{
    //            uploadAWS(image: images[currentImageCount])
    //            print("uploadAWS",self.uploadAWS)
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
    //        var colgId : String!
    //        let defaults = UserDefaults.standard
    //        colgId = defaults.string(forKey: DefaultsKeys.collegeid)
    //
    //
    //        let S3BucketName = DefaultsKeys.S3BucketName
    //
    //        print("S3BucketNameS3BucketName",DefaultsKeys.S3BucketName)
    //
    //        let CognitoPoolID = DefaultsKeys.CognitoPoolID
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
    //        uploadRequest?.contentType = "image/jpeg"
    //        uploadRequest?.acl = .publicRead
    //
    //
    //        print("uploadRequestdd",uploadRequest)
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
    //
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
    //
    //
    //                    //
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
    //
    //
    
    
    
    // AWS PDF Upload Part
    
    
    
    
    
    
    //    func uploadPDFFileToAWS(pdfData : Data){
    //
    //
    //        KRProgressHUD.show()
    //
    //        var colgId : String!
    //        let defaults = UserDefaults.standard
    //        colgId = defaults.string(forKey: DefaultsKeys.collegeid)
    //
    //
    //        let S3BucketName =  DefaultsKeys.S3BucketName
    //        let CognitoPoolID =  DefaultsKeys.CognitoPoolID
    //
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
    //        let ext = imageName as String
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
    //
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
    //                    awsArry.append(absoluteString)
    //                    let imageDict = NSMutableDictionary()
    //                    imageDict["FileName"] = absoluteString
    //                    self.imageUrlArray.add(imageDict)
    //                    self.convertedImagesUrlArray = self.imageUrlArray
    //
    //
    //
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
    //                    }
    //                }
    //            }
    //            else {
    //
    //                KRProgressHUD.dismiss()
    //                print("Unexpected empty result.")
    //            }
    //            return nil
    //        }
    //    }
    
    
    
    
    
    
    @IBAction func generalBtn(_ sender: Any) {
        
        typeofAttendance = "General"
        generalBtnName.setImage(UIImage(named: "radios"), for: .normal)
        theroyBtnName.setImage(UIImage(named: "radio-button"), for: .normal)
        partialBtnName.setImage(UIImage(named: "radio-button"), for: .normal)
    }
    
    @IBAction func theoryBtn(_ sender: Any) {
        
        typeofAttendance = "Theory"
        theroyBtnName.setImage(UIImage(named: "radios"), for: .normal)
        generalBtnName.setImage(UIImage(named: "radio-button"), for: .normal)
        partialBtnName.setImage(UIImage(named: "radio-button"), for: .normal)
    }
    
    
    @IBAction func particalBtn(_ sender: Any) {
        
        typeofAttendance = "Practical"
        partialBtnName.setImage(UIImage(named: "radios"), for: .normal)
        generalBtnName.setImage(UIImage(named: "radio-button"), for: .normal)
        theroyBtnName.setImage(UIImage(named: "radio-button"), for: .normal)
    }
}


class CheckBoxSpecify : UITapGestureRecognizer {
    
    var pos : Int!
    
    var memberidssss : String!
    var demoImgg : UIImageView!
    var checkBoxss : CheckBoxTwo!
    
    var bool : Bool!
    
    
    
}


class AttendanceCheckBoxSpecify : UITapGestureRecognizer {
    
    var pos : Int!
    
    var memberidssss : String!
    
    var checkBoxss : CheckBoxTwo!
    var ViewClickBool : Bool!
    var vieclick : UIView!
    var IndicatiopnImage : UIImageView!
    
}

