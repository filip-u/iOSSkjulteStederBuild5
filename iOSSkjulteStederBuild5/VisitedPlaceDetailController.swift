//
//  VisitedPlaceDetailController.swift
//  iOSSkjulteStederBuild5
//
//  Created by David Byrial Hvejsel on 20/05/15.
//  Copyright (c) 2015 DBH. All rights reserved.
//

import UIKit

class VisitedPlaceDetailController: UIViewController {

    @IBOutlet weak var bgImg: UIImageView!
    
    var dataObject : JSON = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //println(dataObject)
        //println("eller hva?")
        
        //Set background image:
        var bg_img : String = "bg_image"
        let imgUrl = NSURL(string: "http://appindex.dk/api/img/\(dataObject[bg_img])")
        //println(dataObject["bg_img"])
        let urlRequest = NSURLRequest(URL: imgUrl!)
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue(), completionHandler: {
            response, data, error in
            
            if error != nil{
                println(error)
            }
            else{
                let bgImage = UIImage(data: data)
                self.bgImg.image = bgImage
                println("loading img ... ")
            }
        })
        
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
