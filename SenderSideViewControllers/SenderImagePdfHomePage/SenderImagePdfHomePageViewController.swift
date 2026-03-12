//
//  SenderImagePdfHomePageViewController.swift
//  GraditImagePdf
//
//  Created by MACBOOKPRO on 07/12/22.
//

import UIKit
import ObjectMapper
import WebKit
import KRProgressHUD

@available(iOS 16.0, *)
class SenderImagePdfHomePageViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate {
    
    @IBOutlet weak var reusee: ReuseView!
    @IBOutlet weak var SearchView: UIView!
    @IBOutlet weak var searchFullView: UIViewX!
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var topNameview: UIView!
    @IBOutlet weak var tapBarView: UIViewX!
    @IBOutlet weak var loadingCustom: UIActivityIndicatorView!
    
    @IBOutlet weak var redirectLoginView: UIViewX!
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var smallImg: UIImageView!
    
    @IBOutlet weak var bigImg: UIImageView!
    @IBOutlet weak var logoutView: UIView!
    
    @IBOutlet weak var changeRolesView: UIView!
    
    
    @IBOutlet weak var profileView: UIView!
    
    
    @IBOutlet weak var topLabels: UILabel!
    @IBOutlet weak var topMessageLabel: UILabel!
    
    
    @IBOutlet weak var clgLogoImg: UIImageView!
    @IBOutlet weak var refreshView: UIView!
    
    @IBOutlet weak var sideMenuView: UIView!
    
    
    @IBOutlet weak var termsAndConditionView: UIView!
    
    
    
    @IBOutlet weak var changePasswordView: UIView!
    
    
    
    @IBOutlet weak var privacyPolicyView: UIView!
    
    
    @IBOutlet weak var faqView: UIView!
    
    
    @IBOutlet weak var viewTap: UIView!
    
    
    
    
    @IBOutlet weak var helpView: UIView!
    
    
    
    
    
    @IBOutlet weak var swipeMenuHeight: NSLayoutConstraint!
    
    
    
    @IBOutlet weak var plusImageView: UIImageView!
    
    
    @IBOutlet weak var imageCountView: UIViewX!
    
    
    @IBOutlet weak var collegeCountView: UIViewX!
    
    
    @IBOutlet weak var departmetCountView: UIViewX!
    
    
    
    
    @IBOutlet weak var noDataLabel: UILabel!
    @IBOutlet weak var departmentCountLabel: UILabel!
    @IBOutlet weak var collegeCountLabel: UILabel!
    @IBOutlet weak var imageTableView: UITableView!
    
    @IBOutlet weak var imageTopCountLabel: UILabel!
    
    @IBOutlet weak var imageSegmentName: UISegmentedControl!
    
    @IBOutlet weak var noDataTextView: UIView!
    
    
    @IBOutlet weak var plusView: UIViewX!
    
    var iscolap = false
    var imageFileType : String!
    
    var  imagePdfMenuIdType : String!
    
    var NoticeBoardId = "1"
    var videoId = "2"
    var EventId = "3"
    var communicationId = "4"
    var imagePdfId = "5"
    var Assigment = "6"
    
    
    var departmentRef     : [SenderDepartmentImageDataDetails] = []
    var collegeRef     : [SenderDepartmentImageDataDetails] = []
    var overAllRef    : [overAllDataDetails] = []
    
    var identifers = "SenderImagePdfTableViewCell"
    let menuIdentifier = "MenuCollectionViewCell"
    var MenuRefName :[menuApiDataDetails] = []
    var addapiRef : [AddDataDeatils] = []
    var selectedCell : IndexPath?
    var isColapes = false
    var filePathStr : [String] = []
    
    var memberId : String!
    var priority : String!
    var collegId  : String!
    var departmentId : String!
    var sectionId : String!
    var loginType : String!
    
    var memberName : String!
    var colgImg :String!
    
    var mobileNumber : String!
    
    var loginDatas : [datalogin]!
    var logindataprinci :[datalogin]!
    
    var PreviousAddId : Int = 0
    
    
    var password : String!
    
    var str : [String] = []
    
