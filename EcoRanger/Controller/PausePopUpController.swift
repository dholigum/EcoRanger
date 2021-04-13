//
//  PausePopUpController.swift
//  EcoRanger
//
//  Created by Samlo Berutu on 09/04/21.
//

import UIKit
import SpriteKit


protocol PausePopUpControllerDelegate: class {
    func backToHome()
    func resumeGame()
}

class PausePopUpController: UIView {

    static let instance = PausePopUpController()
    //let gameMosquito = SlapMosquitoGameScene()
    @IBOutlet var parentView:UIView!
    @IBOutlet var childView:UIView!
    @IBOutlet var resumeBtn:UIButton!
    @IBOutlet var homeBtn:UIButton!
    @IBOutlet var settingBtn:UIView!
    weak var delegate:PausePopUpControllerDelegate?
    @IBAction func resumeButton(_ sender: Any) {
        print("resume button")
        self.delegate?.resumeGame()
        parentView.removeFromSuperview()
        //gameScene.isPaused = false
        //gameScene.physicsWorld.speed = 1
        //let scene: SlapMosquitoGameScene = SlapMosquitoGameScene(size: skview.frame.size)
//        gameMosquito.view?.isPaused = false
//        gameMosquito.isPaused = false
//        let scene: SlapMosquitoGameScene = SlapMosquitoGameScene(size: skview.frame.size)
//        skview.presentScene(gameMosquito)
//            gameMosquito.physicsWorld.speed = 1
//            gameMosquito.speed = 1.0
    }
    @IBAction func homeButton(_ sender: Any) {
      delegate?.backToHome()
        
    }
    @IBAction func settingButton(_ sender: Any) {
        print("setting button")
        SettingPopUpController.instance.showAlert()
        parentView.removeFromSuperview()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("PausePopUp", owner: self, options: nil)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit(){
        resumeBtn.layer.cornerRadius = 5
        homeBtn.layer.cornerRadius = 5
        settingBtn.layer.cornerRadius = 5
        
        parentView.bounds = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
    }
    func showPausePopUp() {
        print("pause pop up")
        UIApplication.shared.keyWindow?.addSubview(parentView)
    }
    
//    @objc func backToHome(){
//         let destinationVC = SlapMosquitoGameViewController()
//        //navVC.delegate = self
//        destinationVC.tempPaused = true
//        self.pushViewController(destinationVC, animated: true)
//    }
    
    

}
