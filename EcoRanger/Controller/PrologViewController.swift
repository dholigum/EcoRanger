//
//  PrologViewController.swift
//  EcoRanger
//
//  Created by Syahrul Apple Developer BINUS on 03/04/21.
//

import UIKit
import AVKit
class PrologViewController: UIViewController {
//    var dataThumbail = [Thumbnail]()
    var chapterModel: Thumbnail?
    var ButtonPressSFX = AVAudioPlayer()
    var SFXAllowStatus = true
    @IBOutlet weak var thmbImage: UIView!
    @IBOutlet weak var thumbnailImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        labelChapter.text = chapterModel?.chapter
        thumbnailImage.image = UIImage(named: chapterModel!.imgthumbnail)
        //thumbnailImage.layer.cornerRadius = 20.0
        thumbnailImage.applyshadowWithCorner(containerView: thmbImage, cornerRadious: 10.0, shadowOpacity: 1)
//        thumbnailImage.layer.shadowColor = UIColor.black.cgColor
//        thumbnailImage.layer.shadowOpacity = 1
//        thumbnailImage.layer.shadowOffset = .zero
//        thumbnailImage.layer.shadowRadius = 20
        
    }
    
    
    @IBOutlet weak var labelChapter: UILabel!
    @IBAction func didUnwind(_ sender: UIStoryboardSegue){
        guard let tutorVC = sender.source as? TutorialViewController else { return }
        chapterModel = tutorVC.tutorModel
    }
    
    @IBAction func prevButtonPressed(_ sender: UIButton) {
        print("Prolog Prev Button Pressed!")
        SFXPlayer.shared.PlaySFX(SFXFileName: "ButtonPress")
    }
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "tutorialIdentiier", sender: self)
        print("Prolog Next Button Pressed!")
        SFXPlayer.shared.PlaySFX(SFXFileName: "ButtonPress")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "tutorialIdentiier"){
            let tutorVC = segue.destination as! TutorialViewController
            tutorVC.tutorModel = chapterModel
        }
    }
    
    
    
    @IBAction func btnPlay(_ sender: UIButton) {
        SFXPlayer.shared.PlaySFX(SFXFileName: "ButtonPress")
        guard let dataModel = chapterModel else { return }
        if let path =  Bundle.main.path(forResource: "\(dataModel.videoPath)", ofType: "mp4"){
            let video =  AVPlayer(url: URL(fileURLWithPath: path))
            let videoPlayer = AVPlayerViewController()
            videoPlayer.player = video
            MusicPlayer.shared.stopBackgroundMusic()
            present(videoPlayer, animated: true, completion: {
                video.play()
            })
        }
    }
    
    
    
}
