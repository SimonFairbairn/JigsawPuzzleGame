//
//  ScaleComponent.swift
//  Jigsaw
//
//  Created by Simon Fairbairn on 15/08/2018.
//  Copyright © 2018 Voyage Travel Apps. All rights reserved.
//

import GameplayKit
import SpriteKit

class ScaleComponent : GKComponent {
	let scaleAmountPerSecond : CGFloat = 2
	var targetScale : CGFloat = 1 {
		didSet {
			originalScale = currentScale
			difference = targetScale - currentScale
			if abs(difference) < 0.05 {
				originalScale = targetScale
				currentScale = targetScale
				difference = 0
				duration = 0
				currentTime = 0
				return
			}
			duration = TimeInterval(abs(difference) / scaleAmountPerSecond)
			currentTime = duration
		}
	}
	var difference : CGFloat = 0
	var currentTime : TimeInterval = 0
	var duration : TimeInterval = 0
	var currentScale : CGFloat = 1
	var originalScale : CGFloat = 1
	
}

