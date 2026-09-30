//
//  VideoViewController.swift
//  VideoGradit
//
//  Created by MACBOOKPRO on 23/10/22.
//

import UIKit
import ObjectMapper
import AVFoundation
import AVKit
import KRProgressHUD

@available(iOS 16.0, *)
class VideoViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,AVPlayerViewControllerDelegate,UISearchBarDelegate{
    
    @IBOutlet weak var topNameview: UIView!
    @IBOutlet weak var tapBarView: UIViewX!
    @IBOutlet weak var redirectLoginView: UIViewX!
    @IBOutlet weak var logoutView: UIView!
    @IBOutlet weak var changeRolesView: UIView!
    @IBOutlet weak var topLabels: UILabel!
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var clgLogoImg: UIImageView!
    @IBOutlet weak var changePasswordView: UIView!
    @IBOutlet weak var topMessageLabel: UILabel!
    @IBOutlet weak var termsAndConditionView: UIView!
    @IBOutlet weak var helpView: UIView!
    @IBOutlet weak var sideMenuView: UIView!
    @IBOutlet weak var viewTap: UIView!
    @IBOutlet weak var refreshView: UIView!
    @IBOutlet weak var SearchView: UIView!
    @IBOutlet weak var faqView: UIView!
    @IBOutlet weak var searchFullView: UIViewX!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var noDataTextLabel: UILabel!
    @IBOutlet weak var adView: UIView!
    @IBOutlet weak var smallImg: UIImageView!
    @IBOutlet weak var videoTableView: UITableView!
    @IBOutlet weak var noDataView: UIView!
    @IBOutlet weak var bigImg: UIImageView!
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var privacyPolicyView: UIView!
    
    var identifers = "VideoTableViewCell"
    var addapiRef : [AddDataDeatils] = []
    var selectedCell : IndexPath?
    var collegeid : String!
    var userid : String!
    var priority : String!
    var memberName : String!
    var colgImg : String!
    var MobileNumber : String!
    var PreviousAddId : Int = 0
    var password : String!
    var str : [String] = []
    var strName : [String] = []
    var VideoDataList  : [videoDataDetails] = []
    var FiltervideoDataList    : [videoDataDetails] = []
    
