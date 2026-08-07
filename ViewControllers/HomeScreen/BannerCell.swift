//
//  BannerCell.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 30/07/26.
//

import UIKit

class BannerCell: UITableViewCell {
    
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var viewAllBtn: UIButton!
    @IBOutlet weak var cv: UICollectionView!
    
    var emergencyVoices : [EmergencyDashTypes] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
        viewAllBtn.layer.cornerRadius = viewAllBtn.frame.height / 2
        cv.register(UINib(nibName: "EmergencyVoiceCV", bundle: nil), forCellWithReuseIdentifier: "EmergencyVoiceCV")
        cv.delegate = self
        cv.dataSource = self
        
    }
    
    func configure(Data: [EmergencyDashTypes]) {
        emergencyVoices = Data
        cv.reloadData()
    }
    
    @IBAction func viewAllAct(_ sender: Any) {
        
    }
    
}

extension BannerCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        emergencyVoices.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmergencyVoiceCV", for: indexPath) as! EmergencyVoiceCV
        
        let voice = emergencyVoices[indexPath.row]
        
        cell.titleLbl.text = voice.description
        cell.DateLbl.text = voice.createdon
        cell.sentbyLbl.text = voice.membername
        cell.durationLbl.text = String(voice.duration ?? 0)
        
        cell.playAction = { [weak self, weak cell] in

            guard let cell = cell else { return }

            // If same audio is already playing -> Pause
            if AudioPlayerManager.shared.isPlaying {

                AudioPlayerManager.shared.pause()

                cell.playBtn.setImage(
                    UIImage(systemName: "play.fill"),
                    for: .normal
                )

                return
            }

            // Play audio
            /*guard*/ let audioURL = "https://gradit-communication.s3.ap-south-1.amazonaws.com/voice/2026-07-31/1/12_1_File_20260731054903625.wav" //else { return }   // <-- Replace with your model property

            AudioPlayerManager.shared.play(urlString: audioURL)

            cell.playBtn.setImage(
                UIImage(systemName: "pause.fill"),
                for: .normal
            )

            // Update slider
            AudioPlayerManager.shared.onProgress = { [weak cell] progress, currentTime in

                guard let cell = cell else { return }

                DispatchQueue.main.async {

                    cell.slider.value = progress

                    let minutes = Int(currentTime) / 60
                    let seconds = Int(currentTime) % 60

                    cell.timeLbl.text = String(format: "%02d:%02d",
                                               minutes,
                                               seconds)
                }
            }

            // Playback finished
            AudioPlayerManager.shared.onFinish = { [weak cell] in

                guard let cell = cell else { return }

                DispatchQueue.main.async {

                    cell.slider.value = 0
                    cell.timeLbl.text = "00:00"

                    cell.playBtn.setImage(
                        UIImage(systemName: "play.fill"),
                        for: .normal
                    )
                }
            }
        }
        

            cell.sliderChanged = { value in
                AudioPlayerManager.shared.seek(value: value)
            }

        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = collectionView.frame.width - 30
        
        return CGSize(width: width, height: 180)
    }
   
}


import AVFoundation

final class AudioPlayerManager {

    static let shared = AudioPlayerManager()

    private var player: AVPlayer?
    private var timeObserver: Any?

    var onProgress: ((Float, Double) -> Void)?
    var onFinish: (() -> Void)?
    
    var isPlaying: Bool {
        player?.timeControlStatus == .playing
    }

    private init() {}

    func play(urlString: String) {

        guard let url = URL(string: urlString) else { return }

        stop()

        let item = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: item)

        addTimeObserver()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(playerDidFinish),
            name: .AVPlayerItemDidPlayToEndTime,
            object: item)

        player?.play()
    }

    func pause() {
        player?.pause()
    }

    func resume() {
        player?.play()
    }

    func stop() {

        if let observer = timeObserver {
            player?.removeTimeObserver(observer)
            timeObserver = nil
        }

        player?.pause()
        player = nil
    }

    func seek(value: Float) {

        guard let duration = player?.currentItem?.duration.seconds,
              duration.isFinite else { return }

        let seconds = Double(value) * duration

        let time = CMTime(seconds: seconds,
                          preferredTimescale: 600)

        player?.seek(to: time)
    }

    private func addTimeObserver() {

        let interval = CMTime(seconds: 0.2,
                              preferredTimescale: 600)

        timeObserver = player?.addPeriodicTimeObserver(
            forInterval: interval,
            queue: .main) { [weak self] time in

                guard
                    let duration = self?.player?.currentItem?.duration.seconds,
                    duration.isFinite
                else { return }

                let progress = Float(time.seconds / duration)

                self?.onProgress?(progress, time.seconds)
            }
    }

    @objc
    private func playerDidFinish() {
        onFinish?()
    }
}
