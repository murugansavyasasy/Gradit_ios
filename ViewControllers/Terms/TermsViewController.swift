

import UIKit
import WebKit
import KRProgressHUD
import ObjectMapper

@available(iOS 16.0, *)
class TermsViewController: UIViewController {
    
    @IBOutlet weak var viewForEmbeddingWebView: UIView!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var acceptView: UIView!
    
    var versionCheck : [VersionCheckData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        KRProgressHUD.show()
        
        overrideUserInterfaceStyle = .light
        
        let myURL = URL(string: "https://gradit.voicesnap.com/Home/TermsAndConditions")
        let myRequest = URLRequest(url: myURL!)
        
        webView.load(myRequest)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+2.3) {
            KRProgressHUD.dismiss()
        }
        
        VersionCheck ()
        
        let  acceptConditions = UITapGestureRecognizer(target: self, action: #selector(acceptVc))
        acceptView.addGestureRecognizer(acceptConditions)
    }
    
    @IBAction  func acceptVc() {
        
        let vc = CountryListViewController(nibName: nil, bundle: nil)
        
        let term : String = "1"
        let userDefault = UserDefaults.standard
        userDefault.set(term, forKey: DefaultsKeys.TermsAndCondition)
        //        UserDefaults.standard.set(true, forKey: Constant.TermsAndConditionResponse)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    func VersionCheck () {
        let defaults = UserDefaults.standard
        let param : [String : Any] = [
            "versionID" : DefaultsKeys.versionID,
            "device_type" : "iphone"
        ]
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.versionCheck,
            httpMethod: .get,
            isBaseUrl: true,
            queryParam: param,
            requestBody: nil
        ) { [weak self] (result: Result<VersionCheckResponse,Error>) in
            
            guard let self = self else {return}
            
            switch result {
            case .success(let success):
                
                versionCheck = success.data ?? []
                
                let defaults = UserDefaults.standard
                
                defaults.set(versionCheck.first?.videojson, forKey: DefaultsKeys.vimeoAccessToken)
                
                defaults.set(versionCheck.first?.videosizelimit, forKey: DefaultsKeys.videosizelimit)
                
                defaults.set(versionCheck.first?.videosizealert, forKey: DefaultsKeys.videosizealert)
                
                
            case .failure(let failure):
                print("Error:", failure.localizedDescription)
            }
        }
    }
    
}








