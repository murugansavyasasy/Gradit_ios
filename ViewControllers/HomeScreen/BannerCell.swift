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
    @IBOutlet weak var pageController: UIPageControl!
    
    var emergencyVoices : [EmergencyDashTypes] = []
    var onViewAll: (() -> Void)?
    private var priority: String? = UserDefaults.standard.string(forKey: DefaultsKeys.priority)
    private weak var activeCell: EmergencyVoiceCV?
    private var autoScrollTimer: Timer?
    private var isUserDragging = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
        self.priority = UserDefaults.standard.string(forKey: DefaultsKeys.priority)
        viewAllBtn.layer.cornerRadius = viewAllBtn.frame.height / 2
        cv.register(UINib(nibName: "EmergencyVoiceCV", bundle: nil), forCellWithReuseIdentifier: "EmergencyVoiceCV")
        cv.delegate = self
        cv.dataSource = self
        pageController.currentPageIndicatorTintColor = colorForPriority()
        
    }
    
    func configure(Data: [EmergencyDashTypes]) {
        emergencyVoices = Data
        pageController.numberOfPages = emergencyVoices.count
        pageController.currentPage = 0
        pageController.hidesForSinglePage = true
        cv.reloadData()
        restartAutoScrollTimer()
    }
    
    @IBAction func viewAllAct(_ sender: Any) {
        onViewAll?()
    }
    
    private func restartAutoScrollTimer() {
        autoScrollTimer?.invalidate()
        autoScrollTimer = nil
        
        guard emergencyVoices.count > 1 else { return }
        
        autoScrollTimer = Timer.scheduledTimer(
            withTimeInterval: 5.0,
            repeats: false
        ) { [weak self] _ in
            self?.autoScrollToNextPage()
        }
    }

    private func autoScrollToNextPage() {
        guard !emergencyVoices.isEmpty else { return }
        
        let currentPage = pageController.currentPage
        let nextPage = (currentPage + 1) % emergencyVoices.count
        
        pageController.currentPage = nextPage
        
        let targetX = CGFloat(nextPage) * cv.bounds.width
        
        cv.setContentOffset(
            CGPoint(x: targetX, y: 0),
            animated: true
        )
        
        // Start a fresh 5-second countdown
        restartAutoScrollTimer()
    }
    
    @IBAction func pageChanged(_ sender: UIPageControl) {
        restartAutoScrollTimer()
        let targetX = CGFloat(sender.currentPage) * cv.bounds.width
        cv.setContentOffset(CGPoint(x: targetX, y: 0), animated: true)

    }
    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//
//        guard scrollView == cv else { return }
//
//        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width)
//        pageController.currentPage = page
//    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        guard scrollView == cv else { return }
        
        isUserDragging = true
        
        // User started interacting → reset countdown
        restartAutoScrollTimer()
    }

    func scrollViewDidEndDragging(
        _ scrollView: UIScrollView,
        willDecelerate decelerate: Bool
    ) {
        guard scrollView == cv else { return }
        
        isUserDragging = false
        
        // Restart from 0 after the user's interaction finishes.
        if !decelerate {
            updatePageControl()
            restartAutoScrollTimer()
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard scrollView == cv else { return }
        
        updatePageControl()
        
        // User finished manually scrolling.
        // Start a fresh 5-second countdown.
        restartAutoScrollTimer()
    }
    
    private func updatePageControl() {
        guard cv.bounds.width > 0 else { return }
        
        let page = Int(
            round(cv.contentOffset.x / cv.bounds.width)
        )
        
        let validPage = max(
            0,
            min(page, emergencyVoices.count - 1)
        )
        
        pageController.currentPage = validPage
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
            return UIColor.systemBackground // fallback color
        }
    }
}

