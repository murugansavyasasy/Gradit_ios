//
//  SenderCommuTextTableViewCell.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 06/05/23.
//

import UIKit
import AVFAudio
import AVFoundation
import KRProgressHUD

class SenderCommuTextTableViewCell: UITableViewCell,AVAudioPlayerDelegate {
    @IBOutlet weak var PlayerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var sendByView: UIViewX!
    @IBOutlet weak var voiceView: UIViewX!
    @IBOutlet weak var btnName: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var redDotImage: UIImageView!
    @IBOutlet weak var arrowImage: UIImageView!
    @IBOutlet weak var TypeImageView: UIImageView!
    @IBOutlet weak var sendByLabel: UILabel!
    @IBOutlet weak var msgContentLabel: UILabel!
    @IBOutlet weak var playView: UIViewX!
    @IBOutlet weak var secondsTimeLabel: UILabel!
    @IBOutlet weak var durationLAbel: UILabel!
    @IBOutlet weak var playbackSlider: UISlider!
    
    var audioFileURL: String?
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
        voiceView.isHidden = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    @IBAction func playBtn(_ sender: UIButton) {
        guard let url = URL(string: audioFileURL ?? "") else {
            print("Invalid URL")
            return
        }

        
        if player == nil {
            playerItem = AVPlayerItem(url: url)
            player = AVPlayer(playerItem: playerItem)

            NotificationCenter.default.addObserver(
                self,
                selector: #selector(playerDidFinishPlaying),
                name: .AVPlayerItemDidPlayToEndTime,
                object: playerItem
            )
        }

        if btnName.isSelected {

            btnName.isSelected = false
            player?.pause()
            btnName.setImage(UIImage(named: "plays"), for: .normal)

        } else {

            btnName.isSelected = true

            let seconds = Int64(playbackSlider.value)
            let targetTime = CMTime(value: seconds, timescale: 1)

            player?.seek(to: targetTime)
            player?.volume = 1
            player?.play()

            btnName.setImage(UIImage(named: "pauses"), for: .normal)

            createAndDownloadFile(fileNameUrl: audioFileURL ?? "")
        }

        if timer == nil {
            timer = Timer.scheduledTimer(
                timeInterval: 1.0,
                target: self,
                selector: #selector(updateSlider),
                userInfo: nil,
                repeats: true
            )
        }
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
    
    func createAndDownloadFile(fileNameUrl : String) {
        
        KRProgressHUD.show()
        
        let strFilePath : String =  String(describing: fileNameUrl)
        
        let audioUrl = URL(string: strFilePath)
        
        if let audioUrl = URL(string: strFilePath) {
            
            
            let documentsUrl:URL =  (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first as URL?)!
            
            let strpath = String(describing: messageId) + ".wav"
            
            let destinationUrl = documentsUrl.appendingPathComponent(strpath)
            
            
            if FileManager.default.fileExists(atPath: destinationUrl.path) {
                print("The file already exists at path")
                KRProgressHUD.dismiss()
            } else {
                
                
                let sessionConfig = URLSessionConfiguration.default
                let session = URLSession(configuration: sessionConfig)
                
                let request = URLRequest(url:audioUrl)
                
                let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
                    if let tempLocalUrl = tempLocalUrl, error == nil {
                        // Success
                        if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                            KRProgressHUD.dismiss()
                            print("Successfully downloaded. Status code: \(statusCode)")
                            
                            
                        }
                        
                        do {
                            try FileManager.default.copyItem(at: tempLocalUrl, to: destinationUrl)
                            print("Success",tempLocalUrl)
                            print("Success1",destinationUrl)
                            //
                        } catch (let writeError) {
                            KRProgressHUD.dismiss()
                            print("Error creating a file \(destinationUrl) : \(writeError)")
                        }
                        
                    } else {
                        KRProgressHUD.dismiss()
                        print("Error took place while downloading a file. Error description: %@", error?.localizedDescription);
                    }
                }
                task.resume()
                
            }
        }
    }
    
    // Call the function to create and download the file
    func showToast(message : String, seconds: Double){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = .black
        alert.view.alpha = 0.5
        alert.view.layer.cornerRadius = 15
        
        
        self.window?.rootViewController!.present(alert, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
    
    @objc func ordersFinishedPlaying( _ myNotification:NSNotification) {
        
        let selectedTime: CMTime = CMTimeMake(value: Int64(0 * 1000 as Float64), timescale: 1000)
        
        player?.seek(to: selectedTime)
        
        btnName.setImage(UIImage(named: "plays"), for: .normal)
        print("Player finished")
    }
}
