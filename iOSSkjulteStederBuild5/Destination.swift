//
//  Destination.swift
//  iOSSkjulteStederBuild5
//
//  Created by David Byrial Hvejsel on 10/03/15.
//  Copyright (c) 2015 DBH. All rights reserved.
//

import UIKit
import Realm

class Destination: RLMObject {
	dynamic var placeid = ""
	dynamic var name = ""
	dynamic var latitude = ""
	dynamic var longitude = ""
	dynamic var placedescription = ""
	dynamic var image = ""
}