extension BannerCell: UICollectionViewDelegate,
                     UICollectionViewDataSource,
                     UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return emergencyVoices.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "EmergencyVoiceCV",
            for: indexPath
        ) as! EmergencyVoiceCV

        let voice = emergencyVoices[indexPath.row]

        // MARK: - Basic Details

        let sentByString = "Posted by : " + (voice.membername ?? "")
        
       let attributedString = NSMutableAttributedString(string: sentByString)
        
        attributedString.addAttributes(
            [
                .foregroundColor : UIColor.black,
                .font: UIFont.systemFont(ofSize: 13, weight: .regular)
            ],
            range: NSRange(location: 0, length: "Posted by : ".count)
        )
        attributedString.addAttributes(
            [
                .foregroundColor: colorForPriority() ?? .purple,
                .font: UIFont.systemFont(ofSize: 14, weight: .medium)
            ],
            range: NSRange(location: "Posted by : ".count, length: voice.membername?.count ?? 0)
        )
        
        cell.titleLbl.text = voice.description
        cell.sentbyLbl.attributedText = attributedString

        // MARK: - Date & Time

        if let createdOn = voice.createdon {

            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "dd/MM/yyyy hh:mm:ss a"
            inputFormatter.locale = Locale(identifier: "en_US_POSIX")

            if let date = inputFormatter.date(from: createdOn) {

                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                dateFormatter.locale = Locale(identifier: "en_US_POSIX")

                let timeFormatter = DateFormatter()
                timeFormatter.dateFormat = "hh:mm a"
                timeFormatter.locale = Locale(identifier: "en_US_POSIX")

                cell.DateLbl.text = dateFormatter.string(from: date)
                cell.timeLbl.text = timeFormatter.string(from: date)

            } else {
                cell.DateLbl.text = "--/--/----"
                cell.timeLbl.text = "--:--"
            }

        } else {
            cell.DateLbl.text = "--/--/----"
            cell.timeLbl.text = "--:--"
        }

        // MARK: - Initial Duration

        let apiDuration = voice.duration ?? 0

        cell.durationLbl.text = "00:00 / \(formatDuration(Double(apiDuration)))"

        cell.slider.minimumValue = 0
        cell.slider.maximumValue = 1
        cell.slider.value = 0
        
        if voice.voicefilepath != nil, voice.voicefilepath == AudioPlayerManager.shared.currentURL, AudioPlayerManager.shared.isPlaying {
            cell.playBtn.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        } else {
            cell.playBtn.setImage(UIImage(systemName: "play"), for: .normal)
        }

        // MARK: - Play Action
        
        cell.audioURL = voice.voicefilepath

        cell.playAction = { [weak self, weak cell] in
            guard let cell = cell else { return }
            guard let audioURL = voice.voicefilepath, !audioURL.isEmpty else { return }

            let manager = AudioPlayerManager.shared

            // Tapped the cell whose audio is CURRENTLY playing -> pause it
            if manager.isPlaying && manager.currentURL == audioURL {
                manager.pause()
                cell.playBtn.setImage(UIImage(systemName: "play"), for: .normal)
                return
            }

            // Switching to a different audio -> reset the PREVIOUS active cell explicitly
            if let previousCell = self?.activeCell, previousCell !== cell {
                previousCell.playBtn.setImage(UIImage(systemName: "play"), for: .normal)
                previousCell.slider.value = 0
                previousCell.durationLbl.text = "00:00 / \(previousCell.durationLbl.text?.components(separatedBy: " / ").last ?? "00:00")"
            }

            if manager.currentURL == audioURL {
                manager.resume()
            } else {
                manager.play(urlString: audioURL)
            }

            self?.activeCell = cell
            cell.playBtn.setImage(UIImage(systemName: "pause.fill"), for: .normal)

            manager.onProgress = { [weak cell] progress, currentTime, totalDuration in
                guard let cell = cell else { return }
                cell.slider.value = progress
                cell.durationLbl.text =
                    "\(self?.formatDuration(currentTime) ?? "00:00") / \(self?.formatDuration(totalDuration) ?? "00:00")"
            }

            manager.onFinish = { [weak cell] in
                guard let cell = cell else { return }
                cell.slider.value = 0
                cell.durationLbl.text = "00:00 / \(self?.formatDuration(Double(voice.duration ?? 0)) ?? "00:00")"
                cell.playBtn.setImage(UIImage(systemName: "play"), for: .normal)
                self?.activeCell = nil
            }
            
            // in BannerCell, when you configure playAction, also set:
           manager.onStopped = { [weak self] in
                guard let self = self, let cell = self.activeCell else { return }
                cell.playBtn.setImage(UIImage(systemName: "play"), for: .normal)
                cell.slider.value = 0
                self.activeCell = nil
            }
        }

        // MARK: - Slider
        
        cell.sliderChanged = { value in
            AudioPlayerManager.shared.seek(value: value)
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = collectionView.frame.width //- 30

        return CGSize(width: width,height: 195)
    }
    
    func formatDuration(_ seconds: Double) -> String {

        guard seconds.isFinite, seconds >= 0 else {
            return "00:00"
        }

        let minutes = Int(seconds) / 60
        let seconds = Int(seconds) % 60

        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    private func resetOtherPlayButtons(in collectionView: UICollectionView, except exceptCell: EmergencyVoiceCV) {
        for case let otherCell as EmergencyVoiceCV in collectionView.visibleCells where otherCell !== exceptCell {
            otherCell.playBtn.setImage(UIImage(systemName: "play"), for: .normal)
            otherCell.slider.value = 0
        }
    }
}


