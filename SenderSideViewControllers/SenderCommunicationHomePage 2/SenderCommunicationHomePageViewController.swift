//
//  SenderCommunicationHomePageViewController.swift
//  GraditSenderCommunicationMenu
//
//  Created by MACBOOKPRO on 07/12/22.
//

import UIKit
import ObjectMapper
import AVFoundation
import WebKit
import KRProgressHUD

@available(iOS 16.0, *)
class SenderCommunicationHomePageViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    
    
  
    @IBOutlet weak var reusee: ReuseView!
    @IBOutlet weak var searchFullView: UIViewX!
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var topNameview: UIView!
    @IBOutlet weak var tapBarView: UIViewX!
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var smallImg: UIImageView!
    @IBOutlet weak var bigImg: UIImageView!
    @IBOutlet weak var logoutView: UIView!
    @IBOutlet weak var changeRolesView: UIView!
    @IBOutlet weak var SearchView: UIView!
    @IBOutlet weak var topLabels: UILabel!
    @IBOutlet weak var micRecordView: UIViewX!
    @IBOutlet weak var clgLogoImg: UIImageView!
    @IBOutlet weak var topMessageLabel: UILabel!
    @IBOutlet weak var privacyPolicyView: UIView!
    @IBOutlet weak var faqView: UIView!
    @IBOutlet weak var viewTap: UIView!
    @IBOutlet weak var helpView: UIView!
    @IBOutlet weak var changePasswordView: UIView!
    @IBOutlet weak var termsAndConditionView: UIView!
    @IBOutlet weak var sideMenuView: UIView!
    @IBOutlet weak var refreshView: UIView!
    @IBOutlet weak var plusImageView: UIImageView!
    @IBOutlet weak var communicationcountViews: UIViewX!
    @IBOutlet weak var unreadCountView: UIViewX!
    @IBOutlet weak var communiTableView: UITableView!
    @IBOutlet weak var readCountView: UIViewX!
    @IBOutlet weak var plusView: UIViewX!
    @IBOutlet weak var communication: UILabel!
    @IBOutlet weak var CommuniSegementName: UISegmentedControl!
    @IBOutlet weak var readCountLabel: UILabel!
    @IBOutlet weak var noDataView: UIView!
    @IBOutlet weak var unreadCountLabel: UILabel!
    @IBOutlet weak var noDataTextLabel: UILabel!
    @IBOutlet weak var swipeMenuHeight: NSLayoutConstraint!
    @IBOutlet weak var loadingCustom: UIActivityIndicatorView!
    @IBOutlet weak var redirectLoginView: UIViewX!
    
    var ComunimenuId : String!
    var NoticeBoardId = "1"
    var videoId = "2"
    var EventId = "3"
    var communicationId = "4"
    var imagePdfId = "5"
    var Assigment = "6"
    var previousAddId : Int = 0
    var Textidentifier = "SenderCommuTextTableViewCell"
    var ReadData : [SenderCommuniReadDataDetails] = []
    var UnReadData : [SenderCommuniUnReadDataDetails] = []
    var overAllRef    : [overAllDataDetails] = []
    var addapiRef : [AddDataDeatils] = []
    let menuIdentifier = "MenuCollectionViewCell"
    var MenuRefName :[menuApiDataDetails] = []
    var loginDatas : [datalogin]!
    var logindataprinci :[datalogin]!
    fileprivate let seekDuration: Float64 = 10
    var UnReadvoiceMsgUrl : String!
    var readVoiceMgURl : String!
    var UnReademergencyVoiceMsgUrl    : String!
    var  readEmergencyVoiceMessageURl : String!
    var selectedCell:IndexPath?
    var memberId : String!
    var priority : String!
    var collegeId : String!
    var departmentId : String!
    var sectionId : String!
    var loginType : String!
    var memberName : String!
    var colgImg    : String!
    var MobileNumber : String!
    var  password : String!
    var str : [String] = []
    var strName : [String] = []
    var type = ""
    var audioFile : String!
    var audioRecorder: AVAudioRecorder!
    var audioPlayer : AVAudioPlayer!
    var meterTimer:Timer!
    var isAudioRecordingGranted: Bool!
    var durationLable : String!
    var secondsLabel  : String!
    var strPlayStatus : NSString = ""
    var playerItem: AVPlayerItem?
    var player: AVPlayer?
    var timer = Timer()
    var time : Float64 = 0;
    var sliderIndex : NSInteger = NSInteger()
    var strFilePath : String = String()
    var indexPathss : Int!
    var indexPathsections : Int!
    var segmentype : String!
    var cloneList :  [SenderCommuniUnReadDataDetails] = []
    var segTyp : String! = "1"
    var cloneList1 : [SenderCommuniReadDataDetails] = []
    var is_read_enabled = ""
    var is_write_enabled = ""
    var is_read : String!
    var is_write : String!
    var menuSlug = ""
    var messageAndVoiceArray : [menuApiDataDetails] = []
    var heigts : Int!
    var   CallEnabel : String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        print("is_write_enabled",is_write_enabled)
        print("strNamestrNamestrNamestrName",strName)
        
        
        
        sideMenuView.isHidden = true
        searchbar.delegate = self
        micRecordView.isHidden = true
        plusView.isHidden = true
        let defaults = UserDefaults.standard
        
        memberId = defaults.string(forKey: DefaultsKeys.memberid)
        priority = defaults.string(forKey: DefaultsKeys.priority)
        collegeId = defaults.string(forKey: DefaultsKeys.collegeid)
        departmentId = defaults.string(forKey: DefaultsKeys.deptid)
        sectionId = defaults.string(forKey: DefaultsKeys.sectionid)
        loginType = defaults.string(forKey: DefaultsKeys.loginAsType)
        memberName = defaults.string(forKey: DefaultsKeys.memberName)
        MobileNumber = defaults.string(forKey: DefaultsKeys.mobileNumber)
        password  = defaults.string(forKey: DefaultsKeys.Password)
        
        print("mobileeess",MobileNumber)
        colgImg = defaults.string(forKey: DefaultsKeys.colglogo)
        clgLogoImg.sd_setImage(with: URL(string:  colgImg), placeholderImage: UIImage(named: "person.fill"))
        
        topMessageLabel.text = memberName
        
        searchFullView .isHidden = true
        
        
        
        if sectionId == ""{
            
            sectionId = "0"
            
        }
        
        previousAddId = previousAddId + 1
        
        print("menuSlugmenuSlug",menuSlug)
        addApi()
        
        
        
        
        if is_read_enabled == "1"{
            
            unReadModal()
            overAllRefName()
        }else{}
        
        
        
        if is_write_enabled == "1"{
            
            micRecordView.isHidden = false
            
        }
        else{
            
            
            micRecordView.isHidden = true
        }
    
        
        if priority == "p1"{
            tapBarView.backgroundColor = UIColor(named: "Principal" )
            topLabels.text = "Principal"
            
        }
        
        else if priority == "p4"{
            
            topLabels.text = "Student"
            
            
        }
        
        else if priority == "p2" {
            
            micRecordView.backgroundColor = UIColor(named: "messagecolor")
            plusView.backgroundColor = UIColor(named: "messagecolor")
            tapBarView.backgroundColor = UIColor(named: "Teaching Staff" )
            topLabels.text = "Hod"
            
            
        }
        else if priority == "p7" {
            
            micRecordView.backgroundColor = UIColor(named: "univercityColorCod")
            plusView.backgroundColor = UIColor(named: "univercityColorCod")
            tapBarView.backgroundColor = UIColor(named: "univercityColorCod" )
            topLabels.text = "university Head"
            
            
        }
        
        else if priority == "p5"{
            
            
            topLabels.text = "Father"
            
        }
        
        else if priority == "p3"{
            micRecordView.backgroundColor = UIColor(named: "messagecolor")
            plusView.backgroundColor = UIColor(named: "messagecolor")
            tapBarView.backgroundColor = UIColor(named: "Teaching Staff" )
            topLabels.text = "Teacher"
            
        }
        
        else if priority == "p6"{
            
            tapBarView.backgroundColor = UIColor(named: "Teaching Staff" )
            
            readCountView.isHidden = true
            unreadCountView.isHidden = true
            communicationcountViews.isHidden = true
            
            plusView.isHidden = true
            micRecordView.isHidden = true
            
            topLabels.text = "Non Teaching"
            
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
        else if priority == "p7" {
            
            print("HooodddVieewwColor")
            view.backgroundColor = UIColor(named: "univercityColorCod")
            
            reusee.menuImg.image = UIImage(named: "UnivercityHead")
            
        }
        else if priority == "p5"{
            
            
            
            view.backgroundColor = UIColor(named: "FatherColor")
            
            reusee.menuImg.image = UIImage(named: "StaffBigMenu")
            
            
        }
        
        else if priority == "p6"{
            
            
            
            view.backgroundColor = UIColor(named: "Teaching Staff")
            
            reusee.menuImg.image = UIImage(named: "HodImage")
            
            
            
            
        }
        
        
       
        swipeMenuHeight.constant = 150
                reusee.call_back = { [self]
                    (val) in
                  
                    
                        self.swipeMenuHeight.constant =  reusee.callid
                   
                    print("SenderCommunicationHomePageViewController",reusee.callid)
                    
               
                }
        
        
        let TextRownib = UINib(nibName: Textidentifier, bundle: nil)
        communiTableView.register(TextRownib, forCellReuseIdentifier: Textidentifier)
        
        
        
        noDataView.isHidden = true
        noDataTextLabel.isHidden = true
        
        
        
        
        let plusAddViews = UITapGestureRecognizer(target: self, action: #selector(PlusVc))
        plusView.addGestureRecognizer(plusAddViews)
        
        
        let Serach = UITapGestureRecognizer(target: self, action: #selector(Searchfield))
        SearchView.addGestureRecognizer(Serach)
        
        let voiceRecord = UITapGestureRecognizer(target: self, action:#selector(voiceRecordVc))
        micRecordView.addGestureRecognizer(voiceRecord)
        
        
        // tap Bar UiTapGuster.
        
        
        
        
        let changeRolesGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        changeRolesView.addGestureRecognizer(changeRolesGesture)
        
        
        
        let topname = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        topNameview.addGestureRecognizer(topname)
        
        
        
        let logoutGesture = UITapGestureRecognizer(target: self, action: #selector(logoutPressed))
        logoutView.addGestureRecognizer(logoutGesture)
        
        let loginRediectGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        redirectLoginView.addGestureRecognizer(loginRediectGesture)
        
        
        let menuGestureHide = UITapGestureRecognizer(target: self, action: #selector(menu))
        viewTap.addGestureRecognizer(menuGestureHide)
        
        let notificationGesture = UITapGestureRecognizer(target: self, action: #selector(notificationVc))
        notificationView.addGestureRecognizer(notificationGesture)
        
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
        
        
        plusView.isHidden = true
        
        
    }
    
    
    
    
    
    @IBAction func voiceRecordVc(){
        if priority == "p2" || priority == "p3" {
            let vc = VoiceRecoredViewController(nibName: nil, bundle: nil)
            vc.previousAddId = previousAddId
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true,completion: nil)
        }
        
        else if priority == "p7" {
            let vc = VoiceRecoredViewController(nibName: nil, bundle: nil)
            vc.previousAddId = previousAddId
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true,completion: nil)
        }
        else{
            
            
            
            let vc = VoiceRecoredViewController(nibName: nil, bundle: nil)
            vc.previousAddId = previousAddId
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.view.backgroundColor = UIColor(named: "Principal" )
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true,completion: nil)
            
        }
    }
    
    
    
    @IBAction func Searchfield() {
        
        
        searchbar.isHidden  = false
        searchFullView .isHidden = false
        
        
        
        
        
        
        
        
    }
    
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        if CommuniSegementName.selectedSegmentIndex == 0{
            
            
            let filtered_list : [SenderCommuniUnReadDataDetails] = Mapper<SenderCommuniUnReadDataDetails>().mapArray(JSONString: cloneList.toJSONString()!)!
            
            
            
            
            if !searchText.isEmpty{
                
                
                
                UnReadData = filtered_list.filter {
                    
                    
                    
                    
                    
                    
                    
                    $0.msgcontent.lowercased().contains(searchText.lowercased()) || $0.description.lowercased().contains(searchText.lowercased()) || $0.typename.lowercased().contains(searchText.lowercased()) ||  $0.msgdetailsid.lowercased().contains(searchText.lowercased()) || $0.timing.lowercased().contains(searchText.lowercased()) || $0.headerid.lowercased().contains(searchText.lowercased()) || $0.sentby.lowercased().contains(searchText.lowercased())
                    
                    
                    
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
            
            
            
            
            let filtered_list : [SenderCommuniReadDataDetails] = Mapper<SenderCommuniReadDataDetails>().mapArray(JSONString: cloneList.toJSONString()!)!
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            if !searchText.isEmpty{
                
                
                
                ReadData = filtered_list.filter {
                    
                    
                    
                    
                    
                    
                    
                    $0.msgcontent.lowercased().contains(searchText.lowercased()) || $0.description.lowercased().contains(searchText.lowercased()) || $0.typename.lowercased().contains(searchText.lowercased()) ||  $0.msgdetailsid.lowercased().contains(searchText.lowercased()) || $0.timing.lowercased().contains(searchText.lowercased()) || $0.headerid.lowercased().contains(searchText.lowercased()) || $0.sentby.lowercased().contains(searchText.lowercased())
                    
                    
                    
                }
                
                
                
                
                
                
                
            }else{
                
                
                
                ReadData = filtered_list
                
                
                
                print("pendingOrder")
                
                
                
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
    
    
    @IBAction func PlusVc() {
        
        for i in addapiRef{
            
            if priority == "p2" || priority == "p3" {
                
                let vc = SenderComunicationPlusNextPageViewController(nibName: nil, bundle: nil)
                
                vc.comuncationMenuId = communicationId
                vc.backGroundImage = i.background_image
                vc.addWebUrl = i.add_url
                vc.smallImageUrl = i.add_image
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true , completion: nil)
                
            }
            
            
            else if priority == "p7" {
                
                let vc = SenderComunicationPlusNextPageViewController(nibName: nil, bundle: nil)
                
                vc.comuncationMenuId = communicationId
                vc.backGroundImage = i.background_image
                vc.addWebUrl = i.add_url
                vc.smallImageUrl = i.add_image
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
                
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true , completion: nil)
                
            }
            
            
            
            
            
            else{
                
                let vc = SenderComunicationPlusNextPageViewController(nibName: nil, bundle: nil)
                
                vc.backGroundImage = i.background_image
                
                vc.comuncationMenuId = communicationId
                vc.str = str
                vc.strName = strName
                vc.addWebUrl = i.add_url
                vc.smallImageUrl = i.add_image
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.view.backgroundColor = UIColor(named: "Principal" )
                
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true , completion: nil)
                
            }
        }
        
        
    }
    
    
    
    
    @IBAction func adLoad(gesture : CommuniAdd) {
        
        
        let vc = SendercomuniAddViewController(nibName: nil, bundle: nil)
        vc.AddWebUrl = gesture.url
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
        
        
        
    }
    
    @IBAction func communiSegmentAction(_ sender: Any) {
        
        if is_read_enabled == "1"{
            if priority == "p6"{
                
                if CommuniSegementName.selectedSegmentIndex == 0{
                    
                    segmentype = "1"
                    
                    selectedCell = IndexPath()
                    communiTableView.isScrollEnabled = false
                    unReadModal()
                    
                }
                
                else if CommuniSegementName.selectedSegmentIndex == 1{
                    
                    segTyp = "2"
                    segmentype = "2"
                    selectedCell = IndexPath()
                    communiTableView.isScrollEnabled = false
                    ReadApi()
                    
                }
            }
            
            
            else {
                
                
                if CommuniSegementName.selectedSegmentIndex == 0{
                    segmentype = "1"
                    selectedCell = IndexPath()
                    communiTableView.isScrollEnabled = false
                    unReadModal()
                    
                    
                }
                
                else if CommuniSegementName.selectedSegmentIndex == 1{
                    segTyp = "2"
                    segmentype = "2"
                    selectedCell = IndexPath()
                    communiTableView.isScrollEnabled = false
                    ReadApi()
                    
                    
                }
                
            }
        }else{}
    }
    
    
    func MenuIdList() {
        
        let Menu = menuApiIdModal()
        
        Menu.college_id = collegeId
        Menu.priority = priority
        Menu.user_id    = memberId
        
        
        let MenuidStr = Menu.toJSONString()
        
        
        voiceAndTexRequest.call_request(param: MenuidStr!){ [self]
            
            (res) in
            
            
            let menuResp : menuApiIdResponce =
            Mapper<menuApiIdResponce>().map(JSONString: res)!
            
            print("order data",menuResp);
            
            MenuRefName = menuResp.data
            
            print("order data data",MenuRefName)
            
            
            for i in 0..<MenuRefName.count{
                
                
                CallEnabel = MenuRefName[i].menu_slug
                if( MenuRefName[i].is_write_enabled == 1 && MenuRefName[i].menu_slug == "text") {
                    
                    plusView.isHidden = false
                    
                    
                } else if (MenuRefName[i].is_write_enabled == 1 && MenuRefName[i].menu_slug == "voice"){
                    
                    
                    
                    micRecordView.isHidden = false
                    
                }
                
                
                else if( MenuRefName[i].is_write_enabled == 0 && MenuRefName[i].menu_slug == "text") {
                    
                    plusView.isHidden = true
                    
                    
                } else if (MenuRefName[i].is_write_enabled == 0 && MenuRefName[i].menu_slug == "voice"){
                    
                    
                    
                    micRecordView.isHidden = true
                    
                }
                
                
            }
            
            
            
            
            
            
            
        }
        
        
        
    }
    
    func ReadApi() {
        
        
        
        
        
        let Commu = SenderCommuniReadModal()
        
        Commu.userid = memberId
        Commu.priority = priority
        Commu.readtype = "1"
        Commu.appid = "2"
        
        let commuStr = Commu.toJSONString()
        
        SenderReadRequest .call_request(param: commuStr!){ [self]
            
            (res) in
            
            
            let communicationResp : SenderCommuniReadResponce =
            Mapper<SenderCommuniReadResponce>().map(JSONString: res)!
            
            
            
            
            print("order data",communicationResp)
            
            if communicationResp.Status == 1{
                
                ReadData = communicationResp.data
                cloneList1 = communicationResp.data
                communiTableView.isScrollEnabled = true
                noDataView.isHidden = true
                noDataTextLabel.isHidden = true
                communiTableView.delegate = self
                communiTableView.dataSource = self
                communiTableView.isHidden = false
                communiTableView.reloadData()
                
                
                
            }
            
            else{
                
                noDataView.isHidden = false
                noDataTextLabel.isHidden = false
                noDataTextLabel.text = communicationResp.Message
                communiTableView.delegate = self
                communiTableView.dataSource = self
                communiTableView.isHidden = true
                communiTableView.reloadData()
                
                
                
                
                
            }
            
            
        }
        
        
    }
    
    
    func unReadModal() {
        
        let unreads = SenderCommuniUnReadModal()
        
        
        
        unreads.userid = memberId
        unreads.priority = priority
        unreads.readtype = "0"
        unreads.appid = "2"
        
        let unReadStr = unreads.toJSONString()
        
        
        
        SenderReadRequest .call_request(param: unReadStr!){ [self]
            
            (res) in
            
            
            let UnReadcommunicationResp : SenderCommuniUnReadResponce =
            Mapper<SenderCommuniUnReadResponce>().map(JSONString: res)!
            
            print("order data",UnReadcommunicationResp)
            
            
            if UnReadcommunicationResp.Status == 1{
                
                
                UnReadData = UnReadcommunicationResp.data
                cloneList = UnReadcommunicationResp.data
                noDataView.isHidden = true
                noDataTextLabel.isHidden = true
                communiTableView.isScrollEnabled = true
                communiTableView.delegate = self
                communiTableView.dataSource = self
                communiTableView.isHidden = false
                communiTableView.reloadData()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3 ){ [self] in
                    
                    loadingCustom.stopAnimating()
                    
                    loadingCustom.isHidden  = true
                    
                    
                    KRProgressHUD.dismiss()
                    
                    
                }
                
                
                
            }
            
            else{
                
                noDataTextLabel.text = UnReadcommunicationResp.Message
                noDataView.isHidden = false
                noDataTextLabel.isHidden = false
                
                communiTableView.delegate = self
                communiTableView.dataSource = self
                
                communiTableView.isHidden = true
                
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
                        communicationcountViews.isHidden = true
                        
                        
                        
                    }
                    
                    else if i.unread == "0"{
                        
                        
                        unreadCountView.isHidden = true
                        readCountView.isHidden = false
                        communicationcountViews.isHidden = false
                        
                    }
                    
                    else if i.read == "0"{
                        
                        unreadCountView.isHidden = false
                        readCountView.isHidden = true
                        communicationcountViews.isHidden = false
                        
                        
                    }
                    
                    else {
                        
                        unreadCountView.isHidden = false
                        readCountView.isHidden = false
                        communicationcountViews.isHidden = false
                        
                        
                        
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
                communicationcountViews.isHidden = true
                
            }
            
        }
        
        
        
        
        
    }
    
    
    
    func addApi(){
        
        
        let add = AddApiModal()
        
        let defaults = UserDefaults.standard
        var deviceToken = defaults.string(forKey:DefaultsKeys.DeviceToken )
        add.device_token = deviceToken
        print("EventDefaultsKeys.DeviceToken",deviceToken)
        add.member_id = memberId
        add.mobile_no = MobileNumber
        add.priority = priority
        add.college_id = collegeId
        add.previous_add_id = previousAddId
        print("add.previous_add_id",previousAddId)
        
        
        
        let addstr = add.toJSONString()
        
        
        print("mobilree", add.mobile_no)
        addRequest.call_request(param: addstr!){ [self]
            
            (res) in
            
            
            previousAddId = previousAddId + 1
            let addApis : AddApiResponce = Mapper<AddApiResponce>().map(JSONString: res)!
            
            
            if addApis.Status == 1 {
                addapiRef = addApis.data
                
                
                for i in addApis.data{
                    
                    
                    
                    
                    bigImg.sd_setImage(with: URL(string: i.background_image), placeholderImage: UIImage(named: "ic_white"))
                    
                    
                    smallImg.sd_setImage(with: URL(string: i.add_image), placeholderImage: UIImage(named: "ic_white"))
                    
                    let singleTap = CommuniAdd(target: self, action: #selector(adLoad))
                    singleTap.url = i.add_url
                    bigImg.isUserInteractionEnabled = true
                    bigImg.addGestureRecognizer(singleTap)
                    
                    
                }
                
                
                
                
                
                
                
            }
            
            
            else{
                
                
                
                
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
            cell.msgContentLabel.isHidden = false
            
            cell.PlayerViewHeight.constant = 46
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
            
            
            
            let comuCell : SenderCommuniUnReadDataDetails = UnReadData[indexPath.row]
            
            
            if comuCell.isappread == "1"{
                
                cell.redDotImage.isHidden =  true
                
            }
            
            else {
                
                cell.redDotImage.isHidden = false
                
            }
            
            if comuCell.isemergency == "true"{
                type = "Emergency"
                cell.TypeImageView.image = UIImage(named: "emergency")
                
            }else{
                type = "voice"
                
                cell.TypeImageView.image = UIImage(named: "dashboard_recent_voice")
                
            }
            
            
            cell.msgContentLabel.text = comuCell.description.capitalized
            
            cell.sendByLabel.text = comuCell.sentby
            
            cell.dateLabel.text = comuCell.timing
            
            cell.audioFileURL = comuCell.voicefile
            cell.messageId = comuCell.msgdetailsid
            
            cell.durationLAbel.text = "00:00"+comuCell.duration
            
            print("cell.audioFileURL",cell.audioFileURL)
            var dateString2 = comuCell.timing
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy - hh:mm:ss a"
            dateFormatter.locale = Locale.init(identifier: "en_US_POSIX")
            
            let dateObj = dateFormatter.date(from: dateString2!)
            dateFormatter.dateFormat = "dd MMM yyyy  hh:mm a"
            
            
            
            
        }
        
        
        
        else if CommuniSegementName.selectedSegmentIndex == 1 {
            
            
            
            let unreadCell : SenderCommuniReadDataDetails = ReadData[indexPath.row]
            
            print("unreadCell",unreadCell.isappread)
            if unreadCell.isappread == "1"{
                
                cell.redDotImage.isHidden =  true
                
            }
            
            else {
                
                cell.redDotImage.isHidden = false
                
            }
            
            
            
            
            if unreadCell.isemergency == "true"{
                type = "Emergency"
                cell.TypeImageView.image = UIImage(named: "emergency")
                
            }else{
                
                type = "voice"
                
                cell.TypeImageView.image = UIImage(named: "dashboard_recent_voice")
                
            }
            
            
            
            
            
            
            cell.msgContentLabel.text = unreadCell.description.capitalized
            
            cell.sendByLabel.text = unreadCell.sentby
            
            cell.dateLabel.text = unreadCell.timing
            cell.audioFileURL = unreadCell.voicefile
            cell.messageId = unreadCell.msgdetailsid
            
            cell.durationLAbel.text = "00:0"+unreadCell.duration
            
            var dateString2 = unreadCell.timing
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy - hh:mm:ss a"
            dateFormatter.locale = Locale.init(identifier: "en_US_POSIX")
            
            let dateObj = dateFormatter.date(from: dateString2!)
            dateFormatter.dateFormat = "dd MMM yyyy  hh:mm a"
            
            
            
        }
        
        
        
        
        
        
        
        return cell
        
        
    }
    
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Textidentifier, for: indexPath) as!
        SenderCommuTextTableViewCell
        
        
        if CommuniSegementName.selectedSegmentIndex == 0{
            let comuCell : SenderCommuniUnReadDataDetails = UnReadData[indexPath.row]
            if let selectedCells = selectedCell, selectedCells == indexPath {
                
                
                selectedCell = nil
                
                cell.voiceView.isHidden = false
                
                
                print("titlerrererere" , cell.msgContentLabel.isHidden)
                
            } else {
                
                selectedCell = indexPath
                
                print("expandddd" , cell.msgContentLabel.isHidden)
                cell.voiceView.isHidden = true
                if comuCell.isappread == "0"{
                    
                    
                    apread(gesture : comuCell.msgdetailsid)
                    
                    comuCell.isappread = "1"
                    cell.redDotImage.isHidden = true
                    
                }
            }
            
            
            
            
            
        }
        
        else if CommuniSegementName.selectedSegmentIndex == 1 {
            
            
            
            let unreadCell : SenderCommuniReadDataDetails = ReadData[indexPath.row]
            if let selectedCells = selectedCell, selectedCells == indexPath {
                
                
                indexPathsections = indexPath.section
                selectedCell = nil
                
                cell.voiceView.isHidden = false
                
                print("titlerrererere" , cell.msgContentLabel.isHidden)
                
                
                
            } else {
                print("expandddd" , cell.msgContentLabel.isHidden)
                selectedCell = indexPath
                indexPathss = indexPath.row
                
                audioFile = unreadCell.msgcontent
                cell.voiceView.isHidden = true
                
                
            }
            
            
            
            
            
        }
        
        
        communiTableView.beginUpdates()
        
        
        communiTableView.endUpdates()
        
        communiTableView .reloadData()
        
        
    }
    
    
    func showTemporaryMessage(message: String, duration: TimeInterval = 5.0) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        present(alertController, animated: true, completion: nil)
        
        // Automatically dismiss the alert after the specified duration
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            alertController.dismiss(animated: true, completion: nil)
        }
    }
    
    
    
    func apread(gesture : String){
        
        
        let readApiStatus  = AppReadStatusModal()
        
        readApiStatus.msgtype = type
        readApiStatus.priority = priority
        readApiStatus.userid = memberId
        readApiStatus.detailsid = gesture
        
        
        
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
    
    
    
    // This part full  is swipe bottom view
    
    
    
    
  
    
    
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
        
        
        
        if segTyp == "1"{
            
            unReadModal()
            
        }
        else{
            
            
            ReadApi()
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
        
        
        
        
        
        
        
        
        
        let login = LoginModal ()
        login.mobilenumber = MobileNumber
        login.Password = password
        print("passsdded", login.Password)
        
        
        let loginStr = login.toJSONString()
        
        loginRequest.call_request(param: loginStr!){ [self]
            
            (res) in
            
            
            let loginResponse : LoginResponse =
            Mapper<LoginResponse>().map(JSONString: res)!
            
            loginDatas = loginResponse.data
            print("ctrss",loginDatas.count)
            if (loginResponse.data.count >= 1){
                
                
                
                let vc = PriorityViewController(nibName: nil, bundle: nil)
                for i in loginResponse.data{
                    
                    
                    if i.priority == "p3"{
                        vc.IdentfierLabel = "STAFF"
                        vc.loginPrincipal.append(i)
                        
                    }
                    
                    else if i.priority == "p4"{
                        vc.loginStudent.append(i)
                        
                    }
                    
                    
                    else if i.priority == "p2"{
                        
                        vc.IdentfierLabel = "HOD"
                        vc.loginPrincipal.append(i)
                        
                    }
                    
                    else if i.priority == "p1"{
                        
                        vc.IdentfierLabel = "PRINCIPAL"
                        vc.loginPrincipal.append(i)
                    }
                    
                    else if i.priority == "p5"{
                        vc.IdentfierLabel = "PARENT"
                        vc.loginPrincipal.append(i)
                        
                        
                    }
                    
                    else if i.priority == "p6"{
                        
                        vc.IdentfierLabel = "NON TEACHING"
                        vc.loginPrincipal.append(i)
                    }
                    
                    else if i.priority == "p7"{
                        
                        vc.IdentfierLabel = "UNIVERSITY HEAD"
                        vc.loginPrincipal.append(i)
                    }
                }
                vc.modalPresentationStyle = .fullScreen
                
                present(vc, animated: true,completion: nil)
                
                
                
            }
        }
        
        
        
        
        
        
    }
    
}

class VoiceMessagesse : UITapGestureRecognizer {
    
    
    
    
    var sliders : UISlider!
    
    var timeLbl : UILabel!
    
    var img : UIImageView!
    
    var url : String!
    var button : UIButton!
    var tag : Int!
}


class EmargencyVoices : UITapGestureRecognizer {
    
    
    
    var EmergencyVoiceimg : UIImageView!
    
}


class CommuniAdd:UITapGestureRecognizer{
    
    
    var url : String!
    
}


