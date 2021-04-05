//
//  ViewController.swift
//  EcoRanger
//
//  Created by Syahrul Apple Developer BINUS on 03/04/21.
//

import UIKit

class MainViewController: UIViewController {
    
    
    //popUp var space
    @IBOutlet var settingView: UIView!
    @IBOutlet var blurView: UIVisualEffectView!
    @IBAction func backButton(_ sender: UIButton) {
            popUpTransitionOut(desiredView: settingView)
            
        }
    @IBAction func sfxButton(_ sender: Any) {
        print("ini switch sfx")
        
    }
    @IBAction func bgmSwitch(_ sender: Any) {
        print("ini switch BMG")
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //popUp setting button
        blurView.bounds = self.view.bounds
        settingView.layer.cornerRadius = 10
        
    }

    @IBAction func settingButtonPressed(_ sender: UIButton) {
        //print("Setting Button Pressed")
        //action
        //popUpTransition(desiredView: blurView)
        popUpTransitionIn(desiredView: settingView)
        
        
    }
    @IBAction func badgesButtonPressed(_ sender: UIButton) {
        print("Badges Button Pressed")
    }
    @IBAction func avatarButtonPressed(_ sender: UIButton) {
        print("Avatar Button Pressed")
    }
    
    //popUp transition
    func popUpTransitionIn(desiredView:UIView){
        let bgView  = self.view!
        
        //
        bgView.addSubview(desiredView)
        
        //
        desiredView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        desiredView.alpha = 0
        desiredView.center = bgView.center
        
        //
        UIView.animate(withDuration: 0.3, animations: {
            desiredView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            desiredView.alpha = 1
        })
    }
    
    func popUpTransitionOut(desiredView:UIView){
        //
        UIView.animate(withDuration: 0.3, animations: {
            desiredView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            desiredView.alpha = 1
        }, completion: { _ in
            desiredView.removeFromSuperview()
        })
    }
    
}

