//
//  SenderExamAddVcViewController.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 25/02/23.
//

import UIKit
import KRProgressHUD
import WebKit

class SenderExamAddVcViewController: UIViewController {

    
    @IBOutlet weak var webView: WKWebView!
    
    
    var AddWebUrl : String!
    override func viewDidLoad() {
        super.viewDidLoad()

      
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
