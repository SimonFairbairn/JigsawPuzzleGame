//
//  GameScene+mouse.swift
//  Jigsaw (macOS)
//
//  Created by Simon Fairbairn on 24/07/2018.
//  Copyright © 2018 Voyage Travel Apps. All rights reserved.
//

import AppKit

extension GameScene {
	func setupInteractionHandlers() {
	}
	override func mouseDown(with event: NSEvent) {
		let point = event.location(in: self)
		guard let hasEntity = self.topNode(at: point)?.entity else {
			return
		}
		self.entityBeingInteractedWith = hasEntity
		self.entityBeingInteractedWith?.component(ofType: InteractionComponent.self)?.state = .move(.began, point)
	}
	override func mouseDragged(with event: NSEvent) {
		let point = event.location(in: self)
		self.entityBeingInteractedWith?.component(ofType: InteractionComponent.self)?.state = .move(.changed, point)
	}
	override func mouseUp(with event: NSEvent) {
		let point = event.location(in: self)
		self.entityBeingInteractedWith?.component(ofType: InteractionComponent.self)?.state = .move(.ended, point)
		self.entityBeingInteractedWith = nil
	}
	
	override func rightMouseDown(with event: NSEvent) {
		let point = event.location(in: self)
		guard let hasEntity = self.topNode(at: point)?.entity else {
			return
		}
		self.entityBeingInteractedWith = hasEntity
		self.entityBeingInteractedWith?.component(ofType: InteractionComponent.self)?.state = .rotate(.began, 0)
		self.startingPosition = point
	}
	override func rightMouseDragged(with event: NSEvent) {
		let difference = self.startingPosition - event.location(in: self)
		
		var rotation = difference.x
		if abs(difference.x) < 2 {
			rotation = 0
		}
		self.entityBeingInteractedWith?.component(ofType: InteractionComponent.self)?.state = .rotate(.changed, rotation.toRads())
	}
	override func rightMouseUp(with event: NSEvent) {
		self.entityBeingInteractedWith?.component(ofType: InteractionComponent.self)?.state = .rotate(.ended, 0)
	}
}

