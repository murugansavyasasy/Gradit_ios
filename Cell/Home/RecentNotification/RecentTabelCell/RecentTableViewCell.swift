//
//  RecentTableViewCell.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 07/06/23.
//

import UIKit
import AVFoundation

class RecentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var sendDefltLbl: UILabel!
    @IBOutlet weak var discreptionLbl: UILabel!
    @IBOutlet weak var arrowimageview: UIImageView!
    @IBOutlet weak var playbuttonView: UIViewX!
    @IBOutlet weak var playView: UIViewX!
    @IBOutlet weak var voiceSlider: UISlider!
    @IBOutlet weak var btnName: UIButton!
    @IBOutlet weak var timesLabel: UILabel!
    @IBOutlet weak var durationLAbel: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var sendBy: UILabel!
    @IBOutlet weak var sendByView: UIView!
    @IBOutlet weak var topic: UILabel!
    @IBOutlet weak var topImageView: UIImageView!
    
    var audioURL: String!
    var playerItem: AVPlayerItem?
    var player: AVPlayer?
    var timer = Timer()
    var time : Float64 = 0;
    var sliderIndex : NSInteger = NSInteger()
    var strFilePath : String = String()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let cell = UITapGestureRecognizer(target: self, action: #selector(voicePlayerVc))
        playView.addGestureRecognizer(cell)
        playView.cornerRadius = playView.frame.height/2
        outerView.layer.cornerRadius = 10
        outerView.layer.borderWidth = 1
        outerView.layer.borderColor = UIColor(hex: "EDF0FE")?.cgColor
        outerView.backgroundColor = UIColor.white
        outerView.layer.shadowColor = UIColor.black.cgColor
        outerView.layer.shadowOffset = CGSize(width: 0, height: 3)
        outerView.layer.shadowOpacity = 0.10
        outerView.layer.shadowRadius = 8
    }
    func hideShow(show:Bool,type:String){
            sendByView.isHidden = !show
            arrowimageview.isHidden = show
        if type == "Voice"{
            discreptionLbl.isHidden = true
            playbuttonView.isHidden = show
            playView.isHidden = !show
        }else{
            discreptionLbl.isHidden = !show
        }
        
    }
    @IBAction func voicePlayerVc(){
        createAndDownloadFile(fileNameUrl : audioURL)
        var urls = URL(string: audioURL)
        playerItem = AVPlayerItem(url: urls!)
        player = AVPlayer(playerItem: playerItem!)
        if self.player!.currentItem?.status == .readyToPlay{
        }
        NotificationCenter.default.addObserver(self, selector:#selector(self.playerDidFinishPlaying(sender:)),
                                               name:NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: player!.currentItem)
        if(btnName.isSelected){
            btnName.isSelected = false
            let seconds1 : Int64 = Int64(voiceSlider.value)
            let targetTime : CMTime = CMTimeMake(value: seconds1, timescale: 1)
            player!.seek(to: targetTime)
            player?.pause()
            btnName.setImage(UIImage(named: "plays"), for: .normal)
        }else{
            btnName.isSelected = true
            let seconds1 : Int64 = Int64(voiceSlider.value)
            let targetTime : CMTime = CMTimeMake(value: seconds1, timescale: 1)
            player!.seek(to: targetTime)
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
        btnName.setImage(UIImage(named: "plays"), for: .normal)
    }
    
    func createAndDownloadFile(fileNameUrl : String) {
        let fileName = "GraditaudioFile.mp3"
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsURL.appendingPathComponent(fileName)
        let sampleData = "Sample voice data".data(using: .utf8)
        do {
            try sampleData?.write(to: fileURL)
            print("File created successfully!")
        } catch {
            print("Error creating file: \(error)")
            return
        }
        guard let url = URL(string: fileNameUrl) else {return}
        let session = URLSession.shared
        let downloadTask = session.downloadTask(with: url) { (tempURL, response, error) in
            guard let tempURL = tempURL else {
                print("Error downloading file: \(error)")
                return
            }
            do {
                try FileManager.default.moveItem(at: tempURL, to: fileURL)
                print("File downloaded successfully!")
            } catch {
                print("Error moving file: \(error)")
            }
        }
        
        downloadTask.resume()
    }
    
}
