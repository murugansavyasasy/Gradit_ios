//
//  SenderImagePdfTableViewCell.swift
//  GraditImagePdf
//
//  Created by MACBOOKPRO on 07/12/22.
//

import UIKit

class SenderImagePdfTableViewCell: UITableViewCell {

    @IBOutlet weak var sendByCellLabel: UILabel!
    @IBOutlet weak var imageCellTitelLabel: UILabel!
    
    @IBOutlet weak var imageCellTimeLabel: UILabel!
    
    @IBOutlet weak var sndByView: UIViewX!
    @IBOutlet weak var viewTap: UIViewX!
    
    @IBOutlet weak var plusoneLabel: UILabel!
    
    @IBOutlet weak var sendByDefaultLabel: UILabel!
    @IBOutlet weak var imageCellDateLabel: UILabel!
    
    @IBOutlet weak var imageCellDescripitionLabel: UILabel!
    
    @IBOutlet weak var sendbyViewwidth: NSLayoutConstraint!
    @IBOutlet weak var fileAtchNamelabl: UILabel!
    
    @IBOutlet weak var upArrowssImages: UIImageView!
    
    
    
    @IBOutlet weak var countImageView: UIViewX!
    

    
    
    @IBOutlet weak var redDotImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageCellDescripitionLabel.isHidden = true
        redDotImageView.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}
