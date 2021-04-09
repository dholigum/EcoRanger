//
//  YesorNoViewController.swift
//  EcoRanger
//
//  Created by Christian Adiputra on 09/04/21.
//

import UIKit
import SpriteKit
import AVFoundation

class YesorNoViewController: UIViewController {

    var objectGames =  [DataImage]()
    var objFlags = 0
    var life = 3
    var loseMessage = UIAlertController(title: "Confirm", message: "Kamu payah!", preferredStyle: .alert)
    
    let iyanih = UIAlertAction(title: "Setuju!", style: .default, handler: { (action) -> Void in
        print("Ok button tapped")
    })
    
    var selectedObj = DataImage()
    //SwitcherMusic
//    @IBOutlet var switcher: UISwitch!
//    @IBAction func bgmSwitcher(_ sender: UISwitch) {
//        if sender.isOn{
//            MusicPlayer.shared.startBackgroundMusic(bgmFIleName: "homemusic")
//        }else{
//            MusicPlayer.shared.stopBackgroundMusic()
//        }
//    }
    @IBOutlet weak var bgGame: UIImageView!
    
    func imgBlur(){
        bgGame.frame = view.bounds
        bgGame.contentMode = .scaleToFill
        view.addSubview(bgGame)
        let blurEffect = UIBlurEffect(style: .dark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = bgGame.bounds
        view.addSubview(blurredEffectView)
    }
    
    
    @IBAction func btnPause(_ sender: UIButton) {
        PausePopUpController.instance.showPausePopUp()
    }
    @IBOutlet weak var objectView: UIImageView!
    @IBAction func btnYes(_ sender: UIButton) {
        if life >= 1 {
            if objFlags<10 {
                selectedObj = objectGames[objFlags]
                //var randomInt = Int.random(in: 0...14)
                if selectedObj.imgId == "toys" {
                    life -= 1
//                    objFlags += 1
                    if life == 0 {
                        GameResultPopUpController.instance.showResultView(alertType: .failure)
                        //alert message for debug
//                        loseMessage.addAction(iyanih)
//                        self.present(loseMessage, animated: true, completion: nil)
                    }
                }
                objFlags += 1
                selectedObj = objectGames[objFlags]
                objectView.image = UIImage(named: selectedObj.imgSource)
            }
            else{
                GameResultPopUpController.instance.showResultView(alertType: .success)
            }
        }
        
        print("obj ke = \(objFlags)")
        print("Nyawa = \(life)")
        

    }
    @IBAction func btnNo(_ sender: UIButton) {
        if life >= 1 {
            if objFlags<10 {
                selectedObj = objectGames[objFlags]
                if selectedObj.imgId == "trash" {
                    life -= 1
                    if life==0 {
                        GameResultPopUpController.instance.showResultView(alertType: .failure)
//                        loseMessage.addAction(iyanih)
//                        self.present(loseMessage, animated: true, completion: nil)
                    }
                }
                objFlags += 1
                selectedObj = objectGames[objFlags]
                objectView.image = UIImage(named: selectedObj.imgSource)
            } else{
                GameResultPopUpController.instance.showResultView(alertType: .success)
            }
        }
        
        print("obj ke = \(objFlags)")
        print("Nyawa = \(life)")
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //popUp setting button
        
        initDataImage()
        MusicPlayer.shared.startBackgroundMusic(bgmFIleName: "MainMenuBGM")
        print("obj ke = \(objFlags)")
        print("Nyawa = \(life)")
        if objFlags==10{
            GameResultPopUpController.instance.showResultView(alertType: .success)
        }
//        for objectGame in objectGames {
//            print(objectGame.imgSource)
//        }
        
        
    }
    
    func initDataImage() {
        let data1 = DataImage(imgId: "toys", imgSource: "toys-1")
        let data2 = DataImage(imgId: "toys", imgSource: "toys-2")
        let data3 = DataImage(imgId: "toys", imgSource: "toys-3")
        let data4 = DataImage(imgId: "toys", imgSource: "toys-4")
        let data5 = DataImage(imgId: "toys", imgSource: "toys-5")
        let data6 = DataImage(imgId: "trash", imgSource: "Trash-1")
        let data7 = DataImage(imgId: "trash", imgSource: "Trash-2")
        let data8 = DataImage(imgId: "trash", imgSource: "Trash-3")
        let data9 = DataImage(imgId: "trash", imgSource: "Trash-4")
        let data10 = DataImage(imgId: "trash", imgSource: "Trash-5")
        let data11 = DataImage(imgId: "trash", imgSource: "Trash-6")
        let data12 = DataImage(imgId: "trash", imgSource: "Trash-7")
        let data13 = DataImage(imgId: "trash", imgSource: "Trash-8")
        let data14 = DataImage(imgId: "trash", imgSource: "Trash-9")
        let data15 = DataImage(imgId: "trash", imgSource: "Trash-10")
        
        objectGames.append(data1)
        objectGames.append(data2)
        objectGames.append(data3)
        objectGames.append(data4)
        objectGames.append(data5)
        objectGames.append(data6)
        objectGames.append(data7)
        objectGames.append(data8)
        objectGames.append(data9)
        objectGames.append(data10)
        objectGames.append(data11)
        objectGames.append(data12)
        objectGames.append(data13)
        objectGames.append(data14)
        objectGames.append(data15)
        
        objectGames.shuffle()
        
        objectView.image = UIImage(named: objectGames[0].imgSource)
//        objFlags = 0
    }
}
