//
//  SideViewController.swift
//  Timooo
//
//  Created by Nikita Kolmogorov on 03/03/15.
//  Copyright (c) 2015 Borodutch Studio LLC. All rights reserved.
//

import Foundation

class SideViewController: UIViewController {
    var data = [HistoryObject]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateFakeData()
        tableView.allowsMultipleSelectionDuringEditing = false
    }
    
    func generateFakeData() {
        for number in 1...20 {
            var object = HistoryObject()
            object.setDate(2015, month: 1, day: 21-number)
            object.tomatosCount = Int(arc4random_uniform(7)+1)
            data.append(object)
        }
    }
}

extension SideViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("TomatoCell") as! TomatoCell
        cell.object = data[indexPath.row]
        return cell
    }
}

extension SideViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == .Delete) {
            
        }
    }
}
