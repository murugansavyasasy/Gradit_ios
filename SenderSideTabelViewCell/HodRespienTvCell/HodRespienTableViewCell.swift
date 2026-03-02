//
//  HodRespienTableViewCell.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 13/03/23.
//

import UIKit

class HodRespienTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var CellFullView: UIViewX!
    @IBOutlet weak var checkBoxView: CheckBoxTwo!
    @IBOutlet weak var SubjectNameLabel: UILabel!
    @IBOutlet weak var SecLabel: UILabel!
    @IBOutlet weak var SemesterLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var CheckImageView: UIImageView!
    
    @IBOutlet weak var checkImageTop: NSLayoutConstraint!
    @IBOutlet weak var courseNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
