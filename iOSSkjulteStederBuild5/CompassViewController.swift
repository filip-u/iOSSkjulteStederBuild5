//
//  CompassViewController.swift
//  iOSSkjulteStederBuild5
//
//  Created by David Byrial Hvejsel on 10/03/15.
//  Copyright (c) 2015 DBH. All rights reserved.
//
import UIKit
import Realm
import CoreLocation

class CompassViewController: UIViewController, CLLocationManagerDelegate {
	
	var degrees : Float = 0.0
	var manager = CLLocationManager()
	var curLat : Float = 0.0
	var curLon : Float = 0.0
	var heading : CLLocationDirection = CLLocationDirection()
	
	//Realm vars:
	let realm = RLMRealm.defaultRealm()
	
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
		
		//calculateAngle()
		
		//CoreLocation:
		manager.delegate = self
		manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
		manager.requestAlwaysAuthorization()
		manager.startUpdatingHeading()
		manager.startUpdatingLocation()
	}
	
	//CoreLocation:
	func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
		var userLocation : CLLocation = locations[0] as CLLocation
		curLat = Float(userLocation.coordinate.latitude)
		curLon = Float(userLocation.coordinate.longitude)
		
		//self.latitude.text = "\(curLat)"
		calculateAngle()
	}
	
	//Error handling:
	func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
		println(error)
	}
	
	//get heading:
	func locationManager(manager: CLLocationManager!, didUpdateHeading newHeading: CLHeading!) {
		heading = newHeading.magneticHeading
		
		//self.latitude.text = "\(heading)"
	}
	
	//Calculate bearing between current location and endlocation:
	func calculateAngle() {
		//Degrees to radians: PI * X / 180
		//Radians to degrees: X * 180 / PI
		
		var endLat = ""
		var endLon = ""
		
		let curDest = Destination.allObjects()
		for dest in curDest {
			let dest = dest as Destination
			endLat = dest.latitude
			endLon = dest.longitude
		}
		
		var endLatRadians : Float = (endLat.floatValue / Float(M_PI)) * 180.0
		var endLonRadians : Float = (endLon.floatValue / Float(M_PI)) * 180.0
		var curLatRadians : Float = (curLat / Float(M_PI)) * 180.0
		var curLonRadians : Float = (curLon / Float(M_PI)) * 180.0
		
		var x : Float = 0
		var y : Float = 0
		var deg : Float = 0
		var delLon : Float = 0
		
		delLon = endLonRadians - curLonRadians
		y = sin(delLon) * cos(endLatRadians)
		x = cos(curLatRadians) * sin(endLatRadians) - sin(curLatRadians) * cos(endLatRadians) * cos(delLon)
		deg = (180 * (atan2(y, x))) / Float(M_PI)
		
		if deg >= 0 {
			degrees = deg
		}
		else{
			degrees = 360 + deg
		}
		
		compassImg.transform = CGAffineTransformMakeRotation( CGFloat((Float(degrees) - Float(heading)) * Float(M_PI) / 180.0) )
	}
}

extension String {
	var floatValue : Float {
		return (self as NSString).floatValue
	}
}