//
//  LoginVc.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 21/08/26.
//

import UIKit

@available(iOS 16.0, *)
class LoginVc: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var backBtn: RoundedBackBtn!
    @IBOutlet weak var mobileNumberBaseview: UIView!
    @IBOutlet weak var mobileNumberTextfield: UITextField!
    @IBOutlet weak var passwordBaseView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var eyeButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var topCurveview: UIView!
    
    var mobileNumber: String?
    private var CountryData : CountryData?
    var HideBackBtn: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backBtn.isHidden = HideBackBtn
        
        if let data = UserDefaults.standard.data(forKey: DefaultsKeys.SelectedCountry),
           let country = try? JSONDecoder().decode(Gradit.CountryData.self, from: data){
            CountryData = country
        }
        
        mobileNumberBaseview.layer.cornerRadius = 10
        mobileNumberBaseview.layer.borderColor = UIColor.lightGray.cgColor
        mobileNumberBaseview.layer.borderWidth = 1.0
        
        passwordBaseView.layer.cornerRadius = 10
        passwordBaseView.layer.borderColor = UIColor.lightGray.cgColor
        passwordBaseView.layer.borderWidth = 1.0
        
        loginButton.layer.cornerRadius = 10
        
        mobileNumberTextfield.text = mobileNumber
        mobileNumberTextfield.delegate = self
        mobileNumberTextfield.addDoneBtn()
        mobileNumberTextfield.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        updateNextButtonState()
        
        passwordTextField.delegate = self
        passwordTextField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func backAct(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func eyeButtonAct(_ sender: Any) {
        eyeButton.isSelected.toggle()
        if eyeButton.isSelected {
            passwordTextField.isSecureTextEntry = false
            eyeButton.setImage(UIImage(systemName: "eye"), for: .selected)
        }else{
            passwordTextField.isSecureTextEntry = true
            eyeButton.setImage(UIImage(systemName: "eye.slash"), for: .selected)
        }
    }
    
    @IBAction func forgotPasswordAct(_ sender: Any) {
        
        let mobileNumber = mobileNumberTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let mobileLength = Int(CountryData?.mobilenumberlen ?? "10") ?? 10
        
        guard !mobileNumber.isEmpty else {
            showAlert(title: "", message: "Please enter mobile number")
            return
        }
        
        guard mobileNumber.count == mobileLength else {
            showAlert(title: "", message: "Please enter a valid mobile number")
            return
        }
        
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
                    vc.mobileNumber = mobileNumberTextfield.text
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
    
    @IBAction func loginAct(_ sender: Any) {
        
        // MARK: - Validate Mobile Number
        
        let mobileNumber = mobileNumberTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        let mobileLength = Int(CountryData?.mobilenumberlen ?? "10") ?? 10
        
        guard !mobileNumber.isEmpty else {
            showAlert(title: "", message: "Please enter mobile number")
            return
        }
        
        guard mobileNumber.count == mobileLength else {
            showAlert(title: "", message: "Please enter a valid mobile number")
            return
        }
        
        // MARK: - Validate Password
        
        guard !password.isEmpty else {
            showAlert(title: "", message: "Please enter password")
            return
        }
        
        var login = LoginModal ()
        login.mobilenumber = mobileNumber
        login.Password     = password
        
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
                    
                    defaults.set(mobileNumberTextfield.text, forKey: DefaultsKeys.mobileNumber)
                    defaults.set(passwordTextField.text,forKey: DefaultsKeys.Password)
                    
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
    
    private func showAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    private func updateNextButtonState() {
        let isMobileEmpty = (mobileNumberTextfield.text ?? "").isEmpty
        let isPasswordEmpty = (passwordTextField.text ?? "").isEmpty
        let isEnabled = !isMobileEmpty && !isPasswordEmpty

        loginButton.isEnabled = isEnabled
        if isEnabled {
            loginButton.backgroundColor = UIColor(named: "IndigoColour")
            loginButton.setTitleColor(UIColor.white, for: .normal)
        } else {
            loginButton.backgroundColor = .systemGray5
            loginButton.setTitleColor(UIColor.lightGray, for: .normal)
        }
    }
    
    @objc private func textFieldEditingChanged(_ textField: UITextField) {
        updateNextButtonState()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == mobileNumberTextfield {
            
            let allowedCharacters = CharacterSet.decimalDigits
            
            if string.rangeOfCharacter(from: allowedCharacters.inverted) != nil {
                return false
            }
            
            let currentText = textField.text ?? ""
            
            guard let StringRange = Range(range, in: currentText) else {
                return false
            }
            
            let updatedText = currentText.replacingCharacters(in: StringRange, with: string)
            
            let limit = Int(CountryData?.mobilenumberlen ?? "10") ?? 10
            return updatedText.count <= limit
        }
        
        return true
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        let textFieldBottom = passwordTextField.convert(passwordTextField.bounds, to: self.view).maxY
        let keyboardTop = self.view.frame.height - keyboardFrame.height
       
        if textFieldBottom > keyboardTop {
            let overlap = textFieldBottom - keyboardTop + 8
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
