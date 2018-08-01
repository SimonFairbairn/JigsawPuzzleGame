//
//  RotationComponent.swift
//  Jigsaw (iOS)
//
//  Created by Simon Fairbairn on 01/08/2018.
//  Copyright © 2018 Voyage Travel Apps. All rights reserved.
//

import GameplayKit
import SpriteKit

class RotationComponent : GKComponent {
	
	var currentRotation : CGFloat
	
	init( currentRotation : CGFloat ) {
		self.currentRotation = currentRotation
		super.init()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("Not implmented")
	}
}

