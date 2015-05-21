//
//  VisitedPlaceCell.swift
//  iOSSkjulteStederBuild5
//
//  Created by David Byrial Hvejsel on 20/05/15.
//  Copyright (c) 2015 DBH. All rights reserved.
//

import UIKit

class VisitedPlaceCell: UICollectionViewCell {
    
    @IBOutlet var lblCell: UILabel!
    @IBOutlet var imgCell: UIImageView!
    
    override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes!){
        imgCell.layer.cornerRadius = imgCell.frame.size.width / 2
        imgCell.clipsToBounds = true
    }
}