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
	var debug = false
	
	var entityBeingInteractedWith : GKEntity?
	var startingPosition : CGPoint = .zero
	
	private var lastUpdateTime : TimeInterval = 0
	
	lazy var componentSystems : [GKComponentSystem] = {
		let spriteCompSystem = GKComponentSystem(componentClass: SpriteComponent.self)
		let snappingSystem = GKComponentSystem(componentClass: SnappingComponent.self)
		let interactionCompSystem = GKComponentSystem(componentClass: InteractionComponent.self)
		return [interactionCompSystem, snappingSystem, spriteCompSystem]
	}()
	
	var winLabel = SKLabelNode()
	
	override func sceneDidLoad() {
		self.lastUpdateTime = 0
	}
	
	override func didMove(to view: SKView) {
		
		let height = self.size.height
		let width43 = floor((self.size.height / 3 ) * 4)
		let leftMargin = floor(( self.size.width - width43) / 2)
		let yRandomiser = GKRandomDistribution(lowestValue: 0, highestValue: Int(height))
		let xRandomiser = GKRandomDistribution(lowestValue: Int(leftMargin) , highestValue: Int(leftMargin) + Int(width43))
		let rotationRandomiser = GKRandomDistribution(lowestValue: 0, highestValue: 359)
		
		self.setupInteractionHandlers()
		
		for (idx, piece) in puzzle.pieces.enumerated() {
			let puzzlePiece = GKEntity()
			let spriteComponent = SpriteComponent(name: piece.name)
			
			let randomX = CGFloat(xRandomiser.nextInt())
			let randomY = CGFloat(yRandomiser.nextInt())
			var randomPos = CGPoint(x: randomX, y: randomY)
			let nextRotation = rotationRandomiser.nextInt()
			var randomRotation = CGFloat(nextRotation).toRads()
			spriteComponent.sprite.zPosition = CGFloat(idx + 10)
			if (idx > 1 && debug) || nextRotation > 180 {
				randomPos = piece.position
				randomRotation = 0
				spriteComponent.sprite.zPosition = 0
			}
			let positionComponent = PositionComponent(currentPosition: randomPos, targetPosition: piece.position)
			let interactionComponent = InteractionComponent()
			let snappingComponent = SnappingComponent()
			let rotationComponent = RotationComponent(currentRotation: randomRotation)
			let scaleComponent = ScaleComponent()
			puzzlePiece.addComponent(scaleComponent)
			puzzlePiece.addComponent(rotationComponent)
			
			puzzlePiece.addComponent(spriteComponent)
			puzzlePiece.addComponent(positionComponent)
			if idx < 2 || !debug {
				if nextRotation <= 180 {
					puzzlePiece.addComponent(interactionComponent)
					puzzlePiece.addComponent(snappingComponent)
				}
			}
			self.addChild(spriteComponent.sprite)
			self.entities.append(puzzlePiece)
		}
		
		for system in componentSystems {
			for entity in entities {
				system.addComponent(foundIn: entity)
			}
		}
		
		setupLabel()
	}
	
	func setupLabel() {
		self.winLabel.text = "You Win!"
		self.winLabel.zPosition = 100
		self.winLabel.fontColor = .white
		self.winLabel.fontName = "AvenirNextCondensed-Heavy"
		self.winLabel.fontSize = ( self.puzzle.type == "vector" ) ? 100 : 200
		self.winLabel.isHidden = true
		self.winLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
		
		self.addChild(self.winLabel)
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
		
		var hasWon = true
		for entity in entities {
			if let hasPosition = entity.component(ofType: PositionComponent.self) {
				if hasPosition.currentPosition != hasPosition.targetPosition {
					hasWon = false
				}
			}
		}
		
		if hasWon {
			handleWinCondition()
		}
	}
	
	func handleWinCondition() {
		self.winLabel.isHidden = false
		entities.forEach() { $0.removeComponent(ofType: InteractionComponent.self) }
		let wait = SKAction.wait(forDuration: 3)
		let transition = SKAction.run {
		let scene : GameScene
			if let hasNewPuzzle = self.puzzle.nextPuzzle {
				scene = GameScene.scene(named: hasNewPuzzle)
			} else {
				scene = GameScene(size: self.size)
				scene.puzzle = self.puzzle
				scene.scaleMode = self.scaleMode
			}
			let transition = SKTransition.crossFade(withDuration: 1)
			self.view?.presentScene(scene, transition: transition)
		}
		let newScene = SKAction.sequence([wait, transition])
		self.run(newScene)
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
	
func nodes(within region : CGRect ) -> [SKNode] {
	var foundNodes = [SKNode]()
	for node in self.children {
		if node.entity == nil {
			continue
		}
		if node.frame.intersects( region ) {
			foundNodes.append(node)
		}
	}
	return foundNodes.sorted(by: { (node1, node2) -> Bool in
		return node1.zPosition > node2.zPosition
	})
}
	
func fixZPosition() {
	guard let hasPiece = self.entityBeingInteractedWith?.component(ofType: SpriteComponent.self) else {
		return
	}
	let nodesWithinFrame = nodes(within: hasPiece.sprite.frame)
	guard entities.count > 1 else {
		return
	}
	
	var zPositions = nodesWithinFrame.filter() { $0.zPosition < 1000 }.map() { $0.zPosition }
	zPositions.append(hasPiece.currentZPosition)
	let sortedZPositions = zPositions.sorted() { $0 > $1 }
	
	for (idx,entity) in nodesWithinFrame.enumerated() {
		entity.entity?.component(ofType: SpriteComponent.self)?.sprite.zPosition = sortedZPositions[idx]
		entity.entity?.component(ofType: SpriteComponent.self)?.currentZPosition = sortedZPositions[idx]
	}
}
}
