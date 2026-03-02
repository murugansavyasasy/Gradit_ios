//
//  MenuCollectionViewCell.swift
//  Vs_GradItCollege
//
//  Created by APPLE on 04/11/22.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var mainView: UIViewX!
    @IBOutlet weak var menuNameLbl: UILabel!
    
    
    @IBOutlet weak var menuImg: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        mainView.translatesAutoresizingMaskIntoConstraints = false
              mainView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width - 40).isActive = true
          
      }

    }
    


