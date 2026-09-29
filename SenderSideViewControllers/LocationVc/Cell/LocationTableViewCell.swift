//
//  LocationTableViewCell.swift
//  VoicesnapSchoolApp
//
//  Created by admin on 29/08/24.
//  Copyright © 2024 Gayathri. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {

    @IBOutlet weak var calanderView: UIView!
    @IBOutlet weak var fullView: UIView!
    @IBOutlet weak var historyTimImage: UIImageView!
    @IBOutlet weak var toDateLbl: UILabel!
    @IBOutlet weak var StatusLbl: UILabel!
    @IBOutlet weak var workingHrsLbl: UILabel!
    @IBOutlet weak var attendanceTypeLbl: UILabel!
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var datelbl: UILabel!
    @IBOutlet weak var mnthLbl: UILabel!
    @IBOutlet weak var firstInLbl: UILabel!
    @IBOutlet weak var namelbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        fullView.layer.cornerRadius = 10
        calanderView.layer.cornerRadius = 10
        calanderView.layer.masksToBounds = true
        fullView.layer.masksToBounds = true
        fullView.layer.shadowColor = UIColor.black.cgColor
        fullView.layer.shadowOpacity = 0.5
        fullView.layer.shadowOffset = CGSize(width: 2, height: 2)
        fullView.layer.shadowRadius = 2
        fullView.layer.masksToBounds = false
        firstInLbl.isHidden = false
        workingHrsLbl.isHidden = false
        toDateLbl.isHidden = false
        StatusLbl.layer.cornerRadius = 4
        StatusLbl.layer.masksToBounds = true
        
    }
}
