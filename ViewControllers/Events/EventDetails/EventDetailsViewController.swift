//
//  EventDetailsViewController.swift
//  EventsGradit
//
//  Created by MACBOOKPRO on 29/10/22.
//

import UIKit
import ObjectMapper
import KRProgressHUD


@available(iOS 16.0, *)
class EventDetailsViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var tapBarView: UIViewX!
    @IBOutlet weak var sideMenuView: UIView!
    @IBOutlet weak var logoutView: UIView!
    @IBOutlet weak var changeRolesView: UIView!
    @IBOutlet weak var changePasswordView: UIView!
    @IBOutlet weak var termsAndConditionView: UIView!
    @IBOutlet weak var privacyPolicyView: UIView!
    @IBOutlet weak var helpView: UIView!
    @IBOutlet weak var faqView: UIView!
    @IBOutlet weak var smallImg: UIImageView!
    @IBOutlet weak var bigImg: UIImageView!
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var venueLabel: UILabel!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var noImageTextView: UIView!
    @IBOutlet weak var noImagLabel: UILabel!
    
    var identifier = "MenuEventCollectionViewCell"
    
    var venuestr : String!
    var topistr  : String!
    var datestr  : String!
    var timestr  : String!
    var bodystr  : String!
    var priority : String!
    var filePath : [String] = []
    var addapiRef : [AddDataDeatils] = []
    var collegeid : String!
    var userid    : String!
    var MobileNumber : String!
    var previousAdId : Int!
    
    @IBOutlet weak var refreshView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        sideMenuView.isHidden = true
        
        
        topicLabel.text = topistr
        venueLabel.text = venuestr
        dateLabel.text = datestr
        timeLabel.text = timestr
        bodyLabel.text = bodystr
        
        let defaults = UserDefaults.standard
        collegeid = defaults.string(forKey: DefaultsKeys.collegeid)
        userid = defaults.string(forKey: DefaultsKeys.memberid)
        priority = defaults.string(forKey: DefaultsKeys.priority)
        MobileNumber = defaults.string(forKey: DefaultsKeys.mobileNumber)
        
        let rowNib = UINib(nibName: identifier, bundle: nil)
        imageCollectionView.register(rowNib, forCellWithReuseIdentifier: identifier)
        
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        
        noImageTextView.isHidden = true
        noImagLabel.isHidden = true
        
        if filePath.count == 0{
            noImageTextView.isHidden = false
            noImagLabel.isHidden = false
        }
        
        addApi()
        let faqGesture = UITapGestureRecognizer(target: self, action: #selector(faqRedirect))
        faqView.addGestureRecognizer(faqGesture)
        
        let logoutGesture = UITapGestureRecognizer(target: self, action: #selector(logoutPressed))
        logoutView.addGestureRecognizer(logoutGesture)
        
        let helpGesture = UITapGestureRecognizer(target: self, action: #selector(helpRedirect))
        helpView.addGestureRecognizer(helpGesture)
     
        let privacyPolicyGesture = UITapGestureRecognizer(target: self, action: #selector(privacyPolicyRedirect))
        privacyPolicyView.addGestureRecognizer(privacyPolicyGesture)
        
        let termsAndConditionGesture = UITapGestureRecognizer(target: self, action: #selector(termsAndCondition))
        termsAndConditionView.addGestureRecognizer(termsAndConditionGesture)

        let chagePassword = UITapGestureRecognizer(target: self, action: #selector(changePassowrdVC))
        changePasswordView.addGestureRecognizer(chagePassword)
    }
    
    func addApi(){
        
        var add = AddApiModal()
        let defaults = UserDefaults.standard
        var deviceToken = defaults.string(forKey:DefaultsKeys.DeviceToken )
        add.device_token = deviceToken
        add.member_id = Int(userid)
        add.mobile_no = MobileNumber
        add.priority = priority
        add.college_id = Int(collegeid)
        add.previous_add_id = previousAdId
        
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

                    smallImg.setAdImage(
                        imageURL: ad?.add_image,
                        adURL: ad?.add_url,
                        placeholder: UIImage(named: "Default_Ad_small"),
                        from: self
                    )
                
                
            case .failure(let failure):
                print(failure.localizedDescription)
                
                bigImg.setAdImage(
                    imageURL: "",
                    adURL: "",
                    from: self
                )

                smallImg.setAdImage(
                    imageURL:"",
                    adURL: "",
                    placeholder: UIImage(named: "Default_Ad_small"),
                    from: self
                )
            }
        }
        
    }
     
    @IBAction func backbtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filePath.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! MenuEventCollectionViewCell
        cell.EventCellImageView.sd_setImage(with: URL(string: filePath[indexPath.row]), placeholderImage: UIImage(named: "placeHolder.png"))
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = EventImageViewController(nibName: nil, bundle: nil)
        vc.imgfilePath = filePath[indexPath.row]
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 3, height:100)
    }
    
    func getCurrentViewController() -> UIViewController? {
        
        if let rootController = UIApplication.shared.keyWindow?.rootViewController {
            var currentController: UIViewController! = rootController
            while( currentController.presentedViewController != nil ) {
                currentController = currentController.presentedViewController
            }
            return currentController
        }
        return nil
        
    }
    
    
    // Tab Bar Nagivation
    
    
    
    @IBAction func helpRedirect() {
        
        let vc = HelpViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        let currentController = self.getCurrentViewController()
        currentController?.present(vc, animated: true, completion: nil)
        
        
    }
    
    
    @IBAction func termsAndCondition() {
        
        let vc = MenuTermsViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        let currentController = self.getCurrentViewController()
        currentController?.present(vc, animated: true, completion: nil)
        
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
        print("faqRedirect")
        let vc = FaqViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        let currentController = self.getCurrentViewController()
        currentController?.present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func privacyPolicyRedirect() {
        
        let vc = PrivacyPolicyViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        let currentController = self.getCurrentViewController()
        currentController?.present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func changePassowrdVC(){
        
        let vc = ChangePasswordVC(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        let currentController = self.getCurrentViewController()
        currentController?.present(vc, animated: true, completion: nil)
        
    }
    
}

