//
//  PickImageViewController.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 14/01/23.
//

import UIKit
import Photos
import BSImagePicker
import ALCameraViewController

class PickImageViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    
    @IBOutlet weak var img_pick: UIImageView!
    
    @IBOutlet weak var pickImageView: UIView!
    
    
    @IBOutlet weak var takePhotoView: UIView!
    
    var image_choose: Bool = false
    
    
    var selectedImageUrl: URL!

        var SelectedAssets = [PHAsset]()

        var photoArray = [UIImage]()

        var arrSelectedFilePath : [Any] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        overrideUserInterfaceStyle = .light
    
        
        let choose_gesture = UITapGestureRecognizer(target: self, action: #selector(choose_img_list))

        pickImageView.addGestureRecognizer(choose_gesture)
        
        
        let uploadGesture = UITapGestureRecognizer(target: self, action: #selector(uploadImg))

        takePhotoView.addGestureRecognizer(uploadGesture)
    }
    
    
    
    @IBAction func uploadImg() {
        
    }
    
    
    
    @IBAction func choose_img_list(){

            

            let alert = UIAlertController(title: "Add Photo", message: "", preferredStyle: .actionSheet)

            for i in ["Camera", "Gallery"] {

                alert.addAction(UIAlertAction(title: i, style: .default, handler: choose_image_handler))

            }

            

            let change_choose_gesture = UITapGestureRecognizer(target: self, action: #selector(choose_img_list))

        pickImageView.addGestureRecognizer(change_choose_gesture)

            self.present(alert, animated: true, completion: nil)

            

        }

    func choose_image_handler(action: UIAlertAction){

            

            print(action.title!)

            if ((action.title!.elementsEqual("Camera"))){

                print("camera")

                open_camera()

            }else if ((action.title!.elementsEqual("Gallery"))){

                print("gallery")

                open_gallery()

            }

            else {

                

                let optionMenu = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)

                self.present(optionMenu, animated: true, completion: nil)

            }

            

        }
    
    
    func open_camera(){
        if UIImagePickerController.availableCaptureModes(for: .rear) != nil {
            let camera_controller = CameraViewController
            
            
            { [weak self] image, asset in
                
                
               
                //
                self!.photoArray.append(image! as UIImage)
              
                
            
            }
            
            
            
            present(camera_controller, animated: true, completion: nil)
           }else {
               noCamera()
                
             }
      
      

       }
    
    
    func noCamera(){
        let alertVC = UIAlertController(title: "No Camera", message: "Sorry, this device has no camera",preferredStyle: .alert)
       let okAction = UIAlertAction(title: "OK", style:.default, handler: nil)
          alertVC.addAction(okAction)
          present(alertVC,animated: true,completion: nil)
        
    }
    
    
    
    func open_gallery(){

            

            let imagePicker = ImagePickerController()

            

            imagePicker.settings.selection.max = 3

            imagePicker.settings.fetch.assets.supportedMediaTypes = [.image]



            presentImagePicker(imagePicker, animated: true, select:{ (asset: PHAsset) -> Void in

                

            }, deselect: { (assets : PHAsset) -> Void in


            }, cancel: {(assets: [PHAsset]) -> Void in

            }, finish: {(assets: [PHAsset]) -> Void in


                self.image_choose = true

                

                for i in 0..<assets.count



                          {

                              let resource = PHAssetResource.assetResources(for: assets[i]).first

                              let name = resource?.originalFilename

                              let PicsLocalPath = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(name!)

                
                              self.arrSelectedFilePath.append(PicsLocalPath)
                    
                             print("path",PicsLocalPath)

                              self.SelectedAssets.append(assets[i])
}

                self.convertAssetToImages()

            })

        

        }
    

    
    
    
    
    func convertAssetToImages() -> Void {


              if SelectedAssets.count != 0 {



                  for i in 0..<SelectedAssets.count {



                      let manager = PHImageManager.default()



                      let option = PHImageRequestOptions()



                      var thumbnail = UIImage()



                      option.isSynchronous = true



                      manager.requestImage(for: SelectedAssets[i],targetSize: CGSize( width : 200,height : 200), contentMode: .aspectFill, options: option, resultHandler: {(result, info) ->  Void in



                          thumbnail = result!



                      })



                      let data  = thumbnail.jpegData(compressionQuality: 0.7)

                      let newImage = UIImage(data: data!)

                      self.photoArray.append(newImage! as UIImage)
                      
                      }



                 print("photoArray.count" ,photoArray.count)



                    self.img_pick.image = self.photoArray[0]
                


              }



              print("complete phto array \(self.photoArray)")



          }
    
    
    

}
