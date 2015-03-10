//
//  MainViewController.swift
//  iOSSkjulteStederBuild5
//
//  Created by David Byrial Hvejsel on 10/03/15.
//  Copyright (c) 2015 DBH. All rights reserved.
//

import UIKit

class MainViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

	var pages : [UIViewController] = []
	
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
