//
//  SettingPopUpController.swift
//  EcoRanger
//
//  Created by Samlo Berutu on 08/04/21.
//

import UIKit

class SettingPopUpController: UIView {

   //var setting
    static let instance = SettingPopUpController()
    @IBOutlet var backBtn: UIButton!
    @IBOutlet var parentViewContoller : UIView!
    @IBOutlet var alertView : UIView!
    @IBOutlet var switcher: UISwitch!
    @IBOutlet var SFXSwitch: UISwitch!
    @IBAction func backButton(_ sender: UIButton) {
        print("tombol kembali")
        parentViewContoller.removeFromSuperview()
        SFXPlayer.shared.PlaySFX(SFXFileName: "ButtonPress")
    }
    @IBAction func sfxButton(_ sender: Any) {
        print("ini switch sfx")
        if SFXSwitch.isOn
        {
            SFXPlayer.shared.SFXAllowStatus = true
        }
        else
        {
            SFXPlayer.shared.SFXAllowStatus = false
        }
    }
    @IBAction func bgmSwitch(_ sender: Any) {
        print("ini switch BMG")
        /*if BGMSwitch.isOn{
                    MusicPlayer.shared.startBackgroundMusic(bgmFIleName: "MainMenuBGM")
                }else{
                    MusicPlayer.shared.stopBackgroundMusic()
                }*/
        if switcher.isOn
        {
            MusicPlayer.shared.BGMAllowStatus = true
            MusicPlayer.shared.startBackgroundMusic(bgmFIleName: "MainMenuBGM")
        }
        else
        {
            MusicPlayer.shared.BGMAllowStatus = false
            MusicPlayer.shared.stopBackgroundMusic()
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("SettingPopUp", owner: self, options: nil)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit(){
        parentViewContoller.bounds = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        parentViewContoller.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func showAlert(){
        print("halaman alert")
        alertView.layer.cornerRadius = 10
        backBtn.layer.cornerRadius = 10
        //parentViewContoller.center = center.center
        UIApplication.shared.keyWindow?.addSubview(parentViewContoller)
    }
    
    

}
