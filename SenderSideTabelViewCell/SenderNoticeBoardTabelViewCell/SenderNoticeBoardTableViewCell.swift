//
//  SenderNoticeBoardTableViewCell.swift
//  SenderGraditNoticeBoard
//
//  Created by MACBOOKPRO on 06/12/22.
//

import UIKit

class SenderNoticeBoardTableViewCell: UITableViewCell {
    @IBOutlet weak var sendView: UIViewX!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
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
    }
    func configureCommonCell(
        isSelected: Bool,createdBy: String?,isAppRead: String?,topic: String?,date: String?,time: String?,description: String?,sentByName: String?,hasAttachment: Bool,memberId:String){
        descriptionCellLabel.isHidden = !isSelected

           arrowImage.image = UIImage(systemName: isSelected ? "chevron.up" : "chevron.down")
        sendbydefaultlabl.isHidden = !isSelected
        sentByCellLabel.isHidden = !isSelected
        sendView.isHidden = !isSelected
        topicCellLabel.isHidden = false
        deleteView.isHidden = !isSelected || memberId != createdBy
        attchmentView.isHidden = !isSelected || !hasAttachment
        redImageView.isHidden = isAppRead == "1"
        topicCellLabel.text = topic?.capitalized
        dateLbl.text = date
        timeLbl.text = time
        descriptionCellLabel.text = description
        sentByCellLabel.text = sentByName
        descriptionCellLabel.sizeToFit()
    }
}
