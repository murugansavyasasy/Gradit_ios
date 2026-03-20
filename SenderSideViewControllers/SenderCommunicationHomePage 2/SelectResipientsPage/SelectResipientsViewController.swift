//
//  SelectResipientsViewController.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 28/12/22.
//

import UIKit
import ObjectMapper
import DropDown
import Alamofire
import KRProgressHUD
import AWSS3
@available(iOS 16.0, *)
class SelectResipientsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {

@IBOutlet weak var staflDefautLabel: UILabel!

@IBOutlet weak var SelectAllDefaultLbl: UILabel!
@IBOutlet weak var searchOverllAllView: UIView!
@IBOutlet weak var searchbar: UISearchBar!
@IBOutlet weak var allViewTop: NSLayoutConstraint!

@IBOutlet weak var studentCheckBoxCon: NSLayoutConstraint!
@IBOutlet weak var allLbl: UILabel!
@IBOutlet weak var allBtn: UIButton!

@IBOutlet weak var groupLeadingCon: NSLayoutConstraint!
@IBOutlet weak var parentDefaultLabl: UILabel!
@IBOutlet weak var entierDefaultLbl: UILabel!
@IBOutlet weak var allview: UIView!
@IBOutlet weak var entierClgLbl: UILabel!
@IBOutlet weak var entireClgView: UIViewX!
@IBOutlet weak var tvTop: UIViewX!
@IBOutlet weak var allCheckbox: CheckBoxTwo!

@IBOutlet weak var coursedropTxtLabel: UILabel!
@IBOutlet weak var courseDropDownView: UIView!

@IBOutlet weak var dropDownTextLabel: UILabel!
@IBOutlet weak var sendView: UIViewX!


@IBOutlet weak var tvTopConstain: NSLayoutConstraint!

@IBOutlet weak var dropDownView: UIView!
@IBOutlet weak var topIdentificationLabel: UILabel!
@IBOutlet weak var tv: UITableView!

@IBOutlet weak var entireCollegeCheckBoxView: CheckBoxTwo!


@IBOutlet weak var cancelView: UIViewX!


@IBOutlet weak var groupLabel: UILabel!


@IBOutlet weak var courseLabel: UILabel!


@IBOutlet weak var yourClassLabel: UILabel!

@IBOutlet weak var parentCheckTraling: NSLayoutConstraint!

@IBOutlet weak var TVTopCon: NSLayoutConstraint!
@IBOutlet weak var departmentLabel: UILabel!

@IBOutlet weak var yourClassesView: UIViewX!
@IBOutlet weak var devisionTabel: UILabel!


@IBOutlet weak var devisionDropdownTopCon: NSLayoutConstraint!
@IBOutlet weak var groupView: UIViewX!


@IBOutlet weak var courseView: UIViewX!


@IBOutlet weak var departmentView: UIViewX!



@IBOutlet weak var devisionView: UIViewX!




@IBOutlet weak var replySwitch: UISwitch!

@IBOutlet weak var parentsCheckBoxView: CheckBoxTwo!



@IBOutlet weak var studentCheckBoxView: CheckBoxTwo!



@IBOutlet weak var staffCheckBoxView: CheckBoxTwo!

var resivre : String!

var identifier  = "SelectRespienceCellTableViewCell"

var DateLabels : String!

var devisionRefName : [getDivisonDataDetails] = []
var deparmentRefName : [RepienceDeparmentDataDetails] = []
var entierRefName : [EntiercollegeDataDetails] = []
var groupRefName : [getGroupDataDetails] = []
var courseRefName : [getCourseDataDetails] = []
var particularSms : NoticePArticularResponce?
let dropDown = DropDown()
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

var clone : [RepienceDeparmentDataDetails] = []
var memberId : String!
var collegeId : String!
var priority : String!

var VenuTestField : String!

var courseTypeId : String! = ""

var awsurl : String!

var fileType : String!

var videoVimeoUrl : String!

var videoIframe : String!

var voiceUrl : URL!

var voiceReplyType  = "0"
var voiceDuration : String!

var courseId : String!

var yearId : String!

var sectionID : String!

var SubjectId : String!

var nameString : String!


var isFilter : Bool = false

var AssigmentMenuAwsUrl : String!

var AssigmentFileType : String!

var imageFileType : String!


var assigmentHeaderId : String!

var videoURL : String!



var videoType : String!


var venumtextField : String!

var assigmentDate : String!

var EventTime : String!
var resiverType = ""

var strs : [String] = []
var strName : [String] = []

var str : [String] = []

var rowsWhichAreChecked = [IndexPath]()

var awsArry : [String] = []

var s : String!
var filteredItems: [String] = []
var EntierId : String!

var IDforStaffCheck  = ""

var  parentTargetEnagbel : String!
var photoArray = [UIImage]()

var imagePicker = UIImagePickerController()
var currentImageCount = 0
var totalImageCount = 0
var originalImagesArray = [UIImage]()
var absoluteStringImg : String!
var imageUrlArray = NSMutableArray()
var convertedImagesUrlArray = NSMutableArray()
var pdfData : Data? = nil
var is_read_enabled : String!
var is_write_enabled : String!
var clgListDataList : [clgListDataDetails] = []
var ClgListClgId : String!
var clgIdArry: [String] = []
var clone_listDevision : [getDivisonDataDetails] = []
var filtered_listDevision : [getDivisonDataDetails] = []
var clone_listDepartment : [RepienceDeparmentDataDetails] = []
var filtered_listDepartment : [RepienceDeparmentDataDetails] = []
var filtered_listDepartment1 : [RepienceDeparmentDataDetails] = []
var clone_listDepartment1 : [RepienceDeparmentDataDetails] = []
var clone_listgroup : [getGroupDataDetails] = []
var filtered_listgroup : [getGroupDataDetails] = []
var clone_listcourse : [getCourseDataDetails] = []
var clone_listcourse1 : [getCourseDataDetails] = []
var filtered_listcourse : [getCourseDataDetails] = []
var filtered_listcourse1 : [getCourseDataDetails] = []

var departNameArry : [String] = []

var departmentDropdownArry : [String] = []
var departmentCondentArry : [RepienceDeparmentDataDetails] = []
var NameId : String!
var NameIdCourse : String!
var courseFirstDropdownArry : [String] = []

var courseSecondtDropdownArry : [String] = []
var courseCondentArry : [getCourseDataDetails] = []

var VoiceHstryId : String!
var voiceHstryHeaderId : String!


var AlertMessage :  String!

var CallEnabel  : Int!
override func viewDidLoad() {
    super.viewDidLoad()
    overrideUserInterfaceStyle = .light
    allview.isHidden = true
    
    
    
    studentCheckBoxView.isChecked = true
    searchbar.delegate = self
    entireClgView.backgroundColor = UIColor(named: "selectColor")
    entierClgLbl.textColor = UIColor.white
    
    searchOverllAllView.isHidden = true
    devisionDropdownTopCon.constant = -30
    
    
    allCheckbox.isHidden = true
    SelectAllDefaultLbl.isHidden = true
    studentCheckBoxCon.constant = -40
    
    dropDownView.isHidden = true
    
    courseDropDownView.isHidden = true
    
    print("fileTypefileTypefileTypefileTypefileType",fileType)
    print("is_write_enabledis_write_enabled",is_write_enabled)
    
    let defaults = UserDefaults.standard
    
    memberId = defaults.string(forKey: DefaultsKeys.memberid)
    
    collegeId = defaults.string(forKey: DefaultsKeys.collegeid)
    priority = defaults.string(forKey: DefaultsKeys.priority)
    parentTargetEnagbel = defaults.string(forKey: DefaultsKeys.is_parent_target_enabled)
    
    CallEnabel = defaults.integer(forKey: DefaultsKeys.is_allow_to_make_call)
    print("tyylyly",CallEnabel)
    
    
    
    if CallEnabel == 1 && VoiceHstryId == "2"{
        
        entierDefaultLbl.isHidden = false
        replySwitch.isHidden = false
    }
    
    else{
        
        entierDefaultLbl.isHidden = true
        replySwitch.isHidden = true
        
    }
    
    
    
    if parentTargetEnagbel == "0"{
        
        
        parentDefaultLabl.isHidden = true
        parentsCheckBoxView.isHidden = true
        
        parentCheckTraling.constant = -80
    }
    
    else{
        parentDefaultLabl.isHidden = false
        
        parentCheckTraling.constant = 0
        
        parentsCheckBoxView.isHidden = false
    }
    
    
    if priority == "p7"{
        
        
        colgList()
        
        entierClgLbl.text = "College List"
        
        
        
        yourClassesView.isHidden = true
        groupLeadingCon.constant  = -125
        allview.isHidden = false
        
    }
    
    let rownib = UINib(nibName: identifier, bundle: nil)
    tv.register(rownib, forCellReuseIdentifier: identifier)
    
    
    let Drops = UITapGestureRecognizer(target: self, action: #selector(dropDowVC))
    
    
    dropDownView.addGestureRecognizer(Drops)
    
    
    let CoureDrop = UITapGestureRecognizer(target: self, action: #selector( courseDropDown))
    
    
    courseDropDownView.addGestureRecognizer(CoureDrop)
    
    
    let send = UITapGestureRecognizer(target: self, action: #selector(sendVc))
    
    
    sendView.addGestureRecognizer(send)
    
    
    
    let devision = UITapGestureRecognizer(target: self, action: #selector(devisionVc))
    
    
    devisionView.addGestureRecognizer(devision)
    
    replySwitch.addTarget(self, action: #selector(switchIsChanged), for: UIControl.Event.valueChanged)
    
    
    
    
    
    let department = UITapGestureRecognizer(target: self, action: #selector(departmentVc))
    
    
    departmentView.addGestureRecognizer(department)
    
    
    
    let entierclgview = UITapGestureRecognizer(target: self, action: #selector(EntierclgViewVc))
    
    
    entireClgView.addGestureRecognizer(entierclgview)
    
    let course = UITapGestureRecognizer(target: self, action: #selector(course))
    
    
    courseView.addGestureRecognizer(course)
    
    
    
    let yourClass = UITapGestureRecognizer(target: self, action: #selector(yourClassFunction))
    
    
    yourClassesView.addGestureRecognizer(yourClass)
    
    
    
    let groups = UITapGestureRecognizer(target: self, action: #selector(groupVC))
    
    
    groupView.addGestureRecognizer(groups)
    
    
    let studentCheckBox = UITapGestureRecognizer(target: self, action: #selector(StudentCheckBoxVc))
    studentCheckBoxView.addGestureRecognizer(studentCheckBox)
    
    let parentCheckBox = UITapGestureRecognizer(target: self, action: #selector(parentCheckBoxVc))
    parentsCheckBoxView.addGestureRecognizer(parentCheckBox)
    
    
    let staffCheckBox = UITapGestureRecognizer(target: self, action: #selector(staffCheckBoxVC))
    staffCheckBoxView.addGestureRecognizer(staffCheckBox)
    
    
    let Allbox = UITapGestureRecognizer(target: self, action: #selector(allCheckboxvc))
    allCheckbox.addGestureRecognizer(Allbox)
    
    
    
    let cancel = UITapGestureRecognizer(target: self, action: #selector(CancelVc))
    cancelView.addGestureRecognizer(cancel)
    
    
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





func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
    if devisionView.backgroundColor == UIColor(named: "selectColor"){
        
        if searchText.isEmpty{
            isFilter = false
            devisionRefName = clone_listDevision
        }else {
            isFilter = true
            devisionRefName = clone_listDevision.filter {
                ($0.division_name ?? "")
                    .localizedCaseInsensitiveContains(searchText) ||
                ($0.division_id ?? "")
                    .localizedCaseInsensitiveContains(searchText) ||
                ($0.division_code ?? "")
                    .localizedCaseInsensitiveContains(searchText)
            }
        }
        
        tv.alpha = devisionRefName.isEmpty ? 0 : 1
        
        tv.reloadData()
          
    } else if departmentView.backgroundColor == UIColor(named: "selectColor") {
        
        if NameId == "2" {
            
            filtered_listDepartment1 = clone_listDepartment1
            
            if !searchText.isEmpty {
                isFilter = true
                departmentCondentArry = filtered_listDepartment1.filter {
                    
                    ($0.department_code ?? "").lowercased().contains(searchText.lowercased()) ||
                    ($0.department_name ?? "").lowercased().contains(searchText.lowercased()) ||
                    ($0.department_id ?? "").lowercased().contains(searchText.lowercased())
                }
                
            } else {
                
                isFilter = false
                departmentCondentArry = filtered_listDepartment1
                
                print("pendingOrder")
            }
            
            if departmentCondentArry.count > 0 {
                
                print("searchListPendigCount", departmentCondentArry.count)
                
                allview.isHidden = false
                tv.alpha = 1
                
            } else {
                
                allview.isHidden = true
                tv.alpha = 0
            }
            
            tv.reloadData()
            
        } else {
            
            filtered_listDepartment = clone_listDepartment
            
            if !searchText.isEmpty {
                
                isFilter = true
                
                deparmentRefName = filtered_listDepartment.filter {
                    
                    ($0.department_code ?? "").lowercased().contains(searchText.lowercased()) ||
                    ($0.department_name ?? "").lowercased().contains(searchText.lowercased()) ||
                    ($0.department_id ?? "").lowercased().contains(searchText.lowercased())
                }
                
            } else {
                
                isFilter = false
                deparmentRefName = filtered_listDepartment
                
                print("pendingOrder")
            }
            
            if deparmentRefName.count > 0 {
                
                print("searchListPendigCount", deparmentRefName.count)
                
                allview.isHidden = false
                tv.alpha = 1
                
            } else {
                
                allview.isHidden = true
                tv.alpha = 0
            }
            
            tv.reloadData()
        }
        
    } else if groupView.backgroundColor == UIColor(named: "selectColor") {
        
        filtered_listgroup = clone_listgroup
        
        if !searchText.isEmpty {
            isFilter = true
            groupRefName = filtered_listgroup.filter {
                
                ($0.groupname ?? "").lowercased().contains(searchText.lowercased()) ||
                ($0.grouptype ?? "").lowercased().contains(searchText.lowercased())
            }
            
        } else {
            
            isFilter = false
            groupRefName = filtered_listgroup
            
            print("pendingOrder")
        }
        
        if groupRefName.count > 0 {
            
            print("searchListPendigCount", groupRefName.count)
            
            tv.alpha = 1
            
        } else {
            
            tv.alpha = 0
        }
        
        tv.reloadData()
    } else if courseView.backgroundColor == UIColor(named: "selectColor"){
        
        if NameIdCourse == "2"{
            
            filtered_listcourse1 = clone_listcourse1
            
            if !searchText.isEmpty{
                isFilter = true
                courseCondentArry = filtered_listcourse1.filter {
                    
                    ($0.course_name ?? "").lowercased().contains(searchText.lowercased()) ||
                    ($0.course_id ?? "").lowercased().contains(searchText.lowercased()) ||
                    ($0.course_code ?? "").lowercased().contains(searchText.lowercased())
                }
                
            }else{
                
                isFilter = false
                courseCondentArry = filtered_listcourse1
                
                print("pendingOrder")
            }
            
            if courseRefName.count > 0{
                
                print ("searchListPendigCount",courseRefName.count)
                
                tv.alpha = 1
                
            }else{
                
                tv.alpha = 0
            }
            
            tv.reloadData()
        }
        
        else{
            
            filtered_listcourse = clone_listcourse
            
            if !searchText.isEmpty{
                isFilter = true
                courseRefName = filtered_listcourse.filter {
                    
                    ($0.course_name ?? "").lowercased().contains(searchText.lowercased()) ||
                    ($0.course_id ?? "").lowercased().contains(searchText.lowercased()) ||
                    ($0.course_code ?? "").lowercased().contains(searchText.lowercased())
                }
                
            }else{
                
                isFilter = false
                courseRefName = filtered_listcourse
                
                print("pendingOrder")
            }
            
            if courseRefName.count > 0{
                
                print ("searchListPendigCount",courseRefName.count)
                
                tv.alpha = 1
                
            }else{
                
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
    
    
    if devisionView.backgroundColor == UIColor(named: "selectColor"){
        
        
        searchBar.resignFirstResponder()
        
        
        
        tv.alpha = 1
        
        devision()
        
        self.tv.reloadData()
    }
    
    else if departmentView.backgroundColor == UIColor(named: "selectColor"){
        
        if NameId == "2" {
            dropDowVC()
            
            print("searchBarCancelButtonClicked22222")
        }
        
        else{
            
            searchBar.resignFirstResponder()
            print("searchBarCancelButtonClicked22222")
            
            
            
            tv.alpha = 1
            
            departMents()
            
            self.tv.reloadData()
            
        }
    }
    
    else if courseView.backgroundColor == UIColor(named: "selectColor"){
        
        if NameIdCourse == "2" {
            courseDropDown()
            
            print("searchBarCancelButtonClicked22222")
        }
        
        else{
            
            searchBar.resignFirstResponder()
            print("searchBarCancelButtonClicked22222")
            
            
            
            tv.alpha = 1
            
            courseApi()
            
            self.tv.reloadData()
            
        }
    }
    
    
    else if groupView.backgroundColor == UIColor(named: "selectColor"){
        
        
    }
    
}



    @IBAction func CoursedropDowVC(){
        
        DefaultsKeys.resiverId.removeAll()
        tv.isHidden = true
        allview.isHidden = true
        
        var deparment = DepartmentModal()
        
        deparment.user_id = memberId
        deparment.college_id = collegeId
        deparment.div_id =  courseTypeId
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.GetDepartmentsbyDivision,
            httpMethod: .post,
            queryParam: nil,
            requestBody: deparment
        ) {[weak self] (result:Result<RepienceDeparmentResponce, Error>) in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let success):
                deparmentRefName = success.data ?? []
                clone_listDepartment = success.data ?? []
                tv.isHidden = true
                
                var addAryy: [String] = [ ]
                var itemAryy: [String] = [ ]
                
                
                success.data?.forEach {(arrType)  in
                    addAryy.append((arrType.department_name ?? ""))
                }
                
                dropDown.dataSource = addAryy//4
                dropDown.anchorView = courseDropDownView //5
                
                dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
                //
                dropDown.direction = .bottom
                DropDown.appearance().backgroundColor = UIColor.white
                dropDown.show() //7
                
                var idArray : [String] = []
                deparmentRefName.forEach {(arrType)  in
                    idArray.append((arrType.department_id ?? ""))
                }
                //
                dropDown.selectionAction = { [weak self] (index:Int, item: String) in
                    print("Selected item: \(item) at index: \(index)")
                    
                    if(DefaultsKeys.resiverId.count>0){
                        DefaultsKeys.resiverId.removeAll()
                    }
                    
                    self?.allview.isHidden = false
                    var course =  getCourseModal()
                    
                    course.user_id = self?.memberId
                    course.college_id = self?.collegeId
                    course.dept_id = idArray[index]
                    
                    print("fhfytghfg",idArray[index])
                    
                    APiCallManager.shared.callApi(
                            url: APIEndpoints.GetCoursesByDepartment,
                            httpMethod: .post,
                            queryParam: nil,
                            requestBody: course
                        ) {[weak self] (result:Result<getCourseResponce, Error>) in
                                
                            guard let self = self else { return }
                            
                            switch result {
                            case .success(let success):
                                self.courseRefName = success.data ?? []
                                self.tv.isHidden = false
                                self.tv.delegate = self
                                self.tv.dataSource = self
                                self.tv.reloadData()
                                self.coursedropTxtLabel.text = item
                            case .failure(let failure):
                                 print("Error:",failure.localizedDescription)
                            }
                            
                            }
                }
            case .failure(let failure):
                print("Error:",failure.localizedDescription)
            }
            
        }
        
    }


func courseApi(){
    
    var course =  getCourseModal()
    
    course.user_id = memberId
    course.college_id = collegeId
    course.dept_id = "0"
    
    APiCallManager.shared.callApi(
            url: APIEndpoints.GetCoursesByDepartment,
            httpMethod: .post,
            queryParam: nil,
            requestBody: course
        ) {[weak self] (result:Result<getCourseResponce, Error>) in
                
            guard let self = self else { return }
            
            switch result {
            case .success(let cour):
                courseRefName = cour.data ?? []
                clone_listcourse = cour.data ?? []
                
                var str : String
                
                for i in cour.data ?? []{
                    
                    str = i.division_name ?? ""
                    
                    if i.division_name == str{
                        
                        courseFirstDropdownArry.append(i.division_name ?? "")
                    }
                }
                
                var newArray: [String] = []
                newArray = ["--All Division--"]
                for element in courseFirstDropdownArry {
                    // Check if the element is not already in the new array
                    if !newArray.contains(element) {
                        // Add the unique element to the new array
                        newArray.append(element)
                    }
                }
                
                courseFirstDropdownArry = newArray
            
                tv.isHidden = false
                tv.delegate = self
                tv.dataSource = self
                tv.reloadData()
            case .failure(let failure):
                 print("Error:",failure.localizedDescription)
            }
            
            }
}

func departMents(){
    
    var deparment = DepartmentModal()
    
    deparment.user_id = memberId
    deparment.college_id = collegeId
    deparment.div_id = "0"
    
    APiCallManager.shared.callApi(
            url: APIEndpoints.GetDepartmentsbyDivision,
            httpMethod: .post,
            queryParam: nil,
            requestBody: deparment
        ) {[weak self] (result:Result<RepienceDeparmentResponce, Error>) in
                
            guard let self = self else { return }
            
            switch result {
            case .success(let depart):
                if depart.Status == 1{
                    deparmentRefName = depart.data ?? []
                    clone_listDepartment = depart.data ?? []
                    var str : String!
                    
                    for i in depart.data ?? []{
                        
                        str = i.division_name
                        
                        if i.division_name == str{
                            
                            departNameArry.append(i.division_name ?? "")
                        }
                    }
                    
                    var newArray: [String] = []
                    newArray = ["--All Division--"]
                    for element in departNameArry {
                        // Check if the element is not already in the new array
                        if !newArray.contains(element) {
                            // Add the unique element to the new array
                            newArray.append(element)
                        }
                    }
                    
                    departmentDropdownArry = newArray
                    tv.isHidden = false
                    allview.isHidden = false
                    allBtn.isHidden = false
                    tv.dataSource = self
                    tv.delegate = self
                    tv.reloadData()
                }else{
                    
                    tv.dataSource = self
                    tv.delegate = self
                    tv.reloadData()
                }
            case .failure(let failure):
                 print("Error:",failure.localizedDescription)
            }
            
            }
}


@IBAction func dropDowVC(){
    
    allview.isHidden = true
    tv.isHidden = true
    
    allBtn.setImage(UIImage.init(named: "checkboxs"), for: .normal)
    allBtn.isSelected = false
    
    
    if departmentView.backgroundColor == UIColor(named: "selectColor"){
        
        
        dropDown.dataSource =  departmentDropdownArry//4
        
        dropDown.anchorView = dropDownView //5
        
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        
        dropDown.direction = .bottom
        DropDown.appearance().backgroundColor = UIColor.white
        dropDown.show() //7
        
        
        dropDown.selectionAction = { [unowned self] (index:Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            
            //                    if(DefaultsKeys.resiverId.count>0){
            //                        DefaultsKeys.resiverId.removeAll()
            //                    }
            //                    
            departmentCondentArry.removeAll()
            clone_listDepartment1.removeAll()
            tv.isHidden = true
            
            
            
            if index == 0{
                NameId = "1"
                //                        departMents()
                allview.isHidden = false
                allBtn.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                allBtn.isSelected = false
                
                tv.isHidden = false
                tv.delegate = self
                tv.dataSource = self
                tv.reloadData()
            }
            
            else{
                
                NameId = "2"
                for i in deparmentRefName {
                    //                   i.division_id
                    
                    if i.division_name == item{
                        
                        
                        departmentCondentArry.append(i)
                        print("treeeeeeeeeee",departmentCondentArry)
                        
                        
                        //                                icon =  [
                        //                                    DepartItems(departmentId: i.department_name , departmentName: i.department_id )
                        //                                   
                        //                                ]
                        clone_listDepartment1.append(i)
                        
                    }
                    
                }
            }
            self.dropDownTextLabel.text = item
            
            
            
            //                    allview.isHidden = true
            
            tv.isHidden = false
            tv.delegate = self
            tv.dataSource = self
            tv.reloadData()
            
        }
        
        
        
        
        
    }
    
    
    
    else if courseView.backgroundColor == UIColor(named: "selectColor"){
        
        
        dropDown.dataSource =  courseFirstDropdownArry//4
        
        dropDown.anchorView = dropDownView //5
        
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        
        dropDown.direction = .bottom
        DropDown.appearance().backgroundColor = UIColor.white
        dropDown.show() //7
        
        
        dropDown.selectionAction = { [unowned self] (index:Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            
            //                    if(DefaultsKeys.resiverId.count>0){
            //                        DefaultsKeys.resiverId.removeAll()
            //                    }
            //
            clone_listcourse1.removeAll()
            courseCondentArry.removeAll()
            courseSecondtDropdownArry.removeAll()
            //            clone_listDepartment1.removeAll()
            tv.isHidden = true
            
            
            
            if index == 0{
                //                    NameIdCourse = "1"
                //                        departMents()
                
                courseDropDownView.isHidden = true
                
                for i in courseRefName {
                    
                    
                    
                    courseSecondtDropdownArry.append(i.department_name ?? "")
                    print("treeeeeeeeeee",departmentCondentArry)
                    courseCondentArry.append(i)
                    
                    
                    var newArray: [String] = []
                    newArray = ["--All Department--"]
                    for element in courseSecondtDropdownArry {
                        // Check if the element is not already in the new array
                        if !newArray.contains(element) {
                            // Add the unique element to the new array
                            newArray.append(element)
                        }
                    }
                    
                    
                    courseSecondtDropdownArry = newArray
                    
                    
                    
                }
                allview.isHidden = false
                allBtn.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                allBtn.isSelected = false
                
                tv.isHidden = false
                tv.delegate = self
                tv.dataSource = self
                tv.reloadData()
            }
            
            else{
                
                
                NameIdCourse = "2"
                
                courseDropDownView.isHidden = false
                for i in courseRefName {
                    
                    if i.division_name == item{
                        
                        
                        courseSecondtDropdownArry.append(i.department_name ?? "")
                        print("treeeeeeeeeee",departmentCondentArry)
                        courseCondentArry.append(i)
                        
                        clone_listcourse1.append(i)
                        
                    }
                    
                }
                
                var newArray: [String] = []
                newArray = ["--All Department--"]
                for element in courseSecondtDropdownArry {
                    // Check if the element is not already in the new array
                    if !newArray.contains(element) {
                        // Add the unique element to the new array
                        newArray.append(element)
                    }
                }
                
                coursedropTxtLabel.text = "--All Department--"
                
                courseSecondtDropdownArry = newArray
                
                allview.isHidden = true
                allViewTop.constant = -40
                tv.isHidden = false
                tv.delegate = self
                tv.dataSource = self
                tv.reloadData()
            }
            
            
            self.dropDownTextLabel.text = item
            
            
            
            
        }
        
    }
    
}


@IBAction func  courseDropDown(){
    
    
    //           
    //            allview.isHidden = false
    //            allBtn.setImage(UIImage.init(named: "checkboxs"), for: .normal)
    //            allBtn.isSelected = false
    //            
    //        tv.isHidden = false
    //        tv.delegate = self
    //        tv.dataSource = self
    //        tv.reloadData()
    
    coursedropTxtLabel.text = "--All Department--"
    dropDown.dataSource =  courseSecondtDropdownArry//4
    
    dropDown.anchorView = courseDropDownView //5
    
    dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
    
    dropDown.direction = .bottom
    DropDown.appearance().backgroundColor = UIColor.white
    dropDown.show() //7
    
    
    dropDown.selectionAction = { [unowned self] (index:Int, item: String) in
        print("Selected item: \(item) at index: \(index)")
        clone_listcourse1.removeAll()
        courseCondentArry.removeAll()
        
        
        if index == 0{
            NameIdCourse = "1"
            
            allview.isHidden = true
            if dropDownTextLabel.text == "--All Division--" &&  coursedropTxtLabel.text == "--All Department--"{
                
                
                tv.isHidden = false
                tv.delegate = self
                tv.dataSource = self
                
                tv.reloadData()
            }
            
            
            else{
                
                for i in courseRefName {
                    
                    if i.division_name == dropDownTextLabel.text{
                        
                        
                        //                            courseSecondtDropdownArry.append(i.department_name)
                        print("treeeeeeeeeee",departmentCondentArry)
                        courseCondentArry.append(i)
                        
                        
                        
                    }
                    
                }
                
                
                //                        allview.isHidden = false
                //                        allBtn.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                //                        allBtn.isSelected = false
                //                        
                tv.isHidden = false
                tv.delegate = self
                tv.dataSource = self
                tv.reloadData()
            }
        }
        
        else{
            
            NameIdCourse = "2"
            
            for i in courseRefName {
                
                if i.department_name == item{
                    
                    
                    //                            courseSecondtDropdownArry.append(i.department_name)
                    print("treeeeeeeeeee",departmentCondentArry)
                    courseCondentArry.append(i)
                    
                    clone_listcourse1.append(i)
                    
                }
                
            }
            
            allview.isHidden = true
            allViewTop.constant = -40
            tv.isHidden = false
            tv.delegate = self
            tv.dataSource = self
            tv.reloadData()
        }
        
        self.coursedropTxtLabel.text = item
    }
    
    
    
    
    
    
    
    
    
}

func devision(){
    
    allview.isHidden = true
    tv.isHidden = true
    
    var devisions = getDivisionModal()
    
    devisions.college_id = collegeId
    devisions.user_id =  memberId
    
    APiCallManager.shared.callApi(
        url: APIEndpoints.GetDivisions,
        httpMethod: .post,
        queryParam: nil,
        requestBody: devisions
    ) {[weak self] (result:Result<GetDivisionResponce, Error>) in
            
        guard let self = self else { return }
        
        switch result {
        case .success(let success):
            
            devisionRefName = success.data ?? []
            clone_listDevision = success.data ?? []
            
            if success.Status == 1 {
                
                for i in success.data ?? []{
                    strs.append(i.division_name ?? "")
                }
                
                allViewTop.constant = -130
                allview.isHidden = false
                allBtn.isHidden = false
                tv.isHidden  = false
                tv.delegate = self
                tv.dataSource = self
                tv.reloadData()
                
            }else{
                
                tv.delegate = self
                tv.dataSource = self
                tv.reloadData()
                
            }
            
        case .failure(let failure):
            print("Error:",failure.localizedDescription)
        }
        
        }
}






func Group(){
    
    var groups = GetGroupModal()
    
    groups.idcollege = collegeId
    
    APiCallManager.shared.callApi(
            url: APIEndpoints.GetGrouplist,
            httpMethod: .post,
            queryParam: nil,
            requestBody: groups
        ) {[weak self] (result:Result<GetGroupResponce, Error>) in
                
            guard let self = self else { return }
            
            switch result {
            case .success(let success):
                
                if success.Status == 1 {
                    groupRefName = success.data ?? []
                    clone_listgroup = success.data ?? []
                    allViewTop.constant = -130
                    allview.isHidden = false
                    allBtn.isHidden = false
                    tv.isHidden = false
                    tv.delegate = self
                    tv.dataSource = self
                    tv.reloadData()
                } else {
                    
                    tv.isHidden = false
                    tv.delegate = self
                    tv.dataSource = self
                    tv.reloadData()
                }
                
            case .failure(let failure):
                 print("Error:",failure.localizedDescription)
            }
            
            }
}



func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    
    
    
    if devisionView.backgroundColor == UIColor(named: "selectColor"){
        return devisionRefName.count
    }
    
    else if departmentView.backgroundColor == UIColor(named: "selectColor"){
        
        print("departsdfgfd")
        
        if   NameId == "2"{
            
            return departmentCondentArry.count
            
        }
        else{
            return deparmentRefName.count
        }
        
        
    }
    
    else if groupView.backgroundColor == UIColor(named: "selectColor"){
        
        return groupRefName.count
        
    }
    
    else if courseView.backgroundColor == UIColor(named: "selectColor"){
        
        //                print("thiid",courseRefName.count)
        
        
        
        if NameIdCourse == "2"{
            
            
            return courseCondentArry.count
        }
        
        else if NameIdCourse == "1"{
            
            return courseCondentArry.count
            
        }
        
        else if NameIdCourse == "3" {
            
            
            return courseRefName.count
        }
        
    }
    
    
    return 0
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as!
    
    SelectRespienceCellTableViewCell
    
    
    
    
    
    
    
    
    if devisionView.backgroundColor == UIColor(named: "selectColor"){
        
        resiverType = "8"
        
        
        
        let devi : getDivisonDataDetails = devisionRefName[indexPath.row]
        
        
        
        cell.nameLabel.text = devi.division_name
        
        
        
        if devi.isSelected == true
        {
            
            cell.checkboxess.isChecked = true
            
        }else
        {
            
            
            
            cell.checkboxess.isChecked = false
        }
        let selectedGesture = CheckBoxEntier(target: self, action: #selector(changeSelection))
        selectedGesture.checkBoxss = cell.checkboxess
        selectedGesture.memberidssss = devi.division_id
        selectedGesture.bool = devi.isSelected
        selectedGesture.pos = indexPath.row
        cell.checkboxess.addGestureRecognizer(selectedGesture)
        
        
        
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
        
        
        if DefaultsKeys.resiverId.count == 0 {
            
            
            if NameId == "2"{
                
                
                
                let depart : RepienceDeparmentDataDetails = departmentCondentArry[indexPath.row]
                
                
                
                cell.nameLabel.text = depart.department_name
                
                cell.checkboxess.isChecked = false
                
                
                
                
                
                if depart.isSelected == true
                {
                    
                    cell.checkboxess.isChecked = true
                    
                }else
                {
                    
                    
                    cell.checkboxess.isChecked = false
                }
                let selectedGesture = CheckBoxEntier(target: self, action: #selector(changeSelection))
                selectedGesture.checkBoxss = cell.checkboxess
                selectedGesture.memberidssss = depart.department_id
                selectedGesture.bool = depart.isSelected
                selectedGesture.pos = indexPath.row
                cell.checkboxess.addGestureRecognizer(selectedGesture)
                
                
            }else{
                
                
                
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
                let selectedGesture = CheckBoxEntier(target: self, action: #selector(changeSelection))
                selectedGesture.checkBoxss = cell.checkboxess
                selectedGesture.memberidssss = depart.department_id
                selectedGesture.bool = depart.isSelected
                selectedGesture.pos = indexPath.row
                cell.checkboxess.addGestureRecognizer(selectedGesture)
                
                
            }
            
            
            
        }else{
            
            
            
            
            if NameId == "2"{
                
                
                
                let depart : RepienceDeparmentDataDetails = departmentCondentArry[indexPath.row]
                
                
                
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
                
                
                if  DefaultsKeys.resiverId.contains(depart.department_id ?? ""){
                    
                    
                    cell.checkboxess.setImage(UIImage.init(named: "done"), for: .normal)
                }else{
                    
                    cell.checkboxess.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                }
                
                
                
                let selectedGesture = CheckBoxEntier(target: self, action: #selector(changeSelection))
                selectedGesture.checkBoxss = cell.checkboxess
                selectedGesture.memberidssss = depart.department_id
                selectedGesture.bool = depart.isSelected
                selectedGesture.pos = indexPath.row
                cell.checkboxess.addGestureRecognizer(selectedGesture)
                
                
            }else{
                
                
                
                let depart : RepienceDeparmentDataDetails = deparmentRefName[indexPath.row]
                
                
                
                cell.nameLabel.text = depart.department_name
                
                cell.checkboxess.isChecked = false
                
                
                
                
                
                if depart.isSelected == true
                {
                    
                    cell.checkboxess.isChecked = true
                    
                }else
                {
                    
                    
                    cell.checkboxess.isChecked = false
                }
                
                
                if  DefaultsKeys.resiverId.contains(depart.department_id ?? ""){
                    
                    
                    cell.checkboxess.setImage(UIImage.init(named: "done"), for: .normal)
                }else{
                    
                    cell.checkboxess.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                }
                let selectedGesture = CheckBoxEntier(target: self, action: #selector(changeSelection))
                selectedGesture.checkBoxss = cell.checkboxess
                selectedGesture.memberidssss = depart.department_id
                selectedGesture.bool = depart.isSelected
                selectedGesture.pos = indexPath.row
                cell.checkboxess.addGestureRecognizer(selectedGesture)
                
                
            }
            
        }
        
        
        
    }
    
    else if groupView.backgroundColor == UIColor(named: "selectColor"){
        
        resiverType = "6"
        
        let group : getGroupDataDetails = groupRefName[indexPath.row]
        cell.nameLabel.text = group.groupname
        cell.checkboxess.isChecked = false
        
        
        let defaults = String(group.groupid ?? 0)
        
        if group.isSelected == true
        {
            
            cell.checkboxess.isChecked = true
            
        }else
        {
            
            
            
            
            cell.checkboxess.isChecked = false
        }
        let selectedGesture = CheckBoxEntier(target: self, action: #selector(changeSelection))
        selectedGesture.checkBoxss = cell.checkboxess
        selectedGesture.memberidssss = defaults
        selectedGesture.bool = group.isSelected
        selectedGesture.pos = indexPath.row
        cell.checkboxess.addGestureRecognizer(selectedGesture)
        
        
    }
    
    
    
    else if courseView.backgroundColor == UIColor(named: "selectColor"){
        resiverType = "2"
        
        
        if courseRefName.count == DefaultsKeys.resiverId.count{
            
            
            allBtn.isSelected = true
            allBtn.setImage(UIImage.init(named: "done"), for: .normal)
            
        }
        
        
        else{
            
            allBtn.isSelected = false
            allBtn.setImage(UIImage.init(named: "checkboxs"), for: .normal)
            
        }
        
        
        if DefaultsKeys.resiverId.count == 0{
            
            
            
            if NameIdCourse == "2"{
                
                let coursee : getCourseDataDetails = courseCondentArry[indexPath.row]
                cell.nameLabel.text = coursee.course_name
                cell.checkboxess.isChecked = false
                
                
                if coursee.isSelected == true
                {
                    
                    cell.checkboxess.isChecked = true
                    
                }else
                {
                    
                    
                    
                    cell.checkboxess.isChecked = false
                }
                
                
                if  DefaultsKeys.resiverId.contains(coursee.course_id ?? ""){
                    
                    
                    cell.checkboxess.setImage(UIImage.init(named: "done"), for: .normal)
                }else{
                    
                    cell.checkboxess.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                }
                
                let selectedGesture = CheckBoxEntier(target: self, action: #selector(changeSelection))
                selectedGesture.checkBoxss = cell.checkboxess
                selectedGesture.memberidssss = coursee.course_id
                selectedGesture.bool = coursee.isSelected
                selectedGesture.pos = indexPath.row
                cell.checkboxess.addGestureRecognizer(selectedGesture)
                
            }
            else if NameIdCourse == "1"{
                
                
                let coursee : getCourseDataDetails = courseCondentArry[indexPath.row]
                cell.nameLabel.text = coursee.course_name
                cell.checkboxess.isChecked = false
                
                
                if coursee.isSelected == true
                {
                    
                    cell.checkboxess.isChecked = true
                    
                }else
                {
                    
                    
                    
                    cell.checkboxess.isChecked = false
                }
                
                
                if  DefaultsKeys.resiverId.contains(coursee.course_id ?? ""){
                    
                    
                    cell.checkboxess.setImage(UIImage.init(named: "done"), for: .normal)
                }else{
                    
                    cell.checkboxess.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                }
                
                let selectedGesture = CheckBoxEntier(target: self, action: #selector(changeSelection))
                selectedGesture.checkBoxss = cell.checkboxess
                selectedGesture.memberidssss = coursee.course_id
                selectedGesture.bool = coursee.isSelected
                selectedGesture.pos = indexPath.row
                cell.checkboxess.addGestureRecognizer(selectedGesture)
                
                
                
            }
            else if NameIdCourse == "3"{
                
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
                
                if  DefaultsKeys.resiverId.contains(coursee.course_id ?? ""){
                    
                    
                    cell.checkboxess.setImage(UIImage.init(named: "done"), for: .normal)
                }else{
                    
                    cell.checkboxess.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                }
                
                
                let selectedGesture = CheckBoxEntier(target: self, action: #selector(changeSelection))
                selectedGesture.checkBoxss = cell.checkboxess
                selectedGesture.memberidssss = coursee.course_id
                selectedGesture.bool = coursee.isSelected
                selectedGesture.pos = indexPath.row
                cell.checkboxess.addGestureRecognizer(selectedGesture)
                
            }
            
        }
        else{
            
            
            if NameIdCourse == "2"{
                
                let coursee : getCourseDataDetails = courseCondentArry[indexPath.row]
                cell.nameLabel.text = coursee.course_name
                cell.checkboxess.isChecked = false
                
                
                if coursee.isSelected == true
                {
                    
                    cell.checkboxess.isChecked = true
                    
                }else
                {
                    
                    
                    
                    cell.checkboxess.isChecked = false
                }
                
                
                if  DefaultsKeys.resiverId.contains(coursee.course_id ?? ""){
                    
                    
                    cell.checkboxess.setImage(UIImage.init(named: "done"), for: .normal)
                }else{
                    
                    cell.checkboxess.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                }
                
                let selectedGesture = CheckBoxEntier(target: self, action: #selector(changeSelection))
                selectedGesture.checkBoxss = cell.checkboxess
                selectedGesture.memberidssss = coursee.course_id
                selectedGesture.bool = coursee.isSelected
                selectedGesture.pos = indexPath.row
                cell.checkboxess.addGestureRecognizer(selectedGesture)
                
            }
            else if NameIdCourse == "1"{
                
                
                let coursee : getCourseDataDetails = courseCondentArry[indexPath.row]
                cell.nameLabel.text = coursee.course_name
                cell.checkboxess.isChecked = false
                
                
                if coursee.isSelected == true
                {
                    
                    cell.checkboxess.isChecked = true
                    
                }else
                {
                    
                    
                    
                    cell.checkboxess.isChecked = false
                }
                
                
                if  DefaultsKeys.resiverId.contains(coursee.course_id ?? ""){
                    
                    
                    cell.checkboxess.setImage(UIImage.init(named: "done"), for: .normal)
                }else{
                    
                    cell.checkboxess.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                }
                
                let selectedGesture = CheckBoxEntier(target: self, action: #selector(changeSelection))
                selectedGesture.checkBoxss = cell.checkboxess
                selectedGesture.memberidssss = coursee.course_id
                selectedGesture.bool = coursee.isSelected
                selectedGesture.pos = indexPath.row
                cell.checkboxess.addGestureRecognizer(selectedGesture)
                
                
                
            }
            
            else if NameIdCourse == "3" {
                
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
                
                
                if  DefaultsKeys.resiverId.contains(coursee.course_id ?? ""){
                    
                    
                    cell.checkboxess.setImage(UIImage.init(named: "done"), for: .normal)
                }else{
                    
                    cell.checkboxess.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                }
                
                
                let selectedGesture = CheckBoxEntier(target: self, action: #selector(changeSelection))
                selectedGesture.checkBoxss = cell.checkboxess
                selectedGesture.memberidssss = coursee.course_id
                selectedGesture.bool = coursee.isSelected
                selectedGesture.pos = indexPath.row
                cell.checkboxess.addGestureRecognizer(selectedGesture)
                
            }
        }
        
        
        
    }
    return cell
    
}





@IBAction func checkBoxIdss(gestur : selectResipenceCheckBox ){
    
    
    
    if gestur.checkBoxss.isChecked == true{
        
        gestur.checkBoxss.setImage(UIImage.init(named: "checkboxs"), for: .normal)
        
        
        DefaultsKeys.resiverId.removeLast()
        
        gestur.checkBoxss.isChecked = false
        
    }
    
    
    else{
        
        
        gestur.checkBoxss.setImage(UIImage.init(named: "done"), for: .normal)
        
        
        
        
        
        let myString = String(gestur.boxId)
        print(type(of: myString)) // String
        
        
        
        DefaultsKeys.resiverId.append(myString)
        
        nameString =  DefaultsKeys.resiverId.joined(separator: "~")
        
        
        gestur.checkBoxss.isChecked = true
        
        
    }
    
}


func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    return UITableView.automaticDimension
}


@IBAction func sendVc(){
    
    nameString = DefaultsKeys.resiverId.joined(separator: "~")
    
    if entireClgView.backgroundColor == UIColor(named: "selectColor"){
        
        if (staffCheckBoxView.isChecked == true) || (parentsCheckBoxView.isChecked == true) || (studentCheckBoxView.isChecked == true) {
            
            let refreshAlert = UIAlertController(title: "Hold on!", message: "Are you sure you want to submit?", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [self] (action: UIAlertAction!) in
                
                EntierId = "1"
                
                if self.resivre == "1"{
                    
                    if fileType == "pdf"{
                        
                        
                        print("pdfDatapdfDatapdfData",pdfData)
                        
                        uploadPDFFileToAWS(pdfData : pdfData! as NSData)
                    }
                    
                    else{
                        
                        
                        
                        
                        getImageURL(images: photoArray)
                        
                        
                        
                        DispatchQueue.main.asyncAfter(deadline: .now()+4.3) { [self] in
                            
                            KRProgressHUD.dismiss()
                            
                            
                            
                            
                            
                            NoticeSendSmsEntier(ImageFile: awsArry)
                            
                        }
                        
                    }
                    //                            self.NoticeSendSmsEntier()
                    
                    
                }
                
                else if self.resivre == "2"{
                    
                    print("video")
                    
                    self.videoUpload()
                    
                }
                
                else if self.resivre == "3"{
                    
                    self.EventEntier()
                    print("event545454454")
                    
                }
                
                else if self.resivre == "4"{
                    
                    
                    print("communication")
                    
                    self.CommunicationEntierSms()
                    
                    
                }
                
                
                else if self.resivre == "5"{
                    print("imagePdf")
                    if fileType == "3"{
                        
                        
                        
                        uploadPDFFileToAWS(pdfData : pdfData! as NSData)
                    }
                    
                    else{
                        
                        getImageURL(images: photoArray)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now()+4.3) { [self] in
                            
                            KRProgressHUD.dismiss()
                            
                            ImagePdfEntier(ImageFile: awsArry)
                            
                        }
                        
                    }
                }
                
                else if self.resivre == "11"{
                    
                    
                    if VoiceHstryId == "1"{
                        self.multypartAudio()
                        
                    }else if VoiceHstryId == "2"{
                        
                        self.HistoryVoiceSend()
                    }
                    
                    
                    
                }
                
                else if self.resivre == "13"{
                    
                    
                    self.EventEntier()
                    
                }
                
            }))
            
            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                print("Handle Cancel Logic here")
            }))
            
            present(refreshAlert, animated: true, completion: nil)
            
            
            
            
            
            
            
        }
        
        else{
            
            
            let refreshAlert = UIAlertController(title: "", message: "Select Target", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                
                
                
                
            }))
            
            present(refreshAlert, animated: true, completion: nil)
            
            
            
            
            
            
        }
    }
    
    
    
    
    else  if devisionView.backgroundColor == UIColor(named: "selectColor") || departmentView.backgroundColor == UIColor(named: "selectColor") || groupView.backgroundColor == UIColor(named: "selectColor") || courseView.backgroundColor == UIColor(named: "selectColor") {
        
        
        
        
        if (staffCheckBoxView.isChecked == true) || (parentsCheckBoxView.isChecked == true) || (studentCheckBoxView.isChecked == true) {
            
            
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
                
                let refreshAlert = UIAlertController(title: "Are you sure you want to submit?", message:AlertMessage + String(DefaultsKeys.resiverId.count) , preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [self] (action: UIAlertAction!) in
                    
                    if self.resivre == "1"{
                        
                        
                        print("Notice")
                        
                        if fileType == "pdf"{
                            
                            
                            
                            uploadPDFFileToAWS(pdfData : pdfData! as NSData)
                        }
                        
                        else{
                            
                            
                            
                            
                            getImageURL(images: photoArray)
                            
                            
                            
                            DispatchQueue.main.asyncAfter(deadline: .now()+4.3) { [self] in
                                
                                KRProgressHUD.dismiss()
                                
                                
                                
                                self.NoticeSendSmsToParticular(ImageFile: awsArry)
                                
                                
                                
                            }
                            
                        }
                        
                        
                        
                        
                        
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
                        
                        if fileType == "3"{
                            
                            
                            
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
                        
                        print("this voiceee testinggg")
                        if VoiceHstryId == "1"{
                            print("this voiceee 333333")
                            self.multypartAudioParticular()
                            
                        }else if VoiceHstryId == "2"{
                            
                            self.HistoryVoiceSend()
                        }
                        
                        
                        
                    }
                    
                    else if self.resivre == "13"{
                        
                        
                        self.EventEntier()
                        
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
    
    
    
    
    
    
    
    
    
    
    else{
        
        
        //
        
        
        
        let refreshAlert = UIAlertController(title: "", message: "Select Target", preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            
            
            
            
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
    //        }
    
    
    
    
    
}



@IBAction func EntierclgViewVc() {
    
    
    
    staflDefautLabel.isHidden = false
    staffCheckBoxView.isHidden = false
    allBtn.setImage(UIImage.init(named: "checkboxs"), for: .normal)
    allBtn.isSelected = false
    
    
    searchOverllAllView.isHidden = true
    devisionDropdownTopCon.constant = -30
    
    
    
    if(DefaultsKeys.resiverId.count>0){
        DefaultsKeys.resiverId.removeAll()
    }
    
    
    
    if priority == "p7"{
        
        if entireClgView.isUserInteractionEnabled == true {
            //
            //                topIdentificationLabel.text = "College List"
            
            //                tvTop.isHidden = true
            //                tv.isHidden = true
            //
            tv.isHidden = false
            tvTop.isHidden = false
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
            //                allViewTop.constant = -50
            //                allViewTop.constant = -200
            colgList()
            
        }else {
            
            entireClgView.isUserInteractionEnabled = false
            
            
            print("clickedOff")
            
        }
        
        
    }else{
        
        
        
        if entireClgView.isUserInteractionEnabled == true {
            
            tvTop.isHidden = true
            tv.isHidden = true
            
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
            
            
        }else {
            
            entireClgView.isUserInteractionEnabled = false
            
            
            print("clickedOff")
            
        }
    }
    
}
@IBAction func devisionVc() {
    
    
    AlertMessage = "Selected Division count :"
    staflDefautLabel.isHidden = false
    staffCheckBoxView.isHidden = false
    allBtn.setImage(UIImage.init(named: "checkboxs"), for: .normal)
    allBtn.isSelected = false
    searchOverllAllView.isHidden = true
    devisionDropdownTopCon.constant = -30
    if(DefaultsKeys.resiverId.count>0){
        DefaultsKeys.resiverId.removeAll()
    }
    
    
    
    
    if devisionView.isUserInteractionEnabled == true {
        //                topIdentificationLabel.text = "Division"
        
        dropDownView.isHidden = true
        courseDropDownView.isHidden = true
        tv.isHidden = false
        tvTop.isHidden = false
        
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
        
        devision()
        
        
        
        
        
        
        
    }else {
        
        devisionView.isUserInteractionEnabled = false
        
        print("clickedOff")
        
    }
    
    
    
    
}




@IBAction func departmentVc (){
    
    AlertMessage = "Selected Department count :"
    staflDefautLabel.isHidden = false
    staffCheckBoxView.isHidden = false
    allBtn.setImage(UIImage.init(named: "checkboxs"), for: .normal)
    allBtn.isSelected = false
    
    searchOverllAllView.isHidden = false
    devisionDropdownTopCon.constant = 15
    if(DefaultsKeys.resiverId.count>0){
        DefaultsKeys.resiverId.removeAll()
    }
    
    
    if priority == "p7"{
        
        
        
        if clgIdArry.count == 1{
            
            
            
            
            if departmentView.isUserInteractionEnabled == true{
                //                    topIdentificationLabel.text = "Department"
                dropDownTextLabel.text = "--All Division--"
                dropDownView.isHidden = false
                courseDropDownView.isHidden = true
                //            tvTopConstain.constant = 0
                tv.isHidden = true
                tvTop.isHidden = false
                //            departmentView.isUserInteractionEnabled = false
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
                
                
                allViewTop.constant = -50
                
                if  dropDownTextLabel.text == "--SelectDivision--"{
                    
                    allview.isHidden = true
                    
                }
                
                else{
                    
                    allview.isHidden = false
                    
                }
                
                
            }else {
                
                departmentView.isUserInteractionEnabled = false
                
                
                print("clickedOff")
                
            }
            
            
            
            
            
            
        }
        
        else{
            
            
            
            let refreshAlert = UIAlertController(title: "", message: "Please Select Your College", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
                
            }))
            
            
            
            present(refreshAlert, animated: true, completion: nil)
            
            
        }
        
        
        
        
        
    }else{
        
        
        
        if departmentView.isUserInteractionEnabled == true{
            //                topIdentificationLabel.text = "Department"
            dropDownTextLabel.text = "--All Division--"
            dropDownView.isHidden = false
            courseDropDownView.isHidden = true
            
            tv.isHidden = true
            tvTop.isHidden = false
            
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
            
            
            allViewTop.constant = -50
            
            if  dropDownTextLabel.text == "--All Division--"{
                
                allview.isHidden = true
                
            }
            
            else{
                
                allview.isHidden = false
                
            }
            
            
            departMents()
            
        }else {
            
            departmentView.isUserInteractionEnabled = false
            
            
            print("clickedOff")
            
        }
        
        
    }
    
    
}

@IBAction func course(){
    
    AlertMessage = "Selected course count :"
    NameIdCourse = "3"
    staflDefautLabel.isHidden = true
    staffCheckBoxView.isHidden = true
    staffCheckBoxView.isChecked = false
    allBtn.setImage(UIImage.init(named: "checkboxs"), for: .normal)
    allBtn.isSelected = false
    
    searchOverllAllView.isHidden = false
    devisionDropdownTopCon.constant = 15
    
    if(DefaultsKeys.resiverId.count>0){
        DefaultsKeys.resiverId.removeAll()
    }
    IDforStaffCheck = "1"
    
    
    
    if priority == "p7"{
        
        
        
        if ClgListClgId == ""  || ClgListClgId == nil{
            
            
            
            let refreshAlert = UIAlertController(title: "", message: "Please Select Your College", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
                
            }))
            
            
            
            present(refreshAlert, animated: true, completion: nil)
             
        }
         
        else{
            
            if courseView.isUserInteractionEnabled == true {
                //
                //                    topIdentificationLabel.text = "Course"
                coursedropTxtLabel.text =  "--All Department--"
                dropDownTextLabel.text = "--All Division--"
                tv.isHidden = true
                dropDownView.isHidden = false
                courseDropDownView.isHidden = false
                tvTop.isHidden = false
                
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
                
                if  coursedropTxtLabel.text == "--All Department--"  &&  dropDownTextLabel.text == "--All Division--"{
                    
                    allview.isHidden = true
                    
                }
                else{
                    
                    allview.isHidden = false
                }
                allViewTop.constant = -40
                
            }else {
                
                courseView.isUserInteractionEnabled = false
                  
            }
        }
        
    }else{
        
        if courseView.isUserInteractionEnabled == true {
            //
            //                topIdentificationLabel.text = "Course"
            coursedropTxtLabel.text =  "--All Department--"
            dropDownTextLabel.text = "--All Division--"
            tv.isHidden = true
            dropDownView.isHidden = false
            //                courseDropDownView.isHidden = false
            tvTop.isHidden = false
            
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
            
            if  coursedropTxtLabel.text == "--All Department--"  &&  dropDownTextLabel.text == "--All Division--"{
                
                allview.isHidden = true
                
            }
            
            
            
            else{
                
                allview.isHidden = false
                
            }
            allViewTop.constant = -40
            allview.isHidden = false
            courseApi()
            
        }else {
            
            courseView.isUserInteractionEnabled = false
            
            
            
        }
        
        
    }
    
    
    
    
    
}



@IBAction func yourClassFunction () {
    
    
    
    staflDefautLabel.isHidden = false
    staffCheckBoxView.isHidden = false
    allBtn.setImage(UIImage.init(named: "checkboxs"), for: .normal)
    allBtn.isSelected = false
    searchOverllAllView.isHidden = true
    devisionDropdownTopCon.constant = -30
    if(DefaultsKeys.resiverId.count>0){
        DefaultsKeys.resiverId.removeAll()
    }
    if  yourClassesView.isUserInteractionEnabled == true {
        
        
        
        tv.isHidden = true
        dropDownView.isHidden = true
        courseDropDownView.isHidden = true
        tvTop.isHidden = true
        yourClassesView.backgroundColor = UIColor(named: "selectColor")
        
        departmentLabel.textColor = UIColor(named: "clickView")
        courseLabel.textColor = UIColor(named: "clickView")
        devisionTabel.textColor = UIColor(named: "clickView")
        yourClassLabel.textColor = UIColor(named: "clickView")
        groupLabel.textColor = UIColor(named: "clickView")
        entierClgLbl.textColor = UIColor(named: "clickView")
        courseView.backgroundColor = UIColor.white
        yourClassLabel.textColor = UIColor.white
        devisionView.backgroundColor = UIColor.white
        departmentView.backgroundColor = UIColor.white
        groupView.backgroundColor = UIColor.white
        entireClgView.backgroundColor = UIColor.white
        
        
        if priority == "p1"{
            let vc = HodRespienViewController(nibName: nil, bundle: nil)
            
            if VoiceHstryId == "1" || VoiceHstryId == "2"{
                vc.VoiceHstryId = VoiceHstryId
                vc.voiceHstryHeaderId = voiceHstryHeaderId
                
            }
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.view.backgroundColor = UIColor(named: "Principal")
            vc.resivre = resivre
            vc.imageFileType = fileType
            vc.titlesTextField = titlesTextField
            vc.discreptionss = discreptionss
            vc.DateLabels = DateLabels
            vc.venumtextField = VenuTestField
            vc.awsurl = awsurl
            vc.videoURL = videoVimeoUrl
            vc.videoIframe = videoIframe
            print("Passing voiceUrl:", voiceUrl)
            vc.voiceUrl = voiceUrl
            vc.EventTime = EventTime
            vc.voiceDuration = voiceDuration
            vc.str = str
            vc.strName = strName
            
            vc.photoArray = photoArray
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true,completion: nil)
            
            print("yourClassFucntion")
        }
        else if priority == "p7"{
            let vc = HodRespienViewController(nibName: nil, bundle: nil)
            if VoiceHstryId == "1" || VoiceHstryId == "2"{
                vc.VoiceHstryId = VoiceHstryId
                vc.voiceHstryHeaderId = voiceHstryHeaderId
                
            }else{
                
                
            }
            
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.view.backgroundColor = UIColor(named: "univercityColorCod")
            vc.resivre = resivre
            vc.imageFileType = fileType
            vc.titlesTextField = titlesTextField
            vc.discreptionss = discreptionss
            vc.DateLabels = DateLabels
            vc.venumtextField = VenuTestField
            vc.awsurl = awsurl
            vc.videoURL = videoVimeoUrl
            vc.videoIframe = videoIframe
            vc.voiceUrl = voiceUrl
            vc.EventTime = EventTime
            vc.voiceDuration = voiceDuration
            vc.str = str
            vc.strName = strName
            
            vc.photoArray = photoArray
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true,completion: nil)
            
            print("yourClassFucntion")
        }
        
        else{
            
            
            let vc = HodRespienViewController(nibName: nil, bundle: nil)
            if VoiceHstryId == "1" || VoiceHstryId == "2"{
                vc.VoiceHstryId = VoiceHstryId
                vc.voiceHstryHeaderId = voiceHstryHeaderId
                
            }else{
                
                
            }
            
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.resivre = resivre
            vc.imageFileType = fileType
            vc.titlesTextField = titlesTextField
            vc.discreptionss = discreptionss
            vc.DateLabels = DateLabels
            vc.venumtextField = VenuTestField
            vc.awsurl = awsurl
            vc.videoURL = videoVimeoUrl
            vc.videoIframe = videoIframe
            vc.voiceUrl = voiceUrl
            vc.str = str
            vc.strName = strName
            vc.voiceDuration = voiceDuration
            vc.EventTime = EventTime
            
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true,completion: nil)
            
            print("yourClassFucntion")
        }
        
        
    }else {
        
        yourClassesView.isUserInteractionEnabled = false
        
        
    }
    
}



@IBAction func groupVC() {
    
    AlertMessage = "Selected group count :"
    
//    staflDefautLabel.isHidden = true
//    staffCheckBoxView.isHidden = true
    staflDefautLabel.isHidden = false
    staffCheckBoxView.isHidden = false
    staffCheckBoxView.isChecked = false
    allBtn.setImage(UIImage.init(named: "checkboxs"), for: .normal)
    allBtn.isSelected = false
    searchOverllAllView.isHidden = true
    devisionDropdownTopCon.constant = -30
    if(DefaultsKeys.resiverId.count>0){
        DefaultsKeys.resiverId.removeAll()
    }
//    IDforStaffCheck = "1"
    
    if   groupView.isUserInteractionEnabled == true {
        
        
        courseDropDownView.isHidden = true
        dropDownView.isHidden = true
        
        //            topIdentificationLabel.text = "Group"
        tvTop.isHidden = false
        dropDownView.isHidden = true
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
        
        Group()
        
    }else {
        
        groupView.isUserInteractionEnabled = false
        
        
        print("clickedOff")
        
    }
    
    
    
    
}












@IBAction func StudentCheckBoxVc(){
    
    
    if studentCheckBoxView.isChecked == true{
        
        
        
        studentCheckBoxView.isChecked = false
        print("okkkdsdxs",allCheckbox.isChecked)
        
        
        studentCheckBoxView.setImage(UIImage.init(named: "checkboxs"), for: .normal)
        
        
        allCheckbox.isChecked = false
        
        if parentTargetEnagbel == "0"{
            if   studentCheckBoxView.isChecked == true || staffCheckBoxView.isChecked == true{
                
                allCheckbox.isChecked = false
                
            }
        }else{
            
            
            if   studentCheckBoxView.isChecked == true  || parentsCheckBoxView.isChecked == true || staffCheckBoxView.isChecked == true{
                
                allCheckbox.isChecked = false
                
            }
            
        }
    }
    //
    else if studentCheckBoxView.isChecked == false{
        
        
        studentCheckBoxView.isChecked = true
        print("okkkd",studentCheckBoxView.isChecked)
        studentCheckBoxView.setImage(UIImage.init(named: "done"), for: .normal)
        
        
        if parentTargetEnagbel == "0"{
            if   studentCheckBoxView.isChecked == true && staffCheckBoxView.isChecked == true{
                
                allCheckbox.isChecked = true
                
            }
        }else{
            
            
            if studentCheckBoxView.isChecked == true  && parentsCheckBoxView.isChecked == true && staffCheckBoxView.isChecked == true{
                
                allCheckbox.isChecked = true
                
            }
        }
    }
}

@IBAction func allCheckboxvc(){
    
    if parentTargetEnagbel == "0"{
        
        
        //            if checkboxcount.count == 2 {
        //
        //                targetAllCheckBoxView.isChecked = true
        //
        //            }
        if allCheckbox.isChecked == true{
            
            
            
            
            
            allCheckbox.isChecked = false
            allCheckbox.setImage(UIImage.init(named: "checkboxs"), for: .normal)
            parentsCheckBoxView.isChecked = false
            staffCheckBoxView.isChecked =  false
            studentCheckBoxView.isChecked = false
            
            
            
            
            print("UNCheck")
            
            
        } else if allCheckbox.isChecked == false  {
            
            //                if checkboxcount.count == 2 {
            //
            //                    targetAllCheckBoxView.isChecked = true
            //
            //                }
            allCheckbox.isChecked = true
            allCheckbox.setImage(UIImage.init(named: "done"), for: .normal)
            staffCheckBoxView.isChecked =  true
            parentsCheckBoxView.isChecked = false
            studentCheckBoxView.isChecked =  true
            
            
            
            
            
        }
        
        
        
    }
    
    else{
        if allCheckbox.isChecked == true{
            
            allCheckbox.isChecked = false
            allCheckbox.setImage(UIImage.init(named: "checkboxs"), for: .normal)
            parentsCheckBoxView.isChecked = false
            staffCheckBoxView.isChecked =  false
            studentCheckBoxView.isChecked = false
            
            
            print("UNCheck")
            
            
        } else if allCheckbox.isChecked == false  {
            
            allCheckbox.isChecked = true
            allCheckbox.setImage(UIImage.init(named: "done"), for: .normal)
            
            parentsCheckBoxView.isChecked = true
            staffCheckBoxView.isChecked =  true
            
        }
        
    }
    
    
    
}

@IBAction func parentCheckBoxVc(){
    
    
    
    if parentsCheckBoxView.isChecked == true{
        
        parentsCheckBoxView.isChecked = false
        parentsCheckBoxView.setImage(UIImage.init(named: "checkboxs"), for: .normal)
        //
        allCheckbox.isChecked = false
        
        
        if parentTargetEnagbel == "0"{
            if   studentCheckBoxView.isChecked == true || staffCheckBoxView.isChecked == true{
                
                allCheckbox.isChecked = false
                
            }
        }else{
            
            
            if   studentCheckBoxView.isChecked == true  || parentsCheckBoxView.isChecked == true || staffCheckBoxView.isChecked == true{
                
                allCheckbox.isChecked = false
                
            }
            
        }
    } else if parentsCheckBoxView.isChecked == false  {
        
        parentsCheckBoxView.isChecked = true
        parentsCheckBoxView.setImage(UIImage.init(named: "done"), for: .normal)
        
        
        if parentTargetEnagbel == "0"{
            if   studentCheckBoxView.isChecked == true && staffCheckBoxView.isChecked == true{
                
                allCheckbox.isChecked = true
                
            }
        }else{
            
            
            if   studentCheckBoxView.isChecked == true  && parentsCheckBoxView.isChecked == true && staffCheckBoxView.isChecked == true{
                
                allCheckbox.isChecked = true
                
            }
            
        }
        
        
    }
    
    
    
    
}



@IBAction func staffCheckBoxVC(){
    
    
    
    
    
    
    if staffCheckBoxView.isChecked == true {
        
        staffCheckBoxView.isChecked = false
        staffCheckBoxView.setImage(UIImage.init(named: "checkboxs"), for: .normal)
        allCheckbox.isChecked = false
        
        if parentTargetEnagbel == "0"{
            if   studentCheckBoxView.isChecked == true || staffCheckBoxView.isChecked == true{
                
                allCheckbox.isChecked = false
                
            }
        }else{
            
            
            if   studentCheckBoxView.isChecked == true  || parentsCheckBoxView.isChecked == true || staffCheckBoxView.isChecked == true{
                
                allCheckbox.isChecked = false
                
            }
            
        }
        
    } else if  staffCheckBoxView.isChecked == false {
        
        staffCheckBoxView.isChecked = true
        staffCheckBoxView.setImage(UIImage.init(named: "done"), for: .normal)
        
        
        if parentTargetEnagbel == "0"{
            if   studentCheckBoxView.isChecked == true && staffCheckBoxView.isChecked == true{
                
                allCheckbox.isChecked = true
                
            }
        }else{
            
            
            if   studentCheckBoxView.isChecked == true  && parentsCheckBoxView.isChecked == true && staffCheckBoxView.isChecked == true{
                
                allCheckbox.isChecked = true
                
            }
            
        }
        
    }
    
    
    
}





@IBAction func CancelVc(){
    
    
    dismiss(animated: true)
    
    
    
}

func CommunicationEntierSms(){
    
    var entier = EntierCollegeModal()
    
    entier.collegeid = collegeId
    entier.staffid = memberId
    entier.filetype = "1"
    entier.callertype = priority
    if parentTargetEnagbel == "0"{
        entier.isparent = false
    }
    else{
        entier.isparent = parentsCheckBoxView.isChecked
    }
    entier.isstaff = staffCheckBoxView.isChecked
    entier.isstudent = studentCheckBoxView.isChecked
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
                            vc.is_read_enabled = self?.is_read_enabled ?? ""
                            vc.is_write_enabled = self?.is_write_enabled ?? ""
                            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                            
                            vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
                            vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                            vc.strName = self?.strName ?? []
                            vc.str = self?.str ?? []
                            
                            vc.modalPresentationStyle = .fullScreen
                            self?.present(vc, animated: true , completion: nil)
                            
                        } else{
                            
                            let vc = CommuniSMSViewController(nibName: nil, bundle: nil)
                            vc.is_read_enabled = self?.is_read_enabled ?? ""
                            vc.is_write_enabled = self?.is_write_enabled ?? ""
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
                }else {
                    
                    let refreshAlert = UIAlertController(title: "", message: success.Message, preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        
                    }))
                    
                    present(refreshAlert, animated: true, completion: nil)
                }
                
            case .failure(let failure):
                 print("Error:",failure.localizedDescription)
                let refreshAlert = UIAlertController(title: "", message: failure.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    
                }))
                
                present(refreshAlert, animated: true, completion: nil)
            }
            
            }
}

    
    func NoticeSendSmsEntier(ImageFile: [String]) {
        
        KRProgressHUD.show()
        
        var imageAryy: [FiletypeDataDetails] = []
        
        for i in ImageFile {
            var imageAws = FiletypeDataDetails()
            imageAws.filepath = i
            imageAws.filetype = fileType
            imageAryy.append(imageAws)
        }
        
        var particularNotice = NoticeBoardPartiModal()
        
        particularNotice.noticeboardid = "0"
        particularNotice.description = discreptionss
        particularNotice.receivertype = "1"
        particularNotice.isstaff = staffCheckBoxView.isChecked
        particularNotice.isstudent = studentCheckBoxView.isChecked
        
        if parentTargetEnagbel == "0" {
            particularNotice.isparent = false
        } else {
            particularNotice.isparent = parentsCheckBoxView.isChecked
        }
        
        particularNotice.processtype = "add"
        particularNotice.receiveridlist = collegeId
        particularNotice.topic = titlesTextField
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
            
            KRProgressHUD.dismiss()
            
            switch result {
                
            case .success(let response):
                    
                    if response.Status == 1 {
                        
                        self.particularSms = response
                        
                        let refreshAlert = UIAlertController(
                            title: "",
                            message: response.Message,
                            preferredStyle: .alert
                        )
                        
                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                            
                            let vc = SenderGraditNoticeBoardMenuViewController()
                            vc.is_read_enabled = self.is_read_enabled
                            vc.is_write_enabled = self.is_write_enabled
                            vc.strName = self.strName
                            vc.str = self.str
                            
                            if self.priority == "p2" || self.priority == "p3" {
                                
                                vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                                vc.noticeSegments.backgroundColor = UIColor(named: "HodUnSelector")
                                vc.noticeSegments.selectedSegmentTintColor = UIColor(named: "HodSelector")
                                
                            } else {
                                
                                vc.view.backgroundColor = UIColor(named: "Principal")
                                vc.noticeSegments.backgroundColor = UIColor(named: "UnSelector")
                                vc.noticeSegments.selectedSegmentTintColor = UIColor(named: "Selector")
                            }
                            
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true)
                        })
                        
                        self.present(refreshAlert, animated: true)
                        
                    } else {
                        
                        let refreshAlert = UIAlertController(
                            title: "",
                            message: response.Message,
                            preferredStyle: .alert
                        )
                        
                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default))
                        
                        self.present(refreshAlert, animated: true)
                    }
                
                
                self.tv.dataSource = self
                self.tv.delegate = self
                self.tv.reloadData()
                
                
            case .failure(let error):
                
                print("API Error:", error.localizedDescription)
            }
        }
    }
    
    func videoUpload(){
        
        var uploadvideo = EntierVideoUpload()
        
        uploadvideo.callertype = priority
        uploadvideo.url = videoVimeoUrl
        uploadvideo.collegeid = collegeId
        uploadvideo.description = discreptionss
        uploadvideo.iframe = videoIframe
        
        if parentTargetEnagbel == "0"{
            uploadvideo.isparent = false
        }
        else{
            uploadvideo.isparent = parentsCheckBoxView.isChecked
        }
        
        uploadvideo.isstaff = staffCheckBoxView.isChecked
        uploadvideo.isstudent = studentCheckBoxView.isChecked
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
                            vc.is_read_enabled = self.is_read_enabled
                            vc.is_write_enabled = self.is_write_enabled
                            vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                            vc.strName = self.strName
                            vc.str = self.str
                            vc.modalPresentationStyle = .fullScreen
                            
                            self.present(vc, animated: true)
                            
                        } else {
                            
                            let vc = SenderVideoHomePageViewController()
                            vc.is_read_enabled = self.is_read_enabled
                            vc.is_write_enabled = self.is_write_enabled
                            vc.view.backgroundColor = UIColor(named: "Principal")
                            vc.strName = self.strName
                            vc.str = self.str
                            vc.modalPresentationStyle = .fullScreen
                            
                            self.present(vc, animated: true)
                        }
                    }))
                    
                    self.present(refreshAlert, animated: true)
                    
                    self.tv.dataSource = self
                    self.tv.delegate = self
                    self.tv.reloadData()
                    
                } else {
                    
                    let refreshAlert = UIAlertController(
                        title: "",
                        message: particular.Message,
                        preferredStyle: .alert
                    )
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default))
                    
                    self.present(refreshAlert, animated: true)
                    
                    self.tv.dataSource = self
                    self.tv.delegate = self
                    self.tv.reloadData()
                }
                
