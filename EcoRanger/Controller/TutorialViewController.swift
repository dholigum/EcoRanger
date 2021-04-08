//
//  TutorialViewController.swift
//  EcoRanger
//
//  Created by Syahrul Apple Developer BINUS on 03/04/21.
//

import UIKit
import AVKit

class TutorialViewController: UIViewController {
    var tutorModel: Thumbnail?
    
    @IBAction func PlayButton(_ sender: Any) {
        guard let dataModel = tutorModel else { return }
        if let Path = Bundle.main.path(forResource: "\(dataModel.videoPath)", ofType: "mp4")
        {
            let Video = AVPlayer(url: URL(fileURLWithPath: Path))
            let VideoPlayer = AVPlayerViewController()
            VideoPlayer.player = Video
            // VideoPlayer.showsPlaybackControls = false
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
    
    @IBAction func backTutor(_ sender: UIStoryboardSegue){
        guard let gameVC = sender.source as? GameActivityViewController else { return }
        tutorModel = gameVC.gameModel
    }
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "gameIdentifier", sender: self)
        print("Tutorial Button Pressed")
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "gameIdentifier"){
            let gameVC = segue.destination as! GameActivityViewController
            gameVC.gameModel = tutorModel
        }
    }
    override func unwind(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {
        if (unwindSegue.identifier == "backToProlog"){
            let prologVC = unwindSegue.destination as! PrologViewController
            prologVC.chapterModel = tutorModel
        }
    }
}
