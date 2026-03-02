//
//  AttechmentDownloadViewController.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 27/01/23.
//

import UIKit
import KRProgressHUD
import SDWebImage
import Photos
class AttechmentDownloadViewController: UIViewController {
    
    
    @IBOutlet weak var downloadView: UIView!
    
   

    @IBOutlet weak var courseDetailsImageView: UIImageView!
    
    var imgfilePath : String!
    
    var pinch_gesture = UIPinchGestureRecognizer()
 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        overrideUserInterfaceStyle = .light
        
        print("imgfilePath11111",imgfilePath)
        courseDetailsImageView.sd_setImage(with: URL(string: imgfilePath), placeholderImage: UIImage(named: "placeHolder.png"))
        
        
       
        
        if let filePath = Bundle.main.path(forResource: "imageName", ofType: "jpg"), let image = UIImage(contentsOfFile: filePath) {
            courseDetailsImageView.contentMode = .scaleAspectFit
            courseDetailsImageView.image = image
        }
       
        let pinch_gesture = UIPinchGestureRecognizer(target: self, action: #selector(zoom_img))
            courseDetailsImageView.addGestureRecognizer(pinch_gesture)
        
        
        courseDetailsImageView.isUserInteractionEnabled = true

        
    }
    
    
    @IBAction func zoom_img( _ sender : UIPinchGestureRecognizer){
            print("img gesture")
        sender.view?.transform = (sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale))!
          sender.scale = 1.0
        
          }
    
    
    
    
    func getData(from url:URL , completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    
        
        
        
        func getDocumentsDirectory() -> URL {
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            return paths[0]
        }
        @IBAction func downloadImage(from url: URL) {
            print("Download Started")
            KRProgressHUD.show()
            
            
            KRProgressHUD.dismiss()
        }
        
        
        @IBAction func open_url(){
         
            KRProgressHUD.show(withMessage: "Downloading......")
            let imageUrlStr = imgfilePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            let task = URLSession.shared.dataTask(with: URLRequest(url: URL(string: imageUrlStr)!), completionHandler: {(data, response, error) -> Void in
                
                guard let data = data else {
                    print("No image data")
                    return
                }
                
                do {
                    try data.write(to: self.getDocumentsDirectory().appendingPathComponent("image.jpg"))
                    print("Image saved to: ",self.getDocumentsDirectory())
                    
                    KRProgressHUD.dismiss()
                } catch {
                    print(error)
                }
                
            })
            // Start the download.
            task.resume()
            
            
            
        }
        
        
  
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }

   
    

    
    @IBAction func SaveImageButton (sender : UIButton)

    {

        guard let image = courseDetailsImageView.image else { return }

            UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
       
    }


    
    //
    class  InvoiceCustomUrlGesture : UITapGestureRecognizer {
        var  imgurl : String!
        
    }
    
    
    
  
    

    @IBAction func closeBtn(_ sender: Any) {
        
        dismiss(animated: true)
        
    }
    
}
