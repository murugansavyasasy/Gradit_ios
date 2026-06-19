//
//  MenuTermsViewController.swift
//  Vs_GradIt
//
//  Created by APPLE on 27/09/22.
//

import UIKit
import WebKit

class MenuTermsViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var backView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webViewLoad()
        overrideUserInterfaceStyle = .light
        
        
        let backGesture = UITapGestureRecognizer(target: self, action: #selector(backVc))
        backView.addGestureRecognizer(backGesture)
        
    }


    func webViewLoad() {
        let url = URL (string: "https://www.thegradit.com/termsandconditions.html")
        let requestObj = URLRequest(url: url!)
        webView.load(requestObj)
    }
   
    
  @IBAction  func backVc() {
        dismiss(animated: true, completion: nil)
    }

}
