//
//  GameViewController.swift
//  Jigsaw
//
//  Created by Simon Fairbairn on 13/07/2018.
//  Copyright © 2018 Voyage Travel Apps. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		
		let puzzle : Puzzle?
		let sceneSize : CGSize
		if UIDevice.current.userInterfaceIdiom == .pad {
			puzzle = Puzzle(fileNamed: "pieces-iPad.json")
			if let hasPuzzle = puzzle, hasPuzzle.type == "vector" {
				sceneSize = CGSize(width: 2219, height: 1024)
			} else {
				sceneSize = CGSize(width: 4038, height: 2048)
			}
		} else {
			puzzle = Puzzle(fileNamed: "pieces.json")
			if let hasPuzzle = puzzle, hasPuzzle.type == "vector" {
				sceneSize = CGSize(width: 1109, height: 512)
			} else {
				sceneSize = CGSize(width: 2219, height: 1024)
			}
		}
		let scene = GameScene(size: sceneSize)
		
		
		scene.scaleMode = .aspectFill
		
		// Present the scene
		if let view = self.view as? SKView {
			view.presentScene(scene)
			view.ignoresSiblingOrder = true
			view.showsFPS = true
			view.showsNodeCount = true
		}
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
