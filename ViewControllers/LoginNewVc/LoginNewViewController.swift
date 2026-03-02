//
//  LoginNewViewController.swift
//  Vs_GradItCollege
//
//  Created by admin on 19/12/23.
//

import UIKit
import ObjectMapper

@available(iOS 16.0, *)
class LoginNewViewController: UIViewController,UITextFieldDelegate {
    
    
    @IBOutlet weak var mobileNumText: UITextField!
    
    
    @IBOutlet weak var nextView: UIViewX!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mobileNumText.delegate = self
        mobileNumText.keyboardType = .numberPad
        
        addDoneButtonOnKeyboard()
        let vc = UITapGestureRecognizer(target: self, action: #selector(loginVc))
        nextView.addGestureRecognizer(vc)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    
    
    func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        mobileNumText.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction(){
        mobileNumText.resignFirstResponder()
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
    @IBAction  func loginVc() {
        
        
        
        
        if mobileNumText.text!.isEmpty {

            
            let refreshAlert = UIAlertController(title: "", message: "Invalid Mobile Number", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
                
                
                
                
            }))
            present(refreshAlert, animated: true, completion: nil)
        }
        
        else if (mobileNumText.text?.count) != 10 {
            
            
            
            
            let refreshAlert = UIAlertController(title: "", message: "Enter valid Mobile Number", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
                
                
                
                
            }))
            present(refreshAlert, animated: true, completion: nil)
        }
        
        
        
        
        else{
            
            
            let log = loginNewModal()
            
            log.mobile_number = mobileNumText.text
            
            let logstr = log.toJSONString()
            
            
            LoginNewResqust.call_request(param: logstr!){ [self]
                
                (res) in
                
                
                
                let logApis : loginNewResponse = Mapper<loginNewResponse>().map(JSONString: res)!
                
                
                if logApis.Status == 1{
                    
                    
                    for i in  logApis.data{
                        
                        
                        if i.is_redirect_otp_screen == 1{
                            
                            
                            let vc = EnterOtpViewController(nibName: nil, bundle: nil)
                            vc.phnNumber = i.resultmessage
                            vc.resiveMsg = i.ivrnumbers
                            vc.ShowPhnumber = mobileNumText.text
                            vc.modalPresentationStyle = .fullScreen
                            present(vc, animated: true,completion: nil)
                            
                            
                        }
                        
                        
                        else{
                            
                            
                            let vc = LoginViewController(nibName: nil, bundle: nil)
                            vc.mobile_num = mobileNumText.text
                            vc.modalPresentationStyle = .fullScreen
                            present(vc, animated: true,completion: nil)
                            
                        }
                    }
                    
                }
                else{
                    
                    
                    let refreshAlert = UIAlertController(title: "", message: logApis.Message , preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        
                        
                        
                        
                        
                    }))
                    present(refreshAlert, animated: true, completion: nil)
                    
                }
                
            }
            
            
            
            
            
            
            
            
            
            
            
            
        }
    }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return range.location <= 9
    }
    
}
