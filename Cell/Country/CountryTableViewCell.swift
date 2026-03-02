//
//  CountryTableViewCell.swift
//  GraditLoginApp
//
//  Created by MACBOOKPRO on 16/10/22.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var cellPhnLable: UILabel!
    
    
    @IBOutlet weak var cellPhnNumberLable: UILabel!
    
    @IBOutlet weak var checkView: CheckBox!
    
    
    @IBOutlet weak var countryCellView: UIViewX!
    override func awakeFromNib() {
        super.awakeFromNib()
       
        countryCellView.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
        
    }
    
}
