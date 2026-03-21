//
//  ChangePasswordViewController.swift
//  GraditLoginApp
//
//  Created by MACBOOKPRO on 17/10/22.
//

import UIKit
import ObjectMapper

@available(iOS 16.0, *)
class ChangePasswordViewController: UIViewController,UITextFieldDelegate {
    
    
    @IBOutlet weak var cancelView: UIView!
    
    @IBOutlet weak var oldPasswordTextField: UITextField!
    
    
    @IBOutlet weak var newPasswordTextField: UITextField!
    
    
    
    @IBOutlet weak var confirmPassWordTextField: UITextField!
    
    
    @IBOutlet weak var submitView: UIViewX!
    
    override func viewDidLoad() {
        super.viewDidLoad()

   
        overrideUserInterfaceStyle = .light
        let  tapGetOtp = UITapGestureRecognizer(target: self, action: #selector(submitVc))
             
        submitView .addGestureRecognizer(tapGetOtp)
        
        
        
        let  cancelViews = UITapGestureRecognizer(target: self, action: #selector(cancelVc))
             
        cancelView.addGestureRecognizer(cancelViews)
        
        self.oldPasswordTextField.delegate = self
        self.newPasswordTextField.delegate = self
        self.confirmPassWordTextField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {


            self.view.endEditing(true)


            return false


        }
    @objc func keyboardWillShow(notification: NSNotification) {
        
//        print("open",keyboardSize.height)
        
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height-91
                print("keyboardSize.height",keyboardSize.height)
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }

    
    @IBAction  func cancelVc() {
        
        dismiss(animated: true)
        
    }
        
    @IBAction  func submitVc() {
        
        
        
        if oldPasswordTextField.text!.isEmpty {
            
            
            

            
            
            let refreshAlert = UIAlertController(title: "", message: "Enter Your Old Password", preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        
                        
                        
                        
                    }))
                    
                  
                    present(refreshAlert, animated: true, completion: nil)
                    
            
        }
        
        
        else if newPasswordTextField.text!.isEmpty{
            
            
//
//
            
            
            
            let refreshAlert = UIAlertController(title: "", message: "Enter Your New Password ", preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        
                        
                        
                        
                        
                        
                    }))
                    
                  
                    present(refreshAlert, animated: true, completion: nil)
            
        }
        
        
        else if confirmPassWordTextField.text!.isEmpty {
            
            
        
            
            
            let refreshAlert = UIAlertController(title: "", message: "Enter Your Confirm Password ", preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        

                        
                        
                        
                        
                    }))
                    
                  
                    present(refreshAlert, animated: true, completion: nil)
        }
        
        
        else if (oldPasswordTextField.text ) == (newPasswordTextField.text){
            
         
            
            
            let refreshAlert = UIAlertController(title: "", message: "Old Password And New Password are Similar ", preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        
                        
                        
                        
                        
                    }))
                    
                  
                    present(refreshAlert, animated: true, completion: nil)
            
        }
        
        else if (newPasswordTextField.text!) != (confirmPassWordTextField.text!) {
            
            let refreshAlert = UIAlertController(title: "", message: "Your Password Dosen't Match " , preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        
                    }))
                    
                    present(refreshAlert, animated: true, completion: nil)
              
        }
        
        
        else{
            
            let defaults = UserDefaults.standard
            let getmobil = defaults.string(forKey: DefaultsKeys.mobileNumber)
            var changepass = chageModal()
            
            changepass.mobilenumber = getmobil
            changepass.oldpassword = oldPasswordTextField.text
            changepass.newpassword = newPasswordTextField.text

            APiCallManager.shared.callApi(
                url: APIEndpoints.changepassword,
                httpMethod: .post,
                queryParam: nil,
                requestBody: changepass
            ) { [weak self] (result: Result<chageResponce, Error>) in
                
                guard let self = self else { return }
                
                switch result {
                    
                case .success(let changePassRess):
                    
                    let refreshAlert = UIAlertController(title: "", message: changePassRess.Message , preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        
                       let vc =  LoginViewController()
                        vc.mobile_num = defaults.string(forKey: DefaultsKeys.mobileNumber)
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true)
                        
                        
                        
                    }))
                    
                    self.present(refreshAlert, animated: true, completion: nil)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
}

}

