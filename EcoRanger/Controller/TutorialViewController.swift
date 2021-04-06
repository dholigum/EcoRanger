//
//  TutorialViewController.swift
//  EcoRanger
//
//  Created by Syahrul Apple Developer BINUS on 03/04/21.
//

import UIKit
import AVKit

class TutorialViewController: UIViewController {

    @IBAction func PlayButton(_ sender: Any) {
        if let Path = Bundle.main.path(forResource: "s1c1", ofType: "mp4")
        {
            let Video = AVPlayer(url: URL(fileURLWithPath: Path))
            let VideoPlayer = AVPlayerViewController()
            VideoPlayer.player = Video
            
            present(VideoPlayer, animated: true, completion:
            {
                Video.play()
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func prevButtonPressed(_ sender: UIButton) {
        print("Tutorial Button Pressed")
    }
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        print("Tutorial Button Pressed")
    }
    
}
