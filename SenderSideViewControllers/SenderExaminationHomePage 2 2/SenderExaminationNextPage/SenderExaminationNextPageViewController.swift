//
//  SenderExaminationNextPageViewController.swift
//  GraditSenderExaminationMenu
//
//  Created by MACBOOKPRO on 03/12/22.
//

import UIKit
import WebKit
import ObjectMapper
import KRProgressHUD

@available(iOS 16.0, *)
class SenderExaminationNextPageViewController: UIViewController, UITableViewDelegate,UITableViewDataSource{
    
    
    @IBOutlet weak var topNameview: UIView!
    @IBOutlet weak var tapBarView: UIViewX!
    @IBOutlet weak var clearCacheView: UIView!
    @IBOutlet weak var noDataLabel: UILabel!
    @IBOutlet weak var nodataView: UIView!
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var countView: UIViewX!
    @IBOutlet weak var redirectLoginView: UIViewX!
    
    
    @IBOutlet weak var tv: UITableView!
    
    
    @IBOutlet weak var smallImg: UIImageView!
    @IBOutlet weak var bigImg: UIImageView!
    @IBOutlet weak var profileView: UIView!
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
    
    
    @IBOutlet weak var loginView: UIView!
    
    @IBOutlet weak var refreshView: UIView!
    
    @IBOutlet weak var notificationView: UIView!
    
    
    @IBOutlet weak var privacyPolicyView: UIView!
    
    
    var identifer = "ExamViewPageTvTableViewCell"
    
    var examViewRefName : [examviewDataDetails] = []
    var addapiRef : [AddDataDeatils] = []
    
    var memberId : String!
    var colgId : String!
    var examId : String!
    var exameName : String!
    var sectionid : String!
    var departmentId : String!
    var loginType : String!
    var memberName : String!
    var colgImg : String!
    var priority : String!
    
    var mobileNumber : String!
    
    
    var loginDatas : [datalogin]!
    var logindataprinci :[datalogin]!
    
    
    let menuIdentifier = "MenuCollectionViewCell"
    var MenuRefName :[menuApiDataDetails] = []
    var password : String!
    var EditId : String!
    @IBOutlet weak var swipeMenuHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var swipeMenu: UIView!
    
    
    @IBOutlet weak var reusee: ReuseView!
    
    @IBOutlet weak var arrowImg: UIImageView!
    
    
    
    @IBOutlet weak var downView: UIView!
    
    
    
    @IBOutlet weak var menuImg: UIImageView!
    
    
    @IBOutlet weak var cv: UICollectionView!
    
    var str : [String] = []
    
    var strName : [String] = []
    var is_read_enabled = ""
    var is_write_enabled = ""
    
    
    
    var NoticeBoardId = "1"
    var videoId = "2"
    var EventId = "3"
    var communicationId = "4"
    var imagePdfId = "5"
    var Assigment = "6"
    
    var PreviousAddId : Int = 0
    
    
    var ExameSection : [examViewSubjectDataDetails] = []
    
    var examEditresp : [exameEditMainDetail] = []
    var examEditsModalApi : [EditSubjectDetailsRef] = []
    var examEditsModal : [EditSubjectDetailsRef] = []
    
    
    var addImageBackGroundurl : String!
    var addUrls : String!
    
    var smallimagUrl : String!
    
    
    
    
    var examEditresp1 : [exameEditMainDetail] = []
    var examEditsModalApi1 : [EditSubjectDetailsRef] = []
    var examEditsModal1 : [EditSubjectDetailsRef] = []
    
