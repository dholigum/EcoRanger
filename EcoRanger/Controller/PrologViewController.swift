//
//  PrologViewController.swift
//  EcoRanger
//
//  Created by Syahrul Apple Developer BINUS on 03/04/21.
//

import UIKit
import AVKit
class PrologViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func prevButtonPressed(_ sender: UIButton) {
        print("Prolog Prev Button Pressed!")
    }
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        print("Prolog Next Button Pressed!")
    }
    
    @IBAction func btnPlay(_ sender: UIButton) {
        if let path =  Bundle.main.path(forResource: "s1c1", ofType: "mp4"){
            let video =  AVPlayer(url: URL(fileURLWithPath: path))
            let videoPlayer = AVPlayerViewController()
            videoPlayer.player = video
            
            present(videoPlayer, animated: true, completion: {
                video.play()
            })
        }
    }
    
    
}
