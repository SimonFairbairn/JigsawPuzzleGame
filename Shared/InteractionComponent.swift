//
//  InteractionComponent.swift
//  Jigsaw
//
//  Created by Simon Fairbairn on 23/07/2018.
//  Copyright © 2018 Voyage Travel Apps. All rights reserved.
//

import GameplayKit
import SpriteKit
enum Action : Equatable   {
	case none
	case move(ActionState, CGPoint?)
	case rotate(ActionState, CGFloat)
}
enum ActionState : Equatable {
	case began
	case changed
	case ended
}
class InteractionComponent : GKComponent {
	var didBegin : Bool = false
	var state : Action = .none {
		didSet {
			switch state {
			case .move(let actionState, _), .rotate(let actionState, _):
				if actionState == .began {
					self.didBegin = true
				}
			default:
				break
			}
		}
	}
	var offset : CGPoint = .zero
	var rotationOffset : CGFloat = 0
}

