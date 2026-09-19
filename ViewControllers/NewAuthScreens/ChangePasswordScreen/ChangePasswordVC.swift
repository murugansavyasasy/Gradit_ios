//
//  ChangePasswordVC.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 27/08/26.
//

import UIKit

@available(iOS 16.0, *)
class ChangePasswordVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var confirmPasswordTxt: UITextField!
    @IBOutlet weak var newPasswordTxt: UITextField!
    @IBOutlet weak var oldPasswordTxt: UITextField!
    @IBOutlet weak var secure1Btn: UIButton!
    @IBOutlet weak var secure2Btn: UIButton!
    @IBOutlet weak var secure3Btn: UIButton!
    @IBOutlet weak var bodyView: UIView!
    @IBOutlet weak var resetPassword: UIButton!
    @IBOutlet weak var oldPassword: UIView!
    @IBOutlet weak var newPassword: UIView!
    @IBOutlet weak var confirmPassword: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setBorder(view: oldPassword)
        setBorder(view: newPassword)
        setBorder(view: confirmPassword)
        resetPassword.layer.cornerRadius = 10
        
        
        oldPasswordTxt.delegate = self
        newPasswordTxt.delegate = self
        confirmPasswordTxt.delegate = self
        
        oldPasswordTxt.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        newPasswordTxt.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        confirmPasswordTxt.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        updateNextButtonState()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
    
    func setBorder(view:UIView){
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.cornerRadius = 10
        view.backgroundColor = .systemGray6.withAlphaComponent(0.5)
    }
    
    func showAlert(message:String){
        
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    
    @IBAction func resetBtnAct(_ sender: Any) {
        
        let oldPassword = oldPasswordTxt.text ?? ""
        let newPassword = newPasswordTxt.text ?? ""
        let confirmPassword = confirmPasswordTxt.text ?? ""
        
        if oldPassword.isEmpty {
            showAlert(message: "Please enter old password")
        }else if newPassword.isEmpty{
            showAlert(message: "Please enter new password")
        }else if confirmPassword.isEmpty {
            showAlert(message: "Please enter confirm password")
        }else if newPassword != confirmPassword {
            showAlert(message: "Password and confirm password does not match")
        }else {
            changePassword_Api()
        }
    }
    
    func changePassword_Api() {
        
        let mobileNumber = UserDefaults.standard.string(forKey: DefaultsKeys.mobileNumber)
        
        var changePassword = changePasswordModal()
        
        changePassword.mobilenumber = mobileNumber
        changePassword.oldpassword = oldPasswordTxt.text
        changePassword.newpassword = newPasswordTxt.text
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.changepassword,
            httpMethod: .post,
            queryParam: nil,
            requestBody: changePassword
        ) { [weak self] (result: Result<changePasswordResponse, Error>) in
            
            guard let self = self else { return }
            
            switch result {
                
            case .success(let changePassRess):
                
                let refreshAlert = UIAlertController(title: "", message: changePassRess.Message , preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    
                    let defaults = UserDefaults.standard
                    defaults.set(mobileNumber, forKey: DefaultsKeys.mobileNumber)
                    defaults.set(self.newPasswordTxt.text,forKey: DefaultsKeys.Password)
                    
                    if changePassRess.Status == 1 {
                        let vc =  LoginVc()
                        vc.mobileNumber = mobileNumber
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true)
                    }
                    
                }))
                
                self.present(refreshAlert, animated: true, completion: nil)
                
            case .failure(let error):
                showAlert(message: error.localizedDescription)
            }
        }
    }
    
    @IBAction func SecureOldPassword(_ sender: UIButton) {
        sender.isSelected.toggle()
        oldPasswordTxt.isSecureTextEntry = !sender.isSelected
        secure1Btn.setImage(
            sender.isSelected
            ? UIImage(systemName: "eye"): UIImage(systemName: "eye.slash"),
            for: .normal
        )
    }
    
    @IBAction func SecureNewPassword(_ sender: UIButton) {
        sender.isSelected.toggle()
        newPasswordTxt.isSecureTextEntry = !sender.isSelected
        secure2Btn.setImage(
            sender.isSelected
            ? UIImage(systemName: "eye"): UIImage(systemName: "eye.slash"),
            for: .normal
        )
    }
    
    @IBAction func SecureConfirmPassword(_ sender: UIButton) {
        secure3Btn.isSelected.toggle()
        confirmPasswordTxt.isSecureTextEntry = !sender.isSelected
        secure3Btn.setImage(
            sender.isSelected
            ? UIImage(systemName: "eye")
            : UIImage(systemName: "eye.slash"),
            for: .normal
        )
    }
    
    @IBAction func back(_ sender: RoundedBackBtn) {
        dismiss(animated: true)
    }
    
    private func updateNextButtonState() {
        let isOldPasswordEmpty = (oldPasswordTxt.text ?? "").isEmpty
        let isNewPasswordEmpty = (newPasswordTxt.text ?? "").isEmpty
        let isConfirmPasswordEmpty = (confirmPasswordTxt.text ?? "").isEmpty
        let isEnabled = !isOldPasswordEmpty && !isNewPasswordEmpty && !isConfirmPasswordEmpty

        resetPassword.isEnabled = isEnabled
        if isEnabled {
            resetPassword.backgroundColor = UIColor(named: "IndigoColour")
            resetPassword.setTitleColor(UIColor.white, for: .normal)
        } else {
            resetPassword.backgroundColor = .systemGray5
            resetPassword.setTitleColor(UIColor.lightGray, for: .normal)
        }
    }
    
    @objc private func textFieldEditingChanged(_ textField: UITextField) {
        updateNextButtonState()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        guard let activeTextfield = [oldPasswordTxt, newPasswordTxt, confirmPasswordTxt]
            .first(where: { $0.isFirstResponder }) else {
            return
        }
        
        let textFieldBottom = activeTextfield.convert(activeTextfield.bounds, to: self.view).maxY
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
