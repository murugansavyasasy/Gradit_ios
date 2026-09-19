//
//  PasswordVC.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 24/08/26.
//

import UIKit

@available(iOS 16.0, *)
class PasswordVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textFieldBaseView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var eyeButton: UIButton!
    @IBOutlet weak var continueBtn: UIButton!
    
    var mobileNumber : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldBaseView.layer.cornerRadius = 12
        textFieldBaseView.layer.borderWidth =  1
        textFieldBaseView.layer.borderColor = UIColor.lightGray.cgColor
        textFieldBaseView.backgroundColor = .systemGray6.withAlphaComponent(0.5)
        
        continueBtn.layer.cornerRadius = 10

        textField.delegate = self
        textField.addDoneBtn()
        textField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        updateNextButtonState()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func updateNextButtonState() {
        let isEmpty = (textField.text ?? "").isEmpty
        if isEmpty {
            continueBtn.backgroundColor = .systemGray5
            continueBtn.setTitleColor(UIColor.lightGray, for: .normal)
        } else {
            continueBtn.backgroundColor = UIColor(named: "IndigoColour")
            continueBtn.setTitleColor(UIColor.white, for: .normal)
        }
    }
    
    @objc private func textFieldEditingChanged(_ textField: UITextField) {
        updateNextButtonState()
    }
    
    @IBAction func backAct(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func eyeBtnAct(_ sender: Any) {
        
        guard let sender = sender as? UIButton else { return }
        sender.isSelected.toggle()
        
        if sender.isSelected {
            textField.isSecureTextEntry = false
            sender.setImage(UIImage(systemName: "eye"), for: .normal)
        }else{
            textField.isSecureTextEntry = true
            sender.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        }
    }
    
    @IBAction func forgotPasswordAct(_ sender: Any) {
        
        var forgets = forgetModal()
        forgets.mobilenumber = mobileNumber
        
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
                    
                    let vc = OTPScreenVC(nibName: nil, bundle: nil)
                    vc.NotReceivedMessage = forgetResponse.Message
                    vc.IVR_numbers = forgetResponse.data?.first?.ivrnumbers ?? []
                    vc.mobileNumber = mobileNumber
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                    
                }else{
                    showAlert(title: "", message: forgetResponse.Message ?? "")
                }
                
            case .failure(let error):
                showAlert(title: "", message: error.localizedDescription)
            }
        }
    }
    
    @IBAction func continueBtnAct(_ sender: Any) {
        
        if textField.text!.isEmpty{
            showAlert(title: "", message: "Please enter password")
            
        }else{
            
            var login = LoginModal ()
            login.mobilenumber = mobileNumber
            login.Password     = textField.text
            
            APiCallManager.shared.callApi(
                url: APIEndpoints.LoginFromApp,
                httpMethod: .post,
                queryParam: nil,
                requestBody: login
            ) { [weak self] (result:Result<LoginResponse,Error>) in
                
                guard let self = self else { return }
                
                switch result {
                case .success(let success):
                    if success.Status == 1 {
                        
                        let defaults = UserDefaults.standard
                        
                        defaults.set(mobileNumber, forKey: DefaultsKeys.mobileNumber)
                        defaults.set(textField.text,forKey: DefaultsKeys.Password)
                        
                        let loginData = success.data ?? []
                        
                        if let jsonData = try? JSONEncoder().encode(success),
                           let jsonString = String(data: jsonData, encoding: .utf8) {
                            PreferencesUtil.saveToPrefs(key: Constant.keyId, value: jsonString)
                        }
                        
                        do {
                            let encoded = try JSONEncoder().encode(loginData)
                            UserDefaults.standard.set(encoded, forKey: DefaultsKeys.loginDataList)
                        }catch{
                            print("Encoding profiles failed:", error)
                        }
                        
                        if loginData.count == 1 {
                            let vc = NewHomescreenVC(nibName: nil, bundle: nil)
                            for i in loginData {
                                
                                defaults.set(i.colglogo, forKey: DefaultsKeys.colglogo)
                                defaults.set(i.loginas, forKey: DefaultsKeys.loginAsType)
                                defaults.set(i.membername, forKey: DefaultsKeys.memberName)
                                defaults.set(i.colgname, forKey: DefaultsKeys.colgName)
                                defaults.set(i.colgid, forKey: DefaultsKeys.collegeid)
                                defaults.set(i.memberid, forKey: DefaultsKeys.memberid)
                                defaults.set(i.priority, forKey: DefaultsKeys.priority)
                                defaults.set(i.colgcity, forKey:DefaultsKeys.colgcity)
                                defaults.set(i.divid ,   forKey:DefaultsKeys.divid)
                                defaults.set(i.divname, forKey: DefaultsKeys.divname)
                                defaults.set(i.courseid,forKey: DefaultsKeys.courseid)
                                defaults.set(i.coursename,forKey:DefaultsKeys.coursename)
                                defaults.set(i.deptid,forKey: DefaultsKeys.deptid)
                                defaults.set(i.deptname,forKey: DefaultsKeys.deptname)
                                defaults.set(i.yearid,forKey: DefaultsKeys.yearid)
                                defaults.set(i.yearname,forKey: DefaultsKeys.yearname)
                                defaults.set(i.sectionid,forKey: DefaultsKeys.sectionid)
                                defaults.set(i.sectionname,forKey: DefaultsKeys.sectionname)
                                defaults.set(i.semesterid,forKey: DefaultsKeys.semesterid)
                                defaults.set(i.semestername,forKey: DefaultsKeys.semestername)
                                defaults.set(i.is_parent_target_enabled,forKey: DefaultsKeys.is_parent_target_enabled)
                                defaults.set(i.is_allow_to_make_call,forKey: DefaultsKeys.is_allow_to_make_call)
                            }
                            
                            vc.modalPresentationStyle = .fullScreen
                            present(vc, animated: true,completion: nil)
                        }else{
                            
                            let vc = PriorityScreenVC(nibName: nil, bundle: nil)
                            vc.modalPresentationStyle = .fullScreen
                            present(vc, animated: true,completion: nil)
                            
                        }
                    }else {showAlert(title: "", message: success.Message ?? "")
                        
                    }
                    
                case .failure(let failure):
                    
                    showAlert(title: "", message: failure.localizedDescription)
                }
                
            }
        }
    }
    
    private func showAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        let textFieldBottom = textField.convert(textField.bounds, to: self.view).maxY
        let keyboardTop = self.view.frame.height - keyboardFrame.height
       
        if textFieldBottom > keyboardTop {
            let overlap = textFieldBottom - keyboardTop + 45
            UIView.animate(withDuration: 0.3) {
                self.view.frame.origin.y = -overlap
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y = 0
        }
    }
}
