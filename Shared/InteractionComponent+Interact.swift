//
//  InteractionComponent+Interact.swift
//  Jigsaw (macOS)
//
//  Created by Simon Fairbairn on 24/07/2018.
//  Copyright © 2018 Voyage Travel Apps. All rights reserved.
//

import SpriteKit

extension InteractionComponent {
	override func update(deltaTime seconds: TimeInterval) {
		switch state {
		case .none:
			break
		case .move(let state, let point):
			self.handleMove(state: state, point: point)
		}
	}
	
func handleMove( state : ActionState, point : CGPoint ) {
	guard let positionComponent = entity?.component(ofType: PositionComponent.self) else {
		return
	}
	if self.didBegin {
		offset = positionComponent.currentPosition - point
		self.didBegin = false
	}
	switch state {
	case .began, .changed:
		positionComponent.currentPosition = point + offset
	case .ended:
		positionComponent.currentPosition = point + offset
		self.state = .none
		offset = .zero
	}
}
}
