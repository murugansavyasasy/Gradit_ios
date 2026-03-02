//
//  ExamViewPageTvTableViewCell.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 27/03/23.
//

import UIKit

class ExamViewPageTvTableViewCell: UITableViewCell {

    
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var semesterNameLabel: UILabel!
    @IBOutlet weak var courseNameLabel: UILabel!
    
    @IBOutlet weak var ClgDeprtNameLabel: UILabel!
    
    @IBOutlet weak var yearNameLabel: UILabel!
    
    @IBOutlet weak var deleteView: UIViewX!
    @IBOutlet weak var examName: UILabel!
    
    @IBOutlet weak var EditView: UIViewX!
    @IBOutlet weak var startDateLabel: UILabel!
    
    
    @IBOutlet weak var getSubjectView: UIViewX!
    @IBOutlet weak var endDateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        deleteView.isHidden = true
        EditView.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}