    override func viewDidAppear(_ animated: Bool) {
        
        print("kljjjjjjjjj")
        
        
        PreviousAddId = PreviousAddId+1
        
//        addApi()
        
        print("jkkkkkkk",PreviousAddId)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nodataView.isHidden = true
        noDataLabel.isHidden = true
        countView.isHidden = true
        sideMenuView.isHidden = true
        
        
        print("ifdfgfdvcdsvcx",examId)
        let defaults = UserDefaults.standard
        
        memberId = defaults.string(forKey: DefaultsKeys.memberid)
        
        colgId = defaults.string(forKey: DefaultsKeys.collegeid)
        priority = defaults.string(forKey: DefaultsKeys.priority)
        
        sectionid  = defaults.string(forKey: DefaultsKeys.sectionid)
        departmentId = defaults.string(forKey: DefaultsKeys.deptid)
        loginType = defaults.string(forKey: DefaultsKeys.loginAsType)
        memberName = defaults.string(forKey: DefaultsKeys.memberName)
        mobileNumber = defaults.string(forKey: DefaultsKeys.mobileNumber)
        colgImg = defaults.string(forKey: DefaultsKeys.colglogo)
        clgLogoImg.sd_setImage(with: URL(string:  colgImg), placeholderImage: UIImage(named: "person.fill"))
        
        password = defaults.string(forKey: DefaultsKeys.Password)
        
        topMessageLabel.text = memberName
        if priority == "p1"{
            tapBarView.backgroundColor = UIColor(named: "Principal" )
            topLabels.text = "Principal"
            
        }
        
        else if priority == "p4"{
            tapBarView.backgroundColor = UIColor(named: "studentViewColors" )
            topLabels.text = "Student"
            
        }
        
        else if priority == "p2" {
            tapBarView.backgroundColor = UIColor(named: "Teaching Staff" )
            
            topLabels.text = "Hod"
            
        }
        
        else if priority == "p5"{
            
            tapBarView.backgroundColor = UIColor(named: "FatherColor" )
            topLabels.text = "Father"
            
            
            
        }
        
        else if priority == "p3"{
            tapBarView.backgroundColor = UIColor(named: "Teaching Staff" )
            topLabels.text = "Teacher"
            
        }
        
        else if priority == "p6"{
            tapBarView.backgroundColor = UIColor(named: "Teaching Staff" )
            topLabels.text = "NonTeaching"
            
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
        
   
        swipeMenuHeight.constant = 150
                reusee.call_back = { [self]
                    (val) in
                  
                    
                        self.swipeMenuHeight.constant =  reusee.callid
                   
             print("HelloWorld544544343",reusee.callid)
                    
               
                }
        
        
    
        addApi()
        
        examViewPage()
        
        let rowNib = UINib(nibName: identifer, bundle: nil)
        tv.register(rowNib, forCellReuseIdentifier: identifer)
        
        
        
        // tap Bar UiTapGuster.
        
        
        let loginRediectGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        redirectLoginView.addGestureRecognizer(loginRediectGesture)
        
        
        
        
        let changeRolesGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        changeRolesView.addGestureRecognizer(changeRolesGesture)
        
        let topname = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        topNameview.addGestureRecognizer(topname)
        
        
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
        
        
        let privacyPolicyGesture = UITapGestureRecognizer(target: self, action: #selector(privacyPolicyRedirect))
        privacyPolicyView.addGestureRecognizer(privacyPolicyGesture)
        
        let termsAndConditionGesture = UITapGestureRecognizer(target: self, action: #selector(termsAndCondition))
        termsAndConditionView.addGestureRecognizer(termsAndConditionGesture)
        
        let notificationGesture = UITapGestureRecognizer(target: self, action: #selector(notificationVc))
        notificationView.addGestureRecognizer(notificationGesture)
        
        let chagePassword = UITapGestureRecognizer(target: self, action: #selector(changePassowrdVC))
        changePasswordView.addGestureRecognizer(chagePassword)
        
    }
    
    
    
    @IBAction func adLoad(gesture:SenderExamAddsss){
        
        
        let vc = SenderExamAddVcViewController(nibName: nil, bundle: nil)
        
        vc.AddWebUrl = gesture.addUrls
        
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
        
        
    }
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return examViewRefName.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifer, for: indexPath) as!
        
        ExamViewPageTvTableViewCell
        
        cell.selectionStyle = .none
        let examdeatils : examviewDataDetails = examViewRefName[indexPath.row]
        
        
        cell.ClgDeprtNameLabel.text = examdeatils.clgdepartmentname
        cell.courseNameLabel.text = examdeatils.coursename
        cell.endDateLabel.text = examdeatils.enddate
        cell.examName.text = examdeatils.examnm
        cell.sectionLabel.text = examdeatils.clgsectionname
        cell.semesterNameLabel.text = examdeatils.semestername
        cell.startDateLabel.text = examdeatils.startdate
        cell.yearNameLabel.text = examdeatils.yearname
        exameName = examdeatils.examnm
        
        ExameSection = examdeatils.subjectdetails
        //        examdeatils.subjectdetails
        
        let getSubjectVc  = examdetails(target: self, action: #selector(getSubjectVcc))
        getSubjectVc.exameName =  examdeatils.subjectdetails
        cell.getSubjectView.addGestureRecognizer(getSubjectVc)
        
        //
        
        let Delete  = DeleteExam(target: self, action: #selector(DeleteExame))
        Delete.ExamId =  examdeatils.examheaderid
        Delete.sectionId = examdeatils.clgsectionid
        Delete.DepartmentId = examdeatils.clgdepartmentid
        cell.deleteView.addGestureRecognizer(Delete)
        
        
        
        let Edit  = DeleteExam(target: self, action: #selector(EditVc))
        Edit.ExamId =  examdeatils.examheaderid
        Edit.sectionId = examdeatils.clgsectionid
        //
        Edit .EndDate = examdeatils.enddate
        //
        Edit.SectionNameForEdit  = examdeatils.clgsectionname
        Edit .startDate = examdeatils.startdate
        //
        Edit.exameName = examViewRefName
        Edit.EditId  = EditId
        Edit.exameNameEdit = examdeatils.subjectdetails
        Edit.ExameNameEdit = examdeatils.examnm
        Edit.semId = examdeatils.semesterid
        
        cell.EditView.addGestureRecognizer(Edit)
        
        if EditId == "1"{
            
            
            cell.EditView.isHidden = false
            cell.deleteView.isHidden = false
            cell.getSubjectView.isHidden = true
            
            
            
            
            
            
            let modal = exameEditMainDetail()
            
            modal.processtype = "edit"
            modal.examid = examId
            
            modal.collegeid = colgId
            
            modal.staffid = memberId
            
            modal.sectionid = examdeatils.clgsectionid
            examEditresp1.append(modal)
            
            
            
            
            
            let edits = EditSubjectDetailsRef()
            for i in (0..<examdeatils.subjectdetails.count){
                
                
                edits.examdate =  examdeatils.clgsectionid + "/ " + examdeatils.subjectdetails[i].examdate
                edits.examsession =   examdeatils.clgsectionid + "/ " + examdeatils.subjectdetails[i].examsession
                edits.examsubjectid =  examdeatils.clgsectionid + "/ " + examdeatils.subjectdetails[i].examsubjectid
                
                edits.examvenue =   examdeatils.clgsectionid + "/ " + examdeatils.subjectdetails[i].examvenue
                edits.examsyllabus =    examdeatils.clgsectionid + "/ " + examdeatils.subjectdetails[i].examsyllabus
                
                print("edits.examdate",  edits.examdate,  edits.examsession,edits.examsubjectid, edits.examvenue,edits.examsyllabus)
                
                //                tttt.append(edits)
                
                examEditsModalApi1.append(edits)
                
            }
            
            
            
            
            print("examEditsModalApi1",examEditsModalApi1.count)
            
            
            print("examEditresp1",examEditresp1.count)
            
            
            
            
            
            
            
            
        }
        else{
            
            
            cell.EditView.isHidden = true
            cell.deleteView.isHidden = true
            cell.getSubjectView.isHidden = false
            
            
        }
        
        
        
        
        
        
        
        
        
        
        
        return cell
        
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return 230
        
    }
    
    
    @IBAction func EditVc(ges : DeleteExam ){
        
        
        
        //
        var tttt : [EditSubjectDetailsRef] = []
        
        var gggg : [exameEditMainDetail] = []
        
        
        let modal = exameEditMainDetail()
        
        
        modal.processtype = "edit"
        modal.examid = examId
        
        modal.collegeid = colgId
        
        modal.staffid = memberId
        
        
        
        
        modal.sectionid = ges.sectionId
        
        
        
        
        
        for i in ges.exameNameEdit{
            
            let edits = EditSubjectDetailsRef()
            
            edits.examdate =  i.examdate
            edits.examsession =  i.examsession
            edits.examsubjectid =  i.examsubjectid
            
            edits.examvenue =  i.examsyllabus
            edits.examsyllabus =   i.examvenue
            
            print("edits.examdate",  edits.examdate,  edits.examsession,edits.examsubjectid, edits.examvenue,edits.examsyllabus)
            
            
            
            tttt.append(edits)
            
        }
        
        modal.subjectdetails = tttt
        examEditresp.append(modal)
        
        
        let vc = GetSectionAndViewController(nibName: nil, bundle: nil)
        vc.semsterID = ges.semId
        vc.EditId = ges.EditId
        vc.examViewRefName = ges.examViewRefName
        vc.ExameSection = ges.exameName
        vc.sectionNameForEdit = ges.SectionNameForEdit
        vc.sectionIdForEdit   = ges.sectionId
        vc.examHeaderId = ges.ExamId
        vc.StartDateEdit = ges.startDate
        vc.EndDateEdit = ges.EndDate
        
        DefaultsKeys.saveEdit = examEditsModalApi1
        vc.examEditresp = examEditresp
        vc.examEditsModalApi = examEditsModalApi
        
        vc.str = str
        vc.strName = strName
        vc.examEditresp1 =  examEditresp1
        vc.examEditsModalApi1 = examEditsModalApi1
        
        vc.addImageBackGroundurl =  addImageBackGroundurl
        vc.smallImageUrl = smallimagUrl
        vc.imageWebUrl = addUrls
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
        
        
    }
    
    
    @IBAction func DeleteExame(ges : DeleteExam ){
        
        
        
        let refreshAlert = UIAlertController(title: "Delete Exam", message:  "Once done Can't be changed", preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in
            
            
            let examDelete = examDeleteModal()
            
            examDelete.examid = ges.ExamId
            examDelete.sectionid = ges.sectionId
            examDelete.processtype = "delete"
            examDelete.colgid = "1"
            examDelete.departmentid = ges.DepartmentId
            examDelete.userid = memberId
            examDelete.subjectdetails = []
            
            
            let examViewsStr = examDelete.toJSONString()
            
            
            print("examViewsStr",examViewsStr)
            ExamDeleteReqU.call_request(param: examViewsStr!){ [self]
                
                (res) in
                
                
                let departResp : deleteResp =
                Mapper<deleteResp>().map(JSONString: res)!
                
                if departResp.Status == 1{
                    
                    let refreshAlert = UIAlertController(title: "", message:  departResp.Message, preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in
                        
                        
                        
                    }))
                    
                    
                    
                    present(refreshAlert, animated: true, completion: nil)
                    
                    
                    
                    
                    tv.dataSource = self
                    tv.delegate = self
                    tv.reloadData()
                    
                    examViewPage()
                    
                    
                    
                }
                
                else{
                    
                    
                    let refreshAlert = UIAlertController(title: "", message:  departResp.Message, preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        
                        
                        
                    }))
                    
                    
                    
                    present(refreshAlert, animated: true, completion: nil)
                    
                    
                    tv.delegate = self
                    tv.dataSource = self
                    
                    tv.reloadData()
                    
                }
                
                
                print("order data",departResp)
            }
            
            
        }))
        
        
        refreshAlert.addAction(UIAlertAction(title: "CANCEL", style: .default, handler: { [self] (action: UIAlertAction!) in
        }))
        present(refreshAlert, animated: true, completion: nil)
        
        
        
        
        
    }
    
    
    @IBAction func getSubjectVcc(ges : examdetails ){
        
        let vc = GetSubjectVcViewController(nibName: nil, bundle: nil)
        vc.ExameSection = ges.exameName
        vc.exmHeader = examId
        vc.ExamName = exameName
        vc.str = str
        vc.strName = strName
        print(" ExameSection ExameSection", ExameSection.count)
        //        vc.ExameSection = ExameSection
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
        
        
        
    }
    
    
    func examViewPage() {
        
        let examViews = examViewPageModal()
        
        examViews.staffid = memberId
        examViews.examid = examId
        examViews.collegeid = colgId
        
        
        
        let examViewsStr = examViews.toJSONString()
        
        
        examViewPageRequest.call_request(param: examViewsStr!){ [self]
            
            (res) in
            
            
            let departResp : exameViewPageResponce =
            Mapper<exameViewPageResponce>().map(JSONString: res)!
            
            
            print("order data",departResp)
            
            
            
            if departResp.Status == 1{
                
                examViewRefName = departResp.data
                
                
                for i in departResp.data{
                    
                    ExameSection.append(contentsOf: i.subjectdetails)
                    
                }
                
                let count = String(examViewRefName.count)
                countLabel.text = count
                
                nodataView.isHidden = true
                noDataLabel.isHidden = true
                countView.isHidden = false
                tv.delegate = self
                tv.dataSource = self
                tv.reloadData()
                
            }
            
            else{
                
                nodataView.isHidden = false
                noDataLabel.isHidden = false
                countView.isHidden = true
                noDataLabel.text = departResp.Message
                tv.isHidden = true
                tv.delegate = self
                tv.dataSource = self
                tv.reloadData()
                
            }
            
            
        }
        
        
        
        
    }
    
