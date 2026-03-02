//
//  NotSubmitTableViewCell.swift
//  Vs_GradItCollege
//
//  Created by admin on 04/03/24.
//

import UIKit

class NotSubmitTableViewCell: UITableViewCell {

    @IBOutlet weak var serilNom: UILabel!
    @IBOutlet weak var yearLbl: UILabel!
    @IBOutlet weak var courseLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var regNumber: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
