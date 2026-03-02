//
//  ExameViewResiverTableViewCell.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 31/03/23.
//

import UIKit

class ExameViewResiverTableViewCell: UITableViewCell {

    
    @IBOutlet weak var fulview: UIView!
    
    @IBOutlet weak var markLabel: UILabel!
    
    
    @IBOutlet weak var NameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
