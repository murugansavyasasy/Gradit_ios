//
//  ViewController.swift
//  Vs_GradItCollege
//
//  Created by APPLE on 27/10/22.
//

import UIKit
import ObjectMapper
import SystemConfiguration

@available(iOS 16.0, *)
class ViewController: UIViewController {
    
    
    @IBOutlet weak var gifimageView: UIImageView!
    var versionCheck : [VersionCheckData] = []
    
    
    
    
    
    var termsCondition : String!
    
    
    
    var countryId : String!
    
    
    
    var mobileNum : String!
    
    var data                            : [datalogin]!
    
    
    
    var LIVE_ITUNES =
    
    "https://apps.apple.com/us/app/gradit/id1574188445"
    
    
    
    var isversionupdateavailable   :  Int!
    
    var isforceupdaterequired :  Int!
    
    
    
    
    var versionalertcontent   :  String!
    
    var versionalerttitle :  String!
    
    
    var princiData : [String] = []
    
   var myArray = [[String:AnyObject]]()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
//        fatalError("test Crash")
        
        overrideUserInterfaceStyle = .light
        
        // Do any additional setup after loading the view.
        
        
        
        var deviceId = UIDevice.current.identifierForVendor?.uuidString
        
        let defaults = UserDefaults.standard
        
        print("DeviceTo1111kenDeviceToken",deviceId)
        
        defaults.set(deviceId, forKey: DefaultsKeys.DeviceToken)

        
        print("DeviceTokenDeviceToken",deviceId)
        print("DefaultsKeys.DeviceToken",DefaultsKeys.DeviceToken)
        
        
//        let button = UIButton(type: .roundedRect)
//        button.frame = CGRect(x: 20, y: 50, width: 100, height: 30)
//        button.setTitle("Test Crash", for: [])
//        button.addTarget(self, action: #selector(self.crashButtonTapped(_:)), for: .touchUpInside)
//        view.addSubview(button)
//    
        
        print("viewDidload")
        VersionCheck ()
       
         
        
        
        
        
        
//        showAlert()
        
        
        
        
        
        
        
        let nc = NotificationCenter.default
        
