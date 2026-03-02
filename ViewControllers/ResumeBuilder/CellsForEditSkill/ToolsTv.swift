//
//  ToolsTv.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 11/07/25.
//

import UIKit

class ToolsTv: UITableViewCell, UITextViewDelegate {

    @IBOutlet weak var SkillsLbl: UILabel!
    @IBOutlet weak var SkillsField: PaddedTextField!
    @IBOutlet weak var ToolsLbl: UILabel!
    @IBOutlet weak var ToolsField: PaddedTextField!
    
    @IBOutlet weak var SkillTextview: AutoGrowingTextView!
    @IBOutlet weak var ToolsTextview: AutoGrowingTextView!
    
    var OnSkillChange: ((String) -> Void)?
    var OnToolsChange: ((String) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        SkillsLbl.setFont(style: .medium, size: FontSize.title)
        ToolsLbl.setFont(style: .medium, size: FontSize.title)
        
        SkillsField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
        SkillTextview.delegate = self
        ToolsTextview.delegate = self
        
        SkillTextview.placeholder = "Enter comma separated"
        ToolsTextview.placeholder = "Enter comma separated"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        if textView == SkillTextview{
            OnSkillChange?(textView.text)
        }else {
            OnToolsChange?(textView.text)
        }
        
        if let tableView = self.superview(of: UITableView.self) {
                UIView.setAnimationsEnabled(false)
                tableView.beginUpdates()
                tableView.endUpdates()
                UIView.setAnimationsEnabled(true)
            }
    }
    
    
    @IBAction func textDidChange(_ sender: UITextField) {
        
        let text = sender.text ?? ""
        
        switch sender {
            
        case SkillsField:
            OnSkillChange?(text)
        case ToolsField:
            OnToolsChange?(text)
        default:
            break
        }
    }
}
