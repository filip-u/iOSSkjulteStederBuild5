//
//  FinalViewController.swift
//  iOSSkjulteStederBuild5
//
//  Created by David Byrial Hvejsel on 11/03/15.
//  Copyright (c) 2015 DBH. All rights reserved.
//

import UIKit

class FinalViewController: UIViewController {
	
	@IBAction func restartDestinationBrowsing(sender: UIButton) {
		loadNewPlaces = true
		self.performSegueWithIdentifier("restartDestinationPager", sender: self)
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		
    }
}