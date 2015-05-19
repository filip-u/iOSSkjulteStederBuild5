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
	
	@IBAction func cancelBttn(sender: UIButton) {
		continueWithoutDestination = true
		
		self.performSegueWithIdentifier("finalViewCancel", sender: self)
	}
    
    //check's if there's internet connection
    override func viewDidAppear(animated: Bool) {
        if !Reachability.isConnectedToNetwork(){
            var alert = UIAlertController(title: "Ingen forbindelse!", message: "Appen fungerer ikke uden internetforbindelse", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		
    }
}