//
//  SenderAssigmentImageUploadViewController.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 09/12/22.
//

import UIKit
import UniformTypeIdentifiers

class SenderAssigmentImageUploadViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate ,UIDocumentMenuDelegate,UIDocumentPickerDelegate  {

    
    
   
    
    
    @IBOutlet weak var galleryView: UIView!
    
    
    
    @IBOutlet weak var takeAPhotoView: UIView!
    
    
    @IBOutlet weak var choosePDFView: UIView!
    
    var image = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        // Do any additional setup after loading the view.
        
        let gallery =   UITapGestureRecognizer(target: self, action: #selector(GalleryVc))
        
        galleryView.addGestureRecognizer(gallery)
        
        let takePhoto = UITapGestureRecognizer(target: self, action: #selector(TakePhotoVc))
        takeAPhotoView.addGestureRecognizer(takePhoto)
        
        
        let choosePdf = UITapGestureRecognizer(target: self, action: #selector(choosePDFVC))
        choosePDFView.addGestureRecognizer(choosePdf)
        
      
    }

    
    
    @IBAction  func GalleryVc() {
        
        
        print("ImgEdit")
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        //If you dont want to edit the photo then you can set allowsEditing to false
        image.allowsEditing = true
        image.delegate = self
        self.present(image, animated: true, completion: nil)
        
        
    }

    
    @IBAction  func TakePhotoVc() {
        
        
        
        
        
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            image.sourceType = UIImagePickerController.SourceType.camera
            //If you dont want to edit the photo then you can set allowsEditing to false
            image.allowsEditing = true
            image.delegate = self
            self.present(image, animated: true, completion: nil)
        }
        else{
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        
    
        
        
    }
    

    
    @IBAction func backbtn(_ sender: Any) {
        
        
        dismiss(animated: true)
    }
    
    
    @IBAction func choosePDFVC(){
        
        
        clickFunction()
        
    }
    
    
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let myURL = urls.first else {
            return
        }
        print("import result : \(myURL)")
    }
          

    @objc public func documentMenu(_ documentMenu:UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        
        
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }


    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("view was cancelled")
        dismiss(animated: true, completion: nil)
    }
    
    func clickFunction(){

        let documentPicker = UIDocumentPickerViewController(documentTypes: ["com.adobe.pdf"], in: .import)
        
        documentPicker.delegate = self
        documentPicker.modalPresentationStyle = .formSheet
        
       

        self.present(documentPicker, animated: true, completion: nil)
    }
    
}
