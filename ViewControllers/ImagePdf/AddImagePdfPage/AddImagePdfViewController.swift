//
//  AddImagePdfViewController.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 16/02/23.
//

import UIKit
import WebKit
import KRProgressHUD

class AddImagePdfViewController: UIViewController {


@IBOutlet weak var webView: WKWebView!

var addUrl : String!

override func viewDidLoad() {
    super.viewDidLoad()
    
    
    overrideUserInterfaceStyle = .light
    KRProgressHUD.show()
    
    let url = URL (string: addUrl)
    
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
