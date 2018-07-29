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
	
func handleMove( state : ActionState, point : CGPoint? ) {
	guard let positionComponent = entity?.component(ofType: PositionComponent.self) else {
		return
	}
	if self.didBegin {
		if let hasPoint = point {
			offset = positionComponent.currentPosition - hasPoint
		}
		self.didBegin = false
	}
	
	if let hasPoint = point {
		positionComponent.currentPosition = hasPoint + offset
	}
	switch state {
	case .ended:
		self.state = .none
		offset = .zero
	default:
		break
	}
}
}
