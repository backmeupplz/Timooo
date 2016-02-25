//
//  SideViewController.swift
//  Timooo
//
//  Created by Nikita Kolmogorov on 03/03/15.
//  Copyright (c) 2015 Borodutch Studio LLC. All rights reserved.
//

import Foundation

class SideViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var data: [HistoryObject]!
    
    // MARK: - VC Life Cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNotifications()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        loadData()
        tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource -
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TomatoCell") as! TomatoCell
        cell.object = data[indexPath.row]
        return cell
    }
    
    // MARK: - UITableViewDelegate -
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == .Delete) {
            tableView.beginUpdates()
            data.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation:.Fade)
            tableView.endUpdates()
            
            MemoryManager.sharedInstance.deleteTomato(indexPath.row)
        }
    }
    
    // MARK: - General Methods -
    
    func loadData() {
        data = MemoryManager.sharedInstance.getHistory()
    }
    
    // MARK: - Notifications -
    
    func setupNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"shouldAddTomato:", name:didAddTomato, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"shouldUpdateTomato:", name:didUpdateTomato, object: nil)
        
        
    }
    
    func shouldAddTomato(notification: NSNotification) {
        let object = notification.userInfo![newValueKey] as! HistoryObject
        tableView.beginUpdates()
        data.insert(object, atIndex: 0)
        tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation:.Fade)
        tableView.endUpdates()
    }
    
    func shouldUpdateTomato(notification: NSNotification) {
        loadData()
        tableView.reloadData()
    }
}
