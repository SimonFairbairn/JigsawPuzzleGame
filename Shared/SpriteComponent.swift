//
//  SpriteComponent.swift
//  Jigsaw
//
//  Created by Simon Fairbairn on 18/07/2018.
//  Copyright © 2018 Voyage Travel Apps. All rights reserved.
//

import GameplayKit
import SpriteKit

class SpriteComponent : GKComponent {
	
	let sprite : SKSpriteNode
	var currentZPosition : CGFloat = 0
	
	init( name : String  ) {
		self.sprite = SKSpriteNode(imageNamed: name)
		super.init()
	}
	
	override func didAddToEntity() {
		self.sprite.entity = self.entity
		self.currentZPosition = self.sprite.zPosition
	}
	
	override func willRemoveFromEntity() {
		self.sprite.removeFromParent()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("Not implmented")
	}
}