            case .failure(let error):
                print("API Error:", error.localizedDescription)
            }
        }
    }
    
    func EventEntier(){
        
        var particular = EventParticualrModal()
        
        particular.eventid = "0"
        particular.eventbody = titlesTextField
        particular.eventdate = DateLabels
        particular.eventvenue = VenuTestField
        particular.eventtime = EventTime
        particular.eventtopic = discreptionss
        
        if resivre == "13"{
            particular.processtype = "edit"
        }else{
            particular.processtype = "add"
        }
        
        particular.collegeid = collegeId
        particular.staffid = memberId
        particular.Callertype = priority
        particular.receivertype = "1"
        
        if parentTargetEnagbel == "0"{
            particular.isparent = false
        } else{
            particular.isparent = parentsCheckBoxView.isChecked
        }
        
        particular.isstaff = staffCheckBoxView.isChecked
        particular.isstudent = staffCheckBoxView.isChecked
        particular.receiveridlist = collegeId
        
        print("yearAndSectionModalStr", particular)
        
        
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
                                
                            } else {
                                
                                let vc = SenderEventHomePageViewController()
                                vc.is_read_enabled = self.is_read_enabled
                                vc.is_write_enabled = self.is_write_enabled
                                vc.view.backgroundColor = UIColor(named: "Principal")
                                vc.eventSegmentName.backgroundColor = UIColor(named: "UnSelector")
                                vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "Selector")
                                vc.strName = self.strName
                                vc.str = self.str
                                vc.modalPresentationStyle = .fullScreen
                                self.present(vc, animated: true)
                            }
                        })
                        
                        self.present(refreshAlert, animated: true)
                        
                        self.tv.dataSource = self
                        self.tv.delegate = self
                        self.tv.reloadData()
                        
                    } else {
                        
                        let refreshAlert = UIAlertController(title: "", message: i.Message, preferredStyle: .alert)
                        
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
                                
                            } else {
                                
                                let vc = SenderEventHomePageViewController()
                                vc.is_read_enabled = self.is_read_enabled
                                vc.is_write_enabled = self.is_write_enabled
                                vc.view.backgroundColor = UIColor(named: "Principal")
                                vc.eventSegmentName.backgroundColor = UIColor(named: "UnSelector")
                                vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "Selector")
                                vc.strName = self.strName
                                vc.str = self.str
                                vc.modalPresentationStyle = .fullScreen
                                self.present(vc, animated: true)
                            }
                        })
                        
                        self.present(refreshAlert, animated: true)
                        
                        self.tv.dataSource = self
                        self.tv.delegate = self
                        self.tv.reloadData()
                    }
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }


