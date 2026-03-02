//
//  DashBordShwViewController.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 07/06/23.
//

import UIKit
import WebKit
import KRProgressHUD
class DashBordShwViewController: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var scrolles: UIScrollView!
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var downloadView: UIView!
    var imgfilePath :String!
  
    var fileType : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        overrideUserInterfaceStyle = .light
        
       
        webViewLoad()
        
        downloadView.isHidden = true
        
//        let  forget = UITapGestureRecognizer(target: self, action: #selector(open_url))
//
//
//                dow.addGestureRecognizer(forget)
//        
        let  forget = UITapGestureRecognizer(target: self, action: #selector(open_url))
        
        
        downloadView.addGestureRecognizer(forget)
        
    }


    @IBAction func open_url(){

    print("fileTypefileType",fileType)
    
     KRProgressHUD.show(withMessage: "Downloading......")
    if let url = URL(string: imgfilePath ),
    let data = try? Data(contentsOf: url),
  let image = UIImage(data: data) {
     UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    KRProgressHUD.showSuccess(withMessage: "Downloaded SuccessFully")
    print("uiiuiuii",image)
    }
   
     }
//    DashBordShwViewController


    
    
    
    func webViewLoad(){
        
        
        if imgfilePath.contains(".pdf") || imgfilePath.contains(".PDF"){
            print("pdffffffddddd")
            
            webView.isHidden = false
            image.isHidden = true
            scrolles.isHidden = true
            
            KRProgressHUD.show()
            let url = URL (string: imgfilePath)
            print("urlssssskbkbkilkkjghfgfghjkk",url)
            let requestObj = URLRequest(url: url!)

            webView.load(requestObj)
            DispatchQueue.main.asyncAfter(deadline: .now()+2.3) {
                KRProgressHUD.dismiss()
            }
        }
        else{
            print("imgedddddss")
            
            webView.isHidden = true
            image.isHidden = false
            scrolles.isHidden = false
           
           image.sd_setImage(with: URL(string: imgfilePath), placeholderImage: UIImage(named: "person.fill"))
//
                       image.contentMode = .scaleAspectFit
                             
                             // Add the image view as a subview of the scroll view
                         scrolles.addSubview(image)
                             
                             // Set up the scroll view
                  scrolles.delegate = self
                   scrolles.minimumZoomScale = 1.0
                scrolles.maximumZoomScale = 3.0
                             
                             // Add constraints to make the image view fill the scroll view
                   image.translatesAutoresizingMaskIntoConstraints = false
                       image.topAnchor.constraint(equalTo: scrolles.contentLayoutGuide.topAnchor).isActive = true
                       image.leadingAnchor.constraint(equalTo: scrolles.contentLayoutGuide.leadingAnchor).isActive = true
                      image.bottomAnchor.constraint(equalTo: scrolles.contentLayoutGuide.bottomAnchor).isActive = true
                      image.trailingAnchor.constraint(equalTo: scrolles.contentLayoutGuide.trailingAnchor).isActive = true
                       
            
        }
        

        
  }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? { // image zoom
          return image
      }

      func scrollViewDidZoom(_ scrollView: UIScrollView) {
          // Center the image view within the scroll view as it zooms
          let xOffset = max((scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5, 0)
          let yOffset = max((scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5, 0)
          scrollView.contentInset = UIEdgeInsets(top: yOffset, left: xOffset, bottom: yOffset, right: xOffset)
      }
    
    
    @IBAction func backBtn(_ sender: Any) {
        
        dismiss(animated: true)
    }
    
}
