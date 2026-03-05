//
//  VideoPlayerViewController.swift
//  VideoGradit
//
//  Created by MACBOOKPRO on 23/10/22.
//

import UIKit

import WebKit
import KRProgressHUD



class VideoPlayerViewController: UIViewController{
    
    @IBOutlet weak var WebVideo: WKWebView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    @IBOutlet weak var videoView: UIView!
    
    var video    : [videoDataDetails] = []
    
    var webView : WKWebView!
    
    
    
    var titlesss : String!
    var descriptionszs: String!
    var url: String!
    var videoid : String!
    var iframe : String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        KRProgressHUD.show()
        overrideUserInterfaceStyle = .light
        titleLabel.text = titlesss
        descriptionLabel.text = descriptionszs
        
        
        
        let videoId = videoid.components(separatedBy:"/")
        
        
        
        if let mediaURL:URL = URL(string: url) {
            let request:URLRequest = URLRequest(url: mediaURL);
            WebVideo.load(request)
        }
        
        
        
        //
        DispatchQueue.main.asyncAfter(deadline: .now()+3.5) {
            KRProgressHUD.dismiss()
        }
        
    }
    
    
    @IBAction func backbtn(_ sender: Any) {
        
        dismiss(animated: true)
    }
    
}







