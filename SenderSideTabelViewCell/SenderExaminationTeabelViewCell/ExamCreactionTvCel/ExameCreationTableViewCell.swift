//
//  ExameCreationTableViewCell.swift
//  Vs_GradItCollege
//
//  Created by admin on 11/10/23.
//

import UIKit
import DropDown
import ObjectMapper

@available(iOS 16.0, *)
class ExameCreationTableViewCell: UITableViewCell,UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate, UITextViewDelegate {
    
    
    
    @IBOutlet weak var secionOverAllView: UIViewX!
    
    @IBOutlet weak var arrowImgeView: UIImageView!
    @IBOutlet weak var SubjectTabelView: UITableView!
    
    @IBOutlet weak var sectionCheckBox: CheckBoxThree!
    
    @IBOutlet weak var sectionLbl: UILabel!
    
    
    var getSectionsss : [getSubjectWiseDataDetails] = []
    
    var identifiers = "GetSectionYearTableViewCell"
    
    var selectedCell : IndexPath?
    
    var GetSectionNmeRef : [getSectionDatasDetails] = []
    
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
    
    
    var reloadSections: ((_ section: Int) -> Void)?
    
    var examAddRef : [Sectiondetails] = []
    var examSubRef : [Datass] = []
    var sectionRefss : [Subjectdetails] = []
    
    var ExameSection : [examviewDataDetails] = [] // this for edit list variabel
    
    var dteStringGet : String!
    var aryObject : [String] = []
    var userId : String!
    var appId : String!
    var display_date : String!
    var secidonIDTabl : String!
    var url_date : String!
    var semsterID : String!
    
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
    var str : [Int] = []
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
    var SectionIdRefrence  = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        let rowNib = UINib(nibName: identifiers, bundle: nil)
        SubjectTabelView.register(rowNib, forCellReuseIdentifier: identifiers)
        SubjectTabelView.dataSource = self
        SubjectTabelView.delegate = self
        