    var strName : [String] = []
    var is_read_enabled = " "
    var is_write_enabled = " "
    
    var segmentType : String!
    
    var cloneList   : [SenderDepartmentImageDataDetails] = []
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        print("kljjjjjjjjj")
        
        
        PreviousAddId = PreviousAddId+1
        
        //        addApi()
        
        print("jkkkkkkk",PreviousAddId)
        
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        plusView.isHidden = true
        loadingCustom.startAnimating()
        sideMenuView.isHidden = true
        searchbar.isHidden = true
        searchFullView.isHidden = true
        searchbar.delegate = self
        PreviousAddId = PreviousAddId+1
        let defaults = UserDefaults.standard
        
        memberId = defaults.string(forKey: DefaultsKeys.memberid)
        priority = defaults.string(forKey: DefaultsKeys.priority)
        collegId = defaults.string(forKey: DefaultsKeys.collegeid)
        departmentId = defaults.string(forKey: DefaultsKeys.deptid)
        sectionId = defaults.string(forKey: DefaultsKeys.sectionid)
        loginType = defaults.string(forKey: DefaultsKeys.loginAsType)
        mobileNumber  = defaults.string(forKey: DefaultsKeys.mobileNumber)
        
        password = defaults.string(forKey: DefaultsKeys.Password)
        if sectionId == ""{
            
            sectionId = "0"
            
        }
        memberName = defaults.string(forKey: DefaultsKeys.memberName)
        colgImg = defaults.string(forKey: DefaultsKeys.colglogo)
        clgLogoImg.sd_setImage(with: URL(string:  colgImg), placeholderImage: UIImage(named: "person.fill"))
        
        topMessageLabel.text = memberName
        
        addApi()
        
        print("is_read_enabled45678", is_read_enabled)
        print("is_read_enabled345678", is_write_enabled)
        if is_read_enabled == "1"{
            departRefName()
        }else{}
        
        if is_write_enabled == "1"{
            
            plusView.isHidden = false
        }else{
            
            plusView.isHidden = true
        }
        
        
        
        
        
        if priority == "p1"{
            tapBarView.backgroundColor = UIColor(named: "Principal" )
            topLabels.text = "Principal"
            
            overAllRefName()
            
        }
        
        else if priority == "p4"{
            
            topLabels.text = "Student"
            overAllRefName()
            
        }
        
        else if priority == "p2" {
            tapBarView.backgroundColor = UIColor(named: "Teaching Staff" )
            plusView.backgroundColor = UIColor(named: "messagecolor")
            topLabels.text = "Hod"
            plusView.isHidden = false
            overAllRefName()
        }
        
        else if priority == "p7" {
            tapBarView.backgroundColor = UIColor(named: "univercityColorCod" )
            plusView.backgroundColor = UIColor(named: "messagecolor")
            topLabels.text = "University Head"
            plusView.isHidden = false
            overAllRefName()
        }
        
        else if priority == "p5"{
            
            
            topLabels.text = "Father"
            overAllRefName()
            
            
            
        }
        
