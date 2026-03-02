//
//  PickPDFViewController.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 14/01/23.
//

import UIKit
import UniformTypeIdentifiers

class PickPDFViewController: UIViewController,UIImagePickerControllerDelegate & UINavigationControllerDelegate ,UIDocumentMenuDelegate,UIDocumentPickerDelegate  {
    
    
    
    @IBOutlet weak var pdfpickerView: UIView!
    
    
   
   
    var urls : URL!
    
    var collgId : String!
    
    var Pirority : String!
    
    var stafId : String!
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        overrideUserInterfaceStyle = .light
        collgId = defaults.string(forKey: DefaultsKeys.collegeid)
        Pirority = defaults.string(forKey: DefaultsKeys.priority)
        stafId = defaults.string(forKey: DefaultsKeys.memberid)
        
        
        
        
        
        
        let pdfPick = UITapGestureRecognizer(target: self, action: #selector(pdfPickerVc))
        
        pdfpickerView.addGestureRecognizer(pdfPick)

        
    }
    
    
    
    
    @IBAction func pdfPickerVc (){
        
        
        clickFunction()
        
        
    }

    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {

        let fileurl: URL = url as URL
        let filename = url.lastPathComponent
        let fileextension = url.pathExtension
        print("URL: \(fileurl)", "NAME: \(filename)", "EXTENSION: \(fileextension)")

        urls = fileurl
        

            
            AWSS3Manager.shared.uploadOtherFile(fileUrl: urls, conentType: "application/pdf", progress: {[weak self] ( uploadProgress) in
            guard let strongSelf = self else { return }
            
        }) {[weak self] (uploadedFileUrl, error) in
            
            guard let strongSelf = self else { return }
            if let finalPath = uploadedFileUrl as? String { // 3
                print("Uploaded aws file path",finalPath)
                

               
                self!.dismiss(animated: true)
               
            } else {
                print("\(String(describing: error?.localizedDescription))") // 4
            }
        }
        
   
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
    
    
    
    func SendImagePdfEntiers(){
        
        

        
        
        
        
    }
    

}
