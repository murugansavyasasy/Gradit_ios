//
//  ReuseTabController.swift
//  Vs_GradItCollege
//
//  Created by APPLE on 09/11/22.
//

import UIKit
import Foundation
import KRProgressHUD



@available(iOS 16.0, *)
class ReuseTabController  : UIView {
    
    
    @IBOutlet weak var changePasswordView: UIView!
    
    

    @IBOutlet weak var privacyPolicyView: UIView!
    @IBOutlet weak var faqView: UIView!
    @IBOutlet weak var tapView: UIView!
    @IBOutlet weak var refreshView: UIView!
    
    @IBOutlet weak var termsAndConditionView: UIView!
    @IBOutlet weak var helpView: UIView!
    @IBOutlet weak var viewTap: UIView!
    @IBOutlet weak var sideMenuView: UIView!
    @IBOutlet weak var notificationView: UIView!
    
    let nibName = "ReuseTabController"
    let backgroundView = UIView()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
       
        commonInit()
        
        
        let menuGestureHideView = UITapGestureRecognizer(target: self, action: #selector(menuHide))
        tapView.addGestureRecognizer(menuGestureHideView)
        
        let menuGestureHide = UITapGestureRecognizer(target: self, action: #selector(menu))
        viewTap.addGestureRecognizer(menuGestureHide)
        
        let notificationGesture = UITapGestureRecognizer(target: self, action: #selector(notificationVc))
        notificationView.addGestureRecognizer(notificationGesture)
        
        let refreshGesture = UITapGestureRecognizer(target: self, action: #selector(refreshVc))
        refreshView.addGestureRecognizer(refreshGesture)
        
        
                let faqGesture = UITapGestureRecognizer(target: self, action: #selector(faqRedirect))
                faqView.addGestureRecognizer(faqGesture)
     
//        let logoutGesture = UITapGestureRecognizer(target: self, action: #selector(logoutPressed))
        let helpGesture = UITapGestureRecognizer(target: self, action: #selector(helpRedirect))
              helpView.addGestureRecognizer(helpGesture)
      //
        
        let privacyPolicyGesture = UITapGestureRecognizer(target: self, action: #selector(privacyPolicyRedirect))
               privacyPolicyView.addGestureRecognizer(privacyPolicyGesture)
       
               let termsAndConditionGesture = UITapGestureRecognizer(target: self, action: #selector(termsAndCondition))
               termsAndConditionView.addGestureRecognizer(termsAndConditionGesture)
               
              
//               let profileGesture = UITapGestureRecognizer(target: self, action: #selector(profileRedirect))
        
        
        let chagePassword = UITapGestureRecognizer(target: self, action: #selector(changePassowrdVC))
        changePasswordView.addGestureRecognizer(chagePassword)
        
        
        sideMenuView.isHidden = true
    
    }
    @IBAction func helpRedirect() {
        
        let vc = HelpViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        let currentController = self.getCurrentViewController()
        currentController?.present(vc, animated: true, completion: nil)
        
        
    }
    
    
    @IBAction func termsAndCondition() {
        
        let vc = MenuTermsViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        let currentController = self.getCurrentViewController()
        currentController?.present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func logoutPressed() {
        
        
        _ =  SweetAlert().showAlert(" Are you sure do you want to logout ",subTitle: "",style: .none,buttonTitle: "NO",buttonColor:.systemGray,otherButtonTitle: "YES",otherButtonColor: .systemGray){
            is_yes_click in
            if is_yes_click {
                print("pressed no button")
            }else{
                
                UserDefaults.standard.removeObject(forKey: DefaultsKeys.mobileNumber)
                
                let vc = LoginNewViewController(nibName: nil, bundle: nil)
                vc.modalPresentationStyle = .fullScreen
                let currentController = self.getCurrentViewController()
                currentController?.present(vc, animated: true, completion: nil)
            }
        }
        
        
    }
    
    
    @IBAction func faqRedirect() {
        print("faqRedirect")
        let vc = FaqViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        let currentController = self.getCurrentViewController()
        currentController?.present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func privacyPolicyRedirect() {
        
        let vc = PrivacyPolicyViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        let currentController = self.getCurrentViewController()
        currentController?.present(vc, animated: true, completion: nil)
        
    }
    
    
    @IBAction func menu() {
        
        sideMenuView.isHidden = false
        
        backgroundView.isUserInteractionEnabled = false
        print("menuVisble")
    }
    

    @IBAction func menuHide() {
        
        
        sideMenuView.isHidden = true
        backgroundView.isUserInteractionEnabled = true
    }
    
    
    @IBAction func refreshVc() {
        
        print("refreshVcWork")
        KRProgressHUD.show()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
//            self.tv.reloadData()
            
            
            KRProgressHUD.dismiss()
            
        }
        
        
    }
    
    
    @IBAction func notificationVc() {
        print("NotificationViewController")
        let vc = NotificationViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        let currentController = self.getCurrentViewController()
        currentController?.present(vc, animated: false, completion: nil)

//        vc.modalPresentationStyle = .fullScreen
        
    }
    
    
    
    
    func getCurrentViewController() -> UIViewController? {

        if let rootController = UIApplication.shared.keyWindow?.rootViewController {
            var currentController: UIViewController! = rootController
           
            while( currentController.presentedViewController != nil ) {
                currentController = currentController.presentedViewController
               
            }
            return currentController
        }
        return nil

    }
    
    
    
    
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }


    func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }

    
    @IBAction func changePassowrdVC(){
        
        let vc = ChangePasswordViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        let currentController = self.getCurrentViewController()
        currentController?.present(vc, animated: true, completion: nil)
        
//        present(vc, animated: false, completion: nil)
        
        
        
    }

}
