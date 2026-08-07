//
//  EmergencyVoiceCV.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 04/08/26.
//

import UIKit

class EmergencyVoiceCV: UICollectionViewCell {
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var DateLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var seekbarBaseview: UIView!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var durationLbl: UILabel!
    @IBOutlet weak var sentbyLbl: UILabel!
    
    var playAction: (() -> Void)?
    var sliderChanged: ((Float) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        baseView.layer.cornerRadius = 12
        baseView.layer.borderWidth = 1
        baseView.layer.borderColor = UIColor.red.withAlphaComponent(0.7).cgColor
    }

    @IBAction func playBtnAct(_ sender: UIButton) {
        playAction?()
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        sliderChanged?(sender.value)
    }
}
