//
//  ProfileViewController.swift
//  iOSSkjulteStederBuild5
//
//  Created by David Byrial Hvejsel on 10/03/15.
//  Copyright (c) 2015 DBH. All rights reserved.
//

import UIKit
import CoreLocation

class ProfileViewController: UIViewController {

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
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
