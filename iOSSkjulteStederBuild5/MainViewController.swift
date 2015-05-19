//
//  MainViewController.swift
//  iOSSkjulteStederBuild5
//
//  Created by David Byrial Hvejsel on 10/03/15.
//  Copyright (c) 2015 DBH. All rights reserved.
//

import UIKit
import SystemConfiguration

//Class that detects wether there is a connection tio internet or not ...
public class Reachability{
    class func isConnectedToNetwork() -> Bool{
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(&zeroAddress){
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0)).takeRetainedValue()
        }
        
        var flags: SCNetworkReachabilityFlags = 0
        if SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) == 0{
            return false
        }
        
        let isReachable = (flags & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        
        return (isReachable && !needsConnection) ? true : false
    }
}

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

var localeString : String = ""
var localeRequest : String = ""

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
			let user = user as! User
			self.curUserId = user.id
			userID = user.id
		}
		println(curUserId)
		return User.allObjectsInRealm(realm).firstObject() as! User
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		var objLoc : String = "\(NSLocale.preferredLanguages())"
		var objLoc1 : String = objLoc.stringByReplacingOccurrencesOfString("[", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
		var objLoc2 : String = objLoc1.stringByReplacingOccurrencesOfString("]", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
		
		localeString = objLoc2
		println(localeString)
		
		if localeString != "da" {
			localeRequest = "en"
		}
		else{
			localeRequest = "da"
		}
		
		self.delegate = self
		self.dataSource = self
		
		let compassView = storyboard?.instantiateViewControllerWithIdentifier("compassView") as! CompassViewController
		let profileView = storyboard?.instantiateViewControllerWithIdentifier("profileView") as! ProfileViewController
		
		pages = [compassView, profileView]
		
		let firstPage = self.viewControllerAtIndex(0)
		let viewControllers : NSArray = [firstPage]
		
		self.setViewControllers(viewControllers as [AnyObject], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: {(done: Bool) in})
		
		//Set uuid of user if not already set:
		defaultUser()
		
		//CoreLocation:
		manager.delegate = self
		manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
		manager.requestAlwaysAuthorization()
		manager.startUpdatingHeading()
		manager.startUpdatingLocation()
        
        //Check if the user has granted access to location data
        var authStatus : CLAuthorizationStatus = CLLocationManager.authorizationStatus()
        if authStatus == CLAuthorizationStatus.Denied || authStatus == CLAuthorizationStatus.Restricted{
            println("DENIED!!!!")
            //if not - display warning and ask user if he/she wants to go to settings to change it:
            
            var alertCtrl = UIAlertController(title: "Geolocation", message: "Appen virker ikke uden adgang til geolocation. Gå til telefonens indstilligner for at tillade adgang til funktionen?", preferredStyle: UIAlertControllerStyle.Alert)
            var settingsAction = UIAlertAction(title: "Indstillinger", style: UIAlertActionStyle.Default){ (_) -> Void in
                let settingsURL = NSURL(string: UIApplicationOpenSettingsURLString)
                if let url = settingsURL{
                    UIApplication.sharedApplication().openURL(url)
                }
            }
            
            var cancelAction = UIAlertAction(title: "Annuller", style: UIAlertActionStyle.Default, handler: nil)
            alertCtrl.addAction(settingsAction)
            alertCtrl.addAction(cancelAction)
            presentViewController(alertCtrl, animated: true, completion: nil)
        }

    }
	
	//CoreLocation:
	func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
		var userLocation : CLLocation = locations[0] as! CLLocation
		curLat = "\(userLocation.coordinate.latitude)"
		curLon = "\(userLocation.coordinate.longitude)"
		updatedLat = "\(userLocation.coordinate.latitude)"
		updatedLon = "\(userLocation.coordinate.longitude)"
        
        //Check if the user has granted access to location:
        //var authStatus : CLAuthorizationStatus = CLLocationManager.authorizationStatus()
        //if authStatus == CLAuthorizationStatus.Denied || authStatus == CLAuthorizationStatus.Restricted{
        //    println("DENIED!!!!")
        //}
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