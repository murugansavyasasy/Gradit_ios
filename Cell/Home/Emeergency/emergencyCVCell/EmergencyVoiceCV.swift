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
    @IBOutlet weak var microphoneImageView: UIImageView!
    @IBOutlet weak var microphoneImageBaseview: UIView!
    @IBOutlet weak var emergencyLblBaseview: UIView!
    @IBOutlet weak var emergencyLbl: UILabel!
    
    var audioURL: String?
    var playAction: (() -> Void)?
    var sliderChanged: ((Float) -> Void)?
    private var priority: String? = UserDefaults.standard.string(forKey: DefaultsKeys.priority)

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.priority = UserDefaults.standard.string(forKey: DefaultsKeys.priority)
        
        baseView.layer.cornerRadius = 12
//        baseView.layer.borderWidth = 1
//        baseView.layer.borderColor = UIColor.red.withAlphaComponent(0.7).cgColor
        baseView.backgroundColor = .white//colorForPriority()?.withAlphaComponent(0.05)
        baseView.layer.shadowColor = UIColor.black.cgColor
        baseView.layer.shadowRadius = 3
        baseView.layer.shadowOpacity = 0.3
        baseView.layer.shadowOffset = .init(width: 1, height: 2)
        seekbarBaseview.layer.cornerRadius = seekbarBaseview.frame.height/2
        microphoneImageBaseview.layer.cornerRadius = microphoneImageBaseview.frame.height/2
        microphoneImageBaseview.backgroundColor = colorForPriority()?.withAlphaComponent(0.08)
        microphoneImageView.tintColor = colorForPriority()
        playBtn.layer.cornerRadius = playBtn.frame.height/2
        playBtn.backgroundColor = colorForPriority()
        
        emergencyLblBaseview.layer.cornerRadius = emergencyLblBaseview.frame.height/2
        
        emergencyLblBaseview.backgroundColor = UIColor.red.withAlphaComponent(0.08)
        
        emergencyLbl.textColor = .red
        
        seekbarBaseview.layer.cornerRadius = 12
        seekbarBaseview.backgroundColor = colorForPriority()?.withAlphaComponent(0.08)
        
        slider.tintColor = colorForPriority()
        
        titleLbl.setFont(style: .regular, size: 14)
        emergencyLbl.setFont(style: .regular, size: 12)
        DateLbl.setFont(style: .regular,size: 12)
        timeLbl.setFont(style: .regular,size: 12)
        durationLbl.setFont(style: .medium,size: 12)
        
        DateLbl.textColor = UIColor.black.withAlphaComponent(0.8)
        timeLbl.textColor = UIColor.black.withAlphaComponent(0.7)
        
    }
    
    func colorForPriority() -> UIColor? {
        switch priority {
        case "p1":
            return UIColor(named: "Principal")
        case "p2", "p3", "p6":
            return UIColor(named: "Teaching Staff")
        case "p4":
            return UIColor(named: "studentViewColors")
        case "p5":
            return UIColor(named: "FatherColor")
        case "p7":
            return UIColor(named: "univercityColorCod")
        default:
            return UIColor(named: "Principal")
        }
    }

    @IBAction func playBtnAct(_ sender: UIButton) {
        playAction?()
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        sliderChanged?(sender.value)
    }
}
