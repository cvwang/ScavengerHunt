//
//  ScavengerHuntItem.swift
//  ScavengerHunt
//
//  Created by Charles Wang on 1/15/15.
//  Copyright (c) 2015 Charles Wang. All rights reserved.
//

import UIKit

class ScavangerHuntItem: NSObject, NSCoding{
    let NameKey = "Name"
    let PhotoKey = "Photo"
    
    let name: String
    var photo: UIImage?
    var isComplete: Bool {
        get {
            return photo != nil
        }
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "Name")
        if let thePhoto = photo {
            aCoder.encodeObject(thePhoto, forKey: PhotoKey)
        }
    }
    
    required init(coder aDecoder: NSCoder){
        name = aDecoder.decodeObjectForKey(NameKey) as String
        photo = aDecoder.decodeObjectForKey(PhotoKey) as? UIImage
    }
    
    init (name: String) {
        self.name = name
    }
}
