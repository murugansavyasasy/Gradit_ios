//
//  ColoursCvCell.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 30/05/25.
//

import UIKit

class ColoursCvCell: UICollectionViewCell {

    @IBOutlet weak var CellView: UIView!
    @IBOutlet weak var Button: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        Button.layer.cornerRadius = CellView.frame.width / 2
        
        Button.layer.borderWidth = 3
        Button.layer.borderColor = UIColor.clear.cgColor
        
    }

}
