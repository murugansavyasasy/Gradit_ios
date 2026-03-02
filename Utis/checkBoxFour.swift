//
//  checkBoxFour.swift
//  Vs_GradItCollege
//
//  Created by admin on 19/01/24.
//

import Foundation
import UIKit



class checkBoxFour: UIButton {

    // Images

    let checkedImage = UIImage(named: "radios")!

    let uncheckedImage = UIImage(named: "radio-button")!

    

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

