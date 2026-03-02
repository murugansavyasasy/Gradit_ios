//
//  SenderNoticeBoardTableViewCell.swift
//  SenderGraditNoticeBoard
//
//  Created by MACBOOKPRO on 06/12/22.
//

import UIKit

class SenderNoticeBoardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var topicHight: NSLayoutConstraint!
    @IBOutlet weak var sendbyWdth: NSLayoutConstraint!
    @IBOutlet weak var sendView: UIViewX!
    @IBOutlet weak var dateTimeCellLabel: UILabel!
    @IBOutlet weak var sentByCellLabel: UILabel!
    
    @IBOutlet weak var topicCellLabel: UILabel!
    
    @IBOutlet weak var attchmentView: UIViewX!
    @IBOutlet weak var descriptionCellLabel: UILabel!
    
    
    @IBOutlet weak var arrowImage: UIImageView!
    @IBOutlet weak var deleteView: UIViewX!
    
    @IBOutlet weak var sendbydefaultlabl: UILabel!
    
    @IBOutlet weak var redImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        

        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
