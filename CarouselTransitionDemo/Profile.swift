//
//  Profile.swift
//  CarouselTransitionDemo
//
//  Created by Derek Carter on 4/13/18.
//  Copyright © 2018 Derek Carter. All rights reserved.
//

import Foundation
import UIKit

class Profile: NSObject {
    
    var name: String!
    var imageName: String!
    var details: String!
    var latitude: Double!
    var longitude: Double!
    
    
    init(name: String, imageName: String, details: String, latitude: Double, longitude: Double) {
        self.name = name
        self.imageName = imageName
        self.details = details
        self.latitude = latitude
        self.longitude = longitude
    }
    
}
