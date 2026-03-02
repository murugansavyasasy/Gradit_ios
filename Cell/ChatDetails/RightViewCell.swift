//
//  RightViewCell.swift
//  ChatSample
//
//  Created by Hafiz on 20/09/2019.
//  Copyright © 2019 Nibs. All rights reserved.
//

import UIKit

class RightViewCell: UITableViewCell {

    
    @IBOutlet weak var firstCellHeght: NSLayoutConstraint!
    @IBOutlet weak var secondChatCellView: UIViewX!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var studNameLbl: UILabel!
    @IBOutlet weak var messageContainerView: UIViewX!
    @IBOutlet weak var textMessageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        messageContainerView.rounded(radius: 12)
//        messageContainerView.backgroundColor = UIColor(hexString: "E1F7CB")
//
//        contentView.backgroundColor = .clear
//        backgroundColor = .clear
    }
    
//    func configureCell(message: Message) {
//        textMessageLabel.text = message.text
//    }
}
