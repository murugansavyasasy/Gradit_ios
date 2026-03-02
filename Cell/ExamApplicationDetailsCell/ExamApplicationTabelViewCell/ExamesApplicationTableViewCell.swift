//
//  ExamesApplicationTableViewCell.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 24/11/22.
//

import UIKit

class ExamesApplicationTableViewCell: UITableViewCell {

    @IBOutlet weak var cellSemNumberLabel: UILabel!
    
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var cellCodeLabel: UILabel!
    
    @IBOutlet weak var cellFeeAmountLabel: UILabel!
    
    
    
    @IBOutlet weak var cellSubjectNameLabel: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
