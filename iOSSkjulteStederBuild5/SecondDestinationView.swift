//
//  SecondDestinationView.swift
//  iOSSkjulteStederBuild5
//
//  Created by David Byrial Hvejsel on 10/03/15.
//  Copyright (c) 2015 DBH. All rights reserved.
//

import UIKit
import Realm

class SecondDestinationView: UIViewController {

	@IBOutlet weak var destImg: UIImageView!
	@IBOutlet weak var destName: UILabel!
	@IBOutlet weak var imageBlur: UIVisualEffectView!
	@IBAction func selectSecondDestinationBttn(sender: UIButton) {
		setDestinationInRealm()
		if Destination.allObjects().count == 1 {
			self.performSegueWithIdentifier("secondDestinationSelected", sender: self)
		}
	}
	
	let realm = RLMRealm.defaultRealm()
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		if loadNewPlaces == false {
			destName.text = secondDestName
			let imgURL = NSURL(string: "http://davidhvejsel.dk/skjultesteder\(secondDestImg)")
			let urlRequest = NSURLRequest(URL: imgURL!)
			NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue(), completionHandler: {
				response, data, error in
				
				if error != nil {
					println(error)
				}
				else{
					let image = UIImage(data: data)
					self.destImg.image = image
				}
			})
		}
		else if loadNewPlaces == true {
			destName.text = fifthDestName
			let imgURL = NSURL(string: "http://davidhvejsel.dk/skjultesteder\(fifthDestImg)")
			let urlRequest = NSURLRequest(URL: imgURL!)
			NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue(), completionHandler: {
				response, data, error in
				
				if error != nil {
					println(error)
				}
				else{
					let image = UIImage(data: data)
					self.destImg.image = image
				}
			})
		}
		
		var gesture : UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: "longPressed:")
		gesture.minimumPressDuration = 0.2
		self.view.addGestureRecognizer(gesture)
    }
	
	func longPressed(longPress: UIGestureRecognizer) {
		if longPress.state == UIGestureRecognizerState.Ended {
			UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
				self.imageBlur.alpha = 1.0
			}, completion: nil)
		}
		else if longPress.state == UIGestureRecognizerState.Began {
			UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
				self.imageBlur.alpha = 0.0
			}, completion: nil)
		}
	}
	
	func setDestinationInRealm() {
		if loadNewPlaces == false {
			realm.beginWriteTransaction()
			Destination.createInRealm(realm, withObject: [secondDestId, secondDestName, secondDestLat, secondDestLon, secondDestDesc, secondDestImg])
			realm.commitWriteTransaction()
		}
		else if loadNewPlaces == true {
			realm.beginWriteTransaction()
			Destination.createInRealm(realm, withObject: [fifthDestId, fifthDestName, fifthDestLat, fifthDestLon, fifthDestDesc, fifthDestImg])
			realm.commitWriteTransaction()

		}
	}
}