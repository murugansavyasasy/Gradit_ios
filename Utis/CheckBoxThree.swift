//
//  CheckBoxThree.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 17/07/23.
//


import Foundation
import Foundation



import UIKit



class CheckBoxThree: UIButton {

    // Images

    let checkedImage = UIImage(named: "verified")!

    let uncheckedImage = UIImage(named: "Verify")!

    

    // Bool property

    var isChecked: Bool = false {

        didSet {

            if isChecked == true {

                self.setImage(checkedImage, for: UIControl.State.normal)


            } else {

                self.setImage(uncheckedImage, for: UIControl.State.normal)


            }

        }

    }

        

    override func awakeFromNib() {

        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)

        self.isChecked = false

    }

        

    @objc func buttonClicked(sender: UIButton) {

        if sender == self {

            isChecked = !isChecked

        }

    }

}

