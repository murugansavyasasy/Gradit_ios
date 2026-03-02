//
//  SenderImageAddViewController.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 28/02/23.
//

import UIKit
import WebKit
import KRProgressHUD

class SenderImageAddViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    
    var AddWebUrl : String!
    override func viewDidLoad() {
        super.viewDidLoad()

        overrideUserInterfaceStyle = .light
        KRProgressHUD.show()
        
        let url = URL (string: AddWebUrl)

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
