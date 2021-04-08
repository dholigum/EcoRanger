//
//  CarGameScene.swift
//  EcoRanger
//
//  Created by Syahrul Apple Developer BINUS on 06/04/21.
//

import SpriteKit
import GameplayKit

struct PhysicsCategory {
    static let none: UInt32 = 0
    static let all: UInt32 = UInt32.max
    static let mosquito: UInt32 = 0b1
    static let tapEffect: UInt32 = 0b10
}

class SlapMosquitoGameScene: SKScene, SKPhysicsContactDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self.view)
        let tapEffect: SKSpriteNode = SKSpriteNode(imageNamed: "tapeffect")
        
        tapEffect.position = CGPoint(x: location.x, y: size.height - location.y)
        tapEffect.size = CGSize(width: 30, height: 30)
        addChild(tapEffect)
        
        tapEffect.run(
            SKAction.sequence([
                SKAction.playSoundFileNamed("button-3.wav", waitForCompletion: false),
                SKAction.wait(forDuration: 0.5),
                SKAction.removeFromParent()
            ])
        )
        
        tapEffect.physicsBody = SKPhysicsBody(circleOfRadius: tapEffect.size.width/2)
        tapEffect.physicsBody?.isDynamic = true
        tapEffect.physicsBody?.categoryBitMask = PhysicsCategory.tapEffect
        tapEffect.physicsBody?.contactTestBitMask = PhysicsCategory.mosquito
        tapEffect.physicsBody?.collisionBitMask = PhysicsCategory.none
        tapEffect.physicsBody?.usesPreciseCollisionDetection = true
    }
    
    override func didMove(to view: SKView) {
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        
        let backgroundSprite: SKSpriteNode = SKSpriteNode(imageNamed: "roombg")
        backgroundSprite.position = CGPoint(x: size.width/2, y: size.height/2)
        backgroundSprite.size = CGSize(width: frame.maxX, height: frame.maxY)
        self.addChild(backgroundSprite)
        
        addMosquito()
        
    }
    
    func addMosquito() {
        
        let mosquito = SKSpriteNode(imageNamed: "mosquitoright")
        
        for _ in 1...4 {
            
            let mosquitoSprite = mosquito.copy() as! SKSpriteNode
            
            let x = CGFloat(0 - CGFloat(Double.random(in: 50...250)))
            let y = CGFloat(arc4random()).truncatingRemainder(dividingBy: frame.size.height)
            
            mosquitoSprite.position = CGPoint(x: x, y: y)
            mosquitoSprite.size = CGSize(width: 50, height: 50)
            
            addChild(mosquitoSprite)
            
            mosquitoSprite.physicsBody = SKPhysicsBody(rectangleOf: mosquito.size) // 1
            mosquitoSprite.physicsBody?.isDynamic = true // 2
            mosquitoSprite.physicsBody?.categoryBitMask = PhysicsCategory.mosquito // 3
            mosquitoSprite.physicsBody?.contactTestBitMask = PhysicsCategory.tapEffect // 4
            mosquitoSprite.physicsBody?.collisionBitMask = PhysicsCategory.none // 5
            
            var actions:[SKAction] = []

            let firstDestination = CGPoint(x: CGFloat.random(in: 20...50), y: CGFloat.random(in: 0...frame.size.height))
            let firstMove = SKAction.move(to:firstDestination, duration: 1.0)
            actions.append(firstMove)

            for _ in 1...18 {
                let destination = getRandomPoint(withinRect: frame)
                let velocity = Double.random(in: 1.0...1.5)
                let move = SKAction.move(to:destination, duration: velocity)
                actions.append(move)
            }

            let lastDestination = CGPoint(x: frame.size.width + CGFloat.random(in: 20...50), y: CGFloat.random(in: 0...frame.size.height))
            let lastMove = SKAction.move(to:lastDestination, duration: 1.0)
            actions.append(lastMove)
            
            mosquitoSprite.run(SKAction.sequence(actions))
        }
        
    }
    
    func getRandomPoint(withinRect rect:CGRect)->CGPoint{
        
        let x = CGFloat(arc4random()).truncatingRemainder(dividingBy: rect.size.width)
        let y = CGFloat(arc4random()).truncatingRemainder(dividingBy: rect.size.height)
        
        return CGPoint(x: x, y: y)
    }
    
    func mosquitoDidCollideWithTap(mosquito: SKSpriteNode, tapEffect: SKSpriteNode) {
        print("Hit")
        mosquito.removeFromParent()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        // 1
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        // 2
        if ((firstBody.categoryBitMask & PhysicsCategory.mosquito != 0) &&
                (secondBody.categoryBitMask & PhysicsCategory.tapEffect != 0)) {
            if let mosquito = firstBody.node as? SKSpriteNode,
               let tapEffect = secondBody.node as? SKSpriteNode {
                mosquitoDidCollideWithTap(mosquito: mosquito, tapEffect: tapEffect)
            }
        }
    }
    
}
