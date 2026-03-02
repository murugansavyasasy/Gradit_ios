//
//  GetSectionYearTableViewCell.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 26/03/23.
//

import UIKit

class GetSectionYearTableViewCell: UITableViewCell,UITextFieldDelegate, UITextViewDelegate {
    @IBOutlet weak var datePickerView: UIView!
    @IBOutlet weak var height: NSLayoutConstraint!
    @IBOutlet weak var datePickerSet: UIDatePicker!
    @IBOutlet weak var overallView: UIViewX!
    @IBOutlet weak var cellSubjectView: UIViewX!
    @IBOutlet weak var selectImg: UIImageView!
    
    @IBOutlet weak var checkSubjectImageView: UIImageView!
    @IBOutlet weak var venuView: UIViewX!
    
    @IBOutlet weak var overAllView: UIView!
    
    @IBOutlet weak var SaveView: UIViewX!
    @IBOutlet weak var sylubasTextView: UITextView!
    @IBOutlet weak var venuLabel: UITextField!
    @IBOutlet weak var calanderDateLabel: UILabel!
    @IBOutlet weak var clanderView: UIViewX!
    
    @IBOutlet weak var sectionDropDownLabel: UILabel!
    @IBOutlet weak var sectionDropDownView: UIView!
    @IBOutlet weak var SubjectLabel: UILabel!
    
    @IBOutlet weak var subjectCheckBox: CheckBoxThree!
    
    
//    CheckBoxThree
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        sylubasTextView.delegate = self

        datePickerView.isHidden = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
       
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        venuLabel.resignFirstResponder()
        return true
    }
    
    
}
