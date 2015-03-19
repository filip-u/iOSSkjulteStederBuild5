//
//  AbsulotelyFinalViewController.swift
//  iOSSkjulteStederBuild5
//
//  Created by David Byrial Hvejsel on 11/03/15.
//  Copyright (c) 2015 DBH. All rights reserved.
//

import UIKit

class AbsulotelyFinalViewController: UIViewController {

	@IBAction func absCancelBttn(sender: UIButton) {
		continueWithoutDestination = true
		self.performSegueWithIdentifier("absolutelyFinalViewCancel", sender: self)
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}