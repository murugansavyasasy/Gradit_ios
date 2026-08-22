//
//  ReasetPasswordVC.swift
//  Vs_GradItCollege
//
//  Created by Chandhru on 21/08/26.
//

import UIKit

class ReasetPasswordVC: UIViewController {

    @IBOutlet weak var confirmPasswordTxt: UITextField!
    @IBOutlet weak var newPasswordTxt: UITextField!
    @IBOutlet weak var secure1Btn: UIButton!
    @IBOutlet weak var secure2Btn: UIButton!
    @IBOutlet weak var bodyView: UIView!
    @IBOutlet weak var backToLogin: UIButton!
    @IBOutlet weak var resetPassword: UIButton!
    @IBOutlet weak var newPassword: UIView!
    @IBOutlet weak var confirmPassword: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
setBorder(view: newPassword)
setBorder(view: confirmPassword)
        resetPassword.layer.cornerRadius = 10
        bodyView.layer.cornerRadius = 40
        bodyView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    @IBAction func newPassword(_ sender: UIButton) {
        sender.isSelected.toggle()
        newPasswordTxt.isSecureTextEntry = !sender.isSelected
        secure1Btn.setImage(
            sender.isSelected
            ? UIImage(systemName: "eye.fill"): UIImage(systemName: "eye.slash.fill"),
            for: .normal
        )
    }
    @IBAction func confirmPassword(_ sender: UIButton) {
        secure2Btn.isSelected.toggle()
        confirmPasswordTxt.isSecureTextEntry = !sender.isSelected
        secure2Btn.setImage(
            sender.isSelected
            ? UIImage(systemName: "eye.fill")
            : UIImage(systemName: "eye.slash.fill"),
            for: .normal
        )
    }
    @IBAction func back(_ sender: RoundedBackBtn) {
        dismiss(animated: true)
    }
    
    func setBorder(view:UIView){
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
    view.layer.cornerRadius = 10
    }
}
