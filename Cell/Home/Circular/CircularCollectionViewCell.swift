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
    
    @IBOutlet weak var discreption: UILabel!
    
    
    
    @IBOutlet weak var attachementView: UIViewX!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
     
        
    }

}
