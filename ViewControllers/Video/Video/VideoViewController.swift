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
    
    @IBOutlet weak var reusee: ReuseView!
    @IBOutlet weak var topNameview: UIView!
    @IBOutlet weak var tapBarView: UIViewX!
    @IBOutlet weak var loadingCustom: UIActivityIndicatorView!
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
    
    
    
    @IBOutlet weak var swipeMenuHeight: NSLayoutConstraint!
    
  
    @IBOutlet weak var searchbar: UISearchBar!
 
    
    @IBOutlet weak var privacyPolicyView: UIView!
   
    var identifers = "VideoTableViewCell"
    
    
    
    var addapiRef : [AddDataDeatils] = []
    var videoRef     : [videoDataDetails] = []
    let menuIdentifier = "MenuCollectionViewCell"
    var MenuRefName :[menuApiDataDetails] = []
    
    var loginDatas : [datalogin]!
    var logindataprinci :[datalogin]!
    var selectedIndex = -1
    var isclosaps = false
    var selectedCell : IndexPath?
    var collegeid : String!
    var userid : String!
    var priority : String!
    var loginType : String!
    var memberName : String!
    var colgImg : String!
    var MobileNumber : String!
    
    
    var PreviousAddId : Int = 0
    
    var password : String!
    
    var str : [String] = []
    
    var strName : [String] = []
    
    var cloneList  : [videoDataDetails] = []
    
    var is_read_enabled = ""
    var is_write_enabled = ""
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        print("kljjjjjjjjj")
        
        
        PreviousAddId = PreviousAddId+1
        
        addApi()
        
        print("jkkkkkkk",PreviousAddId)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        loadingCustom.startAnimating()
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
        loginType = defaults.string(forKey: DefaultsKeys.loginAsType)
        memberName = defaults.string(forKey: DefaultsKeys.memberName)
        colgImg = defaults.string(forKey: DefaultsKeys.colglogo)
        clgLogoImg.sd_setImage(with: URL(string:  colgImg), placeholderImage: UIImage(named: "person.fill"))
        password = defaults.string(forKey: DefaultsKeys.Password)
        topMessageLabel.text = memberName
        MobileNumber = defaults.string(forKey: DefaultsKeys.mobileNumber)
        
        
        
        videoModals()
        
        
        
        
        if priority == "p1"{
            
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
                   
                    print("VideoViewController",reusee.callid)
                    
               
                }
        
       
        
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
        
        
        
    }
    
    
    @IBAction func Searchfield() {
        
        
        searchbar.isHidden  = false
        searchFullView .isHidden = false
        
        
        
        
        
        
        
        
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        let filtered_list : [videoDataDetails] = cloneList
        
        
        if !searchText.isEmpty{
            let search = searchText.lowercased()

            videoRef = filtered_list.filter {

                ($0.createdon?.lowercased().contains(search) ?? false) ||
                ($0.title?.lowercased().contains(search) ?? false) ||
                ($0.description?.lowercased().contains(search) ?? false) ||
                ($0.createdby?.lowercased().contains(search) ?? false)

            }
            
        }else{
            videoRef = filtered_list
        }
        
        
        
        
        
        
        
        if videoRef.count > 0{
            
            
            
            print ("searchListPendigCount",videoRef.count)
            
            noDataView.isHidden = true
            noDataTextLabel.isHidden = true
            
            
        }else{
            
            
            
            
            noDataView.isHidden = false
            noDataTextLabel.isHidden = false
            noDataTextLabel.text = "No Records Found"
            
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
        add.member_id = userid
        add.mobile_no = MobileNumber
        add.priority = priority
        add.college_id = collegeid
        add.previous_add_id = PreviousAddId
        
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
        return videoRef.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifers, for: indexPath) as!
        VideoTableViewCell
        
        
        cell.selectionStyle = .none
        if let selectedCells = selectedCell, selectedCells == indexPath {
            
            cell.descriptionLableCell.isHidden = false
            
            cell.downArrowImage.image = UIImage(named: "Ups")
            cell.sendByview.isHidden = false
            
        } else {
            
            cell.descriptionLableCell.isHidden = true
            cell.downArrowImage.image = UIImage(named: "downs")
            cell.sendByview.isHidden = true
            
        }
        
        let Shopres : videoDataDetails = videoRef[indexPath.row]
        
        let  a = Shopres.createdby?.count ?? 0*2
        
        let b = a+170
        
        cell.sendbyWidth.constant = CGFloat(b)
        cell.sentByLableCell.text = Shopres.createdby
        cell.descriptionLableCell.text = Shopres.description
        cell.titleLableCell.text  = Shopres.title?.capitalized
        cell.dateTimeLabelCell.text = Shopres.createdon
        
        if Shopres.isappviewed == "1"{
            
            
            cell.redDotImageView.isHidden = true
            
            
        }
        
        else {
            
            cell.redDotImageView.isHidden = false
        }
        
        
        
        let nexts : videoDataDetails = videoRef[indexPath.row]
        
        
        let  play = videoGesture(target: self, action: #selector(connected))
        play.title = nexts.title
        play.desc = nexts.description
        play.videoUrl = nexts.iframe
        play.videoid = nexts.vimeoid
        cell.playView.addGestureRecognizer(play)
        
        
        return cell
        
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
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        videoTableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifers, for: indexPath) as!
        VideoTableViewCell
        
        
        var Shopres : videoDataDetails = videoRef[indexPath.row]
        
        
        
        
        if let selectedCells = selectedCell, selectedCells == indexPath {
            
            selectedCell = nil
            
        }
        
        else{
            
            selectedCell = indexPath
            
            if Shopres.isappviewed == "0"{
                
                apread(gesture : Shopres.detailid ?? "")
                
                Shopres.isappviewed = "1"
                cell.redDotImageView.isHidden = true
                
            }
            
            
            
        }
        
        
        videoTableView.beginUpdates()
        videoTableView.endUpdates()
        videoTableView.reloadData()
        
    }
    
    
    
    func apread(gesture : String){
        
        
        let readApiStatus  = AppReadStatusModal()
        
        readApiStatus.msgtype = "video"
        readApiStatus.priority = priority
        readApiStatus.userid = userid
        readApiStatus.detailsid = gesture
        print("sertt",gesture)
        
        
        let commuS = readApiStatus.toJSONString()
        
        ApiReadStatusRequest .call_request(param: commuS!){ [self]
            
            (res) in
            
            
            let com : ReadStausApiResponce =
            Mapper<ReadStausApiResponce>().map(JSONString: res)!
            
            videoTableView.delegate = self
            videoTableView.dataSource = self
            videoTableView.reloadData()
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        return UITableView.automaticDimension
    }
    
    func videoModals() {
        
        var vedi = videoModal()
        
        vedi.userid       =   userid
        vedi.collegeid     =  collegeid
        vedi.priority      =   priority
        
        APiCallManager.shared.callApi(url: APIEndpoints.GetVideoList, httpMethod: .post, queryParam: nil, requestBody: vedi) { [weak self] (result:Result<videoResponce,Error>) in
            guard let self = self else{return}
            switch result{
            case .success(let VideoResp):
                if VideoResp.Status == 1 {
                    videoRef = VideoResp.data ?? []
                    
                    cloneList = VideoResp.data ?? []
                    noDataView.isHidden = true
                    noDataTextLabel.isHidden = true
                    
                    videoTableView.dataSource = self
                    videoTableView.delegate = self
                    
                    videoTableView.reloadData()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3 ){ [self] in
                        
                        self.loadingCustom.stopAnimating()
                        
                        
                        self.loadingCustom.isHidden  = true
                        
                    }
                    
                }else{
                    
                    noDataView.isHidden = false
                    noDataTextLabel.isHidden = false
                    noDataTextLabel.text = VideoResp.Message
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3 ){ [self] in
                        
                        self.loadingCustom.stopAnimating()
                        
                        
                        self.loadingCustom.isHidden  = true
                        
                    }
                }

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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            KRProgressHUD.dismiss()
            
        }
        
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
        
        if sideMenuView.isHidden == true{
            
            sideMenuView.isHidden = false
            //
            
            print("menuVisble")
        }
        
        else{
            
            sideMenuView.isHidden = true
            
        }
        
        
    }
    
    
    @IBAction func changePassowrdVC(){
        
        let vc = ChangePasswordViewController(nibName: nil, bundle: nil)
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
        let vc = PriorityViewController(nibName: nil, bundle: nil)
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
