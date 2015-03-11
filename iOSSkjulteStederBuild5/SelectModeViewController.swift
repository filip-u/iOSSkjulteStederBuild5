//
//  SelectModeViewController.swift
//  iOSSkjulteStederBuild5
//
//  Created by David Byrial Hvejsel on 10/03/15.
//  Copyright (c) 2015 DBH. All rights reserved.
//

import UIKit
import Realm

//Global vars:
var firstDestId : NSString = ""
var firstDestName : NSString = ""
var firstDestDesc : NSString = ""
var firstDestLat : NSString = ""
var firstDestLon : NSString = ""
var firstDestImg : NSString = ""
var firstDestDst : NSString = ""

var secondDestId : NSString = ""
var secondDestName : NSString = ""
var secondDestDesc : NSString = ""
var secondDestLat : NSString = ""
var secondDestLon : NSString = ""
var secondDestImg : NSString = ""
var secondDestDst : NSString = ""

var thirdDestId : NSString = ""
var thirdDestName : NSString = ""
var thirdDestDesc : NSString = ""
var thirdDestLat : NSString = ""
var thirdDestLon : NSString = ""
var thirdDestImg : NSString = ""
var thirdDestDst : NSString = ""

var fourthDestId : NSString = ""
var fourthDestName : NSString = ""
var fourthDestDesc : NSString = ""
var fourthDestLat : NSString = ""
var fourthDestLon : NSString = ""
var fourthDestImg : NSString = ""
var fourthDestDst : NSString = ""

var fifthDestId : NSString = ""
var fifthDestName : NSString = ""
var fifthDestDesc : NSString = ""
var fifthDestLat : NSString = ""
var fifthDestLon : NSString = ""
var fifthDestImg : NSString = ""
var fifthDestDst : NSString = ""

var sixthDestId : NSString = ""
var sixthDestName : NSString = ""
var sixthDestDesc : NSString = ""
var sixthDestLat : NSString = ""
var sixthDestLon : NSString = ""
var sixthDestImg : NSString = ""
var sixthDestDst : NSString = ""

//For random place:
var randomPlaceId : NSString = ""
var randomPlaceName : NSString = ""
var randomPlaceDesc : NSString = ""
var randomPlaceLat : NSString = ""
var randomPlaceLon : NSString = ""
var randomPlaceImg : NSString = ""
var randomPlaceDst : NSString = ""

class SelectModeViewController: UIViewController {

	//Realm vars:
	let realm = RLMRealm.defaultRealm()
	
	//Random destination
	@IBAction func randomDestinationBttn(sender: UIButton) {
		setRandomDestinationInRealm()
		
		if Destination.allObjects().count == 1 {
			println("Random destination, \(randomPlaceName), selected!")
			self.performSegueWithIdentifier("randomModeSelected", sender: self)
		}
	}
	
	//Browse destination:
	@IBAction func browseDestinationBttn(sender: UIButton) {
		self.performSegueWithIdentifier("jumpToSelectDestination", sender: self)
	}
	
	//Array of the nearest places:
	var nearestPlaces = NSData()
	
	override func loadView() {
		super.loadView()
		
		getPlaces()
		getRandomPlace()
	}
	
	//Get a random, nearby place:
	func getRandomPlace() {
		var endpoint = NSURL(string: "http://davidhvejsel.dk/skjultesteder/api/random/56.1471/10.1927")
		var dataInput = NSData(contentsOfURL: endpoint!)
		var json = JSON(data: dataInput!)
		
		//Put the data in to vars:
		var rpId = json[0]["place_id"]
		var rpName = json[0]["name"]
		var rpDesc = json[0]["description"]
		var rpImg = json[0]["image_src"]
		var rpLat = json[0]["latitude"]
		var rpLon = json[0]["longitude"]
		
		randomPlaceId = "\(rpId)"
		randomPlaceName = "\(rpName)"
		randomPlaceDesc = "\(rpDesc)"
		randomPlaceImg = "\(rpImg)"
		randomPlaceLat = "\(rpLat)"
		randomPlaceLon = "\(rpLon)"
	}
	
