//
//  MobileNumberVC.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 20/08/26.
//

import UIKit

@available(iOS 16.0, *)
class MobileNumberVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var textFieldBaseView: UIView!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    @IBOutlet weak var countryCodeLbl: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backBtn: RoundedBackBtn!
    
    private var CountryData : CountryData?
    var HideBackBtn: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backBtn.isHidden = HideBackBtn
        
        if let data = UserDefaults.standard.data(forKey: DefaultsKeys.SelectedCountry),
           let country = try? JSONDecoder().decode(Gradit.CountryData.self, from: data){
            CountryData = country
        }
        
        countryCodeLbl.text = "+\(CountryData?.codecountry ?? "91")"
        
        textFieldBaseView.layer.cornerRadius = 12
        textFieldBaseView.layer.borderWidth =  1
        textFieldBaseView.layer.borderColor = UIColor.lightGray.cgColor
        textFieldBaseView.backgroundColor = .systemGray6.withAlphaComponent(0.5)
        
        nextButton.layer.cornerRadius = 10

        mobileNumberTextField.delegate = self
        mobileNumberTextField.addDoneBtn()
        mobileNumberTextField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        updateNextButtonState()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func updateNextButtonState() {
        let isEmpty = (mobileNumberTextField.text ?? "").isEmpty
        if isEmpty {
            nextButton.backgroundColor = .systemGray5
            nextButton.setTitleColor(UIColor.lightGray, for: .normal)
        } else {
            nextButton.backgroundColor = UIColor(named: "IndigoColour")
            nextButton.setTitleColor(UIColor.white, for: .normal)
        }
    }
    
    @objc private func textFieldEditingChanged(_ textField: UITextField) {
        updateNextButtonState()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
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
    
    func verifyMobileNumber() {
        
        let log = loginNewModal(mobile_number: mobileNumberTextField.text)
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.ValidateMobileNumber,
            httpMethod: .post,
            queryParam: nil,
            requestBody: log
        ) { [weak self] (result:Result<loginNewResponse,Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let success):
                if success.Status == 1 {
                    
                    let loginResponse = success.data
                    
                    
                    if loginResponse?.first?.is_redirect_otp_screen == 1 {
                        
                        let vc = OTPScreenVC(nibName: nil, bundle: nil)
                        vc.NotReceivedMessage = loginResponse?.first?.resultmessage
                        vc.IVR_numbers = loginResponse?.first?.ivrnumbers ?? []
                        vc.mobileNumber = mobileNumberTextField.text
                        vc.modalPresentationStyle = .fullScreen
                        present(vc, animated: true,completion: nil)
                    }else {
                        let vc = PasswordVC(nibName: nil, bundle: nil)
                        vc.mobileNumber = mobileNumberTextField.text
                        vc.modalPresentationStyle = .fullScreen
                        present(vc, animated: true,completion: nil)
                    }
                }else {
                    
                    let refreshAlert = UIAlertController(title: "", message: success.Message , preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    }))
                    
                    present(refreshAlert, animated: true, completion: nil)
                }
                
            case .failure(let failure):
                let refreshAlert = UIAlertController(title: "", message: failure.localizedDescription , preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                }))
                
                present(refreshAlert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func backAct(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    @IBAction func nextBtnAct(_ sender: Any) {
        
        let length = Int(CountryData?.mobilenumberlen ?? "10") ?? 10
        let text = mobileNumberTextField.text?.count ?? 0
        
        if text < length {
            
            let refreshAlert = UIAlertController(title: "", message: "Please Enter a valid mobile number", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            }))
            
            present(refreshAlert, animated: true)
        }else {
            verifyMobileNumber()
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        let textFieldBottom = mobileNumberTextField.convert(mobileNumberTextField.bounds, to: self.view).maxY
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
