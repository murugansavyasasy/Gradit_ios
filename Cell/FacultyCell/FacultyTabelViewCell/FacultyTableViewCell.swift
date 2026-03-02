//
//  FacultyTableViewCell.swift
//  GraditFaculty
//
//  Created by MACBOOKPRO on 09/11/22.
//

import UIKit

class FacultyTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var intractview: UIViewX!
    @IBOutlet weak var lineviw: UIView!
    @IBOutlet weak var subjectDefaultLabel: UILabel!
    @IBOutlet weak var imageProfileView: UIImageView!
    
    @IBOutlet weak var dottLabel: UILabel!
    
    @IBOutlet weak var cellStafName: UILabel!
    
    
    @IBOutlet weak var subjectDefautLbl: UILabel!
    @IBOutlet weak var cellStafType: UILabel!
    

    @IBOutlet weak var cellSubjectName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        cellSubjectName.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
