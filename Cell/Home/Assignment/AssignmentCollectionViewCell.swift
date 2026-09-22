//
//  AssignmentCollectionViewCell.swift
//  Vs_GradItCollege
//
//  Created by APPLE on 02/11/22.
//

import UIKit

class AssignmentCollectionViewCell: UICollectionViewCell{
    
    
    @IBOutlet weak var attchmentView: UIViewX!
    
    @IBOutlet weak var viewAsigmentClick: UIView!
    @IBOutlet weak var dateview: UIView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var assDescLbl: UILabel!
    @IBOutlet weak var assTopicLbl: UILabel!
    @IBOutlet weak var dueDateLbl: UILabel!
    @IBOutlet weak var assigmentFullView: UIViewX!
 
    override func awakeFromNib() {
        super.awakeFromNib()
   
        assigmentFullView.borderColor = UIColor(red: 132/255, green: 45/255, blue: 255/255, alpha: 0.14)
        assigmentFullView.borderWidth = 1
        dateview.layer.cornerRadius = dateview.frame.height/2
        viewAsigmentClick.layer.cornerRadius = dateview.frame.height/2
    }

}