//func multypartAudio() {
//    
//    print("voiceReplyTypevoiceReplyType",discreptionss)
//    
//    
//    let vimeoVideoEndpoint = "https://gradit.voicesnap.com/api/AppDetailsBal/SendFileToEntireCollege"
//    
//    var voiceUpload = voiceUploadEntierModal()
//    //        discreptionss
//    
//    voiceUpload.staffid = memberId
//    voiceUpload.description = discreptionss
//    voiceUpload.callertype = priority
//    voiceUpload.collegeid = collegeId
//    voiceUpload.fileduration = voiceDuration
//    voiceUpload.filetype = "1"
//    
//    if parentTargetEnagbel == "0"{
//        
//        
//        voiceUpload.isparent = false
//    }
//    
//    else{
//        
//        
//        voiceUpload.isparent = parentsCheckBoxView.isChecked
//    }
//    voiceUpload.isemergencyvoice = voiceReplyType
//    
//    voiceUpload.isstaff = staffCheckBoxView.isChecked
//    voiceUpload.isstudent = studentCheckBoxView.isChecked
//    
//    let voiceUploadStr = voiceUpload.toJSONString()
//    
//    print("chatSenderStr",voiceUpload)
//    
//    
//    AF.upload(multipartFormData: { [self] (multipartFormData) in
//        
//        KRProgressHUD.show()
//        
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            
//            
//            
//            KRProgressHUD.dismiss()
//            
//        }
//        
//        
//        
//        let pathURL = voiceUrl
//        
//        let pathString = pathURL!.path
//        
//        multipartFormData.append(URL(fileURLWithPath: pathString), withName: "file")
//        
//        multipartFormData.append(Data(voiceUploadStr!.description.utf8), withName: "info")
//        
//        
//        
//        print("parameters.description.utf8",voiceUploadStr!.description.utf8)
//        
//        
//    },to: vimeoVideoEndpoint).responseJSON{
//        //
//        
//        
//        
//        //
//        res in
//        
//        
//        
//        
//        let json_str = String(data: res.data!, encoding: .utf8)
//        
//        print("json \(json_str!)")
//        
//        
//        
//        do {
//            if let json = try JSONSerialization.jsonObject(with: res.data!, options: []) as? [String: Any] {
//                if let status = json["Status"] as? Int {
//                    print("Status: \(status)")
//                    
//                    if status == 1 {
//                        
//                        
//                        let a = json["Message"]
//                        
//                        
//                        
//                        
//                        
//                        
//                        let refreshAlert = UIAlertController(title: "", message:  a as! String, preferredStyle: UIAlertController.Style.alert)
//                        
//                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in
//                            
//                            if priority == "p2" || priority == "p3" {
//                                
//                                let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
//                                vc.is_read_enabled = "1"
//                                vc.is_write_enabled = "1"
//                                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
//                                
//                                vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
//                                vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
//                                vc.strName = self.strName
//                                vc.str = self.str
//                                
//                                vc.modalPresentationStyle = .fullScreen
//                                self.present(vc, animated: true , completion: nil)
//                                
//                            }
//                            
//                            
//                            else{
//                                
//                                let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
//                                vc.is_read_enabled = "1"
//                                vc.is_write_enabled = "1"
//                                vc.view.backgroundColor = UIColor(named: "Principal" )
//                                
//                                vc.CommuniSegementName.backgroundColor = UIColor(named: "UnSelector")
//                                vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "Selector")
//                                
//                                vc.strName = self.strName
//                                vc.str = self.str
//                                
//                                vc.modalPresentationStyle = .fullScreen
//                                self.present(vc, animated: true , completion: nil)
//                                
//                            }
//                            
//                            
//                            
//                            
//                            
//                        }))
//                        
//                        
//                        
//                        self.present(refreshAlert, animated: true, completion: nil)
//                        
//                        
//                        
//                        
//                    }
//                    else {
//                        
//                        
//                        
//                        let a = json["Message"]
//                        
//                        
//                        let refreshAlert = UIAlertController(title: "", message:  a as! String, preferredStyle: UIAlertController.Style.alert)
//                        
//                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in
//                            
//                            if priority == "p2" || priority == "p3" {
//                                
//                                let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
//                                vc.is_read_enabled = "1"
//                                vc.is_write_enabled = "1"
//                                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
//                                
//                                vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
//                                vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
//                                vc.strName = self.strName
//                                vc.str = self.str
//                                
//                                vc.modalPresentationStyle = .fullScreen
//                                self.present(vc, animated: true , completion: nil)
//                                
//                            }
//                            
//                            
//                            else{
//                                
//                                let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
//                                vc.is_read_enabled = "1"
//                                vc.is_write_enabled = "1"
//                                vc.view.backgroundColor = UIColor(named: "Principal" )
//                                
//                                vc.CommuniSegementName.backgroundColor = UIColor(named: "UnSelector")
//                                vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "Selector")
//                                
//                                vc.strName = self.strName
//                                vc.str = self.str
//                                
//                                vc.modalPresentationStyle = .fullScreen
//                                self.present(vc, animated: true , completion: nil)
//                                
//                            }
//                            
//                            
//                            
//                            
//                            
//                        }))
//                        
//                        
//                        
//                        self.present(refreshAlert, animated: true, completion: nil)
//                        
//                        
//                        
//                        
//                    }
//                    
//                }
//            }
//        } catch {
//            print("Error parsing JSON: \(error)")
//        }
//        
//    }
//   
//}


    func multypartAudio() {
        
        print("voiceReplyTypevoiceReplyType", discreptionss)
        
        let vimeoVideoEndpoint = "https://gradit.voicesnap.com/api/AppDetailsBal/SendFileToEntireCollege"
        
        var voiceUpload = voiceUploadEntierModal()
        
        voiceUpload.staffid = memberId
        voiceUpload.description = discreptionss
        voiceUpload.callertype = priority
        voiceUpload.collegeid = collegeId
        voiceUpload.fileduration = voiceDuration
        voiceUpload.filetype = "1"
        
        if parentTargetEnagbel == "0"{
            voiceUpload.isparent = false
        } else {
            voiceUpload.isparent = parentsCheckBoxView.isChecked
        }
        
        voiceUpload.isemergencyvoice = voiceReplyType
        voiceUpload.isstaff = staffCheckBoxView.isChecked
        voiceUpload.isstudent = studentCheckBoxView.isChecked
        
        // ✅ Convert to JSON string (instead of toJSONString)
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            KRProgressHUD.dismiss()
        }
        
        MultipartManager.shared.uploadVoice(
            url: vimeoVideoEndpoint,
            fileURL: voiceUrl!,
            infoJSONString: voiceUploadStr
        ) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
                
            case .success(let json):
                
                print("json", json)
                
                if let status = json["Status"] as? Int {
                    print("Status: \(status)")
                    
                    let message = json["Message"] as! String
                    
                    let refreshAlert = UIAlertController(title: "", message: message, preferredStyle: .alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
                        
                        guard let self = self else { return }
                        
                        if priority == "p2" || priority == "p3" {
                            
                            let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
                            vc.is_read_enabled = "1"
                            vc.is_write_enabled = "1"
                            vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                            vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
                            vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                            vc.strName = self.strName
                            vc.str = self.str
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true)
                            
                        } else {
                            
                            let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
                            vc.is_read_enabled = "1"
                            vc.is_write_enabled = "1"
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
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

func HistoryVoiceSend() {
    
    var voiceUpload = VoiceHstryModal()
    
    voiceUpload.staffid = memberId
    voiceUpload.description = discreptionss
    voiceUpload.callertype = priority
    voiceUpload.collegeid = collegeId
    voiceUpload.forwarding_voice_id = voiceHstryHeaderId
    
    if parentTargetEnagbel == "0"{
        voiceUpload.isparent = false
    }else{
        voiceUpload.isparent = parentsCheckBoxView.isChecked
    }
    voiceUpload.isemergencyvoice = voiceReplyType
    voiceUpload.isstaff = staffCheckBoxView.isChecked
    voiceUpload.isstudent = studentCheckBoxView.isChecked
    
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



func HistoryVoiceSendParticular() {
    
    var voiceUpload = VoiceHstryModal()
    
    voiceUpload.staffid = memberId
    voiceUpload.description = discreptionss
    voiceUpload.callertype = priority
    voiceUpload.collegeid = collegeId
    voiceUpload.forwarding_voice_id = voiceHstryHeaderId
    voiceUpload.receiverid =  nameString
    voiceUpload.receivertype = resiverType
    
    if parentTargetEnagbel == "0"{
        
        voiceUpload.isparent = false
    }else{
        
        voiceUpload.isparent = parentsCheckBoxView.isChecked
    }
    
    voiceUpload.isemergencyvoice = voiceReplyType
    voiceUpload.isstaff = staffCheckBoxView.isChecked
    voiceUpload.isstudent = studentCheckBoxView.isChecked
    
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


    func ImagePdfEntier(ImageFile: [String]) {
        
        print("fdfddsx")
        
        var imageAryy: [FileNameImage] = []
        
        for i in ImageFile {
            var imageAws = FileNameImage()
            imageAws.FileName = i
            imageAryy.append(imageAws)
        }
        
        var sendImagePdfEntier = SendImagePdfModal()
        
        sendImagePdfEntier.Staffid = memberId
        print("senderscszsz", memberId)
        
        sendImagePdfEntier.collegeid = collegeId
        sendImagePdfEntier.callertype = priority
        
        if parentTargetEnagbel == "0" {
            sendImagePdfEntier.isparent = false
        } else {
            sendImagePdfEntier.isparent = parentsCheckBoxView.isChecked
        }
        
        sendImagePdfEntier.isstaff = staffCheckBoxView.isChecked
        sendImagePdfEntier.isstudent = studentCheckBoxView.isChecked
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
                
                if enierImagePdf.Status == 1 {
                    
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
                            
                        } else {
                            
                            let vc = SenderImagePdfHomePageViewController()
                            vc.is_read_enabled = self.is_read_enabled
                            vc.is_write_enabled = self.is_write_enabled
                            vc.view.backgroundColor = UIColor(named: "Principal")
                            vc.imageSegmentName.backgroundColor = UIColor(named: "UnSelector")
                            vc.imageSegmentName.selectedSegmentTintColor = UIColor(named: "Selector")
                            vc.strName = self.strName
                            vc.str = self.str
                            vc.modalPresentationStyle = .fullScreen
                            
                            self.present(vc, animated: true)
                        }
                    })
                    
                    self.present(refreshAlert, animated: true)
                    
                } else {
                    
                    let refreshAlert = UIAlertController(
                        title: "",
                        message: enierImagePdf.Message,
                        preferredStyle: .alert
                    )
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default))
                    
                    self.present(refreshAlert, animated: true)
                }
                
                self.tv.dataSource = self
                self.tv.delegate = self
                self.tv.reloadData()
                
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }



