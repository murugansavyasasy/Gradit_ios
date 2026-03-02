//
//  ProjectsTv.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 14/07/25.
//

import UIKit

class ProjectsTv: UITableViewCell, UITextViewDelegate {

    @IBOutlet weak var projectTitleTextView: AutoGrowingTextView!
    @IBOutlet weak var projectTitleLbl: UILabel!
    @IBOutlet weak var RemoveBtn: UIButton!
    
    var deleteAction: (() -> Void)?
    var onProjectField: ((String) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        projectTitleLbl.setFont(style: .medium, size: FontSize.title)
        projectTitleTextView.delegate = self
        projectTitleTextView.placeholder = "Enter Project Title"
        RemoveBtn.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func deleteTapped(){
        deleteAction?()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        let text = textView.text ?? ""
        onProjectField?(text)
    }
}
