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
		let puzzle = Puzzle(fileNamed: "pieces.json")
		print(puzzle?.type)
		let scene = GameScene(size: CGSize(width: 4038, height: 2048))
		scene.scaleMode = .aspectFit
		self.skView.presentScene(scene)
		self.skView.ignoresSiblingOrder = true
		self.skView.showsFPS = true
		self.skView.showsNodeCount = true
	}
}

