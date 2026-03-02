//
//  SelectRespienceCellTableViewCell.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 04/03/23.
//

import UIKit

class SelectRespienceCellTableViewCell: UITableViewCell {

    
    @IBOutlet weak var checkboxess: CheckBoxTwo!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}
