//
//  chatResTableViewCell.swift
//  Vs_GradItCollege
//
//  Created by admin on 04/04/24.
//

import UIKit

class chatResTableViewCell: UITableViewCell {

    
    @IBOutlet weak var timeAndDateLbl: UILabel!
    @IBOutlet weak var messageContentLbl: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
