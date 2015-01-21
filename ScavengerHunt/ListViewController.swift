//
//  ListViewController.swift
//  ScavengerHunt
//
//  Created by Charles Wang on 1/15/15.
//  Copyright (c) 2015 Charles Wang. All rights reserved.
//

import UIKit // contains Foundations

class ListViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    var itemsList = ["Cat", "Bird", "Brick"]
//    var itemsList = [
//        ScavangerHuntItem(name: "Cat"),
//        ScavangerHuntItem(name: "Bird"),
//        ScavangerHuntItem(name: "Brick")
//    ]
    
    var itemsManager = ItemsManager()
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let imagePicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            imagePicker.sourceType = .Camera
        } else {
            imagePicker.sourceType = .PhotoLibrary
        }
        
        imagePicker.delegate = self
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let indexPath = tableView.indexPathForSelectedRow() {
            let selectedItem = itemsManager.items[indexPath.row]
            let photo = info[UIImagePickerControllerOriginalImage] as UIImage
            selectedItem.photo = photo
            dismissViewControllerAnimated(true, completion: {
                self.itemsManager.save()
                self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            })
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsManager.items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ListViewCell", forIndexPath: indexPath) as UITableViewCell
//        cell.textLabel!.text = itemsList[indexPath.row]
        let item = itemsManager.items[indexPath.row]
        cell.textLabel!.text = item.name
        if item.isComplete {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            cell.imageView!.image = item.photo
        } else {
            cell.accessoryType = .None
            cell.imageView!.image = nil
        }
        return cell
    }
    
    @IBAction func unwindToList(segue: UIStoryboardSegue){
        if segue.identifier == "DoneItem" {
            let addViewController = segue.sourceViewController as AddViewController
            if let newItem = addViewController.newItem {
                itemsManager.items += [newItem]
                itemsManager.save()
                let indexPath = NSIndexPath(forItem: itemsManager.items.count - 1, inSection: 0)
                tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            }
        }
    }
}

