//
//  FaqViewController.swift
//  Vs_GradIt
//
//  Created by APPLE on 28/09/22.
//

import UIKit
import WebKit
import KRProgressHUD

class FaqViewController: UIViewController {

    
    
    @IBOutlet weak var backView: UIView!
    
    
    
    
    @IBOutlet weak var webView: WKWebView!
    
    var faqUrl : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        overrideUserInterfaceStyle = .light
        let defaults = UserDefaults.standard
//        faqUrl = defaults.string(forKey: DefaultsKeys.faq)
        
        webViewLoad()
        let backGesture = UITapGestureRecognizer(target: self, action: #selector(backVc))
        backView.addGestureRecognizer(backGesture)
        // Do any additional setup after loading the view.
    }

    
    func webViewLoad() {
        
        KRProgressHUD.show()
        let url = URL (string: "https://gradit.voicesnap.com/Home/FAQ")
        let requestObj = URLRequest(url: url!)
        webView.load(requestObj)
        DispatchQueue.main.asyncAfter(deadline: .now()+2.3) {
            KRProgressHUD.dismiss()
        }
    }
   

    
  @IBAction  func backVc() {
        dismiss(animated: true, completion: nil)
    }


}
