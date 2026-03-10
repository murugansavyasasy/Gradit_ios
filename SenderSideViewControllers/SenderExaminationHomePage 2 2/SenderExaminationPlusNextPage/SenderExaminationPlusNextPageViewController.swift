//
//  SenderExaminationPlusNextPageViewController.swift
//  GraditSenderExaminationMenu
//
//  Created by MACBOOKPRO on 03/12/22.
//

import UIKit
import KRProgressHUD
import ObjectMapper
import DropDown

@available(iOS 16.0, *)
class SenderExaminationPlusNextPageViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var calanderTopHeight: NSLayoutConstraint!
    @IBOutlet weak var calandViewss: UIView!
    
    @IBOutlet weak var vtopNameview: UIView!
    @IBOutlet weak var tapBarView: UIViewX!
    
    @IBOutlet weak var clearCacheView: UIView!
    @IBOutlet weak var redirectLoginView: UIViewX!
    @IBOutlet weak var examNameTextField: UITextField!
    
    @IBOutlet weak var getSubAndSecView: UIView!
    
    @IBOutlet weak var semesterLabel: UILabel!
    
    @IBOutlet weak var yearLabel: UILabel!
    
    @IBOutlet weak var courseNameLabel: UILabel!
    
    @IBOutlet weak var departmentLabel: UILabel!
    @IBOutlet weak var divisionSelectedLabel: UILabel!
    @IBOutlet weak var selectYearDropDown: UIViewX!
    
    @IBOutlet weak var selectCourseDropDown: UIViewX!
    @IBOutlet weak var selectDepartDropDown: UIViewX!
    @IBOutlet weak var selectDivisionDropDown: UIViewX!
    @IBOutlet weak var fromDateLabel: UILabel!
    
    @IBOutlet weak var toDateLabel: UILabel!
    @IBOutlet weak var TodateView: UIViewX!
    
    @IBOutlet weak var calanderView: UIViewX!
    
    @IBOutlet weak var loginView: UIView!
    
    @IBOutlet weak var logoutView: UIView!
    
    @IBOutlet weak var changeRolesView: UIView!
    
    @IBOutlet weak var topLabels: UILabel!
    
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var clgLogoImg: UIImageView!
    @IBOutlet weak var changePasswordView: UIView!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var topMessageLabel: UILabel!
    
    @IBOutlet weak var termsAndConditionView: UIView!
    
    
    
    @IBOutlet weak var helpView: UIView!
    
    
    
    @IBOutlet weak var selectSemesterDropDown: UIViewX!
    
    @IBOutlet weak var sideMenuView: UIView!
    
    
    @IBOutlet weak var viewTap: UIView!
    
    @IBOutlet weak var refreshView: UIView!
    
    
    
    @IBOutlet weak var faqView: UIView!
    
    @IBOutlet weak var privacyPolicyView: UIView!
    
    
    @IBOutlet weak var profileView: UIView!
    
    @IBOutlet weak var smallImg: UIImageView!
    @IBOutlet weak var bigImg: UIImageView!
    var addImageBackGroundurl : String!
    var imageWebUrl : String!
    var smallImageUrl  : String!
    
    
    let dropDown = DropDown()
    var courseRefName : [getCourseDataDetails] = []
    var devisionRefName : [getDivisonDataDetails] = []
    var deparmentRefName : [RepienceDeparmentDataDetails] = []
    var yearRef : [getYearListDataDetails] = []
    var facultyDropDownRef : [dropDownDataDetails] = []
    var courseTypeId : String! = ""
    
    var display_date : String!
    var memberName : String!
    var url_date : String!
    var colgImg : String!
    var priority : String!
    var colgId : String!
    var memberID : String!
    
    var departsss : String! = ""
    var sectionID : String! = ""
    var yearIdsew : String! = ""
    
    var MobileNumber : String!
    var password : String!
    
    var loginDatas : [datalogin]!
    var logindataprinci :[datalogin]!
    
    var examsectionRef : [SectiondetailRef]!
    var semid : String!
    
    var calanderId : String!
    
    var str : [String] = []
    var strName : [String] = []
    var is_read_enabled = ""
    var is_write_enabled = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("sert5",smallImageUrl)
        
        bigImg.sd_setImage(with: URL(string: addImageBackGroundurl), placeholderImage: UIImage(named: "ic_white"))
        smallImg.sd_setImage(with: URL(string: smallImageUrl ), placeholderImage: UIImage(named: "ic_white"))
        
        
        fromDateLabel.text = "-SelectDate-"
        toDateLabel.text = "-SelectDate-"
        
        sideMenuView.isHidden = true
        datePicker.isHidden = true
        calandViewss.isHidden = true
        let defaults = UserDefaults.standard
        memberName = defaults.string(forKey: DefaultsKeys.memberName)
        priority = defaults.string(forKey: DefaultsKeys.priority)
        colgId = defaults.string(forKey: DefaultsKeys.collegeid)
        memberID = defaults.string(forKey: DefaultsKeys.memberid)
        colgImg = defaults.string(forKey: DefaultsKeys.colglogo)
        clgLogoImg.sd_setImage(with: URL(string:  colgImg), placeholderImage: UIImage(named: "person.fill"))
        
        topMessageLabel.text = memberName
        
        
        MobileNumber = defaults.string(forKey: DefaultsKeys.mobileNumber)
        
        password  = defaults.string(forKey: DefaultsKeys.Password)
        
        if priority == "p1"{
            tapBarView.backgroundColor = UIColor(named: "Principal" )
            topLabels.text = "Principal"
            
        }
        
        else if priority == "p4"{
            
            topLabels.text = "Student"
            
        }
        
        else if priority == "p2" || priority == "p3"{
            
            tapBarView.backgroundColor = UIColor(named: "Teaching Staff" )
            topLabels.text = "Teacher"
            
        }
        
        else if priority == "p5"{
            
            
            topLabels.text = "Father"
            
            
            
        }
        examNameTextField.returnKeyType = .done
        examNameTextField.delegate = self
        
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(adLoad))
        
        bigImg.isUserInteractionEnabled = true
        bigImg.addGestureRecognizer(singleTap)
        
        let departMentDropDown = UITapGestureRecognizer(target: self, action: #selector(departmentDropDownVc))
        
        
        selectDepartDropDown.addGestureRecognizer(departMentDropDown)
        
        
        let DevisionDown = UITapGestureRecognizer(target: self, action: #selector(devisionVc))
        
        
        selectDivisionDropDown.addGestureRecognizer(DevisionDown)
        
        
        let getSectionView = UITapGestureRecognizer(target: self, action: #selector(getSubAndSecVc))
        
        
        getSubAndSecView.addGestureRecognizer(getSectionView)
        
        
        
        let CourseDown = UITapGestureRecognizer(target: self, action: #selector(CourseDropDownVc))
        
        
        selectCourseDropDown.addGestureRecognizer(CourseDown)
        
        
        
        let YearDown = UITapGestureRecognizer(target: self, action: #selector(YearDropDownVc))
        
        
        selectYearDropDown.addGestureRecognizer(YearDown)
        
        
        
        let SemesterDown = UITapGestureRecognizer(target: self, action: #selector(semesterDropDownVc))
        
        
        selectSemesterDropDown.addGestureRecognizer(SemesterDown)
        
        
        // tap Bar UiTapGuster.
        
        
        let menuGestureHide = UITapGestureRecognizer(target: self, action: #selector(menu))
        viewTap.addGestureRecognizer(menuGestureHide)
        
        
        let refreshGesture = UITapGestureRecognizer(target: self, action: #selector(refreshVc))
        refreshView.addGestureRecognizer(refreshGesture)
        
        
        let faqGesture = UITapGestureRecognizer(target: self, action: #selector(faqRedirect))
        faqView.addGestureRecognizer(faqGesture)
        
        
        let helpGesture = UITapGestureRecognizer(target: self, action: #selector(helpRedirect))
        helpView.addGestureRecognizer(helpGesture)
        //
        
        let privacyPolicyGesture = UITapGestureRecognizer(target: self, action: #selector(privacyPolicyRedirect))
        privacyPolicyView.addGestureRecognizer(privacyPolicyGesture)
        
        let termsAndConditionGesture = UITapGestureRecognizer(target: self, action: #selector(termsAndCondition))
        termsAndConditionView.addGestureRecognizer(termsAndConditionGesture)
        
        let loginRediectGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        redirectLoginView.addGestureRecognizer(loginRediectGesture)
        
        let chagePassword = UITapGestureRecognizer(target: self, action: #selector(changePassowrdVC))
        changePasswordView.addGestureRecognizer(chagePassword)
        
        let changeRol = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        changeRolesView.addGestureRecognizer(changeRol)
        
        
        let topname = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        vtopNameview.addGestureRecognizer(topname)
        
        
        let logoutGesture = UITapGestureRecognizer(target: self, action: #selector(logoutPressed))
        loginView.addGestureRecognizer(logoutGesture)
        
        
        let calanderViewclick = UITapGestureRecognizer(target: self, action: #selector(calanderClickVc))
        calanderView.addGestureRecognizer(calanderViewclick)
        
        let todateClick = UITapGestureRecognizer(target: self, action: #selector(todateClick))
        TodateView.addGestureRecognizer(todateClick)
        
        
    }
    
    
    func getCurrentViewController() -> UIViewController? {
        
        if let rootController = UIApplication.shared.keyWindow?.rootViewController {
            var currentController: UIViewController! = rootController
            while( currentController.presentedViewController != nil ) {
                currentController = currentController.presentedViewController
            }
            return currentController
        }
        return nil
        
    }
    
    
    
    
    @IBAction func getSubAndSecVc(){
        
        
        
        
        if examNameTextField.text == ""{
            
            
            
            
            let refreshAlert = UIAlertController(title: "", message: "Please Enter ExamName", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
                
                
            }))
            
            
            present(refreshAlert, animated: true, completion: nil)
            
        }
        
        else if fromDateLabel.text == "-SelectDate-"{
            
            
            
            
            
            let refreshAlert = UIAlertController(title: "", message: "Please Select FromDate", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
                
                
            }))
            
            
            present(refreshAlert, animated: true, completion: nil)
            
            
        }
        
        
        else if toDateLabel.text == "-SelectDate-"{
            
            
            
            
            
            
            let refreshAlert = UIAlertController(title: "", message: "Please Select FromDate", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
                
                
            }))
            
            
            present(refreshAlert, animated: true, completion: nil)
            
            
            
        }
        
        
        else if divisionSelectedLabel.text == "Select Division"{
            
            
            
            
            
            let refreshAlert = UIAlertController(title: "", message: "Please Select Division", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
                
                
            }))
            
            
            present(refreshAlert, animated: true, completion: nil)
            
            
        }
        
        else if departmentLabel.text == "Select Department"{
            
            
            
            let refreshAlert = UIAlertController(title: "", message: "Please Select Department", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
                
                
            }))
            
            
            present(refreshAlert, animated: true, completion: nil)
            
            
        }
        
        else if courseNameLabel.text == "Select Courrse"{
            
            
            
            
            let refreshAlert = UIAlertController(title: "", message: "Please Select Courrs", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
                
                
            }))
            
            
            present(refreshAlert, animated: true, completion: nil)
            
        }
        
        else if yearLabel.text == "Select Year"{
            
            
            
            
            let refreshAlert = UIAlertController(title: "", message: "Please Select Year", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
                
                
            }))
            
            
            present(refreshAlert, animated: true, completion: nil)
        }
        
        else if semesterLabel.text == "Select Semester"{
            
            
            
            
            
            
            let refreshAlert = UIAlertController(title: "", message: "Please Select Semester", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
                
                
            }))
            
            
            present(refreshAlert, animated: true, completion: nil)
            
        }
        else{
            
            let addExm = exameMainDetail()
      
            
            addExm.examname = examNameTextField.text
            addExm.enddate = toDateLabel.text
            addExm.startdate = fromDateLabel.text
            addExm.sectiondetails = examsectionRef
            
            
            print("addExm.examname addExm.examname", addExm.examname)
            
            let vc = GetSectionAndViewController(nibName: nil, bundle: nil)
            vc.semsterID = semid
            vc.exameName = examNameTextField.text
            vc.startDate = fromDateLabel.text
            vc.endDate = toDateLabel.text
            vc.clgDepartId = departsss
            vc.sectionId = sectionID
            vc.EndDateEdit = toDateLabel.text
            vc.StartDateEdit = fromDateLabel.text
            vc.examCre.append(addExm)
         
            vc.addImageBackGroundurl = addImageBackGroundurl
            vc.strName = strName
            vc.str = str
            vc.smallImageUrl = addImageBackGroundurl
            
            vc.imageWebUrl = imageWebUrl
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true,completion: nil)
            
        }
    }
    @IBAction func semesterDropDownVc(){
        
        
        dropDown.show()
        
    }
    
    
    
    
    
    @IBAction func departmentDropDownVc(){
        
        
        dropDown.show()
        
    }
    
    
    @IBAction func YearDropDownVc(){
        
        
        dropDown.show()
        
    }
    
    @IBAction func CourseDropDownVc(){
        
        
        dropDown.show()
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        examNameTextField.resignFirstResponder()
        return true
    }
    
    
    func DropDowns(){
        
        let devisions = getDivisionModal()
        
        devisions.college_id = colgId
        devisions.user_id =  memberID
        
        let devisionstr = devisions.toJSONString()
        
        
        DivisionRequest.call_request(param: devisionstr!){ [self]
            
            (res) in
            
            
            
            let devisin : GetDivisionResponce  = Mapper<GetDivisionResponce>().map(JSONString: res)!
            
            devisionRefName = devisin.data
            
            var myArray: [String] = []
            var myArrayId: [String] = [ ]
            
            devisionRefName.forEach {(arrType)  in
                myArray.append((arrType.division_name))
                myArrayId.append((arrType.division_id))
                
            }
            print("frdfd",myArray)
            
            dropDown.dataSource = myArray//4
         
            dropDown.anchorView = selectDivisionDropDown //5
            
            dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
            
            dropDown.direction = .bottom
            DropDown.appearance().backgroundColor = UIColor.white
            dropDown.show() //7
            //
            dropDown.selectionAction = { [unowned self] (index:Int, item: String) in
                print("Selected item: \(item) at index: \(index)")
                
                
                self.divisionSelectedLabel.text = item
                
                var idArray : [String] = []
                devisionRefName.forEach {(arrType)  in
                    idArray.append((arrType.division_id))
                    
                }
                
                print("dropDownTextLabel.text\(item)")
                let deparment = DepartmentModal()
                
                deparment.user_id = memberID
                
                deparment.college_id = colgId
                
                deparment.div_id =  idArray[index]
                
                courseTypeId = idArray[index]
                
                print("idArray[index]\(idArray[index])")
                
                
                
                let deparmentstr = deparment.toJSONString()
                RepienceDeparmentRequest.call_request(param: deparmentstr!){ [self]
                    
                    (res) in
                    
                    
                    
                    let depart : RepienceDeparmentResponce  = Mapper<RepienceDeparmentResponce>().map(JSONString: res)!
                    
                    deparmentRefName = depart.data
                    
                    var departs : [String] = []
                    var departmenIds : [String] = []
                    deparmentRefName.forEach {(arrType)  in
                        departs.append((arrType.department_name))
                        departmenIds.append((arrType.department_id))
                        
                    }
                    print("frdfd",departs)
                    
                    dropDown.dataSource = departs//4
                   
                    dropDown.anchorView = selectDepartDropDown //5
                    
                    dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
                    
                    dropDown.direction = .bottom
                    DropDown.appearance().backgroundColor = UIColor.white
                    dropDown.show() //7
                    //
                    dropDown.selectionAction = { [unowned self] (index:Int, item: String) in
                        print("Selected item: \(item) at index: \(index)")
                        
                        //
                        self.departmentLabel.text = item
                        
                        
                        var courseName : [String] = []
                        
                        
                        let course =  getCourseModal()
                        
                        course.user_id = memberID
                        course.college_id = colgId
                        course.dept_id = departmenIds[index]
                        
                        print("fhfytghfg",departmenIds[index])
                        
                        departsss = departmenIds[index]
                        
                        let coursestr = course.toJSONString()
                        GetCourseRequest.call_request(param: coursestr!){ [self]
                            
                            (res) in
                            //
                            //
                            //
                            let cour : getCourseResponce  = Mapper<getCourseResponce>().map(JSONString: res)!
                            
                            courseRefName = cour.data
                            var CourseIds : [String] = []
                            courseRefName.forEach {(arrType)  in
                                courseName.append((arrType.course_name))
                                CourseIds.append(arrType.course_id)
                            }
                            dropDown.dataSource = courseName//4
                          
                            dropDown.anchorView = selectCourseDropDown //5
                            
                            dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
                            
                            dropDown.direction = .bottom
                            DropDown.appearance().backgroundColor = UIColor.white
                            dropDown.show() //7
                            //
                            dropDown.selectionAction = { [unowned self] (index:Int, item: String) in
                                print("Selected item: \(item) at index: \(index)")
                                
                                self.courseNameLabel.text = item
                                
                                
                                
                                
                                
                                let years = getYearListModal()
                                
                                years.idcollege = colgId
                                years.clgprocessby = memberID
                                years.idcourse = CourseIds[index]
                                years.iddept = departsss
                                
                                print("depaertt",departsss)
                                
                                let yearstr = years.toJSONString()
                                getYearListRequest.call_request(param: yearstr!){ [self]
                                    
                                    (res) in
                                    //
                                    //
                                    //
                                    let cour : getYearListResponce  = Mapper<getYearListResponce>().map(JSONString: res)!
                                    
                                    yearRef = cour.data
                                    
                                    var yearName : [String] = []
                                    var yearIdss : [Int] = []
                                    yearRef.forEach {(arrType)  in
                                        yearName.append((arrType.yearname))
                                        yearIdss.append(arrType.yearid)
                                    }
                                    
                                    let stringArray = yearIdss.map { String($0) }
                                    let string = stringArray.joined(separator: ", ")
                                    
                                    print("thoiedasefcdsx",string)
                                    //
                                    
                                    dropDown.dataSource = yearName//4
                                    
                                    dropDown.anchorView = selectYearDropDown //5
                                    
                                    dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
                                    
                                    dropDown.direction = .bottom
                                    DropDown.appearance().backgroundColor = UIColor.white
                                    dropDown.show() //7
                                    //
                                    dropDown.selectionAction = { [unowned self] (index:Int, item: String) in
                                        print("Selected item: \(item) at index: \(index)")
                                        
                                        self.yearLabel.text = item
                                        
                                        
                                        
                                        let faculDrops = dropDownModal()
                                        
                                        faculDrops.yearid = yearIdss[index]
                                        
                                        let faculStr = faculDrops.toJSONString()
                                        
                                        facultyDropDownRequest.call_request(param: faculStr!){ [self]
                                            (res) in
                                            
                                            let facultyResp : dropDownResponce =
                                            Mapper<dropDownResponce>().map(JSONString: res)!
                                            
                                            facultyDropDownRef = facultyResp.data
                                            
                                            var semesterNam : [String] = []
                                            
                                            
                                            facultyDropDownRef.forEach {(arrType)  in
                                                semesterNam.append((arrType.semestername))
                                                
                                            }
                                            
                                            
                                            dropDown.dataSource = semesterNam//4
                                            
                                            dropDown.anchorView = selectSemesterDropDown //5
                                            
                                            dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
                                            
                                            dropDown.direction = .bottom
                                            DropDown.appearance().backgroundColor = UIColor.white
                                            dropDown.show() //7
                                            //
                                            dropDown.selectionAction = { [unowned self] (index:Int, item: String) in
                                                print("Selected item: \(item) at index: \(index)")
                                                
                                                self.semesterLabel.text = item
                                                
                                                for i in facultyResp.data{
                                                    
                                                    
                                                    semid = i.clgsemesterid
                                                    for isa in i.sectiondetails{
                                                        
                                                        sectionID = isa.sectionid
                                                        
                                                    }
                                                    
                                                    
                                                }
                                                
                                                
                                                
                                            }
                                        }
                                        
                                        
                                        
                                    }
                                    
                                    
                                    
                                    
                                }
                                
                                
                            }
                            
                            
                            
                        }
                        
                        
                        
                        
                        
                        
                        
                    }
                    
                }
                
            }
            
            
            
            
            
            
            
            
        }
        
        
        
    }
    
    
    
    
    @IBAction func dropDownVc(){
        
        
        let deparment = DepartmentModal()
        
        deparment.user_id = memberID
        
        deparment.college_id = colgId
        
        deparment.div_id =  courseTypeId
        
        
        let deparmentstr = deparment.toJSONString()
        print("deparmentstr",deparmentstr)
        RepienceDeparmentRequest.call_request(param: deparmentstr!){ [self]
            
            (res) in
            
            let depart : RepienceDeparmentResponce  = Mapper<RepienceDeparmentResponce>().map(JSONString: res)!
            
            var addAryy: [String] = [ ]
            var itemAryy: [String] = [ ]
            
            
            depart.data .forEach {(arrType)  in
                addAryy.append((arrType.department_name))
                
            }
            
            
            dropDown.dataSource = addAryy//4
            dropDown.anchorView = selectCourseDropDown //5
            
            dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
            //
            dropDown.direction = .bottom
            DropDown.appearance().backgroundColor = UIColor.white
            dropDown.show() //7
            
            var idArray : [String] = []
            deparmentRefName.forEach {(arrType)  in
                idArray.append((arrType.department_id))
                
            }
            //
            dropDown.selectionAction = { [unowned self] (index:Int, item: String) in
                print("Selected item: \(item) at index: \(index)")
                
                
                
                let course =  getCourseModal()
                
                course.user_id = memberID
                course.college_id = colgId
                course.dept_id = idArray[index]
                
                print("fhfytghfg",idArray[index])
                
                
                let coursestr = course.toJSONString()
                GetCourseRequest.call_request(param: coursestr!){ [self]
                    
                    (res) in
                    //
                    //
                    //
                    let cour : getCourseResponce  = Mapper<getCourseResponce>().map(JSONString: res)!
                    
                    courseRefName = cour.data
                    
                    
                }
                
                
            }
            
            
            
            
            
        }
        
        
    }
    
    
    @IBAction func devisionVc(){
        
        
        
        DropDowns()
        
        
    }
    
    @IBAction func adLoad(){
        
        
        
        let vc = TotalAddLoadPageViewController(nibName: nil, bundle: nil)
        
        vc.AddWebUrl = imageWebUrl
        
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
        
        
    }
    
    
    
    @IBAction func calanderClickVc(){
        toDateLabel.text = "DD/MM/YYY"
        FromDate_Action()
        
        
        
    }
    
    
    
    @IBAction func todateClick(){
        datePicker.isHidden = false
        calandViewss.isHidden = false
        calanderTopHeight.constant = 328
        Todate()
        
        
        
    }
    
    
    func FromDate_Action(){
        
        calanderId = "1"
        
        RPicker.selectDate(title: "Select Date", cancelText: "Cancel", datePickerMode: .date, style: .Inline, didSelectDate: {[weak self] (today_date) in
            
            
            
            self?.display_date = today_date.dateString("dd/MM/yyyy")
            
            self?.url_date = today_date.dateString("yyyy-M-dd")
            
            self?.fromDateLabel.text = self!.display_date
            
        })
        
    }
    
    func Todate(){
        
        
        let dateFormater: DateFormatter = DateFormatter()
        dateFormater.dateFormat = "dd/M/yyyy"
        let currentDate = fromDateLabel.text
        let date = dateFormater.date(from:currentDate!)!
        var dt : Date!
        dt = date
        
        
        datePicker.minimumDate = dt
        
        let selectedDate = dateFormater.string(from: datePicker.date)
        print("selectedDate",selectedDate)
        
        
        
        
        
        
    }
    
    
    @IBAction func dte(_ sender: UIDatePicker) {
        print("print \(sender.date)")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/M/yyyy"
        let somedateString = dateFormatter.string(from: sender.date)
        
        
        toDateLabel.text = somedateString
        print(somedateString)
    }
    
    
    
    
    @IBAction func backbtn(_ sender: Any) {
        
        dismiss(animated: true)
        
    }
    
    
    // Tab Bar Nagivation
    
    
    
    @IBAction func helpRedirect() {
        
        let vc = HelpViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        let currentController = self.getCurrentViewController()
        currentController?.present(vc, animated: true, completion: nil)
        
        
    }
    
    
    @IBAction func termsAndCondition() {
        
        let vc = MenuTermsViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        let currentController = self.getCurrentViewController()
        currentController?.present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func logoutPressed() {
        
        
        
        
        let refreshAlert = UIAlertController(title: "", message: "Are you sure do you want to logout", preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "YES", style: .default, handler: { (action: UIAlertAction!) in
            
            
            UserDefaults.standard.removeObject(forKey: DefaultsKeys.mobileNumber)
            
            let vc = LoginNewViewController(nibName: nil, bundle: nil)
            vc.modalPresentationStyle = .fullScreen
            
            self.present(vc, animated: true, completion: nil)
            
            
        }))
        
        
        refreshAlert.addAction(UIAlertAction(title: "NO", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        present(refreshAlert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func faqRedirect() {
        print("faqRedirect")
        let vc = FaqViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        let currentController = self.getCurrentViewController()
        currentController?.present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func privacyPolicyRedirect() {
        
        let vc = PrivacyPolicyViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        let currentController = self.getCurrentViewController()
        currentController?.present(vc, animated: true, completion: nil)
        
    }
    
    
    
    
    
    @IBAction func refreshVc() {
        
        print("refreshVcWork")
        KRProgressHUD.show()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            KRProgressHUD.dismiss()
            
        }
        
        
    }
    
    
    @IBAction func notificationVc() {
        print("NotificationViewController")
        let vc = NotificationViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        let currentController = self.getCurrentViewController()
        currentController?.present(vc, animated: false, completion: nil)
        
    }
    
    
    
    
    @IBAction func menu() {
        
        if sideMenuView.isHidden == true{
            
            sideMenuView.isHidden = false
            //
            
            print("menuVisble")
        }
        
        else{
            
            sideMenuView.isHidden = true
            
            print("mddffenuVisble")
        }
        
        
    }
    
    
    @IBAction func changePassowrdVC(){
        
        let vc = ChangePasswordViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        let currentController = self.getCurrentViewController()
        currentController?.present(vc, animated: true, completion: nil)
        
        
    }
    
    
    
    
    @IBAction func priorityVc() {
        let vc = PriorityViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
    }
    
    @IBAction func doneBtn(_ sender: Any) {
        
        print("click")
        calandViewss.isHidden = true
        calanderTopHeight.constant = 0
    }
    
}
