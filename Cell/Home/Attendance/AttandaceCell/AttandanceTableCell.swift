//
//  AttandanceTableCell.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 30/01/23.
//

import UIKit

class AttandanceTableCell: UITableViewCell {

    
    
    @IBOutlet weak var subjectNamLbl: UILabel!
    @IBOutlet weak var overAllCellView: UIViewX!
    @IBOutlet weak var notYetLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
   
    
    @IBOutlet weak var dateView: UIViewX!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var presentView: UIViewX!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
    }
    
}
