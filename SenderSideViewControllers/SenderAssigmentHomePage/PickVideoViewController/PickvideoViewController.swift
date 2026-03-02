//
//  PickvideoViewController.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 14/01/23.
//

import UIKit
import AVFoundation
import AVKit
import PhotosUI

class PickvideoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{







@IBOutlet weak var videoPickView: UIView!


var urlss : String!
var selectedImageUrl: URL!

let imagePickerController = UIImagePickerController()
var videoURL: URL?

var url: URL!
var SelectedAssets = [PHAsset]()
var arrSelectedFilePath : [Any] = []


override func viewDidLoad() {
    super.viewDidLoad()
    
    
    overrideUserInterfaceStyle = .light
    
    let video = UITapGestureRecognizer(target: self, action: #selector(videopickVc))
    videoPickView.addGestureRecognizer(video)
    
    
    
}





@IBAction func videopickVc(){
    
    
    let imagePickerController = UIImagePickerController()
    imagePickerController.delegate = self
    
    imagePickerController.mediaTypes = ["public.movie"]
    self.present(imagePickerController, animated: true, completion: nil)
}


func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
    let videoURL = info[UIImagePickerController.InfoKey.mediaURL] as? URL
    print(UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(videoURL!.path))
    print("rfrfrf",videoURL)
    dismiss(animated: true, completion: {
        
    })
}





}