    override func viewDidAppear(_ animated: Bool) {
        
        PreviousAddId = PreviousAddId+1
        addApi()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        noDataView.isHidden =  true
        noDataTextLabel.isHidden = true
        sideMenuView.isHidden = true
        searchbar.delegate = self
        searchbar.isHidden  = true
        searchFullView .isHidden = true
        
        let defaults = UserDefaults.standard
        
        collegeid = defaults.string(forKey: DefaultsKeys.collegeid)
        userid = defaults.string(forKey: DefaultsKeys.memberid)
        priority = defaults.string(forKey:DefaultsKeys.priority)
        memberName = defaults.string(forKey: DefaultsKeys.memberName)
        colgImg = defaults.string(forKey: DefaultsKeys.colglogo)
        clgLogoImg.sd_setImage(with: URL(string:  colgImg), placeholderImage: UIImage(named: "EmptyCollegeIcon"))
        password = defaults.string(forKey: DefaultsKeys.Password)
        topMessageLabel.text = memberName
        MobileNumber = defaults.string(forKey: DefaultsKeys.mobileNumber)
        
        videoModals()
        
        view.backgroundColor = .priorityColor
        tapBarView.backgroundColor = .priorityColor
        topLabels.text = .priorityRole
        
        let rownib = UINib(nibName: identifers, bundle: nil)
        videoTableView.register(rownib, forCellReuseIdentifier: identifers)
        
        // tap Bar UiTapGuster.
        
        let loginRediectGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        redirectLoginView.addGestureRecognizer(loginRediectGesture)
        
        let profileGesture = UITapGestureRecognizer(target: self, action: #selector(profileRedirect))
        profileView.addGestureRecognizer(profileGesture)
        
        let changeRolesGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        changeRolesView.addGestureRecognizer(changeRolesGesture)
        
        let topnam = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        topNameview.addGestureRecognizer(topnam)
        
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
        
        let chagePassword = UITapGestureRecognizer(target: self, action: #selector(changePassowrdVC))
        changePasswordView.addGestureRecognizer(chagePassword)
        
        let Serach = UITapGestureRecognizer(target: self, action: #selector(Searchfield))
        SearchView.addGestureRecognizer(Serach)
        
        videoTableView.dataSource = self
        videoTableView.delegate = self
    }
    
    
    @IBAction func Searchfield() {
        
        searchbar.isHidden  = false
        searchFullView .isHidden = false
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        if searchText.isEmpty {
            FiltervideoDataList = VideoDataList
        }else {
            
            let search = searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
            
            FiltervideoDataList = VideoDataList.filter({
                $0.title?.lowercased().contains(search) ?? false ||
                $0.description?.lowercased().contains(search) ?? false ||
                $0.createdby?.lowercased().contains(search) ?? false ||
                $0.createdon?.lowercased().contains(search) ?? false
            })
        }
        
        if FiltervideoDataList.isEmpty{
            
            noDataView.isHidden = false
            noDataTextLabel.isHidden = false
            noDataTextLabel.text = "No Records Found"
            
        }else{
            noDataView.isHidden = true
            noDataTextLabel.isHidden = true
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
        noDataView.isHidden = true
        noDataTextLabel.isHidden = true
        searchbar.resignFirstResponder()
    }
    
    
    @objc func dismissKeyboards() {
        
        sideMenuView.isHidden = true
        view.endEditing(true)
        
    }
    
    func addApi(){
        
        
        var add = AddApiModal()
        
        let defaults = UserDefaults.standard
        var deviceToken = defaults.string(forKey:DefaultsKeys.DeviceToken )
        add.device_token = deviceToken
        print("EventDefaultsKeys.DeviceToken",deviceToken)
        add.member_id = Int(userid)
        add.mobile_no = MobileNumber
        add.priority = priority
        add.college_id = Int(collegeid)
        add.previous_add_id = PreviousAddId
        
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
        return FiltervideoDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifers, for: indexPath) as!
        VideoTableViewCell
        
        cell.selectionStyle = .none
        
        let video : videoDataDetails = FiltervideoDataList[indexPath.row]
        
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
            
        } else{
            
            selectedCell = indexPath
            
            if FiltervideoDataList[indexPath.row].isappviewed == "0"{
                apread(gesture : FiltervideoDataList[indexPath.row].detailid ?? "")
                FiltervideoDataList[indexPath.row].isappviewed = "1"
                cell.redDotImageView.isHidden = true
            }
        }
        
        videoTableView.reloadData()
    }
    
    @IBAction func connected( gesture : videoGesture) {
        
        let vc = VideoPlayerViewController(nibName: nil, bundle: nil)
        vc.titlesss = gesture.title
        vc.descriptionszs = gesture.desc
        vc.url = gesture.videoUrl
        vc.videoid = gesture.videoid
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func adLoad(gesture : addGesture) {
        
        let vc =  AddVideoViewController(nibName: nil, bundle: nil)
        vc.AddImageUrl = gesture.urls
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
        
    }
    
    func apread(gesture : String){
        var readApiStatus  = AppReadStatusModal()
        
        readApiStatus.msgtype = "video"
        readApiStatus.priority = priority
        readApiStatus.userid = userid
        readApiStatus.detailsid = gesture
        
        APiCallManager.shared.callApi(url: APIEndpoints.Appreadstatus, httpMethod: .post, queryParam: nil, requestBody: readApiStatus) {[weak self]  (result:Result<ReadStausApiResponce, Error>) in
            
            guard let self = self else {return}
            
            switch result {
            case .success(_):
                videoTableView.reloadData()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    func videoModals() {
        
        var vedi = videoModal()
        
        vedi.userid = userid
        vedi.collegeid = collegeid
        vedi.priority = priority
        
        APiCallManager.shared.callApi(url: APIEndpoints.GetVideoList, httpMethod: .post, queryParam: nil, requestBody: vedi) { [weak self] (result:Result<videoResponce,Error>) in
            
            guard let self = self else{return}
            
            switch result{
                
            case .success(let VideoResp):
                
                VideoDataList = VideoResp.data ?? []
                FiltervideoDataList = VideoResp.data ?? []
                noDataTextLabel.text = VideoResp.Message
                noDataView.isHidden = !FiltervideoDataList.isEmpty
                noDataTextLabel.isHidden = !FiltervideoDataList.isEmpty
                videoTableView.reloadData()
                
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
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
        
        KRProgressHUD.show()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            KRProgressHUD.dismiss()
        }
        
        videoModals()
    }
    
    @IBAction func notificationVc() {
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
    
    
    @IBAction func profileRedirect() {
        
        let vc = ProfileViewController(nibName: nil, bundle: nil)
        vc.str = str
        vc.strName = strName
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func priorityVc() {
        let vc = PriorityScreenVC(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
    }
    
}

class videoGesture : UITapGestureRecognizer {
    
    var title : String!
    var desc : String!
    var videoUrl : String!
    var videoid : String!
    var url : String!
}

class addGesture : UITapGestureRecognizer{
    var urls : String!
}