//func multypartAudioParticular() {
//    
//    
//    var vimeoVideoEndpoint = "https://gradit.voicesnap.com/api/AppDetailsBal/SendFileToParticularType"
//    
//    var voiceUpload = particularVoiceUploadMoad()
//    
//    voiceUpload.staffid = memberId
//    voiceUpload.description = discreptionss
//    voiceUpload.callertype = priority
//    voiceUpload.collegeid = collegeId
//    voiceUpload.fileduration = voiceDuration
//    voiceUpload.filetype = "1"
//    voiceUpload.isemergencyvoice = voiceReplyType
//    
//    if IDforStaffCheck == "1"{
//        
//        voiceUpload.isstaff = false
//        
//    }else{
//        
//        voiceUpload.isstaff = staffCheckBoxView.isChecked
//    }
//    
//    if parentTargetEnagbel == "0"{
//
//        voiceUpload.isparent = false
//    }else{
//        
//        voiceUpload.isparent = parentsCheckBoxView.isChecked
//    }
//    
//    
//    voiceUpload.isstudent = studentCheckBoxView.isChecked
//    voiceUpload.receiverid = nameString
//    voiceUpload.receivertype = resiverType
//    
//    
//    let voiceUploadStr = voiceUpload.toJSONString()
//    
//    print("chatSenderStr",voiceUpload)
//    
//    AF.upload(multipartFormData: { [self] (multipartFormData) in
//        
//        KRProgressHUD.show()
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            
//            KRProgressHUD.dismiss()
//            
//        }
//        
//        let pathURL = voiceUrl
//        
//        let pathString = pathURL!.path
//        
//        multipartFormData.append(URL(fileURLWithPath: pathString), withName: "file")
//        
//        multipartFormData.append(Data(voiceUploadStr!.description.utf8), withName: "info")
//        
//        print("parameters.description.utf8",voiceUploadStr!.description.utf8)
//        
//        
//    },to: vimeoVideoEndpoint).responseJSON{
//        
//        res in
//        
//        let json_str = String(data: res.data!, encoding: .utf8)
//        
//        print("json \(json_str!)")
//        
//        do {
//            if let json = try JSONSerialization.jsonObject(with: res.data!, options: []) as? [String: Any] {
//                if let status = json["Status"] as? Int {
//                    print("Status: \(status)")
//                    
//                    if status == 1 {
//                        
//                        let a = json["Message"]
//                        
//                        let refreshAlert = UIAlertController(title: "", message:  a as! String, preferredStyle: UIAlertController.Style.alert)
//                        
//                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in
//                            
//                            if priority == "p2" || priority == "p3" {
//                                
//                                let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
//                                vc.is_read_enabled = "1"
//                                vc.is_write_enabled = "1"
//                                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
//                                
//                                vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
//                                vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
//                                vc.strName = self.strName
//                                vc.str = self.str
//                                
//                                vc.modalPresentationStyle = .fullScreen
//                                self.present(vc, animated: true , completion: nil)
//                                
//                            } else if priority == "p7" {
//                                
//                                let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
//                                vc.is_read_enabled = "1"
//                                vc.is_write_enabled = "1"
//                                vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
//                                
//                                vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
//                                vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
//                                vc.strName = self.strName
//                                vc.str = self.str
//                                
//                                vc.modalPresentationStyle = .fullScreen
//                                self.present(vc, animated: true , completion: nil)
//                                
//                            }else{
//                                
//                                let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
//                                vc.is_read_enabled = "1"
//                                vc.is_write_enabled = "1"
//                                vc.view.backgroundColor = UIColor(named: "Principal" )
//                                
//                                vc.CommuniSegementName.backgroundColor = UIColor(named: "UnSelector")
//                                vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "Selector")
//                                
//                                vc.strName = self.strName
//                                vc.str = self.str
//                                vc.modalPresentationStyle = .fullScreen
//                                self.present(vc, animated: true , completion: nil)
//                                
//                            }
//                            
//                        }))
//                        
//                        self.present(refreshAlert, animated: true, completion: nil)
//                        
//                    }
//                    else {
//                        
//                        let a = json["Message"]
//                        
//                        
//                        let refreshAlert = UIAlertController(title: "", message:  a as! String, preferredStyle: UIAlertController.Style.alert)
//                        
//                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in
//                            
//                            if priority == "p2" || priority == "p3" {
//                                
//                                let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
//                                vc.is_read_enabled = "1"
//                                vc.is_write_enabled = "1"
//                                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
//                                
//                                vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
//                                vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
//                                vc.strName = self.strName
//                                vc.str = self.str
//                                
//                                vc.modalPresentationStyle = .fullScreen
//                                self.present(vc, animated: true , completion: nil)
//                                
//                            }
//                            
//                            else if priority == "p7" {
//                                
//                                let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
//                                vc.is_read_enabled = "1"
//                                vc.is_write_enabled = "1"
//                                vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
//                                
//                                vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
//                                vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
//                                vc.strName = self.strName
//                                vc.str = self.str
//                                
//                                vc.modalPresentationStyle = .fullScreen
//                                self.present(vc, animated: true , completion: nil)
//                                
//                            }
//                            
//                            else{
//                                
//                                let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
//                                vc.is_read_enabled = "1"
//                                vc.is_write_enabled = "1"
//                                vc.view.backgroundColor = UIColor(named: "Principal" )
//                                
//                                vc.CommuniSegementName.backgroundColor = UIColor(named: "UnSelector")
//                                vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "Selector")
//                                
//                                vc.strName = self.strName
//                                vc.str = self.str
//                                vc.modalPresentationStyle = .fullScreen
//                                self.present(vc, animated: true , completion: nil)
//                                
//                            }
//                            
//                        }))
//                        
//                        self.present(refreshAlert, animated: true, completion: nil)
//                        
//                    }
//                    
//                }
//            }
//        } catch {
//            print("Error parsing JSON: \(error)")
//        }
//    }
//}
    
    func multypartAudioParticular() {
        
        let vimeoVideoEndpoint = "https://gradit.voicesnap.com/api/AppDetailsBal/SendFileToParticularType"
        
        var voiceUpload = particularVoiceUploadMoad()
        
        voiceUpload.staffid = memberId
        voiceUpload.description = discreptionss
        voiceUpload.callertype = priority
        voiceUpload.collegeid = collegeId
        voiceUpload.fileduration = voiceDuration
        voiceUpload.filetype = "1"
        voiceUpload.isemergencyvoice = voiceReplyType
        
        if IDforStaffCheck == "1"{
            voiceUpload.isstaff = false
        }else{
            voiceUpload.isstaff = staffCheckBoxView.isChecked
        }
        
        if parentTargetEnagbel == "0"{
            voiceUpload.isparent = false
        }else{
            voiceUpload.isparent = parentsCheckBoxView.isChecked
        }
        
        voiceUpload.isstudent = studentCheckBoxView.isChecked
        voiceUpload.receiverid = nameString
        voiceUpload.receivertype = resiverType
        
        // ✅ Codable instead of toJSONString()
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
            fileURL: voiceUrl!,
            infoJSONString: voiceUploadStr,
           
        ) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
                
            case .success(let json):
                
                print("json \(json)")
                
                if let status = json["Status"] as? Int {
                    print("Status: \(status)")
                    
                    DispatchQueue.main.async {
                        
                        if status == 1 {
                            
                            let a = json["Message"]
                            
                            let refreshAlert = UIAlertController(title: "", message: a as! String, preferredStyle: .alert)
                            
                            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
                                
                                guard let self = self else { return }
                                
                                if priority == "p2" || priority == "p3" {
                                    
                                    let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
                                    vc.is_read_enabled = "1"
                                    vc.is_write_enabled = "1"
                                    vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                                    vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
                                    vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                                    vc.strName = self.strName
                                    vc.str = self.str
                                    vc.modalPresentationStyle = .fullScreen
                                    self.present(vc, animated: true)
                                    
                                } else if priority == "p7" {
                                    
                                    let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
                                    vc.is_read_enabled = "1"
                                    vc.is_write_enabled = "1"
                                    vc.view.backgroundColor = UIColor(named: "univercityColorCod")
                                    vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
                                    vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                                    vc.strName = self.strName
                                    vc.str = self.str
                                    vc.modalPresentationStyle = .fullScreen
                                    self.present(vc, animated: true)
                                    
                                } else {
                                    
                                    let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
                                    vc.is_read_enabled = "1"
                                    vc.is_write_enabled = "1"
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
                        else {
                            
                            let a = json["Message"]
                            
                            let refreshAlert = UIAlertController(title: "", message: a as! String, preferredStyle: .alert)
                            
                            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
                                
                                guard let self = self else { return }
                                
                                if priority == "p2" || priority == "p3" {
                                    
                                    let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
                                    vc.is_read_enabled = "1"
                                    vc.is_write_enabled = "1"
                                    vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                                    vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
                                    vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                                    vc.strName = self.strName
                                    vc.str = self.str
                                    vc.modalPresentationStyle = .fullScreen
                                    self.present(vc, animated: true)
                                    
                                } else if priority == "p7" {
                                    
                                    let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
                                    vc.is_read_enabled = "1"
                                    vc.is_write_enabled = "1"
                                    vc.view.backgroundColor = UIColor(named: "univercityColorCod")
                                    vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
                                    vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                                    vc.strName = self.strName
                                    vc.str = self.str
                                    vc.modalPresentationStyle = .fullScreen
                                    self.present(vc, animated: true)
                                    
                                } else {
                                    
                                    let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
                                    vc.is_read_enabled = "1"
                                    vc.is_write_enabled = "1"
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

    func SendVideoToParticular() {
        
        var uploadvideo = ParticularVideoUploadModal()
        
        uploadvideo.callertype = priority
        uploadvideo.url = videoVimeoUrl
        uploadvideo.collegeid = collegeId
        uploadvideo.description = discreptionss
        uploadvideo.iframe = videoIframe
        
        if IDforStaffCheck == "1"{
            uploadvideo.isstaff = false
        } else {
            uploadvideo.isstaff = staffCheckBoxView.isChecked
        }
        
        if parentTargetEnagbel == "0"{
            uploadvideo.isparent = false
        } else {
            uploadvideo.isparent = parentsCheckBoxView.isChecked
        }
        
        uploadvideo.isstudent = studentCheckBoxView.isChecked
        uploadvideo.staffid = memberId
        uploadvideo.title = titlesTextField
        uploadvideo.receiverid = nameString
        uploadvideo.receivertype = resiverType
        
        print("SendVideoToParticular", uploadvideo)
        
        
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
                    
                    let refreshAlert = UIAlertController(
                        title: "",
                        message: particular.Message,
                        preferredStyle: .alert
                    )
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                        
                        if self.priority == "p2" || self.priority == "p3" {
                            
                            let vc = SenderVideoHomePageViewController()
                            vc.is_read_enabled = self.is_read_enabled
                            vc.is_write_enabled = self.is_write_enabled
                            vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                            vc.strName = self.strName
                            vc.str = self.str
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true)
                            
                        } else if self.priority == "p7" {
                            
                            let vc = SenderVideoHomePageViewController()
                            vc.is_read_enabled = self.is_read_enabled
                            vc.is_write_enabled = self.is_write_enabled
                            vc.view.backgroundColor = UIColor(named: "univercityColorCod")
                            vc.strName = self.strName
                            vc.str = self.str
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true)
                            
                        } else {
                            
                            let vc = SenderVideoHomePageViewController()
                            vc.is_read_enabled = self.is_read_enabled
                            vc.is_write_enabled = self.is_write_enabled
                            vc.view.backgroundColor = UIColor(named: "Principal")
                            vc.strName = self.strName
                            vc.str = self.str
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true)
                        }
                    })
                    
                    self.present(refreshAlert, animated: true)
                    
                    self.tv.dataSource = self
                    self.tv.delegate = self
                    self.tv.reloadData()
                    
                } else {
                    
                    let refreshAlert = UIAlertController(
                        title: "",
                        message: particular.Message,
                        preferredStyle: .alert
                    )
                    
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

func SendSmsToParticular() {
    
    var particular = SendSmsToParticularModal()
    
    particular.collegeid = collegeId
    particular.staffid = memberId
    particular.description = discreptionss
    particular.callertype = priority
    particular.receivertype = resiverType
    
    
    if IDforStaffCheck == "1"{
        
        particular.isstaff = false
    }else{
        
        particular.isstaff = staffCheckBoxView.isChecked
    }
    
    if parentTargetEnagbel == "0"{
        
        particular.isparent = false
    }else{
        
        particular.isparent = parentsCheckBoxView.isChecked
    }
    
    particular.isstudent = studentCheckBoxView.isChecked
    particular.receiverid = nameString
    particular.messagecontent = titlesTextField
    particular.filetype = "1"
    
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
                    
                    particularSmsComunication  = success.data ?? []
                    
                    let refreshAlert = UIAlertController(title: "", message: success.Message, preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] (action: UIAlertAction!) in
                        if self?.priority == "p2" || self?.priority == "p3" {
                            
                            let vc = CommuniSMSViewController(nibName: nil, bundle: nil)
                            vc.is_read_enabled = self?.is_read_enabled ?? ""
                            vc.is_write_enabled = self?.is_write_enabled ?? ""
                            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                            
                            vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
                            vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                            
                            vc.strName = self?.strName ?? []
                            vc.str = self?.str ?? []
                            vc.modalPresentationStyle = .fullScreen
                            self?.present(vc, animated: true , completion: nil)
                            
                        }else if self?.priority == "p7" {
                            
                            let vc = CommuniSMSViewController(nibName: nil, bundle: nil)
                            vc.is_read_enabled = self?.is_read_enabled ?? ""
                            vc.is_write_enabled = self?.is_write_enabled ?? ""
                            vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
                            
                            vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
                            vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                            
                            vc.strName = self?.strName ?? []
                            vc.str = self?.str ?? []
                            vc.modalPresentationStyle = .fullScreen
                            self?.present(vc, animated: true , completion: nil)
                            
                        } else{
                            
                            let vc = CommuniSMSViewController(nibName: nil, bundle: nil)
                            vc.is_read_enabled = self?.is_read_enabled ?? ""
                            vc.is_write_enabled = self?.is_write_enabled ?? ""
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
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] (action: UIAlertAction!) in
                        if self?.priority == "p2" || self?.priority == "p3" {
                            
                            let vc = CommuniSMSViewController(nibName: nil, bundle: nil)
                            vc.is_read_enabled = self?.is_read_enabled ?? ""
                            vc.is_write_enabled = self?.is_write_enabled ?? ""
                            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                            
                            vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
                            vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                            
                            vc.strName = self?.strName ?? []
                            vc.str = self?.str ?? []
                            
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
                            
                            vc.strName = self?.strName ?? []
                            vc.str = self?.str ?? []
                            
                            vc.modalPresentationStyle = .fullScreen
                            self?.present(vc, animated: true , completion: nil)
                            
                        }else{
                            
                            let vc = CommuniSMSViewController(nibName: nil, bundle: nil)
                            vc.is_read_enabled = self?.is_read_enabled ?? ""
                            vc.is_write_enabled = self?.is_write_enabled ?? ""
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
                     
                }
                
            case .failure(let failure):
                 print("Error:",failure.localizedDescription)
                
                let refreshAlert = UIAlertController(title: "", message: failure.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                }))
                present(refreshAlert, animated: true, completion: nil)
            }
            
            }
    
}

    func NoticeSendSmsToParticular(ImageFile: [String]) {
        
        var imageAryy: [FiletypeDataDetails] = []
        
        for i in ImageFile {
            var imageAws = FiletypeDataDetails()
            imageAws.filepath = i
            imageAws.filetype = fileType
            imageAryy.append(imageAws)
        }
        
        var particularNotice = NoticeBoardPartiModal()
        
        particularNotice.noticeboardid = "0"
        particularNotice.description = discreptionss
        particularNotice.receivertype = resiverType
        
        if IDforStaffCheck == "1" {
            particularNotice.isstaff = false
        } else {
            particularNotice.isstaff = staffCheckBoxView.isChecked
        }
        
        if parentTargetEnagbel == "0" {
            particularNotice.isparent = false
        } else {
            particularNotice.isparent = parentsCheckBoxView.isChecked
        }
        
        particularNotice.isstudent = studentCheckBoxView.isChecked
        particularNotice.processtype = "add"
        particularNotice.receiveridlist = nameString
        particularNotice.topic = titlesTextField
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
                    
                    self.particularSms = response
                    
                    let refreshAlert = UIAlertController(
                        title: "",
                        message: response.Message,
                        preferredStyle: .alert
                    )
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                        
                        let vc = SenderGraditNoticeBoardMenuViewController()
                        
                        vc.is_read_enabled = self.is_read_enabled
                        vc.is_write_enabled = self.is_write_enabled
                        vc.strName = self.strName
                        vc.str = self.str
                        
                        if self.priority == "p2" || self.priority == "p3" {
                            
                            vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                            vc.noticeSegments.backgroundColor = UIColor(named: "HodUnSelector")
                            vc.noticeSegments.selectedSegmentTintColor = UIColor(named: "HodSelector")
                            
                        } else if self.priority == "p7" {
                            
                            vc.view.backgroundColor = UIColor(named: "univercityColorCod")
                            vc.noticeSegments.backgroundColor = UIColor(named: "HodUnSelector")
                            vc.noticeSegments.selectedSegmentTintColor = UIColor(named: "HodSelector")
                            
                        } else {
                            
                            vc.view.backgroundColor = UIColor(named: "Principal")
                            vc.noticeSegments.backgroundColor = UIColor(named: "UnSelector")
                            vc.noticeSegments.selectedSegmentTintColor = UIColor(named: "Selector")
                        }
                        
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true)
                    })
                    
                    self.present(refreshAlert, animated: true)
                
                
            case .failure(let error):
                
                print("API Error:", error.localizedDescription)
            }
        }
    }

    func EventParticular(){
        
        var particular = EventParticualrModal()
        
        particular.eventid = "0"
        particular.eventbody = discreptionss
        particular.eventdate = DateLabels
        particular.eventvenue = VenuTestField
        particular.eventtime = EventTime
        particular.eventtopic = titlesTextField
        
        particular.processtype = "add"
        particular.collegeid = collegeId
        particular.staffid = memberId
        particular.Callertype = priority
        particular.receivertype = resiverType
        
        if IDforStaffCheck == "1"{
            particular.isstaff = false
        } else{
            particular.isstaff = staffCheckBoxView.isChecked
        }
        
        if parentTargetEnagbel == "0"{
            particular.isparent = false
        } else{
            particular.isparent = parentsCheckBoxView.isChecked
        }
        
        particular.isstudent = studentCheckBoxView.isChecked
        particular.receiveridlist = nameString
        
        print("yearAndSectionModalStr", particular)
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.ManageEvents,
            httpMethod: .post,
            queryParam: nil,
            requestBody: particular
        ) { [weak self] (result: Result<[EventParticularResponce], Error>) in
            
            guard let self = self else { return }
            
            switch result {
                
            case .success(let response):
                
                for i in response {
                    
                    if i.Status == 1 {
                        
                        let refreshAlert = UIAlertController(title: "", message: i.Message, preferredStyle: .alert)
                        
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
                                
                            } else if self.priority == "p7" {
                                
                                let vc = SenderEventHomePageViewController()
                                vc.is_read_enabled = self.is_read_enabled
                                vc.is_write_enabled = self.is_write_enabled
                                vc.view.backgroundColor = UIColor(named: "univercityColorCod")
                                vc.eventSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                                vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                                vc.strName = self.strName
                                vc.str = self.str
                                vc.modalPresentationStyle = .fullScreen
                                self.present(vc, animated: true)
                                
                            } else {
                                
                                let vc = SenderEventHomePageViewController()
                                vc.is_read_enabled = self.is_read_enabled
                                vc.is_write_enabled = self.is_write_enabled
                                vc.view.backgroundColor = UIColor(named: "Principal")
                                vc.eventSegmentName.backgroundColor = UIColor(named: "UnSelector")
                                vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "Selector")
                                vc.strName = self.strName
                                vc.str = self.str
                                vc.modalPresentationStyle = .fullScreen
                                self.present(vc, animated: true)
                            }
                        })
                        
                        self.present(refreshAlert, animated: true)
                        
                    } else {
                        
                        let refreshAlert = UIAlertController(title: "", message: i.Message, preferredStyle: .alert)
                        
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
                                
                            } else if self.priority == "p7" {
                                
                                let vc = SenderEventHomePageViewController()
                                vc.is_read_enabled = self.is_read_enabled
                                vc.is_write_enabled = self.is_write_enabled
                                vc.view.backgroundColor = UIColor(named: "univercityColorCod")
                                vc.eventSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                                vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                                vc.strName = self.strName
                                vc.str = self.str
                                vc.modalPresentationStyle = .fullScreen
                                self.present(vc, animated: true)
                                
                            } else {
                                
                                let vc = SenderEventHomePageViewController()
                                vc.is_read_enabled = self.is_read_enabled
                                vc.is_write_enabled = self.is_write_enabled
                                vc.view.backgroundColor = UIColor(named: "Principal")
                                vc.eventSegmentName.backgroundColor = UIColor(named: "UnSelector")
                                vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "Selector")
                                vc.strName = self.strName
                                vc.str = self.str
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
    }


    func ImagePdfParticular(ImageFile: [String]) {

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
        sendImagePdfEntier.collegeid = collegeId
        sendImagePdfEntier.Description = discreptionss
        sendImagePdfEntier.Staffid = memberId
        sendImagePdfEntier.fileduration = "0"
        sendImagePdfEntier.filetype = fileType
        
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
            sendImagePdfEntier.isparent = parentsCheckBoxView.isChecked
        }
        
        sendImagePdfEntier.isstudent = studentCheckBoxView.isChecked
        sendImagePdfEntier.FileNameArray = imageAryy
        
        print("yearAndSectionModalStr", sendImagePdfEntier)
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.SendImageOrPDFToParticularTypeWithCloudURL,
            httpMethod: .post,
            queryParam: nil,
            requestBody: sendImagePdfEntier
        ) { [weak self] (result: Result<SendImagePdfPartiResponce, Error>) in
            
            guard let self = self else { return }
            
            switch result {
                
            case .success(let enierImagePdf):
                
                self.imagePdfEniterParticular = enierImagePdf.data ?? []
                
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
                        vc.strName = self.strName
                        vc.str = self.str
                        
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true)
                        
                    }
                    else if self.priority == "p7" {
                        
                        let vc = SenderImagePdfHomePageViewController()
                        vc.is_read_enabled = self.is_read_enabled
                        vc.is_write_enabled = self.is_write_enabled
                        vc.view.backgroundColor = UIColor(named: "univercityColorCod")
                        
                        vc.imageSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                        vc.imageSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                        vc.strName = self.strName
                        vc.str = self.str
                        
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
                        vc.strName = self.strName
                        vc.str = self.str
                        
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true)
                    }
                }))
                
                self.present(refreshAlert, animated: true)
                
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

