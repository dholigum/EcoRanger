//
//  CarGameScene.swift
//  EcoRanger
//
//  Created by Syahrul Apple Developer BINUS on 06/04/21.
//

import SpriteKit
import GameplayKit

class CarGameScene: SKScene {
    
    override func didMove(to view: SKView) {
        let backgroundSprite: SKSpriteNode = SKSpriteNode(imageNamed: "roadbackground")
        backgroundSprite.position = CGPoint(x: size.width/2, y: size.height/2)
        backgroundSprite.size = CGSize(width: frame.maxX, height: frame.maxY)
        self.addChild(backgroundSprite)
        
        let objectSprite: SKSpriteNode = SKSpriteNode(imageNamed: "carright")
        objectSprite.position = CGPoint(x: 80, y: 60)
        objectSprite.size = CGSize(width: 200, height: 100)
        self.addChild(objectSprite)
        
        let carImageRight = SKAction.setTexture(SKTexture(imageNamed: "carright"))
        let carImageLeft = SKAction.setTexture(SKTexture(imageNamed: "carleft"))
        let wait = SKAction.wait(forDuration: 0.5)
        let moveRight: SKAction = SKAction.moveBy(x: size.width/2, y: 0, duration: 1)
        let moveLeft: SKAction = moveRight.reversed()
        
        let sequence = SKAction.sequence([carImageRight,moveRight,wait,carImageLeft,moveLeft])
        objectSprite.run(.repeatForever(sequence))
    }
    
}
