//
//  GetSectionAndViewController.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 26/03/23.
//

import UIKit
import KRProgressHUD
import DropDown

@available(iOS 16.0, *)
class GetSectionAndViewController: UIViewController, UITextFieldDelegate, UIGestureRecognizerDelegate, UITextViewDelegate {
    
    @IBOutlet weak var tapBarView: UIView!
    @IBOutlet weak var exameTopicDefaultLbl: UILabel!
    @IBOutlet weak var redirectLoginView: UIViewX!
    @IBOutlet weak var Tv: UITableView!
    @IBOutlet weak var confirmView: UIView!
    @IBOutlet weak var nodataView: UIView!
    @IBOutlet weak var noDataLabel: UILabel!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var topLabels: UILabel!
    @IBOutlet weak var viewTap: UIView!
    @IBOutlet weak var clgLogoImg: UIImageView!
    @IBOutlet weak var topMessageLabel: UILabel!
    @IBOutlet weak var smallImg: UIImageView!
    @IBOutlet weak var bigImg: UIImageView!
    @IBOutlet weak var changeRolesView: UIView!
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var refreshView: UIView!
    @IBOutlet weak var sideMenuView: UIView!
    @IBOutlet weak var termsAndConditionView: UIView!
    @IBOutlet weak var faqView: UIView!
    @IBOutlet weak var privacyPolicyView: UIView!
    @IBOutlet weak var changePasswordView: UIView!
    @IBOutlet weak var helpView: UIView!
    
