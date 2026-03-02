//
//  GetSubjectTvTableViewCell.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 27/03/23.
//

import UIKit

class GetSubjectTvTableViewCell: UITableViewCell {

    
    @IBOutlet weak var LineView: UIView!
    @IBOutlet weak var sectionLabel: UILabel!
    
    @IBOutlet weak var examDate: UILabel!
    @IBOutlet weak var examName: UILabel!
    @IBOutlet weak var subjectNameLabel: UILabel!
    @IBOutlet weak var ExamVenuLabel: UILabel!
    
    @IBOutlet weak var syllubusDefaultLbl: UILabel!
    @IBOutlet weak var syllabusName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
