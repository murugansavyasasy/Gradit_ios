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
class SenderExmainationHomePageViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UISearchBarDelegate {
    
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
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var changeRolesView: UIView!
    
    @IBOutlet weak var reusee: ReuseView!
    @IBOutlet weak var SwipeUpTop: NSLayoutConstraint!
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
    
    
    @IBOutlet weak var swipeMenuHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var swipeMenu: UIView!
    
    
    
    @IBOutlet weak var arrowImg: UIImageView!
    
    
    
    @IBOutlet weak var downView: UIView!
    
    
    
    @IBOutlet weak var menuImg: UIImageView!
    
    
    @IBOutlet weak var cv: UICollectionView!
    
    
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
    let menuIdentifier = "MenuCollectionViewCell"
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
        
        print("kljjjjjjjjj")
        
        
        PreviousAddId = PreviousAddId+1
        
        
        print("jkkkkkkk",PreviousAddId)
        
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
        clgLogoImg.sd_setImage(with: URL(string:  colgImg), placeholderImage: UIImage(named: "person.fill"))
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
        
    
        
        if priority == "p1"{
            tapBarView.backgroundColor = UIColor(named: "Principal" )
            topLabels.text = "Principal"
            
            overAllRefName()
            
        }
        
        else if priority == "p4"{
            
            topLabels.text = "Student"
            
            overAllRefName()
            
        }
        
        else if priority == "p2" {
            
            tapBarView.backgroundColor = UIColor(named: "Teaching Staff" )
            addPlusVcNextPage.backgroundColor = UIColor(named: "messagecolor")
            topLabels.text = "Hod"
            overAllRefName()
            
        }
        
        else if priority == "p5"{
            
            
            topLabels.text = "Father"
            overAllRefName()
            
            
            
        }
        
        else if priority == "p3"{
            
            tapBarView.backgroundColor = UIColor(named: "Teaching Staff" )
            addPlusVcNextPage.backgroundColor = UIColor(named: "messagecolor")
            topLabels.text = "Teacher"
            overAllRefName()
            
        }
        
        else if priority == "p6"{
            tapBarView.backgroundColor = UIColor(named: "Teaching Staff" )
            upcommingCountView.isHidden = true
            pastCountView.isHidden = true
            examTopCountView.isHidden = true
            
            topLabels.text = "NonTeaching"
            addPlusVcNextPage.isHidden = true
        }
        
        else if priority == "p7"{
            tapBarView.backgroundColor = UIColor(named: "univercityColorCod" )
            upcommingCountView.isHidden = true
            pastCountView.isHidden = true
            examTopCountView.isHidden = true
            
            topLabels.text = "Group Head"
            addPlusVcNextPage.isHidden = true
        }
        
        
        if priority == "p1" {
            
            
            print("PrincipalVieewwColor")
            view.backgroundColor = UIColor(named: "Principal" )
            
            reusee.menuImg.image = UIImage(named: "principalBigMenu")
            
        }else if priority == "p4" {
            
            print("StudentVieewwColor")
            view.backgroundColor = UIColor(named: "studentViewColors")
            
            
            reusee.menuImg.image = UIImage(named: "studentSwipeImage")
            
        } else if priority == "p3" ||  priority == "p2" {
            
            print("HooodddVieewwColor")
            view.backgroundColor = UIColor(named: "Teaching Staff")
            
            reusee.menuImg.image = UIImage(named: "HodImage")
            
        }
        else if priority == "p5"{
            
            
            
            view.backgroundColor = UIColor(named: "FatherColor")
            
            reusee.menuImg.image = UIImage(named: "StaffBigMenu")
            
            
        }
        
        
        else if priority == "p6" {
            
            print("HooodddVieewwColor")
            view.backgroundColor = UIColor(named: "Teaching Staff")
            
            reusee.menuImg.image = UIImage(named: "HodImage")
            
        }
        
        
        else if priority == "p7" {
            
            print("HooodddVieewwColor")
            view.backgroundColor = UIColor(named: "univercityColorCod")
            
            reusee.menuImg.image = UIImage(named: "UnivercityHead")
            
        }
        
      
        
        swipeMenuHeight.constant = 150
        reusee.call_back = { [self]
            (val) in
          
            
                self.swipeMenuHeight.constant =  reusee.callid
           
            print("HelloWorld544544343",reusee.callid)
            
       
        }
        
        
        
        
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
        //
        
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
    
    
    
    
    
    @IBAction func Searchfield() {
        
        
        searchbar.isHidden  = false
        searchFullView .isHidden = false
        
        
        
        
        
        
        
        
    }
    
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        
        
        
        let filtered_list : [SenderUpcommingExamDataDetails] = Mapper<SenderUpcommingExamDataDetails>().mapArray(JSONString: cloneList.toJSONString()!)!
        
        
        if !searchText.isEmpty{
            
            
            
            upcomings = filtered_list.filter {
                
          
                
                $0.examname.lowercased().contains(searchText.lowercased()) || $0.createdbyname.lowercased().contains(searchText.lowercased()) || $0.startdate.lowercased().contains(searchText.lowercased())  || $0.startdate.lowercased().contains(searchText.lowercased()) || $0.headerid.lowercased().contains(searchText.lowercased()) || $0.createdon.lowercased().contains(searchText.lowercased())
                
                
                
            }
     
            
        }else{
            
            
            
            upcomings = filtered_list
            
            
            
            print("pendingOrder")
            
            
            
        }
    
        
        if upcomings.count > 0{
            
            
            
            print ("searchListPendigCount",upcomings.count)
            
            
            
        }else{
            
    
            
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
            }
            
            else if priority == "p1" {
                
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
                
            }
            
            
            
            else if priority == "p2"{
                
                
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
                
                
                
            }
            
