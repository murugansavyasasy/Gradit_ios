//
//  EventTableViewCell.swift
//  EventsGradit
//
//  Created by MACBOOKPRO on 29/10/22.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var discreptionlabl: UILabel!
    
    @IBOutlet weak var arrowImage: UIImageView!
    @IBOutlet weak var sendbyDefltlab: UILabel!
    @IBOutlet weak var viewclick: UIViewX!
    @IBOutlet weak var readImageView: UIImageView!
    @IBOutlet weak var topicCellLabel: UILabel!
    
    @IBOutlet weak var sendByView: UIViewX!
   
    
    @IBOutlet weak var timeDateCellLabel: UILabel!
    
    @IBOutlet weak var eventDateCellLabel: UILabel!
    
    
    @IBOutlet weak var createrNameCellLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       
        readImageView.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
