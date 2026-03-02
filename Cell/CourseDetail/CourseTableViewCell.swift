//
//  CourseTableViewCell.swift
//  CourseDetailsGradit
//
//  Created by MACBOOKPRO on 24/10/22.
//

import UIKit

class CourseTableViewCell: UITableViewCell {
    
    
   
    @IBOutlet weak var lineView: UIView!
    
    @IBOutlet weak var SubjectLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    
    @IBOutlet weak var creditsLabel: UILabel!
    
    
    @IBOutlet weak var codeLabel: UILabel!
    
    
    @IBOutlet weak var requirementLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
