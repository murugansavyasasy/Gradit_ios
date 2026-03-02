//
//  ChatAnswerTableViewCell.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 27/06/23.
//

import UIKit

class ChatAnswerTableViewCell: UITableViewCell {

    
    @IBOutlet weak var ansFullView: UIViewX!
    
    @IBOutlet weak var ansName: UILabel!
    
    @IBOutlet weak var ansSideTime: UILabel!
    @IBOutlet weak var ansSideDateLAbel: UILabel!
    @IBOutlet weak var questionLabelLeftSide: UILabel!
    @IBOutlet weak var ansLAbel: UILabel!
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
