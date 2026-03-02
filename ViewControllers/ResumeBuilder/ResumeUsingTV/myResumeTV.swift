//
//  myResumeTV.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 17/07/25.
//

import UIKit

class myResumeTV: UITableViewCell {

    @IBOutlet weak var TitleLbl: UILabel!
    @IBOutlet weak var defaultBtn: UIButton!
    
    @IBOutlet weak var ResumeIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        TitleLbl.setFont(style: .regular, size: FontSize.body)
        defaultBtn.setTitleFont(style: .regular, size: FontSize.body)
        
        if let image = UIImage(systemName: "text.document") {
            ResumeIcon.image = image
        } else if let fallback = UIImage(systemName: "doc.text") {
            ResumeIcon.image = fallback
        } else {
            ResumeIcon.image = UIImage(named: "pdf-file") // custom asset
        }

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