            else if priority == "p7"{
                
                
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
        
        
        if is_read_enabled == "1"{
            if priority == "p1"{
                
                if examSegmentName.selectedSegmentIndex == 0{
                    
                    selectedCell = IndexPath()
                    upcommingRefName()
              }
                else if examSegmentName.selectedSegmentIndex == 1 {
                    selectedCell = IndexPath()
                    pastRefName()
                    
                   
                }
                
            }
            
            else if priority == "p2" || priority == "p3"{
                
                
                if examSegmentName.selectedSegmentIndex == 0{
                    
                    selectedCell = IndexPath()
                    upcommingRefName()
                    
               }
                else if examSegmentName.selectedSegmentIndex == 1 {
                    selectedCell = IndexPath()
                    pastRefName()
                    
                    
                    
                }
            }
            
            else if  priority == "p6"{
                
                
                if examSegmentName.selectedSegmentIndex == 0{
                    
                    selectedCell = IndexPath()
                    upcommingRefName()
                    
              }
                else if examSegmentName.selectedSegmentIndex == 1 {
                    selectedCell = IndexPath()
                    pastRefName()
                    
                    
                }
                
                
            }
            
            
            
            
            else if  priority == "p7"{
                
                
                if examSegmentName.selectedSegmentIndex == 0{
                    
                    selectedCell = IndexPath()
                    upcommingRefName()
                   
                }
                else if examSegmentName.selectedSegmentIndex == 1 {
                    selectedCell = IndexPath()
                    pastRefName()
                    
                  
                }
                
                
            }
        }else{
            
            
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if examSegmentName.selectedSegmentIndex == 0 {
            return upcomings.count
        }
        
        
        else if examSegmentName.selectedSegmentIndex == 1 {
            
            
            return pasts.count
            
            
        }
        
        return 0
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifiers, for: indexPath) as!
        
        SenderExaminationTableViewCell
        
        
        
        if let selectedCells = selectedCell, selectedCells == indexPath {
            
            
            
            cell.startDate.isHidden = false
            cell.endDate.isHidden = false
            cell.cellSendByLabel.isHidden = false
            cell.startDfaultLabel.isHidden = false
            cell.arrowImageVIew.isHidden = true
            cell.VenuColonLabel.isHidden = false
            cell.endDefaultLabel.isHidden = false
            cell.syllabusColonLabel.isHidden = false
            cell.sendByView.isHidden = false
            
        }
        
        else{
            
            cell.startDate.isHidden = true
            cell.cellSendByLabel.isHidden = true
            cell.endDate.isHidden = true
            cell.startDfaultLabel.isHidden = true
            cell.arrowImageVIew.isHidden = false
            cell.VenuColonLabel.isHidden = true
            cell.endDefaultLabel.isHidden = true
            cell.syllabusColonLabel.isHidden = true
            cell.sendByView.isHidden = true
            
        }
        
        
        
        
        if examSegmentName.selectedSegmentIndex == 0{
            
            
            
            let upcom : SenderUpcommingExamDataDetails = upcomings[indexPath.row]
            
            let a = upcom.createdbyname.count*2
            let b = a+150
            cell.sendbyViewWidth.constant = CGFloat(b)
            cell.cellExamDate.text = upcom.createdon
            cell.cellSendByLabel.text = upcom.createdbyname
            cell.cellExamName.text = upcom.examname.capitalized
            cell.startDate.text = upcom.startdate
            
            cell.endDate.text = upcom.enddate
            
            if upcom.createdby == memberId{
                
                cell.deleteView.isHidden = false
                cell.editView.isHidden = false
                
            }
            
            else{
                
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
                cell.editView.isHidden = false
                
            }
            
            else{
                
                cell.deleteView.isHidden = true
                cell.editView.isHidden = true
                
                
            }
            
            let a = past.createdbyname.count*2
            let b = a+150
            cell.sendbyViewWidth.constant = CGFloat(b)
            //            
            cell.cellExamDate.text = past.createdon
            cell.cellSendByLabel.text = past.createdbyname
            cell.cellExamName.text = past.examname.capitalized
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
                
                
                
                
                
                let editDeltes = editDeleteModal()
                
                editDeltes.collegeid = colgId
                editDeltes.startdate = gesture.startDate
                editDeltes.enddate = gesture.endDate
                editDeltes.examid = gesture.ExamId
                editDeltes.staffid = memberId
                editDeltes.examname = gesture.examName
                editDeltes.processtype = "delete"
                editDeltes.sectiondetails = []
                
                
                
                let editDeltesStr = editDeltes.toJSONString()
                
                
                print("gtrrrrr",editDeltesStr)
                
                EditAndDeleteRequest.call_request(param: editDeltesStr!){ [self]
                    
                    (res) in
                    
                    
                    let editDeltesResp : EditAndDeletResponce =
                    Mapper<EditAndDeletResponce>().map(JSONString: res)!
                    
                    editAndDeletRef = editDeltesResp.data
                    
                    if editDeltesResp.Status == 1{
                        
                        
                        
                        
                        
                        let refreshAlert = UIAlertController(title: "", message: editDeltesResp.Message, preferredStyle: UIAlertController.Style.alert)
                        
                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                            
                            
                            
                        }))
                        
                        
                        
                        present(refreshAlert, animated: true, completion: nil)
                        
                        
                        examTableView.delegate = self
                        examTableView.dataSource = self
                        
                        examTableView.reloadData()
                        
                        
                        upcommingRefName()
                        
                    }
                    
