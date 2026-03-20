//
//  EnterOtpPageViewController.swift
//  EnterOtpPage
//
//  Created by MACBOOKPRO on 02/01/23.
//

import UIKit
import ObjectMapper
import  KRProgressHUD

@available(iOS 16.0, *)
class EnterOtpPageViewController: UIViewController,UITextFieldDelegate {


@IBOutlet weak var yourNumberTextField: UITextField!


@IBOutlet weak var enterOtpTextField: UITextField!


@IBOutlet weak var resentView: UIView!


@IBOutlet weak var continueView: UIViewX!


@IBOutlet weak var lockimageView: UIImageView!

@IBOutlet weak var loginView: UIView!




@IBOutlet weak var passwordLockImageView: UIView!
var forArr : [dataForgetDetails] = []
var show_password = true
var mobileNumber : String!
override func viewDidLoad() {
super.viewDidLoad()
overrideUserInterfaceStyle = .light


yourNumberTextField.text = mobileNumber
addDoneButtonOnKeyboard()
let loginviews = UITapGestureRecognizer(target: self, action: #selector(loginViewVc))

loginView.addGestureRecognizer(loginviews)
let contin = UITapGestureRecognizer(target: self, action: #selector(conticevc))

continueView.addGestureRecognizer(contin)
let reSentView = UITapGestureRecognizer(target: self, action: #selector(resentVc))

resentView.addGestureRecognizer(reSentView)

enterOtpTextField.delegate = self
enterOtpTextField.keyboardType = .numberPad


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

enterOtpTextField.inputAccessoryView = doneToolbar
}


@objc func doneButtonAction(){
enterOtpTextField.resignFirstResponder()
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


@IBAction func conticevc () {


verifyOtp ()

}

@IBAction func loginViewVc () {


let vc = LoginViewController(nibName: nil, bundle: nil)

vc.modalPresentationStyle = .fullScreen
present(vc, animated: true,completion: nil)


}



@IBAction func resentVc(){

KRProgressHUD.show()

DispatchQueue.main.asyncAfter(deadline: .now() + 3.5 ){ [self] in

KRProgressHUD.dismiss()

forget()
}



}

func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

let currentCharacterCount = enterOtpTextField.text?.count ?? 0
if range.length + range.location > currentCharacterCount {
return false
}
let newLength = currentCharacterCount + string.count - range.length
return newLength <= 4
}




func textFieldShouldReturn(_ textField: UITextField) -> Bool {


self.view.endEditing(true)


return false


}
    
    func verifyOtp (){
        
        var verify = recentOTPModal()
        
        verify.mobilenumber = mobileNumber
        verify.otp = enterOtpTextField.text
        
        print("verify request", verify)
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.VerifyOTP,
            httpMethod: .post,
            queryParam: nil,
            requestBody: verify
        ) { [weak self] (result: Result<recentOTPResponce, Error>) in
            
            guard let self = self else { return }
            
            switch result {
                
            case .success(let forgetResponse):
                
                if forgetResponse.Status == 1 {
                    
                    let vc = VerifyOtpViewController(nibName: nil, bundle: nil)
                    vc.mobileNumber = mobileNumber
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                    
                }
                else {
                    
                    let refreshAlert = UIAlertController(title: "", message: forgetResponse.Message, preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        
                    }))
                    
                    self.present(refreshAlert, animated: true, completion: nil)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func forget(){
        
        var forgets = forgetModal()
        forgets.mobilenumber = mobileNumber
        
        print("forget request", forgets)
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.forgetpassword,
            httpMethod: .post,
            queryParam: nil,
            requestBody: forgets
        ) { [weak self] (result: Result<forgetResponce, Error>) in
            
            guard let self = self else { return }
            
            switch result {
                
            case .success(let forgetResponse):
                
                if forgetResponse.Status == 1 {
                    
                    self.forArr = forgetResponse.data ?? []
                }
                
                else {
                    
                    let refreshAlert = UIAlertController(title: "", message: forgetResponse.Message, preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        
                    }))
                    
                    self.present(refreshAlert, animated: true, completion: nil)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
