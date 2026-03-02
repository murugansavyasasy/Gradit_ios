//
//  GetSectionAndViewController.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 26/03/23.
//

import UIKit
import ObjectMapper
import KRProgressHUD
import DropDown
import ExpyTableView
@available(iOS 16.0, *)
class GetSectionAndViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate, UIGestureRecognizerDelegate,UITextViewDelegate {
    
    @IBOutlet weak var tapBarView: UIView!
    
    @IBOutlet weak var exameTopicDefaultLbl: UILabel!
    @IBOutlet weak var redirectLoginView: UIViewX!
    @IBOutlet weak var datePickerSet: UIDatePicker!
    
    @IBOutlet weak var Tv: UITableView!
    
    @IBOutlet weak var datePickerView: UIView!
    
    @IBOutlet weak var confirmView: UIView!
    
    
    
    @IBOutlet weak var TopTv: UITableView!
    @IBOutlet weak var nodataView: UIView!
    
    @IBOutlet weak var noDataLabel: UILabel!
    
    
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var topLabels: UILabel!
    
    
    @IBOutlet weak var profileView: UIView!
    
    @IBOutlet weak var viewTap: UIView!
    
    @IBOutlet weak var clgLogoImg: UIImageView!
    @IBOutlet weak var topMessageLabel: UILabel!
    
    
    
    @IBOutlet weak var smallImg: UIImageView!
    @IBOutlet weak var bigImg: UIImageView!
    @IBOutlet weak var adView: UIView!
    
    @IBOutlet weak var changeRolesView: UIView!
    
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var refreshView: UIView!
    
    @IBOutlet weak var sideMenuView: UIView!
    
    
    @IBOutlet weak var termsAndConditionView: UIView!
    @IBOutlet weak var faqView: UIView!
    
    @IBOutlet weak var privacyPolicyView: UIView!
    
    
    @IBOutlet weak var changePasswordView: UIView!
    @IBOutlet weak var helpView: UIView!
    
    
    
    var didSeleId : Int!
    var closedidSeleId : Int!
    
    
    
    var SubjectdetailssujectData : [Subjectdetails] = []
    var sujectData : [Subjectdetails] = []
    
    var examViewRefName : [examviewDataDetails] = []
    var indexPathss : Int!
    var indexPat : [Int] = []
    var indexPathsections : Int!
    
    
    var getSectionName : String!
    var getHeaderId : String!
    
    var selectedList1 : [String:[String]] = [:]
    var sunjectNewId : String!
    var selectedList = [[String]]()
    var subjectProperId  = ""
    var identifiers = "ExameCreationTableViewCell"
    var identifier2 = "GetSectionYearHeaderFooterView"
    var reloadSections: ((_ section: Int) -> Void)?
    var getSection : [getSubjectWiseDataDetails] = []
    var GetSectionNmeRef : [getSectionDatasDetails] = []
    var examAddRef : [Sectiondetails] = []
    var examSubRef : [Datass] = []
    var sectionRefss : [Subjectdetails] = []
    
    var ExameSection : [examviewDataDetails] = [] // this for edit list variabel
    
    var dteStringGet : String!
    //    var subRefName : [subjectDatasDetails] = []
    
    var aryObject : [String] = []
    var userId : String!
    var appId : String!
    var display_date : String!
    
    var url_date : String!
    var semsterID : String!
    var selectedCell : IndexPath?
    var colgId : String!
    
    var exameName : String!
    
    var startDate : String!
    
    var endDate : String!
    
    var clgDepartId : String!
    
    var sectionId : String!
    
    var examHeaderId : String!
    
    var sunjectIds : [String] = []
    var sectionIds : [String] = []
    var model = [String]()
    var sylubus : [String] = []
    var venu : [String]  = []
    var nameString : String!
    
    var subjectsssss : String!
    var venusss : [String] = []
    var sylubasss : [String] = []
    var datess : [String] = []
    var productTags : [String : [String]] = [:]
    var venstr : String!
    var sylubstr : String!
    var indexss : [Int] = []
    
    
    
    var loginDatas : [datalogin]!
    var logindataprinci :[datalogin]!
    
    var MobileNumber : String!
    
    var password : String!
    
    var priority : String!
    
    var  colgImg : String!
    
    var addImageBackGroundurl : String!
    
    var smallImageUrl : String!
    var seci  = ""
    var imageWebUrl : String!
    var hiddenSections = Set<Int>()
    let dropDown = DropDown()
    
    var clgsection : [SectiondetailRef] = []
    
    var examCre : [exameMainDetail] = []
    
    var examEditresp : [exameEditMainDetail] = [] // important
    var examEditsModalApi : [EditSubjectDetailsRef] = [] // important
    
    
    var selectedIndex = -1
    
    
    
    var examEditresp1 : [exameEditMainDetail] = [] // important
    var examEditsModalApi1 : [EditSubjectDetailsRef] = [] // important
    
    var EditId : String!
    
    var sectionNameForEdit : String!
    
    //    var venuTextfld : UITextField!
    
    var sectionIdForEdit : String! // this for exam edit Section Id
    var examHeaderIdForEdit : String! // this for exam edit examHeade Id
    
    var ExamEditSubjectId : String!
    var StartDateEdit : String!
    var EndDateEdit : String!
    var ExameNameEdit : String!
    var isclosaps = false
    
    var sectionsForCompar : String!
    var NonSaveSectionId : String!
    