import AVFoundation

final class AudioPlayerManager {

    static let shared = AudioPlayerManager()
    
    private(set) var currentURL: String?

    private var player: AVPlayer?
    private var timeObserver: Any?

    var onProgress: ((Float, Double, Double) -> Void)?
    var onFinish: (() -> Void)?
    var onStopped: (() -> Void)?

    var isPlaying: Bool {
        player?.timeControlStatus == .playing
    }

    private init() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(appDidEnterBackground),
            name: UIApplication.didEnterBackgroundNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(appDidEnterBackground),
            name: UIApplication.willResignActiveNotification,
            object: nil
        )
    }

    @objc private func appDidEnterBackground() {
        stop()
    }

    // MARK: - Play

    func play(urlString: String) {

        guard let url = URL(string: urlString) else {
            return
        }

        stop()

        currentURL = urlString

        let item = AVPlayerItem(url: url)

        player = AVPlayer(playerItem: item)

        addTimeObserver()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(playerDidFinish),
            name: .AVPlayerItemDidPlayToEndTime,
            object: item
        )

        player?.play()
    }

    // MARK: - Pause

    func pause() {
        player?.pause()
    }

    // MARK: - Resume

    func resume() {
        
        guard let player = player,
              let duration = player.currentItem?.duration.seconds else {
            return
        }
        
        let currentTime = player.currentTime().seconds
        
        // Audio has finished → restart from beginning
        if duration.isFinite && currentTime >= duration {
            
            player.seek(
                to: CMTime(seconds: 0, preferredTimescale: 600)
            ) { _ in
                player.play()
            }
            
        } else {
            // Normal pause → resume from current position
            player.play()
        }
    }

    // MARK: - Stop

    func stop() {

        if let observer = timeObserver {
            player?.removeTimeObserver(observer)
            timeObserver = nil
        }

        if let currentItem = player?.currentItem {
            NotificationCenter.default.removeObserver(
                self,
                name: .AVPlayerItemDidPlayToEndTime,
                object: currentItem
            )
        }

        let wasPlaying = player != nil

        player?.pause()
        player = nil
        currentURL = nil

        if wasPlaying {
            onStopped?()
        }
    }

    // MARK: - Seek

    func seek(value: Float) {

        guard let duration = player?.currentItem?.duration.seconds,
              duration.isFinite else {
            return
        }

        let seconds = Double(value) * duration

        let time = CMTime(
            seconds: seconds,
            preferredTimescale: 600
        )

        player?.seek(to: time)
    }

    // MARK: - Time Observer

    private func addTimeObserver() {

        let interval = CMTime(
            seconds: 0.2,
            preferredTimescale: 600
        )

        timeObserver = player?.addPeriodicTimeObserver(
            forInterval: interval,
            queue: .main
        ) { [weak self] time in

            guard let self = self else {
                return
            }

            guard let duration = self.player?.currentItem?.duration.seconds,
                  duration.isFinite,
                  duration > 0 else {
                return
            }

            let currentTime = time.seconds

            let progress = Float(
                currentTime / duration
            )

            self.onProgress?(
                progress,
                currentTime,
                duration
            )
        }
    }

    // MARK: - Finished

    @objc
    private func playerDidFinish() {
        
        guard let player = player else {
            onFinish?()
            return
        }
        
        player.pause()
        
        player.seek(
            to: CMTime(seconds: 0, preferredTimescale: 600)
        )
        
        onFinish?()
    }
}