@IBAction func changeSelection(gesture : CheckBoxEntier ){
    
    
    
    
    if devisionView.backgroundColor == UIColor(named: "selectColor"){
        
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
            
            if devisionRefName.count == DefaultsKeys.resiverId.count{
                
                
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
            print("resiverId1234",DefaultsKeys.resiverId)
            
            
            
        }else{
            
            
            gesture.checkBoxss.isChecked = true
            
            
            if(!DefaultsKeys.resiverId.contains(gesture.memberidssss)){
                DefaultsKeys.resiverId.append(gesture.memberidssss)
            }
            
            print("resiverId12",DefaultsKeys.resiverId)
            
            
            if courseRefName.count == DefaultsKeys.resiverId.count{
                
                allBtn.isSelected = true
                
                allBtn.setImage(UIImage.init(named: "done"), for: .normal)
                
            }
            
            
            else{
                
                
                allBtn.isSelected = false
                //
                allBtn.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                
                
                
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
            
            
            
            
            
            
            print("gggg45456564",DefaultsKeys.resiverId.count)
            
            
            if(isFilter){
                
                if filtered_listDepartment.count == DefaultsKeys.resiverId.count{
                    
                    
                    allBtn.isSelected = true
                    allBtn.setImage(UIImage.init(named: "done"), for: .normal)
                    
                }
                
                
                else{
                    
                    allBtn.isSelected = false
                    allBtn.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                    
                }
                
            }
            else{
                if deparmentRefName.count == DefaultsKeys.resiverId.count{
                    
                    print("gggg45456564",deparmentRefName.count)
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
    
    
    
    
}




@IBAction func selectAllAction(_ sender: UIButton) {
    
    
    DefaultsKeys.resiverId.removeAll()
    
    
    if priority == "p7"{
        
        if entireClgView.backgroundColor == UIColor(named: "selectColor"){
            
            
            if sender.isSelected {
                for index in  clgListDataList.indices{
                    clgListDataList[index].isSelected = false
                    sender.isSelected = false
                    print("forPrint",clgListDataList[index].college_id)
                    
                    if(DefaultsKeys.resiverId.count > 0){
                        DefaultsKeys.resiverId.removeAll()
                    }
                    
                    sender.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                }
            }else{
                
                for index in  clgListDataList.indices{
                    clgListDataList[index].isSelected = true
                    sender.isSelected = true
                    print("forPrint1",clgListDataList[index].college_id)
                    
                    if(!DefaultsKeys.resiverId.contains(String(clgListDataList[index].college_id ?? 0))){
                        DefaultsKeys.resiverId.append(String(clgListDataList[index].college_id ?? 0))
                    }
                    
                    sender.setImage(UIImage.init(named: "done"), for: .normal)
                }
                
            }
        }
        
        else if devisionView.backgroundColor == UIColor(named: "selectColor"){
            
            if sender.isSelected {
                for index in devisionRefName.indices{
                   devisionRefName[index].isSelected = false
                    sender.isSelected = false
                    print("forPrint",devisionRefName[index].division_id ?? "")
                    
                    if(DefaultsKeys.resiverId.count > 0){
                        DefaultsKeys.resiverId.removeAll()
                    }
                    sender.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                }
            }else{
                
                for index in  devisionRefName.indices{
                    devisionRefName[index].isSelected = true
                    sender.isSelected = true
                    print("forPrint1",devisionRefName[index].division_id)
                    
                    if(!DefaultsKeys.resiverId.contains(devisionRefName[index].division_id ?? "")){
                        DefaultsKeys.resiverId.append(devisionRefName[index].division_id ?? "")
                    }
                    
                    sender.setImage(UIImage.init(named: "done"), for: .normal)
                }
                
            }
        }
        
        else if departmentView.backgroundColor == UIColor(named: "selectColor"){
            
            
            
            
            if sender.isSelected {
                for index in  deparmentRefName.indices{
                    deparmentRefName[index].isSelected = false
                    sender.isSelected = false
                    print("forPrint",deparmentRefName[index].department_id ?? "")
                    
                    if(DefaultsKeys.resiverId.count > 0){
                        DefaultsKeys.resiverId.removeAll()
                    }
                    
                    sender.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                }
            }else{
                
                for index in deparmentRefName.indices{
                    deparmentRefName[index].isSelected = true
                    sender.isSelected = true
                    print("forPrint1",deparmentRefName[index].department_id ?? "")
                    
                    if(!DefaultsKeys.resiverId.contains(deparmentRefName[index].department_id ?? "")){
                        DefaultsKeys.resiverId.append(deparmentRefName[index].department_id ?? "")
                    }
                    sender.setImage(UIImage.init(named: "done"), for: .normal)
                }
                
                
            }
            
            
        }
        
        else if groupView.backgroundColor == UIColor(named: "selectColor"){
            
            
            if sender.isSelected {
                
                for i in  groupRefName.indices{
                    groupRefName[i].isSelected = false
                    sender.isSelected = false
                    
                    if(DefaultsKeys.resiverId.count > 0){
                        DefaultsKeys.resiverId.removeAll()
                    }
                    sender.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                }
                
                print("resiverId",DefaultsKeys.resiverId)
            }else{
                
                for index in groupRefName.indices{
                    groupRefName[index].isSelected = true
                    sender.isSelected = true
                    print("forPrint1",groupRefName[index].groupid)
                    
                    var str = String(groupRefName[index].groupid ?? 0)
                    
                    
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
                for index in courseRefName.indices{
                    courseRefName[index].isSelected = false
                    sender.isSelected = false
                    print("forPrint",courseRefName[index].course_id)
                    sender.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                }
                
                if(DefaultsKeys.resiverId.count > 0){
                    DefaultsKeys.resiverId.removeAll()
                }
                
                
                print("resiverId",DefaultsKeys.resiverId)
            }else{
                
                for index in  courseRefName.indices{
                    courseRefName[index].isSelected = true
                    sender.isSelected = true
                    print("forPrint1",courseRefName[index].course_id)
                    
                    if(!DefaultsKeys.resiverId.contains(courseRefName[index].course_id ?? "")){
                        DefaultsKeys.resiverId.append(courseRefName[index].course_id ?? "")
                    }
                    
                    sender.setImage(UIImage.init(named: "done"), for: .normal)
                }
                
                
                print("CourseSelectALLL",DefaultsKeys.resiverId)
                
                
                
            }
            
            
        }
        
        print("TutorTutorTutor")
        
        
        
        
    }
    
    else{
        if devisionView.backgroundColor == UIColor(named: "selectColor"){
            
            if sender.isSelected {
                for index in  devisionRefName.indices{
                    devisionRefName[index].isSelected = false
                    sender.isSelected = false
                    print("forPrint",devisionRefName[index].division_id ?? "")
                    
                    if(DefaultsKeys.resiverId.count > 0){
                        DefaultsKeys.resiverId.removeAll()
                    }
                    
                    sender.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                }
            }else{
                
                for index in devisionRefName.indices{
                    devisionRefName[index].isSelected = true
                    sender.isSelected = true
                    print("forPrint1",devisionRefName[index].division_id ?? "")
                    
                    if(!DefaultsKeys.resiverId.contains(devisionRefName[index].division_id ?? "")){
                        DefaultsKeys.resiverId.append(devisionRefName[index].division_id ?? "")
                    }
                    
                    sender.setImage(UIImage.init(named: "done"), for: .normal)
                }
                
            }
        }
        
        else if departmentView.backgroundColor == UIColor(named: "selectColor"){
            
            if sender.isSelected {
                for index in deparmentRefName.indices{
                    deparmentRefName[index].isSelected = false
                    sender.isSelected = false
                    print("forPrint",deparmentRefName[index].department_id)
                    
                    
                    if(DefaultsKeys.resiverId.count > 0){
                        DefaultsKeys.resiverId.removeAll()
                    }
                    
                    sender.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                }
            }else{
                
                for index in deparmentRefName.indices{
                    deparmentRefName[index].isSelected = true
                    sender.isSelected = true
                    print("forPrint1",deparmentRefName[index].department_id ?? "")
                    
                    if(!DefaultsKeys.resiverId.contains(deparmentRefName[index].department_id ?? "")){
                        DefaultsKeys.resiverId.append(deparmentRefName[index].department_id ?? "")
                    }
                    sender.setImage(UIImage.init(named: "done"), for: .normal)
                }
                
                
            }
            
            
        }
        
        else if groupView.backgroundColor == UIColor(named: "selectColor"){
            
            
            
            
            
            if sender.isSelected {
                for i in  groupRefName.indices{
                    groupRefName[i].isSelected = false
                    sender.isSelected = false
                    
                    
                    if(DefaultsKeys.resiverId.count > 0){
                        DefaultsKeys.resiverId.removeAll()
                    }
                    sender.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                }
                
                
                
                print("resiverId",DefaultsKeys.resiverId)
            }else{
                
                for index in groupRefName.indices{
                    groupRefName[index].isSelected = true
                    sender.isSelected = true
                    print("forPrint1",groupRefName[index].groupid)
                    
                    var str = String(groupRefName[index].groupid ?? 0)
                    
                    
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
                for index in  courseRefName.indices{
                    courseRefName[index].isSelected = false
                    sender.isSelected = false
                    print("forPrint",courseRefName[index].course_id)
                    sender.setImage(UIImage.init(named: "checkboxs"), for: .normal)
                }
                
                if(DefaultsKeys.resiverId.count > 0){
                    DefaultsKeys.resiverId.removeAll()
                }
                
                
                print("resiverId",DefaultsKeys.resiverId)
            }else{
                
                for index in  courseRefName.indices{
                    courseRefName[index].isSelected = true
                    sender.isSelected = true
                    print("forPrint1",courseRefName[index].course_id)
                    
                    if(!DefaultsKeys.resiverId.contains(courseRefName[index].course_id ?? "")){
                        DefaultsKeys.resiverId.append(courseRefName[index].course_id ?? "")
                    }
                    
                    sender.setImage(UIImage.init(named: "done"), for: .normal)
                }
                
                print("CourseSelectALLL",DefaultsKeys.resiverId)
            }
        }
        
        print("TutorTutorTutor")
    }
    tv.reloadData()
}





// Upload AWS Part

    
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
                    
                    if EntierId == "1"{
                        
                        if resivre == "5"{
                            
                            self.ImagePdfEntier(ImageFile: awsArry)
                            
                            
                        }
                        
                        else if resivre == "1"{
                            
                            
                            NoticeSendSmsEntier(ImageFile: awsArry)
                        }
                        
                    }
                    
                    else{
                        
                        if resivre == "5"{
                            
                            
                            self.ImagePdfParticular(ImageFile: awsArry)
                            
                        }
                        
                        else if resivre == "1"{
                            
                            
                            NoticeSendSmsToParticular(ImageFile: awsArry)
                            
                        }
                        
                        
                    }
                    
                          }
           
            case .failure(let error):
                print("Error fetching presigned URL: \(error.localizedDescription)")
            }
        }
        
    }
    

func colgList(){
    
    let defaults = UserDefaults.standard
    
    var clgId = defaults.integer(forKey: DefaultsKeys.collegeid)
    var colglist = clgListModals()
    colglist.college_id = clgId
    colglist.priority = priority
    colglist.user_id = memberId
    
    APiCallManager.shared.callApi(
            url: APIEndpoints.GetBranchCollegeList,
            httpMethod: .post,
            queryParam: nil,
            requestBody: colglist
        ) {[weak self] (result:Result<clgListResponce, Error>) in
                
            guard let self = self else { return }
            
            switch result {
            case .success(let colglistResp):
                
                if colglistResp.Status == 1 {
                    clgListDataList = colglistResp.data ?? []
                    allViewTop.constant = -130
                    tv.dataSource = self
                    tv.delegate = self
                    tv.reloadData()
                }else{
                    
                    let refreshAlert = UIAlertController(title: "", message: colglistResp.Message, preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                        
                    }))
                    
                    present(refreshAlert, animated: true, completion: nil)
                }
            case .failure(let failure):
                 print("Error:",failure.localizedDescription)
            }
            
            }
}

}








class selectResipenceCheckBox : UITapGestureRecognizer {

var pos : Int!

var boxId : String!

var checkBoxss : CheckBoxTwo!


}



class CheckBoxEntier : UITapGestureRecognizer {

var pos : Int!

var memberidssss : String!
var demoImgg : UIImageView!
var checkBoxss : CheckBoxTwo!

var bool : Bool!


}

