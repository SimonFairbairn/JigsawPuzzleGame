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
	}
	override func mouseDragged(with event: NSEvent) {
		let point = event.location(in: self)
		self.player.component(ofType: InteractionComponent.self)?.state = Action.move(.changed, point)
	}
	override func mouseUp(with event: NSEvent) {
		let point = event.location(in: self)
		self.player.component(ofType: InteractionComponent.self)?.state = Action.move(.ended, point)
	}
	
	func movePiece(at point : CGPoint, with state: ActionState ) {
		let point = event.location(in: self)
		let entity = self.topNode(at: point)?.entity
		entity.component(ofType: InteractionComponent.self)?.interactionBegan(.move(.began, point), with: topNode?.entity)

	}
}
