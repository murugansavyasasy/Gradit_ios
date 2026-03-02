//
//  ExamTableViewCell.swift
//  GraditExmation
//
//  Created by MACBOOKPRO on 03/11/22.
//

import UIKit

class ExamTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var sentByView: UIViewX!
    @IBOutlet weak var venuDefaultLabl: UILabel!
    
    
    @IBOutlet weak var syubsDotLabl: UILabel!
    @IBOutlet weak var venuDotLabl: UILabel!
    
    @IBOutlet weak var sylubsDefaltLabl: UILabel!
    
    @IBOutlet weak var arrowImageHeight: NSLayoutConstraint!
    
    @IBOutlet weak var redDotImageView: UIImageView!
    @IBOutlet weak var cellExamName: UILabel!
    
  
    
    @IBOutlet weak var cellExamDate: UILabel!
    
    
    @IBOutlet weak var arrowImgView: UIImageView!
    @IBOutlet weak var cellExamVenue: UILabel!
    
    @IBOutlet weak var cellSendByLabel: UILabel!
    
    @IBOutlet weak var cellSyllabus: UILabel!
    
    @IBOutlet weak var nextView: UIViewX!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
       
       
        redDotImageView.isHidden = true
      
        arrowImgView.image = UIImage(named: "down")
//        arrowImageHeight.constant = 86
        
        venuDotLabl.isHidden = true
        syubsDotLabl.isHidden = true
        sylubsDefaltLabl.isHidden = true
        venuDefaultLabl.isHidden = true
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
        
    }
    
}
