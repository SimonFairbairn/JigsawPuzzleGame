//
//  GameScene.swift
//  Jigsaw
//
//  Created by Simon Fairbairn on 13/07/2018.
//  Copyright © 2018 Voyage Travel Apps. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var entities = [GKEntity]()

	private var lastUpdateTime : TimeInterval = 0
	
    override func sceneDidLoad() {
        self.lastUpdateTime = 0
    }
	
	override func didMove(to view: SKView) {
		for i in 0..<7 {
			let pieceNode = SKSpriteNode(imageNamed: "vector-piece\(i + 1)")
			pieceNode.position = CGPoint(x: 400 + (300 * i), y: 300)
			self.addChild(pieceNode)
		}
	}
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
		
        self.lastUpdateTime = currentTime
    }
}