    var DateIdForcell : String!
    var str : [String] = []
    var strName : [String] = []
    
    var venuCellLabelEdit  : [String] = []
    var sylubasLabelEdit  : [String] = []
    var DateLabelEdit  : [String] = []
    var NoonLabelEdit  : [String] = []
    var subjectLabelEdit  : [String] = []
    var ids : String!
    var HeaderSectionCheckBoxx : CheckBoxThree!
    var refrencenceSecctionId : [String] = [""]
    var refrence : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if EditId == "1"{
            
            
            exameTopicDefaultLbl.text = "Edit  Examination"
        }
        
        else{
            
            
            exameTopicDefaultLbl.text = "Create Examination"
        }
        
        
        
        
        
        
        
        print("nklnkl;hjkln",examEditsModalApi1.count)
        
        
        
        
        
        
        bigImg.sd_setImage(with: URL(string: addImageBackGroundurl), placeholderImage: UIImage(named: "ic_white"))
        smallImg.sd_setImage(with: URL(string: smallImageUrl ), placeholderImage: UIImage(named: "ic_white"))
        
        nodataView.isHidden = true
        noDataLabel.isHidden = true
        sideMenuView.isHidden = true
        
        let defaults = UserDefaults.standard
        
        
        priority  =  defaults.string(forKey: DefaultsKeys.priority)
        userId = defaults.string(forKey: DefaultsKeys.memberid)
        
        colgId = defaults.string(forKey: DefaultsKeys.collegeid)
        
        MobileNumber = defaults.string(forKey: DefaultsKeys.mobileNumber)
        password = defaults.string(forKey: DefaultsKeys.Password)
        
        colgImg = defaults.string(forKey: DefaultsKeys.colglogo)
        clgLogoImg.sd_setImage(with: URL(string:  colgImg), placeholderImage: UIImage(named: "person.fill"))
        
        topMessageLabel.text = defaults.string(forKey: DefaultsKeys.memberName)
        
        
        
        if priority == "p1"{
            
            topLabels.text = "Principal"
            tapBarView.backgroundColor = UIColor(named: "Principal")
            view.backgroundColor = UIColor(named: "Principal")
        }
        
        else if priority == "p4"{
            
            topLabels.text = "Student"
            
        }
        
        else if priority == "p2" {
            
            tapBarView.backgroundColor = UIColor(named: "Teaching Staff")
            topLabels.text = "Hod"
            
        }
        
        else if priority == "p5"{
            
            
            topLabels.text = "Father"
            
            
            
        }
        
        else if  priority == "p3"{
            tapBarView.backgroundColor = UIColor(named: "Teaching Staff")
            topLabels.text = "Teacher"
            
            
        }
        
        priority = defaults.string(forKey: DefaultsKeys.priority)
        GetSectionAndYear()
        
        let rowNib = UINib(nibName: identifiers, bundle: nil)
        Tv.register(rowNib, forCellReuseIdentifier: identifiers)
        
