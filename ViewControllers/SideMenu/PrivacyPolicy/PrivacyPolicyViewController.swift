//
//  PrivacyPolicyViewController.swift
//  Vs_GradIt
//
//  Created by APPLE on 27/09/22.
//

import UIKit
import WebKit

class PrivacyPolicyViewController: UIViewController {

    
    @IBOutlet weak var backView: UIView!
    
    
    @IBOutlet weak var webkit: WKWebView!
    
    
    var privacyUrl : String!
    override func viewDidLoad() {
        super.viewDidLoad()

        overrideUserInterfaceStyle = .light
        
        let defaults = UserDefaults.standard
//        privacyUrl = defaults.string(forKey: DefaultsKeys.privarypolicy)
        
        webViewLoad()
        
        let backGesture = UITapGestureRecognizer(target: self, action: #selector(backVc))
        backView.addGestureRecognizer(backGesture)
        
    }


    
    func webViewLoad() {
        let url = URL (string: "https://www.thegradit.com/privacyandpolicy.html")
        let requestObj = URLRequest(url: url!)
        webkit.load(requestObj)
    }
   
    
  @IBAction  func backVc() {
        dismiss(animated: true, completion: nil)
    }


}
