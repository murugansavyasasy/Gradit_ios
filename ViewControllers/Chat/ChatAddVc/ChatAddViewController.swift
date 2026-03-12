//
//  ChatAddViewController.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 24/02/23.
//

import UIKit
import WebKit
import KRProgressHUD

class ChatAddViewController: UIViewController {
    
    
    @IBOutlet weak var webView: WKWebView!
    
    var addWeurl : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        KRProgressHUD.show()
        
        let url = URL (string: addWeurl)
        
        let requestObj = URLRequest(url: url!)
        webView.load(requestObj)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+2.8) {
            KRProgressHUD.dismiss()
        }
        
    }
    
    
    @IBAction func backBtn(_ sender: Any) {
        
        dismiss(animated: true)
        
    }
}
