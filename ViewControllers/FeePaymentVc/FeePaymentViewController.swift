//
//  FeePaymentViewController.swift
//  Vs_GradItCollege
//
//  Created by admin on 13/06/24.
//

import UIKit
import KRProgressHUD
import WebKit

class FeePaymentViewController: UIViewController,WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    
    
    var memberId = ""
    var feeUrl = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        let defaults = UserDefaults.standard
        
        memberId = defaults.string(forKey: DefaultsKeys.memberid)!
        feeUrl = defaults.string(forKey: DefaultsKeys.feepaymentlink)!
        
        let myURL = URL(string: feeUrl+memberId)
        let myRequest = URLRequest(url: myURL!)
        print("myRequestmyRequest",myRequest)
        webView.load(myRequest)
        
    }
    
    
    
    
    @IBAction func backbtn(_ sender: Any) {
        
        
        dismiss(animated: true)
        
    }
    
    
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url {
            print("URL is about to be loaded: \(url)")
            // Here you can check the URL and decide to allow or cancel the navigation
        }
        decisionHandler(.allow)
    }
    
    // WKNavigationDelegate method to listen when URL has started loading
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        if let url = webView.url {
            print("URL has started loading: \(url)")
        }
    }
    
    // WKNavigationDelegate method to listen when URL has finished loading
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if let url = webView.url {
            print("URL has finished loading: \(url)")
            
            if url.absoluteString.contains("paymentsucccess/returnhome"){
                self.dismiss(animated: true)
                
            }else{
                
            }
        }
    }
}
