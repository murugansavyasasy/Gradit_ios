//
//  NextVoiceTableViewCell.swift
//  Vs_GradItCollege
//
//  Created by admin on 29/01/24.
//

import UIKit
import AVFAudio
import AVFoundation

class NextVoiceTableViewCell: UITableViewCell {

  
    @IBOutlet weak var sendView: UIViewX!
    @IBOutlet weak var dateTimeLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var btnName: UIButton!
    @IBOutlet weak var playbackSlider: UISlider!
    @IBOutlet weak var secondsTimeLabel: UILabel!
    @IBOutlet weak var durationLAbel: UILabel!
    var audioFileURL: String!

var audioRecorder: AVAudioRecorder!
var audioPlayer : AVAudioPlayer!
var meterTimer:Timer!
var isAudioRecordingGranted: Bool!
var durationLable : String!
var secondsLabel  : String!

var strPlayStatus : NSString = ""


var playerItem: AVPlayerItem?
 var player: AVPlayer?

var timer = Timer()
var time : Float64 = 0;
var sliderIndex : NSInteger = NSInteger()
var strFilePath : String = String()

var messageId : String!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        secondsTimeLabel.text = "00:00"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    
    @IBAction func playButtonPressed(_ sender: UIButton) {
        
     
        
        var urls = URL(string: audioFileURL)
        
        playerItem = AVPlayerItem(url: urls!)
        player = AVPlayer(playerItem: playerItem!)
        if self.player!.currentItem?.status == .readyToPlay{
        }
          NotificationCenter.default.addObserver(self, selector: #selector(self.playerDidFinishPlaying(sender:)),
         name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
         object: player!.currentItem)
         if(btnName.isSelected)
         {
          btnName.isSelected = false
            let seconds1 : Int64 = Int64(playbackSlider.value)
             let targetTime : CMTime = CMTimeMake(value: seconds1, timescale: 1)
           
             player!.seek(to: targetTime)
            strPlayStatus = "play"
             player?.pause()
             
             btnName.setImage(UIImage(named: "plays"), for: .normal)
        
             
             print("start")
            }else{
             btnName.isSelected = true
           let seconds1 : Int64 = Int64(playbackSlider.value)
            let targetTime : CMTime = CMTimeMake(value: seconds1, timescale: 1)
            player!.seek(to: targetTime)
         
           strPlayStatus = "play"
         player?.volume = 1
            player?.play()
                btnName.setImage(UIImage(named: "pauses"), for: .normal)
              
                print("enddddd")
         }
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)
            
      
    
        
        do {        let str = try String(contentsOfFile: audioFileURL)
            print("lllllllll")    }
        
        catch {        print("The file could not be loaded : \(error)")    }
        


    }







@objc func updateSlider(){
if self.player!.currentItem?.status == .readyToPlay {

time = CMTimeGetSeconds(self.player!.currentTime())
}
let duration : CMTime = playerItem!.asset.duration
let seconds : Float64 = CMTimeGetSeconds(duration)
playbackSlider.maximumValue = Float(seconds)
playbackSlider.minimumValue = 0.0
playbackSlider.value = Float(time)

if(time > 0){
let minutes = Int(time) / 60 % 60
let secondss = Int(time) % 60

let durationFormat = String(format:"%02i:%02i", minutes, secondss)
secondsTimeLabel.text = durationFormat
}
if(time == seconds){
timer.invalidate()
btnName.isSelected = false
playbackSlider.value = 0.0
}
}
func playbackSliderValueChanged(playbackSliders:UISlider){
let seconds : Int64 = Int64(playbackSlider.value)
let targetTime : CMTime = CMTimeMake(value: seconds, timescale: 1)
if(player != nil){
player!.seek(to: targetTime)
}else{
playbackSlider.value = playbackSliders.value
}
}


@objc func playerDidFinishPlaying(sender: Notification) {
 timer.invalidate()
  playbackSlider.value = 0.0
player?.pause()
 btnName.isSelected = false
  playerItem?.seek(to: CMTime.zero)
    secondsTimeLabel.text = "00:00"
    btnName.setImage(UIImage(named: "plays"), for: .normal)
  }






@objc func ordersFinishedPlaying( _ myNotification:NSNotification) {



    let selectedTime: CMTime = CMTimeMake(value: Int64(0 * 1000 as Float64), timescale: 1000)

    player?.seek(to: selectedTime)


    btnName.setImage(UIImage(named: "plays"), for: .normal)
    print("Player finished")



}

    
}
