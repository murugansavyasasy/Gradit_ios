//
//  OTPScreenVC.swift
//  Vs_GradItCollege
//
//  Created by Chandhru on 21/08/26.
//

import UIKit

@available(iOS 16.0, *)
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
    @IBOutlet weak var callusLbl: UILabel!
    @IBOutlet weak var ivrStack: UIStackView!
    
    var otp: String?
    var mobileNumber: String?
    var timer:Timer?
    var duration:Int = 30
    var IVR_numbers: [String] = []
    var NotReceivedMessage: String?
    private var CountryData : CountryData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupOtp()
        verifyBtn.layer.cornerRadius = 10
        let maskedNumber = MaskMobileNumber()
        
        if let data = UserDefaults.standard.data(forKey: DefaultsKeys.SelectedCountry),
           let country = try? JSONDecoder().decode(Gradit.CountryData.self, from: data){
            CountryData = country
        }
        
       let countryCode = "+\(CountryData?.codecountry ?? "91")"
        
        displayNumberLbl.text = "We have sent a 4-digit verification code to (\(countryCode) \(maskedNumber))"
        resendLbl.text = "Resend OTP in 00:30"
        timer?.invalidate()
        updateTimer()
        resendLbl.isUserInteractionEnabled = false

        let tapGesture = UITapGestureRecognizer(
                target: self,
                action: #selector(resendOTP)
            )
        resendLbl.addGestureRecognizer(tapGesture)
        
        callusLbl.text = NotReceivedMessage
        
        ivrStack.arrangedSubviews.forEach({$0.removeFromSuperview()})
        for i in IVR_numbers {
            
            let button = UIButton(type: .system)
            button.setTitle(i, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
            button.setTitleColor(.systemBlue, for: .normal)
            if let image = UIImage(systemName: "phone.fill") {
                let resizedImage = image.withConfiguration(
                    UIImage.SymbolConfiguration(pointSize: 14, weight: .regular)
                )
                button.setImage(resizedImage, for: .normal)
                button.imageView?.contentMode = .scaleAspectFit
            }
            button.tintColor = .black
            button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
            button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: -5)
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 5)
            button.addTarget(self, action: #selector(call), for: .touchUpInside)
            ivrStack.addArrangedSubview(button)
        }
    }
    
    @IBAction func call(sender: UIButton) {
        if let number = sender.currentTitle {
            let cleanedNumber = number.replacingOccurrences(of: " ", with: "")
            if let url = URL(string: "tel://\(cleanedNumber)"),
               UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }

    
 //   func setup_CallusLbl() {
        
//        let fullText = "If you didn't receive OTP through SMS or mail, Please ☎️ Call us"
//        let callusText = "☎️ Call us"
//        
//        let attributedString = NSMutableAttributedString(string: fullText)
//        let range = (fullText as NSString).range(of: callusText)
//        attributedString.addAttributes([.foregroundColor: UIColor.systemBlue, .underlineStyle : NSUnderlineStyle.byWord.rawValue], range: range)
//        
//        callusLbl.attributedText = attributedString
        
     //   callusLbl.text = NotReceivedMessage
        
  //  }
    
    @objc func resendOTP() {
        Resend_OTP()
        duration = 30
        updateTimer()
        resendLbl.isUserInteractionEnabled = false
    }
    
    func MaskMobileNumber() -> String {
        let count = mobileNumber?.count ?? 0
        let suffix = mobileNumber?.suffix(3) ?? ""
        guard count > 3 else { return mobileNumber ?? "" }
        let masked = String(repeating: "*", count: count - 3) + suffix
        return masked
    }
    
    @IBAction func verifyBtn(_ sender: Any) {
        
        let vc = ReasetPasswordVC(nibName: nil, bundle: nil)
        vc.mobileNumber = mobileNumber
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
        return
        
        guard let otp = otp, !otp.isEmpty else {
            let alert = UIAlertController(
                title: "",
                message: "Please enter OTP",
                preferredStyle: .alert
            )

            let action = UIAlertAction(title: "OK", style: .default)
            alert.addAction(action)

            present(alert, animated: true)
            return
        }
        
        var verify = recentOTPModal()
        
        verify.mobilenumber = mobileNumber
        verify.otp = otp
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
                    
                    let vc = ReasetPasswordVC(nibName: nil, bundle: nil)
                    vc.mobileNumber = mobileNumber
                    vc.modalPresentationStyle = .fullScreen
                    present(vc, animated: true,completion: nil)
                    
                }else {
                    
                    let refreshAlert = UIAlertController(title: "", message: forgetResponse.Message, preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        
                    }))
                    
                    self.present(refreshAlert, animated: true, completion: nil)
                }
                
            case .failure(let error):
                let refreshAlert = UIAlertController(title: "", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    
                }))
                
                self.present(refreshAlert, animated: true, completion: nil)
                print(error.localizedDescription)
            }
        }
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
                self.resendLbl.text = "Resend OTP"
                resendLbl.isUserInteractionEnabled = true
            }
        }
    }
    
    func Resend_OTP(){
        
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
                print(forgetResponse.Message ?? "")
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func setupOtp() {
        OtpView.fieldsCount = 4
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

    @IBAction func backAct(_ sender: Any) {
        dismiss(animated: true)
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
