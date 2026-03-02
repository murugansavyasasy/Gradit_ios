//
//  SenderImageDownloadViewController.swift
//  GraditImagePdf
//
//  Created by MACBOOKPRO on 07/12/22.
//

import UIKit
import KRProgressHUD
import SDWebImage
import WebKit


class SenderImageDownloadViewController: UIViewController, URLSessionDelegate {
    
    
    
    
    
    
    
    @IBOutlet weak var imageViews: UIImageView!
    @IBOutlet weak var webViewParentView: UIView!
    
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var downloadView: UIView!
    
    
    @IBOutlet weak var courseDetailsImageView: UIImageView!
    
    var imgfilePath : String!
    
    var viewBgColor : String!
    
    var fileType : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        print("imagetssTypesssDownload",fileType)
        print("imageFile",imgfilePath)
        
      
        
        webViewLoad()
        
       
        let  forget = UITapGestureRecognizer(target: self, action: #selector(open_url))
        downloadView.addGestureRecognizer(forget)
        
        
      
    }
    
    
    func webViewLoad(){
        
        if fileType == "2"{
            
            webView.isHidden = true
            imageViews.isHidden = false
            KRProgressHUD.show()
            let url = URL (string: imgfilePath)
           
            
            imageViews.sd_setImage(with: url , placeholderImage: UIImage(named: "ic_white"))
            
            
            DispatchQueue.main.asyncAfter(deadline: .now()+2.3) {
                KRProgressHUD.dismiss()
            }
        }
        
        else if fileType == "3"{
            
            webView.isHidden = false
            imageViews.isHidden = true
            KRProgressHUD.show()
            let url = URL (string: imgfilePath)
            print("Urlssssdds",url)
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
                //file is downloaded in app data container, I can find file from x code > devices > MyApp > download Container >This container has the file
            } catch {
                print("Pdf could not be saved")
            }
        }
        
        
    }
    
    
    
    
    
    
    
    
    
}

