//
//  ShowAdvertisementViewController.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 16/02/23.
//

import UIKit
import WebKit
import KRProgressHUD

class ShowAdvertisementViewController: UIViewController {

    
    
    
    @IBOutlet weak var webView: WKWebView!
    
    
    var addUrl : String!
    override func viewDidLoad() {
        super.viewDidLoad()

        KRProgressHUD.show()
        overrideUserInterfaceStyle = .light
        let url = URL (string: addUrl)

        let requestObj = URLRequest(url: url!)
        webView.load(requestObj)

        DispatchQueue.main.asyncAfter(deadline: .now()+2.8) {
           KRProgressHUD.dismiss()
        }
        
        
    }

    
    
    
    
    
    @IBAction func backbtn(_ sender: Any) {
        
        dismiss(animated: true)
        
    }
    
    
}
