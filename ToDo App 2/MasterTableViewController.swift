//
//  MasterTableViewController.swift
//  ToDo App 2
//
//  Created by Mekong Lam on 04.06.16.
//  Copyright © 2016 Mekong Lam. All rights reserved.
//

import UIKit

class MasterTableViewController: UITableViewController, AddViewControllerDelegate {
    //Erstelle ein dictionary 'toDoItems'
    var toDoItemsList = [AnyObject]()
    let itemTitle = [AnyObject]()
    let itemNotes = [String]()
    
    override func viewDidAppear(animated:Bool){
        //initialisiere UserDefaults
        let userDefaults = NSUserDefaults.standardUserDefaults()
        //Erstelle eine dictionary namens itemListfromUserDefaults, die im userDefaults unter dem key 'itemList' abgespeichert wird
        
        //Wenn itemListfromUserDefaults nicht leer ist, dann speichere es in toDoItems ab
        if let itemListFromUserDefaults = userDefaults.objectForKey("itemList") as? [AnyObject] {
            toDoItemsList = itemListFromUserDefaults
        }
        
        self.tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addItem(title: String, notes: String) {
        //let dataSet = [ "itemTitle": title, "itemNote" : notes ]
        //toDoItems += [dataSet]
        var toDoItem = [String: AnyObject]()
        toDoItem["itemTitle"] = title
        toDoItem["itemNote"] = notes
        
        // add toDoItem to toDoItemsList
        toDoItemsList.append(toDoItem)
        
        NSUserDefaults.standardUserDefaults().setObject(toDoItemsList, forKey: "itemList")
        print(title)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItemsList.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        let Item = toDoItemsList[indexPath.row]
        let itemTitle = Item["itemTitle"]
        print("itemTitle: \(itemTitle)")
        let itemNotes = Item["itemNote"]
        // print("itemNotes: \(itemNotes)")
        //let toDoItem = toDoItems.values(indexPath.row) as! Dictionary
        cell.textLabel?.text = itemTitle as? String
        //print("Titel im Cell: \(indexPath.row)")
        //cell.textLabel?.text = toDoItem.objectForKey("itemTitle") as? String
        
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if let detailViewController: DetailViewController = segue.destinationViewController as? DetailViewController where segue.identifier == "showDetail" {
//            let selectedIndexPath: NSIndexPath = self.tableView.indexPathForSelectedRow!
//            detailViewController.toDoData = [itemTitle[selectedIndexPath.row] as! String: itemNotes[selectedIndexPath.row]]
//        }
        if let viewController = segue.destinationViewController as? DetailViewController where segue.identifier == "addItem" {
            viewController.delegate = self
            viewController.isEditingItem = false

        }
        else if let viewController = segue.destinationViewController as? DetailViewController where segue.identifier == "editItem" {
            let selectedIndexPath = tableView.indexPathForSelectedRow
            let selectedRow = selectedIndexPath!.row
            // get selected row from index path
            // get correct toDoItem from toDoItemsList
            let selectedToDoItem = toDoItemsList[selectedRow]
            // pass toDoItem to destinationViewController
            viewController.selectedToDoItem = selectedToDoItem as! [String : AnyObject]
            viewController.isEditingItem = true
            
            
        }
    }
  

}
