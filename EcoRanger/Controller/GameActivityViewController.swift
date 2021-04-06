//
//  GameActivityViewController.swift
//  EcoRanger
//
//  Created by Syahrul Apple Developer BINUS on 06/04/21.
//

import UIKit
import SpriteKit

class GameActivityViewController: UIViewController {

    @IBOutlet weak var skview: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let scene: CarGameScene = CarGameScene(size: skview.frame.size)
        skview.presentScene(scene)
    }
    

}
