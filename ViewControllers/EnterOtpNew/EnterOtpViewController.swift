//
//  EnterOtpViewController.swift
//  Vs_GradItCollege
//
//  Created by admin on 20/12/23.
//

import UIKit


@available(iOS 16.0, *)
class EnterOtpViewController: UIViewController,UITextFieldDelegate {
    
    
    @IBOutlet weak var reSendView: UIView!
    @IBOutlet weak var callView: UIView!
    @IBOutlet weak var AddPhnNumber: UILabel!
    @IBOutlet weak var phnNumberLbl: UILabel!
    @IBOutlet weak var resiveSucessLbl: UILabel!
    
    @IBOutlet weak var nextView: UIViewX!
    @IBOutlet weak var tf3: UITextField!
    @IBOutlet weak var tf2: UITextField!
    
    @IBOutlet weak var tf4: UITextField!
    @IBOutlet weak var tf1: UITextField!
    var phnNumber : String!
    var resiveMsg : [String] = []
    var ShowPhnumber : String!
    var callNumaber : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        addDoneButtonOnKeyboard()
        
        
        let mobileNumber = ShowPhnumber
        let maskedNumber = maskPhoneNumber(mobileNumber!)
        AddPhnNumber.text = " We have sent a 4 - digit verification code to " + " " + "+91" + maskedNumber
        
        
        tf1.addTarget(self, action: #selector(self.textFieldDidChangeSelection(_:)), for: UIControl.Event.editingChanged)
        tf2.addTarget(self, action: #selector(self.textFieldDidChangeSelection(_:)), for: UIControl.Event.editingChanged)
        tf3.addTarget(self, action: #selector(self.textFieldDidChangeSelection(_:)), for: UIControl.Event.editingChanged)
        tf4.addTarget(self, action: #selector(self.textFieldDidChangeSelection(_:)), for: UIControl.Event.editingChanged)
        resiveSucessLbl.text = phnNumber
        for i in resiveMsg {
            
            
            callNumaber = i
            phnNumberLbl.text = i
        }
        
        
        
        self.tf1.delegate = self
        tf1.keyboardType = .numberPad
        self.tf2.delegate = self
        tf2.keyboardType = .numberPad
        self.tf3.delegate = self
        tf3.keyboardType = .numberPad
        self.tf4.delegate = self
        tf4.keyboardType = .numberPad
       
        
        let vc = UITapGestureRecognizer(target: self, action: #selector(nextVC))
        
        nextView.addGestureRecognizer(vc)
        
        
        
        let resend = UITapGestureRecognizer(target: self, action: #selector(reSendVc))
        
        reSendView.addGestureRecognizer(resend)
        let callContect = UITapGestureRecognizer(target: self, action: #selector(CallConnectVc))
        
        callView.addGestureRecognizer(callContect)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tf1.becomeFirstResponder()
    }
    
    
    
    
    func maskPhoneNumber(_ phoneNumber: String) -> String {
        guard phoneNumber.count == 10 else {
            return "Invalid phone number"
        }
        
        let startIndex = phoneNumber.startIndex
        let endIndex = phoneNumber.index(phoneNumber.startIndex, offsetBy: 7)
        let maskedPart = String(repeating: "*", count: 7)
        let visiblePart = phoneNumber[endIndex...]
        
        return maskedPart + visiblePart
    }
    
    func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        tf1.inputAccessoryView = doneToolbar
        tf2.inputAccessoryView = doneToolbar
        tf3.inputAccessoryView = doneToolbar
        tf4.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction(){
        tf1.resignFirstResponder()
        tf2.resignFirstResponder()
        tf3.resignFirstResponder()
        tf4.resignFirstResponder()
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
    @objc  func textFieldDidChangeSelection(_ textField: UITextField) {
        
        let text = textField.text
        
        
        if text?.utf16.count == 1 {
            
            switch textField{
                
            case tf1:
                tf2.becomeFirstResponder()
                break
            case tf2 :
                tf3.becomeFirstResponder()
                break
            case tf3 :
                tf4.becomeFirstResponder()
                break
                
            case tf4:
                tf4.becomeFirstResponder()
                break
            default:
                break
                
            }
            
        }
        
        else{
            
            
        }
    }
    
    
    @IBAction func backbtn(_ sender: Any) {
        
        dismiss(animated: true)
    }
    
    
    @IBAction func reSendVc(){
        
        
        
        
    }
    
    
    
    @IBAction func nextVC(){
        
        
        let vc = VerifyOtpViewController(nibName: nil, bundle: nil)
        vc.mobileNumber = ShowPhnumber
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
        
        
    }
    
    @IBAction func CallConnectVc(){
        redirectToPhoneCall(phoneNumber: callNumaber)
    }
    
    
    
    func redirectToPhoneCall(phoneNumber: String) {
        if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
            let application = UIApplication.shared
            if application.canOpenURL(phoneCallURL) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            } else {
                print("Unable to redirect to phone call")
            }
        } else {
            print("Invalid phone number")
        }
    }
}


