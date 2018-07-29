//
//  CGPoint+math.swift
//  Jigsaw
//
//  Created by Simon Fairbairn on 24/07/2018.
//  Copyright © 2018 Voyage Travel Apps. All rights reserved.
//

import SpriteKit

extension CGPoint {
	public static func - (lhs : CGPoint, rhs : CGPoint ) -> CGPoint {
		return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
	}
	public static func + (lhs : CGPoint, rhs : CGPoint ) -> CGPoint {
		return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
	}

}
