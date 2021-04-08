//
//  TruckGameViewController.swift
//  EcoRanger
//
//  Created by Syahrul Apple Developer BINUS on 08/04/21.
//

import UIKit
import SpriteKit

class TruckGameViewController: UIViewController {
    var gameModel: Thumbnail?
    @IBOutlet weak var skview: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let scene: TruckGameScene = TruckGameScene(size: skview.frame.size)
        skview.presentScene(scene)
    }

}
