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
		case .rotate(let state, let rotation):
			self.handleRotation(state: state, rotation: rotation)
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
			entity?.component(ofType: ScaleComponent.self)?.targetScale = 1.2
			self.didBegin = false
		}
		
		if let hasPoint = point {
			positionComponent.currentPosition = hasPoint + offset
		}
		switch state {
		case .ended:
			self.state = .none
			offset = .zero
			entity?.component(ofType: ScaleComponent.self)?.targetScale = 1
		default:
			break
		}
	}
	
	func handleRotation( state : ActionState, rotation : CGFloat ) {
		guard let rotationComponent = entity?.component(ofType: RotationComponent.self) else {
			return
		}
		
		if self.didBegin {
			rotationOffset = rotationComponent.currentRotation - rotation
			self.didBegin = false
		}
		
		switch state {
		case .ended:
			self.state = .none
		default:
			rotationComponent.currentRotation = rotation + rotationOffset
		}
	}
}
