//
//  OptionsSheetView.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 02/06/25.
//

import UIKit

class OptionsSheetView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var changeRoleBtn: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        Bundle.main.loadNibNamed("OptionsSheetView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

    @IBAction func ChangeRoleAct(_ sender: Any) {
        print("TopBar button tapped")
        if let parentVC = self.findViewController() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let newVC = storyboard.instantiateViewController(withIdentifier: "ResumeVC") as? ResumeVC {
                newVC.modalPresentationStyle = .fullScreen
                parentVC.present(newVC, animated: true)
            }
        }
    }

    // Other actions remain as-is...

    
    @IBAction func FaqAct(_ sender: Any) {
        
        
    }
    
    
//    @IBAction func HelpAct(_ sender: Any) {
//    }
//    
//    @IBAction func PrivacyPolicyAct(_ sender: Any) {
//    }
//    
//    @IBAction func TermsAct(_ sender: Any) {
//    }
//    
//    @IBAction func changePasswordAct(_ sender: Any) {
//    }
//    @IBAction func LogoutAct(_ sender: Any) {
//    }
//    
//    @IBAction func BuildResumeAct(_ sender: Any) {
//    }
    
}
