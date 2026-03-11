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
class CommuniSMSViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var reusee: ReuseView!
    
    
    @IBOutlet weak var plusView: UIViewX!
    
    @IBOutlet weak var tv: UITableView!
    
    
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
    
    @IBOutlet weak var communicationcountViews: UIViewX!
    
    @IBOutlet weak var unreadCountView: UIViewX!
    
    
    @IBOutlet weak var readCountView: UIViewX!
    
    
    
    @IBOutlet weak var communication: UILabel!
    
    @IBOutlet weak var CommuniSegementName: UISegmentedControl!
    
    @IBOutlet weak var readCountLabel: UILabel!
    
    @IBOutlet weak var noDataView: UIView!
    
    
    @IBOutlet weak var unreadCountLabel: UILabel!
    
    
    @IBOutlet weak var noDataTextLabel: UILabel!
    
    
    @IBOutlet weak var swipeMenuHeight: NSLayoutConstraint!
    
    
    
    @IBOutlet weak var redirectLoginView: UIViewX!
    
    var Textidentifier = "TextMessageTableViewCell"
    
    var ReadData : [SenderCommuniReadDataDetails] = []
    
    var UnReadData : [SenderCommuniUnReadDataDetails] = []
    var overAllRef    : [overAllDataDetails] = []
    var addapiRef : [AddDataDeatils] = []
    let menuIdentifier = "MenuCollectionViewCell"
    var MenuRefName :[menuApiDataDetails] = []
    var loginDatas : [datalogin]!
    var logindataprinci :[datalogin]!
    var is_read_enabled = ""
    var is_write_enabled = ""
    var ComunimenuId : String!
    var str : [String] = []
    
    var segmentype : String!
    var cloneList :  [SenderCommuniUnReadDataDetails] = []
    var segTyp : String! = "1"
    var cloneList1 : [SenderCommuniReadDataDetails] = []
    var strName : [String] = []
    
    var NoticeBoardId = "1"
    var videoId = "2"
    var EventId = "3"
    var communicationId = "4"
    var imagePdfId = "5"
    var Assigment = "6"
    
    var  password : String!
    var memberId : String!
    var priority : String!
    var collegeId : String!
    var departmentId : String!
    var sectionId : String!
    var loginType : String!
    var memberName : String!
    var colgImg    : String!
    var MobileNumber : String!
    var selectedCell:IndexPath?
    var indexPathss : Int!
    var type = ""
    var indexPathsections : Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        sideMenuView.isHidden = true
        
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
        
        //        previousAddId = previousAddId + 1
        
        
        addApi()
        
        
        if priority == "p4" || priority == "p5"{
            
            
            unReadModal()
        }else{
            
            if is_read_enabled == "1"{
                
                unReadModal()
                
            }else{}
            
        }
        
        
        
        overAllRefName()
        
        
        if is_write_enabled == "1"{
            
            plusView.isHidden = false
            
        }
        else{
            
            
            plusView.isHidden = true
        }
        
        
        
        if priority == "p1"{
            tapBarView.backgroundColor = UIColor(named: "Principal" )
            topLabels.text = "Principal"
            
        }
        
        else if priority == "p4"{
            plusView.isHidden = true
            topLabels.text = "Student"
            
            tapBarView.backgroundColor = UIColor(named: "studentViewColors")
        }
        
        else if priority == "p2" {
            
            
            plusView.backgroundColor = UIColor(named: "messagecolor")
            tapBarView.backgroundColor = UIColor(named: "Teaching Staff" )
            topLabels.text = "Hod"
            
            
        }
        else if priority == "p7" {
            
            
            plusView.backgroundColor = UIColor(named: "univercityColorCod")
            tapBarView.backgroundColor = UIColor(named: "univercityColorCod" )
            topLabels.text = "university Head"
            
            
        }
        
        else if priority == "p5"{
            
            plusView.isHidden = true
            topLabels.text = "Father"
            
            
            
        }
        
        else if priority == "p3"{
            
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
            
            print("CommuniSMSViewController",reusee.callid)
            
            
        }
        
        
        
        
        let TextRownib = UINib(nibName: Textidentifier, bundle: nil)
        tv.register(TextRownib, forCellReuseIdentifier: Textidentifier)
        
        
        
        
        noDataView.isHidden = true
        noDataTextLabel.isHidden = true
        
        
        let Serach = UITapGestureRecognizer(target: self, action: #selector(Searchfield))
        SearchView.addGestureRecognizer(Serach)
        
        
        let plusAddViews = UITapGestureRecognizer(target: self, action: #selector(PlusVc))
        plusView.addGestureRecognizer(plusAddViews)
        
        
        
        // tap Bar UiTapGuster.
        
        
        bigImg.sd_setImage(with: URL(string: "https://gradit.voicesnap.com/files/ads/SchoolChimes_ad.png"), placeholderImage: UIImage(named: "ic_white"))
        
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
        //
        
        let privacyPolicyGesture = UITapGestureRecognizer(target: self, action: #selector(privacyPolicyRedirect))
        privacyPolicyView.addGestureRecognizer(privacyPolicyGesture)
        
        let termsAndConditionGesture = UITapGestureRecognizer(target: self, action: #selector(termsAndCondition))
        termsAndConditionView.addGestureRecognizer(termsAndConditionGesture)
        
        
        
        
        
        let chagePassword = UITapGestureRecognizer(target: self, action: #selector(changePassowrdVC))
        changePasswordView.addGestureRecognizer(chagePassword)
        
        
        
        
    }
    
    
    @IBAction func Searchfield() {
        
        
        searchbar.isHidden  = false
        searchFullView .isHidden = false
        
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
        
        
        
        tv.reloadData()
        
        
        
        
        
        
        
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
        
        if is_read_enabled == "1"{
            if priority == "p6"{
                
                if CommuniSegementName.selectedSegmentIndex == 0{
                    
                    segmentype = "1"
                    
                    selectedCell = IndexPath()
                    tv.isScrollEnabled = false
                    unReadModal()
                    
                }
                
                else if CommuniSegementName.selectedSegmentIndex == 1{
                    
                    segTyp = "2"
                    segmentype = "2"
                    selectedCell = IndexPath()
                    tv.isScrollEnabled = false
                    ReadApi()
                    
                }
            }
            
            
            else {
                
                
                if CommuniSegementName.selectedSegmentIndex == 0{
                    segmentype = "1"
                    selectedCell = IndexPath()
                    tv.isScrollEnabled = false
                    unReadModal()
                    
                    
                }
                
                else if CommuniSegementName.selectedSegmentIndex == 1{
                    segTyp = "2"
                    segmentype = "2"
                    selectedCell = IndexPath()
                    tv.isScrollEnabled = false
                    ReadApi()
                    
                    
                }
                
            }
        }else{}
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if CommuniSegementName.selectedSegmentIndex == 0 {
            
            //
            return UnReadData.count
            
        }
        
        else if CommuniSegementName.selectedSegmentIndex == 1{
            //
            return ReadData.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Textidentifier, for: indexPath) as!
        TextMessageTableViewCell
        
        
        cell.selectionStyle = .none
        
        if let selectedCell = selectedCell, selectedCell == indexPath {
            
            cell.discreptionsLbl.isHidden = false
            cell.arrowImage.image = UIImage(named: "up")
            cell.sendByView.isHidden = false
            
        } else {
            
            cell.arrowImage.image = UIImage(named: "down")
            cell.discreptionsLbl.isHidden = true
            cell.sendByView.isHidden = true
        }
        
        if CommuniSegementName.selectedSegmentIndex == 0{
            
            let comuCell : SenderCommuniUnReadDataDetails = UnReadData[indexPath.row]
           
            if comuCell.isappread == "1"{
                
                cell.redDotImgView.isHidden =  true
            }
            
            else {
                
                cell.redDotImgView.isHidden = false
            }
            
            type = "Text"
            cell.TextImgView.image = UIImage(named: "dashboard_text")
            
            
            cell.MsgContentLbl.text = comuCell.msgcontent
            cell.discreptionsLbl.text =  comuCell.description.capitalized
            cell.SendByLbl.text = comuCell.sentby
            cell.dateLbl.text = comuCell.timing
            
            
            
        }
        
        
        
        else if CommuniSegementName.selectedSegmentIndex == 1 {
            
            
            
            let unreadCell : SenderCommuniReadDataDetails = ReadData[indexPath.row]
            
            print("unreadCell",unreadCell.isappread)
            if unreadCell.isappread == "1"{
                
                cell.redDotImgView.isHidden =  true
                
            }
            
            else {
                
                cell.redDotImgView.isHidden = false
                //
            }
            
            
            
            type = "Text"
            cell.TextImgView.image = UIImage(named: "dashboard_text")
            
            cell.MsgContentLbl.text = unreadCell.msgcontent
            cell.discreptionsLbl.text =  unreadCell.description.capitalized
            cell.SendByLbl.text = unreadCell.sentby
            cell.dateLbl.text = unreadCell.timing
            
            
            
            //
        }
        
        
        
        
        
        
        
        return cell
        
        
    }
    
    
    
    
    
    
    
    //
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Textidentifier, for: indexPath) as!
        TextMessageTableViewCell
        
        
        if CommuniSegementName.selectedSegmentIndex == 0{
            let comuCell : SenderCommuniUnReadDataDetails = UnReadData[indexPath.row]
            if let selectedCells = selectedCell, selectedCells == indexPath {
                
                
                selectedCell = nil
                
                
                
            } else {
                
                selectedCell = indexPath
                
                
                if comuCell.isappread == "0"{
                    
                    
                    apread(gesture : comuCell.msgdetailsid)
                    
                    comuCell.isappread = "1"
                    cell.redDotImgView.isHidden = true
                    
                }
            }
        }
        
        else if CommuniSegementName.selectedSegmentIndex == 1 {
            
            
            
            let unreadCell : SenderCommuniReadDataDetails = ReadData[indexPath.row]
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
        
        tv .reloadData()
        
        
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
            
            
            
            tv.delegate = self
            tv.dataSource = self
            tv.reloadData()
            
            
            
        }
        
        
        
        
    }
    
    
    
    
    
    func ReadApi() {
        
        
        
        
        
        let Commu = SenderCommuniReadModal()
        
        Commu.userid = memberId
        Commu.priority = priority
        Commu.readtype = "1"
        Commu.appid = "2"
        
        let commuStr = Commu.toJSONString()
        
        voiceAndTexRequest .call_request(param: commuStr!){ [self]
            
            (res) in
            
            
            let communicationResp : SenderCommuniReadResponce =
            Mapper<SenderCommuniReadResponce>().map(JSONString: res)!
            
            
            
            
            print("order data",communicationResp)
            
            if communicationResp.Status == 1{
                
                ReadData = communicationResp.data
                cloneList1 = communicationResp.data
                tv.isScrollEnabled = true
                noDataView.isHidden = true
                noDataTextLabel.isHidden = true
                tv.delegate = self
                tv.dataSource = self
                tv.isHidden = false
                tv.reloadData()
                
                
                
            }
            
            else{
                
                noDataView.isHidden = false
                noDataTextLabel.isHidden = false
                noDataTextLabel.text = communicationResp.Message
                tv.delegate = self
                tv.dataSource = self
                tv.isHidden = true
                tv.reloadData()
                
                
                
                
                
            }
            
            
        }
        
        
    }
    
    
    func unReadModal() {
        //UnRead
        
        let unreads = SenderCommuniUnReadModal()
        
        
        
        unreads.userid = memberId
        unreads.priority = priority
        unreads.readtype = "0"
        unreads.appid = "2"
        
        let unReadStr = unreads.toJSONString()
        
        
        
        voiceAndTexRequest .call_request(param: unReadStr!){ [self]
            
            (res) in
            
            
            let UnReadcommunicationResp : SenderCommuniUnReadResponce =
            Mapper<SenderCommuniUnReadResponce>().map(JSONString: res)!
            
            print("order data",UnReadcommunicationResp)
            
            
            if UnReadcommunicationResp.Status == 1{
                
                
                UnReadData = UnReadcommunicationResp.data
                cloneList = UnReadcommunicationResp.data
                tv.isScrollEnabled = true
                noDataView.isHidden = true
                noDataTextLabel.isHidden = true
                
                tv.delegate = self
                tv.dataSource = self
                tv.isHidden = false
                tv.reloadData()
                
                
            }
            
            else{
                
                
                
                noDataTextLabel.text = UnReadcommunicationResp.Message
                noDataView.isHidden = false
                noDataTextLabel.isHidden = false
                tv.isScrollEnabled = true
                tv.delegate = self
                tv.dataSource = self
                
                tv.isHidden = true
                
                tv.reloadData()
                
                
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
        
        print("order data233432",overall.toJSON())
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
                    
                    else if  i.unread == "0"{
                        
                        
                        unreadCountView.isHidden = false
                        readCountView.isHidden = true
                        communicationcountViews.isHidden = false
                    }
                    
                    else if i.read == "0"{
                        
                        
                        
                        unreadCountView.isHidden = true
                        readCountView.isHidden = false
                        communicationcountViews.isHidden = false
                        
                    }
                    
                    else{
                        
                        
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
        
        
        var add = AddApiModal()
        
        let defaults = UserDefaults.standard
        var deviceToken = defaults.string(forKey:DefaultsKeys.DeviceToken )
        add.device_token = deviceToken
        add.member_id = memberId
        add.mobile_no = MobileNumber
        add.priority = priority
        add.college_id = collegeId
        add.previous_add_id = 1
        
        APiCallManager.shared.callApi(url: APIEndpoints.GetAddsForCollege, httpMethod: .post, queryParam: nil, requestBody: add
        ) {[weak self] (result:Result<AddApiResponce,Error>) in
            
            guard let self = self else {return}
            
            switch result {
            case .success(let success):
                if success.Status == 1 {
                    addapiRef = success.data ?? []
                    
                    for i in addapiRef{
                      
                        bigImg.sd_setImage(with: URL(string: i.background_image ?? ""), placeholderImage: UIImage(named: "ic_white"))
                        
                        smallImg.sd_setImage(with: URL(string: i.add_image ?? ""), placeholderImage: UIImage(named: "ic_white"))
                        
//                        let singleTap = adds(target: self, action: #selector(adLoad))
//                        singleTap.url = i.add_url
                       // bigImg.isUserInteractionEnabled = true
                        //bigImg.addGestureRecognizer(singleTap)
                    }
                }
                
            case .failure(let failure):
                print(failure.localizedDescription)
            }
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
            //
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
    
}
