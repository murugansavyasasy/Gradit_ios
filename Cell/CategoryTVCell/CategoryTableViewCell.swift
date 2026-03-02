//
//  CategoryTableViewCell.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 21/02/23.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var cellCategory_name: UILabel!
    
    @IBOutlet weak var cellObtained: UILabel!
    
    @IBOutlet weak var cellto_be_obtained: UILabel!
    
    @IBOutlet weak var cellTotal_credits: UILabel!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}
