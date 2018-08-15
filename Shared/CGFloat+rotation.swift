//
//  CGFloat+rotation.swift
//  Jigsaw (iOS)
//
//  Created by Simon Fairbairn on 01/08/2018.
//  Copyright © 2018 Voyage Travel Apps. All rights reserved.
//

import SpriteKit

extension CGFloat {
	
	func toDegrees() -> CGFloat {
		return ( self / CGFloat.pi ) * 180
	}
	
	func toRads() -> CGFloat {
		return ( self / 180 ) * CGFloat.pi
	}
	
}
