//
//  AttendanceAddViewController.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 27/02/23.
//

import UIKit
import KRProgressHUD
import WebKit

class AttendanceAddViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    var addString : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        overrideUserInterfaceStyle = .light
        KRProgressHUD.show()
        
        let url = URL (string: addString)

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
