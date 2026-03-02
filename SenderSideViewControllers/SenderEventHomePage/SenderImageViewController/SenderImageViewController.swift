//
//  SenderImageViewController.swift
//  GraditSenderEventMenu
//
//  Created by MACBOOKPRO on 02/12/22.
//

import UIKit
import KRProgressHUD

class SenderImageViewController: UIViewController {

    @IBOutlet weak var downloadView: UIView!
    
    @IBOutlet weak var courseDetailsImageView: UIImageView!
    
    
    var imgfilePath : String!
    
    var pinch_gesture = UIPinchGestureRecognizer()
 
  
    override func viewDidLoad() {
        super.viewDidLoad()

        overrideUserInterfaceStyle = .light
        print("imgfilePath11111","\(imgfilePath)")
        courseDetailsImageView.sd_setImage(with: URL(string: imgfilePath), placeholderImage: UIImage(named: "placeHolder.png"))
        
        let  forget = UITapGestureRecognizer(target: self, action: #selector(open_url))
        
        
        downloadView.addGestureRecognizer(forget)
        

        
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
    

    
    
    

    @IBAction func backbtn(_ sender: Any) {
        
        dismiss(animated: true)
    }
    
    
    
    
    

  
   
    
    
    @IBAction func open_url(){
        
        
            if let url = URL(string: imgfilePath ),

               let data = try? Data(contentsOf: url),

               let image = UIImage(data: data) {

                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                KRProgressHUD.showSuccess(withMessage: "Downloaded SuccessFully")
                print("uiiuiuii",image)
            }

        }
        
       
    }
    
    
   

