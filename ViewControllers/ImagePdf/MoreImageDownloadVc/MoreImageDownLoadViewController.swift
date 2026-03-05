//
//  MoreImageDownLoadViewController.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 31/03/23.
//

import UIKit
import KRProgressHUD
import SDWebImage
import Alamofire
import WebKit

class MoreImageDownLoadViewController: UIViewController, UIScrollViewDelegate {


@IBOutlet weak var scrolles: UIScrollView!

@IBOutlet weak var imageViewss: UIImageView!
@IBOutlet weak var webView: WKWebView!

@IBOutlet weak var downloadView: UIView!

var MoreimgfilePath : String!
var fileType : String!

var viewBgColor : String!
override func viewDidLoad() {
    super.viewDidLoad()
    overrideUserInterfaceStyle = .light
    
    
    downloadView.isHidden = true
    print("imgeDownoladPageeee",MoreimgfilePath)
    print("fileTypefileTypefileType",fileType)
    
    if fileType == "image"{
        
        
        fileType = "2"
        
    }
    
    else if fileType == "pdf"{
        
        fileType = "3"
        
    }
    
    
    webViewLoad()
    
    let  forget = UITapGestureRecognizer(target: self, action: #selector(open_url))
    
    
    downloadView.addGestureRecognizer(forget)
    
    
    
    
}






func webViewLoad(){
    
    if fileType == "2"{
        
        webView.isHidden = true
        scrolles.isHidden = false
        imageViewss.isHidden = false
        KRProgressHUD.show()
        let url = URL (string: MoreimgfilePath)
        
        
        
        imageViewss.sd_setImage(with: url , placeholderImage: UIImage(named: "ic_white"))
        
        imageViewss.contentMode = .scaleAspectFit
        
        
        scrolles.addSubview(imageViewss)
        
        
        scrolles.delegate = self
        scrolles.minimumZoomScale = 1.0
        scrolles.maximumZoomScale = 3.0
        
        
        imageViewss.translatesAutoresizingMaskIntoConstraints = false
        imageViewss.topAnchor.constraint(equalTo: scrolles.contentLayoutGuide.topAnchor).isActive = true
        imageViewss.leadingAnchor.constraint(equalTo: scrolles.contentLayoutGuide.leadingAnchor).isActive = true
        imageViewss.bottomAnchor.constraint(equalTo: scrolles.contentLayoutGuide.bottomAnchor).isActive = true
        imageViewss.trailingAnchor.constraint(equalTo: scrolles.contentLayoutGuide.trailingAnchor).isActive = true
        DispatchQueue.main.asyncAfter(deadline: .now()+2.3) {
            KRProgressHUD.dismiss()
        }
    }
    
    else if fileType == "3"{
        
        
        webView.isHidden = false
        scrolles.isHidden = true
        imageViewss.isHidden = true
        
        KRProgressHUD.show()
        let url = URL (string: MoreimgfilePath)
        let requestObj = URLRequest(url: url!)
        webView.load(requestObj)
        DispatchQueue.main.asyncAfter(deadline: .now()+2.3) {
            KRProgressHUD.dismiss()
        }
        
    }
    
}




func viewForZooming(in scrollView: UIScrollView) -> UIView? { // image zoom
    return imageViewss
}

func scrollViewDidZoom(_ scrollView: UIScrollView) {
    // Center the image view within the scroll view as it zooms
    let xOffset = max((scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5, 0)
    let yOffset = max((scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5, 0)
    scrollView.contentInset = UIEdgeInsets(top: yOffset, left: xOffset, bottom: yOffset, right: xOffset)
}





@IBAction func backbtn(_ sender: Any) {
    
    dismiss(animated: true)
}



func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
    URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
}





@IBAction func open_url(){
    
    if fileType == "2"{
        
        KRProgressHUD.show(withMessage: "Downloading......")
        if let url = URL(string: MoreimgfilePath ),
           let data = try? Data(contentsOf: url),
           
            let image = UIImage(data: data) {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            KRProgressHUD.showSuccess(withMessage: "Downloaded SuccessFully")
            print("uiiuiuii",image)
        }
    }
    
    else if fileType == "3"{
        
        print("iiii")
        
        
        
        
        
        let url =  MoreimgfilePath
        
        let url1 = URL(string: url!)
        let fileName = url1!.lastPathComponent
        
        savePdf(urlString: url!, fileName: fileName)
        
    }
    
}



func savePdf(urlString:String, fileName:String) {
    DispatchQueue.main.async {
        let url = URL(string: urlString)
        let pdfData = try? Data.init(contentsOf: url!)
        let resourceDocPath = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL
        let pdfNameFromUrl = "\(fileName).pdf"
        let actualPath = resourceDocPath.appendingPathComponent(pdfNameFromUrl)
        do {
            try pdfData?.write(to: actualPath, options: .atomic)
            print("pdf successfully saved!")
            
        } catch {
            print("Pdf could not be saved")
        }
    }
    
    
}



//
class  InvoiceCustomUrlGesture : UITapGestureRecognizer {
    var  imgurl : String!
    
}

}




