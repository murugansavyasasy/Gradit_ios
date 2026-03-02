//
//  SenderEventTableViewCell.swift
//  GraditSenderEventMenu
//
//  Created by MACBOOKPRO on 02/12/22.
//

import UIKit

class SenderEventTableViewCell: UITableViewCell {

    @IBOutlet weak var SendByViewFull: UIViewX!
    @IBOutlet weak var topicCellLabel: UILabel!
    
    @IBOutlet weak var timeDateCellLabel: UILabel!
    
    @IBOutlet weak var arrowImage: UIImageView!
    @IBOutlet weak var eventDateCellLabel: UILabel!
    
    @IBOutlet weak var sendbyDefltlab: UILabel!
    
    @IBOutlet weak var viewclick: UIViewX!
    @IBOutlet weak var createrNameCellLabel: UILabel!
    
    @IBOutlet weak var discreptionlbl: UILabel!
    
    @IBOutlet weak var ReadDotImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        ReadDotImageView.isHidden = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
