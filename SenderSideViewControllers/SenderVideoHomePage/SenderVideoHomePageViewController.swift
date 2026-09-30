//
//  SenderVideoHomePageViewController.swift
//  GraditSenderVideoMenu
//
//  Created by MACBOOKPRO on 03/12/22.
//

import UIKit
import ObjectMapper
import KRProgressHUD

@available(iOS 16.0, *)
class SenderVideoHomePageViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var countLbl: UILabel!
    @IBOutlet weak var countView: UIView!
    @IBOutlet weak var SearchView: UIView!
    @IBOutlet weak var searchFullView: UIViewX!
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var tapNameview: UIView!
    @IBOutlet weak var tapBarView: UIViewX!
    @IBOutlet weak var redirectLoginView: UIViewX!
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var smallImg: UIImageView!
    @IBOutlet weak var bigImg: UIImageView!
    @IBOutlet weak var plusPageView: UIViewX!
    @IBOutlet weak var privacyPolicyView: UIView!
    @IBOutlet weak var helpView: UIView!
    @IBOutlet weak var faqView: UIView!
    @IBOutlet weak var refreshView: UIView!
    @IBOutlet weak var logoutView: UIView!
    @IBOutlet weak var changeRolesView: UIView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var topLabels: UILabel!
    @IBOutlet weak var topMessageLabel: UILabel!
    @IBOutlet weak var clgLogoImg: UIImageView!
    @IBOutlet weak var sideMenuView: UIView!
    @IBOutlet weak var viewTap: UIView!
    @IBOutlet weak var changePasswordView: UIView!
    @IBOutlet weak var termsAndConditionView: UIView!
    @IBOutlet weak var videoTableView: UITableView!
    @IBOutlet weak var noDataTextLabel: UILabel!
    @IBOutlet weak var noDataView: UIView!
    
    var videoId = "2"
    var videoRef     : [SendervideoDataDetails] = []
    var addapiRef : [AddDataDeatils] = []
    var identifers = "VideoTableViewCell"
    var selectedCell : IndexPath?
    var memberId : String!
    var priority : String!
    var colgId   : String!
    var memberName : String!
    var colgImg : String!
    var mobileNumber : String!
    var loginDatas : [datalogin]!
    var logindataprinci :[datalogin]!
    var str : [String] = []
    var strName : [String] = []
    var is_read_enabled = ""
    var is_write_enabled = ""
    var password : String!
    var PreviousAddId : Int = 0
    var cloneList : [SendervideoDataDetails] = []
    
    override func viewDidAppear(_ animated: Bool) {
        
        PreviousAddId = PreviousAddId+1
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        
        sideMenuView.isHidden = true
        
        searchbar.delegate = self
        searchbar.isHidden  = true
        searchFullView .isHidden = true
        
        let defaults = UserDefaults.standard
        memberId = defaults.string(forKey: DefaultsKeys.memberid)
        priority = defaults.string(forKey: DefaultsKeys.priority)
        colgId = defaults.string(forKey: DefaultsKeys.collegeid)
        memberName = defaults.string(forKey: DefaultsKeys.memberName)
        mobileNumber = defaults.string(forKey: DefaultsKeys.mobileNumber)
        colgImg = defaults.string(forKey: DefaultsKeys.colglogo)
        clgLogoImg.sd_setImage(with: URL(string:  colgImg), placeholderImage: UIImage(named: "EmptyCollegeIcon"))
        password = defaults.string(forKey: DefaultsKeys.Password)
        
        topMessageLabel.text = memberName
        
        addApi()
        
        videoModals()
        
        countView.layer.cornerRadius = 10
        
        view.backgroundColor = .priorityColor
        tapBarView.backgroundColor = .priorityColor
        topLabels.text = .priorityRole
        plusPageView.backgroundColor = UIColor(named: "messagecolor")
        plusPageView.isHidden = priority == "p6" ? true : false
        
        let plusPageViews = UITapGestureRecognizer(target: self, action: #selector(plusPageVc))
        plusPageView.addGestureRecognizer(plusPageViews)
        
        let rownib = UINib(nibName: identifers, bundle: nil)
        videoTableView.register(rownib, forCellReuseIdentifier: identifers)
        
        videoTableView.delegate = self
        videoTableView.dataSource = self
        
        noDataView.isHidden = true
        noDataTextLabel.isHidden = true
        
        
        let changeRolesGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        changeRolesView.addGestureRecognizer(changeRolesGesture)
        
        
        let tpname = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        tapNameview.addGestureRecognizer(tpname)
        
        
        let logoutGesture = UITapGestureRecognizer(target: self, action: #selector(logoutPressed))
        logoutView.addGestureRecognizer(logoutGesture)
        
        
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
        
        
        let loginRediectGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        redirectLoginView.addGestureRecognizer(loginRediectGesture)
        
        
        let chagePassword = UITapGestureRecognizer(target: self, action: #selector(changePassowrdVC))
        changePasswordView.addGestureRecognizer(chagePassword)
        
        
        let Serach = UITapGestureRecognizer(target: self, action: #selector(Searchfield))
        SearchView.addGestureRecognizer(Serach)
    }
    
    @IBAction func Searchfield() {
        
        searchbar.isHidden  = false
        searchFullView .isHidden = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let filtered_list : [SendervideoDataDetails] = cloneList
        
        if !searchText.isEmpty{
            
            let search = searchText.lowercased()
            
            videoRef = filtered_list.filter {
                
                ($0.description?.lowercased().contains(search) ?? false) ||
                ($0.createdby?.lowercased().contains(search) ?? false) ||
                ($0.createdon?.lowercased().contains(search) ?? false) ||
                ($0.title?.lowercased().contains(search) ?? false)
                
            }
            
        }else{
            
            videoRef = filtered_list
        }
        
        videoTableView.reloadData()
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
        searchbar.resignFirstResponder()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoRef.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifers, for: indexPath) as!
        VideoTableViewCell
        
        cell.selectionStyle = .none
        
        let video : SendervideoDataDetails = videoRef[indexPath.row]
        
        cell.sentByLableCell.text = video.createdby
        cell.descriptionLableCell.text = video.description
        cell.titleLableCell.text  = video.title?.capitalized
        cell.redDotImageView.isHidden = video.isappviewed == "1" ? true : false
        
        let value = video.createdon ?? ""

        let inputFormatter = DateFormatter()
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        inputFormatter.dateFormat = "dd MMM yyyy hh:mm a"

        if let date = inputFormatter.date(from: value) {

            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "dd MMM yyyy"

            let timeFormatter = DateFormatter()
            timeFormatter.locale = Locale(identifier: "en_US_POSIX")
            timeFormatter.dateFormat = "hh:mm a"

            cell.dateLabel.text = dateFormatter.string(from: date)
            cell.timeLabel.text = timeFormatter.string(from: date)
        }
        
        if let selectedCells = selectedCell, selectedCells == indexPath {
            cell.descriptionLableCell.isHidden = false
            cell.downArrowImage.image = UIImage(systemName: "chevron.up")
            cell.sendByview.isHidden = false
            
        } else {
            cell.descriptionLableCell.isHidden = true
            cell.downArrowImage.image = UIImage(systemName: "chevron.down")
            cell.sendByview.isHidden = true
            
        }
        
        let  play = videoGesture(target: self, action: #selector(connected))
        play.title = video.title
        play.desc = video.description
        play.videoUrl = video.iframe
        play.videoid = video.vimeoid
        cell.playView.addGestureRecognizer(play)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        videoTableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifers, for: indexPath) as!
        VideoTableViewCell
        
        if let selectedCells = selectedCell, selectedCells == indexPath {
            
            
            selectedCell = nil
            
        } else {
            
            selectedCell = indexPath
            
            if videoRef[indexPath.row].isappviewed == "0"{
                
                apread(gesture : videoRef[indexPath.row].detailid ?? "")
                
                videoRef[indexPath.row].isappviewed = "1"
                cell.redDotImageView.isHidden = true
                
            }
        }
        
        videoTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    @IBAction func connected( gestures : videoGesture) {
        
        let vc = SenderPlayingVideoViewController(nibName: nil, bundle: nil)
        vc.titlesss = gestures.title
        vc.descriptionszs = gestures.desc
        vc.url = gestures.videoUrl
        vc.videoid = gestures.videoid
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func plusPageVc(){
        
        let add = addapiRef.last
        
        let vc = VideoRestionViewController(nibName: nil, bundle: nil)
        
        vc.addImageBackGroundurl = add?.background_image
        vc.smallImageUrl = add?.add_image
        vc.imageWebUrl = add?.add_url
        vc.videoMenuId = videoId
        vc.str  = str
        vc.is_read_enabled = is_read_enabled
        vc.is_write_enabled = is_write_enabled
        vc.strName = strName
        vc.modalPresentationStyle = .formSheet
        present(vc, animated: true,completion: nil)
    }
    
    func apread(gesture : String){
        
        var readApiStatus  = AppReadStatusModal()
        
        readApiStatus.msgtype = "video"
        readApiStatus.priority = priority
        readApiStatus.userid = memberId
        readApiStatus.detailsid = gesture
        
        APiCallManager.shared.callApi(url: APIEndpoints.Appreadstatus, httpMethod: .post, queryParam: nil, requestBody: readApiStatus) {[weak self]  (result:Result<ReadStausApiResponce, Error>) in
            
            guard let self = self else {return}
            
            switch result {
            case .success(let success):
                videoTableView.reloadData()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func videoModals() {
        
        var vedi = SendervideoModal()
        
        vedi.userid = memberId
        vedi.collegeid = colgId
        vedi.priority =  priority
        
        APiCallManager.shared.callApi(url: APIEndpoints.GetVideoList, httpMethod: .post, queryParam: nil, requestBody: vedi) { [weak self] (result:Result<SendervideoResponce,Error>) in
            guard let self = self else{return}
            switch result{
            case .success(let VideoResp):
                
                videoRef = VideoResp.data ?? []
                cloneList = VideoResp.data ?? []
                countLbl.text = "\(videoRef.count)"
                noDataView.isHidden = !videoRef.isEmpty
                noDataTextLabel.isHidden = !videoRef.isEmpty
                noDataTextLabel.text = VideoResp.Message
                videoTableView.reloadData()
                
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func addApi(){
        
        var add = AddApiModal()
        
        let defaults = UserDefaults.standard
        var deviceToken = defaults.string(forKey:DefaultsKeys.DeviceToken )
        add.device_token = deviceToken
        add.member_id = Int(memberId)
        add.mobile_no = mobileNumber
        add.priority = priority
        add.college_id = Int(colgId)
        add.previous_add_id = PreviousAddId
        
        APiCallManager.shared.callApi(url: APIEndpoints.GetAddsForCollege, httpMethod: .post, queryParam: nil, requestBody: add
        ) {[weak self] (result:Result<AddApiResponce,Error>) in
            
            guard let self = self else {return}
            
            switch result {
            case .success(let success):
                if success.Status == 1 {
                    addapiRef = success.data ?? []
                    bgView.isHidden = addapiRef.count == 0
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
    
    
    @IBAction func adLoad( gesture : videoAdd){
        
        let vc = TotalAddLoadPageViewController(nibName: nil, bundle: nil)
        vc.AddWebUrl = gesture.url
        vc.modalPresentationStyle = . fullScreen
        present(vc, animated: true,completion: nil)
        
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
    
    @IBAction func refreshVc() {
        videoModals()
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
        
        sideMenuView.isHidden.toggle()
      
    }
    
    @IBAction func changePassowrdVC(){
        
        let vc = ChangePasswordVC(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
          
    }
    
    @IBAction func priorityVc() {
        
        let vc = PriorityScreenVC(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
    }
    
}

class videoAdd : UITapGestureRecognizer{

    var url : String!
}
