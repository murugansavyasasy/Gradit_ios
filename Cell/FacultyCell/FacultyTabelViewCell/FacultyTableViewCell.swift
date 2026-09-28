//
//  FacultyTableViewCell.swift
//  GraditFaculty
//
//  Created by MACBOOKPRO on 09/11/22.
//

import UIKit

class FacultyTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var subjectStack: UIStackView!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var imageBaseView: UIView!
    @IBOutlet weak var intractview: UIViewX!
    @IBOutlet weak var imageProfileView: UIImageView!
    @IBOutlet weak var cellStafName: UILabel!
    @IBOutlet weak var subjectDefautLbl: UILabel!
    @IBOutlet weak var cellStafType: UILabel!
    @IBOutlet weak var cellSubjectName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellView.layer.cornerRadius = 10
        cellView.layer.shadowColor = UIColor.black.cgColor
        cellView.layer.shadowOpacity = 0.1
        cellView.layer.shadowOffset = .init(width: 0.3, height: 1)
        cellView.layer.shadowRadius = 2
        cellView.layer.borderWidth = 0.3
        cellView.layer.borderColor = UIColor.systemGray6.withAlphaComponent(0.3).cgColor
        
        imageBaseView.layer.cornerRadius = imageBaseView.frame.height/2
        imageBaseView.layer.borderWidth = 2
        imageBaseView.layer.borderColor = UIColor(named: "ConfirmColor")?.withAlphaComponent(0.3).cgColor
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
