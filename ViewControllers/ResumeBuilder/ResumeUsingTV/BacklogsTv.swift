//
//  BacklogsTv.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 05/07/25.
//

import UIKit

class BacklogsTv: UITableViewCell {
    
    
    @IBOutlet weak var BacklogsLbl: UILabel!
    @IBOutlet weak var NoOfArrearsLbl: UILabel!
    @IBOutlet weak var BacklogsField: TextfieldWithImage!
    @IBOutlet weak var ArrearsField: TextfieldWithImage!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        BacklogsLbl.setFont(style: .medium, size: 12)
        NoOfArrearsLbl.setFont(style: .medium, size: 12)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
