//
//  DestinationPagesController.swift
//  iOSSkjulteStederBuild5
//
//  Created by David Byrial Hvejsel on 10/03/15.
//  Copyright (c) 2015 DBH. All rights reserved.
//

import UIKit

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
		let firstView : FirstDestinationView = FirstDestinationView(nibName: "FirstDestinationView", bundle: nil)
		let secondView : SecondDestinationView = SecondDestinationView(nibName: "SecondDestinationView", bundle: nil)
		let thirdView : ThirdDestinationView = ThirdDestinationView(nibName: "ThirdDestinationView", bundle: nil)
		let finalView : FinalViewController = FinalViewController(nibName: "FinalViewController", bundle: nil)
		
		pages = [firstView, secondView, thirdView, finalView]
    }
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		pages[0].view.frame = view.bounds
		pages[1].view.frame = view.bounds
		pages[2].view.frame = view.bounds
		pages[3].view.frame = view.bounds
		
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