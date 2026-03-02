//
//  RecentTableViewCell.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 07/06/23.
//

import UIKit
import AVFoundation

class RecentTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var playFulViewTop: NSLayoutConstraint!
    @IBOutlet weak var sendDefltLbl: UILabel!
    @IBOutlet weak var sendbyTop: NSLayoutConstraint!
    
    @IBOutlet weak var sendViewWidth: NSLayoutConstraint!
    @IBOutlet weak var sendbydefaltLblTop: NSLayoutConstraint!
    @IBOutlet weak var discreptionLbl: UILabel!
    @IBOutlet weak var arrowimageview: UIImageView!
    @IBOutlet weak var playbuttonView: UIViewX!
    @IBOutlet weak var playView: UIViewX!
    @IBOutlet weak var playVoiceView: UIView!
    @IBOutlet weak var voiceSlider: UISlider!
    
    @IBOutlet weak var btnName: UIButton!
    @IBOutlet weak var timesLabel: UILabel!
    
    @IBOutlet weak var durationLAbel: UILabel!
    
    @IBOutlet weak var playImage: UIImageView!
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var secodsLabel: UILabel!
    @IBOutlet weak var sendBy: UILabel!
    @IBOutlet weak var topic: UILabel!
    @IBOutlet weak var topImageView: UIImageView!
    var audioURL: String!
    
    
    var playerItem: AVPlayerItem?
     var player: AVPlayer?
//        weak var playbackSlider: UISlider?
    var timer = Timer()
    var time : Float64 = 0;
    var sliderIndex : NSInteger = NSInteger()
    var strFilePath : String = String()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let cell = UITapGestureRecognizer(target: self, action: #selector(voicePlayerVc))
        
        playView.addGestureRecognizer(cell)
        
    }
    
    
    
    @IBAction func voicePlayerVc(){
        
        
       
        
        createAndDownloadFile(fileNameUrl : audioURL)
        var urls = URL(string: audioURL)
        
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
            let seconds1 : Int64 = Int64(voiceSlider.value)
             let targetTime : CMTime = CMTimeMake(value: seconds1, timescale: 1)
              //  print("pause AudioSlider:\(seconds1)")
             player!.seek(to: targetTime)
//            strPlayStatus = "play"
             player?.pause()
             
             btnName.setImage(UIImage(named: "plays"), for: .normal)
            //  timer.invalidate()
            }else{
             btnName.isSelected = true
           let seconds1 : Int64 = Int64(voiceSlider.value)
            let targetTime : CMTime = CMTimeMake(value: seconds1, timescale: 1)
            player!.seek(to: targetTime)
            // print("play AudioSlider:\(seconds1)")
//           strPlayStatus = "play"
         player?.volume = 1
            player?.play()
                btnName.setImage(UIImage(named: "pauses"), for: .normal)
        
         }
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)
            
      
        
        
        
        
        
        
        
        
        
        


    }







@objc func updateSlider(){
if self.player!.currentItem?.status == .readyToPlay {

time = CMTimeGetSeconds(self.player!.currentTime())
}
let duration : CMTime = playerItem!.asset.duration
let seconds : Float64 = CMTimeGetSeconds(duration)
    voiceSlider.maximumValue = Float(seconds)
    voiceSlider.minimumValue = 0.0
    voiceSlider.value = Float(time)

if(time > 0){
let minutes = Int(time) / 60 % 60
let secondss = Int(time) % 60

let durationFormat = String(format:"%02i:%02i", minutes, secondss)
    durationLAbel.text = durationFormat
}
if(time == seconds){
timer.invalidate()
btnName.isSelected = false
    voiceSlider.value = 0.0
}
}
func playbackSliderValueChanged(playbackSliders:UISlider){
let seconds : Int64 = Int64(voiceSlider.value)
let targetTime : CMTime = CMTimeMake(value: seconds, timescale: 1)
if(player != nil){
player!.seek(to: targetTime)
}else{
    voiceSlider.value = playbackSliders.value
}
}


@objc func playerDidFinishPlaying(sender: Notification) {
 timer.invalidate()
    voiceSlider.value = 0.0
player?.pause()
 btnName.isSelected = false
  playerItem?.seek(to: CMTime.zero)
    durationLAbel.text = "00:00"
    btnName.setImage(UIImage(named: "plays"), for: .normal)
  }

func createAndDownloadFile(fileNameUrl : String) {
    
    
    print("GraditaudioFile")
    let fileName = "GraditaudioFile.mp3"
    
    // Create a file URL for the desired location
    let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let fileURL = documentsURL.appendingPathComponent(fileName)
    
    // Create some sample data to be written to the file
    let sampleData = "Sample voice data".data(using: .utf8)
    
    // Write data to the file
    do {
        try sampleData?.write(to: fileURL)
        print("File created successfully!")
    } catch {
        print("Error creating file: \(error)")
        return
    }
    
    // Download the file
    let url = URL(string: fileNameUrl)!
    print("urlurlurlurl",url)
    let session = URLSession.shared
    let downloadTask = session.downloadTask(with: url) { (tempURL, response, error) in
        guard let tempURL = tempURL else {
            print("Error downloading file: \(error)")
            return
        }
        
        // Move the downloaded file to the desired location
        do {
            try FileManager.default.moveItem(at: tempURL, to: fileURL)
            print("File downloaded successfully!")
        } catch {
            print("Error moving file: \(error)")
        }
    }
    
    downloadTask.resume()
}
        
  


    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
