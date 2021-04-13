//
//  TruckGameViewController.swift
//  EcoRanger
//
//  Created by Syahrul Apple Developer BINUS on 08/04/21.
//

import UIKit
import SpriteKit

class SlapMosquitoGameViewController: UIViewController, PausePopUpControllerDelegate {
    func resumeGame() {
        ispausedon = false
        skview.isPaused = ispausedon
    }
    
    func backToHome() {
        let storyboard = UIStoryboard(name: "Main" ?? "nil", bundle: nil)
        let navigation = storyboard.instantiateViewController(identifier: "mainView" ?? "nil")
        self.present(navigation, animated: true, completion: nil)
    }
    
    var gameModel: Thumbnail?
   // var mosquitoScene: SlapMosquitoGameScene!
    var tempPaused = true
    var ispausedon = true
//    var time = 20
    @IBOutlet weak var skview: SKView!
//    @IBOutlet weak var pauseBtn: UIButton!
    
    @IBAction func pauseButton(_ sender: UIButton) {
        //let scene: SlapMosquitoGameScene = SlapMosquitoGameScene(size: skview.frame.size)
        ispausedon = true
        PausePopUpController.instance.showPausePopUp()
        //mosquitoScene.gameIsPaused = true
        //mosquitoScene!.pauseButtoPressed(sender: sender)
        //scene.view?.isPaused = true
        //scene.physicsWorld.speed = 0

        skview.isPaused = ispausedon
    }
    
//    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        if let view = self.view as! SKView?{
//            if let scene = SKScene(fileNamed: "SlapMosquitoGameScene"){
//            scene.scaleMode = .aspectFIll
//            view.presentScene(scene)
//        }
        let scene: SlapMosquitoGameScene = SlapMosquitoGameScene(size: skview.frame.size)
//       print(time)
        //mosquitoScene = scene
        skview.presentScene(scene)
        PausePopUpController.instance.delegate = self
//        if pauseBtn?.isTouchInside == true {
//            skview.isPaused = true
//        }
//        scene.view?.isPaused = true
        //print("sisa \(scene.mosquitoleft)")
    }

}
