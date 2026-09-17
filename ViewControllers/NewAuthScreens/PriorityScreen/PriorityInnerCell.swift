//
//  PriorityInnerCell.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 25/08/26.
//

import UIKit

class PriorityInnerCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var firstLetterBaseview: UIView!
    @IBOutlet weak var FirstLetterLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var detailsLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellView.layer.cornerRadius = 10
        cellView.layer.borderWidth = 0.7
        cellView.layer.borderColor = UIColor.lightGray.cgColor
        
        firstLetterBaseview.layer.cornerRadius = firstLetterBaseview.frame.height/2
        
        cellView.backgroundColor = UIColor.systemGray6.withAlphaComponent(0.4)
        
    }

}
