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
        
        
        
        mobileNum = defaults.string(forKey: DefaultsKeys.mobileNumber)
        
        
        
        let PasswordText = defaults.string(forKey: DefaultsKeys.Password)
        
        
        
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [self] in
            
            let defaults = UserDefaults.standard
            
            mobileNum = defaults.string(forKey:DefaultsKeys.mobileNumber)
            
            termsCondition = defaults.string(forKey: DefaultsKeys.TermsAndCondition)
            
            countryId = defaults.string(forKey: DefaultsKeys.CountryId)
            
            
            
            
            
            print("mobileNum123",mobileNum)
            
            print("termsCondition",termsCondition)
            
            print("countryId",countryId)
            
            
            
            if termsCondition != nil {
                
                
                
                if countryId != nil {
                    
                    
                    
                    if mobileNum != nil {
                        
//                        print("mobileNumTrue")
                        
                        let is_user_Select_country = PreferencesUtil.checkPrefs(key: Constant.keyId)
                        
                        //
                        
                        if is_user_Select_country{
                            
                            
                            
                            
                            
//                            print("go to Home")
                            
                            
                            
                            
                            
                            let login = LoginModal ()
                            
                            
                            
                            login.mobilenumber = mobileNum
                            
                            
                            
                            login.Password     =  PasswordText
                           
                            
                            print("PasswordText",PasswordText)
                          
                            print("mobileNum123",mobileNum)
                         
                            let loginStr = login.toJSONString()
                            
                            
                            
                            loginRequest.call_request(param: loginStr!){ [self]
                                
                             
                                
                                (res) in
                                
                          
                                
                                let loginResponse : LoginResponse =
                                
                                
                                
                                Mapper<LoginResponse>().map(JSONString: res)!
                             
                                let vc = PriorityViewController(nibName: nil, bundle: nil)
                                
                                vc.modalPresentationStyle = .fullScreen
                                
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
                                        vc.loginStudent.append(i)
                                        
                                        
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
                            
                                
                                print("dfrdd",loginResponse.data)
                             
                                vc.loginData = loginResponse.data
                                
                                present(vc, animated: true,completion: nil)
                           
                            }
                      
                            
                        }else{
                            
                            
                            
                            let vc = LoginNewViewController(nibName: nil, bundle: nil)
                            
                            
                            
                            vc.modalPresentationStyle = .fullScreen
                            
                            
                            
                            self.present(vc, animated: true, completion: nil)
                            
                            
                            
                            print("LoginViewController")
                       
                            
                        }
                        
                        
                        
                    }else{
                        
                        
                        
                        let vc = LoginNewViewController(nibName: nil, bundle: nil)
                        
                        
                        
                        vc.modalPresentationStyle = .fullScreen
                        
                        
                        
                        self.present(vc, animated: true, completion: nil)
                        
                        
                        
                        print("LoginViewController")
                        
                        
                        
                    }
                    
                }else{
                    
                    
                    
                    let vc = CountryListViewController(nibName: nil, bundle: nil)
                    
                    //
                    
                    vc.modalPresentationStyle = .fullScreen
                    
                    
                    
                    self.present(vc, animated: true, completion: nil)
                    
                    
                    
                    print("CountryListViewController")
                    
                    
                    
                    
                    
                }
                
        
                
            }else{
                
                let vc = TermsViewController(nibName: nil, bundle: nil)
                
                //
                
                vc.modalPresentationStyle = .fullScreen
                
                
                
                self.present(vc, animated: true, completion: nil)
                
                
                
                print("TermsViewController")
                
            }
            
       
        }
        
        
        
    }
    
    
    
    
    
    
    
    
    
    func VersionCheck () {
        let defaults = UserDefaults.standard
        
        //var versionId = defaults.integer(forKey: DefaultsKeys.versionID)
        
        let param : [String : Any] =
        
        
        
        [
            
            
            
            
            
            
            
            "versionID" : DefaultsKeys.versionID,
            
            
            
            "device_type" : "iphone"
            
            
            
            
            
            
            
        ]
        
        
        
        
        
        
        
        print("param",param)
        
        
        
        VersionCheckRequest.call_request(param: param)  {
            
            
            
            
            
            
            
            [self] (res) in
            
            
            
            
            
            
            
            
            
            
            let VersionUpdate : VersionCheckResponce = Mapper<VersionCheckResponce>().map(JSONString: res)!
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            if VersionUpdate.Status == 1 {
                
                
                versionCheck = VersionUpdate.versionData
                
                
                
                
                
                for i in versionCheck {
                    
                    
               
                    
                    
                    defaults.set(i.videojson, forKey: DefaultsKeys.vimeoAccessToken)
                    
                    defaults.set(i.feepaymentlink, forKey: DefaultsKeys.feepaymentlink)
                    
//                    defaults.set(i., forKey: <#T##String#>)
                    
                    
                    
                    
                    
                    defaults.set(i.videosizelimit, forKey: DefaultsKeys.videosizelimit)
                    
                    
                    
                    
                    
                    
                    
                    defaults.set(i.videosizealert, forKey: DefaultsKeys.videosizealert)
                    
                    
                    
                    defaults.set(i.isforceupdaterequired, forKey: DefaultsKeys.isforceupdaterequired)
                    
                    defaults.set(i.isversionupdateavailable, forKey: DefaultsKeys.isversionupdateavailable)
                    
                    
                    defaults.set(i.versionalerttitle, forKey: DefaultsKeys.versionalerttitle)
                    
                    defaults.set(i.versionalertcontent, forKey: DefaultsKeys.versionalertcontent)
                    
                    
                    
                    
//                    print("paymentLink",)
                    
                    
                    
                    
                    
                    
                    print("DefaultsKeys.vimeoAccessToken",DefaultsKeys.vimeoAccessToken)
                    
                    
                    
                    print("DefaultsKeys.",i.videojson)
              
                    
                    isversionupdateavailable = defaults.integer(forKey: DefaultsKeys.isversionupdateavailable)
                    
                    
                    
                    isforceupdaterequired = defaults.integer(forKey: DefaultsKeys.isforceupdaterequired)
                    
                    versionalertcontent  = defaults.string(forKey: DefaultsKeys.versionalertcontent)
                    
                    
                    
                    versionalerttitle = defaults.string(forKey: DefaultsKeys.versionalerttitle)
                    
                    
      
                    
                    if(isversionupdateavailable == 1){
                        
                        
                        let alert = UIAlertController(title: versionalerttitle, message:versionalertcontent, preferredStyle: UIAlertController.Style.alert)
                        
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { [self] action in
                            
                            if(isversionupdateavailable == 1 && isforceupdaterequired == 1)
                                
                            {
                                
                                let alert = UIAlertController(title: "Needs to Update", message: "New updates are available. Would you like to update them now?", preferredStyle: UIAlertController.Style.alert)
                                
                                //
                                
                                alert.addAction(UIAlertAction(title: "Update", style: UIAlertAction.Style.default, handler: { action in self.callAppStore()}))
                                
                                
                                
                                DispatchQueue.main.async{
                                    
                                    self.present(alert, animated: true, completion: nil)
                                    
                                }
                                
                            }else  if(isversionupdateavailable == 1 && isforceupdaterequired == 0) {
                                
                                let alert = UIAlertController(title: "Needs to Update", message: "New updates are available. Would you like to update them now?", preferredStyle: UIAlertController.Style.alert)
                                
                                alert.addAction(UIAlertAction(title: "Not Now", style: UIAlertAction.Style.default, handler: { action in self.loginDetails()}))
                                
                                alert.addAction(UIAlertAction(title: "Update", style: UIAlertAction.Style.default, handler: { action in self.callAppStore()}))
                                
                                
                                
                                DispatchQueue.main.async{
                                    
                                    self.present(alert, animated: true, completion: nil)
                                    
                                }
                                
                            }
                            //
                            else
                            
                            {
                                
                                self.loginDetails()
                                
                            }
                       
                        }))
                        
                        DispatchQueue.main.async
                        
                        {
                            
                            self.present(alert, animated: true, completion: nil)
                            
                        }
                 
                    }else{
                        
                        print("LoginDetailElsePart")
                        
                        loginDetails()
                        
                        
                    }
            
                    print("VersionCheckSuccess")
                    
                    
                    
                }
                
                
                
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
