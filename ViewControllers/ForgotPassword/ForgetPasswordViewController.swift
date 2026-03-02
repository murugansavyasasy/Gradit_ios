//
//  ForgetPasswordViewController.swift
//  GraditLoginApp
//
//  Created by MACBOOKPRO on 17/10/22.
//

import UIKit
import ObjectMapper

@available(iOS 16.0, *)
class ForgetPasswordViewController: UIViewController,UITextFieldDelegate {

@IBOutlet weak var forgetMobileNumberTextFiled: UITextField!

@IBOutlet weak var loginPageView: UIView!

@IBOutlet weak var getOtpView: UIViewX!

var forArr : [dataForgetDetails] = []
var ivrn : [String] = []

override func viewDidLoad() {
super.viewDidLoad()

overrideUserInterfaceStyle = .light
let  tapGetOtp = UITapGestureRecognizer(target: self, action: #selector(getOtpVc))

getOtpView.addGestureRecognizer(tapGetOtp)
addDoneButtonOnKeyboard()

let  loginpages = UITapGestureRecognizer(target: self, action: #selector(LogVc))

loginPageView.addGestureRecognizer(loginpages)

forgetMobileNumberTextFiled.delegate = self

self.forgetMobileNumberTextFiled.delegate = self
forgetMobileNumberTextFiled.keyboardType = .numberPad

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

forgetMobileNumberTextFiled.inputAccessoryView = doneToolbar
}


@objc func doneButtonAction(){
forgetMobileNumberTextFiled.resignFirstResponder()
}


func textFieldShouldReturn(_ textField: UITextField) -> Bool {


self.view.endEditing(true)


return false


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

@IBAction  func LogVc() {

let vc = LoginViewController(nibName: nil, bundle: nil)
vc.modalPresentationStyle = .fullScreen
present(vc, animated: true,completion: nil)



}






func forget(){


let forgets =  forgetModal  ()
forgets.mobilenumber = forgetMobileNumberTextFiled.text



let forgetStr = forgets.toJSONString()

forgetRequest.call_request(param: forgetStr!){ [self]

(res) in


let forgetResponse : forgetResponce =
Mapper<forgetResponce>().map(JSONString: res)!

if forgetResponse.Status == 1 {
    
    if forgetMobileNumberTextFiled.text! .isEmpty {
        forArr = forgetResponse.data
        
        
        let refreshAlert = UIAlertController(title: "", message: forgetResponse.Message, preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            
            
        }))
        
        
        present(refreshAlert, animated: true, completion: nil)
        
        
        
    }
    
    else if (forgetMobileNumberTextFiled.text?.count) != 10 {
        //
        
        let refreshAlert = UIAlertController(title: "", message: forgetResponse.Message, preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            
            
        }))
        
        
        present(refreshAlert, animated: true, completion: nil)
        
        //
    }
    
    
    
    
    else{
        
        let vc = GetOtpViewController(nibName: nil, bundle: nil)
        
        vc.messageId = forgetResponse.Message
        vc.MobileNumber = forgetMobileNumberTextFiled.text
        
        
        for i in forgetResponse.data{
            ivrn = i.ivrnumbers
            
            vc.ivrNumberId = ivrn
            
        }
        
        vc.modalPresentationStyle = .formSheet
        present(vc, animated: true,completion: nil)
        
        
        
        
        
        
        
    }
    
    
    
}

else {
    
    
    
    
    
    let refreshAlert = UIAlertController(title: "", message: forgetResponse.Message, preferredStyle: UIAlertController.Style.alert)
    
    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
        
        
    }))
    
    
    present(refreshAlert, animated: true, completion: nil)
    
    
    
    
}

}
}

@IBAction  func getOtpVc() {



forget()




}


func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

return range.location <= 9
}






}


