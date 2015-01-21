//
//  ViewController.swift
//  ScavengerHunt
//
//  Created by Charles Wang on 1/15/15.
//  Copyright (c) 2015 Charles Wang. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    
    var newItem: ScavangerHuntItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var textField: UITextField!
    
    @IBAction func cancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DoneItem" {
            if let name = textField.text {
                if !name.isEmpty{
                    newItem = ScavangerHuntItem(name: textField.text)
                }
            }
        }
    }
}

