//
//  TruckGameViewController.swift
//  EcoRanger
//
//  Created by Syahrul Apple Developer BINUS on 08/04/21.
//

import UIKit
import SpriteKit

class SlapMosquitoGameViewController: UIViewController, PausePopUpControllerDelegate, CustomViewDelegate {
    var flagGame = 2
    func goToNextScene() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        CoreDataHandle.initCoreData(appDelegate)
        
        CoreDataHandle.updateIsActiveStatus(id: 3, isActive: true)
        
        let storyboard = UIStoryboard(name: "Main" , bundle: nil)
        let navigation = storyboard.instantiateViewController(identifier: "mainView" )
        self.present(navigation, animated: true, completion: nil)
    }
    
    func backToGame() {
        if flagGame == 1 {
            let storyboard = UIStoryboard(name: "YesOrNoStoryboard" , bundle: nil)
            let navigation = storyboard.instantiateViewController(identifier: "YesOrNo" )
            self.present(navigation, animated: true, completion: nil)
        } else{
            let storyboard = UIStoryboard(name: "SlapMosquitoGame" , bundle: nil)
            let navigation = storyboard.instantiateViewController(identifier: "slapMosquitoGame" )
            self.present(navigation, animated: true, completion: nil)
        }
    }
    
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
    var ispausedon = true
    var statusGame = 2
//    var time = 20
    @IBOutlet weak var skview: SKView!
//    @IBOutlet weak var pauseBtn: UIButton!
    
    @IBAction func pauseButton(_ sender: UIButton) {
        SFXPlayer.shared.PlaySFX(SFXFileName: "ButtonPress")
        let scene: SlapMosquitoGameScene = SlapMosquitoGameScene(size: skview.frame.size)
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
        skview.presentScene(scene)
        PausePopUpController.instance.delegate = self
        GameResultPopUpController.instance.delegate = self
        

    }

}
