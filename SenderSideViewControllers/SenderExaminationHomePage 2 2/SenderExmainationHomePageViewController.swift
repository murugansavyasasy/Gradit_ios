//
//  SenderExmainationHomePageViewController.swift
//  GraditSenderExaminationMenu
//
//  Created by MACBOOKPRO on 03/12/22.
//

import UIKit
import ObjectMapper
import KRProgressHUD

@available(iOS 16.0, *)
class SenderExmainationHomePageViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    
    @IBOutlet weak var searchFullView: UIViewX!
    @IBOutlet weak var SearchView: UIView!
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var topNameview: UIView!
    @IBOutlet weak var tapBarView: UIViewX!
    @IBOutlet weak var loadingCustom: UIActivityIndicatorView!
    @IBOutlet weak var redirectLoginView: UIViewX!
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var smallImg: UIImageView!
    @IBOutlet weak var bigImg: UIImageView!
    @IBOutlet weak var changeRolesView: UIView!
    @IBOutlet weak var topLabels: UILabel!
    @IBOutlet weak var topMessageLabel: UILabel!
    @IBOutlet weak var clgLogoImg: UIImageView!
    @IBOutlet weak var sideMenuView: UIView!
    @IBOutlet weak var viewTap: UIView!
    @IBOutlet weak var changePasswordView: UIView!
    @IBOutlet weak var termsAndConditionView: UIView!
    @IBOutlet weak var helpView: UIView!
    @IBOutlet weak var faqView: UIView!
    @IBOutlet weak var plusImageView: UIImageView!
    @IBOutlet weak var privacyPolicyView: UIView!
    @IBOutlet weak var examsCountViews: UIViewX!
    @IBOutlet weak var upcommingExamCountLabel: UILabel!
    @IBOutlet weak var addPlusVcNextPage: UIViewX!
    @IBOutlet weak var noDataTextView: UIView!
    @IBOutlet weak var noDataLabel: UILabel!
    @IBOutlet weak var examSegmentName: UISegmentedControl!
    @IBOutlet weak var examTableView: UITableView!
    @IBOutlet weak var pastCountView: UIViewX!
    @IBOutlet weak var upcommingCountView: UIViewX!
    @IBOutlet weak var examTopCountLabel: UILabel!
    @IBOutlet weak var examTopCountView: UIViewX!
    @IBOutlet weak var pastExamCoutLabel: UILabel!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var refreshView: UIView!
    
    var NoticeBoardId = "1"
    var videoId = "2"
    var EventId = "3"
    var communicationId = "4"
    var imagePdfId = "5"
    var Assigment = "6"
    var  identifiers = "SenderExaminationTableViewCell"
    var upcomings : [SenderUpcommingExamDataDetails] = []
    var pasts : [SenderPastExamDataDetails] = []
    var overAllRef    : [overAllDataDetails] = []
    var addapiRef : [AddDataDeatils] = []
    var MenuRefName :[menuApiDataDetails] = []
    var editAndDeletRef : [editAndDeleteDataDetails] = []
    var selectedCell : IndexPath?
    var isclosaps = false
    var loginDatas : [datalogin]!
    var logindataprinci :[datalogin]!
    var memberId : String!
    var priority : String!
    var colgId  : String!
    var sectionid : String!
    var departmentId : String!
    var loginType : String!
    var memberName : String!
    var colgImg : String!
    var MobileNumber : String!
    var password : String!
    var PreviousAddId : Int = 0
    var str : [String] = []
    var strName : [String] = []
    var cloneList :  [SenderUpcommingExamDataDetails] = []
    var is_read_enabled = ""
    var is_write_enabled = ""
    
    override func viewDidAppear(_ animated: Bool) {
     
        PreviousAddId = PreviousAddId+1
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        sideMenuView.isHidden = true
        searchbar.delegate = self
        searchFullView .isHidden = true
        loadingCustom.isHidden = true
        let defaults = UserDefaults.standard
        
        memberId = defaults.string(forKey: DefaultsKeys.memberid)
        priority = defaults.string(forKey: DefaultsKeys.priority)
        colgId = defaults.string(forKey: DefaultsKeys.collegeid)
        sectionid  = defaults.string(forKey: DefaultsKeys.sectionid)
        departmentId = defaults.string(forKey: DefaultsKeys.deptid)
        loginType = defaults.string(forKey: DefaultsKeys.loginAsType)
        memberName = defaults.string(forKey: DefaultsKeys.memberName)
        colgImg = defaults.string(forKey: DefaultsKeys.colglogo)
        clgLogoImg.sd_setImage(with: URL(string:  colgImg), placeholderImage: UIImage(named: "EmptyCollegeIcon"))
        MobileNumber = defaults.string(forKey: DefaultsKeys.mobileNumber)
        
        password  = defaults.string(forKey: DefaultsKeys.Password)
        topMessageLabel.text = memberName
        
        addApi()

        if sectionid == ""{
            
            sectionid = "0"
        }
        
        upcommingRefName()
        
        if is_write_enabled == "1"{
            addPlusVcNextPage.isHidden = false
        }else{
            addPlusVcNextPage.isHidden = true
        }
        
        applyPriorityConfiguration()
        
        
        let rowNib = UINib(nibName: identifiers, bundle: nil)
        examTableView.register(rowNib, forCellReuseIdentifier: identifiers)
        examTableView.delegate = self
        examTableView.dataSource = self
        
        
        noDataTextView.alpha = 0
        
        
        let plusAddViews = UITapGestureRecognizer(target: self, action: #selector(PlusVc))
        addPlusVcNextPage.addGestureRecognizer(plusAddViews)
        
        
        // tap Bar UiTapGuster.
        
        
        let Serach = UITapGestureRecognizer(target: self, action: #selector(Searchfield))
        SearchView.addGestureRecognizer(Serach)
        
        let menuGestureHide = UITapGestureRecognizer(target: self, action: #selector(menu))
        viewTap.addGestureRecognizer(menuGestureHide)
        
        let notificationGesture = UITapGestureRecognizer(target: self, action: #selector(notificationVc))
        notificationView.addGestureRecognizer(notificationGesture)
        
        let refreshGesture = UITapGestureRecognizer(target: self, action: #selector(refreshVc))
        refreshView.addGestureRecognizer(refreshGesture)
        
        
        let loginRediectGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        redirectLoginView.addGestureRecognizer(loginRediectGesture)
        
        
        let faqGesture = UITapGestureRecognizer(target: self, action: #selector(faqRedirect))
        faqView.addGestureRecognizer(faqGesture)
        
        let helpGesture = UITapGestureRecognizer(target: self, action: #selector(helpRedirect))
        helpView.addGestureRecognizer(helpGesture)
        
        let privacyPolicyGesture = UITapGestureRecognizer(target: self, action: #selector(privacyPolicyRedirect))
        privacyPolicyView.addGestureRecognizer(privacyPolicyGesture)
        
        let termsAndConditionGesture = UITapGestureRecognizer(target: self, action: #selector(termsAndCondition))
        termsAndConditionView.addGestureRecognizer(termsAndConditionGesture)
        
        
        let chagePassword = UITapGestureRecognizer(target: self, action: #selector(changePassowrdVC))
        changePasswordView.addGestureRecognizer(chagePassword)
        
        let changeRol = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        changeRolesView.addGestureRecognizer(changeRol)
        
        
        
        let topname = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        topNameview.addGestureRecognizer(topname)
        
        
        let logoutGesture = UITapGestureRecognizer(target: self, action: #selector(logoutPressed))
        loginView.addGestureRecognizer(logoutGesture)
    }
    
    // MARK: - Apply Priority UI

    private func applyPriorityConfiguration() {
        
        // Reset defaults
        addPlusVcNextPage.isHidden = false
        upcommingCountView.isHidden = false
        pastCountView.isHidden = false
        examTopCountView.isHidden = false

        switch priority {
            
        case "p1":
            topLabels.text = "Principal"
            tapBarView.backgroundColor = UIColor(named: "Principal")
            view.backgroundColor = UIColor(named: "Principal")
            overAllRefName()

        case "p2":
            topLabels.text = "Hod"
            tapBarView.backgroundColor = UIColor(named: "Teaching Staff")
            addPlusVcNextPage.backgroundColor = UIColor(named: "messagecolor")
            view.backgroundColor = UIColor(named: "Teaching Staff")
            overAllRefName()

        case "p3":
            topLabels.text = "Teacher"
            tapBarView.backgroundColor = UIColor(named: "Teaching Staff")
            addPlusVcNextPage.backgroundColor = UIColor(named: "messagecolor")
            view.backgroundColor = UIColor(named: "Teaching Staff")
            overAllRefName()

        case "p4":
            topLabels.text = "Student"
            view.backgroundColor = UIColor(named: "studentViewColors")
            overAllRefName()

        case "p5":
            topLabels.text = "Father"
            view.backgroundColor = UIColor(named: "FatherColor")
            overAllRefName()

        case "p6":
            topLabels.text = "NonTeaching"
            tapBarView.backgroundColor = UIColor(named: "Teaching Staff")
            view.backgroundColor = UIColor(named: "Teaching Staff")
            addPlusVcNextPage.isHidden = true
            upcommingCountView.isHidden = true
            pastCountView.isHidden = true
            examTopCountView.isHidden = true

        case "p7":
            topLabels.text = "Group Head"
            tapBarView.backgroundColor = UIColor(named: "univercityColorCod")
            view.backgroundColor = UIColor(named: "univercityColorCod")
            addPlusVcNextPage.isHidden = true
            upcommingCountView.isHidden = true
            pastCountView.isHidden = true
            examTopCountView.isHidden = true

        default:
            break
        }
    }
    
    
    
    @IBAction func Searchfield() {
        
        searchbar.isHidden  = false
        searchFullView .isHidden = false
    }
    
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let filtered_list : [SenderUpcommingExamDataDetails] = cloneList
        
        
        if !searchText.isEmpty{
            
            upcomings = filtered_list.filter {
                
                ($0.examname ?? "").lowercased().contains(searchText.lowercased()) || ($0.createdbyname ?? "").lowercased().contains(searchText.lowercased()) || ($0.startdate ?? "").lowercased().contains(searchText.lowercased())  || ($0.enddate ?? "").lowercased().contains(searchText.lowercased()) || ($0.headerid ?? "").lowercased().contains(searchText.lowercased()) || ($0.createdon ?? "").lowercased().contains(searchText.lowercased())
            }
     
        } else{
            
            upcomings = filtered_list
            print("pendingOrder")
            
        }
        examTableView.reloadData()
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
        
        searchbar.resignFirstResponder()
        
    }
    
    @IBAction func PlusVc() {
        
        for i in addapiRef{
            if  priority == "p3" {
                let vc = TeacherSidePlusPageViewController(nibName: nil, bundle: nil)
                
                vc.addImageBackGroundurl = i.background_image
                vc.imageWebUrl = i.add_url
                vc.smallImageUrl = i.add_image
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
               
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true , completion: nil)
            } else if priority == "p1" {
                
                let vc = SenderExaminationPlusNextPageViewController(nibName: nil, bundle: nil)
                vc.addImageBackGroundurl = i.background_image
                vc.imageWebUrl = i.add_url
                vc.smallImageUrl = i.add_image
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
               
                vc.str = str
                vc.strName = strName
                vc.view.backgroundColor = UIColor(named: "Principal" )
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true , completion: nil)
                
            }else if priority == "p2"{
                
                
                let vc = SenderExaminationPlusNextPageViewController(nibName: nil, bundle: nil)
                vc.addImageBackGroundurl = i.background_image
                vc.imageWebUrl = i.add_url
                vc.smallImageUrl = i.add_image
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
               
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true , completion: nil)
                 
            } else if priority == "p7"{
                
                
                let vc = SenderExaminationPlusNextPageViewController(nibName: nil, bundle: nil)
                vc.addImageBackGroundurl = i.background_image
                vc.imageWebUrl = i.add_url
                vc.smallImageUrl = i.add_image
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
               
                vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true , completion: nil)
                
            }
        }
        
    }
    
    @IBAction func examSegmentAction(_ sender: Any) {
        guard is_read_enabled == "1" else { return }
        
        let validPriorities = ["p1", "p2", "p3", "p6", "p7"]
        guard validPriorities.contains(priority) else { return }
        
        selectedCell = IndexPath()
        
        switch examSegmentName.selectedSegmentIndex {
        case 0:
            upcommingRefName()
        case 1:
            pastRefName()
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return examSegmentName.selectedSegmentIndex == 0 ? upcomings.count : pasts.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifiers, for: indexPath) as!
        
        SenderExaminationTableViewCell
        
        let isExpanded = selectedCell == indexPath
        
        cell.startDate.isHidden          = !isExpanded
        cell.endDate.isHidden            = !isExpanded
        cell.cellSendByLabel.isHidden    = !isExpanded
        cell.startDfaultLabel.isHidden   = !isExpanded
        cell.VenuColonLabel.isHidden     = !isExpanded
        cell.endDefaultLabel.isHidden    = !isExpanded
        cell.syllabusColonLabel.isHidden = !isExpanded
        cell.sendByView.isHidden         = !isExpanded
        cell.editDeleteStack.isHidden         = !isExpanded
        cell.arrowImageVIew.isHidden     = isExpanded
        
        if examSegmentName.selectedSegmentIndex == 0{
            
            let upcom : SenderUpcommingExamDataDetails = upcomings[indexPath.row]
            cell.cellExamDate.text = upcom.createdon
            cell.cellSendByLabel.text = upcom.createdbyname
            cell.cellExamName.text = upcom.examname?.capitalized
            cell.startDate.text = upcom.startdate
            cell.endDate.text = upcom.enddate
            
            if upcom.createdby == memberId{
                
                cell.deleteView.isHidden = false
                cell.editView.isHidden = false
                
            }else{
                
                cell.deleteView.isHidden = true
                cell.editView.isHidden = true
                
            }
            
            
            let  play = viewPage(target: self, action: #selector(connectedUpcoming))
            play.ExamId = upcom.headerid
            
            cell.nextView.addGestureRecognizer(play)
            
            let  editView = viewPage(target: self, action: #selector(connectedUpcoming))
            editView.EditId = "1"
            editView.ExamId = upcom.headerid
            cell.editView.addGestureRecognizer(editView)
            
            let deletee = deletessss(target: self, action: #selector(UpcomedeltedVc))
            deletee.examName  = upcom.examname
            deletee.ExamId = upcom.headerid
            deletee.startDate = upcom.startdate
            deletee.endDate = upcom.enddate
            
            cell.deleteView.addGestureRecognizer(deletee)
        }
        
        
        else if examSegmentName.selectedSegmentIndex == 1 {
            
            let past : SenderPastExamDataDetails = pasts[indexPath.row]
            
            if past.createdby == memberId{
                
                cell.deleteView.isHidden = false
                cell.editView.isHidden = true
                
            }else{
                
                cell.deleteView.isHidden = true
                cell.editView.isHidden = true
            }
            
            cell.cellExamDate.text = past.createdon
            cell.cellSendByLabel.text = past.createdbyname
            cell.cellExamName.text = past.examname?.capitalized
            cell.startDate.text = past.startdate
            cell.endDate.text = past.enddate
            
            let  play = viewPage(target: self, action: #selector(connected))
            play.ExamId = past.headerid
            cell.nextView.addGestureRecognizer(play)
            
            let  Edit = viewPage(target: self, action: #selector(connected))
            Edit.EditId = "1"
            Edit.ExamId = past.headerid
            cell.editView.addGestureRecognizer(Edit)
            
            let deletee = deletessss(target: self, action: #selector(UpcomedeltedVc))
            deletee.examName  = past.examname
            deletee.ExamId = past.headerid
            deletee.startDate = past.startdate
            deletee.endDate = past.enddate
            cell.deleteView.addGestureRecognizer(deletee)
            
        }
        
        return cell
    }
    
    
    @IBAction func UpcomedeltedVc(gesture :deletessss ){
        
        
        let refreshAlert = UIAlertController(title: "Delete Exam" + "  " +  gesture.examName, message:  "Once done Can't be changed", preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in
            
            if examSegmentName.selectedSegmentIndex == 0{
                
                
                var editDeltes = editDeleteModal()
                
                editDeltes.collegeid = colgId
                editDeltes.startdate = gesture.startDate
                editDeltes.enddate = gesture.endDate
                editDeltes.examid = gesture.ExamId
                editDeltes.staffid = memberId
                editDeltes.examname = gesture.examName
                editDeltes.processtype = "delete"
                editDeltes.sectiondetails = []
                
                APiCallManager.shared.callApi(
                    url: APIEndpoints.ExamCreation,
                    httpMethod: .post,
                    queryParam: nil,
                    requestBody: editDeltes
                ) { [weak self] (result: Result<EditAndDeletResponce, Error>) in
                    
                    guard let self = self else { return }
                    
                    switch result {
                        
                    case .success(let editDeltesResp):
                        
                        self.editAndDeletRef = editDeltesResp.data ?? []
                        
                        if editDeltesResp.Status == 1{
                            
                            let refreshAlert = UIAlertController(title: "", message: editDeltesResp.Message, preferredStyle: UIAlertController.Style.alert)
                            
                            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                                
                            }))
                            
                            self.present(refreshAlert, animated: true, completion: nil)
                            
                            self.examTableView.delegate = self
                            self.examTableView.dataSource = self
                            
                            self.examTableView.reloadData()
                            
                            self.upcommingRefName()
                            
                        }
                        
                        else{
                            
                            
                            let refreshAlert = UIAlertController(title: "", message: editDeltesResp.Message, preferredStyle: UIAlertController.Style.alert)
                            
                            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                                
                            }))
                            
                            self.present(refreshAlert, animated: true, completion: nil)
                            
                            self.examTableView.delegate = self
                            self.examTableView.dataSource = self
                            self.examTableView.reloadData()
                            
                        }
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            } else if examSegmentName.selectedSegmentIndex == 1{
                
                
                var editDeltes = editDeleteModal()
                
                editDeltes.collegeid = colgId
                editDeltes.startdate = gesture.startDate
                editDeltes.enddate = gesture.endDate
                editDeltes.examid = gesture.ExamId
                editDeltes.staffid = memberId
                editDeltes.examname = gesture.examName
                editDeltes.processtype = "delete"
                editDeltes.sectiondetails = []
                
                APiCallManager.shared.callApi(
                    url: APIEndpoints.ExamCreation,
                    httpMethod: .post,
                    queryParam: nil,
                    requestBody: editDeltes
                ) { [weak self] (result: Result<EditAndDeletResponce, Error>) in
                    
                    guard let self = self else { return }
                    
                    switch result {
                        
                    case .success(let editDeltesResp):
                        
                        self.editAndDeletRef = editDeltesResp.data ?? []
                        
                        if editDeltesResp.Status == 1{
                            
                            let refreshAlert = UIAlertController(title: "", message: editDeltesResp.Message, preferredStyle: UIAlertController.Style.alert)
                            
                            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                                
                            }))
                            
                            self.present(refreshAlert, animated: true, completion: nil)
                            
                            self.examTableView.delegate = self
                            self.examTableView.dataSource = self
                            
                            self.examTableView.reloadData()
                            
                            self.pastRefName()
                            
                        }
                        
                        else{
                            
                            
                            let refreshAlert = UIAlertController(title: "", message: editDeltesResp.Message, preferredStyle: UIAlertController.Style.alert)
                            
                            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                                
                            }))
                            
                            self.present(refreshAlert, animated: true, completion: nil)
                            
                            self.examTableView.delegate = self
                            self.examTableView.dataSource = self
                            self.examTableView.reloadData()
                            
                        }
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
            
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "CANCEL", style: .default, handler: { (action: UIAlertAction!) in
           
        }))
        
        present(refreshAlert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func connected(gestur:viewPage) {
        
        if priority ==  "p2" || priority == "p3" {
            
            let vc = SenderExaminationNextPageViewController(nibName: nil, bundle: nil)
            vc.examId = gestur.ExamId
            
            vc.str = str
            vc.strName = strName
            vc.EditId = gestur.EditId
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
        }
        
        else if priority ==  "p7" {
            
            let vc = SenderExaminationNextPageViewController(nibName: nil, bundle: nil)
            vc.examId = gestur.ExamId
            
            vc.str = str
            vc.strName = strName
            vc.EditId = gestur.EditId
            vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
        }
        
        else{
            
            let vc = SenderExaminationNextPageViewController(nibName: nil, bundle: nil)
            vc.examId = gestur.ExamId
            
            vc.str = str
            vc.strName = strName
            vc.EditId = gestur.EditId
            vc.view.backgroundColor = UIColor(named: "Principal" )
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
        }
        
    }
    
    @IBAction func connectedUpcoming(gestur:viewPage) {
        
        if priority ==  "p2" || priority == "p3" {
            
            let vc = SenderExaminationNextPageViewController(nibName: nil, bundle: nil)
            vc.examId = gestur.ExamId
            vc.str = str
            vc.strName = strName
            vc.EditId = gestur.EditId
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
           
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
        }
        
       else if priority ==  "p7" {
            
            let vc = SenderExaminationNextPageViewController(nibName: nil, bundle: nil)
            vc.examId = gestur.ExamId
            vc.str = str
            vc.strName = strName
            vc.EditId = gestur.EditId
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
           
            vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
        }
        else{
            
            let vc = SenderExaminationNextPageViewController(nibName: nil, bundle: nil)
            vc.examId = gestur.ExamId
            vc.str = str
            vc.strName = strName
            vc.EditId = gestur.EditId
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
           
            vc.view.backgroundColor = UIColor(named: "Principal" )
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
        }
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        examTableView.deselectRow(at: indexPath, animated: true)
        
        
        
        if let selectedCells = selectedCell, selectedCells == indexPath {
            
            selectedCell = nil
            
        }
        
        else{
            
            selectedCell = indexPath
            
        }
        
        
        examTableView.beginUpdates()
        examTableView.endUpdates()
        examTableView.reloadData()
        
    }
    
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        if let selectedCell = selectedCell, selectedCell == indexPath {
            
            
            return UITableView.automaticDimension
            
        } else {
            
            return 140
            
        }
        
        
    }
    
    
    func upcommingRefName() {
        
        var upcoming = SenderUpcommingExamModal()
        
        upcoming.userid   = memberId
        upcoming.collegeid = colgId
        upcoming.sectionid = sectionid
        upcoming.appid    = "2"
        upcoming.priority = priority
        upcoming.type     = "upcomingexams"
        
        
        print("upcoming request", upcoming)
        
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.GetExamListByTypeforsenderapp,
            httpMethod: .post,
            queryParam: nil,
            requestBody: upcoming
        ) { [weak self] (result: Result<SenderUpcommingExamResponce, Error>) in
            
            guard let self = self else { return }
            
            switch result {
                
            case .success(let departResp):
                
                if departResp.Status == 1{
                    
                    self.upcomings = departResp.data ?? []
                    self.cloneList = departResp.data ?? []
                    self.noDataTextView.alpha = 0
                    self.examTableView.delegate = self
                    self.examTableView.dataSource = self
                    self.examTableView.reloadData()
                   
                }else{
                    self.noDataTextView.alpha = 1
                    
                    self.noDataTextView.isHidden = false
                    self.noDataLabel.text = departResp.Message
                    self.examTableView.delegate = self
                    self.examTableView.dataSource = self
                    self.examTableView.reloadData()
                   
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    
    func pastRefName() {
        
        var past = SenderPastExamModal()
        
        past.userid   = memberId
        past.collegeid = colgId
        past.sectionid = sectionid
        past.appid    = "2"
        past.priority = priority
        past.type     = "pastexams"
        
        print("past request", past)
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.GetExamListByTypeforsenderapp,
            httpMethod: .post,
            queryParam: nil,
            requestBody: past
        ) { [weak self] (result: Result<SenderPAstExamResponce, Error>) in
            
            guard let self = self else { return }
            
            switch result {
                
            case .success(let pastResp):
                
                print("order data", pastResp)
                print("order data", pastResp)
                
                if pastResp.Status == 1{
                    
                    self.pasts = pastResp.data ?? []
                    
                    self.examTableView.delegate = self
                    self.examTableView.dataSource = self
                    
                    self.noDataTextView.alpha = 0
                    
                    self.examTableView.reloadData()
                    
                }
                
                else{
                    
                    self.noDataTextView.isHidden = false
                    self.noDataLabel.text = pastResp.Message
                    
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func addApi(){
        
        var add = AddApiModal()
        
        let defaults = UserDefaults.standard
        var deviceToken = defaults.string(forKey:DefaultsKeys.DeviceToken )
        add.device_token = deviceToken
        add.member_id = Int(memberId)
        add.mobile_no = MobileNumber
        add.priority = priority
        add.college_id = Int(colgId)
        add.previous_add_id = PreviousAddId
        
        
        APiCallManager.shared.callApi(url: APIEndpoints.GetAddsForCollege, httpMethod: .post, queryParam: nil, requestBody: add
        ) {[weak self] (result:Result<AddApiResponce,Error>) in
            
            guard let self = self else {return}
            
            switch result {
            case .success(let success):
                if success.Status == 1 {
                    addapiRef = success.data ?? []
                    
                    for i in addapiRef{
                      
                        bigImg.sd_setImage(with: URL(string: i.background_image ?? ""), placeholderImage: UIImage(named: "ic_white"))
                        
                        smallImg.sd_setImage(with: URL(string: i.add_image ?? ""), placeholderImage: UIImage(named: "ic_white"))
                        
                        let singleTap = adds(target: self, action: #selector(adLoad))
                        singleTap.url = i.add_url
                        bigImg.isUserInteractionEnabled = true
                        bigImg.addGestureRecognizer(singleTap)
                    }
                }
                
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    
    func overAllRefName() {
        
        var overall = overAllModal()
        
        overall.userid   =  memberId
        overall.menuid       = "3"
        overall.collegeid    =  colgId
        overall.departmentid =  departmentId
        overall.sectionid    =  sectionid
        overall.appid        =   "2"
        overall.priority     = priority
        
        APiCallManager.shared.callApi(url:APIEndpoints.GetOverallcountByMenuType, httpMethod: .post, queryParam: nil, requestBody: overall) {[weak self] (result:Result<overAllResponce,Error>) in
            guard let self = self else {return}
            switch result {
            case .success(let success):
                if success.Status == 1{
                    overAllRef = success.data ?? []
                    for i in overAllRef{
                        upcommingExamCountLabel.text = i.upcomingexams
                        pastExamCoutLabel.text = i.pastexams
                        if (i.upcomingexams == "0") && (i.pastexams == "0"){
                            
                            upcommingCountView.isHidden = true
                            pastCountView.isHidden = true
                            examsCountViews.isHidden = true
                            
                        }else if i.upcomingexams == "0" {
                            
                            upcommingCountView.isHidden = true
                            pastCountView.isHidden = false
                            examsCountViews.isHidden = false
                            
                        }
                        else if i.pastexams == "0"{
                            
                            upcommingCountView.isHidden = false
                            pastCountView.isHidden = true
                            examsCountViews.isHidden = false
                            
                        }else {
                            upcommingCountView.isHidden = false
                            pastCountView.isHidden = false
                            examsCountViews.isHidden = false
                        }
                    }
                    let a =  Int( upcommingExamCountLabel.text!)
                    let b = Int(pastExamCoutLabel.text!)
                    let c = a! + b!
                    examTopCountLabel.text = String(c)
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        
    }
    
    
    
    @IBAction func adLoad(gesture:SenderExamAdd){
        
        let vc = SenderExamAddVcViewController(nibName: nil, bundle: nil)
        vc.AddWebUrl = gesture.addUrls
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
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
            
            
            self.upcommingRefName()
            
            KRProgressHUD.dismiss()
            
        }
        
        
    }
    
    
    @IBAction func notificationVc() {
        print("NotificationViewController")
        let vc = NotificationViewController(nibName: nil, bundle: nil)
        vc.str = str
        vc.strName = strName
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
}

class SenderExamAdd : UITapGestureRecognizer{
    
    
    var addUrls : String!
    
    
}

class viewPage : UITapGestureRecognizer{
    
    var ExamId : String!
    var EditId : String!
}


class deletessss : UITapGestureRecognizer{
    
    
    var startDate : String!
    
    var endDate : String!
    var ExamId : String!
    
    var examName : String!
    
    
}
