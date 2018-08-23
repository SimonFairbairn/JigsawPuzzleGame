//
//  GameScene+touch.swift
//  Jigsaw (iOS)
//
//  Created by Simon Fairbairn on 24/07/2018.
//  Copyright © 2018 Voyage Travel Apps. All rights reserved.
//

import GameplayKit
extension GameScene {
	
	static func scene(named : String ) -> GameScene {
		let puzzle = Puzzle(fileNamed: named)
		let sceneSize : CGSize
		if UIDevice.current.userInterfaceIdiom == .pad {
			if let hasPuzzle = puzzle, hasPuzzle.type == "vector" {
				sceneSize = CGSize(width: 2219, height: 1024)
			} else {
				sceneSize = CGSize(width: 4438, height: 2048)
			}
		} else {
			if let hasPuzzle = puzzle, hasPuzzle.type == "vector" {
				sceneSize = CGSize(width: 1109, height: 512)
			} else {
				sceneSize = CGSize(width: 2219, height: 1024)
			}
		}
		let scene = GameScene(size: sceneSize)
		scene.scaleMode = .aspectFill
		scene.puzzle = puzzle
		return scene
	}
	
	
	
	func setupInteractionHandlers() {
		let panRecogniser = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
		panRecogniser.maximumNumberOfTouches = 1
		self.view?.addGestureRecognizer(panRecogniser)
		
		let rotationRecogniser = UIRotationGestureRecognizer(target: self, action: #selector(handleRotation(_:)))
		self.view?.addGestureRecognizer(rotationRecogniser)
	}
	
	@objc func handleRotation( _ recogniser : UIRotationGestureRecognizer) {
		let point = self.scene?.convertPoint(fromView: recogniser.location(in: self.view)) ?? .zero
		if recogniser.state == .began {
			self.entityBeingInteractedWith = self.topNode(at: point)?.entity
		}
		guard let hasEntity = self.entityBeingInteractedWith else { return }
		
		let rotation = recogniser.rotation * -1
		switch recogniser.state {
		case .began:
			hasEntity.component(ofType: InteractionComponent.self)?.state = .rotate(.began, 	rotation)
		case .changed:
			hasEntity.component(ofType: InteractionComponent.self)?.state = .rotate(.changed, rotation)
		case .ended, .cancelled, .failed:
			hasEntity.component(ofType: InteractionComponent.self)?.state = .rotate(.ended, rotation)
		default:
			break
		}
	}
	
	@objc func handlePan(_ recogniser : UIPanGestureRecognizer ) {
		let point = self.scene?.convertPoint(fromView: recogniser.location(in: self.view)) ?? .zero
		if recogniser.state == .began {
			self.entityBeingInteractedWith = self.topNode(at: point)?.entity
		}
		guard let hasEntity = self.entityBeingInteractedWith else { return }
		
		guard recogniser.numberOfTouches <= 1 else {
			self.entityBeingInteractedWith = nil
			hasEntity.component(ofType: InteractionComponent.self)?.state = .none
			return
		}
		
		switch recogniser.state {
		case .began:
			hasEntity.component(ofType: InteractionComponent.self)?.state = .move(.began, point)
		case .changed:
			hasEntity.component(ofType: InteractionComponent.self)?.state = .move(.changed, point)
		case .cancelled:
			print("Cancelled")
		case .failed:
			print("Failed")
		case .ended:
			self.fixZPosition()
			hasEntity.component(ofType: InteractionComponent.self)?.state = .move(.ended, point)
			self.entityBeingInteractedWith = nil
		default:
			break
		}
	}
}
