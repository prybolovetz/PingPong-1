//
//  GameScene.swift
//  PingPong
//
//  Created by Ivan on 1/10/19.
//  Copyright © 2019 Ivan. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene  {
//    ,SKPhysicsContactDelegate
//    var starField: SKEmitterNode!
    
    var ball = SKSpriteNode()
    var enemy = SKSpriteNode()
    var main = SKSpriteNode()
    
    var topLbl = SKLabelNode()
    var btmLbl = SKLabelNode()
    
    var score = [Int]()
    
    override func didMove(to view: SKView) {
        //The function is called from the start of the game.
        
//        starField = SKEmitterNode(fileNamed: "Starfield")
//        starField.position = CGPoint(x: 0, y: 1472)
//        starField.advanceSimulationTime(10)
//        self.addChild(starField)
//        
//        //Position on the background
//        starField.zPosition = -1
        
        topLbl = self.childNode(withName: "topLabel") as! SKLabelNode
        btmLbl = self.childNode(withName: "btmLabel") as! SKLabelNode
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        
        print(self.view?.bounds.height as Any)
        
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        enemy.position.y = (self.frame.height / 2) - 50
        
        main = self.childNode(withName: "main") as! SKSpriteNode
        main.position.y = (-self.frame.height / 2) + 50
        
        let border  = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        border.friction = 0
        //beats off ball
        border.restitution = 1
        
        self.physicsBody = border
        
        startGame()
    }
    
//    func didBegin(_ contact: SKPhysicsContact) {
//        var alienBody: SKPhysicsBody
//        var bulletBody: SKPhysicsBody
//
//        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask{
//            alienBody = contact.bodyA
//            bulletBody = contact.bodyB
//        }else {
//            alienBody = contact.bodyB
//            bulletBody = contact.bodyA
//        }
//
//
//    }
//    func collisionElements(bulletNode:SKSpriteNode, alienNode:SKSpriteNode ){
//        let explosion = SKEmitterNode(fileNamed: "Vzriv")
//        explosion?.position = alienNode.position
//        self.addChild(explosion!)
//
//        self.run(SKAction.playSoundFileNamed("Vzriv.mp3", waitForCompletion: false))
//        self.run(SKAction.wait(forDuration: 2)){
//            explosion?.removeFromParent()
//        }
//    }
    
    func startGame() {
        score = [0,0]
        topLbl.text = "\(score[1])"
        btmLbl.text = "\(score[0])"
        
        ball.physicsBody?.applyImpulse(CGVector(dx: 37 , dy: 37))
        //The first movement of the ball.
    }
    
    func addScore(playerWhoWon : SKSpriteNode){
        
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        if playerWhoWon == main {
            score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: 37, dy: 37))
        }
        else if playerWhoWon == enemy {
            score[1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: -37, dy: -37))
        }
        
        topLbl.text = "\(score[1])"
        btmLbl.text = "\(score[0])"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Tap the screen
        //My movement
        for touch in touches {
            let location = touch.location(in: self)
            
            if currentGameType == .player2 {
                if location.y > 0 {
                    enemy.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
                if location.y < 0 {
                    
                    main.run(SKAction.moveTo(x: location.x, duration: 0.2))
                    
                }
                
            }
            else{
                main.run(SKAction.moveTo(x: location.x, duration: 0.2))
            }
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //We drive on the screen
        //My movement
        
        
        for touch in touches {
            let location = touch.location(in: self)
            
            if currentGameType == .player2 {
                if location.y > 0 {
                    enemy.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
                if location.y < 0 {
                    
                    main.run(SKAction.moveTo(x: location.x, duration: 0.2))
                    
                }
                
            }
            else{
                main.run(SKAction.moveTo(x: location.x, duration: 0.2))
            }
            
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        //The function is called every second.
        // Called before each frame is rendered
        
        //Opponent's movement
        switch currentGameType {
        case .easy:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.5))
            break
        case .medium:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.4))
            break
        case .hard:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.14))
            break
        case .player2:
            
            break
        }
        
        
        if ball.position.y <= main.position.y - 20 {
            addScore(playerWhoWon: enemy)
        }
        else if ball.position.y >= enemy.position.y + 20 {
            addScore(playerWhoWon: main)
        }
    }
}