        nc.addObserver(self,selector: #selector(ViewController.callNotification), name: NSNotification.Name(rawValue: "PushNotification"), object:nil)
        
        
        
    }
    
    
//    @IBAction func crashButtonTapped(_ sender: AnyObject) {
//          let numbers = [0]
//          let _ = numbers[1]
//      }
    
    
    
    
    
    
    @objc func callNotification(notification:Notification) -> Void {
        
        // self.showCustomNotificationVC()
        
    }
    
    
    func loginDetails() {
        
        let defaults = UserDefaults.standard
        
        mobileNum      = defaults.string(forKey: DefaultsKeys.mobileNumber)
        let password   = defaults.string(forKey: DefaultsKeys.Password)
        termsCondition = defaults.string(forKey: DefaultsKeys.TermsAndCondition)
        countryId      = defaults.string(forKey: DefaultsKeys.CountryId)
        
        // Terms check
        guard termsCondition != nil else {
            presentVC(TermsViewController())
            return
        }
        
        // Country check
        guard countryId != nil else {
            print("CountryListViewController")
            presentVC(CountryListViewController())
            return
        }
        
        // Mobile check
        guard mobileNum != nil else {
            print("LoginViewController")
            presentVC(LoginNewViewController())
            return
        }
        
        let isUserSelectCountry = PreferencesUtil.checkPrefs(key: Constant.keyId)
        
        guard isUserSelectCountry else {
            print("LoginViewController")
            presentVC(LoginNewViewController())
            return
        }
        
        var login = LoginModal()
        login.mobilenumber = mobileNum
        login.Password     = password
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.LoginFromApp,
            httpMethod: .post,
            queryParam: nil,
            requestBody: login
        ) { [weak self] (result: Result<LoginResponse, Error>) in
            
            guard let self = self else { return }
            
            switch result {
                
            case .success(let success):
                
                if success.Status == 1 {
                    
                    let loginData = success.data ?? []
                    
                    do {
                        let encoded = try JSONEncoder().encode(loginData)
                        UserDefaults.standard.set(encoded, forKey: DefaultsKeys.loginDataList)
                    }catch{
                        print("Encoding profiles failed:", error)
                    }
                    
                    if loginData.count == 1 {
                        let vc = HomeScreenViewController(nibName: nil, bundle: nil)
                        for i in loginData {
                            
                            defaults.set(i.colglogo, forKey: DefaultsKeys.colglogo)
                            defaults.set(i.loginas, forKey: DefaultsKeys.loginAsType)
                            defaults.set(i.membername, forKey: DefaultsKeys.memberName)
                            defaults.set(i.colgname, forKey: DefaultsKeys.colgName)
                            defaults.set(i.colgid, forKey: DefaultsKeys.collegeid)
                            defaults.set(i.memberid, forKey: DefaultsKeys.memberid)
                            defaults.set(i.priority, forKey: DefaultsKeys.priority)
                            defaults.set(i.colgcity, forKey:DefaultsKeys.colgcity)
                            defaults.set(i.divid ,   forKey:DefaultsKeys.divid)
                            defaults.set(i.divname, forKey: DefaultsKeys.divname)
                            defaults.set(i.courseid,forKey: DefaultsKeys.courseid)
                            defaults.set(i.coursename,forKey:DefaultsKeys.coursename)
                            defaults.set(i.deptid,forKey: DefaultsKeys.deptid)
                            defaults.set(i.deptname,forKey: DefaultsKeys.deptname)
                            defaults.set(i.yearid,forKey: DefaultsKeys.yearid)
                            defaults.set(i.yearname,forKey: DefaultsKeys.yearname)
                            defaults.set(i.sectionid,forKey: DefaultsKeys.sectionid)
                            defaults.set(i.sectionname,forKey: DefaultsKeys.sectionname)
                            defaults.set(i.semesterid,forKey: DefaultsKeys.semesterid)
                            defaults.set(i.semestername,forKey: DefaultsKeys.semestername)
                            defaults.set(i.is_parent_target_enabled,forKey: DefaultsKeys.is_parent_target_enabled)
                            defaults.set(i.is_allow_to_make_call,forKey: DefaultsKeys.is_allow_to_make_call)
                        }
                        
                        vc.modalPresentationStyle = .fullScreen
                        present(vc, animated: true,completion: nil)
                    }else{
                        
                        let vc = PriorityViewController(nibName: nil, bundle: nil)
                        vc.modalPresentationStyle = .fullScreen
                        present(vc, animated: true,completion: nil)
                        
                    }
                } else {
                    
                    presentVC(LoginNewViewController())
                }
                
            case .failure(let error):
                print("Error:", error.localizedDescription)
                presentVC(LoginNewViewController())
            }
        }
    }

    private func presentVC(_ vc: UIViewController) {
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func VersionCheck () {
        let defaults = UserDefaults.standard
        
        //var versionId = defaults.integer(forKey: DefaultsKeys.versionID)
        
        let param : [String : Any] = [
            "versionID" : DefaultsKeys.versionID,
            "device_type" : "iphone"
        ]
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.versionCheck,
            httpMethod: .get,
            queryParam: param,
            requestBody: nil
        ) { [weak self] (result: Result<VersionCheckResponse,Error>) in
                
            guard let self = self else {return}
            
            switch result {
            case .success(let success):
                
                versionCheck = success.data ?? []
                
                defaults.set(versionCheck.first?.videojson, forKey: DefaultsKeys.vimeoAccessToken)
                
                defaults.set(versionCheck.first?.feepaymentlink, forKey: DefaultsKeys.feepaymentlink)
                
                defaults.set(versionCheck.first?.videosizelimit, forKey: DefaultsKeys.videosizelimit)
                
                defaults.set(versionCheck.first?.videosizealert, forKey: DefaultsKeys.videosizealert)
                
                defaults.set(versionCheck.first?.isforceupdaterequired, forKey: DefaultsKeys.isforceupdaterequired)
                
                defaults.set(versionCheck.first?.isversionupdateavailable, forKey: DefaultsKeys.isversionupdateavailable)
                
                defaults.set(versionCheck.first?.versionalerttitle, forKey: DefaultsKeys.versionalerttitle)
                
                defaults.set(versionCheck.first?.versionalertcontent, forKey: DefaultsKeys.versionalertcontent)
                
                isversionupdateavailable = defaults.integer(forKey: DefaultsKeys.isversionupdateavailable)
                
                isforceupdaterequired = defaults.integer(forKey: DefaultsKeys.isforceupdaterequired)
                
                versionalertcontent  = defaults.string(forKey: DefaultsKeys.versionalertcontent)
                
                versionalerttitle = defaults.string(forKey: DefaultsKeys.versionalerttitle)
                
                if isversionupdateavailable == 1 {
                    
                    if isforceupdaterequired == 1{
                        
                        AlertHelper.showOKAlert(
                            on: self,
                            title: "Needs to Update",
                            message: "New updates are available. Would you like to update them now?",
                            okTitle: "Update"
                        ) {
                            self.callAppStore()
                        }
                    }else {
                        
                        AlertHelper.showOKCancelAlert(
                            on: self,
                            title: "Needs to Update",
                            message: "New updates are available. Would you like to update them now?",
                            okTitle: "Update",
                            cancelTitle: "Not now") {
                                self.callAppStore()
                            } cancelAction: {
                                self.loginDetails()
                            }
                    }
                    
                }else {
                    
                    loginDetails()
                }
                
            case .failure(let failure):
                
                print("Error",failure.localizedDescription)
            }
            
            }
    }
    
    
    
    
    
    func callAppStore (){
        print("callAppStore")
        let myUrl = LIVE_ITUNES
        if let url = URL(string: "\(myUrl)"), !url.absoluteString.isEmpty {
            
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    
        
        // or outside scope use this
        
        guard let url = URL(string: "\(myUrl)"), !url.absoluteString.isEmpty else {
            
            return
            
        }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        
    }
    
    
    
    
    
    
   
}
