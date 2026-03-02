//
//  MoreImageCCCollectionViewCell.swift
//  Vs_GradItCollege
//
//  Created by admin on 28/02/24.
//

import UIKit

class MoreImageCCCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var fullView: UIViewX!
    @IBOutlet weak var countView: UIViewX!
    @IBOutlet weak var countLabl: UILabel!
    @IBOutlet weak var pdfView: UIViewX!
    @IBOutlet weak var cellwith: NSLayoutConstraint!
    @IBOutlet weak var cellHeight: NSLayoutConstraint!
    @IBOutlet weak var CellmageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        countView.isHidden = true
        
    }

}
