//
//  MainViewController.swift
//  iOSSkjulteStederBuild5
//
//  Created by David Byrial Hvejsel on 10/03/15.
//  Copyright (c) 2015 DBH. All rights reserved.
//

import UIKit
import Realm
import CoreLocation

//Global vars:
var userID : NSString = ""
var globalCurLat : NSString = "0.0"
var globalCurLon : NSString = "0.0"
var updatedLat : NSString = ""
var updatedLon : NSString = ""

var continueWithoutDestination : Bool = false

class MainViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource, CLLocationManagerDelegate {

	//"Pagination":
	var pages : [UIViewController] = []
	
	//CoreLocation vars:
	var manager = CLLocationManager()
	var curLat : String = "0.0" {
		didSet{
			if oldValue == "0.0" {
				globalCurLat = curLat
			}
		}
	}
	var curLon : String = "0.0" {
		didSet{
			if oldValue == "0.0" {
				globalCurLon = curLon
				isDestinationSet()
			}
		}
	}
	
	//Realm vars:
	let realm = RLMRealm.defaultRealm()
	var curUserId = ""
	
	//Get or set the destination:
	func isDestinationSet() {
		if Destination.allObjectsInRealm(realm).count == 0 && continueWithoutDestination != true {
			println("No destination is set!")
			self.performSegueWithIdentifier("jumpToSelectMode", sender: self)
		}
	}
	
	func defaultUser() -> User {
		if User.allObjectsInRealm(realm).count == 0 {
			println("No user id is set!")
			realm.transactionWithBlock() {
				let user = User()
				user.id = NSUUID().UUIDString
				self.realm.addObject(user)
			}
		}
		
		let allUsers = User.allObjects()
		for user in allUsers {
			let user = user as User
			self.curUserId = user.id
			userID = user.id
		}
		println(curUserId)
		return User.allObjectsInRealm(realm).firstObject() as User
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		self.delegate = self
		self.dataSource = self
		
		let compassView = storyboard?.instantiateViewControllerWithIdentifier("compassView") as CompassViewController
		let profileView = storyboard?.instantiateViewControllerWithIdentifier("profileView") as ProfileViewController
		
		pages = [compassView, profileView]
		
		let firstPage = self.viewControllerAtIndex(0)
		let viewControllers : NSArray = [firstPage]
		
		self.setViewControllers(viewControllers, direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: {(done: Bool) in})
		
		//Set uuid of user if not already set:
		defaultUser()
		
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
		curLat = "\(userLocation.coordinate.latitude)"
		curLon = "\(userLocation.coordinate.longitude)"
		updatedLat = "\(userLocation.coordinate.latitude)"
		updatedLon = "\(userLocation.coordinate.longitude)"
	}
	
	//CoreLocation error handling:
	func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
		println(error)
	}
	
	func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
		var index = find(pages, viewController)!
		
		if index == 0 || index == NSNotFound {
			return nil
		}
		
		index--
		
		if index == pages.count {
			return nil
		}
		
		return self.viewControllerAtIndex(index)
	}
	
	func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
		var index = find(pages, viewController)!
		
		if index == NSNotFound {
			return nil
		}
		
		index++
		
		if index == pages.count {
			return nil
		}
		
		return viewControllerAtIndex(index)
	}
	
	func viewControllerAtIndex(index : NSInteger) -> UIViewController {
		return pages[index]
	}
}