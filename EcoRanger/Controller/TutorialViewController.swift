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
    var ButtonPressSFX = AVAudioPlayer()
    var SFXAllowStatus = true
    @IBOutlet weak var containerTutorThumbnail: UIView!
    @IBOutlet weak var tutorThumbnail: UIImageView!
    @IBAction func PlayButton(_ sender: Any) {
        SFXPlayer.shared.PlaySFX(SFXFileName: "ButtonPress")
        guard let dataModel = tutorModel else { return }
        if let Path = Bundle.main.path(forResource: "\(dataModel.tutorPath)", ofType: "mp4")
        {
            let Video = AVPlayer(url: URL(fileURLWithPath: Path))
            let VideoPlayer = AVPlayerViewController()
            VideoPlayer.player = Video
            MusicPlayer.shared.stopBackgroundMusic()
            present(VideoPlayer, animated: true, completion:
                        {
                            Video.play()
                        })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tutorThumbnail.image = UIImage(named: tutorModel!.imgtutorthumbnail)
        tutorThumbnail.applyshadowWithCorner(containerView: containerTutorThumbnail, cornerRadious: 10.0, shadowOpacity: 0.5)
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        SFXPlayer.shared.PlaySFX(SFXFileName: "ButtonPress")
        
        print("to \(tutorModel?.gameStoryboard ?? "nil") Activity")
        print("to \(tutorModel?.gameIdentifier ?? "nil") Identifier")
        
        let storyboard = UIStoryboard(name: tutorModel?.gameStoryboard ?? "nil", bundle: nil)
        let navigation = storyboard.instantiateViewController(identifier: tutorModel?.gameIdentifier ?? "nil")
        self.present(navigation, animated: true, completion: nil)
        
    }
    
    override func unwind(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {
        if (unwindSegue.identifier == "backToProlog"){
            let prologVC = unwindSegue.destination as! PrologViewController
            prologVC.chapterModel = tutorModel
        }
    }
}
