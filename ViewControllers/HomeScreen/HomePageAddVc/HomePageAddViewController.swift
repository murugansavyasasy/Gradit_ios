//
//  HomePageAddViewController.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 17/02/23.
//

import UIKit
import WebKit
import KRProgressHUD

class HomePageAddViewController: UIViewController {

    
    @IBOutlet weak var webView: WKWebView!
    
    var AddWebUrl : String!
    
    var adds : [String] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    
        overrideUserInterfaceStyle = .light
      
       print("ararr",adds)
        
            
            
       
            
            
            
       
            
            
            
            
            //            if i.count == 1{
            
            KRProgressHUD.show()
            
            let url = URL (string: AddWebUrl  )
            
            let requestObj = URLRequest(url: url!)
            webView.load(requestObj)
            
            DispatchQueue.main.asyncAfter(deadline: .now()+2.8) {
                KRProgressHUD.dismiss()
                //                }
                //
                //}
                //
                //
                //
                
                
                
                
                
                
           
            
        }
       
      
    }


    
    
    
    
   
    @IBAction func backBtn(_ sender: Any) {
        
        dismiss(animated: true)
    }
    
}