    func addApi(){
        
        var add = AddApiModal()
        
        let defaults = UserDefaults.standard
        var deviceToken = defaults.string(forKey:DefaultsKeys.DeviceToken )
        add.device_token = deviceToken
        add.member_id = memberId
        add.mobile_no = mobileNumber
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
    
    
    
    @IBAction func back(_ sender: Any) {
        
        dismiss(animated: true)
    }
    
    
    
    
  
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
        vc.str = str
        vc.strName = strName
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
        
        let vc = PriorityViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
    }
    
   
    class SenderExamAddsss : UITapGestureRecognizer{
        
        
        var addUrls : String!
        
        
    }
    
    class examdetails : UITapGestureRecognizer{
        
        
        var  exameName  : [examViewSubjectDataDetails] = []
        
        
        
        
    }
}




class DeleteExam : UITapGestureRecognizer{
    
    
    var ExamId : String!
    var sectionId : String!
    var DepartmentId : String!
    var semId : String!
    var EditId : String!
    var SectionNameForEdit : String!
    var examViewRefName : [examviewDataDetails] = []
    var subjectId : String!
    var startDate : String!
    var EndDate : String!
    var ExameNameEdit : String!
    var examEditsModalApi : [exameEditMainDetail] = []
    var exameName : [examviewDataDetails] = []
    var  exameNameEdit  : [examViewSubjectDataDetails] = []
    
}
