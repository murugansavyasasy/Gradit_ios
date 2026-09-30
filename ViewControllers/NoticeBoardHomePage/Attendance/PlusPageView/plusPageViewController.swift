//
//  plusPageViewController.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 20/03/23.
//

import UIKit
import DropDown
import KRProgressHUD

@available(iOS 16.0, *)
class plusPageViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var noOfdateLabel: UILabel!
    @IBOutlet weak var leaveTypDropDownView: UIViewX!
    @IBOutlet weak var confirmView: UIViewX!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var dropDownLabel: UILabel!
    @IBOutlet weak var toDateLabel: UILabel!
    @IBOutlet weak var fromDateLabel: UILabel!
    @IBOutlet weak var calanderTopHeight: NSLayoutConstraint!
    @IBOutlet weak var calandViewss: UIView!
    @IBOutlet weak var tapBarView: UIViewX!
    @IBOutlet weak var reason: UITextView!
    @IBOutlet weak var toDateView: UIView!
    @IBOutlet weak var fromDateView: UIView!
    @IBOutlet weak var topMemberLabel: UILabel!
    @IBOutlet weak var changeRolesView: UIView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var topLabels: UILabel!
    @IBOutlet weak var clgLogoImg: UIImageView!
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var privacyPolicyView: UIView!
    @IBOutlet weak var cancelssView: UIViewX!
    @IBOutlet weak var faqView: UIView!
    @IBOutlet weak var refreshView: UIView!
    @IBOutlet weak var viewTap: UIView!
    @IBOutlet weak var sideMenuView: UIView!
    @IBOutlet weak var helpView: UIView!
    @IBOutlet weak var termsAndConditionView: UIView!
    @IBOutlet weak var changePasswordView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var bigImg: UIImageView!
    @IBOutlet weak var redirectLoginView: UIViewX!
    @IBOutlet weak var smallImg: UIImageView!
    
    private enum Text {
        static let reasonPlaceholder = "Enter the Reason"
        static let datePlaceholder = "dd/mm/yyyy"
        static let noOfDaysPlaceholder = "No of days"
        static let leaveTypePlaceholder = "Select type of Leave"
    }
    private let maxReasonLength = 500
    let dropDown = DropDown()
    let defaults = UserDefaults.standard
    
    var stafId: String!
    var collegeId: String!
    var section: String!
    var leaveTypeId: [String] = []
    var nameString: String!
    var PreviousAddId: Int!
    var types: String!
    var fromDateString: String?
    var toDateString: String?
    var reasonss: String!
    var headerId: String!
    var activeDateField: String?
    var fromDate: Date?
    var toDate: Date?
    var NoOfDays: Int?
    
    let displayFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy"
        return df
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        sideMenuView.isHidden = true
        lblCount.text = ""
        reason.delegate = self
        
        if types == "1" {
            fromDateLabel.text = Text.datePlaceholder
            toDateLabel.text = Text.datePlaceholder
            noOfdateLabel.text = Text.noOfDaysPlaceholder
            reason.text = Text.reasonPlaceholder
            reason.textColor = .lightGray
        } else {
            let apiFormatter = DateFormatter()
            apiFormatter.dateFormat = "dd MMM yyyy"
            apiFormatter.locale = Locale(identifier: "en_US_POSIX")
            if let from = apiFormatter.date(from: fromDateString ?? "") {
                fromDate = from
                fromDateLabel.text = displayFormatter.string(from: from)
            }
            if let to = apiFormatter.date(from: toDateString ?? "") {
                toDate = to
                toDateLabel.text = displayFormatter.string(from: to)
            }
            calculateDays()
            reason.text = reasonss
            reason.textColor = .black
        }
        
        stafId = defaults.string(forKey: DefaultsKeys.memberid)
        collegeId = defaults.string(forKey: DefaultsKeys.collegeid)
        section = defaults.string(forKey: DefaultsKeys.sectionid)
        topMemberLabel.text = defaults.string(forKey: DefaultsKeys.memberName)
        let colgImg = defaults.string(forKey: DefaultsKeys.colglogo) ?? ""
        clgLogoImg.sd_setImage(with: URL(string: colgImg), placeholderImage: UIImage(named: "EmptyCollegeIcon"))
        topLabels.text = .priorityRole
        tapBarView.backgroundColor = .priorityColor
        
        addApi()
        LeavedropDrop()
        setupGestures()
    }
    
    private func addTap(to view: UIView, action: Selector) {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: action))
    }
    
    private func setupGestures() {
        addTap(to: leaveTypDropDownView, action: #selector(dropDownVc))
        addTap(to: confirmView, action: #selector(ConfirmVc))
        addTap(to: fromDateView, action: #selector(FromdateVc))
        addTap(to: toDateView, action: #selector(TodateVc))
        addTap(to: cancelssView, action: #selector(BackBtn(_:)))
        addTap(to: viewTap, action: #selector(menu))
        addTap(to: notificationView, action: #selector(notificationVc))
        addTap(to: refreshView, action: #selector(refreshVc))
        addTap(to: faqView, action: #selector(faqRedirect))
        addTap(to: loginView, action: #selector(logoutPressed))
        addTap(to: helpView, action: #selector(helpRedirect))
        addTap(to: privacyPolicyView, action: #selector(privacyPolicyRedirect))
        addTap(to: termsAndConditionView, action: #selector(termsAndCondition))
        addTap(to: profileView, action: #selector(profileRedirect))
        addTap(to: changePasswordView, action: #selector(changePassowrdVC))
        addTap(to: changeRolesView, action: #selector(priorityVc))
        addTap(to: redirectLoginView, action: #selector(priorityVc))
    }
    
    private func presentFullScreen(_ vc: UIViewController, animated: Bool = true) {
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: animated, completion: nil)
    }
    
    @IBAction func BackBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func ConfirmVc() {
        if dropDownLabel.text == Text.leaveTypePlaceholder {
            AlertHelper.showOKAlert(on: self, title: "", message: "Please Select Leave type")
        } else if fromDateLabel.text == Text.datePlaceholder {
            AlertHelper.showOKAlert(on: self, title: "", message: "From Date Field is Empty")
        } else if toDateLabel.text == Text.datePlaceholder {
            AlertHelper.showOKAlert(on: self, title: "", message: "To Date Field is Empty")
        } else if noOfdateLabel.text == Text.noOfDaysPlaceholder {
            AlertHelper.showOKAlert(on: self, title: "", message: "No Of Date Field is Empty")
        } else if reason.text == Text.reasonPlaceholder || reason.text.isEmpty {
            AlertHelper.showOKAlert(on: self, title: "", message: "Please fill the Valid reason")
        } else {
            manageLeaveResponce()
        }
    }
    
    @IBAction func dropDownVc() {
        dropDown.show()
    }
    
    @IBAction func menu() {
        sideMenuView.isHidden.toggle()
    }
    
    @IBAction func done(_ sender: Any) {
        calandViewss.isHidden = true
        calanderTopHeight.constant = 0
    }
    
    @IBAction func FromdateVc() {
        activeDateField = "from"
        RPicker.selectDate(title: "Select From Date",
                           cancelText: "Cancel",
                           datePickerMode: .date,
                           minDate: nil,
                           style: .Inline,
                           didSelectDate: { [weak self] selectedDate in
            guard let self = self else { return }
            self.fromDate = selectedDate
            self.toDate = nil
            self.fromDateLabel.text = selectedDate.dateString("dd/MM/yyyy")
            self.toDateLabel.text = Text.datePlaceholder
        })
    }
    
    @IBAction func TodateVc() {
        guard let start = fromDate else {
            AlertHelper.showOKAlert(on: self, title: "", message: "Select from date first")
            return
        }
        activeDateField = "to"
        RPicker.selectDate(title: "Select To Date",
                           cancelText: "Cancel",
                           datePickerMode: .date,
                           minDate: start,
                           style: .Inline,
                           didSelectDate: { [weak self] selectedDate in
            guard let self = self else { return }
            self.toDate = selectedDate
            self.toDateLabel.text = selectedDate.dateString("dd/MM/yyyy")
            self.calculateDays()
        })
    }
    
    @IBAction func dte(_ sender: UIDatePicker) {
        if activeDateField == "from" {
            fromDate = sender.date
            fromDateLabel.text = displayFormatter.string(from: sender.date)
        } else {
            toDate = sender.date
            toDateLabel.text = displayFormatter.string(from: sender.date)
        }
        calculateDays()
    }
    
    func calculateDays() {
        guard let start = fromDate, let end = toDate else { return }
        
        if end < start {
            noOfdateLabel.text = "Invalid Date"
            return
        }
        
        let days = Calendar.current.dateComponents([.day], from: start, to: end).day ?? 0
        noOfdateLabel.text = "\(days + 1) days"
        NoOfDays = days
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == Text.reasonPlaceholder {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = Text.reasonPlaceholder
            textView.textColor = .lightGray
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        lblCount.text = "\(textView.text.count)/\(maxReasonLength)"
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        if text == "\n" {
            textView.resignFirstResponder()
        }
        return newText.count < maxReasonLength
    }
    
    func addApi() {
        var add = AddApiModal()
        add.device_token = defaults.string(forKey: DefaultsKeys.DeviceToken)
        add.member_id = Int(stafId)
        add.mobile_no = defaults.string(forKey: DefaultsKeys.mobileNumber)
        add.priority = defaults.string(forKey: DefaultsKeys.priority)
        add.college_id = Int(collegeId)
        add.previous_add_id = PreviousAddId
        
        APiCallManager.shared.callApi(url: APIEndpoints.GetAddsForCollege,
                                      httpMethod: .post,
                                      queryParam: nil,
                                      requestBody: add
        ) { [weak self] (result: Result<AddApiResponce, Error>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let success):
                guard success.Status == 1 else { return }
                for ad in success.data ?? [] {
                    self.bigImg.sd_setImage(with: URL(string: ad.background_image ?? ""), placeholderImage: UIImage(named: "ic_white"))
                    self.smallImg.sd_setImage(with: URL(string: ad.add_image ?? ""), placeholderImage: UIImage(named: "ic_white"))
                    
                    let singleTap = addvertisementPlus(target: self, action: #selector(self.adLoad))
                    singleTap.url = ad.add_url
                    self.bigImg.isUserInteractionEnabled = true
                    self.bigImg.addGestureRecognizer(singleTap)
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func LeavedropDrop() {
        var leaveTypes = GetLeaveTypeModal()
        leaveTypes.appid = "1"
        leaveTypes.userid = stafId
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.GetLeaveType,
            httpMethod: .post,
            queryParam: nil,
            requestBody: leaveTypes
        ) { [weak self] (result: Result<GetLeaveTypeResponce, Error>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let success):
                let leaveList = success.data ?? []
                self.leaveTypeId = leaveList.map { $0.leavetypeid ?? "" }
                
                self.dropDownLabel.text = Text.leaveTypePlaceholder
                self.dropDown.anchorView = self.leaveTypDropDownView
                self.dropDown.dataSource = leaveList.map { $0.leavetypename ?? "" }
                self.dropDown.bottomOffset = CGPoint(x: 0, y: self.dropDown.anchorView?.plainView.bounds.height ?? 0)
                self.dropDown.direction = .bottom
                DropDown.appearance().backgroundColor = UIColor.white
                self.dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                    self.dropDownLabel.text = item
                    self.nameString = self.leaveTypeId[index]
                }
                
            case .failure(let failure):
                print("Error:", failure.localizedDescription)
            }
        }
    }
    
    func manageLeaveResponce() {
        var mangeLeave = manageLeaveModal()
        mangeLeave.leavetypeid = nameString
        mangeLeave.clgsectionid = section
        mangeLeave.colgid = collegeId
        mangeLeave.leavefromdate = fromDateLabel.text
        mangeLeave.leavereason = reason.text
        mangeLeave.leavetodate = toDateLabel.text
        mangeLeave.memberid = stafId
        mangeLeave.numofdays = String(NoOfDays ?? 0)
        
        if types == "1" {
            mangeLeave.processtype = "add"
            mangeLeave.applicationid = "0"
        } else {
            mangeLeave.processtype = "edit"
            mangeLeave.applicationid = headerId
        }
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.ManageLeaveapplication,
            httpMethod: .post,
            queryParam: nil,
            requestBody: mangeLeave
        ) { [weak self] (result: Result<manageLeaveResponce, Error>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let success):
                AlertHelper.showOKAlert(on: self, title: "", message: success.Message)
            case .failure(let failure):
                AlertHelper.showOKAlert(on: self, title: "", message: failure.localizedDescription)
            }
        }
    }
    
    @IBAction func adLoad(gesture: addvertisementPlus) {
        let vc = ShowExaminationAddViewController(nibName: nil, bundle: nil)
        vc.addString = gesture.url
        presentFullScreen(vc)
    }
    
    @IBAction func helpRedirect() {
        presentFullScreen(HelpViewController(nibName: nil, bundle: nil))
    }
    
    @IBAction func termsAndCondition() {
        presentFullScreen(MenuTermsViewController(nibName: nil, bundle: nil))
    }
    
    @IBAction func faqRedirect() {
        presentFullScreen(FaqViewController(nibName: nil, bundle: nil))
    }
    
    @IBAction func privacyPolicyRedirect() {
        presentFullScreen(PrivacyPolicyViewController(nibName: nil, bundle: nil))
    }
    
    @IBAction func notificationVc() {
        presentFullScreen(NotificationViewController(nibName: nil, bundle: nil), animated: false)
    }
    
    @IBAction func changePassowrdVC() {
        presentFullScreen(ChangePasswordVC(nibName: nil, bundle: nil))
    }
    
    @IBAction func profileRedirect() {
        presentFullScreen(ProfileViewController(nibName: nil, bundle: nil))
    }
    
    @IBAction func priorityVc() {
        presentFullScreen(PriorityScreenVC(nibName: nil, bundle: nil))
    }
    
    @IBAction func logoutPressed() {
        AlertHelper.showOKCancelAlert(on: self, title: "", message: "Are you sure do you want to logout", okTitle: "YES", cancelTitle: "NO", okAction: {
            UserDefaults.standard.removeObject(forKey: DefaultsKeys.mobileNumber)
            self.presentFullScreen(LoginVc(nibName: nil, bundle: nil))
        })
    }
    
    @IBAction func refreshVc() {
        KRProgressHUD.show()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            KRProgressHUD.dismiss()
        }
    }
}

class addvertisementPlus: UITapGestureRecognizer {
    var url: String!
}
