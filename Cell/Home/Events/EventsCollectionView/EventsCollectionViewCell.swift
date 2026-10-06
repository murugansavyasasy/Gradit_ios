//
//  EventsCollectionViewCell.swift
//  Vs_GradItCollege
//
//  Created by APPLE on 01/11/22.
//

import UIKit

class EventsCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var fullView: UIViewX!
    
    @IBOutlet weak var eventTopic: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        fullView.backgroundColor = .systemGreen.withAlphaComponent(0.1)
        fullView.borderColor = .systemGreen.withAlphaComponent(0.12)
        fullView.borderWidth = 1
        fullView.cornerRadius = 10
    }

}
