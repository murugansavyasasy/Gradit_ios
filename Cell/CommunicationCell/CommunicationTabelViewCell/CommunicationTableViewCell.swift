//
//  CommunicationTableViewCell.swift
//  GraditCommuniMenu
//
//  Created by MACBOOKPRO on 21/11/22.
//

import UIKit

class CommunicationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var texMessageRedDotImageView: UIImageView!
    @IBOutlet weak var voiceMessageSliderView: UIViewX!
    @IBOutlet weak var cellCreatedByLabel: UILabel!
    @IBOutlet weak var cellTimeLabel: UILabel!
    @IBOutlet weak var textMessageImageView: UIImageView!
    @IBOutlet weak var cellDescpLabel: UILabel!
    @IBOutlet weak var cellDescriptionLabel: UILabel!
    @IBOutlet weak var emergencyVoiceSliderView: UIViewX!
    @IBOutlet weak var textsendbyDefaultLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var cellVoiceSendByLabel: UILabel!
    @IBOutlet weak var cellVoiceDescriponLabel: UILabel!
    @IBOutlet weak var cellVoiceTimeLabel: UILabel!
//    @IBOutlet weak var voicMessageTopHeight: NSLayoutConstraint!
//    @IBOutlet weak var textMessageTopHeight: NSLayoutConstraint!
    @IBOutlet weak var emergencyVoiceMessageHeight: NSLayoutConstraint!
    @IBOutlet weak var voiceMessageHeight: NSLayoutConstraint!
    @IBOutlet weak var textMessageHeight: NSLayoutConstraint!
    @IBOutlet weak var voiceMessageView: UIViewX!
    @IBOutlet weak var textMessageView: UIViewX!
    @IBOutlet weak var emerImage: UIImageView!
    @IBOutlet weak var emergencyVoiceMessageView: UIViewX!
    @IBOutlet weak var cellVoiceMessagePlayView: UIView!
   // @IBOutlet weak var emergencyVoiceMessageTopHeight: NSLayoutConstraint!
    @IBOutlet weak var emergencyPlay: UIView!
    @IBOutlet weak var cellEmergenyDescpLabel: UILabel!
    @IBOutlet weak var voiceMessageRedDotImage: UIImageView!
    @IBOutlet weak var cellVoiceImageView: UIImageView!
    @IBOutlet weak var emergencyRedDotImageView: UIImageView!
    @IBOutlet weak var cellEmergencyTimeLabel: UILabel!
    @IBOutlet weak var emergencyVoiceDurationLabel: UILabel!
    @IBOutlet weak var cellEmergencySendByLabel: UILabel!
    @IBOutlet weak var cellEmergencyImageView: UIImageView!
    @IBOutlet weak var voiceMessageDuriactionLabel: UILabel!
    @IBOutlet weak var labelCurrentTime: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var voicemessagePlayTopView: UIViewX!
    @IBOutlet weak var EmergencylabelCurrentTime: UILabel!
    @IBOutlet weak var emergncyVoiceSlider: UISlider!
    @IBOutlet weak var emergencyVoicePlayTopView: UIViewX!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        cellDescpLabel.isHidden = true
        voiceMessageSliderView.isHidden = true
        emergencyVoiceSliderView.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
