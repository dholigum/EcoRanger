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
    @IBOutlet weak var skview: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let scene: SlapMosquitoGameScene = SlapMosquitoGameScene(size: skview.frame.size)
        skview.presentScene(scene)
    }

}
