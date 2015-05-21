//
//  ProfileViewController.swift
//  iOSSkjulteStederBuild5
//
//  Created by David Byrial Hvejsel on 10/03/15.
//  Copyright (c) 2015 DBH. All rights reserved.
//

import UIKit
import CoreLocation

class ProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var pIds : [String] = []
    var labelData : [String] = []
    var imgData : [String] = []
    var bgImgs : [String] = []
    var descTitles : [String] = []
    var descs : [String] = []
    var cats : [String] = []
    var lats : [String] = []
    var lons : [String] = []
    var upIds : [String] = []
    var dataObject : JSON = []
    
	//Unwind segue for settings view
	@IBAction func unwindToProfileViewController(sender: UIStoryboardSegue){
		
    }
    
    //check's if there's internet connection
    override func viewDidAppear(animated: Bool) {
        if !Reachability.isConnectedToNetwork(){
            var alert = UIAlertController(title: "Ingen forbindelse!", message: "Appen fungerer ikke uden internetforbindelse", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        //Check if the user has granted access to location data
        var authStatus : CLAuthorizationStatus = CLLocationManager.authorizationStatus()
        if authStatus == CLAuthorizationStatus.Denied || authStatus == CLAuthorizationStatus.Restricted{

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
    
    //fetch all the currents users visited places from the api
    func getVisitedPlaces(){
        var endPoint = NSURL(string: "http://appindex.dk/api/v2/visited/\(localeRequest)/david")
        var dataInput = NSData(contentsOfURL: endPoint!)
        var json = JSON(data: dataInput!)
        
        //println(json)
        
        visitedPlaces = json
        
        for (index, object) in json {
            let pId = object["place_id"].stringValue
            pIds += [pId]
            
            let name = object["name"].stringValue
            labelData += [name]
            
            let thImg = object["th_image"].stringValue
            imgData += [thImg]
            
            let bgImg = object["bg_image"].stringValue
            bgImgs += [bgImg]
            
            let descTitle = object["desc_title"].stringValue
            descTitles += [descTitle]
            
            let desc = object["description"].stringValue
            descs += [desc]
            
            let cat = object["category"].stringValue
            cats += [cat]
            
            let lat = object["latitude"].stringValue
            lats += [lat]
            
            let lon = object["longitude"].stringValue
            lons += [lon]
            
            let upId = object["unique_place_id"].stringValue
            upIds += [upId]
        }
    }
	
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getVisitedPlaces()

        // Do any additional setup after loading the view.
        //CollectionView setup:
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return visitedPlaces.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell : VisitedPlaceCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! VisitedPlaceCell
        //cell.lblCell.text = labelData[indexPath.row]
        //get image from web server:
        let imgURL = NSURL(string: "http://appindex.dk/api/img/\(imgData[indexPath.row])")
        println(imgURL)
        let urlRequest = NSURLRequest(URL: imgURL!)
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue(), completionHandler: {
            response, data, error in
            
            if error != nil {
                println(error)
            }
            else{
                let ajaxImage = UIImage(data: data)
                cell.imgCell.image = ajaxImage
            }
        })
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        println("Cell \(indexPath.row) selected");
        dataObject = [
            "place_id":"\(pIds[indexPath.row])",
            "name":"\(labelData[indexPath.row])",
            "desc_title":"\(descTitles[indexPath.row])",
            "description":"\(descs[indexPath.row])",
            "category":"\(cats[indexPath.row])",
            "latitude":"\(lats[indexPath.row])",
            "longitude":"\(lons[indexPath.row])",
            "bg_image":"\(bgImgs[indexPath.row])",
            "th_image":"\(imgData[indexPath.row])",
            "unique_place_id":"\(upIds[indexPath.row])"
        ]
        
        self.performSegueWithIdentifier("visitedPlaceDetail", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "visitedPlaceDetail" {
            let controller = (segue.destinationViewController as! UINavigationController).topViewController as! VisitedPlaceDetailController
            controller.dataObject = dataObject
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}