//
//  HallTicketCollectionViewCell.swift
//  Vs_GradItCollege
//
//  Created by admin on 15/12/23.
//

import UIKit

class HallTicketCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var clgName: UILabel!
    @IBOutlet weak var condonationPaidDefaultlbl: UILabel!
    @IBOutlet weak var course: UILabel!
    @IBOutlet weak var condonationPaidLbl: UILabel!
    @IBOutlet weak var courseWiseAttLbl: UILabel!
    @IBOutlet weak var overallAttendDefaultlbl: UILabel!
    @IBOutlet weak var overallSemesterAttLbl: UILabel!
    @IBOutlet weak var arrearRegularLbl: UILabel!
    @IBOutlet weak var exameTime: UILabel!
    @IBOutlet weak var exameDateLbl: UILabel!
    @IBOutlet weak var subjectCodeLbl: UILabel!
    @IBOutlet weak var subjectLbl: UILabel!
    @IBOutlet weak var semesterLbl: UILabel!
    @IBOutlet weak var courseLbl: UILabel!
    @IBOutlet weak var deparmentLbl: UILabel!
    @IBOutlet weak var dateOfBrithLbl: UILabel!
    @IBOutlet weak var registerLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        condonationPaidLbl.isHidden = true
        
   courseWiseAttLbl.isHidden = true
    overallSemesterAttLbl.isHidden = true
     arrearRegularLbl.isHidden = true
     exameTime.isHidden = true
   exameDateLbl.isHidden = true
   subjectCodeLbl.isHidden = true
   subjectLbl.isHidden = true
    semesterLbl.isHidden = true
     courseLbl.isHidden = true
    deparmentLbl.isHidden = true
  dateOfBrithLbl.isHidden = true
   registerLbl.isHidden = true
 nameLbl.isHidden = true
    }

}
