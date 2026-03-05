//
//  SenderPlayingVideoViewController.swift
//  GraditSenderVideoMenu
//
//  Created by MACBOOKPRO on 04/12/22.
//

import UIKit
import WebKit


class SenderPlayingVideoViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var WebVideo: WKWebView!
    
   
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    var viewBgColor : String!
     
    
     
     var titlesss : String!
      var descriptionszs: String!
     var url: String!
     var videoid : String!

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        view.backgroundColor = UIColor(named: viewBgColor)
        
        titleLabel.text = titlesss
        descriptionLabel.text = descriptionszs
        
        


        let videoId = videoid.components(separatedBy:"/")
        
        
        if let mediaURL:URL = URL(string: url) {
            let request:URLRequest = URLRequest(url: mediaURL);
            WebVideo.load(request)
            
            
        }

        
    }


    @IBAction func back(_ sender: Any) {
        
        dismiss(animated: true)
    }
    

}
