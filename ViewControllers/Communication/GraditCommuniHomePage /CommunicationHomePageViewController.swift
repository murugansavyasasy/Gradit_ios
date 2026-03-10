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
    
    @IBOutlet weak var reusee: ReuseView!
    @IBOutlet weak var topNameview: UIView!
    @IBOutlet weak var tapBarView: UIViewX!
    @IBOutlet weak var searchFullView: UIViewX!
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var loadingCustom: UIActivityIndicatorView!
    @IBOutlet weak var redirectLoginView: UIViewX!
    @IBOutlet weak var topLabels: UILabel!
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var SearchView: UIView!
    @IBOutlet weak var privacyPolicyView: UIView!
    @IBOutlet weak var faqView: UIView!
    @IBOutlet weak var changePasswordView: UIView!
    @IBOutlet weak var logoutView: UIView!
    @IBOutlet weak var helpView: UIView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var termsAndConditionView: UIView!
    @IBOutlet weak var refreshView: UIView!
    @IBOutlet weak var changeRolesView: UIView!
    @IBOutlet weak var topMessageLabel: UILabel!
    @IBOutlet weak var clgLogoImg: UIImageView!
    @IBOutlet weak var sideMenuView: UIView!
    @IBOutlet weak var viewTap: UIView!
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
    @IBOutlet weak var swipeMenuHeight: NSLayoutConstraint!
    @IBOutlet weak var smallImg: UIImageView!
    @IBOutlet weak var bigImg: UIImageView!
    
    
    var idss : Int!
    var Textidentifier = "SenderCommuTextTableViewCell"
    var addapiRef : [AddDataDeatils] = []
    var ReadData : [ReadCommunicationDetails] = []
    var UnReadData : [ReadCommunicationDetails] = []
    var overAllRef    : [overAllDataDetails] = []
    let menuIdentifier = "MenuCollectionViewCell"
    var MenuRefName :[menuApiDataDetails] = []
    var readApiRef : readStatusResponce!
    var loginDatas : [datalogin]!
    var logindataprinci :[datalogin]!
    var webview: WKWebView!
    var player:AVPlayer?
    var playerItem:AVPlayerItem?
    fileprivate let seekDuration: Float64 = 10
    var UnReadvoiceMsgUrl : String!
    var readVoiceMgURl : String!
    var UnReademergencyVoiceMsgUrl    : String!
    var  readEmergencyVoiceMessageURl : String!
    var selectedCell : IndexPath?
    var time : String!
    var addWebUrlRef : String!
    var memberId : String!
    var priority : String!
    var collegeId : String!
    var departmentId : String!
    var sectionId : String!
    var loginType : String!
    var colgImg : String!
    var memberName : String!
    var MobileNumber : String!
    var PreviousAddId : Int = 0
    var password : String!
    var str : [String] = []
    var strName : [String] = []
    var type = ""
    var segmentId : String!
    var cloneList :  [ReadCommunicationDetails] = []
    var segTyp : String! = "1"
    var is_read_enabled : String!
    var is_write_enabled : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingCustom.startAnimating()
        overrideUserInterfaceStyle = .light
        
        PreviousAddId = PreviousAddId+1
        print("trrrr",is_read_enabled)
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
        loginType = defaults.string(forKey: DefaultsKeys.loginAsType)
        colgImg = defaults.string(forKey: DefaultsKeys.colglogo)
        clgLogoImg.sd_setImage(with: URL(string:  colgImg), placeholderImage: UIImage(named: "person.fill"))
        memberName = defaults.string(forKey: DefaultsKeys.memberName)
        topMessageLabel.text = memberName
        MobileNumber = defaults.string(forKey: DefaultsKeys.mobileNumber)
        
        password = defaults.string(forKey: DefaultsKeys.Password)
        PreviousAddId = PreviousAddId+1
        
        addApi()
        
        overAllRefName()
        
        unReadModal()
        
        if priority == "p1"{
            tapBarView.backgroundColor = UIColor(named: "Principal" )
            topLabels.text = "Principal"
            
        }
        
        else if priority == "p4"{
            
            tapBarView.backgroundColor = UIColor(named: "StudentParent" )
            topLabels.text = "Student"
            
        }
        
        else if priority == "p2" || priority == "p3"{
            
            
            topLabels.text = "Teacher"
        }
        
        else if priority == "p5"{
            
            tapBarView.backgroundColor = UIColor(named: "FatherColor" )
            topLabels.text = "Father"
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
        
        swipeMenuHeight.constant = 150
        reusee.call_back = { [self]
            (val) in
            
            
            self.swipeMenuHeight.constant =  reusee.callid
            
            print("CommunicationHomePageViewController",reusee.callid)
        }
        
        let TextRownib = UINib(nibName: Textidentifier, bundle: nil)
        communiTableView.register(TextRownib, forCellReuseIdentifier: Textidentifier)
        
        communiTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 85, right: 0)
        communiTableView.rowHeight = UITableView.automaticDimension
        
        let loginRediectGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        redirectLoginView.addGestureRecognizer(loginRediectGesture)
        
        
        let changeRolesGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        changeRolesView.addGestureRecognizer(changeRolesGesture)
        
        
        let topname = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        topNameview.addGestureRecognizer(topname)
        
        let notificationGesture = UITapGestureRecognizer(target: self, action: #selector(notificationVc))
        notificationView.addGestureRecognizer(notificationGesture)
        
        
        let termsAndConditionGesture = UITapGestureRecognizer(target: self, action: #selector(termsAndCondition))
        termsAndConditionView.addGestureRecognizer(termsAndConditionGesture)
        
        let refreshGesture = UITapGestureRecognizer(target: self, action: #selector(refreshVc))
        refreshView.addGestureRecognizer(refreshGesture)
        
        let profileGesture = UITapGestureRecognizer(target: self, action: #selector(profileRedirect))
        profileView.addGestureRecognizer(profileGesture)
        //
        let helpGesture = UITapGestureRecognizer(target: self, action: #selector(helpRedirect))
        helpView.addGestureRecognizer(helpGesture)
        
        let logoutGesture = UITapGestureRecognizer(target: self, action: #selector(logoutPressed))
        logoutView.addGestureRecognizer(logoutGesture)
        
        let menuGestureHide = UITapGestureRecognizer(target: self, action: #selector(menu))
        viewTap.addGestureRecognizer(menuGestureHide)
        
        let chagePassword = UITapGestureRecognizer(target: self, action: #selector(changePassowrdVC))
        changePasswordView.addGestureRecognizer(chagePassword)
        
        let faqGesture = UITapGestureRecognizer(target: self, action: #selector(faqRedirect))
        faqView.addGestureRecognizer(faqGesture)
        let privacyPolicyGesture = UITapGestureRecognizer(target: self, action: #selector(privacyPolicyRedirect))
        privacyPolicyView.addGestureRecognizer(privacyPolicyGesture)
        
        let Serach = UITapGestureRecognizer(target: self, action: #selector(Searchfield))
        SearchView.addGestureRecognizer(Serach)
    }
    
    @objc func dismissKeyboards() {
        
        sideMenuView.isHidden = true
        view.endEditing(true)
    }
    
    @IBAction func Searchfield() {
        
        searchbar.isHidden  = false
        searchFullView .isHidden = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if CommuniSegementName.selectedSegmentIndex == 0{
            
            let filtered_list : [ReadCommunicationDetails] = Mapper<ReadCommunicationDetails>().mapArray(JSONString: cloneList.toJSONString()!)!
            
            if !searchText.isEmpty{
                
                UnReadData = filtered_list.filter {
                    
                    $0.description.lowercased().contains(searchText.lowercased()) || $0.typename.lowercased().contains(searchText.lowercased()) ||  $0.msgdetailsid.lowercased().contains(searchText.lowercased()) || $0.timing.lowercased().contains(searchText.lowercased()) || $0.headerid.lowercased().contains(searchText.lowercased()) || $0.sentby.lowercased().contains(searchText.lowercased())
                    
                }
                
            }else{
                
                UnReadData = filtered_list
                print("pendingOrder")
            }
            
            
            if UnReadData.count > 0{
                
                
                print ("searchListPendigCount",UnReadData.count)
                
                noDataView.isHidden = true
                noDataTextLabel.isHidden = true
            }else{
                
                noDataView.isHidden = false
                noDataTextLabel.isHidden = false
                noDataTextLabel.text = "No Records Found"
            }
        }
        
        else if CommuniSegementName.selectedSegmentIndex == 1{
            
            let filtered_list : [ReadCommunicationDetails] = Mapper<ReadCommunicationDetails>().mapArray(JSONString: cloneList.toJSONString()!)!
            
            if !searchText.isEmpty{
                
                ReadData = filtered_list.filter {
                    
                    $0.msgcontent.lowercased().contains(searchText.lowercased()) || $0.description.lowercased().contains(searchText.lowercased()) || $0.typename.lowercased().contains(searchText.lowercased()) ||  $0.msgdetailsid.lowercased().contains(searchText.lowercased()) || $0.timing.lowercased().contains(searchText.lowercased()) || $0.headerid.lowercased().contains(searchText.lowercased()) || $0.sentby.lowercased().contains(searchText.lowercased())
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
    
    
    @IBAction func adLoad(gesture : VoiceMessage) {
        
        let vc = ShowAdvertisementViewController(nibName: nil, bundle: nil)
        vc.addUrl = gesture.url
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
    }
    
    @IBAction func communiSegmentAction(_ sender: Any) {
        
        if is_read_enabled == "1"{
            
            if CommuniSegementName.selectedSegmentIndex == 0{
                segmentId = "1"
                segTyp = "1"
                communiTableView.isScrollEnabled = false
                selectedCell = IndexPath()
                
                overAllRefName()
                unReadModal()
            }
            
            else if CommuniSegementName.selectedSegmentIndex ==  1 {
                segmentId = "2"
                segTyp = "2"
                communiTableView.isScrollEnabled = false
                selectedCell = IndexPath()
                overAllRefName()
                
                ReadApi()
            }
        }else{
            
        }
    }
    
    func ReadApi() {
        
        let Commu = ReadModal()
        
        Commu.userid = memberId
        Commu.priority = priority
        Commu.readtype = "1"
        Commu.appid = "2"
        
        let commuStr = Commu.toJSONString()
        print("commuStr",commuStr)
        SenderReadRequest .call_request(param: commuStr!){ [self]
            
            (res) in
            
            
            let communicationResp : ReadcommunicationResponce =
            Mapper<ReadcommunicationResponce>().map(JSONString: res)!
            
            print("order data",communicationResp)
            
            if communicationResp.Status == 1{
                
                ReadData = communicationResp.data
                cloneList = communicationResp.data
                noDataView.isHidden = true
                communiTableView.isScrollEnabled = true
                noDataTextLabel.isHidden = true
                communiTableView.delegate = self
                communiTableView.dataSource = self
                
                communiTableView.reloadData()
            }
            
            else{
                
                noDataView.isHidden = false
                noDataTextLabel.isHidden = false
                
                noDataTextLabel.text = communicationResp.Message
                communiTableView.delegate = self
                communiTableView.dataSource = self
                communiTableView.reloadData()
            }
        }
    }
    
    
    func unReadModal() {
        
        let unreads = ReadModal()
        
        unreads.userid = memberId
        unreads.priority = priority
        unreads.readtype = "0"
        unreads.appid = "2"
        
        let unReadStr = unreads.toJSONString()
        
        print("unReadStr",unReadStr)
        SenderReadRequest .call_request(param: unReadStr!){ [self]
            
            (res) in
            
            
            let UnReadcommunicationResp : ReadcommunicationResponce =
            Mapper<ReadcommunicationResponce>().map(JSONString: res)!
            
            print("order data",UnReadcommunicationResp)
            
            
            if UnReadcommunicationResp.Status == 1{
                
                
                UnReadData = UnReadcommunicationResp.data
                cloneList = UnReadcommunicationResp.data
                KRProgressHUD.dismiss()
                
                communiTableView.isScrollEnabled = true
                noDataView.isHidden = true
                noDataTextLabel.isHidden = true
                communiTableView.delegate = self
                communiTableView.dataSource = self
                communiTableView.reloadData()
                
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3 ){ [self] in
                    
                    loadingCustom.stopAnimating()
                    
                    loadingCustom.isHidden  = true
                    
                }
            }
            
            else{
                
                noDataView.isHidden = false
                noDataTextLabel.isHidden = false
                
                noDataTextLabel.text = UnReadcommunicationResp.Message
                communiTableView.delegate = self
                communiTableView.dataSource = self
                communiTableView.reloadData()
                
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3 ){ [self] in
                    
                    loadingCustom.stopAnimating()
                    
                    loadingCustom.isHidden  = true
                }
            }
        }
    }
    
    
    func overAllRefName() {
        
        let overall = overAllModal()
        
        overall.userid   =  memberId
        overall.menuid       = "2"
        overall.collegeid    =  collegeId
        overall.departmentid =  departmentId
        overall.sectionid    =   sectionId
        overall.appid        = "2"
        overall.priority     = priority
        
        
        let overallStr = overall.toJSONString()
        print("overallStreeeeee",overall.toJSON())
        
        overAllRequest .call_request(param: overallStr!){ [self]
            
            (res) in
            
            let overallResp : overAllResponce =
            Mapper<overAllResponce>().map(JSONString: res)!
            
            print("order data",overallResp)
            
            if overallResp.Status == 1{
                overAllRef = overallResp.data
                
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
            
        }
        
    }
    
    func addApi(){
        
        var add = AddApiModal()
        
        let defaults = UserDefaults.standard
        var deviceToken = defaults.string(forKey:DefaultsKeys.DeviceToken )
        add.device_token = deviceToken
        print("EventDefaultsKeys.DeviceToken",deviceToken)
        add.member_id = memberId
        add.mobile_no = MobileNumber
        add.priority = priority
        add.college_id = collegeId
        add.previous_add_id = 1
        
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
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if CommuniSegementName.selectedSegmentIndex == 0 {
            
            
            return UnReadData.count
            
        }
        
        else if CommuniSegementName.selectedSegmentIndex == 1{
            
            return ReadData.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Textidentifier, for: indexPath) as!
        SenderCommuTextTableViewCell
        
        
        cell.selectionStyle = .none
        
        if let selectedCell = selectedCell, selectedCell == indexPath {
            cell.PlayerViewHeight.constant = 46
            cell.msgContentLabel.isHidden = false
           
            cell.voiceView.isHidden = false
            cell.playView.isHidden = true
            cell.arrowImage.image = UIImage(named: "up")
            cell.sendByLabel.isHidden = false
            cell.sendByView.isHidden = false
            
        } else {
            cell.PlayerViewHeight.constant = 0
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
            
            
            cell.msgContentLabel.text = comuCell.description.capitalized
            
            cell.sendByLabel.text = comuCell.sentby
            
            
            cell.audioFileURL = comuCell.voicefile
            cell.messageId = comuCell.msgdetailsid
            cell.dateLabel.text = comuCell.timing
            
            if comuCell.description != nil{
                cell.durationLAbel.text = "00:0"+comuCell.duration
            }else{
                
                cell.durationLAbel.text = "00:00"
            }
            
            
            print("cell.audioFileURL",cell.audioFileURL)
            var dateString2 = comuCell.timing
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy - hh:mm:ss a"
            dateFormatter.locale = Locale.init(identifier: "en_US_POSIX")
            
            let dateObj = dateFormatter.date(from: dateString2!)
            dateFormatter.dateFormat = "dd MMM yyyy  hh:mm a"
            
            
        }
        
        else if CommuniSegementName.selectedSegmentIndex == 1 {
            
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
            
            
            cell.msgContentLabel.text = unreadCell.description.capitalized
            
            cell.sendByLabel.text = unreadCell.sentby
            
            cell.dateLabel.text = unreadCell.timing
            cell.audioFileURL = unreadCell.voicefile
            cell.messageId = unreadCell.msgdetailsid
            
            
            if unreadCell.description == nil{
                cell.durationLAbel.text = "00:0"+unreadCell.duration
            }else{
                
                cell.durationLAbel.text = "00:00"
            }
            var dateString2 = unreadCell.timing
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy - hh:mm:ss a"
            dateFormatter.locale = Locale.init(identifier: "en_US_POSIX")
            
            let dateObj = dateFormatter.date(from: dateString2!)
            dateFormatter.dateFormat = "dd MMM yyyy  hh:mm a"
            
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
            let comuCell : ReadCommunicationDetails = UnReadData[indexPath.row]
            
            if let selectedCells = selectedCell, selectedCells == indexPath {
                
                selectedCell = nil
                
            } else {
                
                selectedCell = indexPath
                
                if comuCell.isappread == "0"{
                    
                    apread(gesture : comuCell.msgdetailsid)
                    comuCell.isappread = "1"
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
        
        
        
        let readApiStatus  = AppReadStatusModal()
        
        readApiStatus.msgtype = type
        readApiStatus.priority = priority
        readApiStatus.userid = memberId
        readApiStatus.detailsid = gesture
        print("sertt",type)
        
        
        let commuS = readApiStatus.toJSONString()
        
        ApiReadStatusRequest .call_request(param: commuS!){ [self]
            
            (res) in
            
            
            let com : ReadStausApiResponce =
            Mapper<ReadStausApiResponce>().map(JSONString: res)!
            
            
            
            communiTableView.delegate = self
            communiTableView.dataSource = self
            communiTableView.reloadData()
            
            
            
        }
        
        
        
    }
    
    @IBAction func Voice(gesture : VoiceMessage) {
        
        
        
        print("play Button")
        
        
        
        if player?.rate == 0
            
            
            
        {
            
            player!.play()
            
            gesture.img.image = UIImage(named: "pause")
            
            
            
        } else {
            
            
            
            player!.pause()
            
            
            
            gesture.img.image = UIImage(named: "play")
            
            
            
        }
        
        
        
    }
    
    
    
    
    @IBAction func Emergncy(gesture : EmargencyVoice) {
        
        
        
        print("play Button")
        
        
        
        if player?.rate == 0
            
            
            
        {
            
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
        
        
        
        print("Player finished")
        
        
        
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
    
    @IBAction func menu() {
        
        if sideMenuView.isHidden == true{
            
            sideMenuView.isHidden = false
            
            
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
            
            let vc = LoginNewViewController(nibName: nil, bundle: nil)
            vc.modalPresentationStyle = .fullScreen
            
            self.present(vc, animated: true, completion: nil)
            
            
        }))
        
        
        refreshAlert.addAction(UIAlertAction(title: "NO", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        present(refreshAlert, animated: true, completion: nil)
        
    }
    
    @IBAction func refreshVc() {
        
        print("segTyp",segTyp)
        if segTyp == "1"{
            
            unReadModal()
            overAllRefName()
        }
        else{
            
            overAllRefName()
            ReadApi()
        }
    }
    
    
    @IBAction func loginRedirect() {
        
        
        let vc = LoginViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
        
    }
    
    @IBAction func priorityVc() {
        
        let vc = PriorityViewController(nibName: nil, bundle: nil)
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
    
    
    
    
    @IBAction func notificationVc() {
        
        let vc = NotificationViewController(nibName: nil, bundle: nil)
        vc.str = str
        vc.strName = strName
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
        
        
    }
    
    
    
    @IBAction func termsAndCondition() {
        
        let vc = MenuTermsViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
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



