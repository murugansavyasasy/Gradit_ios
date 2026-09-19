//
//  ReasetPasswordVC.swift
//  Vs_GradItCollege
//
//  Created by Chandhru on 21/08/26.
//

import UIKit

@available(iOS 16.0, *)
class ReasetPasswordVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var confirmPasswordTxt: UITextField!
    @IBOutlet weak var newPasswordTxt: UITextField!
    @IBOutlet weak var secure1Btn: UIButton!
    @IBOutlet weak var secure2Btn: UIButton!
    @IBOutlet weak var bodyView: UIView!
    @IBOutlet weak var backToLogin: UIButton!
    @IBOutlet weak var resetPassword: UIButton!
    @IBOutlet weak var newPassword: UIView!
    @IBOutlet weak var confirmPassword: UIView!
    
    var mobileNumber : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backToLogin.isHidden = true
        setBorder(view: newPassword)
        setBorder(view: confirmPassword)
        resetPassword.layer.cornerRadius = 10
        newPassword.backgroundColor = .systemGray6.withAlphaComponent(0.5)
        confirmPassword.backgroundColor = .systemGray6.withAlphaComponent(0.5)
        
        newPasswordTxt.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        confirmPasswordTxt.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        updateNextButtonState()
        
        newPasswordTxt.delegate = self
        confirmPasswordTxt.delegate = self
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
    }
    
    func showAlert(message:String){
        
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    func ResetPassword(){
        
        var verify = confirmPasswordModal()
        
        verify.mobilenumber = mobileNumber
        verify.newpassword = confirmPasswordTxt.text
        
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
                        
                        let vc = LoginVc(nibName: nil, bundle: nil)
                        vc.mobileNumber = mobileNumber
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true)
                    }))
                    
                    present(refreshAlert, animated: true, completion: nil)
                    
                }else{
                    
                    showAlert(message: success.Message ?? "")
                }
            case .failure(let failure):
                
                showAlert(message: failure.localizedDescription)
            }
        }
    }
    
    
    @IBAction func resetBtnAct(_ sender: Any) {
        
        let password = newPasswordTxt.text ?? ""
        let confirmPassword = confirmPasswordTxt.text ?? ""
        
        if password.isEmpty {
            showAlert(message: "Please enter new password")
        }else if confirmPassword.isEmpty {
            showAlert(message: "Please enter confirm password")
        }else if password != confirmPassword {
            showAlert(message: "New password and confirm password does not match")
        }else {
            ResetPassword()
        }
    }
    
    @IBAction func newPassword(_ sender: UIButton) {
        sender.isSelected.toggle()
        newPasswordTxt.isSecureTextEntry = !sender.isSelected
        secure1Btn.setImage(
            sender.isSelected
            ? UIImage(systemName: "eye"): UIImage(systemName: "eye.slash"),
            for: .normal
        )
    }
    
    @IBAction func confirmPassword(_ sender: UIButton) {
        secure2Btn.isSelected.toggle()
        confirmPasswordTxt.isSecureTextEntry = !sender.isSelected
        secure2Btn.setImage(
            sender.isSelected
            ? UIImage(systemName: "eye")
            : UIImage(systemName: "eye.slash"),
            for: .normal
        )
    }
    
    @IBAction func back(_ sender: RoundedBackBtn) {
        dismiss(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    private func updateNextButtonState() {
        let isNewaPasswordEmpty = (newPasswordTxt.text ?? "").isEmpty
        let isConfirmPasswordEmpty = (confirmPasswordTxt.text ?? "").isEmpty
        let isEnabled = !isNewaPasswordEmpty && !isConfirmPasswordEmpty

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
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        guard let activeTextfield = [newPasswordTxt, confirmPasswordTxt]
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
