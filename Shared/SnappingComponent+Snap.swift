//
//  SnappingComponent+Snap.swift
//  Jigsaw (iOS)
//
//  Created by Simon Fairbairn on 29/07/2018.
//  Copyright © 2018 Voyage Travel Apps. All rights reserved.
//

import SpriteKit

extension SnappingComponent {
	override func update(deltaTime seconds: TimeInterval) {
		guard let positionComponent = entity?.component(ofType: PositionComponent.self) else { return }
		guard let interactionComponent = entity?.component(ofType: InteractionComponent.self), interactionComponent.state == .none else { return }
		let vector = positionComponent.currentPosition - positionComponent.targetPosition
		let hyp = sqrt(( vector.x * vector.x ) + (vector.y * vector.y))
		var shouldSnap = true
		if hyp > self.positionTolerance {
			shouldSnap = false
		}
		if let hasRotation = entity?.component(ofType: RotationComponent.self) {
			let inDegrees = abs(hasRotation.currentRotation.toDegrees())
			if inDegrees > rotationTolerance && inDegrees < (360 - rotationTolerance)  {
				shouldSnap = false
			}
		}
		
		if shouldSnap {
			positionComponent.currentPosition = positionComponent.targetPosition
			entity?.component(ofType: RotationComponent.self)?.currentRotation = 0
			entity?.component(ofType: SpriteComponent.self)?.sprite.zPosition = 1
		}
	}
}
