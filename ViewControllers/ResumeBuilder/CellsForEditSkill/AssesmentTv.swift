//
//  AssesmentTv.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 11/07/25.
//

import UIKit

class AssesmentTv: UITableViewCell, UITextViewDelegate, UITextFieldDelegate {

    
    @IBOutlet weak var AssesmentLbl: UILabel!
    @IBOutlet weak var ScoreLbl: UILabel!
    @IBOutlet weak var AssessmentField: PaddedTextField!
    @IBOutlet weak var ScoreField: PaddedTextField!
    @IBOutlet weak var AssessmentTxtview: ExpandableTextView!
    @IBOutlet weak var ScoreTxtView: ExpandableTextView!
    @IBOutlet weak var RemoveBtn: UIButton!
    @IBOutlet weak var AssesmentFieldHeight: NSLayoutConstraint!
    @IBOutlet weak var ScoreFieldHeight: NSLayoutConstraint!
    
    var OnAssessment: ((String) -> Void)?
    var OnScore: ((String) -> Void)?
    var deleteAction: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        AssesmentLbl.setFont(style: .medium, size: FontSize.title)
        ScoreLbl.setFont(style: .medium, size: FontSize.title)
        AssessmentField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        ScoreField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        RemoveBtn.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
        AssessmentTxtview.delegate = self
        ScoreTxtView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func deleteTapped(){
        deleteAction?()
    }
    
    @IBAction func textDidChange(_ sender: UITextField) {
        
        let text = sender.text ?? ""
        
        switch sender {
            
        case AssessmentField:
            OnAssessment?(text)
            
        case ScoreField:
            OnScore?(text)
            
        default:
            break
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
           let text = textView.text ?? ""

           switch textView {
           case AssessmentTxtview:
               OnAssessment?(text)
           case ScoreTxtView:
               OnScore?(text)
           default:
               break
           }

           // 🔁 Force cell height update
        if let tableView = self.findSuperview(of: UITableView.self) {
            tableView.beginUpdates()
            tableView.endUpdates()
        }
       }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }

}

extension UIView {
    func findSuperview<T: UIView>(of type: T.Type) -> T? {
        if let superview = self.superview as? T {
            return superview
        }
        return self.superview?.findSuperview(of: T.self)
    }

}
