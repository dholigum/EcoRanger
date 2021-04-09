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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelChapter.text = chapterModel?.chapter
        // Do any additional setup after loading the view.
        
        //Prepare SFX on Button Press
        do{
            ButtonPressSFX = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath:  Bundle.main.path(forResource: "ButtonPress", ofType: ".wav")!))
            ButtonPressSFX.prepareToPlay()
        }
        catch{
            print(error)
        }
    }
    
    
    
    @IBOutlet weak var labelChapter: UILabel!
    @IBAction func didUnwind(_ sender: UIStoryboardSegue){
        guard let tutorVC = sender.source as? TutorialViewController else { return }
        chapterModel = tutorVC.tutorModel
    }
    
    @IBAction func prevButtonPressed(_ sender: UIButton) {
        print("Prolog Prev Button Pressed!")
        if SFXAllowStatus
        {
            if ButtonPressSFX.isPlaying
            {
                ButtonPressSFX.stop()
            }
            ButtonPressSFX.play()
        }
    }
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "tutorialIdentiier", sender: self)
        print("Prolog Next Button Pressed!")
        if SFXAllowStatus
        {
            if ButtonPressSFX.isPlaying
            {
                ButtonPressSFX.stop()
            }
            ButtonPressSFX.play()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "tutorialIdentiier"){
            let tutorVC = segue.destination as! TutorialViewController
            tutorVC.tutorModel = chapterModel
        }
    }
    
    
    
    @IBAction func btnPlay(_ sender: UIButton) {
        if SFXAllowStatus
        {
            if ButtonPressSFX.isPlaying
            {
                ButtonPressSFX.stop()
            }
            ButtonPressSFX.play()
        }
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
//    
//    private func setupView() {
//        guard let dataModel = chapterModel else { return }
//        print(dataModel.chapter)
//    }
    
    
    
}
