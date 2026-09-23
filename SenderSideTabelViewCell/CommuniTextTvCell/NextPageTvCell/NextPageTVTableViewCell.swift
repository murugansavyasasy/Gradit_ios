//
//  NextPageTVTableViewCell.swift
//  Vs_GradItCollege
//
//  Created by admin on 29/01/24.
//

import UIKit

class NextPageTVTableViewCell: UITableViewCell {

    @IBOutlet weak var textImageBaseview: UIView!
    @IBOutlet weak var DateLbl: UILabel!
    @IBOutlet weak var TimeLbl: UILabel!
    @IBOutlet weak var msgContent: UILabel!
    @IBOutlet weak var DiscreptionLbl: UILabel!
    @IBOutlet weak var sendView: UIViewX!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textImageBaseview.backgroundColor = UIColor(named: "ConfirmColor")?.withAlphaComponent(0.1)
        textImageBaseview.layer.cornerRadius = textImageBaseview.frame.height/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
