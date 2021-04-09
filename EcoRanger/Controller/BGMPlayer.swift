//
//  BGMPlayer.swift
//  EcoRanger
//
//  Created by Christian Adiputra on 09/04/21.
//

import Foundation
import AVFoundation
class MusicPlayer{
    static let shared = MusicPlayer()
    var audioPlayer: AVAudioPlayer?
    func startBackgroundMusic(bgmFIleName: String) {
            if let bundle = Bundle.main.path(forResource: bgmFIleName, ofType: "mp3") {
                let backgroundMusic = NSURL(fileURLWithPath: bundle)
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: backgroundMusic as URL)
                    guard let audioPlayer = audioPlayer else {return}
                    audioPlayer.numberOfLoops = -1
                    audioPlayer.prepareToPlay()
                    audioPlayer.play()
                } catch  {
                    print(error)
                }
        }
    }

    func stopBackgroundMusic() {
        guard let audioPlayer = audioPlayer else { return }
        audioPlayer.stop()
    }

}