    var sujectData: [Subjectdetails] = []
    var identifiers = "ExameCreationTableViewCell"
    var getSection: [getSubjectWiseDataDetails] = []
    var examSubRef: [Datass] = []
    var userId: String?
    var semsterID: String?
    var colgId: String?
    var priority: String?
    var colgImg: String?
    var addImageBackGroundurl: String?
    var smallImageUrl: String?
    var imageWebUrl: String?
    let dropDown = DropDown()
    var sectionIdForEdit: String! // this for exam edit Section Id
    var str: [String] = []
    var strName: [String] = []
    var examName: String?
    var startDate: String?
    var endDate: String?
    var departmentId: String?
    var selectedIndex: IndexPath?
    var isEditExam: Bool = false
    var EditExamData: examviewDataDetails?
    var isStaff: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureInitialLabels()
        loadImages()
        setupInitialVisibility()
        loadDefaultsAndApplyPriorityStyling()
        registerTableRowNib()
        attachGestureRecognizers()
//        if !isStaff{
//            GetSectionAndYear()
//        }else{
//            Tv.reloadData()
//        }
        GetSectionAndYear()
    }
    
    private func configureInitialLabels() {
        if isEditExam == true {
            exameTopicDefaultLbl.text = "Edit Examination"
        } else {
            exameTopicDefaultLbl.text = "Create Examination"
        }
    }
    
    private func loadImages() {
        bigImg.sd_setImage(with: URL(string: addImageBackGroundurl ?? ""), placeholderImage: UIImage(named: "ic_white"))
        smallImg.sd_setImage(with: URL(string: smallImageUrl ?? ""), placeholderImage: UIImage(named: "ic_white"))
    }
    
    private func setupInitialVisibility() {
        nodataView.isHidden = true
        noDataLabel.isHidden = true
        sideMenuView.isHidden = true
    }
    
    private func loadDefaultsAndApplyPriorityStyling() {
        let defaults = UserDefaults.standard
        priority  = defaults.string(forKey: DefaultsKeys.priority)
        userId = defaults.string(forKey: DefaultsKeys.memberid)
        colgId = defaults.string(forKey: DefaultsKeys.collegeid)
        colgImg = defaults.string(forKey: DefaultsKeys.colglogo)
        clgLogoImg.sd_setImage(with: URL(string: colgImg ?? ""), placeholderImage: UIImage(named: "EmptyCollegeIcon"))
        topMessageLabel.text = defaults.string(forKey: DefaultsKeys.memberName)
        switch priority {
        case "p1":
            topLabels.text = "Principal"
            tapBarView.backgroundColor = UIColor(named: "Principal")
            view.backgroundColor = UIColor(named: "Principal")
        case "p4":
            topLabels.text = "Student"
        case "p2":
            tapBarView.backgroundColor = UIColor(named: "Teaching Staff")
            topLabels.text = "Hod"
        case "p5":
            topLabels.text = "Father"
        case "p3":
            tapBarView.backgroundColor = UIColor(named: "Teaching Staff")
            topLabels.text = "Teacher"
        default:
            break
        }
    }
    
    private func registerTableRowNib() {
        let rowNib = UINib(nibName: identifiers, bundle: nil)
        Tv.register(rowNib, forCellReuseIdentifier: identifiers)
        self.Tv.dataSource = self
        self.Tv.delegate = self
    }
    
    private func attachGestureRecognizers() {
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(adLoad))
        bigImg.isUserInteractionEnabled = true
        bigImg.addGestureRecognizer(singleTap)
        
        let confirm = UITapGestureRecognizer(target: self, action: #selector(ConfirmVc))
        confirmView.addGestureRecognizer(confirm)
        
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
        
        let privacyPolicyGesture = UITapGestureRecognizer(target: self, action: #selector(privacyPolicyRedirect))
        privacyPolicyView.addGestureRecognizer(privacyPolicyGesture)
        
        let termsAndConditionGesture = UITapGestureRecognizer(target: self, action: #selector(termsAndCondition))
        termsAndConditionView.addGestureRecognizer(termsAndConditionGesture)
        
        let chagePassword = UITapGestureRecognizer(target: self, action: #selector(changePassowrdVC))
        changePasswordView.addGestureRecognizer(chagePassword)
        
        let toplabelclick = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        topLabels.isUserInteractionEnabled = true
        topLabels.addGestureRecognizer(toplabelclick)
    }
    
    @IBAction func adLoad() {
        let vc = TotalAddLoadPageViewController(nibName: nil, bundle: nil)
        vc.AddWebUrl = imageWebUrl
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func ConfirmVc() {
        let refreshAlert = UIAlertController(title: "Hold on!", message: "Are you sure do you want to submit?", preferredStyle: .alert)
        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: {[self] _ in
            if isEditExam{
                editExamApi()
            }else{
                CreateExam()
            }
        }))
        refreshAlert.addAction(UIAlertAction(title: "CANCEL", style: .cancel))
        present(refreshAlert, animated: true, completion: nil)
    }
    
    func GetSectionAndYear() {
        
        var section = getSubjectWiseSectionModal()
        section.userid = userId
        section.appid = "2"
        section.semesterid = semsterID
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.getsectionwisesubjectlist,
            httpMethod: .post,
            queryParam: nil,
            requestBody: section
        ) { [weak self] (result: Result<getSubjectWiseResponce, Error>) in
            guard let self = self else { return }
            switch result {
                
            case .success(let particular):
                
                // ✅ Step 1: ALWAYS assign API data first
                self.getSection = particular.data ?? []
                
                // ✅ Step 2: If edit → merge data
                if isEditExam {
                    
                    for i in 0..<getSection.count {
                        
                        // match section
                        if getSection[i].sectionid == EditExamData?.clgsectionid {
                            
                            for j in 0..<(getSection[i].subjectdetails?.count ?? 0) {
                                
                                let subjectId = getSection[i].subjectdetails?[j].subjectid
                                
                                for editSub in EditExamData?.subjectdetails ?? [] {
                                    
                                    if subjectId == editSub.examsubjectid {
                                        
                                        // ✅ Fill values
                                        getSection[i].subjectdetails?[j].examdate = editSub.examdate
                                        getSection[i].subjectdetails?[j].examsyllabus = editSub.examsyllabus
                                        getSection[i].subjectdetails?[j].examvenue = editSub.examvenue
                                        getSection[i].subjectdetails?[j].examsession = editSub.examsession
                                        
                                        // ✅ mark saved
                                        getSection[i].subjectdetails?[j].isSaved = true
                                    }
                                }
                            }
                        }
                    }
                    
                    // ✅ OPTIONAL: show only that section
                    self.getSection = self.getSection.filter {
                        $0.sectionid == self.EditExamData?.clgsectionid
                    }
                    
                    // ✅ auto expand
                    self.selectedIndex = IndexPath(row: 0, section: 0)
                }
                
                // ✅ UI handling
                if particular.Status == 1 {
                    self.nodataView.isHidden = true
                    self.noDataLabel.isHidden = true
                } else {
                    self.nodataView.isHidden = false
                    self.noDataLabel.isHidden = false
                    self.noDataLabel.text = particular.Message
                }
                
               
                self.Tv.reloadData()
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    func CreateExam() {
        
        
        var sectionArray: [Sectiondetails] = []
        
        for section in getSection {
            
            guard let sectionId = section.sectionid,
                  let subjects = section.subjectdetails else { continue }
            
            // ✅ Filter ONLY saved subjects
            let savedSubjects = subjects.filter { $0.isSaved == true }
            
            // Skip section if no saved subjects
            if savedSubjects.isEmpty { continue }
            
            var subjectArray: [Subjectdetails] = []
            
            for sub in savedSubjects {
                
                let subjectDetail = Subjectdetails(
                    examsubjectid: sub.subjectid ?? "",
                    examdate: sub.examdate ?? "",
                    examsyllabus: sub.examsyllabus ?? "",
                    examvenue: sub.examvenue ?? "",
                    examsession: sub.examsession ?? ""
                )
                
                subjectArray.append(subjectDetail)
            }
            
            let sectionDetail = Sectiondetails(
                clgsectionid: Int(sectionId),
                Subjectdetails: subjectArray
            )
            
            sectionArray.append(sectionDetail)
        }
        
        if sectionArray.isEmpty {
            
            let refreshAlert = UIAlertController(title: "", message: "Enter Subject Details", preferredStyle: .alert)
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default))
            present(refreshAlert, animated: true, completion: nil)
            return
        }
        
        var examCreate = Main()
        
        examCreate.collegeid = colgId
        examCreate.staffid = userId
        examCreate.examid = "0"
        examCreate.departmentid = departmentId
        examCreate.examname = examName
        examCreate.startdate = startDate
        examCreate.enddate = endDate
        examCreate.processtype = "add"
        examCreate.sectiondetails = sectionArray
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.ExamCreation,
            httpMethod: .post,
            queryParam: nil,
            requestBody: examCreate
        ) { [weak self] (result: Result<ExaminationAddResponce, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let exams):
                self.examSubRef = exams.data ?? []
                if exams.Status == 1 {
                    let refreshAlert = UIAlertController(title: "", message: exams.Message, preferredStyle: .alert)
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
                        guard let self = self else { return }
                        if priority == "p2" || priority == "p3" {
                            let vc = SenderExmainationHomePageViewController(nibName: nil, bundle: nil)
                            vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                            vc.examSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                            vc.examSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                            vc.str = str
                            vc.strName = strName
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true, completion: nil)
                        } else {
                            let vc = SenderExmainationHomePageViewController(nibName: nil, bundle: nil)
                            vc.view.backgroundColor = UIColor(named: "Principal")
                            vc.examSegmentName.backgroundColor = UIColor(named: "UnSelector")
                            vc.examSegmentName.selectedSegmentTintColor = UIColor(named: "Selector")
                            vc.str = str
                            vc.strName = strName
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true, completion: nil)
                        }
                    }))
                    self.present(refreshAlert, animated: true, completion: nil)
                } else {
                    let refreshAlert = UIAlertController(title: "", message: exams.Message, preferredStyle: .alert)
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(refreshAlert, animated: true, completion: nil)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func editExamApi() {
        
        var subjectArray: [ExamDetailsDataDetails] = []
        
        for section in getSection {
            
            for subject in section.subjectdetails ?? [] {
                
                // ✅ Only saved subjects
                if subject.isSaved == true {
                    
                    let sub = ExamDetailsDataDetails(
                        clgsubjectid: subject.subjectid ?? "",
                        examdate: subject.examdate ?? "",
                        examsyllabus: subject.examsyllabus ?? "",
                        examvenue: subject.examvenue ?? "",
                        examsession: subject.examsession ?? ""
                    )
                    
                    subjectArray.append(sub)
                }
            }
        }
        
        var editExam = ExameEditModal()
        
        editExam.examid = EditExamData?.examheaderid
        editExam.colgid = colgId
        editExam.userid = userId
        editExam.sectionid = getSection.first?.sectionid
        editExam.processtype = "edit"
        editExam.subjectdetails = subjectArray
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.EditSectionWiseExamForApp,
            httpMethod: .post,
            queryParam: nil,
            requestBody: editExam
        ) { [weak self] (result: Result<ExaminationAddResponce, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let exams):
                if exams.Status == 1 {
                    let refreshAlert = UIAlertController(title: "", message: exams.Message, preferredStyle: .alert)
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
                        guard let self = self else { return }
                        if priority == "p2" || priority == "p3" {
                            let vc = SenderExmainationHomePageViewController(nibName: nil, bundle: nil)
                            vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                            vc.examSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                            vc.examSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                            vc.str = str
                            vc.strName = strName
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true, completion: nil)
                        } else {
                            
                            let vc = SenderExmainationHomePageViewController(nibName: nil, bundle: nil)
                            vc.view.backgroundColor = UIColor(named: "Principal")
                            vc.examSegmentName.backgroundColor = UIColor(named: "UnSelector")
                            vc.examSegmentName.selectedSegmentTintColor = UIColor(named: "Selector")
                            vc.str = str
                            vc.strName = strName
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true, completion: nil)
                        }
                    }))
                    self.present(refreshAlert, animated: true, completion: nil)
                } else {
                    let refreshAlert = UIAlertController(title: "", message: exams.Message, preferredStyle: .alert)
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(refreshAlert, animated: true, completion: nil)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
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
        let refreshAlert = UIAlertController(title: "", message: "Are you sure do you want to logout", preferredStyle: .alert)
        refreshAlert.addAction(UIAlertAction(title: "YES", style: .default, handler: { _ in
            UserDefaults.standard.removeObject(forKey: DefaultsKeys.mobileNumber)
            let vc = LoginNewViewController(nibName: nil, bundle: nil)
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }))
        refreshAlert.addAction(UIAlertAction(title: "NO", style: .cancel))
        present(refreshAlert, animated: true, completion: nil)
    }
    
    @IBAction func faqRedirect() {
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
        KRProgressHUD.show()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { KRProgressHUD.dismiss() }
    }
    
    @IBAction func notificationVc() {
        let vc = NotificationViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false, completion: nil)
    }
    
    @IBAction func menu() {
        sideMenuView.isHidden.toggle()
    }
    
    @IBAction func changePassowrdVC() {
        let vc = ChangePasswordViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func priorityVc() {
        let vc = PriorityViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}

@available(iOS 16.0, *)
extension GetSectionAndViewController : UITableViewDelegate, UITableViewDataSource, ExameCreationCellDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        getSection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifiers, for: indexPath) as! ExameCreationTableViewCell
        
        let expand = indexPath == selectedIndex ? true : false
        
        let model = getSection[indexPath.row]
        cell.configure(
            sectionName: model.sectionname ?? "",
            subjects: model.subjectdetails ?? [], isExpand: expand
        )
        cell.fromDate = startDate
        cell.toDate = endDate
        cell.delegate = self
        cell.sectionIndex = indexPath.row
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath == selectedIndex{
            selectedIndex = nil
        }else{
            selectedIndex = indexPath
        }
        
        tableView.reloadData()
        
        DispatchQueue.main.async {
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        UITableView.automaticDimension
    }
    
    func didUpdateSubject(sectionIndex: Int,
                          subjectIndex: Int,
                          subject: getSectionDatasDetails) {
        
        getSection[sectionIndex].subjectdetails?[subjectIndex] = subject
        
        print("Updated Main Data:", getSection)
    }
}


