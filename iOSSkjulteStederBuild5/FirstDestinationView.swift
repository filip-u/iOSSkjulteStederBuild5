//
//  FirstDestinationView.swift
//  iOSSkjulteStederBuild5
//
//  Created by David Byrial Hvejsel on 10/03/15.
//  Copyright (c) 2015 DBH. All rights reserved.
//

import UIKit
import Realm

class FirstDestinationView: UIViewController {

	//Realm vars:
	let realm = RLMRealm.defaultRealm()

	//Display the name if the destination:
	@IBOutlet weak var destName: UILabel!
	
	//Button to select the destination:
	@IBAction func selectFirstDestBttn(sender: UIButton) {
		setDestinationInRealm()
		if Destination.allObjects().count == 1 {
			self.performSegueWithIdentifier("firstDestinationSelected", sender: self)
		}
	}
	
	//Blur effect view:
	@IBOutlet weak var imageBlur: UIVisualEffectView!
	
	//Background image:
	@IBOutlet weak var destImg: UIImageView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
        // Do any additional setup after loading the view.
		if loadNewPlaces == false {
			//Get destination name
			destName.text = firstDestName as String
		
			//Set background image:
			let imgURL = NSURL(string: "http://appindex.dk/api/img/\(firstDestImg)")
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
			destName.text = fourthDestName as String
			
			let imgURL = NSURL(string: "http://appindex.dk/api/img/\(fourthDestImg)")
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
		
		//Gesture Recognizer:
		var gesture : UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: "longPressed:")
		gesture.minimumPressDuration = 0.25
		self.view.addGestureRecognizer(gesture)
    }
	
	//unblur image on long press:
	func longPressed(longPress: UIGestureRecognizer) {
		if longPress.state == UIGestureRecognizerState.Ended {
			UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
				self.imageBlur.alpha = 1.0
			}, completion: nil)
		}
		else if longPress.state == UIGestureRecognizerState.Began {
			UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
				self.imageBlur.alpha = 0.0
			}, completion: nil)
		}
	}
    
    //check's if there's internet connection
    override func viewDidAppear(animated: Bool) {
        if !Reachability.isConnectedToNetwork(){
            var alert = UIAlertController(title: "Ingen forbindelse!", message: "Appen fungerer ikke uden internetforbindelse", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }

	
	//Self explanatory :)
	func setDestinationInRealm() {
		realm.beginWriteTransaction()
		Destination.createInRealm(realm, withObject: [firstDestId, firstDestName, firstDestLat, firstDestLon, firstDestDesc, firstDestImg])
		realm.commitWriteTransaction()
	}
}