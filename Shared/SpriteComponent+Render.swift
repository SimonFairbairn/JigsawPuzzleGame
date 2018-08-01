//
//  SpriteComponent+Render.swift
//  Jigsaw
//
//  Created by Simon Fairbairn on 18/07/2018.
//  Copyright © 2018 Voyage Travel Apps. All rights reserved.
//

import Foundation

extension SpriteComponent {
	override func update(deltaTime seconds: TimeInterval) {
		guard let hasPositionComponent = entity?.component(ofType: PositionComponent.self) else {
			return
		}
		self.sprite.position = hasPositionComponent.currentPosition
		
		if let hasRotation = entity?.component(ofType: RotationComponent.self) {
			self.sprite.zRotation = hasRotation.currentRotation
		}
	}
}
