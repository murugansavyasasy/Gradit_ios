//
//  ImageDownloadViewController.swift
//  GraditCircularImage
//
//  Created by MACBOOKPRO on 03/11/22.
//

import UIKit
import KRProgressHUD
import SDWebImage
import Alamofire
import WebKit

//import QuickLook

class ImageDownloadViewController: UIViewController, URLSessionDelegate, UIScrollViewDelegate {
//

@IBOutlet weak var scrolles: UIScrollView!
@IBOutlet weak var scrollview: UIScrollView!
@IBOutlet weak var imageViewss: UIImageView!
@IBOutlet weak var webView: WKWebView!

@IBOutlet weak var downloadView: UIView!


@IBOutlet weak var courseDetailsImageView: UIImageView!

var pdfurl : URL!
var imgfilePath :String!
var images : UIImage!
var fileType : String!
var scrollV : UIScrollView!
var imageShow : String!
var imageView: UIImageView!
override func viewDidLoad() {
    super.viewDidLoad()
    
    
    
    overrideUserInterfaceStyle = .light
    
    
    webViewLoad()
    
    downloadView.isHidden = true
    let  forget = UITapGestureRecognizer(target: self, action: #selector(open_url))
    
    
    downloadView.addGestureRecognizer(forget)
    
    
    
}



func webViewLoad(){
    
    if fileType == "2"{
        
        webView.isHidden = true
        imageViewss.isHidden = false
        scrolles.isHidden = false
        KRProgressHUD.show()
        let url = URL (string: imgfilePath)
        print("urlsssssfghjklkjhgf",url)
        
        
        imageViewss.sd_setImage(with: url , placeholderImage: UIImage(named: "ic_white"))
        
        imageViewss.contentMode = .scaleAspectFit
        
        // Add the image view as a subview of the scroll view
        scrolles.addSubview(imageViewss)
        
        // Set up the scroll view
        scrolles.delegate = self
        scrolles.minimumZoomScale = 1.0
        scrolles.maximumZoomScale = 3.0
        
        // Add constraints to make the image view fill the scroll view
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
        imageViewss.isHidden = true
        scrolles.isHidden = true
        KRProgressHUD.show()
        let url = URL (string: imgfilePath)
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




func downloadImage() {
    let imageUrlStr = imgfilePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    let task = URLSession.shared.dataTask(with: URLRequest(url: URL(string: imageUrlStr)!), completionHandler: {(data, response, error) -> Void in
        
        guard let data = data else {
            print("No image data")
            return
        }
        
        do {
            try data.write(to: self.getDocumentsDirectory().appendingPathComponent("image.jpg"))
            print("Image saved to: ",self.getDocumentsDirectory())
        } catch {
            print(error)
        }
        
    })
    // Start the download.
    task.resume()
}

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

@IBAction func downloadImage(from url: URL) {
    print("Download Started")
    downloadImage()
    
}






@IBAction func open_url(){
    
    
    
    if fileType == "2"{
        
        KRProgressHUD.show(withMessage: "Downloading......")
        if let url = URL(string: imgfilePath ),
           let data = try? Data(contentsOf: url),
           let image = UIImage(data: data) {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            KRProgressHUD.showSuccess(withMessage: "Downloaded SuccessFully")
            print("uiiuiuii",image)
        }
    }
    
    else if fileType == "3"{
        
        print("iiii")
        
        let url =  imgfilePath
        
        let url1 = URL(string: url!)
        let fileName = url1!.lastPathComponent
        print("filename",fileName)
        savePdf(urlString: url!, fileName: fileName)
        
        
        
        
    }
    
    
    
    
    func savePdf(urlString:String, fileName:String) {
        DispatchQueue.main.async {
            let url = URL(string: urlString)
            let pdfData = try? Data.init(contentsOf: url!)
            let resourceDocPath = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL
            let pdfNameFromUrl = "file\(fileName).pdf"
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



}
