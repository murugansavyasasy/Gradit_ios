//
//  audioPlayer.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 12/02/23.
//

import Foundation
import UIKit
import AVFAudio
class AudioPlayer {
    
    var audioFile:AVAudioFile
    var engine:AVAudioEngine
    var playerNodes = [AVAudioPlayerNode]()
    var mixer: AVAudioMixerNode
    var timer: Timer!
    init (_ url: URL) {
        audioFile = try! AVAudioFile(forReading: url)
        engine = AVAudioEngine()
        mixer = AVAudioMixerNode()
        
        engine.attach(mixer)
        engine.connect(mixer, to: engine.outputNode, format: nil)
        createNodes()
    }
    
    private func createNodes() {
        for _ in 0...3 {
            let node = AVAudioPlayerNode()
            playerNodes += [node]
        }
    }
    
    func start() {
        for node in playerNodes {
            engine.attach(node)
            engine.connect(node, to: mixer, format: nil)
            node.scheduleFile(audioFile, at: nil, completionHandler: nil)
            try! engine.start()
        }
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {[unowned self] timer in
            for node in self.playerNodes {
                guard let nodeTime = node.lastRenderTime,
                let playerTime = node.playerTime(forNodeTime: nodeTime) else {
                    continue
                }
                
                let secs = Double(playerTime.sampleTime) / playerTime.sampleRate
                print(secs)
            }
        }
        DispatchQueue.global().async { [unowned self] in
            for node in self.playerNodes {
                sleep(1)
                node.play()
            }
        }
    }
}