        let rownib2 = UINib(nibName: identifier2, bundle: nil)
        Tv.register(rownib2, forHeaderFooterViewReuseIdentifier: identifier2)
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(adLoad))
        
        bigImg.isUserInteractionEnabled = true
        bigImg.addGestureRecognizer(singleTap)
        
        let confirm = UITapGestureRecognizer(target: self, action: #selector(ConfirmVc))
        confirmView.addGestureRecognizer(confirm)
        
        // tap Bar UiTapGuster.
        
        let loginRediectGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        redirectLoginView.addGestureRecognizer(loginRediectGesture)
        
        
        
        let changeRolesGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        changeRolesView.addGestureRecognizer(changeRolesGesture)
        
        
        let logoutGesture = UITapGestureRecognizer(target: self, action: #selector(logoutPressed))
        loginView.addGestureRecognizer(logoutGesture)
        
        
        
        
        
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
        
        
        let chagePassword = UITapGestureRecognizer(target: self, action: #selector(changePassowrdVC))
        changePasswordView.addGestureRecognizer(chagePassword)
        
        let toplabelclick = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        topLabels.addGestureRecognizer(toplabelclick)
        
        
        
    }
    
    
    
    @IBAction func adLoad(){
        
        
        
        let vc = TotalAddLoadPageViewController(nibName: nil, bundle: nil)
        
        vc.AddWebUrl = imageWebUrl
        
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
        
        
    }
    
    @IBAction func ConfirmVc(){
        
        let refreshAlert = UIAlertController(title: "Hold on!", message: "Are you sure do you want to submit?", preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in
            
            
            
            createExam()
            
            
        }))
        
        
        refreshAlert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        
        present(refreshAlert, animated: true, completion: nil)
        
        
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        
        
        return getSection.count
        
        
        
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifiers, for: indexPath) as!
        
        ExameCreationTableViewCell
        
        let section :  getSubjectWiseDataDetails = getSection[indexPath.row]
        
        
        
        
        
        if EditId == "1"{
            
            
            print("kjhgfdsdfghjkl;.",  cell.SectionIdRefrence)
            
            
            if let selectedCell = selectedCell, selectedCell == indexPath {
                
                
                cell.SubjectTabelView.isHidden = false
                cell.sectionCheckBox.isChecked = true
                
                
                cell.SectionIdRefrence = section.sectionid
                
                
                
                print("oiuytrtyuiopplkjhgf",  cell.SectionIdRefrence)
                
                cell.arrowImgeView.image = UIImage(named: "arrow-up")
            }
            
            else{
                
                
                cell.arrowImgeView.image = UIImage(named: "downward-arrow (2)")
                cell.SubjectTabelView.isHidden = true
                
            }
            
            
            cell.sectionLbl.text = section.sectionname
            
            
            cell.GetSectionNmeRef = section.subjectdetails
            
            
            cell.closedidSeleId  = closedidSeleId
            
            
            
            cell.SubjectdetailssujectData =  SubjectdetailssujectData
            cell.sujectData =  sujectData
            
            cell.examViewRefName = examViewRefName
            
            cell.indexPat = indexPat
            
            cell.getSectionName =  getSectionName
            cell.getHeaderId = getHeaderId
            
            cell.selectedList1 = selectedList1
            cell.sunjectNewId = sunjectNewId
            cell.selectedList = selectedList
            cell.subjectProperId  = subjectProperId
            
            cell.reloadSections = reloadSections
            //
            cell.examAddRef  = examAddRef
            cell.examSubRef = examSubRef
            cell.sectionRefss = sectionRefss
            
            cell.ExameSection = ExameSection // this for edit list variabel
            
            cell.dteStringGet  = dteStringGet
         
            
            cell.aryObject = aryObject
            cell.userId = userId
            cell.appId =   appId
            cell.display_date = display_date
            
            cell.url_date = url_date
            cell.semsterID = semsterID
            cell.selectedCell =  selectedCell
            cell.colgId = colgId
            
            cell.exameName = exameName
            
            cell.startDate  =  startDate
            
            cell.endDate = endDate
            
            cell.clgDepartId  = clgDepartId
            
            cell.sectionId =  sectionId
            
            cell.examHeaderId = examHeaderId
            
            cell.sunjectIds =  sunjectIds
            cell.sectionIds =  sectionIds
            cell.model =  model
            cell.sylubus = sylubus
            cell.venu = venu
            cell.nameString = nameString
            
            
            
            
            cell.loginDatas =  loginDatas
            cell.logindataprinci =  logindataprinci
            
            cell.examEditresp = examEditresp
            cell.examEditsModalApi =  examEditsModalApi
            
            
            
            
            cell.examEditresp1 = examEditresp1 // important
            cell.examEditsModalApi1 = examEditsModalApi1 // important
            
            cell.EditId = EditId
            
            cell.sectionNameForEdit = sectionNameForEdit
            
            //    var venuTextfld : UITextField!
            
            cell.sectionIdForEdit = sectionIdForEdit// this for exam edit Section Id
            cell.examHeaderIdForEdit = examHeaderIdForEdit  // this for exam edit examHeade Id
            
            cell.ExamEditSubjectId = ExamEditSubjectId
            cell.StartDateEdit = StartDateEdit
            cell.EndDateEdit = EndDateEdit
            cell.ExameNameEdit =   ExameNameEdit
            
            
            
            
            var DateIdForcell : String!
            
            if   sectionIdForEdit ==  section.sectionid {
                
                cell.isUserInteractionEnabled = true
                
                cell.sectionCheckBox.isChecked = true
                
                
                
                cell.sectionLbl.text = section.sectionname
                
                
                
                
            }
            
            
            
            else {
                
                cell.isUserInteractionEnabled = false
                
                cell.secionOverAllView.backgroundColor = UIColor.gray
            }
            //
            
        }
        
        
        
        
        
        
        else{
            if let selectedCell = selectedCell, selectedCell == indexPath {
                
                
                cell.SubjectTabelView.isHidden = false
                cell.sectionCheckBox.isChecked = true
                
                
                cell.SectionIdRefrence = section.sectionid
                
                
                
                print("sectioniddd",  cell.SectionIdRefrence)
                
                
                
                cell.arrowImgeView.image = UIImage(named: "arrow-up")
                
            }
            
            else{
                cell.arrowImgeView.image = UIImage(named: "downward-arrow (2)")
                
                cell.SubjectTabelView.isHidden = true
            }
            
            
            
            
            
            
            cell.GetSectionNmeRef = section.subjectdetails
            
            
            //
            cell.sectionLbl.text = section.sectionname
            
            
            
            
            cell.closedidSeleId  = closedidSeleId
            
            
            
            cell.SubjectdetailssujectData =  SubjectdetailssujectData
            cell.sujectData =  sujectData
            
            cell.examViewRefName = examViewRefName
            
            cell.indexPat = indexPat
            
            
            cell.getSectionName =  getSectionName
            cell.getHeaderId = getHeaderId
            
            cell.selectedList1 = selectedList1
            cell.sunjectNewId = sunjectNewId
            cell.selectedList = selectedList
            cell.subjectProperId  = subjectProperId
            
            cell.reloadSections = reloadSections
            //
            cell.examAddRef  = examAddRef
            cell.examSubRef = examSubRef
            cell.sectionRefss = sectionRefss
            
            cell.ExameSection = ExameSection // this for edit list variabel
            
            cell.dteStringGet  = dteStringGet
            
            cell.aryObject = aryObject
            cell.userId = userId
            cell.appId =   appId
            cell.display_date = display_date
            
            cell.url_date = url_date
            cell.semsterID = semsterID
            cell.selectedCell =  selectedCell
            cell.colgId = colgId
            
            cell.exameName = exameName
            
            cell.startDate  =  startDate
            
            cell.endDate = endDate
            
            cell.clgDepartId  = clgDepartId
            
            cell.sectionId =  sectionId
            
            cell.examHeaderId = examHeaderId
            
            cell.sunjectIds =  sunjectIds
            cell.sectionIds =  sectionIds
            cell.model =  model
            cell.sylubus = sylubus
            cell.venu = venu
            cell.nameString = nameString
            
            
            
            
            cell.loginDatas =  loginDatas
            cell.logindataprinci =  logindataprinci
            
            cell.examEditresp = examEditresp
            cell.examEditsModalApi =  examEditsModalApi
            
            
            
            cell.examEditresp1 = examEditresp1 // important
            cell.examEditsModalApi1 = examEditsModalApi1 // important
            
            cell.EditId = EditId
            
            cell.sectionNameForEdit = sectionNameForEdit
            
            cell.sectionIdForEdit = sectionIdForEdit// this for exam edit Section Id
            cell.examHeaderIdForEdit = examHeaderIdForEdit  // this for exam edit examHeade Id
            
            cell.ExamEditSubjectId = ExamEditSubjectId
            cell.StartDateEdit = StartDateEdit
            cell.EndDateEdit = EndDateEdit
            cell.ExameNameEdit =   ExameNameEdit
            
            
            
            var DateIdForcell : String!
            
            
            
        }
        
        
        
        
        
        
        
        
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifiers, for: indexPath) as!
        
        ExameCreationTableViewCell
        
        let section :  getSubjectWiseDataDetails = getSection[indexPath.row]
        
        
        
        
        if EditId == "1"{
            
            
            if let selectedCells = selectedCell, selectedCells == indexPath {
                
                selectedCell = nil
                
                
                
                cell.arrowImgeView.image = UIImage(named: "downward-arrow (2)")
                
            }
            
            else{
                cell.arrowImgeView.image = UIImage(named: "arrow-up")
                
                selectedCell = indexPath
                
                cell.sectionCheckBox.isChecked = true
            }
            
        }
        
        
        
        
        
        else{
            
            
            
            
            if let selectedCells = selectedCell, selectedCells == indexPath {
                
                selectedCell = nil
                
                
                cell.arrowImgeView.image = UIImage(named: "downward-arrow (2)")
            }
            
            else{
                
                cell.arrowImgeView.image = UIImage(named: "arrow-up")
                selectedCell = indexPath
                
                
                cell.sectionCheckBox.isChecked = true
                cell.SectionIdRefrence = section.sectionid
                
                let vc = SectiondetailRef()
                
                vc.clgsectionid =  section.sectionid
                
                
                clgsection.append(vc)
                
                
                
            }
            
            
            
        }
        
        Tv.beginUpdates()
        Tv.endUpdates()
        Tv.reloadData()
        
        
        
        
        
    }
    
    
    
    @IBAction func NoonVc(ges : NoonCell){
        
        
        let  myArray = ["An","Fn"]
        
        dropDown.dataSource = myArray//4
        dropDown.anchorView = ges.noonClick
        
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        
        dropDown.direction = .bottom
        DropDown.appearance().backgroundColor = UIColor.white
        dropDown.show() //7
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            ges.noonLabel.text = item
            
            
        }
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //
        
        
        
        if let selectedCell = selectedCell, selectedCell == indexPath {
            
            return 240
            
        } else {
            
            return 50
            
        }
        
    }
    
    func GetSectionAndYear(){
        var GetSe : [getSectionDatasDetails] = []
        let section = getSubjectWiseSectionModal()
        
        section.userid = userId
        section.appid = "2"
        section.semesterid = semsterID
        
        
        let sectionStr = section.toJSONString()
        
        
        
        getSectionWiseRequest.call_request(param: sectionStr!) {
            
            [self]  (res) in
            
            
            
            
            
            let particular : getSubjectWiseResponce = Mapper<getSubjectWiseResponce>().map(JSONString: res)!
            
            
            
            getSection = particular.data
            
            
            
            
            if particular.Status == 1 {
                //                
                
                //                
                for i in particular.data{
                    
                    GetSectionNmeRef = i.subjectdetails
                    
                }
                
                
                
                
                nodataView.isHidden = true
                noDataLabel.isHidden = true
                
                Tv.dataSource = self
                Tv.delegate = self
                Tv.reloadData()
                
                
            }else{
                nodataView.isHidden = false
                noDataLabel.isHidden = false
                noDataLabel.text = particular.Message
                Tv.dataSource = self
                Tv.delegate = self
                Tv.reloadData()
                
            }
            
            
            
        }
        
        
        
        
        
        
    }
    
    
    func createExam(){
        if EditId == "1"{
            
            
            if DefaultsKeys.saveButtonId == "1"{
                
                
                
                let createExam = ExameEditModal()
                
                
                for z in 0..<examEditresp1.count{
                    
                    
                    
                    
                    
                    
                    createExam.examid = examEditresp1[z].examid
                    createExam.userid = examEditresp1[z].staffid
                    createExam.colgid = examEditresp1[z].collegeid
                    createExam.sectionid = sectionIdForEdit
                    
                    createExam.processtype = "edit"
                    
                    
                    var sections : [Sectiondetails] = []
                    
                    
                    var sujectData : [Subjectdetails] = []
                    
                    var subjectDataEdit : [ExamDetailsDataDetails] = []
                    
                    
                    for ik in 0..<(DefaultsKeys.saveEdit.count)
                    {
                        
                        
                        
                        let subjectdetails  =  ExamDetailsDataDetails()
                        
                        if (DefaultsKeys.saveEdit[ik].examsyllabus.contains(sectionIdForEdit) ) && (DefaultsKeys.saveEdit[ik].examvenue.contains(sectionIdForEdit) ) && (DefaultsKeys.saveEdit[ik].examdate.contains(sectionIdForEdit) ) && (DefaultsKeys.saveEdit[ik].examsubjectid.contains(sectionIdForEdit) ) {
                            
                            
                            
                            print("iops",DefaultsKeys.saveEdit.count)
                            
                            
                            
                            
                            
                            let date = DefaultsKeys.saveEdit[ik].examdate;
                            let resultdate = date!.split(separator: "/ ")
                            print("result",resultdate)
                            print(resultdate[0]) // Hello
                            print(resultdate[1])
                            
                            
                            subjectdetails.examdate =  String(resultdate[1])
                            
                            
                            let venu = DefaultsKeys.saveEdit[ik].examvenue;
                            let resultvenu = venu!.split(separator: "/ ")
                            print("result",resultvenu)
                            print(resultvenu[0]) // Hello
                            print(resultvenu[1])
                            
                            
                            subjectdetails.examvenue = String(resultvenu[1])
                            
                            
                            
                            subjectdetails.examsession = "An"
                            
                            let sylubas = DefaultsKeys.saveEdit[ik].examsyllabus;
                            let resultsylubs = sylubas!.split(separator: "/ ")
                            print("result",resultsylubs)
                            print(resultsylubs[0]) // Hello
                            print(resultsylubs[1])
                            
                            
                            subjectdetails.examsyllabus = String(resultsylubs[1])
                            
                            
                            
                            
                            
                            
                            
                            
                            let sayHello = DefaultsKeys.saveEdit[ik].examsubjectid;
                            let result = sayHello!.split(separator: "/ ")
                            print("result",result)
                            print(result[0]) // Hello
                            print(result[1])
                            
                            
                            
                            
                            subjectdetails.clgsubjectid = String(result[1])
                            
                            
                            
                            
                            
                            subjectDataEdit.append(subjectdetails)
                            
                        }
                        
                        
                        
                        
                    }
                    
                    
                    createExam.subjectdetails = subjectDataEdit
                    
                    
                    
                    
                    
                    
                    
                    
                }
                
                let createExamStr = createExam.toJSONString()
                
                
                ExameEditREquest.call_request(param: createExamStr!) {
                    //
                    [self]  (res) in
                    
                    
                    let exams : ExaminationAddResponce = Mapper<ExaminationAddResponce>().map(JSONString: res)!
                    
                    
                    //                examSubRef = exams.data
                    
                    if exams.status == 1 {
                        
                        
                        
                        
                        let refreshAlert = UIAlertController(title: "", message:  exams.message, preferredStyle: UIAlertController.Style.alert)
                        
                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in
                            
                            
                            if priority == "p2" || priority == "p3" {
                                
                                let vc = SenderExmainationHomePageViewController(nibName: nil, bundle: nil)
                                
                                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                                vc.examSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                                vc.examSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                                vc.str = str
                                vc.strName = strName
                                vc.modalPresentationStyle = .fullScreen
                                self.present(vc, animated: true , completion: nil)
                                
                            }
                            
                            
                            else{
                                
                                let vc = SenderExmainationHomePageViewController(nibName: nil, bundle: nil)
                                
                                vc.view.backgroundColor = UIColor(named: "Principal" )
                                vc.examSegmentName.backgroundColor = UIColor(named: "UnSelector")
                                vc.examSegmentName.selectedSegmentTintColor = UIColor(named: "Selector")
                                vc.str = str
                                vc.strName = strName
                                vc.modalPresentationStyle = .fullScreen
                                self.present(vc, animated: true , completion: nil)
                                
                            }
                            
                        }))
                        
                        
                        
                        present(refreshAlert, animated: true, completion: nil)
                        
                        
                        
                        
                        
                        
                        
                        
                    }
                    
                    else{
                        
                        
                        let refreshAlert = UIAlertController(title: "", message: exams.message, preferredStyle: UIAlertController.Style.alert)
                        
                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                            
                            
                            
                            
                            
                        }))
                        
                        
                        
                        
                        present(refreshAlert, animated: true, completion: nil)
                        
                        
                        
                        
                        
                    }
                    
                    
                }
            }else{
                
                
                
                
                
                if DefaultsKeys.saveEdit.count == 0 {
                    
                    let refreshAlert = UIAlertController(title: "", message: "Enter Subject Details" , preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        
                        
                        
                    }))
                    
                    
                    
                    
                    present(refreshAlert, animated: true, completion: nil)
                    
                    
                    
                    
                }
                
                
                
                
                
                
                else{
                    
                    let createExam = ExameEditModal()
                    
                    
                    for z in 0..<examEditresp1.count{
                        
                        
                        
                        createExam.examid = examEditresp1[z].examid
                        createExam.userid = examEditresp1[z].staffid
                        createExam.colgid = examEditresp1[z].collegeid
                        createExam.sectionid = sectionIdForEdit
                        
                        createExam.processtype = "edit"
                        
                        var subjectDataEdit : [ExamDetailsDataDetails] = []
                        for ik in 0..<(examEditsModalApi1.count)
                        {
                            
                            
                            let subjectdetails  =  ExamDetailsDataDetails()
                            
                            if (DefaultsKeys.saveEdit[ik].examsyllabus.contains(sectionIdForEdit) ) && (DefaultsKeys.saveEdit[ik].examvenue.contains(sectionIdForEdit) ) && (DefaultsKeys.saveEdit[ik].examdate.contains(sectionIdForEdit) ) && (DefaultsKeys.saveEdit[ik].examsubjectid.contains(sectionIdForEdit) ) {
                                
                                let date = examEditsModalApi1[ik].examdate;
                                let resultdate = date!.split(separator: "/ ")
                                print("result",resultdate)
                                print(resultdate[0]) // Hello
                                print(resultdate[1])
                                
                                
                                subjectdetails.examdate = String(resultdate[1])
                                
                                //
                                let venu = examEditsModalApi1[ik].examvenue;
                                let resultvenu = venu!.split(separator: "/ ")
                                print("result",resultvenu)
                                print(resultvenu[0]) // Hello
                                print(resultvenu[1])
                                
                                subjectdetails.examvenue = String(resultvenu[1])
                                
                                
                                
                                subjectdetails.examsession = "An"
                                //
                                let sylubas = examEditsModalApi1[ik].examsyllabus;
                                let resultsylubs = sylubas!.split(separator: "/ ")
                                print("result",resultsylubs)
                                print(resultsylubs[0]) // Hello
                                print(resultsylubs[1])
                                
                                
                                subjectdetails.examsyllabus = String(resultsylubs[1])
                                
                                
                                let sayHello = examEditsModalApi1[ik].examsubjectid;
                                let result = sayHello!.split(separator: "/ ")
                                print("result",result)
                                print(result[0]) // Hello
                                print(result[1])
                                
                                
                                
                                
                                subjectdetails.clgsubjectid = String(result[1])
                                
                                
                                
                                subjectDataEdit.append(subjectdetails)
                                
                                
                                
                            }
                            
                            
                        }
                        
                        
                        
                        
                        
                        
                        
                        createExam.subjectdetails = subjectDataEdit
                        
                        
                        
                        
                        
                    }
                    
                    let createExamStr = createExam.toJSONString()
                    
                    
                    print("createExamStr",createExamStr)
                    ExameEditREquest.call_request(param: createExamStr!) {
                        //
                        [self]  (res) in
                        
                        
                        let exams : ExaminationAddResponce = Mapper<ExaminationAddResponce>().map(JSONString: res)!
                        
                        
                        if exams.status == 1 {
                            
                            
                            
                            
                            
                            let refreshAlert = UIAlertController(title: "", message: exams.message, preferredStyle: UIAlertController.Style.alert)
                            
                            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in
                                
                                
                                
                                if priority == "p2" || priority == "p3" {
                                    
                                    let vc = SenderExmainationHomePageViewController (nibName: nil, bundle: nil)
                                    
                                    vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                                    vc.examSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                                    vc.examSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                                    vc.str = str
                                    vc.strName = strName
                                    vc.modalPresentationStyle = .fullScreen
                                    self.present(vc, animated: true , completion: nil)
                                    
                                }
                                
                                
                                else{
                                    
                                    let vc = SenderExmainationHomePageViewController(nibName: nil, bundle: nil)
                                    
                                    vc.view.backgroundColor = UIColor(named: "Principal" )
                                    vc.examSegmentName.backgroundColor = UIColor(named: "UnSelector")
                                    vc.examSegmentName.selectedSegmentTintColor = UIColor(named: "Selector")
                                    vc.str = str
                                    vc.strName = strName
                                    vc.modalPresentationStyle = .fullScreen
                                    self.present(vc, animated: true , completion: nil)
                                    
                                }
                                
                                
                            }))
                            
                            
                            
                            
                            present(refreshAlert, animated: true, completion: nil)
                            
                            
                            
                            
                            
                            
                            
                            
                        }
                        
                        else{
                            
                            
                            
                            
                            let refreshAlert = UIAlertController(title: "", message: exams.message, preferredStyle: UIAlertController.Style.alert)
                            
                            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                                
                                
                                
                                
                                
                            }))
                            
                            
                            
                            
                            present(refreshAlert, animated: true, completion: nil)
                            
                            
                        }
                        
                        
                        
                        
                    }
                    
                    
                    
                    //
                }
                //
                //
            }
            
        }
        else{
            
            
            if   DefaultsKeys.saves.count == 0 {
                
                let refreshAlert = UIAlertController(title: "", message: "Enter Subject Details" , preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    
                    
                    
                }))
                
                
                
                
                present(refreshAlert, animated: true, completion: nil)
                
                
                
                
            }
            
            
            else{
                
                
                var sections : [Sectiondetails] = []
                
                
                print("clgsection.count",clgsection.count)
                
                
                
                
                let createExam = Main()
                
                
                for z in 0..<examCre.count{
                    
                    
                    createExam.examname = examCre[z].examname
                    createExam.staffid = userId
                    createExam.collegeid = colgId
                    createExam.examid = "0"
                    createExam.enddate =  examCre[z].enddate
                    createExam.startdate =  examCre[z].startdate
                    createExam.processtype = "add"
                    
                    for i in 0..<clgsection.count{
                        
                        print("clgsection.count-1",clgsection.count)
                        print("iewrrr",i)
                        let sectionDetails  =  Sectiondetails()
                        
                        
                        
                        sectionDetails.clgsectionid = clgsection[i].clgsectionid
                        
                        sectionDetails.clgdepartmentid = clgDepartId
                        
                        
                        sections.append(sectionDetails)
                        
                        var sujectData : [Subjectdetails] = []
                        for ik in 0..<(  DefaultsKeys.saves.count)
                        {
                            
                            print("poopoppop",  DefaultsKeys.saves.count-1)
                            
                            //
                            
                            let subjectdetails  =  Subjectdetails()
                            
                            if (  DefaultsKeys.saves[ik].examsyllabus.contains(clgsection[i].clgsectionid) ) && (  DefaultsKeys.saves[ik].examvenue.contains(clgsection[i].clgsectionid) ) && (  DefaultsKeys.saves[ik].examdate.contains(clgsection[i].clgsectionid) ) && (  DefaultsKeys.saves[ik].examsubjectid.contains(clgsection[i].clgsectionid) ) {
                                
                                
                                
                                print("iops",  DefaultsKeys.saves.count)
                                
                                
                                
                                
                                
                                let date =   DefaultsKeys.saves[ik].examdate;
                                let resultdate = date!.split(separator: "/ ")
                                print("result",resultdate)
                                print(resultdate[0]) // Hello
                                print(resultdate[1])
                                
                                
                                subjectdetails.examdate =  String(resultdate[1])
                                
                                
                                let venu =   DefaultsKeys.saves[ik].examvenue;
                                let resultvenu = venu!.split(separator: "/ ")
                                print("result",resultvenu)
                                print(resultvenu[0]) // Hello
                                print(resultvenu[1])
                                
                                
                                subjectdetails.examvenue = String(resultvenu[1])
                                
                                
                                
                                subjectdetails.examsession = "An"
                                
                                let sylubas =   DefaultsKeys.saves[ik].examsyllabus;
                                let resultsylubs = sylubas!.split(separator: "/ ")
                                print("result",resultsylubs)
                                print(resultsylubs[0]) // Hello
                                print(resultsylubs[1])
                                
                                
                                subjectdetails.examsyllabus = String(resultsylubs[1])
                                
                                
                                let sayHello = DefaultsKeys.saves[ik].examsubjectid;
                                let result = sayHello!.split(separator: "/ ")
                                print("result",result)
                                print(result[0]) // Hello
                                print(result[1])
                                
                                
                                subjectdetails.examsubjectid = String(result[1])
                                
                                sujectData.append(subjectdetails)
                                
                            }
                            
                        }
                        
                        
                        sectionDetails.subjectdetails = sujectData
                        
                        
                        
                    }
                    
                    createExam.sectiondetails = sections
                    
                    
                }
                
                let createExamStr = createExam.toJSONString()
                
                
                print("createExamStr",createExamStr)
                examAddSubRequest.call_request(param: createExamStr!) {
                    //
                    [self]  (res) in
                    
                    
                    let exams : ExaminationAddResponce = Mapper<ExaminationAddResponce>().map(JSONString: res)!
                    
                    
                    examSubRef = exams.data
                    
                    if exams.status == 1 {
                        
                        
                        let refreshAlert = UIAlertController(title: "", message: exams.message, preferredStyle: UIAlertController.Style.alert)
                        
                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in
                            
                            
                            if priority == "p2" || priority == "p3" {
                                
                                let vc = SenderExmainationHomePageViewController(nibName: nil, bundle: nil)
                                
                                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                                vc.examSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                                vc.examSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                                vc.str = str
                                vc.strName = strName
                                vc.modalPresentationStyle = .fullScreen
                                self.present(vc, animated: true , completion: nil)
                                
                            }
                            
                            
                            else{
                                
                                let vc = SenderExmainationHomePageViewController(nibName: nil, bundle: nil)
                                
                                vc.view.backgroundColor = UIColor(named: "Principal" )
                                vc.examSegmentName.backgroundColor = UIColor(named: "UnSelector")
                                vc.examSegmentName.selectedSegmentTintColor = UIColor(named: "Selector")
                                vc.str = str
                                vc.strName = strName
                                vc.modalPresentationStyle = .fullScreen
                                self.present(vc, animated: true , completion: nil)
                                
                            }
                            
                        }))
                        
                        
                        
                        
                        present(refreshAlert, animated: true, completion: nil)
                        
                        
                        
                        
                        
                        
                        
                        
                        
                    }
                    
                    else{
                        
                        
                        
                        let refreshAlert = UIAlertController(title: "", message: exams.message, preferredStyle: UIAlertController.Style.alert)
                        
                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                            
                            
                            
                            
                            
                        }))
                        
                        
                        
                        
                        present(refreshAlert, animated: true, completion: nil)
                        
                        
                        
                        
                    }
                    
                }
                
                
            }
        }
    }
    
    
    
    
    
    
    
    @IBAction func backBtn(_ sender: Any) {
        
        examEditsModalApi.removeAll()
        
        dismiss(animated: true)
        
        
        
    }
    
    // Tab Bar Nagivation
    
    
    // tap bar View
    
    
    
    
    @IBAction func helpRedirect() {
        
        let vc = HelpViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true, completion: nil)
        
        
    }
    
    
    @IBAction func termsAndCondition() {
        
        let vc = MenuTermsViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true, completion: nil)
        
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
        
        present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func privacyPolicyRedirect() {
        
        let vc = PrivacyPolicyViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true, completion: nil)
        
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
        
        present(vc, animated: false, completion: nil)
        
        
        
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
        
        present(vc, animated: true, completion: nil)
        
        
    }
    
    
    
    
    
    
    
    
    @IBAction func priorityVc() {
        
        
        
        
        
        
        let login = LoginModal ()
        login.mobilenumber = MobileNumber
        login.Password = password
        print("passsdded", login.Password)
        
        
        let loginStr = login.toJSONString()
        
        loginRequest.call_request(param: loginStr!){ [self]
            
            (res) in
            
            
            let loginResponse : LoginResponse =
            Mapper<LoginResponse>().map(JSONString: res)!
            
            loginDatas = loginResponse.data
            print("ctrss",loginDatas.count)
            if (loginResponse.data.count >= 1){
                
                
                
                let vc = PriorityViewController(nibName: nil, bundle: nil)
                for i in loginResponse.data{
                    
                    
                    if i.priority == "p3"{
                        vc.IdentfierLabel = "STAFF"
                        vc.loginPrincipal.append(i)
                        
                    }
                    
                    else if i.priority == "p4"{
                        vc.loginStudent.append(i)
                        
                    }
                    
                    
                    else if i.priority == "p2"{
                        
                        vc.IdentfierLabel = "HOD"
                        vc.loginPrincipal.append(i)
                        
                    }
                    
                    else if i.priority == "p1"{
                        
                        vc.IdentfierLabel = "PRINCIPAL"
                        vc.loginPrincipal.append(i)
                    }
                    
                    else if i.priority == "p5"{
                        vc.IdentfierLabel = "PARENT"
                        vc.loginPrincipal.append(i)
                        
                        
                    }
                    
                    
                    else if i.priority == "p6"{
                        
                        vc.IdentfierLabel = "NON TEACHING"
                        vc.loginPrincipal.append(i)
                    }
                    
                }
                vc.modalPresentationStyle = .fullScreen
                
                present(vc, animated: true,completion: nil)
                
                
                
            }
        }
        
        
        
        
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        var index = IndexPath(row: indexPathss, section: indexPathsections)
        
        
        //
        let cell: GetSectionYearTableViewCell = self.Tv.cellForRow(at: index) as! GetSectionYearTableViewCell
        
        cell.venuLabel.resignFirstResponder()
        return true
    }
    
    
    
    
    
    
    
    
    //
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        var index = IndexPath(row: indexPathss, section: indexPathsections)
        
        
        //
        let cell: GetSectionYearTableViewCell = self.Tv.cellForRow(at: index) as! GetSectionYearTableViewCell
        
        if text == "\n" {
            cell.sylubasTextView.resignFirstResponder()
            return false
        }
        return true
    }
    
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        print("false")
        
        var index = IndexPath(row: indexPathss, section: indexPathsections)
        
        
        //
        let cell: GetSectionYearTableViewCell = self.Tv.cellForRow(at: index) as! GetSectionYearTableViewCell
        if cell.sylubasTextView.text == "" {
            cell.sylubasTextView.text = "Syllabus"
            cell.sylubasTextView.textColor = UIColor.black
            cell.sylubasTextView.font = UIFont(name: "verdana", size: 13.0)
            
        }
    }
    
    
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        print("true")
        
        var index = IndexPath(row: indexPathss, section: indexPathsections)
        
        
        //
        let cell: GetSectionYearTableViewCell = self.Tv.cellForRow(at: index) as! GetSectionYearTableViewCell
        
        
        if cell.sylubasTextView.text == "Syllabus" {
            cell.sylubasTextView.text = ""
            cell.sylubasTextView.textColor = UIColor.black
            cell.sylubasTextView.font = UIFont(name: "verdana", size: 14.0)
        }
    }
    
    
    
}
class SelectSubject : UITapGestureRecognizer{
    
    
    var  checkBoxx : CheckBoxThree!
    
