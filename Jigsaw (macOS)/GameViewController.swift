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
	
	static func scene(for fileName: String ) -> GameScene {
		let puzzle = Puzzle(fileNamed: fileName)
		let scene : GameScene
		if let hasPuzzle = puzzle, hasPuzzle.type == "vector" {
			scene = GameScene(size: CGSize(width: 2019, height: 1024))
		} else {
			scene = GameScene(size: CGSize(width: 4038, height: 2048))
		}
		scene.puzzle = puzzle
		scene.scaleMode = .aspectFit
		return scene
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let scene = GameViewController.scene(for: "pieces-iPad.json")
		self.skView.presentScene(scene)
		self.skView.ignoresSiblingOrder = true
		self.skView.showsFPS = true
		self.skView.showsNodeCount = true
	}
}

