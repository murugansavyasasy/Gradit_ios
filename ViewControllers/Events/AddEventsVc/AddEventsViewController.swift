//
//  AddEventsViewController.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 16/02/23.
//

import UIKit
import WebKit
import KRProgressHUD

class AddEventsViewController: UIViewController {

    
    
    @IBOutlet weak var webView: WKWebView!
    
    var addWebUrl : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        overrideUserInterfaceStyle = .light
        KRProgressHUD.show()
        
        let url = URL (string: addWebUrl)

        let requestObj = URLRequest(url: url!)
        webView.load(requestObj)

        DispatchQueue.main.asyncAfter(deadline: .now()+2.8) {
           KRProgressHUD.dismiss()
        }
        
        
    }


    @IBAction func btnBack(_ sender: Any) {
        
        dismiss(animated: true)
    }
    
}
