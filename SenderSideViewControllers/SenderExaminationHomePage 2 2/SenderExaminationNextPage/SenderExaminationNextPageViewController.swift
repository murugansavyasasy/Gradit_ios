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
final class SenderExaminationNextPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Outlets
    @IBOutlet private weak var topNameview: UIView!
    @IBOutlet private weak var tapBarView: UIViewX!
    @IBOutlet private weak var clearCacheView: UIView!
    @IBOutlet private weak var noDataLabel: UILabel!
    @IBOutlet private weak var nodataView: UIView!
    @IBOutlet private weak var countLabel: UILabel!
    @IBOutlet private weak var countView: UIViewX!
    @IBOutlet private weak var redirectLoginView: UIViewX!
    @IBOutlet private weak var tv: UITableView!
    @IBOutlet private weak var smallImg: UIImageView!
    @IBOutlet private weak var bigImg: UIImageView!
    @IBOutlet private weak var changeRolesView: UIView!
    @IBOutlet private weak var topLabels: UILabel!
    @IBOutlet private weak var topMessageLabel: UILabel!
    @IBOutlet private weak var clgLogoImg: UIImageView!
    @IBOutlet private weak var sideMenuView: UIView!
    @IBOutlet private weak var viewTap: UIView!
    @IBOutlet private weak var changePasswordView: UIView!
    @IBOutlet private weak var termsAndConditionView: UIView!
    @IBOutlet private weak var helpView: UIView!
    @IBOutlet private weak var faqView: UIView!
    @IBOutlet private weak var loginView: UIView!
    @IBOutlet private weak var refreshView: UIView!
    @IBOutlet private weak var notificationView: UIView!
    @IBOutlet private weak var privacyPolicyView: UIView!

    // MARK: - Properties
    private let identifer = "ExamViewPageTvTableViewCell"
    private let menuIdentifier = "MenuCollectionViewCell"
    private var examViewRefName: [examviewDataDetails] = []
    private var addapiRef: [AddDataDeatils] = []
    private var memberId: String!
    private var colgId: String!
    private var exameName: String!
    private var sectionid: String!
    private var departmentId: String!
    private var loginType: String!
    private var memberName: String!
    private var colgImg: String!
    private var priority: String!
    private var mobileNumber: String!
    private var password: String!
    private let NoticeBoardId = "1"
    private let videoId = "2"
    private let EventId = "3"
    private let communicationId = "4"
    private let imagePdfId = "5"
    private let Assigment = "6"
    private var addImageBackGroundurl: String!
    private var addUrls: String!
    private var smallimagUrl: String!
    
    var examId: String!
    var EditId: String!
    var str: [String] = []
    var strName: [String] = []
    var is_read_enabled = ""
    var is_write_enabled = ""
    var PreviousAddId: Int = 0

    // MARK: - Lifecycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        PreviousAddId += 1
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial hidden states
        nodataView.isHidden = true
        noDataLabel.isHidden = true
        countView.isHidden = true
        sideMenuView.isHidden = true

        // Load defaults
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
        password = defaults.string(forKey: DefaultsKeys.Password)

        clgLogoImg.sd_setImage(with: URL(string: colgImg), placeholderImage: UIImage(named: "EmptyCollegeIcon"))
        topMessageLabel.text = memberName

        // Configure UI by priority
        applyPriorityAppearance()
        applyBackgroundAppearance()

        // API Calls
        addApi()
        examViewPage()

        // Table registration
        let rowNib = UINib(nibName: identifer, bundle: nil)
        tv.register(rowNib, forCellReuseIdentifier: identifer)

        // Gestures
        addGestures()
    }

    // MARK: - UI Configuration
    private func applyPriorityAppearance() {
        switch priority {
        case "p1":
            tapBarView.backgroundColor = UIColor(named: "Principal")
            topLabels.text = "Principal"
        case "p4":
            tapBarView.backgroundColor = UIColor(named: "studentViewColors")
            topLabels.text = "Student"
        case "p2":
            tapBarView.backgroundColor = UIColor(named: "Teaching Staff")
            topLabels.text = "Hod"
        case "p5":
            tapBarView.backgroundColor = UIColor(named: "FatherColor")
            topLabels.text = "Father"
        case "p3":
            tapBarView.backgroundColor = UIColor(named: "Teaching Staff")
            topLabels.text = "Teacher"
        case "p6":
            tapBarView.backgroundColor = UIColor(named: "Teaching Staff")
            topLabels.text = "NonTeaching"
        default:
            break
        }
    }

    private func applyBackgroundAppearance() {
        switch priority {
        case "p1":
            view.backgroundColor = UIColor(named: "Principal")
           
        case "p4":
            view.backgroundColor = UIColor(named: "studentViewColors")
           
        case "p3", "p2":
            view.backgroundColor = UIColor(named: "Teaching Staff")
            
        case "p5":
            view.backgroundColor = UIColor(named: "FatherColor")
           
        case "p6":
            view.backgroundColor = UIColor(named: "Teaching Staff")
           
        default:
            break
        }
    }

    private func addGestures() {
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

    // MARK: - Actions
    @IBAction private func adLoad(gesture: SenderExamAddsss) {
        let vc = SenderExamAddVcViewController(nibName: nil, bundle: nil)
        vc.AddWebUrl = gesture.addUrls
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }

    @IBAction private func EditVc(ges: DeleteExam) {
        let vc = GetSectionAndViewController(nibName: nil, bundle: nil)
        vc.semsterID = ges.examData?.semesterid
        vc.examName = ges.examData?.examnm
        vc.startDate = ges.examData?.startdate
        vc.endDate = ges.examData?.enddate
        vc.departmentId = ges.examData?.clgdepartmentid
        vc.sectionIdForEdit = ges.examData?.clgsectionid
        vc.str = str
        vc.strName = strName
        vc.addImageBackGroundurl = addImageBackGroundurl
        vc.smallImageUrl = smallimagUrl
        vc.imageWebUrl = addUrls
        vc.EditExamData = ges.examData
        vc.isEditExam = true
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }

    @IBAction private func DeleteExame(ges: DeleteExam) {
        let refreshAlert = UIAlertController(title: "Delete Exam", message: "Once done Can't be changed", preferredStyle: .alert)

        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }

            var examDelete = examDeleteModal()
            examDelete.examid = ges.examData?.examheaderid
            examDelete.sectionid = ges.examData?.clgsectionid
            examDelete.processtype = "delete"
            examDelete.colgid = "1"
            examDelete.departmentid = ges.examData?.clgdepartmentid
            examDelete.userid = self.memberId
            examDelete.subjectdetails = []

            APiCallManager.shared.callApi(
                url: APIEndpoints.EditSectionWiseExamForApp,
                httpMethod: .post,
                queryParam: nil,
                requestBody: examDelete
            ) { [weak self] (result: Result<deleteResp, Error>) in
                guard let self = self else { return }

                switch result {
                case .success(let departResp):
                    if departResp.Status == 1 {
                        let alert = UIAlertController(title: "", message: departResp.Message, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)

                        self.tv.dataSource = self
                        self.tv.delegate = self
                        self.tv.reloadData()
                        self.examViewPage()
                    } else {
                        let alert = UIAlertController(title: "", message: departResp.Message, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)

                        self.tv.delegate = self
                        self.tv.dataSource = self
                        self.tv.reloadData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }))

        refreshAlert.addAction(UIAlertAction(title: "CANCEL", style: .default, handler: nil))
        present(refreshAlert, animated: true, completion: nil)
    }

    @IBAction private func getSubjectVcc(ges: examdetails) {
        let vc = GetSubjectVcViewController(nibName: nil, bundle: nil)
        vc.ExameSection = ges.SubjectsList
        vc.exmHeader = examId
        vc.ExamName = ges.examName
        vc.str = str
        vc.strName = strName
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }

    @IBAction private func back(_ sender: Any) {
        dismiss(animated: true)
    }

    @IBAction private func helpRedirect() {
        let vc = HelpViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }

    @IBAction private func termsAndCondition() {
        let vc = MenuTermsViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }

    @IBAction private func logoutPressed() {
        let refreshAlert = UIAlertController(title: "", message: "Are you sure do you want to logout", preferredStyle: .alert)

        refreshAlert.addAction(UIAlertAction(title: "YES", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            UserDefaults.standard.removeObject(forKey: DefaultsKeys.mobileNumber)
            let vc = LoginNewViewController(nibName: nil, bundle: nil)
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }))

        refreshAlert.addAction(UIAlertAction(title: "NO", style: .cancel, handler: nil))
        present(refreshAlert, animated: true, completion: nil)
    }

    @IBAction private func faqRedirect() {
        let vc = FaqViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }

    @IBAction private func privacyPolicyRedirect() {
        let vc = PrivacyPolicyViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }

    @IBAction private func refreshVc() {
        KRProgressHUD.show()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            KRProgressHUD.dismiss()
        }
    }

    @IBAction private func notificationVc() {
        let vc = NotificationViewController(nibName: nil, bundle: nil)
        vc.str = str
        vc.strName = strName
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false, completion: nil)
    }

    @IBAction private func menu() {
        sideMenuView.isHidden.toggle()
    }

    @IBAction private func changePassowrdVC() {
        let vc = ChangePasswordViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }

    @IBAction private func priorityVc() {
        let vc = PriorityViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }

    // MARK: - Networking
    private func examViewPage() {
        var examViews = examViewPageModal()
        examViews.staffid = memberId
        examViews.examid = examId
        examViews.collegeid = colgId

        APiCallManager.shared.callApi(
            url: APIEndpoints.GetDetailsForExamEdit,
            httpMethod: .post,
            queryParam: nil,
            requestBody: examViews
        ) { [weak self] (result: Result<exameViewPageResponce, Error>) in
            guard let self = self else { return }

            switch result {
            case .success(let departResp):
                if departResp.Status == 1 {
                    
                    self.examViewRefName = departResp.data ?? []

                    let count = String(self.examViewRefName.count)
                    self.countLabel.text = count
                    self.nodataView.isHidden = true
                    self.noDataLabel.isHidden = true
                    self.countView.isHidden = false
                    self.tv.delegate = self
                    self.tv.dataSource = self
                    self.tv.reloadData()
                } else {
                    self.nodataView.isHidden = false
                    self.noDataLabel.isHidden = false
                    self.countView.isHidden = true
                    self.noDataLabel.text = departResp.Message
                    self.tv.isHidden = true
                    self.tv.delegate = self
                    self.tv.dataSource = self
                    self.tv.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    private func addApi() {
        var add = AddApiModal()
        let defaults = UserDefaults.standard
        let deviceToken = defaults.string(forKey: DefaultsKeys.DeviceToken)

        add.device_token = deviceToken
        add.member_id = Int(memberId)
        add.mobile_no = mobileNumber
        add.priority = priority
        add.college_id = Int(colgId)
        add.previous_add_id = PreviousAddId

        APiCallManager.shared.callApi(
            url: APIEndpoints.GetAddsForCollege,
            httpMethod: .post,
            queryParam: nil,
            requestBody: add
        ) { [weak self] (result: Result<AddApiResponce, Error>) in
            guard let self = self else { return }

            switch result {
            case .success(let success):
                if success.Status == 1 {
                    self.addapiRef = success.data ?? []

                    for i in self.addapiRef {
                        self.addImageBackGroundurl = i.background_image ?? ""
                        self.smallimagUrl = i.add_image ?? ""

                        self.bigImg.sd_setImage(with: URL(string: i.background_image ?? ""), placeholderImage: UIImage(named: "ic_white"))
                        self.smallImg.sd_setImage(with: URL(string: i.add_image ?? ""), placeholderImage: UIImage(named: "ic_white"))

                        let singleTap = adds(target: self, action: #selector(self.adLoad))
                        singleTap.url = i.add_url
                        self.bigImg.isUserInteractionEnabled = true
                        self.bigImg.addGestureRecognizer(singleTap)
                    }
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }

    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return examViewRefName.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifer, for: indexPath) as! ExamViewPageTvTableViewCell
        
        cell.selectionStyle = .none

        let examdeatils: examviewDataDetails = examViewRefName[indexPath.row]
        cell.ClgDeprtNameLabel.text = examdeatils.clgdepartmentname
        cell.courseNameLabel.text = examdeatils.coursename
        cell.endDateLabel.text = examdeatils.enddate
        cell.examName.text = examdeatils.examnm
        cell.sectionLabel.text = examdeatils.clgsectionname
        cell.semesterNameLabel.text = examdeatils.semestername
        cell.startDateLabel.text = examdeatils.startdate
        cell.yearNameLabel.text = examdeatils.yearname

        let getSubjectVc = examdetails(target: self, action: #selector(getSubjectVcc))
        getSubjectVc.SubjectsList = examdeatils.subjectdetails ?? []
        getSubjectVc.examName = examdeatils.examnm
        cell.getSubjectView.addGestureRecognizer(getSubjectVc)

        let deleteGesture = DeleteExam(target: self, action: #selector(DeleteExame))
        deleteGesture.examData = examdeatils
        cell.deleteView.addGestureRecognizer(deleteGesture)

        let editGesture = DeleteExam(target: self, action: #selector(EditVc))
        editGesture.examData = examdeatils
        cell.EditView.addGestureRecognizer(editGesture)

        if EditId == "1" {
            cell.EditView.isHidden = false
            cell.deleteView.isHidden = false
            cell.getSubjectView.isHidden = true
        } else {
            cell.EditView.isHidden = true
            cell.deleteView.isHidden = true
            cell.getSubjectView.isHidden = false
        }

        return cell
    }

    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
}

// MARK: - Gesture Subclasses
final class SenderExamAddsss: UITapGestureRecognizer {
    var addUrls: String!
}

final class examdetails: UITapGestureRecognizer {
    var SubjectsList: [examViewSubjectDataDetails] = []
    var examName : String?
}

final class DeleteExam: UITapGestureRecognizer {
    
    var examData: examviewDataDetails?
}
