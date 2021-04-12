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
    var selectedObj = DataImage()
    var objFlags = 0
    var life = 3
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var objectView: UIImageView!
    @IBOutlet weak var bgGame: UIImageView!
    
    
    @IBAction func btnPause(_ sender: UIButton) {
        PausePopUpController.instance.showPausePopUp()
    }
    
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
    }
    
    @IBAction func btnNo(_ sender: UIButton) {
        if life >= 1 {
            if objFlags<10 {
                selectedObj = objectGames[objFlags]
                if selectedObj.imgId == "trash" {
                    life -= 1
                    if life==0 {
                        GameResultPopUpController.instance.showResultView(alertType: .failure)
                    }
                }
                objFlags += 1
                selectedObj = objectGames[objFlags]
                objectView.image = UIImage(named: selectedObj.imgSource)
                
            } else{
                GameResultPopUpController.instance.showResultView(alertType: .success)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initDataImage()
        MusicPlayer.shared.startBackgroundMusic(bgmFIleName: "MainMenuBGM")
        objectView.applyshadowWithCorner(containerView: containerView, cornerRadious: 10.0)
        
        if objFlags==10{
            GameResultPopUpController.instance.showResultView(alertType: .success)
        }
        
    }
    
    func initDataImage() {
        let data1 = DataImage(imgId: "toys", imgSource: "YesOrNoCard-10")
        let data2 = DataImage(imgId: "toys", imgSource: "YesOrNoCard-11")
        let data3 = DataImage(imgId: "toys", imgSource: "YesOrNoCard-12")
        let data4 = DataImage(imgId: "toys", imgSource: "YesOrNoCard-13")
        let data5 = DataImage(imgId: "toys", imgSource: "YesOrNoCard-14")
        let data6 = DataImage(imgId: "toys", imgSource: "YesOrNoCard-15")
        let data7 = DataImage(imgId: "trash", imgSource: "YesOrNoCard-1")
        let data8 = DataImage(imgId: "trash", imgSource: "YesOrNoCard-2")
        let data9 = DataImage(imgId: "trash", imgSource: "YesOrNoCard-3")
        let data10 = DataImage(imgId: "trash", imgSource: "YesOrNoCard-4")
        let data11 = DataImage(imgId: "trash", imgSource: "YesOrNoCard-5")
        let data12 = DataImage(imgId: "trash", imgSource: "YesOrNoCard-6")
        let data13 = DataImage(imgId: "trash", imgSource: "YesOrNoCard-7")
        let data14 = DataImage(imgId: "trash", imgSource: "YesOrNoCard-8")
        let data15 = DataImage(imgId: "trash", imgSource: "YesOrNoCard-9")
        
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
    }
}
