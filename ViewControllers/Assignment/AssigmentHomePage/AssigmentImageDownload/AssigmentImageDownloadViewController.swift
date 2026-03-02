//
//  AssigmentImageDownloadViewController.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 18/02/23.
//

import UIKit
import WebKit
import KRProgressHUD

class AssigmentImageDownloadViewController: UIViewController {


@IBOutlet weak var webViewParentView: UIView!

@IBOutlet weak var webView: WKWebView!

@IBOutlet weak var downloadView: UIView!


@IBOutlet weak var courseDetailsImageView: UIImageView!

var imgfilePath : String!

var viewBgColor : String!

var fileType : String!

var pinch_gesture = UIPinchGestureRecognizer()

override func viewDidLoad() {
    super.viewDidLoad()
    
    overrideUserInterfaceStyle = .light
    
    
    webViewLoad()
    
    print("imagetssTypesssDownload",fileType)
    
    
    let  forget = UITapGestureRecognizer(target: self, action: #selector(open_url))
    
    
    downloadView.addGestureRecognizer(forget)
    
    
    let pinch_gesture = UIPinchGestureRecognizer(target: self, action: #selector(zoom_img))
    courseDetailsImageView.addGestureRecognizer(pinch_gesture)
    
    
    courseDetailsImageView.isUserInteractionEnabled = true
    
    
}


@IBAction func zoom_img( _ sender : UIPinchGestureRecognizer){
    print("img gesture")
    sender.view?.transform = (sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale))!
    sender.scale = 1.0
    
}


func webViewLoad(){
    
    if fileType == "image"{
        KRProgressHUD.show()
        let url = URL (string: imgfilePath)
        let requestObj = URLRequest(url: url!)
        webView.load(requestObj)
        DispatchQueue.main.asyncAfter(deadline: .now()+2.3) {
            KRProgressHUD.dismiss()
        }
    }
    
    else if fileType == "pdf"{
        KRProgressHUD.show()
        let url = URL (string: imgfilePath)
        let requestObj = URLRequest(url: url!)
        webView.load(requestObj)
        DispatchQueue.main.asyncAfter(deadline: .now()+2.3) {
            KRProgressHUD.dismiss()
        }
        
    }
    
    
    
}






@IBAction func backbtn(_ sender: Any) {
    
    dismiss(animated: true)
}






func getData(from url:URL , completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
    URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
}

@IBAction func downloadImage(from url: URL) {
    print("Download Started")
    KRProgressHUD.show()
    getData(from:url) { data, response, error in
        guard let data = data, error == nil else { return }
        print(response?.suggestedFilename ?? url.lastPathComponent)
        print("Download Finished")
        KRProgressHUD.dismiss()
        
        DispatchQueue.main.async() { [weak self] in
            
        }
    }
}




@IBAction func open_url(){
    
    
    
    KRProgressHUD.show(withMessage: "Downloading......")
    if let url = URL(string: imgfilePath ),
       let data = try? Data(contentsOf: url),
       let image = UIImage(data: data) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        KRProgressHUD.showSuccess(withMessage: "Downloaded SuccessFully")
        print("uiiuiuii",image)
    }
    
    
    
}
















}
