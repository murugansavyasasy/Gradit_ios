//
//  CommuniSMSViewController.swift
//  Vs_GradItCollege
//
//  Created by admin on 23/01/24.
//

import UIKit
import KRProgressHUD
import ObjectMapper

@available(iOS 16.0, *)
class CommuniSMSViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var plusView: UIViewX!
    @IBOutlet weak var tv: UITableView!
    @IBOutlet weak var searchFullView: UIViewX!
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var customTabBar: CustomTabBar!
    @IBOutlet weak var smallImg: UIImageView!
    @IBOutlet weak var bigImg: UIImageView!
    @IBOutlet weak var logoutView: UIView!
    @IBOutlet weak var changeRolesView: UIView!
    @IBOutlet weak var privacyPolicyView: UIView!
    @IBOutlet weak var faqView: UIView!
    @IBOutlet weak var helpView: UIView!
    @IBOutlet weak var changePasswordView: UIView!
    @IBOutlet weak var termsAndConditionView: UIView!
    @IBOutlet weak var sideMenuView: UIView!
    @IBOutlet weak var communicationcountViews: UIViewX!
    @IBOutlet weak var unreadCountView: UIViewX!
    @IBOutlet weak var readCountView: UIViewX!
    @IBOutlet weak var communication: UILabel!
    @IBOutlet weak var CommuniSegementName: UISegmentedControl!
    @IBOutlet weak var readCountLabel: UILabel!
    @IBOutlet weak var noDataView: UIView!
    @IBOutlet weak var unreadCountLabel: UILabel!
    @IBOutlet weak var noDataTextLabel: UILabel!
    var Textidentifier = "TextMessageTableViewCell"
  
    var overAllRef: [overAllDataDetails] = []
    var addapiRef: [AddDataDeatils] = []
    var is_read_enabled = ""
    var is_write_enabled = ""
    var str: [String] = []
    var ReadData: [SenderCommunicationDataDetails] = []
    var UnReadData: [SenderCommunicationDataDetails] = []
    var cloneList: [SenderCommunicationDataDetails] = []
    var cloneList1: [SenderCommunicationDataDetails] = []
    var strName: [String] = []
    var communicationId = "4"
    var password: String!
    var memberId: String!
    var priority: String!
    var collegeId: String!
    var departmentId: String!
    var sectionId: String!
    var MobileNumber: String!
    var selectedCell: IndexPath?
    var indexPathss: Int!
    var indexPathsections: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideMenuView.isHidden = true
        
        let defaults = UserDefaults.standard
        
        memberId = defaults.string(forKey: DefaultsKeys.memberid)
        priority = defaults.string(forKey: DefaultsKeys.priority)
        collegeId = defaults.string(forKey: DefaultsKeys.collegeid)
        departmentId = defaults.string(forKey: DefaultsKeys.deptid)
        sectionId = defaults.string(forKey: DefaultsKeys.sectionid)
        MobileNumber = defaults.string(forKey: DefaultsKeys.mobileNumber)
        password = defaults.string(forKey: DefaultsKeys.Password)
        
        searchbar.delegate = self
        searchFullView.isHidden = true
        
        tv.delegate = self
        tv.dataSource = self
        
        if sectionId == "" {
            sectionId = "0"
        }
       
        addApi()
        
        if priority == "p4" || priority == "p5" {
            unReadModal()
        } else {
            if is_read_enabled == "1" {
                unReadModal()
            }
        }
        
        overAllRefName()
        
        customTabBar.delegate = self
        
        view.backgroundColor = .priorityColor
        plusView.backgroundColor = UIColor(named: "messagecolor")
        plusView.isHidden = is_write_enabled == "1" ? false : true
        
        if priority == "p4" || priority == "p5" {
            
            plusView.isHidden = true
            
        }else if priority == "p6" {
            readCountView.isHidden = true
            unreadCountView.isHidden = true
            communicationcountViews.isHidden = true
            plusView.isHidden = true
        }
        
        let TextRownib = UINib(nibName: Textidentifier, bundle: nil)
        tv.register(TextRownib, forCellReuseIdentifier: Textidentifier)
        
        noDataView.isHidden = true
        noDataTextLabel.isHidden = true
        
        let plusAddViews = UITapGestureRecognizer(target: self, action: #selector(PlusVc))
        plusView.addGestureRecognizer(plusAddViews)
        
        // tap Bar UiTapGuster.
        
        bigImg.sd_setImage(with: URL(string: "https://gradit.voicesnap.com/files/ads/SchoolChimes_ad.png"), placeholderImage: UIImage(named: "ic_white"))
        
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
    }
    
    
    @IBAction func PlusVc() {
        
        let add = addapiRef.last
        
        let vc = SenderComunicationPlusNextPageViewController(nibName: nil, bundle: nil)
        
        vc.comuncationMenuId = communicationId
        vc.backGroundImage = add?.background_image
        vc.addWebUrl = add?.add_url
        vc.smallImageUrl = add?.add_image
        vc.str = str
        vc.strName = strName
        vc.is_read_enabled = is_read_enabled
        vc.is_write_enabled = is_write_enabled
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if CommuniSegementName.selectedSegmentIndex == 0 {
            let filtered_list: [SenderCommunicationDataDetails] = cloneList
            
            if !searchText.isEmpty {
                let search = searchText.lowercased()
                
                UnReadData = filtered_list.filter {
                    ($0.msgcontent ?? "").lowercased().contains(search) ||
                    ($0.description ?? "").lowercased().contains(search) ||
                    ($0.typename ?? "").lowercased().contains(search) ||
                    ($0.msgdetailsid ?? "").lowercased().contains(search) ||
                    ($0.timing ?? "").lowercased().contains(search) ||
                    ($0.headerid ?? "").lowercased().contains(search) ||
                    ($0.sentby ?? "").lowercased().contains(search)
                }
            } else {
                UnReadData = filtered_list
            }
            
            if UnReadData.count > 0 {
                noDataView.isHidden = true
                noDataTextLabel.isHidden = true
            } else {
                noDataView.isHidden = false
                noDataTextLabel.isHidden = false
                noDataTextLabel.text = "No Records Found"
            }
        } else if CommuniSegementName.selectedSegmentIndex == 1 {
            let filtered_list : [SenderCommunicationDataDetails] = cloneList1
            
            if !searchText.isEmpty {
                let search = searchText.lowercased()
                
                ReadData = filtered_list.filter { item in
                    (item.msgcontent ?? "").lowercased().contains(search) ||
                    (item.description ?? "").lowercased().contains(search) ||
                    (item.typename ?? "").lowercased().contains(search) ||
                    (item.msgdetailsid ?? "").lowercased().contains(search) ||
                    (item.timing ?? "").lowercased().contains(search) ||
                    (item.headerid ?? "").lowercased().contains(search) ||
                    (item.sentby ?? "").lowercased().contains(search)
                }
            } else {
                ReadData = filtered_list
            }
            
            if ReadData.count > 0 {
                noDataView.isHidden = true
                noDataTextLabel.isHidden = true
            } else {
                noDataView.isHidden = false
                noDataTextLabel.isHidden = false
                noDataTextLabel.text = "No Records Found"
            }
        }
        
        tv.reloadData()
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
        noDataView.isHidden = true
        noDataTextLabel.isHidden = true
        searchbar.resignFirstResponder()
    }
    
    @IBAction func communiSegmentAction(_ sender: Any) {
        
        guard is_read_enabled == "1" else { return }
        
        searchbar.searchTextField.text = ""
        
        if CommuniSegementName.selectedSegmentIndex == 0 {
            selectedCell = IndexPath()
            tv.isScrollEnabled = false
            unReadModal()
        }else {
            selectedCell = IndexPath()
            tv.isScrollEnabled = false
            ReadApi()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return CommuniSegementName.selectedSegmentIndex == 0 ? UnReadData.count : ReadData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Textidentifier, for: indexPath) as! TextMessageTableViewCell
        
        cell.selectionStyle = .none
        
        if let selectedCell = selectedCell, selectedCell == indexPath {
            cell.discreptionsLbl.isHidden = false
            cell.arrowImage.image = UIImage(systemName: "chevron.up")
            cell.sendByView.isHidden = false
        } else {
            cell.arrowImage.image = UIImage(systemName: "chevron.down")
            cell.discreptionsLbl.isHidden = true
            cell.sendByView.isHidden = true
        }
        
        if CommuniSegementName.selectedSegmentIndex == 0 {
            let comuCell: SenderCommunicationDataDetails = UnReadData[indexPath.row]
            
            if comuCell.isappread == "1" {
                cell.redDotImgView.isHidden = true
            } else {
                cell.redDotImgView.isHidden = false
            }
            
            cell.MsgContentLbl.text = comuCell.msgcontent
            cell.discreptionsLbl.text = comuCell.description?.capitalized
            cell.SendByLbl.text = comuCell.sentby
            
            if let timing = comuCell.timing {
                let dateAndTime = timing.components(separatedBy: " - ")
                cell.dateLbl.text = dateAndTime.first ?? ""
                cell.timeLbl.text = dateAndTime.dropFirst().joined(separator: " - ")
            }
            
        } else if CommuniSegementName.selectedSegmentIndex == 1 {
            let unreadCell: SenderCommunicationDataDetails = ReadData[indexPath.row]
            
            if unreadCell.isappread == "1" {
                cell.redDotImgView.isHidden = true
            } else {
                cell.redDotImgView.isHidden = false
            }
            
            cell.MsgContentLbl.text = unreadCell.msgcontent
            cell.discreptionsLbl.text = unreadCell.description?.capitalized
            cell.SendByLbl.text = unreadCell.sentby
            
            if let timing = unreadCell.timing {
                let dateAndTime = timing.components(separatedBy: " - ")
                cell.dateLbl.text = dateAndTime.first ?? ""
                cell.timeLbl.text = dateAndTime.dropFirst().joined(separator: " - ")
            }
        }
         
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: Textidentifier, for: indexPath) as! TextMessageTableViewCell
        
        if CommuniSegementName.selectedSegmentIndex == 0 {
            if let selectedCells = selectedCell, selectedCells == indexPath {
                selectedCell = nil
            } else {
                selectedCell = indexPath
                
                if UnReadData[indexPath.row].isappread == "0" {
                    apread(gesture: UnReadData[indexPath.row].msgdetailsid ?? "")
                    
                    UnReadData[indexPath.row].isappread = "1"
                    cell.redDotImgView.isHidden = true
                }
            }
        } else if CommuniSegementName.selectedSegmentIndex == 1 {
            if let selectedCells = selectedCell, selectedCells == indexPath {
                indexPathsections = indexPath.section
                selectedCell = nil
            } else {
                selectedCell = indexPath
                indexPathss = indexPath.row
            }
        }
        
        tv.beginUpdates()
        tv.endUpdates()
        tv.reloadData()
    }
    
    func apread(gesture: String) {
        
        var readApiStatus = AppReadStatusModal()
        
        readApiStatus.msgtype = "Text"
        readApiStatus.priority = priority
        readApiStatus.userid = memberId
        readApiStatus.detailsid = gesture
        
        APiCallManager.shared.callApi(url: APIEndpoints.Appreadstatus, httpMethod: .post, queryParam: nil, requestBody: readApiStatus) { [weak self] (result: Result<ReadStausApiResponce, Error>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let success):
                
                tv.reloadData()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    
    func ReadApi() {
        var Commu = SenderCommunicationModal()
        
        Commu.userid = memberId
        Commu.priority = priority
        Commu.readtype = "1"
        Commu.appid = "2"
        
        APiCallManager.shared.callApi(url: APIEndpoints.GetTextMessageBytype, httpMethod: .post, queryParam: nil, requestBody: Commu) { [weak self] (result: Result<SenderCommunicationResponse, Error>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let communicationResp):
                if communicationResp.Status == 1 {
                    ReadData = communicationResp.data ?? []
                    cloneList1 = communicationResp.data ?? []
                    tv.isScrollEnabled = true
                    noDataView.isHidden = true
                    noDataTextLabel.isHidden = true
                    tv.isHidden = false
                    tv.reloadData()
                } else {
                    noDataView.isHidden = false
                    noDataTextLabel.isHidden = false
                    noDataTextLabel.text = communicationResp.Message
                    tv.isHidden = true
                    tv.reloadData()
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    
    func unReadModal() {
        
        var unreads = SenderCommunicationModal()
        
        unreads.userid = memberId
        unreads.priority = priority
        unreads.readtype = "0"
        unreads.appid = "2"
        
        APiCallManager.shared.callApi(url: APIEndpoints.GetTextMessageBytype, httpMethod: .post, queryParam: nil, requestBody: unreads) { [weak self] (result: Result<SenderCommunicationResponse, Error>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let UnReadcommunicationResp):
                if UnReadcommunicationResp.Status == 1 {
                    UnReadData = UnReadcommunicationResp.data ?? []
                    cloneList = UnReadcommunicationResp.data ?? []
                    tv.isScrollEnabled = true
                    noDataView.isHidden = true
                    noDataTextLabel.isHidden = true
                    tv.isHidden = false
                    tv.reloadData()
                } else {
                    noDataTextLabel.text = UnReadcommunicationResp.Message
                    noDataView.isHidden = false
                    noDataTextLabel.isHidden = false
                    tv.isScrollEnabled = true
                    tv.isHidden = true
                    tv.reloadData()
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    
    func overAllRefName() {
        var overall = overAllModal()
        
        overall.userid = memberId
        overall.menuid = "17"
        overall.collegeid = collegeId
        overall.departmentid = departmentId
        overall.sectionid = sectionId
        overall.appid = "2"
        overall.priority = priority
        
        APiCallManager.shared.callApi(url: APIEndpoints.GetOverallcountByMenuType, httpMethod: .post, queryParam: nil, requestBody: overall) { [weak self] (result: Result<overAllResponce, Error>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let success):
                if success.Status == 1 {
                    overAllRef = success.data ?? []
                    
                    for i in overAllRef {
                        unreadCountLabel.text = i.unread
                        readCountLabel.text = i.read
                        
                        if (i.unread == "0") && (i.read == "0") {
                            unreadCountView.isHidden = true
                            readCountView.isHidden = true
                            communicationcountViews.isHidden = true
                        } else if i.unread == "0" {
                            unreadCountView.isHidden = true
                            readCountView.isHidden = false
                            communicationcountViews.isHidden = false
                        } else if i.read == "0" {
                            readCountView.isHidden = true
                            unreadCountView.isHidden = false
                            communicationcountViews.isHidden = false
                        } else {
                            unreadCountView.isHidden = false
                            readCountView.isHidden = false
                            communicationcountViews.isHidden = false
                        }
                    }
                    
                    let a = Int(unreadCountLabel.text!)
                    let b = Int(readCountLabel.text!)
                    let c = a! + b!
                    communication.text = String(c)
                } else {
                    unreadCountView.isHidden = true
                    readCountView.isHidden = true
                    communicationcountViews.isHidden = true
                }
            case .failure(let error):
                print("Error: \(error)")
                unreadCountView.isHidden = true
                readCountView.isHidden = true
                communicationcountViews.isHidden = true
            }
        }
    }
    
    
    func addApi() {
        var add = AddApiModal()
        
        let defaults = UserDefaults.standard
        var deviceToken = defaults.string(forKey: DefaultsKeys.DeviceToken)
        add.device_token = deviceToken
        add.member_id = Int(memberId)
        add.mobile_no = MobileNumber
        add.priority = priority
        add.college_id = Int(collegeId)
        add.previous_add_id = 1
        
        APiCallManager.shared.callApi(url: APIEndpoints.GetAddsForCollege, httpMethod: .post, queryParam: nil, requestBody: add) { [weak self] (result: Result<AddApiResponce, Error>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let success):
                if success.Status == 1 {
                    addapiRef = success.data ?? []
                    
                    for i in addapiRef {
                        bigImg.sd_setImage(with: URL(string: i.background_image ?? ""), placeholderImage: UIImage(named: "ic_white"))
                        
                        smallImg.sd_setImage(with: URL(string: i.add_image ?? ""), placeholderImage: UIImage(named: "ic_white"))
                    }
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
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
extension CommuniSMSViewController : CustomTabBarDelegate {
    func didTapSearch() {
        searchbar.isHidden = false
        searchFullView.isHidden = false
    }
    
    func didTapSideMenu() {
        sideMenuView.isHidden.toggle()
    }
}
