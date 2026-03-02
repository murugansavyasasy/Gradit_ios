//
//  SemCreditTableViewCell.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 17/02/23.
//

import UIKit

class SemCreditTableViewCell: UITableViewCell {

    
    @IBOutlet weak var totalCellLabel: UILabel!
    @IBOutlet weak var toBeObtainedCellLabel: UILabel!
    @IBOutlet weak var categoryCellLabel: UILabel!
    
    
    @IBOutlet weak var obtainedCellLabel: UILabel!
    
    
    @IBOutlet weak var semesterCellLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
