//
//  PriorityTableViewCell.swift
//  Vs_GradItCollege
//
//  Created by APPLE on 27/10/22.
//

import UIKit

class PriorityTableViewCell: UITableViewCell {

   
    @IBOutlet weak var clgNameLabl: UILabel!
    @IBOutlet weak var StudentLabl: UILabel!
    @IBOutlet weak var clgLogoImg: UIImageView!
   
    @IBOutlet weak var DepartmentLabl: UILabel!
    
    @IBOutlet weak var SectionLbl: UILabel!
    @IBOutlet weak var YearANdSemeLbl: UILabel!
    
    @IBOutlet weak var CoureLabl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
