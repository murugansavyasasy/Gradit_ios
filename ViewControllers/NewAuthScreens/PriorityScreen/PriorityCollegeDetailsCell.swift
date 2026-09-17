//
//  PriorityCollegeDetailsCell.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 26/08/26.
//

import UIKit

class PriorityCollegeDetailsCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var collegeLogoBaseView: UIView!
    @IBOutlet weak var collegeLogo: UIImageView!
    @IBOutlet weak var collegeNameLbl: UILabel!
    @IBOutlet weak var collegeAddressLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        cellView.layer.cornerRadius = 10
        cellView.layer.borderWidth = 0.3
        cellView.layer.borderColor = UIColor.systemGray4.cgColor
        
        collegeLogoBaseView.layer.cornerRadius = 10
    }
    
}
