//
//  CompassViewController.swift
//  iOSSkjulteStederBuild5
//
//  Created by David Byrial Hvejsel on 10/03/15.
//  Copyright (c) 2015 DBH. All rights reserved.
//

import UIKit

class CompassViewController: UIViewController {

	//Compass arrow to be rotated:
	@IBOutlet weak var compassImg: UIImageView!
	
	//select destination button:
	@IBAction func selectDestBttn(sender: UIButton) {
		self.performSegueWithIdentifier("compassViewSelectDestination", sender: self)
	}
	
	//View containing buttons and labels - only visible, when no destination is set!
	@IBOutlet weak var noDestinationSet: UIView!
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		if continueWithoutDestination == false {
			noDestinationSet.hidden = true
		}
		
		if Destination.allObjects().count == 1 {
			noDestinationSet.hidden = true
		}
    }
}