        DefaultsKeys.saves.removeAll()
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return GetSectionNmeRef.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifiers, for: indexPath) as!
        
        GetSectionYearTableViewCell
        
        
        let sujectName : getSectionDatasDetails = GetSectionNmeRef[indexPath.row]
        
        
        cell.datePickerSet.isHidden = true
        cell.datePickerView.isHidden = true
        
        
        let dateFormater: DateFormatter = DateFormatter()
        dateFormater.dateFormat = "dd/M/yyyy"
        let currentDate = StartDateEdit
        let date = dateFormater.date(from:currentDate!)
        var dt : Date!
        dt = date
        let currentDate1 = EndDateEdit
             let date1 = dateFormater.date(from:currentDate1!)
        var dt1 : Date!
        dt1 = date1
        
        
        cell.datePickerSet.minimumDate = dt
        cell.datePickerSet.maximumDate = dt1
        sectionsForCompar = SectionIdRefrence
        
        
        if EditId == "1"{
            
            
            if let selectedCell = selectedCell, selectedCell == indexPath {
                
                cell.checkSubjectImageView.image = UIImage(named: "verified")
            }
            
            else{
                
                cell.checkSubjectImageView.image = UIImage(named: "checkbox")
                //
                
            }
            cell.SubjectLabel.text = sujectName.subjectname
            
            
            
            for ik in examEditresp{
                
                
                
                
                for i in  0..<ik.subjectdetails.count{
                    
                    
                    
                    ids =  ik.subjectdetails[i].examsubjectid
                    
                    if  ids ==   sujectName.subjectid
                    {
                        
                        
                        
                        cell.venuLabel.text =   ik.subjectdetails[i].examsyllabus
                        //
                        cell.sylubasTextView.text = ik.subjectdetails[i].examvenue
                        cell.calanderDateLabel.text = ik.subjectdetails[i].examdate
                        cell.sectionDropDownLabel.text = ik.subjectdetails[i].examsession
                        
                        
                        
                        cell.checkSubjectImageView.image = UIImage(named: "verified")
                        //
                        
                        let vc = NoonCell(target: self, action: #selector(NoonVc))
                        vc.noonClick = cell.sectionDropDownView
                        vc.noonLabel = cell.sectionDropDownLabel
                        cell.sectionDropDownView.addGestureRecognizer(vc)
                        
                        cell.datePickerSet.addTarget(self, action: #selector(dte(_:)), for: .valueChanged)
                        
                        var clickDate = DatePickerEnable(target: self, action: #selector(clickD))
                        clickDate.dateP = cell.datePickerSet
                        clickDate.datePView =  cell.datePickerView
                        clickDate.tag = cell.tag
                        cell.clanderView.addGestureRecognizer(clickDate)
                        
                        //
                        
                        
                        let save = SaveSubjectsssss(target: self, action: #selector(saveVcc))
                        
                        
                        save.subjectId = sujectName.subjectid
                        
                        
                        save.venus = cell.venuLabel.text
                        save.synal = cell.sylubasTextView.text
                        save.date = cell.calanderDateLabel.text
                        
                        cell.SaveView.addGestureRecognizer(save)
                        
                        
                        
                    }
                    
                    
                    
                    
                    
                    else {
                        
                        cell.sylubasTextView.textColor = UIColor.black
                        cell.sylubasTextView.font = UIFont(name: "verdana", size: 11.0)
                        
                        
                        let vc = NoonCell(target: self, action: #selector(NoonVc))
                        vc.noonClick = cell.sectionDropDownView
                        vc.noonLabel = cell.sectionDropDownLabel
                        cell.sectionDropDownView.addGestureRecognizer(vc)
                        
                        cell.venuLabel.returnKeyType = .done
                        cell.venuLabel.delegate = self
                        cell.sylubasTextView.returnKeyType = .done
                        cell.sylubasTextView.delegate = self
                        
                        cell.SubjectLabel.text =  sujectName.subjectname
                        
                        
                        examHeaderId =  sujectName.subjectid
                        
                        cell.datePickerSet.addTarget(self, action: #selector(dte(_:)), for: .valueChanged)
                        var clickDate  = DatePickerEnable(target: self, action: #selector(clickD))
                        clickDate.dateP = cell.datePickerSet
                        clickDate.datePView =  cell.datePickerView
                        //
                        clickDate.tag = cell.tag
                        cell.clanderView.addGestureRecognizer(clickDate)
                        
                        let save = SaveSubjectsssss(target: self, action: #selector(saveVcc))
                        
                        
                        save.subjectId = sujectName.subjectid
                        
                        
                        save.venus = cell.venuLabel.text
                        save.synal = cell.sylubasTextView.text
                        save.date = cell.calanderDateLabel.text
                        
                        cell.SaveView.addGestureRecognizer(save)
                        
                        
                        if DefaultsKeys.saveEdit.count > 0{
                            
                            
                            for i in DefaultsKeys.saveEdit.indices{
                                
                                var ids = DefaultsKeys.saveEdit[i].examsubjectid
                                
                                
                                if ids == SectionIdRefrence + "/ " + (sujectName.subjectid ?? ""){
                                    
                                    cell.checkSubjectImageView.image = UIImage(named: "verified")
                                    
                                    var venue = DefaultsKeys.saveEdit[i].examvenue
                                    let resultvenue = venue!.split(separator: "/ ")
                                    
                                    var examsyllabus = DefaultsKeys.saveEdit[i].examsyllabus
                                    let resultexamsyllabus = examsyllabus!.split(separator: "/ ")
                                    
                                    var startDate = DefaultsKeys.saveEdit[i].examdate
                                    let resultstartDate = startDate!.split(separator: "/ ")
                                    var examesesion = DefaultsKeys.saveEdit[i].examsession
                                    let resultexamesesion = examesesion!.split(separator: "/ ")
                                    
                                    
                                    
                                    
                                    cell.sylubasTextView.text = String(resultexamsyllabus[1])
                                    cell.venuLabel.text = String(resultvenue[1])
                                    cell.calanderDateLabel.text = String(resultstartDate[1])
                                    cell.sectionDropDownLabel.text = String(resultexamesesion[1])
                                    
                                    
                                }
                                
                                
                                
                            }
                            
                            
                            
                            
                        }
                    }
                }
                
            }
            
        }
        
        
        
        
        
        //
        else {
            
            
            
            if let selectedCell = selectedCell, selectedCell == indexPath {
                
                cell.checkSubjectImageView.image = UIImage(named: "verified")
            }
            
            else{
                
                
            }
            
            
            
            
            ////
            cell.SubjectLabel.text = sujectName.subjectname
            
            cell.sectionDropDownLabel.text = "Session"
            
            cell.sylubasTextView.textColor = UIColor.black
            cell.sylubasTextView.font = UIFont(name: "verdana", size: 11.0)
            
            let vc = NoonCell(target: self, action: #selector(NoonVc))
            vc.noonClick = cell.sectionDropDownView
            vc.noonLabel = cell.sectionDropDownLabel
            cell.sectionDropDownView.addGestureRecognizer(vc)
            
            cell.venuLabel.returnKeyType = .done
            cell.venuLabel.delegate = self
            cell.sylubasTextView.returnKeyType = .done
            cell.sylubasTextView.delegate = self
            
            
            cell.datePickerSet.addTarget(self, action: #selector(dte(_:)), for: .valueChanged)
            var clickDate = DatePickerEnable(target: self, action: #selector(clickD))
            clickDate.dateP = cell.datePickerSet
            clickDate.datePView =  cell.datePickerView
            clickDate.tag = cell.tag
            cell.clanderView.addGestureRecognizer(clickDate)
            
            
            let save = SaveSubjectsssss(target: self, action: #selector(saveVcc))
            
            
            save.subjectId = sujectName.subjectid
            
            
            save.venus = cell.venuLabel.text
            save.synal = cell.sylubasTextView.text
            save.date = cell.calanderDateLabel.text
            
            cell.SaveView.addGestureRecognizer(save)
            
            
            
            
            
            if DefaultsKeys.saves.count > 0{
                
                
                for i in DefaultsKeys.saves.indices{
                    
                    var ids = DefaultsKeys.saves[i].examsubjectid
                    
                    
                    if ids == SectionIdRefrence + "/ " + (sujectName.subjectid ?? ""){
                        
                        cell.checkSubjectImageView.image = UIImage(named: "verified")
                        
                        var venue = DefaultsKeys.saves[i].examvenue
                        let resultvenue = venue!.split(separator: "/ ")
                        
                        var examsyllabus = DefaultsKeys.saves[i].examsyllabus
                        let resultexamsyllabus = examsyllabus!.split(separator: "/ ")
                        
                        var startDate = DefaultsKeys.saves[i].examdate
                        let resultstartDate = startDate!.split(separator: "/ ")
                        var examesesion = DefaultsKeys.saves[i].examsession
                        let resultexamesesion = examesesion!.split(separator: "/ ")
                        
                        
                        
                        
                        cell.sylubasTextView.text = String(resultexamsyllabus[1])
                        cell.venuLabel.text = String(resultvenue[1])
                        cell.calanderDateLabel.text = String(resultstartDate[1])
                        cell.sectionDropDownLabel.text = String(resultexamesesion[1])
                        
                        
                    }
                    
                    
                    
                }
                
                
                
                
            }
            
            
        }
        
        
        
        
        
        return cell
        
    }
    
    
    
    
    @IBAction func dte(_ sender: UIDatePicker) {
        print("print \(sender.date)")
        
        
        var index = IndexPath(row: indexPathss, section: indexPathsections)
        //
        let cell = SubjectTabelView.cellForRow(at: index) as! GetSectionYearTableViewCell
        //
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YYYY"
        let somedateString = dateFormatter.string(from: sender.date)
        dteStringGet = "1"
        cell.calanderDateLabel.text = somedateString
        
        print("somedateString",somedateString)
        
        
        cell.datePickerView.isHidden = true
        
        
        
    }
    
    @IBAction func clickD(ges : DatePickerEnable) {
        
        
        ges.dateP.isHidden = false
        ges.datePView.isHidden = false
        
        
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
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifiers, for: indexPath) as!
        
        GetSectionYearTableViewCell
        
        
        let sujectName : getSectionDatasDetails = GetSectionNmeRef[indexPath.row]
        
        
        
        
        
        
        
        
        
        if EditId == "1"{
            
            
            
            indexPathsections = indexPath.section
            
            
            
            //                  }
            
            
            if let selectedCells = selectedCell, selectedCells == indexPath {
                
                selectedCell = nil
                
                
            } else {
                
                
                
                selectedCell = indexPath
                
                
                cell.checkSubjectImageView.image = UIImage(named: "verified")
                
                
                
                
                
                
                
                
                
                
                indexPathss = indexPath.row
                
            }
            
            
            
            
        }
        
        
        
        
        
        
        
        
        
        
        
        
        else{
      
            if let selectedCells = selectedCell, selectedCells == indexPath {
                
                selectedCell = nil
                
                
            }
            
            else{
                
                selectedCell = indexPath
                indexPathsections = indexPath.section
                indexPathss = indexPath.row
                
                cell.checkSubjectImageView.image = UIImage(named: "verified")
                
                
                
                
                
                
                
                
                
            }
            
        }
        
        
        
        
        
        
        
        SubjectTabelView .reloadRows(at: [indexPath], with: .automatic)
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if let selectedCell = selectedCell, selectedCell == indexPath {
            
            
            return 365
        } else {
            
            return UITableView.automaticDimension
            
        }
        
    }
    
    
    
    
    
    @IBAction func saveVcc( ges : SaveSubjectsssss){
        
        
        print("12345678")
        
        DefaultsKeys.saveButtonId = "1"
        
        var index = IndexPath(row: indexPathss, section: indexPathsections)
        let currentController = self.getCurrentViewController()
        
        
        //
        
        
        if EditId == "1"{
            let cell: GetSectionYearTableViewCell = self.SubjectTabelView.cellForRow(at: index) as! GetSectionYearTableViewCell
            
            
            if cell.sylubasTextView.text == "Syllabus"{
                
                
                
                let refreshAlert = UIAlertController(title: "", message: "Please Enter Syllabus", preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    
                    
                    
                    
                    
                    
                }))
                
                
                
                
                currentController?.present(refreshAlert, animated: true, completion: nil)
                
                
                
            }
            
            else if cell.venuLabel.text == ""{
                
                
                
                
                
                let refreshAlert = UIAlertController(title: "", message: "Please Enter Venue", preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    
                    
                    
                    
                    
                    
                }))
                
                
                
                
                currentController?.present(refreshAlert, animated: true, completion: nil)
                
                
            }
            
            
            else if cell.calanderDateLabel.text ==  "DD/MM/YY" {
                
                
                
                
                
                let refreshAlert = UIAlertController(title: "", message: "Please Select Date", preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    
                    
                    
                    
                    
                    
                }))
                
                
                
                
                currentController?.present(refreshAlert, animated: true, completion: nil)
                
                
            }
            else if  cell.sectionDropDownLabel.text == "Session"{
                
                
                
                let refreshAlert = UIAlertController(title: "", message: "Please Select Session", preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    
                    
                    
                    
                    
                    
                }))
                
                
                
                
                currentController?.present(refreshAlert, animated: true, completion: nil)
                
            }
            
            else if ges.subjectId == ""{
                
                
                
                
                
                let refreshAlert = UIAlertController(title: "", message: "Please Select Subject", preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    
                    
                    
                    
                    
                    
                }))
                
                
                
                
                currentController?.present(refreshAlert, animated: true, completion: nil)
                
            }
            
            
            
            else{
                let sujectData = EditSubjectDetailsRef()
                
                
                
                sujectData.examsyllabus = sectionIdForEdit + "/ " + cell.sylubasTextView.text!
                
                sujectData.examvenue = sectionIdForEdit + "/ " + cell.venuLabel.text!
                sujectData.examdate = sectionIdForEdit + "/ " + cell.calanderDateLabel.text!
                sujectData.examsession =  sectionIdForEdit + "/ " + cell.sylubasTextView.text!
                sujectData.examsubjectid = sectionIdForEdit + "/ " + ges.subjectId
                sujectData.examsession = sectionIdForEdit + "/ " + cell.sectionDropDownLabel.text!
                
                
                
                
                
                DefaultsKeys.saveEdit.append(sujectData)
                
                cell.checkSubjectImageView.image = UIImage(named: "verified")
                
                let refreshAlert = UIAlertController(title: "", message: "Given Data SuccessFully Edit ", preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    
                    
                    
                    
                    
                    
                }))
                
                
                
                
                currentController?.present(refreshAlert, animated: true, completion: nil)
                
                
                
            }
        }
        
        
        else{
            //
            
            let cell: GetSectionYearTableViewCell = self.SubjectTabelView.cellForRow(at: index) as! GetSectionYearTableViewCell
            
            
            if cell.sylubasTextView.text == "Syllabus"{
                
                
                
                
                let refreshAlert = UIAlertController(title: "", message: "Please Enter Syllabus ", preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    
                    
                    
                    
                    
                    
                }))
                
                
                
                
                currentController?.present(refreshAlert, animated: true, completion: nil)
                
                
                
            }
            
            else if cell.venuLabel.text == ""{
                
                
                
                
                
                
                let refreshAlert = UIAlertController(title: "", message: "Please Enter Venue ", preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    
                    
                    
                    
                    
                    
                }))
                
                
                
                
                currentController?.present(refreshAlert, animated: true, completion: nil)
                
            }
            
            
            else if cell.calanderDateLabel.text ==  "DD/MM/YY" {
                
                
                
                
                
                let refreshAlert = UIAlertController(title: "", message: "Please Select Date", preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    
                    
                    
                    
                    
                    
                }))
                
                
                
                
                currentController?.present(refreshAlert, animated: true, completion: nil)
                
            }
            else if  cell.sectionDropDownLabel.text == "Session"{
                
                
                
                let refreshAlert = UIAlertController(title: "", message: "Please Select Session", preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    
                    
                    
                    
                    
                    
                }))
                
                currentController?.present(refreshAlert, animated: true, completion: nil)
                
            }
            
            else if ges.subjectId == ""{
                
                
                
                
                
                
                let refreshAlert = UIAlertController(title: "", message: "Please Select Subject", preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    
                    
                    
                    
                    
                    
                }))
                
                
                
                
                currentController?.present(refreshAlert, animated: true, completion: nil)
                
            }
            
            else{
                
                let vc = SectiondetailRef()
                
                vc.clgsectionid = SectionIdRefrence
                
                DefaultsKeys.clgsection.append(vc)
                
                
                
                
                
                
                
                
                
                let sujectData = SubjectDetailsRef()
                
                
                
                
                
                
                for i in  DefaultsKeys.clgsection{
                    
                    
                    sujectData.examsyllabus = i.clgsectionid + "/ " + cell.sylubasTextView.text
                    
                    sujectData.examvenue = i.clgsectionid + "/ " + cell.venuLabel.text!
                    sujectData.examdate = i.clgsectionid + "/ " +  cell.calanderDateLabel.text!
                    sujectData.examsession =  i.clgsectionid + "/ " + cell.sylubasTextView.text
                    sujectData.examsubjectid = i.clgsectionid + "/ " + ges.subjectId
                    sujectData.examsession = i.clgsectionid + "/ " + cell.sectionDropDownLabel.text!
                    
                    
                }
                
                
                
                DefaultsKeys.saves.append(sujectData)
                
                
                cell.checkSubjectImageView.image = UIImage(named: "verified")
                
                
                
                
                
                let refreshAlert = UIAlertController(title: "", message: "Given Data SuccessFully Saved", preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    
                    
                    
                    
                    
                    
                }))
                
                
                
                
                currentController?.present(refreshAlert, animated: true, completion: nil)
                
                
                
                print(" i.sujectData", sujectData)
                
                
                print("sujectDatasujectData",sujectData.examvenue,sujectData.examsubjectid,sujectData.examsyllabus)
                
            }
            
            
            
            
        }
        
    }
    
    
    
    
    
    
}



class SaveSubjectsssss : UITapGestureRecognizer{
    
    var  checkBoxx : CheckBoxThree!
    
    var  subjectId : String!
    var  sessionId : String!
    
    var venus : String!
    var synal : String!
    var date : String!
    
    var height  : Int!
    
    var sectionId : String!
    
}






class DatePickerEnable : UITapGestureRecognizer{
    var dateP : UIDatePicker!
    var datePView : UIView!
    var date : Date!
    var tag : Int!
}