	//Get nearest places:
	func getPlaces() {
		var endpoint = NSURL(string: "http://davidhvejsel.dk/skjultesteder/api/user/\(userID)/56.1471/10.1927")
		var dataInput = NSData(contentsOfURL: endpoint!)
		var json = JSON(data: dataInput!)
		
		//places vars:
		var firstId = json[0]["place_id"]
		var firstName = json[0]["name"]
		var firstDesc = json[0]["description"]
		var firstLat = json[0]["latitude"]
		var firstLon = json[0]["longitude"]
		var firstImg = json[0]["image_src"]
		var firstDst = json[0]["distance"]
		
		var secondId = json[1]["place_id"]
		var secondName = json[1]["name"]
		var secondDesc = json[1]["description"]
		var secondLat = json[1]["latitude"]
		var secondLon = json[1]["longitude"]
		var secondImg = json[1]["image_src"]
		var secondDst = json[1]["distance"]

		var thirdId = json[2]["place_id"]
		var thirdName = json[2]["name"]
		var thirdDesc = json[2]["description"]
		var thirdLat = json[2]["latitude"]
		var thirdLon = json[2]["longitude"]
		var thirdImg = json[2]["image_src"]
		var thirdDst = json[2]["distance"]

		var fourthId = json[3]["place_id"]
		var fourthName = json[3]["name"]
		var fourthDesc = json[3]["description"]
		var fourthLat = json[3]["latitude"]
		var fourthLon = json[3]["longitude"]
		var fourthImg = json[3]["image_src"]
		var fourthDst = json[3]["distance"]
		
		var fifthId = json[4]["place_id"]
		var fifthName = json[4]["name"]
		var fifthDesc = json[4]["description"]
		var fifthLat = json[4]["latitude"]
		var fifthLon = json[4]["longitude"]
		var fifthImg = json[4]["image_src"]
		var fifthDst = json[4]["distance"]

		var sixthId = json[5]["place_id"]
		var sixthName = json[5]["name"]
		var sixthDesc = json[5]["description"]
		var sixthLat = json[5]["latitude"]
		var sixthLon = json[5]["longitude"]
		var sixthImg = json[5]["image_src"]
		var sixthDst = json[5]["distance"]


		//set the global vars too:
		firstDestId = "\(firstId)"
		firstDestName = "\(firstName)"
		firstDestDesc = "\(firstDesc)"
		firstDestLat = "\(firstLat)"
		firstDestLon = "\(firstLon)"
		firstDestImg = "\(firstImg)"
		firstDestDst = "\(firstDst)"

		secondDestId = "\(secondId)"
		secondDestName = "\(secondName)"
		secondDestDesc = "\(secondDesc)"
		secondDestLat = "\(secondLat)"
		secondDestLon = "\(secondLon)"
		secondDestImg = "\(secondImg)"
		secondDestDst = "\(secondDst)"
		
		thirdDestId = "\(thirdId)"
		thirdDestName = "\(thirdName)"
		thirdDestDesc = "\(thirdDesc)"
		thirdDestLat = "\(thirdLat)"
		thirdDestLon = "\(thirdLon)"
		thirdDestImg = "\(thirdImg)"
		thirdDestDst = "\(thirdDst)"

		fourthDestId = "\(fourthId)"
		fourthDestName = "\(fourthName)"
		fourthDestDesc = "\(fourthDesc)"
		fourthDestLat = "\(fourthLat)"
		fourthDestLon = "\(fourthLon)"
		fourthDestImg = "\(fourthImg)"
		fourthDestDst = "\(fourthDst)"
		
		fifthDestId = "\(fifthId)"
		fifthDestName = "\(fifthName)"
		fifthDestDesc = "\(fifthDesc)"
		fifthDestLat = "\(fifthLat)"
		fifthDestLon = "\(fifthLon)"
		fifthDestImg = "\(fifthImg)"
		fifthDestDst = "\(fifthDst)"

		sixthDestId = "\(sixthId)"
		sixthDestName = "\(sixthName)"
		sixthDestDesc = "\(sixthDesc)"
		sixthDestLat = "\(sixthLat)"
		sixthDestLon = "\(sixthLon)"
		sixthDestImg = "\(sixthImg)"
		sixthDestDst = "\(sixthDst)"

	}
	
	//Save the random location to Realm:
	func setRandomDestinationInRealm() {
		realm.beginWriteTransaction()
		Destination.createInRealm(realm, withObject: [randomPlaceId, randomPlaceName, randomPlaceLat, randomPlaceLon, randomPlaceDesc, randomPlaceImg])
		realm.commitWriteTransaction()
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}