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
	let filename : String
	if UIDevice.current.userInterfaceIdiom == .pad {
		filename = "pieces-iPad.json"
	} else {
		filename = "pieces.json"
	}
	let scene = GameScene.scene(named: filename)
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
