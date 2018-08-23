//
//  GameViewController.swift
//  Jigsaw (macOS)
//
//  Created by Simon Fairbairn on 13/07/2018.
//  Copyright © 2018 Voyage Travel Apps. All rights reserved.
//

import Cocoa
import SpriteKit
import GameplayKit

class GameViewController: NSViewController {

    @IBOutlet var skView: SKView!


	override func viewDidLoad() {
		super.viewDidLoad()
		
		let scene = GameScene.scene(named: "raster-pieces-iPad.json")
		self.skView.presentScene(scene)
		self.skView.ignoresSiblingOrder = true
		self.skView.showsFPS = true
		self.skView.showsNodeCount = true
	}
}

