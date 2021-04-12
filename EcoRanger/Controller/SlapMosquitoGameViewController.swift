//
//  TruckGameViewController.swift
//  EcoRanger
//
//  Created by Syahrul Apple Developer BINUS on 08/04/21.
//

import UIKit
import SpriteKit

class SlapMosquitoGameViewController: UIViewController {
    var gameModel: Thumbnail?
//    var time = 20
    @IBOutlet weak var skview: SKView!
    @IBAction func pauseButton(_ sender: UIButton) {
        SFXPlayer.shared.PlaySFX(SFXFileName: "ButtonPress")
        let scene: SlapMosquitoGameScene = SlapMosquitoGameScene(size: skview.frame.size)
        PausePopUpController.instance.showPausePopUp()
        scene.view?.isPaused = true
        
    }
    
//    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let scene: SlapMosquitoGameScene = SlapMosquitoGameScene(size: skview.frame.size)
//       print(time)
        skview.presentScene(scene)
        
//        scene.view?.isPaused = true
        //print("sisa \(scene.mosquitoleft)")
    }
//    var timerGame = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(Action), userInfo: nil, repeats: true)
//    @objc func Action(){
//        time -= 1
//        timeLabel.text = String(time)
//
//    }
}
