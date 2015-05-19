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