//
//  CommunicationHomePageViewController.swift
//  GraditCommuniMenu
//
//  Created by MACBOOKPRO on 21/11/22.
//

import UIKit
import ObjectMapper
import AVFoundation
import WebKit
import KRProgressHUD


@available(iOS 16.0, *)
class CommunicationHomePageViewController: UIViewController, UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    
    @IBOutlet weak var tapBarView: CustomTabBar!
    @IBOutlet weak var searchFullView: UIViewX!
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var privacyPolicyView: UIView!
    @IBOutlet weak var faqView: UIView!
    @IBOutlet weak var changePasswordView: UIView!
    @IBOutlet weak var logoutView: UIView!
    @IBOutlet weak var helpView: UIView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var termsAndConditionView: UIView!
    @IBOutlet weak var changeRolesView: UIView!
    @IBOutlet weak var sideMenuView: UIView!
    @IBOutlet weak var communicationCountView: UIViewX!
    @IBOutlet weak var unreadCountView: UIViewX!
    @IBOutlet weak var readCountView: UIViewX!
    @IBOutlet weak var communiTableView: UITableView!
    @IBOutlet weak var communication: UILabel!
    @IBOutlet weak var CommuniSegementName: UISegmentedControl!
    @IBOutlet weak var noDataView: UIView!
    @IBOutlet weak var readCountLabel: UILabel!
    @IBOutlet weak var noDataTextLabel: UILabel!
    @IBOutlet weak var unreadCountLabel: UILabel!
    @IBOutlet weak var bigImg: UIImageView!
    
    
    var idss : Int!
    var Textidentifier = "SenderCommuTextTableViewCell"
    var addapiRef : [AddDataDeatils] = []
    var ReadData : [ReadCommunicationDetails] = []
    var UnReadData : [ReadCommunicationDetails] = []
    var overAllRef    : [overAllDataDetails] = []
    var readApiRef : readStatusResponce!
    var player:AVPlayer?
    var selectedCell : IndexPath?
    var memberId : String!
    var priority : String!
    var collegeId : String!
    var departmentId : String!
    var sectionId : String!
    var MobileNumber : String!
    var PreviousAddId : Int = 0
    var password : String!
    var str : [String] = []
    var strName : [String] = []
    var type = ""
    var cloneList :  [ReadCommunicationDetails] = []
    var is_read_enabled : String!
    var is_write_enabled : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        
        PreviousAddId = PreviousAddId+1
        searchbar.delegate = self
        searchbar.isHidden  = true
        searchFullView .isHidden = true
        noDataView.isHidden = true
        noDataTextLabel.isHidden = true
        sideMenuView.isHidden = true
        
        let defaults = UserDefaults.standard
        
        memberId = defaults.string(forKey: DefaultsKeys.memberid)
        priority = defaults.string(forKey: DefaultsKeys.priority)
        collegeId = defaults.string(forKey: DefaultsKeys.collegeid)
        departmentId = defaults.string(forKey: DefaultsKeys.deptid)
        sectionId = defaults.string(forKey: DefaultsKeys.sectionid)
        MobileNumber = defaults.string(forKey: DefaultsKeys.mobileNumber)
        
        password = defaults.string(forKey: DefaultsKeys.Password)
        PreviousAddId = PreviousAddId+1
        
        tapBarView.delegate = self
        
        communiTableView.delegate = self
        communiTableView.dataSource = self
        
        addApi()
        
        overAllRefName()
        
        unReadModal()
       
        view.backgroundColor = .priorityColor
        
        let TextRownib = UINib(nibName: Textidentifier, bundle: nil)
        communiTableView.register(TextRownib, forCellReuseIdentifier: Textidentifier)
        
        communiTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 85, right: 0)
        communiTableView.rowHeight = UITableView.automaticDimension
        
        let changeRolesGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        changeRolesView.addGestureRecognizer(changeRolesGesture)
        
        let termsAndConditionGesture = UITapGestureRecognizer(target: self, action: #selector(termsAndCondition))
        termsAndConditionView.addGestureRecognizer(termsAndConditionGesture)
        
        let profileGesture = UITapGestureRecognizer(target: self, action: #selector(profileRedirect))
        profileView.addGestureRecognizer(profileGesture)
        //
        let helpGesture = UITapGestureRecognizer(target: self, action: #selector(helpRedirect))
        helpView.addGestureRecognizer(helpGesture)
        
        let logoutGesture = UITapGestureRecognizer(target: self, action: #selector(logoutPressed))
        logoutView.addGestureRecognizer(logoutGesture)
        
        let chagePassword = UITapGestureRecognizer(target: self, action: #selector(changePassowrdVC))
        changePasswordView.addGestureRecognizer(chagePassword)
        
        let faqGesture = UITapGestureRecognizer(target: self, action: #selector(faqRedirect))
        faqView.addGestureRecognizer(faqGesture)
        
        let privacyPolicyGesture = UITapGestureRecognizer(target: self, action: #selector(privacyPolicyRedirect))
        privacyPolicyView.addGestureRecognizer(privacyPolicyGesture)
        
    }
    
    @objc func dismissKeyboards() {
        
        sideMenuView.isHidden = true
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if CommuniSegementName.selectedSegmentIndex == 0{
            
            let filtered_list : [ReadCommunicationDetails] = cloneList
            
            if !searchText.isEmpty{
                
                let search = searchText.lowercased()

                UnReadData = filtered_list.filter {
                    ($0.description ?? "").lowercased().contains(search) ||
                    ($0.typename ?? "").lowercased().contains(search) ||
                    ($0.msgdetailsid ?? "").lowercased().contains(search) ||
                    ($0.timing ?? "").lowercased().contains(search) ||
                    ($0.headerid ?? "").lowercased().contains(search) ||
                    ($0.sentby ?? "").lowercased().contains(search)
                }
                
            }else{
                
                UnReadData = filtered_list
                print("pendingOrder")
            }
            
            
            if UnReadData.count > 0{
                
                noDataView.isHidden = true
                noDataTextLabel.isHidden = true
            }else{
                
                noDataView.isHidden = false
                noDataTextLabel.isHidden = false
                noDataTextLabel.text = "No Records Found"
            }
        }
        
        else if CommuniSegementName.selectedSegmentIndex == 1{
            
            let filtered_list : [ReadCommunicationDetails] = cloneList
            
            if !searchText.isEmpty{
                
                let search = searchText.lowercased()

                ReadData = filtered_list.filter {
                    ($0.msgcontent ?? "").lowercased().contains(search) ||
                    ($0.description ?? "").lowercased().contains(search) ||
                    ($0.typename ?? "").lowercased().contains(search) ||
                    ($0.msgdetailsid ?? "").lowercased().contains(search) ||
                    ($0.timing ?? "").lowercased().contains(search) ||
                    ($0.headerid ?? "").lowercased().contains(search) ||
                    ($0.sentby ?? "").lowercased().contains(search)
                }
                
            }else{
                
                ReadData = filtered_list
            }
            
            if ReadData.count > 0{
                
                print ("searchListPendigCount",ReadData.count)
                
                noDataView.isHidden = true
                noDataTextLabel.isHidden = true
                
            }else{
                
                noDataView.isHidden = false
                noDataTextLabel.isHidden = false
                noDataTextLabel.text = "No Records Found"
            }
        }
        
        communiTableView.reloadData()
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
    
    @IBAction func communiSegmentAction(_ sender: Any) {
        
        searchbar.searchTextField.text = ""
        if is_read_enabled == "1"{
            
            if CommuniSegementName.selectedSegmentIndex == 0{
                communiTableView.isScrollEnabled = false
                selectedCell = IndexPath()
                overAllRefName()
                unReadModal()
            }else if CommuniSegementName.selectedSegmentIndex ==  1 {
                communiTableView.isScrollEnabled = false
                selectedCell = IndexPath()
                overAllRefName()
                ReadApi()
            }
        }
    }
    
    func ReadApi() {
        
        var Commu = ReadModal()
        
        Commu.userid = memberId
        Commu.priority = priority
        Commu.readtype = "1"
        Commu.appid = "2"
        APiCallManager.shared.callApi(
            url: APIEndpoints.GetVoiceMessageBytype,
            httpMethod: .post,
            queryParam: nil,
            requestBody: Commu
        ) {[weak self] (result:Result<ReadcommunicationResponce, Error>) in
            
            guard let self = self else {return}
            switch result {
            case .success(let communicationResp):
                if communicationResp.Status == 1{
                    ReadData = communicationResp.data ?? []
                    cloneList = communicationResp.data ?? []
                    noDataView.isHidden = true
                    communiTableView.isScrollEnabled = true
                    noDataTextLabel.isHidden = true
                    communiTableView.reloadData()
                }else{
                    
                    noDataView.isHidden = false
                    noDataTextLabel.isHidden = false
                    noDataTextLabel.text = communicationResp.Message
                    communiTableView.reloadData()
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    
    func unReadModal() {
        
        var unreads = ReadModal()
        
        unreads.userid = memberId
        unreads.priority = priority
        unreads.readtype = "0"
        unreads.appid = "2"
        APiCallManager.shared.callApi(
            url: APIEndpoints.GetVoiceMessageBytype,
            httpMethod: .post,
            queryParam: nil,
            requestBody: unreads
        ) {[weak self] (result:Result<ReadcommunicationResponce , Error>) in
            guard let self = self else {return}
            switch result {
            case .success(let UnReadcommunicationResp):
                if UnReadcommunicationResp.Status == 1{
                    
                    UnReadData = UnReadcommunicationResp.data ?? []
                    cloneList = UnReadcommunicationResp.data ?? []
                    communiTableView.isScrollEnabled = true
                    noDataView.isHidden = true
                    noDataTextLabel.isHidden = true
                    communiTableView.reloadData()
                    
                }else{
                    
                    noDataView.isHidden = false
                    noDataTextLabel.isHidden = false
                    noDataTextLabel.text = UnReadcommunicationResp.Message
                    communiTableView.reloadData()
                    
                }
            case .failure(let error):
                print("Erro: \(error.localizedDescription)")
            }
        }
    }
    
    
    func overAllRefName() {
        
        var overall = overAllModal()
        
        overall.userid   =  memberId
        overall.menuid       = "16"
        overall.collegeid    =  collegeId
        overall.departmentid =  departmentId
        overall.sectionid    =   sectionId
        overall.appid        = "2"
        overall.priority     = priority
        
        APiCallManager.shared.callApi(url: APIEndpoints.GetOverallcountByMenuType, httpMethod: .post, queryParam: nil, requestBody: overall) { [weak self] (result:Result<overAllResponce,Error>) in
            guard let self = self else{return}
            switch result{
            case .success(let success):
                
                if success.Status == 1{
                    overAllRef = success.data ?? []
                    
                    for i in overAllRef{
                        
                        unreadCountLabel.text = i.unread
                        readCountLabel.text = i.read
                        if (i.unread == "0") && (i.read == "0"){
                            
                            unreadCountView.isHidden = true
                            readCountView.isHidden = true
                            communicationCountView.isHidden = true
                            
                        }
                        
                        else if i.unread == "0"{
                            
                            unreadCountView.isHidden = true
                            readCountView.isHidden = false
                            communicationCountView.isHidden = false
                            
                        }
                        
                        else if i.read == "0"{
                            
                            unreadCountView.isHidden = false
                            readCountView.isHidden = true
                            communicationCountView.isHidden = false
                            
                        }
                        
                        else{
                            
                            unreadCountView.isHidden = false
                            readCountView.isHidden = false
                            communicationCountView.isHidden = false
                            
                        }
                        
                    }
                    
                    let a =  Int( unreadCountLabel.text!)
                    let b = Int(readCountLabel.text!)
                    let c = a! + b!
                    
                    communication.text = String(c)
                }
                
                else{
                    
                    unreadCountView.isHidden = true
                    readCountView.isHidden = true
                    communicationCountView.isHidden = true
                    
                }


            case .failure(let error):
                print("Error: \(error)")
                unreadCountView.isHidden = true
                readCountView.isHidden = true
                communicationCountView.isHidden = true
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
        add.mobile_no = MobileNumber
        add.priority = priority
        add.college_id = Int(collegeId)
        add.previous_add_id = 1
        
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

            case .failure(let failure):
                print(failure.localizedDescription)
                
                bigImg.setAdImage(
                    imageURL: "",
                    adURL: "",
                    from: self
                )

            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return CommuniSegementName.selectedSegmentIndex == 0 ? UnReadData.count : ReadData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Textidentifier, for: indexPath) as!
        SenderCommuTextTableViewCell
        
        
        cell.selectionStyle = .none
        
        if let selectedCell = selectedCell, selectedCell == indexPath {
            cell.msgContentLabel.isHidden = false
            cell.voiceView.isHidden = false
            cell.playView.isHidden = true
            cell.arrowImage.image = UIImage(named: "up")
            cell.sendByLabel.isHidden = false
            cell.sendByView.isHidden = false
        } else {
            cell.sendByLabel.isHidden = true
            cell.voiceView.isHidden = true
            cell.playView.isHidden = false
            cell.arrowImage.image = UIImage(named: "down")
            cell.sendByLabel.isHidden = true
            cell.sendByView.isHidden = true
            cell.player?.pause()
            cell.btnName.setImage(UIImage(named: "plays"), for: .normal)
        }
        
        if CommuniSegementName.selectedSegmentIndex == 0{
            
            
            let comuCell : ReadCommunicationDetails = UnReadData[indexPath.row]
            
            if comuCell.isappread == "1"{
                
                cell.redDotImage.isHidden =  true
                
            }
            
            else {
                
                cell.redDotImage.isHidden = false
                //
            }
            
            if comuCell.isemergency == "true"{
                cell.TypeImageView.image = UIImage(named: "emergency")
                
            }else{
                
                cell.TypeImageView.image = UIImage(named: "dashboard_recent_voice")
                
            }
            
            
            
            type = "voice"
            
            
            cell.msgContentLabel.text = comuCell.description?.capitalized
            
            cell.sendByLabel.text = comuCell.sentby
            
            
            cell.audioFileURL = comuCell.voicefile
            cell.messageId = comuCell.msgdetailsid
            
            if comuCell.description != nil{
                cell.durationLAbel.text = "00:0"+(comuCell.duration ?? "")
            }else{
                
                cell.durationLAbel.text = "00:00"
            }
            
            if let timing = comuCell.timing {
                let dateAndTime = timing.components(separatedBy: " - ")

                cell.dateLabel.text = dateAndTime.first ?? ""
                cell.timeLabel.text = dateAndTime.dropFirst().joined(separator: " - ")
            }
        }else if CommuniSegementName.selectedSegmentIndex == 1 {
            
            let unreadCell : ReadCommunicationDetails = ReadData[indexPath.row]
            
            
            print("unreadCell",unreadCell.isappread)
            if unreadCell.isappread == "1"{
                
                cell.redDotImage.isHidden =  true
                
            }
            
            else {
                
                cell.redDotImage.isHidden = false
                //
            }
            
            if unreadCell.isemergency == "true"{
                cell.TypeImageView.image = UIImage(named: "emergency")
                
            }else{
                
                cell.TypeImageView.image = UIImage(named: "dashboard_recent_voice")
                
            }
            type = "voice"
            
            
            cell.msgContentLabel.text = unreadCell.description?.capitalized
            
            cell.sendByLabel.text = unreadCell.sentby
            cell.audioFileURL = unreadCell.voicefile
            cell.messageId = unreadCell.msgdetailsid
            
            
            if unreadCell.description == nil{
                cell.durationLAbel.text = "00:0"+(unreadCell.duration ?? "")
            }else{
                
                cell.durationLAbel.text = "00:00"
            }
            
            if let timing = unreadCell.timing {
                let dateAndTime = timing.components(separatedBy: " - ")

                cell.dateLabel.text = dateAndTime.first ?? ""
                cell.timeLabel.text = dateAndTime.dropFirst().joined(separator: " - ")
            }
            
        }
        
        return cell
        
    }
    
    //
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Textidentifier, for: indexPath) as!
        SenderCommuTextTableViewCell
        
        if CommuniSegementName.selectedSegmentIndex == 0{
            
            if let selectedCells = selectedCell, selectedCells == indexPath {
                
                selectedCell = nil
                
            } else {
                
                selectedCell = indexPath
                
                if UnReadData[indexPath.row].isappread == "0"{
                    
                    apread(gesture : UnReadData[indexPath.row].msgdetailsid ?? "")
                    UnReadData[indexPath.row].isappread = "1"
                    cell.redDotImage.isHidden = true
                    
                }
                
            }
            
        }
        
        else if CommuniSegementName.selectedSegmentIndex == 1 {
            
            
            if let selectedCells = selectedCell, selectedCells == indexPath {
                
                selectedCell = nil
                
            } else {
                selectedCell = indexPath
            }
        }
        
        
        communiTableView.beginUpdates()
        
        communiTableView.endUpdates()
        
        communiTableView.reloadData()
        
    }
    
    
    func apread(gesture : String){
        
        var readApiStatus  = AppReadStatusModal()
        
        readApiStatus.msgtype = type
        readApiStatus.priority = priority
        readApiStatus.userid = memberId
        readApiStatus.detailsid = gesture
        print("sertt",type)
        
        APiCallManager.shared.callApi(url: APIEndpoints.Appreadstatus, httpMethod: .post, queryParam: nil, requestBody: readApiStatus) {[weak self]  (result:Result<ReadStausApiResponce, Error>) in
            
            guard let self = self else {return}
            
            switch result {
            case .success(let success):
                communiTableView.reloadData()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    @IBAction func Voice(gesture : VoiceMessage) {
    
        if player?.rate == 0 {
            
            player!.play()
            
            gesture.img.image = UIImage(named: "pause")
            
        } else {
            
            player!.pause()
            gesture.img.image = UIImage(named: "play")
            
        }
    }
    
    
    @IBAction func Emergncy(gesture : EmargencyVoice) {
     
        if player?.rate == 0{
            
            player!.play()
            gesture.EmergencyVoiceimg.image = UIImage(named: "pause")
            
        } else {
            
            player!.pause()
            gesture.EmergencyVoiceimg.image = UIImage(named: "play")
        }
    }
    
    
    @objc func ordersFinishedPlaying( _ myNotification:NSNotification) {
        
        let selectedTime: CMTime = CMTimeMake(value: Int64(0 * 1000 as Float64), timescale: 1000)
        player?.seek(to: selectedTime)
        
    }
    
    
    func stringFromTimeInterval(interval: TimeInterval) -> String {
        
        
        
        let interval = Int(interval)
        
        
        
        let seconds = interval % 60
        
        
        
        let minutes = (interval / 60) % 60
        
        
        
        let hours = (interval / 3600)
        
        
        
        return String(format: "%02d:%02d", minutes, seconds)
        
        
        
    }
    
    
    
    @objc func playbackSliderValueChanged(_ playbackSlider:UISlider) {
        
        
        
        let seconds : Int64 = Int64(playbackSlider.value)
        
        
        
        let targetTime:CMTime = CMTimeMake(value: seconds, timescale: 1)
        
        
        
        player!.seek(to: targetTime)
        
        
        
        if player!.rate == 0 {
            
            
            
            player?.play()
            
            
            
        }
        
        
        
    }
    
    
    
    
    // tap Nivagation
    
    @IBAction func changePassowrdVC(){
        
        let vc = ChangePasswordVC(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
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
    
    @IBAction func priorityVc() {
        
        let vc = PriorityScreenVC(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
    }
        
    @IBAction func helpRedirect() {
        
        let vc = HelpViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
        
    }
    
    
    @IBAction func profileRedirect() {
        
        let vc = ProfileViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        vc.str = str
        vc.strName = strName
        present(vc, animated: true, completion: nil)
        
    }
    
    
    @IBAction func termsAndCondition() {
        
        let vc = MenuTermsViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
    }
}

@available(iOS 16.0, *)
extension CommunicationHomePageViewController : CustomTabBarDelegate {
    func didTapSearch() {
        searchbar.isHidden  = false
        searchFullView .isHidden = false
    }
    
    func didTapSideMenu() {
        sideMenuView.isHidden.toggle()
    }
}

class VoiceMessage : UITapGestureRecognizer {
    
    
    
    
    var sliders : UISlider!
    
    var timeLbl : UILabel!
    
    var img : UIImageView!
    
    var url : String!
    var buttons : UIButton!
    
}


class EmargencyVoice : UITapGestureRecognizer {
    
    
    var emergncyVoiceSlider : UISlider!
    
    var EmergencyVoicetimeLbl : UILabel!
    
    var EmergencyVoiceimg : UIImageView!
    
}



