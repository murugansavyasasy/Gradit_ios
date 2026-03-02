//
//  AssigmentAttechmentTableViewCell.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 06/04/23.
//

import UIKit

class AssigmentAttechmentTableViewCell: UITableViewCell {

    
    @IBOutlet weak var fileImage: UIView!
    @IBOutlet weak var lineView: UIView!
    
    @IBOutlet weak var imageViewClick: UIImageView!
    
    @IBOutlet weak var CellClickView: UIViewX!
    
    @IBOutlet weak var discreptionsLabel: UILabel!
    
    
    @IBOutlet weak var FileNameLabel: UILabel!
    
    @IBOutlet weak var DateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
