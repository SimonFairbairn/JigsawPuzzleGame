//
//  GameScene+touch.swift
//  Jigsaw (iOS)
//
//  Created by Simon Fairbairn on 24/07/2018.
//  Copyright © 2018 Voyage Travel Apps. All rights reserved.
//

import UIKit
extension GameScene {
	func setupInteractionHandlers() {
		let panRecogniser = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
		self.view?.addGestureRecognizer(panRecogniser)
	}
@objc func handlePan(_ recogniser : UIPanGestureRecognizer ) {
	let point : CGPoint = self.scene?.convertPoint(fromView: recogniser.location(in: self.view)) ?? .zero
	let entity = self.topNode(at: point)?.entity
	switch recogniser.state {
	case .began:
		entity?.component(ofType: InteractionComponent.self)?.state = .move(.began, point)
	case .changed:
		entity?.component(ofType: InteractionComponent.self)?.state = .move(.changed, point)
	case .cancelled, .ended, .failed:
		entity?.component(ofType: InteractionComponent.self)?.state = .move(.ended, point)
	default:
		break
	}	
}
}
