//
//  SettingsViewController.swift
//  iOSSkjulteStederBuild5
//
//  Created by Filip Ulatowski on 3/17/15.
//  Copyright (c) 2015 DBH. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var customSlider: UISlider!
    
    @IBOutlet weak var stopTracking: UIButton!
    
    @IBOutlet weak var sliderLabel: UILabel!
    
    @IBAction func sliderValue(sender: UISlider) {
        var currentValue = Int(sender.value)
        
        sliderLabel.text = "\(currentValue)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Slider Styling
        
        let leftTrackImage = UIImage(named: "bar@2x.png")
        customSlider.setMinimumTrackImage(leftTrackImage, forState: .Normal)
        
        let rightTrackImage = UIImage(named: "bar@2x.png")
        customSlider.setMaximumTrackImage(rightTrackImage, forState: .Normal)
        
        let thumbImage = UIImage(named: "thumb@2x.png")
        
        customSlider.setThumbImage(thumbImage, forState: .Normal)
        
        // button border
        
        stopTracking.layer.borderWidth = 1.0
        stopTracking.layer.borderColor = UIColor.whiteColor().CGColor
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
