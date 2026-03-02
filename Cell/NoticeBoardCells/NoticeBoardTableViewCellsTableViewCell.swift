//
//  NoticeBoardTableViewCellsTableViewCell.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 24/11/22.
//

import UIKit

class NoticeBoardTableViewCellsTableViewCell: UITableViewCell {

    @IBOutlet weak var DetailsStack: UIStackView!
    @IBOutlet weak var attchmentView: UIViewX!
    @IBOutlet weak var redDotImageView: UIImageView!
    @IBOutlet weak var arrowImage: UIImageView!
    @IBOutlet weak var topicCellLabel: UILabel!
    @IBOutlet weak var descriptionCellLabel: UILabel!
    @IBOutlet weak var sentByCellLabel: UILabel!
    @IBOutlet weak var dateTimeCellLabel: UILabel!
    
    var redDotImageStr : UIImage!
    override func awakeFromNib() {
        super.awakeFromNib()
        

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
