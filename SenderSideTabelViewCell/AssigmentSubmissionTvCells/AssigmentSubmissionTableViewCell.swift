//
//  AssigmentSubmissionTableViewCell.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 06/04/23.
//

import UIKit

class AssigmentSubmissionTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var submisionLabel: UILabel!
    @IBOutlet weak var courseNameLabel: UILabel!
    
    
    @IBOutlet weak var attechmentView: UIViewX!
    @IBOutlet weak var StudentLabel: UILabel!
    
    
    @IBOutlet weak var YearLabel: UILabel!
    
    
    @IBOutlet weak var semesterLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
