//
//  CertificationsTv.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 11/07/25.
//

import UIKit

class CertificationsTv: UITableViewCell {

    @IBOutlet weak var courseLbl: UILabel!
    @IBOutlet weak var CourseField: PaddedTextField!
    @IBOutlet weak var InstituteField: PaddedTextField!
    @IBOutlet weak var durationLbl: UILabel!
    @IBOutlet weak var durationField: PaddedTextField!
    @IBOutlet weak var InstituteLbl: UILabel!
    @IBOutlet weak var RemoveBtn: UIButton!
    var deleteAction: (() -> Void)?
    
    var OnCourse: ((String) -> Void)?
    var OnInstitute: ((String) -> Void)?
    var OnDuration: ((String) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        courseLbl.setFont(style: .medium, size: FontSize.title)
        durationLbl.setFont(style: .medium, size: FontSize.title)
        InstituteLbl.setFont(style: .medium, size: FontSize.title)
        CourseField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        InstituteField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        durationField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        RemoveBtn.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func textDidChange(_ sender: UITextField) {
        
        let text = sender.text ?? ""
        
        switch sender {
            
        case CourseField:
            OnCourse?(text)
            
        case InstituteField:
            OnInstitute?(text)
            
        case durationField:
            OnDuration?(text)
            
        default:
            break
        }
    }
    
    @IBAction func deleteTapped(){
        deleteAction?()
    }
}
