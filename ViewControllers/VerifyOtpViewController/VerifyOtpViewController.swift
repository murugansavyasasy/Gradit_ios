//
//  VerifyOtpViewController.swift
//  Vs_GradItCollege
//
//  Created by admin on 25/08/23.
//

import UIKit
import ObjectMapper

@available(iOS 16.0, *)
class VerifyOtpViewController: UIViewController,UITextFieldDelegate {
    
    
    
    
    @IBOutlet weak var newpassordsecrView: UIView!
    @IBOutlet weak var newPassowrdTextfiled: UITextField!
    
    @IBOutlet weak var newpassLockImg: UIImageView!
    
    @IBOutlet weak var confirmpassTestfield: UITextField!
    
    @IBOutlet weak var confirmBtn: UIViewX!
    
    @IBOutlet weak var confirmpasslockImage: UIImageView!
    @IBOutlet weak var confirmpassowrdLock: UIView!
    var mobileNumber : String!
    var show_password = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let confirmView = UITapGestureRecognizer(target: self, action: #selector(clickVC))
        confirmBtn.addGestureRecognizer(confirmView)
        
        
        
        let eye_gesture = UITapGestureRecognizer(target: self, action: #selector(toggle_password))
        newpassordsecrView.addGestureRecognizer(eye_gesture)
        
        
        let eye_gesture1 = UITapGestureRecognizer(target: self, action: #selector(toggle_password1))
        confirmpassowrdLock.addGestureRecognizer(eye_gesture1)
        
        newPassowrdTextfiled.delegate = self
        confirmpassTestfield.delegate = self
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    
    
    @objc func keyboardWillShow(notification: NSNotification) { // -----> to set key board set height
        
        
        
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
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        self.view.endEditing(true)
        
        
        return false
        
        
    }
    
    
    @objc func toggle_password(){
        print("toggle works")
        show_password = !show_password
        newPassowrdTextfiled.isSecureTextEntry = show_password
        newpassLockImg.image = UIImage(named: show_password ? "lock": "un_lock")
        
    }
    
    
    
    @objc func toggle_password1(){
        print("toggle works")
        show_password = !show_password
        confirmpassTestfield.isSecureTextEntry = show_password
        confirmpasslockImage.image = UIImage(named: show_password ? "lock": "un_lock")
        
    }
    
    
    @IBAction func clickVC(){
        
        
        print("newPassowrdTextfiled",newPassowrdTextfiled.text)
        
        print("confirmpassTestfield",confirmpassTestfield.text)
        
        
        if (newPassowrdTextfiled.text == ""){
            
            let refreshAlert = UIAlertController(title: "", message: "All Fields  Empty ", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
            }))
            
            present(refreshAlert, animated: true, completion: nil)
        }
        
        
        else if  (confirmpassTestfield.text == "") {
            
            let refreshAlert = UIAlertController(title: "", message: "All Fields Or Empty ", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
            }))
            
            present(refreshAlert, animated: true, completion: nil)
        }
        
        
        else  if newPassowrdTextfiled.text ==  confirmpassTestfield.text{
            
            confirmpass()
            
        }
        
        
        
        else {
            
            
            
            let refreshAlert = UIAlertController(title: "", message: "Password is Mismatch ", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
                
            }))
            
            present(refreshAlert, animated: true, completion: nil)
            
        }
        
    }
    
    
    func confirmpass(){
        
        var verify = confirmPasswordModal()
        
        verify.mobilenumber = mobileNumber
        verify.newpassword = confirmpassTestfield.text
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.forgetpasswordReset,
            httpMethod: .post,
            queryParam: nil,
            requestBody: verify
        ) { [weak self] (result:Result<ConfirmPassResp,Error>) in
                
            guard let self = self else { return }
            
            switch result {
            case .success(let success):
                if success.Status == 1 {
                    
                    let refreshAlert = UIAlertController(
                        title: "",
                        message: success.Message,
                        preferredStyle: .alert
                    )
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
                        guard let self = self else { return }
                        
                        let vc = LoginViewController(nibName: nil, bundle: nil)
                        vc.mobile_num = mobileNumber
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true)
                    }))
                    
                    present(refreshAlert, animated: true, completion: nil)
                    
                }else{
                    
                    let refreshAlert = UIAlertController(title: "", message: success.Message, preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        
                    }))
                    
                    present(refreshAlert, animated: true, completion: nil)
                }
            case .failure(let failure):
                let refreshAlert = UIAlertController(title: "", message: failure.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    
                }))
                
                present(refreshAlert, animated: true, completion: nil)
            }
                
            }
    }
    
    
}