    var  subjectId : String!
    
    var sectionID : String!
    
    var index : IndexPath!
    
    
}

class SaveSubject : UITapGestureRecognizer{
    
    
    var  checkBoxx : CheckBoxThree!
    
    var  subjectId : String!
    var  sessionId : String!
    
    var venus : String!
    var synal : String!
    var date : String!
    
    var height  : Int!
    
    var sectionId : String!
    
}




class Save : UITapGestureRecognizer{
    
    
    var  subjectId : String!
    
    var venu : String!
    var synal : String!
    var date : String!
    
    
}


class getSaveViewModal : Mappable  {
    
    
    
    
    
    
    
    var venue : String!
    
    var syllabus : String!
    
    var date : String!
    
    var sectionId : [String] = []
    
    var subjeID : String!
    
    
    
    
    
    init(){}
    
    
    
    
    
    required init?(map: ObjectMapper.Map) {
        
        mapping(map: map)
        
    }
    
    
    
    
    
    
    func mapping(map: ObjectMapper.Map) {
        
        
        
    }
    
    
    
}


class HeaderTapGesture : UITapGestureRecognizer{
    
    
    var tagss : Int!
    
    
}


class NoonCell : UITapGestureRecognizer{
    
    
    var noonClick : UIView!
    var noonLabel : UILabel!
    
}

