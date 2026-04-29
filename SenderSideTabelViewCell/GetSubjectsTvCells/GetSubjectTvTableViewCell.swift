//
//  GetSubjectTvTableViewCell.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 27/03/23.
//

import UIKit

class GetSubjectTvTableViewCell: UITableViewCell {

    
    @IBOutlet weak var LineView: UIView!
    @IBOutlet weak var sessionLabel: UILabel!
    
    @IBOutlet weak var examDate: UILabel!
    @IBOutlet weak var examName: UILabel!
    @IBOutlet weak var subjectNameLabel: UILabel!
    @IBOutlet weak var ExamVenuLabel: UILabel!
    
    @IBOutlet weak var syllubusDefaultLbl: UILabel!
    @IBOutlet weak var syllabusName: UILabel!
    
    @IBOutlet weak var cellBaseView: UIView!
    
    @IBOutlet weak var ArrowImagview: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellBaseView.layer.cornerRadius = 10
        cellBaseView.layer.shadowColor = UIColor.black.cgColor
        cellBaseView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cellBaseView.layer.shadowOpacity = 0.2
        cellBaseView.layer.shadowRadius = 4.0
        cellBaseView.clipsToBounds = false
        cellBaseView.layer.borderWidth = 0.5
        cellBaseView.layer.borderColor = UIColor.lightGray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
