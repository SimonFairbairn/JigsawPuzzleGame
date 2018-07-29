//
//  PositionComponent.swift
//  Jigsaw
//
//  Created by Simon Fairbairn on 18/07/2018.
//  Copyright © 2018 Voyage Travel Apps. All rights reserved.
//

import GameplayKit
import SpriteKit

class PositionComponent : GKComponent {
	
	var currentPosition : CGPoint
	let targetPosition : CGPoint
	
	init( currentPosition : CGPoint, targetPosition : CGPoint ) {
		self.currentPosition = currentPosition
		self.targetPosition = targetPosition
		super.init()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("Not implmented")
	}
}

