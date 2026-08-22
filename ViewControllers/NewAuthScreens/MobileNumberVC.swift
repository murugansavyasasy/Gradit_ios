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
    
    private var CountryData : CountryData?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        baseView.layer.cornerRadius = 40
        baseView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        if let data = UserDefaults.standard.data(forKey: DefaultsKeys.CountryId),
           let country = try? JSONDecoder().decode(Gradit.CountryData.self, from: data){
            CountryData = country
        }
        
        textFieldBaseView.layer.cornerRadius = 12
        textFieldBaseView.layer.borderWidth =  1
        textFieldBaseView.layer.borderColor = UIColor.lightGray.cgColor
        
        nextButton.layer.cornerRadius = 10
        
        mobileNumberTextField.delegate = self
        mobileNumberTextField.addDoneBtn()
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
                        
                        let vc = EnterOtpViewController(nibName: nil, bundle: nil)
                        vc.phnNumber = loginResponse?.first?.resultmessage
                        vc.resiveMsg = loginResponse?.first?.ivrnumbers ?? []
                        vc.ShowPhnumber = mobileNumberTextField.text
                        vc.modalPresentationStyle = .fullScreen
                        present(vc, animated: true,completion: nil)
                    }else {
                        let vc = LoginViewController(nibName: nil, bundle: nil)
                        vc.mobile_num = mobileNumberTextField.text
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
            
            let refreshAlert = UIAlertController(title: "", message: "Please Enter a valid a mobile number", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            }))
        }else {
            verifyMobileNumber()
        }
    }
}
