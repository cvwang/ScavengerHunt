//
//  ItemsManager.swift
//  ScavengerHunt
//
//  Created by Charles Wang on 1/15/15.
//  Copyright (c) 2015 Charles Wang. All rights reserved.
//

import Foundation

class ItemsManager{
    var items = [ScavangerHuntItem]()
    
    lazy private var archivePath: String = {
        let fileManager = NSFileManager.defaultManager()
        let documentDirectoryURLs = fileManager.URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask) as [NSURL]
        let archiveURL = documentDirectoryURLs.first!.URLByAppendingPathComponent("ScavengerHuntItems", isDirectory: false)
        return archiveURL.path!
    }()
    
    func save() {
        NSKeyedArchiver.archiveRootObject(items, toFile: archivePath)
    }
    
    private func unarchiveSavedItems() {
        if NSFileManager.defaultManager().fileExistsAtPath(archivePath) {
            let savedItems = NSKeyedUnarchiver.unarchiveObjectWithFile(archivePath) as [ScavangerHuntItem]
            items += savedItems
        }
    }
    
    init() {
        unarchiveSavedItems()
    }
}