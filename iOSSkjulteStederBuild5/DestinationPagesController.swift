//
//  DestinationPagesController.swift
//  iOSSkjulteStederBuild5
//
//  Created by David Byrial Hvejsel on 10/03/15.
//  Copyright (c) 2015 DBH. All rights reserved.
//

import UIKit

//Global vars:
var loadNewPlaces : Bool = false

let reuseIdentifier = "Cell"

class DestinationPagesController: UICollectionViewController {

	var pages : [UIViewController] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
		
		let firstView = storyboard?.instantiateViewControllerWithIdentifier("firstView") as FirstDestinationView
		let secondView = storyboard?.instantiateViewControllerWithIdentifier("secondView") as SecondDestinationView
		let thirdView = storyboard?.instantiateViewControllerWithIdentifier("thirdView") as ThirdDestinationView
		let finalView = storyboard?.instantiateViewControllerWithIdentifier("finalView") as FinalViewController
		let absolutelyFinalView = storyboard?.instantiateViewControllerWithIdentifier("absolutelyFinalView") as AbsulotelyFinalViewController

		if loadNewPlaces == false {
			pages = [firstView, secondView, thirdView, finalView]
		}
		else{
			pages = [firstView, secondView, thirdView, absolutelyFinalView]
		}
    }
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		pages[0].view.frame = view.bounds
		pages[1].view.frame = view.bounds
		pages[2].view.frame = view.bounds
		pages[3].view.frame = view.bounds
		
	}
	
	override func prefersStatusBarHidden() -> Bool {
		return true
	}
	
	override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
		return 1
	}
	
	override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return pages.count
	}
	
	override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as UICollectionViewCell
		
		let row = indexPath.row
		let vc = pages[row].view
		cell.contentView.addSubview(vc)
		
		return cell
	}
	
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
		return collectionView.frame.size
	}
	
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndexPath section: Int) -> CGFloat {
		return 0
	}
	
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
		return 0
	}
}