        else if priority == "p3"{
            tapBarView.backgroundColor = UIColor(named: "Teaching Staff" )
            plusView.backgroundColor = UIColor(named: "messagecolor")
            topLabels.text = "Teacher"
            plusView.isHidden = false
            overAllRefName()
        }
        
        
        else if priority == "p6"{
            tapBarView.backgroundColor = UIColor(named: "Teaching Staff" )
            topLabels.text = "Non Teaching"
            plusView.isHidden = true
            imageCountView.isHidden = true
            collegeCountView.isHidden = true
            departmetCountView.isHidden = true
            
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
        
        
        else if priority == "p6"{
            
            
            view.backgroundColor = UIColor(named: "Teaching Staff")
            
            reusee.menuImg.image = UIImage(named: "HodImage")
            
        }
        
        else if priority == "p7"{
            
            
            view.backgroundColor = UIColor(named: "univercityColorCod")
            
            reusee.menuImg.image = UIImage(named: "UnivercityHead")
            
        }
        
        
        swipeMenuHeight.constant = 150
        reusee.call_back = { [self]
            (val) in
            
            
            self.swipeMenuHeight.constant =  reusee.callid
            
            print("SenderFacultyViewController",reusee.callid)
            
            
        }
        
        
        let rownib = UINib(nibName: identifers, bundle: nil)
        imageTableView.register(rownib, forCellReuseIdentifier: identifers)
        
        noDataLabel.isHidden = true
        noDataTextView.isHidden = true
        
        let plusAddViews = UITapGestureRecognizer(target: self, action: #selector(PlusVc))
        plusView.addGestureRecognizer(plusAddViews)
        
        
        // tap Bar UiTapGuster.
        
        
        let Serach = UITapGestureRecognizer(target: self, action: #selector(Searchfield))
        SearchView.addGestureRecognizer(Serach)
        
        
        
        let loginRediectGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        redirectLoginView.addGestureRecognizer(loginRediectGesture)
        
        
        
        let changeRolesGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        changeRolesView.addGestureRecognizer(changeRolesGesture)
        
        
        let topname = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        topNameview.addGestureRecognizer(topname)
        
        
        
        
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
    
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        
        if imageSegmentName.selectedSegmentIndex == 0{
            
            let filtered_list : [SenderDepartmentImageDataDetails] = cloneList
            
            if !searchText.isEmpty{
                let search = searchText.lowercased()
                
                departmentRef = filtered_list.filter {
                    
                    ($0.description?.lowercased().contains(search) ?? false) ||
                    ($0.filetype?.lowercased().contains(search) ?? false) ||
                    ($0.sentbyname?.lowercased().contains(search) ?? false) ||
                    ($0.title?.lowercased().contains(search) ?? false) ||
                    ($0.createdontime?.lowercased().contains(search) ?? false) ||
                    ($0.createdondate?.lowercased().contains(search) ?? false)
                    
                }
            }else{
                departmentRef = filtered_list
            }
            
        }
        imageTableView.reloadData()
        
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
    
    @IBAction func PlusVc() {
        
        
        for i in addapiRef{
            if priority == "p3" || priority == "p2" {
                let vc = SenderImagePdfPlusNextPageViewController(nibName: nil, bundle: nil)
                vc.backGroungImageUrl = i.background_image
                vc.SmallImageUrl = i.add_image
                vc.addWebUrl = i.add_url
                vc.resiveMenuId =  imagePdfId
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true , completion: nil)
                
            }
            
            else if priority == "p7" {
                let vc = SenderImagePdfPlusNextPageViewController(nibName: nil, bundle: nil)
                vc.backGroungImageUrl = i.background_image
                vc.SmallImageUrl = i.add_image
                vc.addWebUrl = i.add_url
                vc.resiveMenuId =  imagePdfId
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true , completion: nil)
                
            }
            
            
            else{
                
                let vc = SenderImagePdfPlusNextPageViewController(nibName: nil, bundle: nil)
                vc.backGroungImageUrl = i.background_image
                vc.SmallImageUrl = i.add_image
                vc.addWebUrl = i.add_url
                vc.resiveMenuId =  imagePdfId
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.view.backgroundColor = UIColor(named: "Principal" )
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true , completion: nil)
                
                
            }
        }
        
    }
    
    
    
    
    @IBAction func imageSegment(_ sender: Any) {
        
        if is_read_enabled == "1"{
            
            
            if imageSegmentName.selectedSegmentIndex == 0 {
                print("ok")
                
                segmentType = "1"
                selectedCell = IndexPath()
                imageTableView.isScrollEnabled = false
                departRefName()
                
            }
            
            else if imageSegmentName.selectedSegmentIndex == 1{
                
                segmentType = "2"
                selectedCell = IndexPath()
                imageTableView.isScrollEnabled = false
                collegeRefName()
                
                
                
            }
            
            
            
        }else{
            
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if imageSegmentName.selectedSegmentIndex == 0 {
            return departmentRef.count
        }
        else if imageSegmentName.selectedSegmentIndex == 1{
            
            return collegeRef.count
            
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifers, for: indexPath) as!
        
        SenderImagePdfTableViewCell
        
        
        if let selectedCell = selectedCell, selectedCell == indexPath {
            
            cell.sendByDefaultLabel.isHidden = false
            cell.sendByCellLabel.isHidden = false
            cell.imageCellDescripitionLabel.isHidden = false
            cell.upArrowssImages.image = UIImage(named: "up")
            cell.sndByView.isHidden = false
            
        }
        
        else{
            
            
            cell.sendByDefaultLabel.isHidden = true
            cell.sendByCellLabel.isHidden = true
            cell.imageCellDescripitionLabel.isHidden = true
            cell.sndByView.isHidden = true
            cell.upArrowssImages.image = UIImage(named: "down")
            
        }
        
        
        
        if imageSegmentName.selectedSegmentIndex == 0 {
            
            let image : SenderDepartmentImageDataDetails = departmentRef[indexPath.row]
            
            
            
            if image.newfilepath == [""]{
                
                
                cell.viewTap.isHidden = true
                
                
            }
            
            else{
                
                
                cell.viewTap.isHidden = false
                
            }
            
            if image.isappread == "1"{
                
                cell.redDotImageView.isHidden =  true
                
                
            }
            
            else {
                
                cell.redDotImageView.isHidden = false
            }
            
            
            cell.imageCellTimeLabel.text = image.createdontime
            cell.imageCellDateLabel.text = image.createdondate
            
            cell.imageCellDescripitionLabel.text = image.description
            cell.sendByCellLabel.text = image.sentbyname
            cell.imageCellTitelLabel.text = image.title?.capitalized
            
            if image.newfilepath == [""] || image.newfilepath == ["[]"]{
                
                print("vfdscds")
                
                cell.viewTap.isHidden = true
            }
            
            
            else{
                
                
                print("12344")
                
                cell.viewTap.isHidden = false
            }
            
            
            if image.file_path == "" {
                
                
                
                cell.viewTap.isHidden = true
                
            }
            
            else {
                
                cell.viewTap.isHidden = false
                let parsed = image.file_path?.replacingOccurrences(of: "https://college-app-files.s3.amazonaws.com/", with: "")
                
                
                let s = parsed ?? ""
                let start = s.endIndex
                let end = s.index(s.startIndex, offsetBy: 13)
                let substring = s[end..<start] // www.stackoverflow
                
                let strrr = String(substring)
                
                
            }
            
            let  plusoneCount  = image.newfilepath?.count ?? 0-1
            let stringconvert = String(plusoneCount)
            cell.plusoneLabel.text = "+" + stringconvert
            
            
            if image.newfilepath?.count == 1{
                
                cell.countImageView.isHidden = true
                let  play = viewClickGesture(target: self, action: #selector(connected))
                
                play.img_urls = image.newfilepath ?? []
                play.imageFileType = image.filetype
                for i in image.newfilepath ?? []{
                    play.img_url =  i
                }
                
                cell.viewTap.addGestureRecognizer(play)
                
                
                
            }
            
            
            
            
            
            else{
                
                
                
                
                cell.countImageView.isHidden = false
                
                
                
                
                
                let  play = SenderImageGesturess(target: self, action: #selector(connected))
                
                play.imageFileType = image.filetype
                play.img_urls = image.newfilepath ?? []
                for i in image.newfilepath ?? []{
                    play.img_url =  i
                }
                
                cell.viewTap.addGestureRecognizer(play)
                
                
                
                let  viewCount = SenderImageGesturess(target: self, action: #selector(connected))
                
                viewCount.imageFileType = image.filetype
                viewCount.img_urls = image.newfilepath ?? []
                for i in image.newfilepath ?? []{
                    viewCount.img_url =  i
                }
                
                cell.countImageView.addGestureRecognizer(viewCount)
                
                
                
            }
            
            
            
            
            
            
            return cell
        }
        
        
        
        else if imageSegmentName.selectedSegmentIndex == 1 {
            
            
            let images : SenderDepartmentImageDataDetails = collegeRef[indexPath.row]
            
            
            
            if images.newfilepath == [""]{
                
                
                cell.viewTap.isHidden = true
                
                
            }
            
            else{
                
                
                cell.viewTap.isHidden = false
                
            }
            
            if images.isappread == "1"{
                
                cell.redDotImageView.isHidden =  true
                
                
            }
            
            else {
                
                cell.redDotImageView.isHidden = false
            }
            
            cell.imageCellTimeLabel.text = images.createdontime
            cell.imageCellDateLabel.text = images.createdondate
            
            cell.imageCellDescripitionLabel.text = images.description
            cell.sendByCellLabel.text = images.sentbyname
            cell.imageCellTitelLabel.text = images.title?.capitalized
            
            let  plusoneCount  = images.newfilepath?.count ?? 0-1
            let stringconvert = String(plusoneCount)
            cell.plusoneLabel.text = "+" + stringconvert
            
            
            if images.newfilepath == [""] || images.newfilepath == ["[]"]{
                
                print("vfdscds")
                
                cell.viewTap.isHidden = true
            }
            
            
            else{
                
                
                print("12344")
                
                cell.viewTap.isHidden = false
            }
            
            let parsed = images.file_path?.replacingOccurrences(of: "https://college-app-files.s3.amazonaws.com/", with: "")
            
            
            //
            let cutss = parsed?.suffix(43) ?? ""
            //
            let strss = String(cutss)
            
            
            if images.isappread == "1"{
                
                cell.redDotImageView.isHidden =  true
                
            }
            
            else {
                
                cell.redDotImageView.isHidden = false
            }
            
            
            if images.newfilepath?.count == 1{
                cell.countImageView.isHidden = true
                
                let  play = SenderImageGesturess(target: self, action: #selector(connected))
                
                play.img_urls = images.newfilepath ?? []
                play.imageFileType = images.filetype
                for i in images.newfilepath ?? []{
                    play.img_url =  i
                }
                
                cell.viewTap.addGestureRecognizer(play)
                
                
            }
            
            
            
            
            else{
                
                
                
                
                cell.countImageView.isHidden = false
                
                
                
                let  play = SenderImageGesturess(target: self, action: #selector(connected))
                
                play.imageFileType = images.filetype
                play.img_urls = images.newfilepath ?? []
                for i in images.newfilepath  ?? []{
                    play.img_url =  i
                }
                
                cell.viewTap.addGestureRecognizer(play)
                
                
                
                
                
                let  countView = SenderImageGesturess(target: self, action: #selector(connected))
                
                countView.imageFileType = images.filetype
                countView.img_urls = images.newfilepath ?? []
                for i in images.newfilepath ?? []{
                    countView.img_url =  i
                }
                
                cell.countImageView.addGestureRecognizer(countView)
                
                
            }
            
            
        }
        
        return cell
    }
    
    
    @IBAction func connected( gesture : SenderImageGesturess) {
        
        if imageSegmentName.selectedSegmentIndex == 0{
            
            
            if gesture.img_urls.count == 1 {
                
                
                let vc = ImageDownloadViewController(nibName: nil, bundle: nil)
                print("view")
                
                
                vc.fileType = gesture.imageFileType
                
                vc.imgfilePath = gesture.img_url
                print("gesture.img_url",gesture.img_url.count)
                
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true, completion: nil)
                
                
                
                
            }
            
            
            else{
                
                
                
                
                let vc  = MoreImageViewController(nibName: nil, bundle: nil)
                
                vc.imageFile = gesture.img_urls
                vc.fileType = gesture.imageFileType
                vc.PreviousAddId = PreviousAddId
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.modalPresentationStyle = .fullScreen
                
                present(vc, animated: true,completion: nil)
                
                
            }
            
            
        }
        
        
        
        
        else if imageSegmentName.selectedSegmentIndex == 1 {
            
            
            if gesture.img_urls.count == 1 {
                
                
                
                
                let vc = ImageDownloadViewController(nibName: nil, bundle: nil)
                print("view")
                
                
                vc.fileType = gesture.imageFileType
                
                vc.imgfilePath = gesture.img_url
                print("gesture.img_url",gesture.img_url.count)
                
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true, completion: nil)
                
                
                
                
                
            }
            
            
            else{
                
                
                
                
                let vc  = MoreImageViewController(nibName: nil, bundle: nil)
                
                vc.imageFile = gesture.img_urls
                vc.fileType = gesture.imageFileType
                vc.PreviousAddId = PreviousAddId
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                
                vc.modalPresentationStyle = .fullScreen
                
                present(vc, animated: true,completion: nil)
                
                
                
            }
            
            
            
            
        }
        
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifers, for: indexPath) as!
        
        SenderImagePdfTableViewCell
        
        
        if imageSegmentName.selectedSegmentIndex == 0{
            
            var image : SenderDepartmentImageDataDetails = departmentRef[indexPath.row]
            if let selectedCells = selectedCell, selectedCells == indexPath{
                
                
                selectedCell = nil
                
            }
            
            else{
                
                
                
                selectedCell = indexPath
                
                
                if image.isappread == "0"{
                    
                    apread(gesture : image.detailsid ?? "")
                    
                    image.isappread = "1"
                    cell.redDotImageView.isHidden = true
                    
                }
                
            }
            
            
        }
        
        
        else if  imageSegmentName.selectedSegmentIndex == 1{
            
            var images : SenderDepartmentImageDataDetails = collegeRef[indexPath.row]
            if let selectedCells = selectedCell, selectedCells == indexPath {
                
                selectedCell = nil
                
            }
            
            else{
                
                selectedCell = indexPath
                
                
                
                if images.isappread == "0"{
                    
                    apread(gesture : images.detailsid ?? "")
                    
                    images.isappread = "1"
                    cell.redDotImageView.isHidden = true
                    
                }
            }
            
            
            
        }
        
        
        imageTableView.beginUpdates()
        imageTableView.endUpdates()
        imageTableView.reloadData()
        
        
        
        
    }
    
    
    func apread(gesture : String){
        
        //        for i in collegeRef{
        
        let readApiStatus  = AppReadStatusModal()
        
        readApiStatus.msgtype = "circular"
        readApiStatus.priority = priority
        readApiStatus.userid = memberId
        readApiStatus.detailsid = gesture
        print("sertt",gesture)
        
        let commuS = readApiStatus.toJSONString()
        
        ApiReadStatusRequest .call_request(param: commuS!){ [self]
            
            (res) in
            
            
            let com : ReadStausApiResponce =
            Mapper<ReadStausApiResponce>().map(JSONString: res)!
            
            
            
            imageTableView.delegate = self
            imageTableView.dataSource = self
            imageTableView.reloadData()
            
            
            
        }
        
        //        }
        
        
    }
    
    func departRefName() {
        
        var depart = SenderDeparmentImageModal()
        
        depart.userid = memberId
        depart.appid  = "2"
        depart.priority = priority
        depart.type    = "departmentcircular"
        
        APiCallManager.shared.callApi(url: APIEndpoints.GetCircularListByType, httpMethod: .post, queryParam: nil, requestBody: depart) { [weak self] (result:Result<SenderDepartmentImageResponce,Error>)  in
            guard let self = self else{return}
            switch result{
            case .success(let departResp):
                if departResp.Status == 1 {
                    
                    print("order data",departResp)
                    
                    cloneList = departResp.data ?? []
                    departmentRef = departResp.data ?? []
                    
                    noDataLabel.isHidden = true
                    noDataTextView.isHidden = true
                    
                    imageTableView.isScrollEnabled = true
                    imageTableView.delegate = self
                    imageTableView.dataSource = self
                    imageTableView.reloadData()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3 ){ [self] in
                        
                        self.loadingCustom.stopAnimating()
                        
                        self.loadingCustom.isHidden  = true
                        
                    }
                    
                    
                    
                }else{
                    
                    noDataLabel.isHidden = false
                    noDataTextView.isHidden = false
                    noDataLabel.text = departResp.Message
                    imageTableView.delegate = self
                    imageTableView.dataSource = self
                    imageTableView.reloadData()
                    
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
    
    
    func collegeRefName() {
        
        
        
        var college = SenderDeparmentImageModal()
        
        college.userid   =  memberId
        college.appid    = "2"
        college.priority = priority
        college.type     =  "collegecircular"
        
        
        APiCallManager.shared.callApi(url: APIEndpoints.GetCircularListByType, httpMethod: .post, queryParam: nil, requestBody: college) { [weak self] (result:Result<SenderDepartmentImageResponce,Error>)  in
            guard let self = self else{return}
            switch result{
            case .success(let collegeResp):
                
                if collegeResp.Status == 1 {
                    
                    print("order data",collegeResp)
                    
                    
                    collegeRef = collegeResp.data ?? []
                    
                    noDataLabel.isHidden = true
                    noDataTextView.isHidden = true
                    
                    imageTableView.isScrollEnabled = true
                    imageTableView.delegate = self
                    imageTableView.dataSource = self
                    imageTableView.reloadData()
                    
                }else{
                    
                    
                    noDataLabel.isHidden = false
                    noDataTextView.isHidden = false
                    noDataLabel.text = collegeResp.Message
                    imageTableView.delegate = self
                    imageTableView.dataSource = self
                    imageTableView.reloadData()
                }
                
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
        
        
    }
    
    
    
    
    func overAllRefName() {
        
        var overall = overAllModal()
        
        overall.userid   =  memberId
        overall.menuid       = "6"
        overall.collegeid    =  collegId
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
                    for i in overAllRef {
                        departmentCountLabel.text = i.departmentcircular
                        collegeCountLabel.text = i.collegecircular
                        
                        if (i.departmentcircular == "0") && (i.collegecircular == "0"){
                            
                            departmetCountView.isHidden = true
                            collegeCountView.isHidden = true
                            imageCountView.isHidden = true
                            
                            
                        }else if i.departmentcircular == "0"{
                            
                            departmetCountView.isHidden = true
                            collegeCountView.isHidden = false
                            imageCountView.isHidden = false
                            
                        }else if i.collegecircular == "0"{
                            
                            departmetCountView.isHidden = false
                            collegeCountView.isHidden = true
                            imageCountView.isHidden = false
                            
                        }else {
                            departmetCountView.isHidden = false
                            collegeCountView.isHidden = false
                            imageCountView.isHidden = false
                        }
                    }
                    
                    let a =  Int(collegeCountLabel.text!)
                    let b = Int(departmentCountLabel.text!)
                    let c = a! + b!
                    imageTopCountLabel.text = String(c)
                    imageTableView.delegate = self
                    imageTableView.dataSource = self
                    imageTableView.reloadData()
                    
                }else{
                    departmetCountView.isHidden = true
                    collegeCountView.isHidden = true
                    imageCountView.isHidden = true
                }
            case .failure(let error):
                print("Error: \(error)")
                departmetCountView.isHidden = true
                collegeCountView.isHidden = true
                imageCountView.isHidden = true
            }
        }
        
    }
    
    
    
    func addApi(){
        
        
        var add = AddApiModal()
        
        let defaults = UserDefaults.standard
        var deviceToken = defaults.string(forKey:DefaultsKeys.DeviceToken )
        add.device_token = deviceToken
        print("EventDefaultsKeys.DeviceToken",deviceToken)
        add.member_id =  memberId
        add.mobile_no = mobileNumber
        add.priority = priority
        add.college_id = collegId
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
    
    
    @IBAction func adLoad( gesture : SenderImageAdd){
        
        
        let vc = SenderImageAddViewController(nibName: nil, bundle: nil)
        
        vc.AddWebUrl = gesture.url
        
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true,completion: nil)
        
        
        
    }
    
    
    
    // This Part  is  swipe view.
    
    
    
    
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            KRProgressHUD.dismiss()
            
        }
        
        if segmentType == "1"{
            
            departRefName()
            
        }
        
        else{
            
            
            collegeRefName()
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
class SenderImageGesturess : UITapGestureRecognizer {
    
    var url : String!
    var img_url : String!
    var imageFileType : String!
    var img_urls : [String] = []
}


class SenderImageAdd : UITapGestureRecognizer{
    
    
    var url : String!
    
}

