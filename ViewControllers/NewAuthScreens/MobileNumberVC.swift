//
//  MobileNumberVC.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 20/08/26.
//

import UIKit

class MobileNumberVC: UIViewController {

    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var textFieldBaseView: UIView!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        baseView.layer.cornerRadius = 40
        baseView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        textFieldBaseView.layer.cornerRadius = 12
        textFieldBaseView.layer.borderWidth =  2
        textFieldBaseView.layer.borderColor = UIColor.lightGray.cgColor
        
        nextButton.layer.cornerRadius = 10
        
    }

}