                    else{
                        
                        
                        let refreshAlert = UIAlertController(title: "", message: editDeltesResp.Message, preferredStyle: UIAlertController.Style.alert)
                        
                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                            
                            
                            
                        }))
                        
                        
                        
                        present(refreshAlert, animated: true, completion: nil)
                        
                        examTableView.delegate = self
                        examTableView.dataSource = self
                        examTableView.reloadData()
                        
                        
                    }
                    
                    
                    
                    
                }
                
                
                
            }
            
            
            else if examSegmentName.selectedSegmentIndex == 1{
                
                
                let editDeltes = editDeleteModal()
                
                editDeltes.collegeid = colgId
                editDeltes.startdate = gesture.startDate
                editDeltes.enddate = gesture.endDate
                editDeltes.examid = gesture.ExamId
                editDeltes.staffid = memberId
                editDeltes.examname = gesture.examName
                editDeltes.processtype = "delete"
                editDeltes.sectiondetails = []
                
                
                
                let editDeltesStr = editDeltes.toJSONString()
                
                print("gtrrrrr",editDeltesStr)
                EditAndDeleteRequest.call_request(param: editDeltesStr!){ [self]
                    
                    (res) in
                    
                    
                    let editDeltesResp : EditAndDeletResponce =
                    Mapper<EditAndDeletResponce>().map(JSONString: res)!
                    
                    editAndDeletRef = editDeltesResp.data
                    
                    if editDeltesResp.Status == 1{
                        
                        
                        
                        
                        
                        let refreshAlert = UIAlertController(title: "", message: editDeltesResp.Message, preferredStyle: UIAlertController.Style.alert)
                        
                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                            
                            
                            
                        }))
                        
                        
                        
                        present(refreshAlert, animated: true, completion: nil)
                        //
                        examTableView.delegate = self
                        examTableView.dataSource = self
                        
                        examTableView.reloadData()
                        //
                        
                        
                        
                        pastRefName()
                        
                    }
                    
                    else{
                        
                        
                        let refreshAlert = UIAlertController(title: "", message: editDeltesResp.Message, preferredStyle: UIAlertController.Style.alert)
                        
                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                            
                            
                            
                        }))
                        
                        
                        
                        present(refreshAlert, animated: true, completion: nil)
                        
                        examTableView.delegate = self
                        examTableView.dataSource = self
                        examTableView.reloadData()
                        
                        
                    }
                    
                    
                    
                    
                }
                
                
                
                
            }
            
        }))
        
        
        
        refreshAlert.addAction(UIAlertAction(title: "CANCEL", style: .default, handler: { (action: UIAlertAction!) in
            
            
            
        }))
        
        present(refreshAlert, animated: true, completion: nil)
        
        
        
        
        
        
    }
    
    
    
    
    @IBAction func deltedVc(gesture :deletessss ){
        
        
        
        
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
        
        let upcoming = SenderUpcommingExamModal()
        
        upcoming.userid   = memberId
        upcoming.collegeid = colgId
        upcoming.sectionid = sectionid
        upcoming.appid    = "2"
        upcoming.priority = priority
        upcoming.type     = "upcomingexams"
        
        
        
        
        
        let upcomingStr = upcoming.toJSONString()
        
        
        SenderExamRequest.call_request(param: upcomingStr!){ [self]
            
            (res) in
            
            
            let departResp : SenderUpcommingExamResponce =
            Mapper<SenderUpcommingExamResponce>().map(JSONString: res)!
            
            
            print("order data",departResp)
            
            
            
            if departResp.Status == 1{
                
                upcomings = departResp.data
                cloneList = departResp.data
                noDataTextView.alpha = 0
                examTableView.delegate = self
                examTableView.dataSource = self
                examTableView.reloadData()
               
            }
            
            else{
                noDataTextView.alpha = 1
                
                noDataTextView.isHidden = false
                noDataLabel.text = departResp.Message
                examTableView.delegate = self
                examTableView.dataSource = self
                examTableView.reloadData()
               
            }
            
            
        }
        
        
        
        
    }
    
    
    func pastRefName() {
        
        let past = SenderPastExamModal()
        
        past.userid   = memberId
        past.collegeid = colgId
        past.sectionid = sectionid
        past.appid    = "2"
        past.priority = priority
        past.type     = "pastexams"
        
        
        
        let pastStr = past.toJSONString()
        
        
        SenderExamRequest .call_request(param: pastStr!){ [self]
            
            (res) in
            
            
            let pastResp : SenderPAstExamResponce =
            Mapper<SenderPAstExamResponce>().map(JSONString: res)!
            
            print("order data",pastResp)
            
            
            
            
            print("order data",pastResp)
            
            
            if pastResp.Status == 1{
                
                pasts = pastResp.data
                
                examTableView.delegate = self
                examTableView.dataSource = self
                
                noDataTextView.alpha = 0
                
                examTableView.reloadData()
                
                
            }
            
            else{
                
                
                noDataTextView.isHidden = false
                noDataLabel.text = pastResp.Message
                
                
            }
            
            
        }
        
        
        
        
    }
    
    func addApi(){
        
        var add = AddApiModal()
        
        let defaults = UserDefaults.standard
        var deviceToken = defaults.string(forKey:DefaultsKeys.DeviceToken )
        add.device_token = deviceToken
        add.member_id = memberId
        add.mobile_no = MobileNumber
        add.priority = priority
        add.college_id = colgId
        add.previous_add_id = PreviousAddId
        
        
        APiCallManager.shared.callApi(url: APIEndpoints.GetAddsForCollege, httpMethod: .get, queryParam: nil, requestBody: nil
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
    
    
    
    // this  part is bottom swipe view .
    
    
    
    
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            if priority == "p4" {
                switch swipeGesture.direction {
                case .right:
                    print("Swiped right")
                case .down:
                    swipeMenuHeight.constant = 150
                    
                    print("swipeMenuHeight.constant\(swipeMenuHeight.constant)")
                    
                    
                    arrowImg.image = UIImage(named: "up")
                    print("Swiped down")
                case .left:
                    print("Swiped left")
                case .up:
                    swipeMenuHeight.constant = 470
                    
                    menuImg.image = UIImage(named: "StaffBigMenu")
                    
                    
                    
                    print("swipeMenuHeight.constant\(swipeMenuHeight.constant)")
                    
                    arrowImg.image = UIImage(named: "down")
                    SwipeUpTop.constant = 30
                    print("Swiped up")
                default:
                    break
                }
            }
            
            
            else if priority == "p1" {
                
                
                switch swipeGesture.direction {
                case .right:
                    print("Swiped right")
                case .down:
                    swipeMenuHeight.constant = 150
                    
                    print("swipeMenuHeight.constant\(swipeMenuHeight.constant)")
                    
                    arrowImg.image = UIImage(named: "up")
                    print("Swiped down")
                case .left:
                    print("Swiped left")
                case .up:

                    if str.count <= 4{
                        
                        print("uiouiop")
                        swipeMenuHeight.constant = 150
                        
                    }
//
                   else if str.count  == 5{
                        
                        print("uioiuiopkjhgbjnkmjhvgyjbkn,m")
                        swipeMenuHeight.constant = 240
                        
                    }
                    else if str.count == 6{
                        
                        
                        swipeMenuHeight.constant = 240
                    }
//
                    else if str.count == 7 {
                        
                        

                        
                        swipeMenuHeight.constant = 240
                    }
                    
                    else if str.count == 8{
                        
                        
                        swipeMenuHeight.constant = 240
                    }
                    
                    else if str.count == 9{
                        
                        
                        swipeMenuHeight.constant = 300
                    }
                    else if str.count == 10{
                        
                        
                        swipeMenuHeight.constant = 300
                    }
                    
                    
                    else if str.count == 11{
                        
                        
                        swipeMenuHeight.constant = 300
                    }
                    
                    
                    else if str.count == 12{
                        
                        
                        swipeMenuHeight.constant = 300
                    }
                    
                
                    else if str.count == 13{
                        
                        
                        swipeMenuHeight.constant = 470
                    }
                    
                    
                    else if str.count == 14{
                        
                        
                        swipeMenuHeight.constant = 470
                    }
                    
                    else if str.count == 15{
                        
                        
                        swipeMenuHeight.constant = 400
                        
                        
                    }
                    
                    else {
                        
                        
                        swipeMenuHeight.constant = 400
                        
                    }
                    
                    menuImg.image = UIImage(named: "principalBigMenu")
                    
                    
                    print("swipeMenuHeight.constant\(swipeMenuHeight.constant)")
                    
                    arrowImg.image = UIImage(named: "down")
                    print("Swiped up")
                default:
                    break
                }
                
                
            }
            
            else if priority == "p2" || priority == "p3" {
                
                print("HooodddVieewwColor")
                
                
                switch swipeGesture.direction {
                case .right:
                    print("Swiped right")
                case .down:
                    swipeMenuHeight.constant = 150
                    
                    print("swipeMenuHeight.constant\(swipeMenuHeight.constant)")
                    
                    menuImg.image = UIImage(named: "HodImage")
                    
                    arrowImg.image = UIImage(named: "up")
                    print("Swiped down")
                case .left:
                    print("Swiped left")
                case .up:
                   
                    if str.count <= 4{
                        
                        print("uiouiop")
                        swipeMenuHeight.constant = 150
                        
                    }
//
                   else if str.count  == 5{
                        
                        print("uioiuiopkjhgbjnkmjhvgyjbkn,m")
                        swipeMenuHeight.constant = 240
                        
                    }
                    else if str.count == 6{
                        
                        
                        swipeMenuHeight.constant = 240
                    }
//
                    else if str.count == 7 {
                        
                        swipeMenuHeight.constant = 240
                    }
                    
                    else if str.count == 8{
                        
                        
                        swipeMenuHeight.constant = 240
                    }
                    
                    else if str.count == 9{
                        
                        
                        swipeMenuHeight.constant = 300
                    }
                    else if str.count == 10{
                        
                        
                        swipeMenuHeight.constant = 300
                    }
                    
                    
                    else if str.count == 11{
                        
                        
                        swipeMenuHeight.constant = 300
                    }
                    
                    
                    else if str.count == 12{
                        
                        
                        swipeMenuHeight.constant = 300
                    }
                    
                
                    else if str.count == 13{
                        
                        
                        swipeMenuHeight.constant = 470
                    }
                    
                    
                    else if str.count == 14{
                        
                        
                        swipeMenuHeight.constant = 470
                    }
                    
                    else if str.count == 15{
                        
                        
                        swipeMenuHeight.constant = 400
                        
                        
                    }
                    
                    else {
                        
                        
                        swipeMenuHeight.constant = 400
                        
                    }
                    print("swipeMenuHeight.constant\(swipeMenuHeight.constant)")
                    
                    arrowImg.image = UIImage(named: "down")
                    print("Swiped up")
                default:
                    break
                }
                //
            }
            
            
            else if priority == "p7" {
                
                print("HooodddVieewwColor")
                
                
                switch swipeGesture.direction {
                case .right:
                    print("Swiped right")
                case .down:
                    swipeMenuHeight.constant = 150
                    
                    print("swipeMenuHeight.constant\(swipeMenuHeight.constant)")
                    
                    menuImg.image = UIImage(named: "UnivercityHead")
                    
                    arrowImg.image = UIImage(named: "up")
                    print("Swiped down")
                case .left:
                    print("Swiped left")
                case .up:
                    if str.count <= 4{
                        
                        print("uiouiop")
                        swipeMenuHeight.constant = 150
                        
                    }
//
                   else if str.count  == 5{
                        
                      
                        swipeMenuHeight.constant = 240
                        
                    }
                    else if str.count == 6{
                        
                        
                        swipeMenuHeight.constant = 240
                    }
//
                    else if str.count == 7 {
                        
                       
                        swipeMenuHeight.constant = 240
                    }
                    
                    else if str.count == 8{
                        
                        
                        swipeMenuHeight.constant = 240
                    }
                    
                    else if str.count == 9{
                        
                        
                        swipeMenuHeight.constant = 300
                    }
                    else if str.count == 10{
                        
                        
                        swipeMenuHeight.constant = 300
                    }
                    
                    
                    else if str.count == 11{
                        
                        
                        swipeMenuHeight.constant = 300
                    }
                    
                    
                    else if str.count == 12{
                        
                        
                        swipeMenuHeight.constant = 300
                    }
                    
                
                    else if str.count == 13{
                        
                        
                        swipeMenuHeight.constant = 470
                    }
                    
                    
                    else if str.count == 14{
                        
                        
                        swipeMenuHeight.constant = 470
                    }
                    
                    else if str.count == 15{
                        
                        
                        swipeMenuHeight.constant = 400
                        
                        
                    }
                    
                    else {
                        
                        
                        swipeMenuHeight.constant = 400
                        
                    }
                    print("swipeMenuHeight.constant\(swipeMenuHeight.constant)")
                    
                    arrowImg.image = UIImage(named: "down")
                    print("Swiped up")
                default:
                    break
                }
                //
            }
            
            else if priority == "p5"{
                switch swipeGesture.direction {
                case .right:
                    print("Swiped right")
                case .down:
                    swipeMenuHeight.constant = 170
                    
                    print("swipeMenuHeight.constant\(swipeMenuHeight.constant)")
                    
                    
                    arrowImg.image = UIImage(named: "up")
                    print("Swiped down")
                case .left:
                    print("Swiped left")
                case .up:
                    swipeMenuHeight.constant = 470
                    
                    print("swipeMenuHeight.constant\(swipeMenuHeight.constant)")
                    
                    arrowImg.image = UIImage(named: "down")
                    print("Swiped up")
                default:
                    break
                }
                //
                
                
                
            }
            
            
            else if priority == "p6"{
                
                switch swipeGesture.direction {
                case .right:
                    print("Swiped right")
                case .down:
                    swipeMenuHeight.constant = 150
                    
                    print("swipeMenuHeight.constant\(swipeMenuHeight.constant)")
                    
                    menuImg.image = UIImage(named: "HodImage")
                    
                    arrowImg.image = UIImage(named: "up")
                    print("Swiped down")
                case .left:
                    print("Swiped left")
                case .up:
                    
                    if str.count <= 4{
                        
                        print("uiouiop")
                        swipeMenuHeight.constant = 150
                        
                    }
//
                   else if str.count  == 5{
                        
                        print("uioiuiopkjhgbjnkmjhvgyjbkn,m")
                        swipeMenuHeight.constant = 240
                        
                    }
                    else if str.count == 6{
                        
                        
                        swipeMenuHeight.constant = 240
                    }
//
                    else if str.count == 7 {
                        
                        swipeMenuHeight.constant = 240
                    }
                    
                    else if str.count == 8{
                        
                        
                        swipeMenuHeight.constant = 240
                    }
                    
                    else if str.count == 9{
                        
                        
                        swipeMenuHeight.constant = 300
                    }
                    else if str.count == 10{
                        
                        
                        swipeMenuHeight.constant = 300
                    }
                    
                    
                    else if str.count == 11{
                        
                        
                        swipeMenuHeight.constant = 300
                    }
                    
                    
                    else if str.count == 12{
                        
                        
                        swipeMenuHeight.constant = 300
                    }
                    
                
                    else if str.count == 13{
                        
                        
                        swipeMenuHeight.constant = 470
                    }
                    
                    
                    else if str.count == 14{
                        
                        
                        swipeMenuHeight.constant = 470
                    }
                    
                    else if str.count == 15{
                        
                        
                        swipeMenuHeight.constant = 400
                        
                        
                    }
                    
                    else {
                        
                        
                        swipeMenuHeight.constant = 400
                        
                    }
                    print("swipeMenuHeight.constant\(swipeMenuHeight.constant)")
                    
                    arrowImg.image = UIImage(named: "down")
                    print("Swiped up")
                default:
                    break
                }
                //
                
            }
            
        }
        
    }
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print("loginass",loginType)
        
        if priority == "p4"{
            
            print("stu",strName.count)
            return strName.count
        }
        
        else if priority == "p1"{
            
            print("Prin",strName.count)
            return strName.count
            
        }
        
        
        else if priority == "p2" || priority == "p3"{
            
            print("Teach",strName.count)
            return strName.count
        }
        
        else if priority == "p5"{
            
            print("father",strName.count)
            return strName.count
            
        }
        
        
        else if priority == "p6"{
            
            print("father",strName.count)
            return strName.count
            
        }
        
        
        else if priority == "p7"{
            
            print("father",strName.count)
            return strName.count
            
        }
        
        
        return 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: menuIdentifier , for: indexPath) as! MenuCollectionViewCell
        
        
        if priority == "p4"{
            
            
            cell.menuNameLbl.text = strName[indexPath.row]
            
            cell.menuImg.image = UIImage(named: String(str[indexPath.row]))
            
            
            
        }
        
        else if priority == "p1"{
            
            
            cell.menuNameLbl.text = strName[indexPath.row]
            
            cell.menuImg.image = UIImage(named: String(str[indexPath.row]))
            
            
        }
        
        
        else if priority == "p2" || priority == "p3"{
            
            cell.menuNameLbl.text = strName[indexPath.row]
            
            cell.menuImg.image = UIImage(named: String(str[indexPath.row]))
            
            
            
            
        }
        
        else if priority == "p7"{
            
            cell.menuNameLbl.text = strName[indexPath.row]
            
            cell.menuImg.image = UIImage(named: String(str[indexPath.row]))
            
            
            
            
        }
        
        else if priority == "p5"{
            
            
            cell.menuNameLbl.text = strName[indexPath.row]
            
            cell.menuImg.image = UIImage(named: String(str[indexPath.row]))
            
            
            
        }
        
        
        
        else if priority == "p6"{
            
            cell.menuNameLbl.text = strName[indexPath.row]
            
            cell.menuImg.image = UIImage(named: String(str[indexPath.row]))
            
            
            
        }
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 4, height: 80)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let stud : menuApiDataDetails =  DefaultsKeys.MenuRefName[indexPath.row]
        let read = String(stud.is_read_enabled)
        let write =  String(stud.is_write_enabled)

        
        
        if priority == "p1"{
            
            
            
            if str[indexPath.row] == "home"{
                
                
                
                let vc = HomeScreenViewController(nibName: nil, bundle: nil)
                let currentController = self.getCurrentViewController()
                vc.view.backgroundColor = UIColor(named: "Principal" )
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: false, completion: nil)
                
                
                
            }
            
            
            
            else if str[indexPath.row] == "voice"{
                
                
                let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
                let currentController = self.getCurrentViewController()
                vc.is_read_enabled = read
                vc.is_write_enabled = write
               
                vc.view.backgroundColor = UIColor(named: "Principal" )
                vc.CommuniSegementName.backgroundColor = UIColor(named: "UnSelector")
                vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "Selector")
                vc.ComunimenuId = communicationId
                vc.str = str
                vc.strName = strName
                
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: false, completion: nil)
                
            }
            
            else if str[indexPath.row] == "text"{
                
                
                let vc = CommuniSMSViewController(nibName: nil, bundle: nil)
                let currentController = self.getCurrentViewController()
                vc.is_read_enabled = read
                vc.is_write_enabled = write
               
                vc.view.backgroundColor = UIColor(named: "Principal" )
                vc.CommuniSegementName.backgroundColor = UIColor(named: "UnSelector")
                vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "Selector")
                vc.ComunimenuId = communicationId
                vc.str = str
                vc.strName = strName
                
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: false, completion: nil)
                
            }
            
            else if str[indexPath.row] == "examination"{
                
                
                let vc = SenderExmainationHomePageViewController(nibName: nil, bundle: nil)
                let currentController = self.getCurrentViewController()
                vc.is_read_enabled = read
                vc.is_write_enabled = write
               
                vc.view.backgroundColor = UIColor(named: "Principal" )
                vc.examSegmentName.backgroundColor = UIColor(named: "UnSelector")
                vc.examSegmentName.selectedSegmentTintColor = UIColor(named: "Selector")
                vc.str = str
                vc.strName = strName
                
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: false, completion: nil)
                
                
            }
            
            
            
            else if str[indexPath.row] == "attendance"{
                
                
                
                let vc =  SenderAttendanceVcViewController(nibName: nil, bundle: nil)
                let currentController = self.getCurrentViewController()
                vc.is_read_enabled = read
                vc.is_write_enabled = write
               
                vc.view.backgroundColor = UIColor(named: "Principal" )
                vc.segmentName.backgroundColor = UIColor(named: "UnSelector")
                vc.segmentName.selectedSegmentTintColor = UIColor(named: "Selector")
                vc.str = str
                vc.strName = strName
               
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: false, completion: nil)
                
                
            }
            
            
            else if str[indexPath.row] == "assignment"{
                
                
                let vc = SenderAssigmentHomePageViewController(nibName: nil, bundle: nil)
                let currentController = self.getCurrentViewController()
                vc.is_read_enabled = read
                vc.is_write_enabled = write
               
                vc.view.backgroundColor = UIColor(named: "Principal" )
                vc.assigmentSegmentName.backgroundColor = UIColor(named: "UnSelector")
                vc.assigmentSegmentName.selectedSegmentTintColor = UIColor(named: "Selector")
                vc.assigmentMenuId = Assigment
                vc.str = str
                vc.strName = strName
                
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: false, completion: nil)
                
                //
            }
            
            
            else if str[indexPath.row] == "circular"{
                
                let vc = SenderImagePdfHomePageViewController(nibName: nil, bundle: nil)
                let currentController = self.getCurrentViewController()
                vc.is_read_enabled = read
                vc.is_write_enabled = write
               
                vc.view.backgroundColor = UIColor(named: "Principal" )
                vc.imageSegmentName.backgroundColor = UIColor(named: "UnSelector")
                vc.imageSegmentName.selectedSegmentTintColor = UIColor(named: "Selector")
                vc.imagePdfMenuIdType = imagePdfId
                vc.str = str
                vc.strName = strName
               
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: false, completion: nil)
                
                
            }
            
            else if str[indexPath.row] == "notice_board"{
                
                let vc = SenderGraditNoticeBoardMenuViewController(nibName: nil, bundle: nil)
                let currentController = self.getCurrentViewController()
                vc.is_read_enabled = read
                vc.is_write_enabled = write
               
                vc.view.backgroundColor = UIColor(named: "Principal" )
                vc.noticeSegments.backgroundColor = UIColor(named: "UnSelector")
                vc.noticeSegments.selectedSegmentTintColor = UIColor(named: "Selector")
                vc.menuTypessww = NoticeBoardId
                vc.str = str
                vc.strName = strName
               
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: false, completion: nil)
                
                
            }
            
            
            
            else if str[indexPath.row] == "events"{
                
                
                let vc = SenderEventHomePageViewController(nibName: nil, bundle: nil)
                let currentController = self.getCurrentViewController()
                vc.is_read_enabled = read
                vc.is_write_enabled = write
               
                vc.view.backgroundColor = UIColor(named: "Principal" )
                vc.eventSegmentName.backgroundColor = UIColor(named: "UnSelector")
                vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "Selector")
                vc.EventMenuId = EventId
                vc.str = str
                vc.strName = strName
               
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: false, completion: nil)
                
                
            }
            
            
            
            else if str[indexPath.row] == "faculty"{
                
                print("faculty is clicked")
                
                let vc = SenderFacultyViewController(nibName: nil, bundle: nil)
                vc.is_read_enabled = read
                vc.is_write_enabled = write
               
                vc.view.backgroundColor = UIColor(named: "Principal" )
                vc.str = str
                vc.strName = strName
               
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false, completion: nil)
                
                
            }
            
            else if str[indexPath.row] == "video"{
                
                
                let vc = SenderVideoHomePageViewController(nibName: nil, bundle: nil)
                let currentController = self.getCurrentViewController()
                vc.is_read_enabled = read
                vc.is_write_enabled = write
               
                vc.view.backgroundColor = UIColor(named: "Principal" )
                vc.videoId = videoId
                vc.str = str
                vc.strName = strName
               
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: false, completion: nil)
                
                
            }
            
            
            else if str[indexPath.row] == "chat"{
                
                
                print("chat is clicked ")
                
                
                let vc =  ChatSenderViewController(nibName: nil, bundle: nil)
                vc.is_read_enabled = read
                vc.is_write_enabled = write
               
                vc.view.backgroundColor = UIColor(named: "Principal" )
                vc.str = str
                vc.strName = strName
               
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false, completion: nil)
                
                
            }
            
            
        }
        
        
        else if priority == "p2" || priority == "p3"{
            
            if str[indexPath.row] == "home"{
                
                
                
                let vc = HomeScreenViewController(nibName: nil, bundle: nil)
                let currentController = self.getCurrentViewController()
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: false, completion: nil)
                
                
                
            }
            
            
            
            else if str[indexPath.row] == "voice"{
                
                
                let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
                vc.is_read_enabled = read
                vc.is_write_enabled = write
               
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
                vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                vc.ComunimenuId = communicationId
                vc.str = str
                vc.strName = strName
                
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false, completion: nil)
                
            }
            
            else if str[indexPath.row] == "text"{
                
                
                let vc = CommuniSMSViewController(nibName: nil, bundle: nil)
                vc.is_read_enabled = read
                vc.is_write_enabled = write
               
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
                vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                vc.ComunimenuId = communicationId
                vc.str = str
                vc.strName = strName
                
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false, completion: nil)
                
            }
            
            else if str[indexPath.row] == "examination"{
                
                
                let vc = SenderExmainationHomePageViewController(nibName: nil, bundle: nil)
                vc.is_read_enabled = read
                vc.is_write_enabled = write
               
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.examSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                vc.examSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                vc.str = str
                vc.strName = strName
               vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false, completion: nil)
                
                
            }
            
            
            
            else if str[indexPath.row] == "attendance"{
                
                
                let vc =  SenderAttendanceVcViewController(nibName: nil, bundle: nil)
                let currentController = self.getCurrentViewController()
                vc.is_read_enabled = read
                vc.is_write_enabled = write
               
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.segmentName.backgroundColor = UIColor(named: "HodUnSelector")
                vc.segmentName.selectedSegmentTintColor = UIColor(named: "HodUnSelector")
                vc.str = str
                vc.strName = strName
               
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: false, completion: nil)
                
                
                
            }
            
            
            else if str[indexPath.row] == "assignment"{
                
                
                let vc = SenderAssigmentHomePageViewController(nibName: nil, bundle: nil)
                vc.is_read_enabled = read
                vc.is_write_enabled = write
               
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.assigmentSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                vc.assigmentSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                vc.assigmentMenuId = Assigment
                vc.str = str
                vc.strName = strName
               
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false, completion: nil)
                //
            }
            
            
            else if str[indexPath.row] == "circular"{
                
                let vc = SenderImagePdfHomePageViewController(nibName: nil, bundle: nil)
                vc.is_read_enabled = read
                vc.is_write_enabled = write
               
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.imageSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                vc.imageSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                vc.imagePdfMenuIdType = imagePdfId
                vc.str = str
                vc.strName = strName
                
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false, completion: nil)
                
            }
            
            else if str[indexPath.row] == "notice_board"{
                
                let vc = SenderGraditNoticeBoardMenuViewController(nibName: nil, bundle: nil)
                vc.is_read_enabled = read
                vc.is_write_enabled = write
               
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.noticeSegments.backgroundColor = UIColor(named: "HodUnSelector")
                vc.noticeSegments.selectedSegmentTintColor = UIColor(named: "HodSelector")
                vc.menuTypessww = NoticeBoardId
                vc.str = str
                vc.strName = strName
               
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false, completion: nil)
                
            }
            
            
            
            else if str[indexPath.row] == "events"{
                
                
                let vc = SenderEventHomePageViewController(nibName: nil, bundle: nil)
                vc.is_read_enabled = read
                vc.is_write_enabled = write
               
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.eventSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                vc.EventMenuId = EventId
                vc.str = str
                vc.strName = strName
                
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false, completion: nil)
                
            }
            
            
            
            else if str[indexPath.row] == "faculty"{
                
                let vc = SenderFacultyViewController(nibName: nil, bundle: nil)
                vc.is_read_enabled = read
                vc.is_write_enabled = write
               
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.str = str
                vc.strName = strName
               
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false, completion: nil)
                
                
                
            }
            
            else if str[indexPath.row] == "video"{
                
                
                let vc = SenderVideoHomePageViewController(nibName: nil, bundle: nil)
                vc.is_read_enabled = read
                vc.is_write_enabled = write
               
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                
                vc.str = str
                vc.strName = strName
                
                vc.VideoMenuId = videoId
              
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false, completion: nil)
                
            }
            
            
            else if str[indexPath.row] == "chat"{
                
                
                let vc =  ChatSenderViewController(nibName: nil, bundle: nil)
                vc.is_read_enabled = read
                vc.is_write_enabled = write
               
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.str = str
                vc.strName = strName
              
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false, completion: nil)
                
                
                
            }
            
            
            
        }
        
        
        else if priority == "p7"{
            
            if str[indexPath.row] == "home"{
                
                
                
                let vc = HomeScreenViewController(nibName: nil, bundle: nil)
                let currentController = self.getCurrentViewController()
                vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
                
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: false, completion: nil)
                
                
                
            }
            
            
            
            else if str[indexPath.row] == "voice"{
                
                
                let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
                vc.is_read_enabled = read
                vc.is_write_enabled = write
               
                vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
                vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
                vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                vc.ComunimenuId = communicationId
                vc.str = str
                vc.strName = strName
                
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false, completion: nil)
                
            }
            
            else if str[indexPath.row] == "text"{
                
                
                let vc = CommuniSMSViewController(nibName: nil, bundle: nil)
                vc.is_read_enabled = read
                vc.is_write_enabled = write
               
                vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
                vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
                vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                vc.ComunimenuId = communicationId
                vc.str = str
                vc.strName = strName
                
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false, completion: nil)
                
            }
            
            
            
            else if str[indexPath.row] == "examination"{
                
                
                let vc = SenderExmainationHomePageViewController(nibName: nil, bundle: nil)
                vc.is_read_enabled = read
                vc.is_write_enabled = write
               
                vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
                vc.examSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                vc.examSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                vc.str = str
                vc.strName = strName
              
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false, completion: nil)
                
                
            }
            
            
            
            else if str[indexPath.row] == "attendance"{
                
                
                let vc =  SenderAttendanceVcViewController(nibName: nil, bundle: nil)
                
                let currentController = self.getCurrentViewController()
                vc.is_read_enabled = read
                vc.is_write_enabled = write
               
                vc.view.backgroundColor = UIColor(named: "univercityColorCodf" )
                vc.segmentName.backgroundColor = UIColor(named: "HodUnSelector")
                vc.segmentName.selectedSegmentTintColor = UIColor(named: "HodUnSelector")
                vc.str = str
                vc.strName = strName
               
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: false, completion: nil)
                
                
                
            }
            
            
            else if str[indexPath.row] == "assignment"{
                
                
                let vc = SenderAssigmentHomePageViewController(nibName: nil, bundle: nil)
                vc.is_read_enabled = read
                vc.is_write_enabled = write
               
                vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
                vc.assigmentSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                vc.assigmentSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                vc.assigmentMenuId = Assigment
                vc.str = str
                vc.strName = strName
               
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false, completion: nil)
                //
            }
            
            
            else if str[indexPath.row] == "circular"{
                
                let vc = SenderImagePdfHomePageViewController(nibName: nil, bundle: nil)
                vc.is_read_enabled = read
                vc.is_write_enabled = write
               
                vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
                vc.imageSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                vc.imageSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                vc.imagePdfMenuIdType = imagePdfId
                vc.str = str
                vc.strName = strName
               
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false, completion: nil)
                
            }
            
            else if str[indexPath.row] == "notice_board"{
                
                let vc = SenderGraditNoticeBoardMenuViewController(nibName: nil, bundle: nil)
                vc.is_read_enabled = read
                vc.is_write_enabled = write
               
                vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
                vc.noticeSegments.backgroundColor = UIColor(named: "HodUnSelector")
                vc.noticeSegments.selectedSegmentTintColor = UIColor(named: "HodSelector")
                vc.menuTypessww = NoticeBoardId
                vc.str = str
                vc.strName = strName
                
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false, completion: nil)
                
            }
            
            
            
            else if str[indexPath.row] == "events"{
                
                
                let vc = SenderEventHomePageViewController(nibName: nil, bundle: nil)
                vc.is_read_enabled = read
                vc.is_write_enabled = write
               
                vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
                vc.eventSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                vc.EventMenuId = EventId
                vc.str = str
                vc.strName = strName
               
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false, completion: nil)
                
            }
            
            
            
            else if str[indexPath.row] == "faculty"{
                
                let vc = SenderFacultyViewController(nibName: nil, bundle: nil)
                vc.is_read_enabled = read
                vc.is_write_enabled = write
               
                vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
                vc.str = str
                vc.strName = strName
                
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false, completion: nil)
                
                
                
            }
            
            else if str[indexPath.row] == "video"{
                
                
                let vc = SenderVideoHomePageViewController(nibName: nil, bundle: nil)
                vc.is_read_enabled = read
                vc.is_write_enabled = write
               
                vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
                
                vc.str = str
                vc.strName = strName
                
                vc.VideoMenuId = videoId
              
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false, completion: nil)
                
            }
            
            
            else if str[indexPath.row] == "chat"{
                
                
                let vc =  ChatSenderViewController(nibName: nil, bundle: nil)
                vc.is_read_enabled = read
                vc.is_write_enabled = write
               
                vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
                vc.str = str
                vc.strName = strName
              
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false, completion: nil)
                
                
                
            }
            
            
            
        }
        
        
        
        
        else if priority == "p6"{
            
            if str[indexPath.row] == "home"{
                
                
                
                let vc = HomeScreenViewController(nibName: nil, bundle: nil)
                let currentController = self.getCurrentViewController()
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: false, completion: nil)
                
                
                
            }
            
            
            
            else if str[indexPath.row] == "voice"{
                
                
                let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
                vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                vc.ComunimenuId = communicationId
                vc.str = str
                vc.strName = strName
                
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false, completion: nil)
                
            }
            
            else if str[indexPath.row] == "text"{
                
                
                let vc = CommuniSMSViewController(nibName: nil, bundle: nil)
                vc.is_read_enabled = read
                vc.is_write_enabled = write
             
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
                vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                vc.ComunimenuId = communicationId
                vc.str = str
                vc.strName = strName
                
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false, completion: nil)
                
            }
            
            
            else if str[indexPath.row] == "examination"{
                
                
                let vc = SenderExmainationHomePageViewController(nibName: nil, bundle: nil)
                vc.is_read_enabled = read
                vc.is_write_enabled = write
               
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.examSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                vc.examSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                vc.str = str
                vc.strName = strName
               
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false, completion: nil)
                
                
            }
            
            
            
            else if str[indexPath.row] == "attendance"{
                
                
                let vc =  SenderAttendanceVcViewController(nibName: nil, bundle: nil)
                let currentController = self.getCurrentViewController()
                vc.is_read_enabled = read
                vc.is_write_enabled = write
               
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.segmentName.backgroundColor = UIColor(named: "HodUnSelector")
                vc.segmentName.selectedSegmentTintColor = UIColor(named: "HodUnSelector")
                vc.str = str
                vc.strName = strName
               
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: false, completion: nil)
                
                
                
            }
            
            
            else if str[indexPath.row] == "assignment"{
                
                
                let vc = SenderAssigmentHomePageViewController(nibName: nil, bundle: nil)
                vc.is_read_enabled = read
                vc.is_write_enabled = write
               
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.assigmentSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                vc.assigmentSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                vc.assigmentMenuId = Assigment
                vc.str = str
                vc.strName = strName
                
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false, completion: nil)
                //
            }
            
            
            else if str[indexPath.row] == "circular"{
                
                let vc = SenderImagePdfHomePageViewController(nibName: nil, bundle: nil)
                vc.is_read_enabled = read
                vc.is_write_enabled = write
               
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.imageSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                vc.imageSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                vc.imagePdfMenuIdType = imagePdfId
                vc.str = str
                vc.strName = strName
               
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false, completion: nil)
                
            }
            
            else if str[indexPath.row] == "notice_board"{
                
                let vc = SenderGraditNoticeBoardMenuViewController(nibName: nil, bundle: nil)
                vc.is_read_enabled = read
                vc.is_write_enabled = write
               
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.noticeSegments.backgroundColor = UIColor(named: "HodUnSelector")
                vc.noticeSegments.selectedSegmentTintColor = UIColor(named: "HodSelector")
                vc.menuTypessww = NoticeBoardId
                vc.str = str
                vc.strName = strName
               
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false, completion: nil)
                
            }
            
            
            
            else if str[indexPath.row] == "events"{
                
                
                let vc = SenderEventHomePageViewController(nibName: nil, bundle: nil)
                vc.is_read_enabled = read
                vc.is_write_enabled = write
               
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.eventSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                vc.EventMenuId = EventId
                vc.str = str
                vc.strName = strName
             
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false, completion: nil)
                
            }
            
            
            
            else if str[indexPath.row] == "faculty"{
                
                let vc = SenderFacultyViewController(nibName: nil, bundle: nil)
                vc.str = str
                vc.strName = strName
                
                vc.is_read_enabled = read
                vc.is_write_enabled = write
               
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false, completion: nil)
                
                
                
            }
            
            else if str[indexPath.row] == "video"{
                
                
                let vc = SenderVideoHomePageViewController(nibName: nil, bundle: nil)
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                
                vc.VideoMenuId = videoId
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = read
                vc.is_write_enabled = write
               
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false, completion: nil)
                
            }
            
            
            else if str[indexPath.row] == "chat"{
                
                
                let vc =  ChatSenderViewController(nibName: nil, bundle: nil)
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.str = str
                vc.strName = strName
                
                vc.is_read_enabled = read
                vc.is_write_enabled = write
               
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false, completion: nil)
                
                
                
            }
        }
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
