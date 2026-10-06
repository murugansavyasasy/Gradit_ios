//
//  SenderAssigmentHomePageViewController.swift
//  GraditSenderAssigment
//
//  Created by MACBOOKPRO on 30/11/22.
//

import UIKit
import ObjectMapper
import KRProgressHUD

@available(iOS 16.0, *)
class SenderAssigmentHomePageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var searchFullView: UIViewX!
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var CustomTabBar: CustomTabBar!
    @IBOutlet weak var smallImg: UIImageView!
    
    @IBOutlet weak var loadingCustom: UIActivityIndicatorView!
    @IBOutlet weak var bigImg: UIImageView!
    
    @IBOutlet weak var logoutView: UIView!
    
    @IBOutlet weak var changeRolesView: UIView!
    @IBOutlet weak var privacyPolicyView: UIView!
    
    @IBOutlet weak var faqView: UIView!
    
    @IBOutlet weak var helpView: UIView!
    
    @IBOutlet weak var changePasswordView: UIView!
    
    @IBOutlet weak var termsAndConditionView: UIView!
    
    @IBOutlet weak var sideMenuView: UIView!
    
    @IBOutlet weak var assigmentCountViews: UIViewX!
    @IBOutlet weak var upcommingcountView: UIViewX!
    
    @IBOutlet weak var noDataView: UIView!
    
    @IBOutlet weak var noDataTextLabel: UILabel!
    @IBOutlet weak var assigmentPastCountView: UIViewX!
    @IBOutlet weak var assigmentUpcommingCount: UILabel!
    @IBOutlet weak var assigmentTopCount: UILabel!
    
    @IBOutlet weak var assigmentSegmentName: UISegmentedControl!
    
    @IBOutlet weak var assigmentPastCount: UILabel!
    
    @IBOutlet weak var addPlusVcNextPage: UIViewX!
    @IBOutlet weak var assigmentTableView: UITableView!
    
    var Indentifiers = "SenderAssigmentTableViewCell"
    var UpcommingRef: [upcommingdataDetails] = []
    var PasrRef: [upcommingdataDetails] = []
    var overAllRef: [overAllDataDetails] = []
    var addapiRef: [AddDataDeatils] = []
    var assigmentImagPdf: [assigmentImagePdfResponce] = []
    var selectedCell: IndexPath?
    var memberId: String!
    var priority: String!
    var colgId: String!
    var sectionid: String!
    var deptid: String!
    var assigmentMenuId: String!
    var mobileNumber: String!
    var password: String!
    var str: [String] = []
    var strName: [String] = []
    var PreviousAddId: Int = 0
    var addImageBackGroundurl: String!
    var smallImageUrl: String!
    var addurls: String!
    var cloneList: [upcommingdataDetails] = []
    var is_read_enabled: String?
    var is_write_enabled: String?
    
    override func viewDidAppear(_ animated: Bool) {
        PreviousAddId = PreviousAddId + 1
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        loadingCustom.startAnimating()
        
        sideMenuView.isHidden = true
        searchbar.delegate = self
        searchbar.isHidden = true
        searchFullView.isHidden = true
        
        let defaults = UserDefaults.standard
        
        memberId = defaults.string(forKey: DefaultsKeys.memberid)
        priority = defaults.string(forKey: DefaultsKeys.priority)
        colgId = defaults.string(forKey: DefaultsKeys.collegeid)
        deptid = defaults.string(forKey: DefaultsKeys.deptid)
        sectionid = defaults.string(forKey: DefaultsKeys.sectionid)
        mobileNumber = defaults.string(forKey: DefaultsKeys.mobileNumber)
        password = defaults.string(forKey: DefaultsKeys.Password)
        
        CustomTabBar.delegate = self
        
        if sectionid == "" {
            sectionid = "0"
        }
        
        addApi()
        
        if is_read_enabled == "1" {
            UpcommingRefName()
        }
        
        addPlusVcNextPage.isHidden = is_write_enabled == "1" ? false : true
        
        overAllRefName()
        
        if priority == "p6" {
            addPlusVcNextPage.isHidden = true
            assigmentTopCount.isHidden = true
            assigmentPastCountView.isHidden = true
            upcommingcountView.isHidden = true
        }
        
        view.backgroundColor = .priorityColor
        
        let rowNib = UINib(nibName: Indentifiers, bundle: nil)
        assigmentTableView.register(rowNib, forCellReuseIdentifier: Indentifiers)
        
        let plusAddViews = UITapGestureRecognizer(target: self, action: #selector(PlusVc))
        addPlusVcNextPage.addGestureRecognizer(plusAddViews)
        
        // tap Bar UiTapGuster.
        
        let changeRolesGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        changeRolesView.addGestureRecognizer(changeRolesGesture)
        
        let logoutGesture = UITapGestureRecognizer(target: self, action: #selector(logoutPressed))
        logoutView.addGestureRecognizer(logoutGesture)
        
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
        
        noDataView.isHidden = true
        noDataTextLabel.isHidden = true
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if assigmentSegmentName.selectedSegmentIndex == 0 {
            
            let filtered_list: [upcommingdataDetails] = cloneList
            
            if !searchText.isEmpty {
                
                let search = searchText.lowercased()
                
                UpcommingRef = filtered_list.filter {
                    ($0.description?.lowercased().contains(search) ?? false) ||
                    ($0.assignmenttype?.lowercased().contains(search) ?? false) ||
                    ($0.createdon?.lowercased().contains(search) ?? false) ||
                    ($0.topic?.lowercased().contains(search) ?? false) ||
                    ($0.subjectname?.lowercased().contains(search) ?? false) ||
                    ($0.createdby?.lowercased().contains(search) ?? false)
                }
                
            } else {
                
                UpcommingRef = filtered_list
                
                print("pendingOrder")
            }
            
            if UpcommingRef.count > 0 {
                print("searchListPendigCount", UpcommingRef.count)
                
                noDataTextLabel.isHidden = true
                noDataView.isHidden = true
                
            } else {
                noDataTextLabel.isHidden = false
                noDataView.isHidden = false
                noDataTextLabel.text = "No Records Found"
            }
            
        } else if assigmentSegmentName.selectedSegmentIndex == 1 {
            
            let filtered_list: [upcommingdataDetails] = cloneList
            
            if !searchText.isEmpty {
                
                let search = searchText.lowercased()
                
                PasrRef = filtered_list.filter {
                    ($0.description?.lowercased().contains(search) ?? false) ||
                    ($0.assignmenttype?.lowercased().contains(search) ?? false) ||
                    ($0.createdon?.lowercased().contains(search) ?? false) ||
                    ($0.topic?.lowercased().contains(search) ?? false) ||
                    ($0.subjectname?.lowercased().contains(search) ?? false) ||
                    ($0.createdby?.lowercased().contains(search) ?? false)
                }
                
            } else {
                
                PasrRef = filtered_list
            }
            
            if PasrRef.count > 0 {
                print("searchListPendigCount", PasrRef.count)
                
                noDataTextLabel.isHidden = true
                noDataView.isHidden = true
                
            } else {
                noDataTextLabel.isHidden = false
                noDataView.isHidden = false
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
        
        searchbar.isHidden = true
        searchFullView.isHidden = true
        
        searchbar.resignFirstResponder()
    }
    
    
    @IBAction func PlusVc() {
        
        let ad = addapiRef.first
        
        let vc = PlusScreenNextPageViewController(nibName: nil, bundle: nil)
        
        vc.addImageBackGroundurl = ad?.background_image
        vc.imageWebUrl = ad?.add_url
        vc.smallImageUrl = ad?.add_image
        vc.is_read_enabled = is_read_enabled
        vc.is_write_enabled = is_write_enabled
        vc.str = str
        vc.strName = strName
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func segmentAction(_ sender: Any) {
        
        searchbar.text = ""
        searchbar.endEditing(true)
        
        if assigmentSegmentName.selectedSegmentIndex == 0 {
            addPlusVcNextPage.isHidden = false
            selectedCell = IndexPath()
            assigmentTableView.isScrollEnabled = false
            UpcommingRefName()
            
        } else if assigmentSegmentName.selectedSegmentIndex == 1 {
            addPlusVcNextPage.isHidden = false
            assigmentTableView.isScrollEnabled = false
            selectedCell = IndexPath()
            PastRefName()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if assigmentSegmentName.selectedSegmentIndex == 0 {
            return UpcommingRef.count
            
        } else if assigmentSegmentName.selectedSegmentIndex == 1 {
            return PasrRef.count
        }
        
        return 0
    }
    
    
    @IBAction func NotSelectdFunc(gesture: AssigmentDeletes) {
        
        let notsubimted = AssigmentNotSubViewController(nibName: nil, bundle: nil)
        notsubimted.assigmentId = gesture.assigmentHeaderId
        notsubimted.modalPresentationStyle = .fullScreen
        present(notsubimted, animated: true)
    }
    
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(
            withIdentifier: Indentifiers,
            for: indexPath
        ) as! SenderAssigmentTableViewCell

        // MARK: - Reset reused cell

        cell.detailsStack.isHidden = true
        cell.readDotImageView.isHidden = true
        cell.AttchmentView.isUserInteractionEnabled = false
        cell.PlusOneView.isUserInteractionEnabled = false
        cell.forwardView.isUserInteractionEnabled = false
        cell.submissionView.isUserInteractionEnabled = false
        cell.notSubmittedView.isUserInteractionEnabled = false

        // IMPORTANT:
        // UITableView reuses cells, so remove old gesture recognizers.
        cell.AttchmentView.gestureRecognizers?.forEach {
            cell.AttchmentView.removeGestureRecognizer($0)
        }

        cell.PlusOneView.gestureRecognizers?.forEach {
            cell.PlusOneView.removeGestureRecognizer($0)
        }

        cell.forwardView.gestureRecognizers?.forEach {
            cell.forwardView.removeGestureRecognizer($0)
        }

        cell.submissionView.gestureRecognizers?.forEach {
            cell.submissionView.removeGestureRecognizer($0)
        }

        cell.notSubmittedView.gestureRecognizers?.forEach {
            cell.notSubmittedView.removeGestureRecognizer($0)
        }

        // MARK: - UPCOMING

        if assigmentSegmentName.selectedSegmentIndex == 0 {

            guard indexPath.row < UpcommingRef.count else {
                return cell
            }

            let upcoming = UpcommingRef[indexPath.row]

            // MARK: Basic information

            cell.topicLabel.text = upcoming.topic?.capitalized
            cell.descriptionLabel.text = upcoming.description
            cell.creatonLabel.text = upcoming.sentbyname
            cell.countLabel.text = "Submitted : \(upcoming.submittedcount ?? "")"
            cell.notSubLBL.text =
                "Not submitted : " + (upcoming.totalcount ?? "")
            let date = "Due \(upcoming.submissiondate ?? "")"
            cell.dueDateBtn.setTitle(date, for: .normal)
            cell.submissionCountLbl.text = "Submission :\(upcoming.submittedcount ?? "")"
            cell.submissionCountLbl.textColor = upcoming.submittedcount == "0" ? .systemRed : .systemGreen
            
            if let timing = upcoming.createdon {
                let dateAndTime = timing.components(separatedBy: " - ")
                cell.dateLabel.text = dateAndTime.first ?? ""
                cell.timeLabel.text = dateAndTime.dropFirst().joined(separator: " - ")
            }

            cell.readDotImageView.isHidden = upcoming.isappread == "1"
            
            // MARK: Expanded state

            if let selectedCells = selectedCell,
               selectedCells == indexPath {

                cell.detailsStack.isHidden = false

                let assignmentType = upcoming.assignmenttype?
                    .trimmingCharacters(in: .whitespacesAndNewlines)
                    .lowercased()

                if assignmentType == "text" ||
                    assignmentType == "all" {

                    cell.attachmentStack.isHidden = true

                } else if let files = upcoming.newfilepath,
                          !files.isEmpty {
                    cell.attachmentStack.isHidden = false

                    if files.count > 1 {
                        cell.PlusOneView.isHidden = false
                        cell.plusOneCountLabel.isHidden = false
                        cell.plusOneCountLabel.text = "+\(files.count - 1)"
                    } else {
                        cell.PlusOneView.isHidden = true
                        cell.plusOneCountLabel.isHidden = true
                    }
                }
            }

            // MARK: Attachment

            let files = upcoming.newfilepath ?? []

            let assignmentType = upcoming.assignmenttype?
                .trimmingCharacters(in: .whitespacesAndNewlines)
                .lowercased()

            let hasValidAttachment =
                !files.isEmpty &&
                assignmentType != "text" &&
                assignmentType != "all"

            if hasValidAttachment {

                cell.AttchmentView.isHidden = false
                cell.AttchmentView.isUserInteractionEnabled = true

                let attachmentTap = senderassigments(
                    target: self,
                    action: #selector(AtchmentVc)
                )

                attachmentTap.img_urls = files
                attachmentTap.img_url = files.first
                attachmentTap.imageFileType = upcoming.assignmenttype
                attachmentTap.titee = upcoming.topic
                attachmentTap.descrttt = upcoming.description

                cell.AttchmentView.addGestureRecognizer(attachmentTap)

                // MARK: Multiple attachments

                if files.count > 1 {

                    cell.PlusOneView.isHidden = false
                    cell.PlusOneView.isUserInteractionEnabled = true

                    cell.plusOneCountLabel.isHidden = false
                    cell.plusOneCountLabel.text = "+\(files.count - 1)"

                    let plusOneTap = senderassigments(
                        target: self,
                        action: #selector(AtchmentVc)
                    )

                    plusOneTap.img_urls = files
                    plusOneTap.img_url = files.first
                    plusOneTap.imageFileType = upcoming.assignmenttype
                    plusOneTap.titee = upcoming.topic
                    plusOneTap.descrttt = upcoming.description

                    cell.PlusOneView.addGestureRecognizer(plusOneTap)

                } else {

                    cell.PlusOneView.isHidden = true
                    cell.plusOneCountLabel.isHidden = true
                }

            } else {

                cell.AttchmentView.isHidden = true
                cell.PlusOneView.isHidden = true
                cell.plusOneCountLabel.isHidden = true
            }

            // MARK: Forward

            if upcoming.createdby == memberId {

                cell.forwardView.isHidden = false
                cell.forwardView.isUserInteractionEnabled = true

                let forward = AssigmentDeletes(
                    target: self,
                    action: #selector(ForwardVC)
                )

                forward.assigmentHeaderId = upcoming.assignmentid
                forward.ImgeType = upcoming.assignmenttype
                forward.dateText = upcoming.submissiondate
                forward.titleText = upcoming.topic
                forward.resiveId = "8"
                forward.discreptionForwad = upcoming.description
                forward.newfilePathForWad = upcoming.newfilepath
                forward.fileType = upcoming.assignmenttype

                cell.forwardView.addGestureRecognizer(forward)
            }

            // MARK: Submission

            let hasSubmission =
                upcoming.submittedcount != nil &&
                upcoming.submittedcount != "0"

            if hasSubmission {

                cell.submissionView.isHidden = false
                cell.submissionView.isUserInteractionEnabled = true
                cell.countLabel.textColor = .systemGreen

                let submission = AssigmentDeletes(
                    target: self,
                    action: #selector(AssigmentSubmissionVC)
                )

                submission.assigmentHeaderId = upcoming.assignmentid
                submission.fileType = upcoming.assignmenttype
                submission.memberId = upcoming.createdby

                cell.submissionView.addGestureRecognizer(submission)

            } else {

                cell.submissionView.isHidden = true
                cell.submissionView.isUserInteractionEnabled = false
            }

            // MARK: Not submitted

            cell.notSubmittedView.isUserInteractionEnabled = true

            let notSubmitted = AssigmentDeletes(
                target: self,
                action: #selector(NotSelectdFunc)
            )

            notSubmitted.assigmentHeaderId = upcoming.assignmentid

            cell.notSubmittedView.addGestureRecognizer(notSubmitted)
        }

        // MARK: - PAST

        else if assigmentSegmentName.selectedSegmentIndex == 1 {

            guard indexPath.row < PasrRef.count else {
                return cell
            }

            let past = PasrRef[indexPath.row]

            // MARK: Basic information

            cell.topicLabel.text = past.topic?.capitalized
            cell.descriptionLabel.text = past.description
            cell.creatonLabel.text = past.sentbyname
            cell.countLabel.text = "Submitted : \(past.submittedcount ?? "")"
            cell.notSubLBL.text =
                "Not submitted : " + (past.totalcount ?? "")
            let date = "Due \(past.submissiondate ?? "")"
            cell.dueDateBtn.setTitle(date, for: .normal)
            cell.submissionCountLbl.text = "Submission :\(past.submittedcount ?? "")"
            cell.submissionCountLbl.textColor = past.submittedcount == "0" ? .systemRed : .systemGreen
            if let timing = past.createdon {
                let dateAndTime = timing.components(separatedBy: " - ")
                cell.dateLabel.text = dateAndTime.first ?? ""
                cell.timeLabel.text = dateAndTime.dropFirst().joined(separator: " - ")
            }

            // MARK: Read status

            cell.readDotImageView.isHidden = past.isappread == "1"

            // MARK: Expanded / collapsed

            if let selectedCells = selectedCell,
               selectedCells == indexPath {

                cell.detailsStack.isHidden = false

                let assignmentType = past.assignmenttype?
                    .trimmingCharacters(in: .whitespacesAndNewlines)
                    .lowercased()

                if assignmentType == "text" ||
                    assignmentType == "all" {

                    cell.attachmentStack.isHidden = true

                } else if let files = past.newfilepath,
                          !files.isEmpty {

                    cell.attachmentStack.isHidden = false

                    if files.count > 1 {
                        cell.PlusOneView.isHidden = false
                        cell.plusOneCountLabel.isHidden = false
                        cell.plusOneCountLabel.text = "+\(files.count - 1)"
                    }
                }

            } else {

                cell.detailsStack.isHidden = true
            }

            // MARK: Attachment

            let files = past.newfilepath ?? []

            let assignmentType = past.assignmenttype?
                .trimmingCharacters(in: .whitespacesAndNewlines)
                .lowercased()

            let hasValidAttachment =
                !files.isEmpty &&
                assignmentType != "text" &&
                assignmentType != "all"

            if hasValidAttachment {

                cell.AttchmentView.isUserInteractionEnabled = true
                cell.AttchmentView.isHidden = false

                let attachmentTap = senderassigments(
                    target: self,
                    action: #selector(AtchmentVc)
                )

                attachmentTap.img_urls = files
                attachmentTap.img_url = files.first
                attachmentTap.imageFileType = past.assignmenttype
                attachmentTap.titee = past.topic
                attachmentTap.descrttt = past.description

                cell.AttchmentView.addGestureRecognizer(attachmentTap)

                // MARK: Multiple attachments

                if files.count > 1 {

                    cell.PlusOneView.isHidden = false
                    cell.PlusOneView.isUserInteractionEnabled = true

                    cell.plusOneCountLabel.isHidden = false
                    cell.plusOneCountLabel.text = "+\(files.count - 1)"

                    let plusOneTap = senderassigments(
                        target: self,
                        action: #selector(AtchmentVc)
                    )

                    plusOneTap.img_urls = files
                    plusOneTap.img_url = files.first
                    plusOneTap.imageFileType = past.assignmenttype
                    plusOneTap.titee = past.topic
                    plusOneTap.descrttt = past.description

                    cell.PlusOneView.addGestureRecognizer(plusOneTap)

                } else {

                    cell.PlusOneView.isHidden = true
                    cell.plusOneCountLabel.isHidden = true
                }

            } else {

                cell.AttchmentView.isHidden = true
                cell.PlusOneView.isHidden = true
                cell.plusOneCountLabel.isHidden = true
            }

            // MARK: Forward

            if memberId == past.createdby {

                cell.forwardView.isHidden = false
                cell.forwardView.isUserInteractionEnabled = true

                let forward = AssigmentDeletes(
                    target: self,
                    action: #selector(ForwardVC)
                )

                forward.assigmentHeaderId = past.assignmentid
                forward.ImgeType = past.assignmenttype
                forward.dateText = past.submissiondate
                forward.titleText = past.topic
                forward.resiveId = "8"
                forward.newfilePathForWad = past.newfilepath
                forward.discreptionForwad = past.description
                forward.fileType = past.assignmenttype

                cell.forwardView.addGestureRecognizer(forward)
            }

            // MARK: Submission

            let hasSubmission =
                past.submittedcount != nil &&
                past.submittedcount != "0"

            if hasSubmission {

                cell.submissionView.isHidden = false
                cell.submissionView.isUserInteractionEnabled = true
                cell.countLabel.textColor = .systemGreen

                let submission = AssigmentDeletes(
                    target: self,
                    action: #selector(AssigmentSubmissionVC)
                )

                submission.assigmentHeaderId = past.assignmentid
                submission.fileType = past.assignmenttype

                cell.submissionView.addGestureRecognizer(submission)

            } else {

                cell.submissionView.isHidden = true
                cell.submissionView.isUserInteractionEnabled = false
            }

            // MARK: Not submitted

            cell.notSubmittedView.isUserInteractionEnabled = true

            let notSubmitted = AssigmentDeletes(
                target: self,
                action: #selector(NotSelectdFunc)
            )

            notSubmitted.assigmentHeaderId = past.assignmentid

            cell.notSubmittedView.addGestureRecognizer(notSubmitted)
        }

        return cell
    }
    
    
    @IBAction func AssigmentSubmissionVC(gesture: AssigmentDeletes) {
        
            let vc = AssigmentSubmissionViewController(nibName: nil, bundle: nil)
            vc.assigmentId = gesture.assigmentHeaderId
            vc.assigmentFileType = gesture.fileType
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled ?? ""
            vc.is_write_enabled = is_write_enabled ?? ""
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func ForwardVC(gesture: AssigmentDeletes) {
            
            let vc = PlusScreenNextPageViewController(nibName: nil, bundle: nil)
            
            vc.assigmentHeaderId = gesture.assigmentHeaderId
            vc.Assigment = gesture.resiveId
            vc.strName = strName
            vc.str = str
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.ImgeType = gesture.ImgeType
            vc.fileType = gesture.fileType
            vc.titleText = gesture.titleText
            vc.addImageBackGroundurl = addapiRef.first?.background_image
            vc.smallImageUrl = smallImageUrl
            vc.imageWebUrl = addurls
            vc.forwadDiscreption = gesture.discreptionForwad
            vc.awsPdfURl = gesture.newfilePathForWad ?? []
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func PastDeleteVc(gesture: AssigmentDeletes) {
        
        var imagePdfFileArry = FileNameArray()
        imagePdfFileArry.FileName = ""
        
        var imagePdf = assigmentImagePdfModal()
        
        imagePdf.collegeid = ""
        imagePdf.sectionid = ""
        imagePdf.processtype = "delete"
        imagePdf.staffid = ""
        imagePdf.assignmentdescription = ""
        imagePdf.assignmentid = gesture.assigmentHeaderId
        imagePdf.assignmenttopic = ""
        imagePdf.assignmenttype = ""
        imagePdf.callertype = ""
        imagePdf.courseid = ""
        imagePdf.receiverid = ""
        imagePdf.receivertype = ""
        imagePdf.subjectid = ""
        imagePdf.yearid = ""
        imagePdf.submissiondate = ""
        imagePdf.FileNameArray = [imagePdfFileArry]
        
        print("SenderAssigmentDelete", imagePdf)
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.AssignmentDelete,
            httpMethod: .post,
            queryParam: nil,
            requestBody: imagePdf
        ) { [weak self] (result: Result<[assigmentImagePdfResponce], Error>) in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let particularss):
                
                for i in particularss {
                    
                    self.assigmentImagPdf = particularss
                    
                    let refreshAlert = UIAlertController(
                        title: "",
                        message: i.Message,
                        preferredStyle: .alert
                    )
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default))
                    
                    self.present(refreshAlert, animated: true)
                    
                    self.assigmentTableView.dataSource = self
                    self.assigmentTableView.delegate = self
                    self.assigmentTableView.reloadData()
                    
                    if i.Status == 1 {
                        self.PastRefName()
                    }
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    @IBAction func UpcomingDeleteVc(gesture: AssigmentDeletes) {
        
        var imagePdfFileArry = FileNameArray()
        imagePdfFileArry.FileName = ""
        
        var imagePdf = assigmentImagePdfModal()
        
        imagePdf.collegeid = ""
        imagePdf.sectionid = ""
        imagePdf.processtype = "delete"
        imagePdf.staffid = ""
        imagePdf.assignmentdescription = ""
        imagePdf.assignmentid = gesture.assigmentHeaderId
        imagePdf.assignmenttopic = ""
        imagePdf.assignmenttype = ""
        imagePdf.callertype = ""
        imagePdf.courseid = ""
        imagePdf.receiverid = ""
        imagePdf.receivertype = ""
        imagePdf.subjectid = ""
        imagePdf.yearid = ""
        imagePdf.submissiondate = ""
        imagePdf.FileNameArray = [imagePdfFileArry]
        
        print("yearAndSectionModalStr", imagePdf)
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.AssignmentDelete,
            httpMethod: .post,
            queryParam: nil,
            requestBody: imagePdf
        ) { [weak self] (result: Result<[assigmentImagePdfResponce], Error>) in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let particularss):
                
                for i in particularss {
                    
                    self.assigmentImagPdf = particularss
                    
                    let refreshAlert = UIAlertController(
                        title: "",
                        message: i.Message,
                        preferredStyle: .alert
                    )
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default))
                    
                    self.present(refreshAlert, animated: true)
                    
                    self.assigmentTableView.dataSource = self
                    self.assigmentTableView.delegate = self
                    self.assigmentTableView.reloadData()
                    
                    if i.Status == 1 {
                        self.UpcommingRefName()
                    }
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    @IBAction func AtchmentVc(gesture: senderassigments) {
        
        let vc = MoreImageVcViewController(nibName: nil, bundle: nil)
        
        vc.imageFile = gesture.img_urls
        vc.fileType = gesture.imageFileType
        vc.TopicLbl = gesture.titee
        vc.modalPresentationStyle = .formSheet
        present(vc, animated: true, completion: nil)
        
        assigmentTableView.beginUpdates()
        assigmentTableView.endUpdates()
        assigmentTableView.reloadData()
    }
    
    
    func apread(gesture: String) {
        
        var readApiStatus = AppReadStatusModal()
        
        readApiStatus.msgtype = "assignment"
        readApiStatus.priority = priority
        readApiStatus.userid = memberId
        readApiStatus.detailsid = gesture
        print("sertt", gesture)
        
        APiCallManager.shared.callApi(url: APIEndpoints.Appreadstatus, httpMethod: .post, queryParam: nil, requestBody: readApiStatus) { [weak self] (result: Result<ReadStausApiResponce, Error>) in
            
            guard let self = self else { return }
            
            switch result {
            case .success(_):
                self.assigmentTableView.reloadData()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        assigmentTableView.deselectRow(at: indexPath, animated: true)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Indentifiers, for: indexPath) as! SenderAssigmentTableViewCell
        
        if assigmentSegmentName.selectedSegmentIndex == 0 {
            
            if let selectedCells = selectedCell, selectedCells == indexPath {
                selectedCell = nil
            } else {
                
                selectedCell = indexPath
                let readApiStatus = AppReadStatusModal()
                
                if UpcommingRef[indexPath.row].isappread == "0" {
                    
                    apread(gesture: UpcommingRef[indexPath.row].assignmentdetailid ?? "")
                    
                    UpcommingRef[indexPath.row].isappread = "1"
                    cell.readDotImageView.isHidden = true
                }
            }
            
        } else if assigmentSegmentName.selectedSegmentIndex == 1 {
            
            if let selectedCells = selectedCell, selectedCells == indexPath {
                
                selectedCell = nil
                
            } else {
                
                selectedCell = indexPath
                
                if PasrRef[indexPath.row].isappread == "0" {
                    
                    apread(gesture: PasrRef[indexPath.row].assignmentdetailid ?? "")
                    PasrRef[indexPath.row].isappread = "1"
                    cell.readDotImageView.isHidden = true
                }
            }
        }
        
        assigmentTableView.beginUpdates()
        assigmentTableView.endUpdates()
        assigmentTableView.reloadData()
    }
    
    
    func UpcommingRefName() {
        
        var Upcom = senderUpcommingModal()
        
        Upcom.userid = memberId
        Upcom.collegeid = colgId
        Upcom.departmentid = deptid
        Upcom.sectionid = sectionid
        Upcom.appid = "2"
        Upcom.priority = priority
        Upcom.type = "upcomingassignments"
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.GetAssignmentListByType,
            httpMethod: .post,
            queryParam: nil,
            requestBody: Upcom
        ) { [weak self] (result: Result<senderUpcommingResponces, Error>) in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let success):
                if success.Status == 1 {
                    
                    cloneList = success.data ?? []
                    UpcommingRef = success.data ?? []
                    
                    assigmentTableView.isScrollEnabled = true
                    noDataView.isHidden = true
                    noDataTextLabel.isHidden = true
                    assigmentTableView.delegate = self
                    assigmentTableView.dataSource = self
                    assigmentTableView.reloadData()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [self] in
                        
                        self.loadingCustom.stopAnimating()
                        
                        self.loadingCustom.isHidden = true
                    }
                    
                } else {
                    
                    noDataView.isHidden = false
                    noDataTextLabel.isHidden = false
                    noDataTextLabel.text = success.Message
                    assigmentTableView.delegate = self
                    assigmentTableView.dataSource = self
                    assigmentTableView.reloadData()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [self] in
                        
                        self.loadingCustom.stopAnimating()
                        
                        self.loadingCustom.isHidden = true
                    }
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    
    func PastRefName() {
        var past = senderUpcommingModal()
        
        past.userid = memberId
        
        past.collegeid = colgId
        
        past.departmentid = deptid
        past.sectionid = sectionid
        
        past.appid = "2"
        past.priority = priority
        
        past.type = "pastassignments"
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.GetAssignmentListByType,
            httpMethod: .post,
            queryParam: nil,
            requestBody: past
        ) { [weak self] (result: Result<senderUpcommingResponces, Error>) in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let success):
                if success.Status == 1 {
                    PasrRef = success.data ?? []
                    cloneList = success.data ?? []
                    
                    assigmentTableView.isScrollEnabled = true
                    noDataView.isHidden = true
                    noDataTextLabel.isHidden = true
                    
                    assigmentTableView.delegate = self
                    assigmentTableView.dataSource = self
                    assigmentTableView.reloadData()
                    
                } else {
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
        overall.userid = memberId
        overall.menuid = "5"
        overall.collegeid = colgId
        overall.departmentid = deptid
        overall.sectionid = sectionid
        overall.appid = "2"
        overall.priority = priority
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.GetOverallcountByMenuType,
            httpMethod: .post,
            queryParam: nil,
            requestBody: overall
        ) { [weak self] (result: Result<overAllResponce, Error>) in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let success):
                if success.Status == 1 {
                    overAllRef = success.data ?? []
                    
                    for i in overAllRef {
                        
                        assigmentUpcommingCount.text = i.upcomingassignment
                        assigmentPastCount.text = i.pastassignment
                        
                        if (i.upcomingassignment == "0") && (i.pastassignment == "0") {
                            
                            upcommingcountView.isHidden = true
                            assigmentPastCountView.isHidden = true
                            assigmentCountViews.isHidden = true
                            
                        } else if i.upcomingassignment == "0" {
                            
                            upcommingcountView.isHidden = true
                            assigmentPastCountView.isHidden = false
                            assigmentCountViews.isHidden = false
                            
                        } else if i.pastassignment == "0" {
                            
                            upcommingcountView.isHidden = false
                            assigmentPastCountView.isHidden = true
                            assigmentCountViews.isHidden = false
                            
                        } else {
                            upcommingcountView.isHidden = false
                            assigmentPastCountView.isHidden = false
                            assigmentCountViews.isHidden = false
                        }
                    }
                    
                    let a = Int(assigmentUpcommingCount.text!)
                    let b = Int(assigmentPastCount.text!)
                    let c = (a ?? 0) + (b ?? 0)
                    
                    assigmentTopCount.text = String(c)
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    
    func addApi() {
        
        var add = AddApiModal()
        
        let defaults = UserDefaults.standard
        var deviceToken = defaults.string(forKey: DefaultsKeys.DeviceToken)
        add.device_token = deviceToken
        print("EventDefaultsKeys.DeviceToken", deviceToken as Any)
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
                    addapiRef = success.data ?? []
                    
                    for i in addapiRef {
                        
                        bigImg.sd_setImage(with: URL(string: i.background_image ?? ""), placeholderImage: UIImage(named: "ic_white"))
                        
                        smallImg.sd_setImage(with: URL(string: i.add_image ?? ""), placeholderImage: UIImage(named: "ic_white"))
                        
                        smallImageUrl = i.add_image
                        addImageBackGroundurl = i.background_image
                        addurls = i.add_url
                        
                        let singleTap = senderassAdd(target: self, action: #selector(adLoad))
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
    
    
    @IBAction func adLoad(gesture: senderassAdd) {
        
        let vc = SenderExamAddVcViewController(nibName: nil, bundle: nil)
        vc.AddWebUrl = gesture.url
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
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
        let vc = FaqViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func privacyPolicyRedirect() {
        
        let vc = PrivacyPolicyViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func changePassowrdVC() {
        
        let vc = ChangePasswordVC(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func priorityVc() {
        
        let vc = PriorityScreenVC(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
}


@available(iOS 16.0, *)
extension SenderAssigmentHomePageViewController: CustomTabBarDelegate {
    
    func didTapSearch() {
        searchbar.isHidden = false
        searchFullView.isHidden = false
    }
    
    func didTapSideMenu() {
        sideMenuView.isHidden.toggle()
    }
    
}


class senderassigments: UITapGestureRecognizer {
    
    var img_url: String!
    var imageFileType: String!
    var titee: String!
    var descrttt: String!
    
    var img_urls: [String] = []
    
}

class senderassAdd: UITapGestureRecognizer {
    
    var url: String!
    
}


class AssigmentDeletes: UITapGestureRecognizer {
    
    var assigmentHeaderId: String!
    
    var resiveId: String!
    
    var fileType: String!
    
    var titleText: String!
    
    var dateText: String!
    var ImgeType: String!
    var newfilePathForWad: [String]?
    
    var discreptionForwad: String!
    
    var memberId: String!
}

class forwardAssigment: UITapGestureRecognizer {
    
}
