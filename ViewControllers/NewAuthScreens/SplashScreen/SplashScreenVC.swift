//
//  SplashScreenVC.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 20/08/26.
//

import UIKit

class SplashScreenVC: UIViewController {
    
    @IBOutlet weak var ellipsisImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        animateEllipsisColor()
    }
    
    func animateEllipsisColor() {
        UIView.animate(withDuration: 1.0,
                       delay: 0,
                       options: [.repeat, .autoreverse],
                       animations: {
            self.ellipsisImage.tintColor = .systemBlue
        }, completion: nil)
    }

}
