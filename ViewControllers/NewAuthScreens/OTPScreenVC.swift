//
//  OTPScreenVC.swift
//  Vs_GradItCollege
//
//  Created by Chandhru on 21/08/26.
//

import UIKit

class OTPScreenVC: UIViewController, OTPFieldViewDelegate {
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
    }
    
    func enteredOTP(otp: String) {
        self.otp = otp
    }
    
    func hasEnteredAllOTP(hasEnteredAll: Bool) -> Bool {
        return false
    }
    
    @IBOutlet weak var verifyBtn: UIButton!
    @IBOutlet weak var bodyView: UIView!
    @IBOutlet weak var displayNumberLbl: UILabel!
    @IBOutlet weak var resendLbl: UILabel!
    @IBOutlet weak var OtpView: OTPFieldView!
    var otp: String?
    var mobileNumber: String? = "9597296169"
    var timer:Timer?
    var duration:Int = 60
    override func viewDidLoad() {
        super.viewDidLoad()
        bodyView.layer.cornerRadius = 40
        bodyView.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner
        ]
        verifyBtn.layer.cornerRadius = 10
        displayNumberLbl.text = "Enter the verification Code send to (+91 \(mobileNumber ?? ""))to Rest your Password"
        timer?.invalidate()
        updateTimer()
        resendLbl.isUserInteractionEnabled = false

            let tapGesture = UITapGestureRecognizer(
                target: self,
                action: #selector(resendOTP)
            )

        resendLbl.addGestureRecognizer(tapGesture)
    }
    @objc func resendOTP() {
        duration = 30
        updateTimer()
    }
    @IBAction func verifyBtn(_ sender: Any) {
        let vc = ReasetPasswordVC()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
        
//        var verify = recentOTPModal()
//        
//        verify.mobilenumber = mobileNumber
//        verify.otp = otp
//        APiCallManager.shared.callApi(
//            url: APIEndpoints.VerifyOTP,
//            httpMethod: .post,
//            queryParam: nil,
//            requestBody: verify
//        ) { [weak self] (result: Result<recentOTPResponce, Error>) in
//            
//            guard let self = self else { return }
//            
//            switch result {
//                
//            case .success(let forgetResponse):
//                
//                if forgetResponse.Status == 1 {
//                    
////                    let vc = VerifyOtpViewController(nibName: nil, bundle: nil)
////                    vc.mobileNumber = ShowPhnumber
////                    vc.modalPresentationStyle = .fullScreen
////                    present(vc, animated: true,completion: nil)
//                    
//                }else {
//                    
//                    let refreshAlert = UIAlertController(title: "", message: forgetResponse.Message, preferredStyle: UIAlertController.Style.alert)
//                    
//                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
//                        
//                    }))
//                    
//                    self.present(refreshAlert, animated: true, completion: nil)
//                }
//                
//            case .failure(let error):
//                let refreshAlert = UIAlertController(title: "", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
//                
//                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
//                    
//                }))
//                
//                self.present(refreshAlert, animated: true, completion: nil)
//                print(error.localizedDescription)
//            }
//        }
    }
    func updateTimer(){
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            let minutes = self.duration / 60
                  let seconds = self.duration % 60

            let remining = String(format: "%02d:%02d", minutes, seconds)
            self.resendLbl.text = "Resend OTP in \(remining)"
            self.duration -= 1
            if self.duration == 0 {
                self.timer?.invalidate()
                self.resendLbl.text = "Resend"
                resendLbl.isUserInteractionEnabled = true
            }
        }
    }
    func setupOtp() {
        OtpView.fieldsCount = 6
        OtpView.fieldBorderWidth = 1
        OtpView.defaultBorderColor = UIColor.gray
        OtpView.filledBorderColor = UIColor.blue
        OtpView.displayType = .roundedCorner
        OtpView.separatorSpace = 8
        OtpView.shouldAllowIntermediateEditing = false
        OtpView.delegate = self
        OtpView.cursorColor = UIColor.gray
        OtpView.initializeUI()
    }

}


@IBDesignable
class GradientHeaderView: UIView {
    
    @IBInspectable var gradientStartColor: UIColor = UIColor(red:160/255, green: 193/255, blue: 253/255, alpha: 1.0)
    @IBInspectable var gradientMidColor: UIColor = UIColor(red: 138/255, green: 166/255, blue: 252/255, alpha: 1.0)
    @IBInspectable var gradientEndColor: UIColor = UIColor(red: 155/255, green: 207/255, blue:253/255, alpha: 1.0)
    
    private let gradientLayer = CAGradientLayer()
        
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    private func setupView() {
        setupGradient()
    }
    
    private func setupGradient() {
        gradientLayer.colors = [
            gradientStartColor.cgColor,
            gradientMidColor.cgColor,
            gradientEndColor.cgColor
        ]
        // Diagonal direction similar to the screenshot
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.6)
        gradientLayer.locations = [0.0, 0.5, 1.0]
        layer.insertSublayer(gradientLayer, at: 0)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}
