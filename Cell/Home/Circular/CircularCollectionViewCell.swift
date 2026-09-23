//
//  CircularCollectionViewCell.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 24/01/23.
//

import UIKit

@available(iOS 16.0, *)
class CircularCollectionViewCell: UICollectionViewCell {
    
    weak var parent:ViewController?
    @IBOutlet weak var CircularFullView: UIViewX!
    @IBOutlet weak var creatDate: UILabel!
    @IBOutlet weak var createTime: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var discreption: UITextView!
    @IBOutlet weak var attachementView: UIViewX!
    override func awakeFromNib() {
        super.awakeFromNib()
        CircularFullView.borderColor = UIColor(red: 190/255, green: 174/255, blue: 255/255, alpha: 0.40)
        CircularFullView.borderWidth = 1
        CircularFullView.cornerRadius = 16
        
    }

}
