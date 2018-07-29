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
	var puzzle : Puzzle!
	
	var entityBeingInteractedWith : GKEntity?
	
	private var lastUpdateTime : TimeInterval = 0
	
lazy var componentSystems : [GKComponentSystem] = {
	let spriteCompSystem = GKComponentSystem(componentClass: SpriteComponent.self)
	let snappingSystem = GKComponentSystem(componentClass: SnappingComponent.self)
	let interactionCompSystem = GKComponentSystem(componentClass: InteractionComponent.self)
	return [interactionCompSystem, snappingSystem, spriteCompSystem]
}()
	
	override func sceneDidLoad() {
		self.lastUpdateTime = 0
	}
	
	override func didMove(to view: SKView) {
		
let height = self.size.height
let width43 = floor((self.size.height / 3 ) * 4)
let leftMargin = floor(( self.size.width - width43) / 2)
let yRandomiser = GKRandomDistribution(lowestValue: 0, highestValue: Int(height))
let xRandomiser = GKRandomDistribution(lowestValue: Int(leftMargin) , highestValue: Int(leftMargin) + Int(width43))
		
		self.setupInteractionHandlers()
		
		for piece in puzzle.pieces {
			let puzzlePiece = GKEntity()
			let spriteComponent = SpriteComponent(name: piece.name)
			
let randomX = CGFloat(xRandomiser.nextInt())
let randomY = CGFloat(yRandomiser.nextInt())
let positionComponent = PositionComponent(currentPosition: CGPoint(x: randomX, y: randomY), targetPosition: piece.position)
			let interactionComponent = InteractionComponent()
			let snappingComponent = SnappingComponent()
			puzzlePiece.addComponent(spriteComponent)
			puzzlePiece.addComponent(positionComponent)
			puzzlePiece.addComponent(interactionComponent)
			puzzlePiece.addComponent(snappingComponent)
			self.addChild(spriteComponent.sprite)
			self.entities.append(puzzlePiece)
		}
		
		for system in componentSystems {
			for entity in entities {
				system.addComponent(foundIn: entity)
			}
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
		
		for system in componentSystems {
			system.update(deltaTime: dt)
		}
		
		self.lastUpdateTime = currentTime
	}
	
	func topNode(  at point : CGPoint ) -> SKNode? {
		var topMostNode : SKNode? = nil
		let nodes = self.nodes(at: point).filter() { $0.entity != nil }
		for node in nodes {
			if topMostNode == nil {
				topMostNode = node
				continue
			}
			if topMostNode!.zPosition < node.zPosition {
				topMostNode = node
			}
		}
		return topMostNode
	}
}
