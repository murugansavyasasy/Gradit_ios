//
//  AssigmentHomePageViewController.swift
//  GraditAssigment
//
//  Created by MACBOOKPRO on 14/11/22.
//

import UIKit
import WebKit
import ObjectMapper
import KRProgressHUD

@available(iOS 16.0, *)
class AssigmentHomePageViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    
    @IBOutlet weak var customTabBar: CustomTabBar!
    @IBOutlet weak var searchFullView: UIViewX!
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var changeRolesView: UIView!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var assigmentTableView: UITableView!
    @IBOutlet weak var smallImg: UIImageView!
    @IBOutlet weak var bigImg: UIImageView!
    @IBOutlet weak var adView: UIView!
    @IBOutlet weak var assigmentSegmentName: UISegmentedControl!
    @IBOutlet weak var assigmentCountViews: UIViewX!
    @IBOutlet weak var sideMenuView: UIView!
    @IBOutlet weak var termsAndConditionView: UIView!
    @IBOutlet weak var faqView: UIView!
    @IBOutlet weak var privacyPolicyView: UIView!
    @IBOutlet weak var changePasswordView: UIView!
    @IBOutlet weak var helpView: UIView!
    @IBOutlet weak var upcommingcountView: UIViewX!
    @IBOutlet weak var noDataView: UIView!
    @IBOutlet weak var noDataTextLabel: UILabel!
    @IBOutlet weak var assigmentPastCountView: UIViewX!
    @IBOutlet weak var assigmentUpcommingCount: UILabel!
    @IBOutlet weak var assigmentTopCount: UILabel!
    @IBOutlet weak var assigmentPastCount: UILabel!
    
    var Indentifiers = "AssigmentTvTableViewCell"
    var UpcommingRef : [upcommingdataDetails] = []
    var PasrRef      : [upcommingdataDetails]    = []
    var overAllRef    : [overAllDataDetails] = []
    var addapiRef : [AddDataDeatils] = []
    var selectedCell : IndexPath?
    var memberId : String!
    var priority : String!
    var colgId   : String!
    var sectionid : String!
    var deptid    : String!
    var password : String!
    var mobileNumber : String!
    var str : [String] = []
    var strName : [String] = []
    var PreviousAddId : Int = 0
    var cloneList : [upcommingdataDetails]    = []
    var is_read_enabled = ""
    var is_write_enabled = ""
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        PreviousAddId = PreviousAddId+1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        customTabBar.delegate = self
        
        sideMenuView.isHidden = true
        searchbar.delegate = self
        searchbar.isHidden  = true
        searchFullView .isHidden = true
        PreviousAddId = PreviousAddId+1
        let defaults = UserDefaults.standard
        
        memberId = defaults.string(forKey: DefaultsKeys.memberid)
        priority = defaults.string(forKey: DefaultsKeys.priority)
        colgId = defaults.string(forKey: DefaultsKeys.collegeid)
        deptid = defaults.string(forKey: DefaultsKeys.deptid)
        sectionid = defaults.string(forKey: DefaultsKeys.sectionid)
        mobileNumber = defaults.string(forKey: DefaultsKeys.mobileNumber)
        password = defaults.string(forKey: DefaultsKeys.Password)
        
        if sectionid == ""{
            
            sectionid = "0"
        }
       
        addApi()
        overAllRefName()
        
        UpcommingRefName()
        
        view.backgroundColor = .priorityColor
       
        let rowNib = UINib(nibName: Indentifiers, bundle: nil)
        assigmentTableView.register(rowNib, forCellReuseIdentifier: Indentifiers)
        
        // tap Bar UiTapGuster.
        
        let faqGesture = UITapGestureRecognizer(target: self, action: #selector(faqRedirect))
        faqView.addGestureRecognizer(faqGesture)
        
        let logoutGesture = UITapGestureRecognizer(target: self, action: #selector(logoutPressed))
        loginView.addGestureRecognizer(logoutGesture)
        
        let helpGesture = UITapGestureRecognizer(target: self, action: #selector(helpRedirect))
        helpView.addGestureRecognizer(helpGesture)
        
        let privacyPolicyGesture = UITapGestureRecognizer(target: self, action: #selector(privacyPolicyRedirect))
        privacyPolicyView.addGestureRecognizer(privacyPolicyGesture)
        
        let termsAndConditionGesture = UITapGestureRecognizer(target: self, action: #selector(termsAndCondition))
        termsAndConditionView.addGestureRecognizer(termsAndConditionGesture)
        
        let profileGesture = UITapGestureRecognizer(target: self, action: #selector(profileRedirect))
        profileView.addGestureRecognizer(profileGesture)
        
        let chagePassword = UITapGestureRecognizer(target: self, action: #selector(changePassowrdVC))
        changePasswordView.addGestureRecognizer(chagePassword)
        
        let changeRol = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        changeRolesView.addGestureRecognizer(changeRol)
        
        noDataView.isHidden = true
        noDataTextLabel.isHidden = true
        
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        if assigmentSegmentName.selectedSegmentIndex == 0{
            
            let filtered_list : [upcommingdataDetails] = cloneList
            
            
            if !searchText.isEmpty{
                
                
                let search = searchText.lowercased()

                UpcommingRef = filtered_list.filter {

                    ($0.topic?.lowercased().contains(search) ?? false) ||
                    ($0.description?.lowercased().contains(search) ?? false) ||
                    ($0.assignmenttype?.lowercased().contains(search) ?? false) ||
                    ($0.subjectname?.lowercased().contains(search) ?? false) ||
                    ($0.sentbyname?.lowercased().contains(search) ?? false) ||
                    ($0.createdby?.lowercased().contains(search) ?? false)

                }
                
            }else{
                
                UpcommingRef = filtered_list
                
                print("pendingOrder")
            }
            
            
            if UpcommingRef.count > 0{
                
                print ("searchListPendigCount",UpcommingRef.count)
                
                noDataView.isHidden = true
                noDataTextLabel.isHidden = true
                
                
            }else{
                
                noDataView.isHidden = false
                noDataTextLabel.isHidden = false
                noDataTextLabel.text = "No Records Found"
                
            }
            
        }
        
        
        else if assigmentSegmentName.selectedSegmentIndex == 1{
            
            let filtered_list : [upcommingdataDetails] = cloneList
            
            if !searchText.isEmpty{
                
                
                PasrRef = filtered_list.filter {

                    ($0.topic?.lowercased().contains(searchText.lowercased()) ?? false) ||
                    ($0.description?.lowercased().contains(searchText.lowercased()) ?? false) ||
                    ($0.assignmenttype?.lowercased().contains(searchText.lowercased()) ?? false) ||
                    ($0.subjectname?.lowercased().contains(searchText.lowercased()) ?? false) ||
                    ($0.sentbyname?.lowercased().contains(searchText.lowercased()) ?? false) ||
                    ($0.createdby?.lowercased().contains(searchText.lowercased()) ?? false)

                }
                
            }else{
                
                PasrRef = filtered_list
                
                print("pendingOrder")
            }
            
            if PasrRef.count > 0{
                
                print ("searchListPendigCount",PasrRef.count)
                
                noDataView.isHidden = true
                noDataTextLabel.isHidden = true
                
            }else{
                
                noDataView.isHidden = false
                noDataTextLabel.isHidden = false
                noDataTextLabel.text = "No Records Found"
                
            }
        }
        
        assigmentTableView.reloadData()
        
    }
    
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        searchbar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchbar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchbar.isHidden  = true
        searchFullView .isHidden = true
        noDataView.isHidden = true
        noDataTextLabel.isHidden = true
        
        searchbar.resignFirstResponder()
    }
    
    @objc func dismissKeyboards() {
        
        sideMenuView.isHidden = true
        view.endEditing(true)
    }
    
    @IBAction func segmentAction(_ sender: Any) {
        
        if is_read_enabled == "1"{
            
            if assigmentSegmentName .selectedSegmentIndex == 0 {
                selectedCell = IndexPath()
                assigmentTableView.isScrollEnabled = false
                UpcommingRefName()
            }else if assigmentSegmentName.selectedSegmentIndex == 1 {
                selectedCell = IndexPath()
                assigmentTableView.isScrollEnabled = false
                PastRefName()
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if assigmentSegmentName.selectedSegmentIndex == 0{
            
            return UpcommingRef.count
        }
        
        else if assigmentSegmentName.selectedSegmentIndex == 1{
            
            return PasrRef.count
        }
        
        return 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Indentifiers, for: indexPath) as! AssigmentTvTableViewCell
        
        cell.selectionStyle = .none
        
        cell.topicLabel.isHidden = false
        cell.sendByLbl.isHidden = true
        cell.descriptionLabel.isHidden = true
        cell.attchmentView.isHidden = true
        cell.plusOneView.isHidden = true
        cell.submitionDateLabel.isHidden = true
        cell.subDateView.isHidden = true
        cell.submitionView.isHidden = true
        cell.attachFileLabel.isHidden = true
        cell.prevSubmissionView.isHidden = true
        cell.dotHeight.constant = 0
        
        if assigmentSegmentName.selectedSegmentIndex == 0{
            
            let upcoming : upcommingdataDetails = UpcommingRef[indexPath.row]
            
            cell.topicLabel.text = upcoming.topic
            cell.descriptionLabel.text = upcoming.description
            cell.creatonLabel.text = upcoming.sentbyname
            
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "dd-MM-yyy"
            
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = " dd MMM,yyyy"
            
            let dates: NSDate? = dateFormatterGet.date(from: upcoming.submissiondate ?? "") as NSDate?
            
            cell.submitionDateLabel.text = dateFormatterPrint.string(from: dates as! Date)
            
            let  plusoneCount  = upcoming.newfilepath?.count ?? 0
            let stringconvert = String(plusoneCount)
            
            cell.plusoneLabel.text = "+" + stringconvert
            
            if let createdOn = upcoming.createdon {
                let dateAndTime = createdOn.components(separatedBy: " - ")
                cell.dateLabel.text = dateAndTime.first ?? ""
                cell.timeLabel.text = dateAndTime.dropFirst().joined(separator: " - ")
            }
            
            if let selectedCells = selectedCell, selectedCells == indexPath {
                cell.descriptionLabel.isHidden = false
                cell.sendByLbl.isHidden = false
                cell.attchmentView.isHidden = false
                cell.plusOneView.isHidden = false
                cell.submitionDateLabel.isHidden = false
                cell.cellArrowImage.image = UIImage(systemName: "chevron.up")
                cell.subDateView.isHidden = false
                cell.submitionView.isHidden = false
                cell.attachFileLabel.isHidden = false
                cell.PreviousSubmissionHeight.constant = 35
                cell.creatonLabel.alpha = 1
                cell.submissiondefaultLbl.isHidden = false
              
                if upcoming.assignmenttype == "text"  || upcoming.assignmenttype == "Text" {
                    
                    cell.attchmentView.isHidden = true
                    cell.plusOneView.isHidden = true
                }else if upcoming.assignmenttype == "All"{
                    
                    cell.attchmentView.isHidden = true
                    cell.plusOneView.isHidden = true
                    
                }else{
                    
                    cell.attchmentView.isHidden = false
                    cell.plusOneView.isHidden = false
                }
                
                if (upcoming.newfilepath?.count ?? 0) == 0{
                    
                    cell.attchmentView.isHidden = true
                    cell.plusOneView.isHidden = true
                    
                }else{
                    
                    cell.attchmentView.isHidden = false
                    cell.plusOneView.isHidden = false
                }
                
                if upcoming.isappread == "1"{
                    
                    cell.ReadDotImageView.isHidden =  true
                    
                }else {
                    
                    cell.ReadDotImageView.isHidden = false
                   
                }
                
                if upcoming.submittedcount != "0"{
                    //
                    cell.prevSubmissionView.isHidden = false
                    
                    let submission = AssigmentPreViewSubmision(target: self, action: #selector(AssigmentSubmissionVC))
                    submission.assigmentHeaderId = upcoming.assignmentid
                    submission.fileType = upcoming.assignmenttype
                    cell.prevSubmissionView.addGestureRecognizer(submission)
                    
                }else{
                    
                    cell.prevSubmissionView.isHidden = true
                    
                    let submission = AssigmentPreViewSubmision(target: self, action: #selector(AssigmentSubmissionVC))
                    submission.assigmentHeaderId = upcoming.assignmentid
                    submission.fileType = upcoming.assignmenttype
                    cell.prevSubmissionView.addGestureRecognizer(submission)
                    
                }
                
                let submit = SubmissionassigmentGesture(target: self, action: #selector(sbmitionVc))
                submit.assigmentId = upcoming.assignmentid
                submit.progressId = upcoming.createdby
                cell.submitionView.addGestureRecognizer(submit)
                
                
                if upcoming.newfilepath?.count == 1  {
                    
                    cell.plusOneView.isHidden = true
                    let  attchmentTap = assigmentGesture(target: self, action: #selector(AtchmentVc))
                    attchmentTap.img_urls = upcoming.newfilepath ?? []
                    attchmentTap.imageFileType = upcoming.assignmenttype
                    attchmentTap.titee = upcoming.topic
                    attchmentTap.descrttt = upcoming.description
                    
                    for i in upcoming.newfilepath ?? []{
                        
                        attchmentTap.img_url = i
                        
                    }
                    
                    cell.attchmentView.addGestureRecognizer(attchmentTap)
                    
                }
                
                
                else{
                    
                    let  attchmentTap = assigmentGesture(target: self, action: #selector(AtchmentVc))
                    attchmentTap.img_urls = upcoming.newfilepath ?? []
                    attchmentTap.imageFileType = upcoming.assignmenttype
                    attchmentTap.titee = upcoming.topic
                    attchmentTap.descrttt = upcoming.description
                    
                    
                    for i in upcoming.newfilepath ?? []{
                        
                        attchmentTap.img_url = i
                        
                    }
                    
                    cell.attchmentView.addGestureRecognizer(attchmentTap)
                }
                
            } else {
                cell.descriptionLabel.isHidden = true
                cell.submissiondefaultLbl.isHidden = true
                cell.PreviousSubmissionHeight.constant = 0
                cell.cellArrowImage.image = UIImage(systemName: "chevron.down")
                cell.creatonLabel.alpha = 0
            }
        }else if assigmentSegmentName.selectedSegmentIndex == 1 {
            
            let upcoming : upcommingdataDetails = PasrRef[indexPath.row]
            
            cell.topicLabel.text = upcoming.topic
            cell.descriptionLabel.text = upcoming.description
            cell.creatonLabel.text = upcoming.sentbyname
            
            if let createdOn = upcoming.createdon {
                let dateAndTime = createdOn.components(separatedBy: " - ")
                cell.dateLabel.text = dateAndTime.first ?? ""
                cell.timeLabel.text = dateAndTime.dropFirst().joined(separator: " - ")
            }
            
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "dd-MM-yyy"
            
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = " dd MMM,yyyy"
            
            let dates: NSDate? = dateFormatterGet.date(from: upcoming.submissiondate ?? "") as NSDate?

            cell.submitionDateLabel.text = dateFormatterPrint.string(from: dates as! Date)
            let  plusoneCount  = upcoming.newfilepath?.count ?? 0
            let stringconvert = String(plusoneCount)
            cell.plusoneLabel.text = "+" + stringconvert
            
            if let selectedCells = selectedCell, selectedCells == indexPath {
                cell.sendByLbl.isHidden = false
                cell.descriptionLabel.isHidden = false
                cell.attchmentView.isHidden = false
                cell.plusOneView.isHidden = false
                cell.submitionDateLabel.isHidden = false
                cell.cellArrowImage.image = UIImage(systemName: "chevron.up")
                cell.subDateView.isHidden = false
                cell.submitionView.isHidden = false
                cell.attachFileLabel.isHidden = false
                cell.creatonLabel.alpha = 1
                cell.PreviousSubmissionHeight.constant = 35
                cell.descriptionLabel.isHidden = false
                cell.submissiondefaultLbl.isHidden = false
             
                if upcoming.assignmenttype == "text"  || upcoming.assignmenttype == "Text" {
                    
                    cell.attchmentView.isHidden = true
                    cell.plusOneView.isHidden = true
                }else if upcoming.assignmenttype == "All"{
                    
                    cell.attchmentView.isHidden = true
                    cell.plusOneView.isHidden = true
                } else{
                    
                    cell.attchmentView.isHidden = false
                    cell.plusOneView.isHidden = false
                }
                
                if (upcoming.newfilepath?.count ?? 0) == 0{
                    
                    cell.attchmentView.isHidden = true
                    cell.plusOneView.isHidden = true
                    
                }else{
                    
                    cell.attchmentView.isHidden = false
                    cell.plusOneView.isHidden = false
                }
                
                if upcoming.isappread == "1"{
                    
                    cell.ReadDotImageView.isHidden =  true
                    
                }else {
                    
                    cell.ReadDotImageView.isHidden = false
                    
                }
                
                if upcoming.submittedcount != "0"{
                    
                    cell.prevSubmissionView.isHidden = false
                    
                    let submission = AssigmentPreViewSubmision(target: self, action: #selector(AssigmentSubmissionVC))
                    submission.assigmentHeaderId = upcoming.assignmentid
                    submission.fileType = upcoming.assignmenttype
                    cell.prevSubmissionView.addGestureRecognizer(submission)
                    
                }else{
                    
                    cell.prevSubmissionView.isHidden = true
                    
                    let submission = AssigmentPreViewSubmision(target: self, action: #selector(AssigmentSubmissionVC))
                    submission.assigmentHeaderId = upcoming.assignmentid
                    submission.fileType = upcoming.assignmenttype
                    cell.prevSubmissionView.addGestureRecognizer(submission)
                }
                
                let submit = SubmissionassigmentGesture(target: self, action: #selector(sbmitionVc))
                submit.assigmentId = upcoming.assignmentid
                submit.progressId = upcoming.createdby
                cell.submitionView.addGestureRecognizer(submit)
                
                
                if upcoming.newfilepath?.count == 1  {
                    
                    cell.plusOneView.isHidden = true
                    let  attchmentTap = assigmentGesture(target: self, action: #selector(AtchmentVc))
                    attchmentTap.img_urls = upcoming.newfilepath ?? []
                    attchmentTap.imageFileType = upcoming.assignmenttype
                    attchmentTap.titee = upcoming.topic
                    attchmentTap.descrttt = upcoming.description
                    
                    for i in upcoming.newfilepath ?? []{
                        
                        attchmentTap.img_url = i
                        
                    }
                    
                    cell.attchmentView.addGestureRecognizer(attchmentTap)
                    
                }else{
                    
                    let  attchmentTap = assigmentGesture(target: self, action: #selector(AtchmentVc))
                    attchmentTap.img_urls = upcoming.newfilepath ?? []
                    attchmentTap.imageFileType = upcoming.assignmenttype
                    attchmentTap.titee = upcoming.topic
                    attchmentTap.descrttt = upcoming.description
                    
                    for i in upcoming.newfilepath ?? []{
                        
                        attchmentTap.img_url = i
                        
                    }
                    
                    cell.attchmentView.addGestureRecognizer(attchmentTap)
                }
                
            } else {
                
                cell.descriptionLabel.isHidden = true
                cell.submissiondefaultLbl.isHidden = true
                cell.cellArrowImage.image = UIImage(systemName: "chevron.down")
                cell.creatonLabel.alpha = 0
                cell.PreviousSubmissionHeight.constant = 0
            }
        }
        
        return cell
    }
    
    @IBAction func AssigmentSubmissionVC(gesture : AssigmentPreViewSubmision){
        
        if priority == "p4" || priority == "p5"{
            
                let vc = AssigmentSubmissionViewController(nibName: nil, bundle: nil)
                vc.assigmentId = gesture.assigmentHeaderId
                vc.assigmentFileType = gesture.fileType
                vc.strName = strName
                vc.str = str
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true,completion: nil)
                
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
            return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        assigmentTableView.deselectRow(at: indexPath, animated: true)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Indentifiers, for: indexPath) as!
        
        AssigmentTvTableViewCell
        
        
        cell.selectionStyle = .none
        
        if assigmentSegmentName.selectedSegmentIndex == 0{
            
            var upcoming : upcommingdataDetails = UpcommingRef[indexPath.row]
            
            
            
            if let selectedCells = selectedCell, selectedCells == indexPath {
                
                selectedCell = nil
                
                
                
                if upcoming.assignmenttype == "text"  || upcoming.assignmenttype == "Text" {
                    
                    cell.attchmentView.isHidden = true
                    cell.plusOneView.isHidden = true
                }
                
                else if upcoming.assignmenttype == "All"{
                    
                    cell.attchmentView.isHidden = true
                    cell.plusOneView.isHidden = true
                    
                }
                
                else{
                    
                    cell.attchmentView.isHidden = false
                    cell.plusOneView.isHidden = false
                }
                
                if upcoming.newfilepath?.count == 0{
                    
                    cell.attchmentView.isHidden = true
                    cell.plusOneView.isHidden = true
                    
                }
                
                else{
                    
                    cell.attchmentView.isHidden = false
                    cell.plusOneView.isHidden = false
                }
                
                
                
                if upcoming.isappread == "1"{
                    
                    cell.ReadDotImageView.isHidden =  true
                    
                }
                
                else {
                    
                    cell.ReadDotImageView.isHidden = false
                    //
                }
                
                
                
                
                if upcoming.submittedcount != "0"{
                    //
                    cell.prevSubmissionView.isHidden = false
                    
                    let submission = AssigmentPreViewSubmision(target: self, action: #selector(AssigmentSubmissionVC))
                    submission.assigmentHeaderId = upcoming.assignmentid
                    submission.fileType = upcoming.assignmenttype
                    cell.prevSubmissionView.addGestureRecognizer(submission)
                    
                    
                }
                
                else{
                    
                    cell.prevSubmissionView.isHidden = true
                    
                    let submission = AssigmentPreViewSubmision(target: self, action: #selector(AssigmentSubmissionVC))
                    submission.assigmentHeaderId = upcoming.assignmentid
                    submission.fileType = upcoming.assignmenttype
                    cell.prevSubmissionView.addGestureRecognizer(submission)
                    
                    
                }
                
                let submit = SubmissionassigmentGesture(target: self, action: #selector(sbmitionVc))
                submit.assigmentId = upcoming.assignmentid
                submit.progressId = upcoming.createdby
                cell.submitionView.addGestureRecognizer(submit)
                
                
                if upcoming.newfilepath?.count == 1  {
                    
                    
                    cell.plusOneView.isHidden = true
                    let  attchmentTap = senderassigments(target: self, action: #selector(AtchmentVc))
                    attchmentTap.img_urls = upcoming.newfilepath ?? []
                    attchmentTap.imageFileType = upcoming.assignmenttype
                    attchmentTap.titee = upcoming.topic
                    attchmentTap.descrttt = upcoming.description
                    
                    
                    for i in upcoming.newfilepath ?? []{
                        
                        attchmentTap.img_url = i
                        
                    }
                    
                    cell.attchmentView.addGestureRecognizer(attchmentTap)
                    
                }
                
                
                else{
                    
                    let  attchmentTap = senderassigments(target: self, action: #selector(AtchmentVc))
                    attchmentTap.img_urls = upcoming.newfilepath ?? []
                    attchmentTap.imageFileType = upcoming.assignmenttype
                    attchmentTap.titee = upcoming.topic
                    attchmentTap.descrttt = upcoming.description
                    
                    
                    for i in upcoming.newfilepath ?? []{
                        
                        attchmentTap.img_url = i
                    }
                    
                    cell.attchmentView.addGestureRecognizer(attchmentTap)
                }
                
            } else {
                
                
                selectedCell = indexPath
                
                if upcoming.isappread == "0"{
                    
                    apread(gesture : upcoming.assignmentdetailid ?? "")
                    
                    upcoming.isappread = "1"
                    cell.ReadDotImageView.isHidden = true
                    
                }
            }
        }
        
        else if assigmentSegmentName.selectedSegmentIndex == 1{
            
            
            var past : upcommingdataDetails = PasrRef[indexPath.row]
            
            
            
            if let selectedCells = selectedCell, selectedCells == indexPath {
                
                selectedCell = nil
                
                
            } else {
                
                
                selectedCell = indexPath
                
                if past.isappread == "0"{
                    
                    apread(gesture : past.assignmentdetailid ?? "")
                    
                    past.isappread = "1"
                    cell.ReadDotImageView.isHidden = true
                    
                }
            }
            
        }
        
        assigmentTableView.beginUpdates()
        assigmentTableView.endUpdates()
        assigmentTableView.reloadData()
    }
    
    
    func apread(gesture : String){
        
        var readApiStatus  = AppReadStatusModal()
        
        readApiStatus.msgtype = "assignment"
        readApiStatus.priority = priority
        readApiStatus.userid = memberId
        readApiStatus.detailsid = gesture
        print("sertt",gesture)
        
        APiCallManager.shared.callApi(url: APIEndpoints.Appreadstatus, httpMethod: .post, queryParam: nil, requestBody: readApiStatus) {[weak self]  (result:Result<ReadStausApiResponce, Error>) in
            
            guard let self = self else {return}
            
            switch result {
            case .success(let success):
                assigmentTableView.reloadData()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func addApi(){
        
        
        var add = AddApiModal()
        
        let defaults = UserDefaults.standard
        var deviceToken = defaults.string(forKey:DefaultsKeys.DeviceToken )
        add.device_token = deviceToken
        print("EventDefaultsKeys.DeviceToken",deviceToken)
        add.member_id = Int(memberId)
        add.mobile_no = mobileNumber
        add.priority = priority
        add.college_id = Int(colgId)
        add.previous_add_id = PreviousAddId
        
        APiCallManager.shared.callApi(url: APIEndpoints.GetAddsForCollege, httpMethod: .post, queryParam: nil, requestBody: add
        ) {[weak self] (result:Result<AddApiResponce,Error>) in
            
            guard let self = self else {return}
            
            switch result {
            case .success(let success):
         
                    addapiRef = success.data ?? []
                    
                    let ad = addapiRef.first
                  
                    bigImg.setAdImage(
                        imageURL: ad?.background_image,
                        adURL: ad?.add_url,
                        from: self
                    )

                    smallImg.setAdImage(
                        imageURL: ad?.add_image,
                        adURL: ad?.add_url,
                        placeholder: UIImage(named: "Default_Ad_small"),
                        from: self
                    )
                
                
            case .failure(let failure):
                print(failure.localizedDescription)
                
                bigImg.setAdImage(
                    imageURL: "",
                    adURL: "",
                    from: self
                )

                smallImg.setAdImage(
                    imageURL:"",
                    adURL: "",
                    placeholder: UIImage(named: "Default_Ad_small"),
                    from: self
                )
            }
        }
    }
    
    @IBAction func sbmitionVc(gesture : SubmissionassigmentGesture){
        
        let vc = SubmitionViewController(nibName: nil, bundle: nil)
        vc.assigmentId = gesture.assigmentId
        vc.str  = str
        vc.strName = strName
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
    }
    
    
    @IBAction func AtchmentVc(gesture : assigmentGesture){
    
        let vc  = MoreImageVcViewController(nibName: nil, bundle: nil)

        vc.imageFile = gesture.img_urls
        vc.fileType = gesture.imageFileType
        vc.TopicLbl = gesture.titee
        vc.modalPresentationStyle = .formSheet
        present(vc, animated: true,completion: nil)
    }
    
    
    
    func UpcommingRefName() {
        
        var Upcom = senderUpcommingModal()
        
        Upcom.userid   = memberId
        Upcom.collegeid    = colgId
        Upcom.departmentid = deptid
        Upcom.sectionid     = sectionid
        Upcom.appid    =  "2"
        Upcom.priority = priority
        Upcom.type = "upcomingassignments"
        
        
        APiCallManager.shared.callApi(url: APIEndpoints.GetAssignmentListByType, httpMethod: .post, queryParam: nil, requestBody: Upcom) { [weak self] (result:Result<senderUpcommingResponces,Error>) in
            guard let self = self else {return}
            switch result{
            case .success(let success):
                if success.Status == 1 {
                    
                    print("order data",success)
                    
                    
                    UpcommingRef = success.data ?? []
                    cloneList = success.data ?? []
                    
                    assigmentTableView.isScrollEnabled = true
                    
                    noDataView.isHidden = true
                    noDataTextLabel.isHidden = true
                    assigmentTableView.delegate = self
                    assigmentTableView.dataSource = self
                    assigmentTableView.reloadData()
                    
                }else{
                    
                    noDataView.isHidden = false
                    noDataTextLabel.isHidden = false
                    noDataTextLabel.text = success.Message
                    assigmentTableView.delegate = self
                    assigmentTableView.dataSource = self
                    assigmentTableView.reloadData()
                    
                }
            case .failure(let error):
                print()
            }
        }
        
    }
    
    
    func PastRefName() {
        
        var past = senderUpcommingModal()
        
        past.userid   = memberId
        
        past.collegeid    = colgId
        
        past.departmentid = deptid
        past.sectionid     = sectionid
        
        past.appid    =  "2"
        past.priority = priority
        
        past.type = "pastassignments"
        
        APiCallManager.shared.callApi(url: APIEndpoints.GetAssignmentListByType, httpMethod: .post, queryParam: nil, requestBody: past) { [weak self] (result:Result<senderUpcommingResponces,Error>) in
            guard let self = self else {return}
            switch result{
            case .success(let success):
                if success.Status == 1{
                    
                    PasrRef = success.data ?? []
                    cloneList = success.data ?? []
                    
                    noDataView.isHidden = true
                    noDataTextLabel.isHidden = true
                    assigmentTableView.isScrollEnabled = true
                    assigmentTableView.delegate = self
                    assigmentTableView.dataSource = self
                    assigmentTableView.reloadData()
                    
                }else {
                    noDataView.isHidden = false
                    noDataTextLabel.isHidden = false
                    noDataTextLabel.text = success.Message
                    assigmentTableView.delegate = self
                    assigmentTableView.dataSource = self
                    assigmentTableView.reloadData()
                    
                }
                
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func overAllRefName() {
        
        var overall = overAllModal()
        
        overall.userid   =  memberId
        overall.menuid       = "5"
        overall.collegeid    = colgId
        overall.departmentid =  deptid
        overall.sectionid    =   sectionid
        overall.appid        = "2"
        overall.priority     = priority
        
        APiCallManager.shared.callApi(url: APIEndpoints.GetOverallcountByMenuType, httpMethod: .post, queryParam: nil, requestBody: overall) { [weak self] (result:Result<overAllResponce,Error>) in
            guard let self = self else{return}
            switch result{
            case .success(let success):
                
                if success.Status == 1{
                    overAllRef = success.data ?? []
                    
                    for i in overAllRef{
                        
                        assigmentUpcommingCount.text = i.upcomingassignment
                        assigmentPastCount.text = i.pastassignment
                        if (i.upcomingassignment == "0") && (i.pastassignment == "0"){
                            
                            upcommingcountView.isHidden = true
                            assigmentPastCountView.isHidden = true
                            assigmentCountViews.isHidden = true
                            
                        }
                        
                        else if  i.upcomingassignment == "0"{
                            
                            upcommingcountView.isHidden = true
                            assigmentPastCountView.isHidden = false
                            assigmentCountViews.isHidden = false
                            
                        }
                        
                        else if i.pastassignment == "0"{
                            
                            upcommingcountView.isHidden = false
                            assigmentPastCountView.isHidden = true
                            assigmentCountViews.isHidden = false
                            
                        }
                        
                        else{
                            
                            upcommingcountView.isHidden = false
                            assigmentPastCountView.isHidden = false
                            assigmentCountViews.isHidden = false
                            
                        }
                    }
                    
                    let a =  Int( assigmentUpcommingCount.text!)
                    let b = Int(assigmentPastCount.text!)
                    let c = a! + b!
                    
                    assigmentTopCount.text = String(c)
                }
                
                
                else{
                    
                    upcommingcountView.isHidden = true
                    assigmentPastCountView.isHidden = true
                    assigmentCountViews.isHidden = true
                    
                }


            case .failure(let error):
                print("Error: \(error)")
                upcommingcountView.isHidden = true
                assigmentPastCountView.isHidden = true
                assigmentCountViews.isHidden = true
            }
        }
    }
    
    // Tab Bar Nagivation
    
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
            
            let vc = LoginVc(nibName: nil, bundle: nil)
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
  
    @IBAction func changePassowrdVC(){
        
        let vc = ChangePasswordVC(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true, completion: nil)
        
    }
    
    
    @IBAction func profileRedirect() {
        
        let vc = ProfileViewController(nibName: nil, bundle: nil)
        vc.str = str
        vc.strName = strName
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func priorityVc() {
        let vc = PriorityScreenVC(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
    }
    
}

@available(iOS 16.0, *)
extension AssigmentHomePageViewController: CustomTabBarDelegate {
    
    func didTapSearch() {
        searchbar.isHidden  = false
        searchFullView .isHidden = false
    }
    
    func didTapSideMenu() {
        sideMenuView.isHidden.toggle()
    }
    
}

class assigmentGesture : UITapGestureRecognizer {
    
    var img_url : String!
    var imageFileType : String!
    var titee : String!
    var descrttt : String!
    
    var img_urls : [String] = []
    
    
}


class SubmissionassigmentGesture : UITapGestureRecognizer {
    
    var assigmentId : String!
    var progressId : String!
    
}

class AssigmentPreViewSubmision : UITapGestureRecognizer{
    
    
    var assigmentHeaderId : String!
    
    var resiveId : String!
    
    var fileType : String!
    
}
