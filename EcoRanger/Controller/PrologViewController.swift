//
//  PrologViewController.swift
//  EcoRanger
//
//  Created by Syahrul Apple Developer BINUS on 03/04/21.
//

import UIKit
import AVKit
class PrologViewController: UIViewController {
    
    var chapterModel: Thumbnail?

    override func viewDidLoad() {
        super.viewDidLoad()
        labelChapter.text = chapterModel!.chapter
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBOutlet weak var labelChapter: UILabel!
    
    
    @IBAction func prevButtonPressed(_ sender: UIButton) {
        print("Prolog Prev Button Pressed!")
    }
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        print("Prolog Next Button Pressed!")
    }
    
    @IBAction func btnPlay(_ sender: UIButton) {
        guard let dataModel = chapterModel else { return }
        if let path =  Bundle.main.path(forResource: "\(dataModel.videoPath)", ofType: "mp4"){
            let video =  AVPlayer(url: URL(fileURLWithPath: path))
            let videoPlayer = AVPlayerViewController()
            videoPlayer.player = video
            
            present(videoPlayer, animated: true, completion: {
                video.play()
            })
        }
    }
    
    private func setupView() {
        guard let dataModel = chapterModel else { return }
        print(dataModel.chapter)
    }
    
    
}
