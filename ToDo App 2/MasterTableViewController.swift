//
//  MasterTableViewController.swift
//  ToDo App 2
//
//  Created by Mekong Lam on 04.06.16.
//  Copyright © 2016 Mekong Lam. All rights reserved.


import UIKit
import AVFoundation

class MasterTableViewController: UITableViewController, DetailViewControllerDelegate {
    //Für die Übergabe der eingetragenen ToDoItems erstelle einen globalen Array toDoItemsList
    var toDoItemsList = [AnyObject]()
    //Für die Übergabe der randomToDos, erstelle eine randomItemsList
    var randomItemsList = [AnyObject]()
    //Für den Sound, erstelle einen globalen Audioplayer
    var audioPlayer: AVAudioPlayer!

    

    
    override func viewDidAppear(animated:Bool){
        //initialisiere UserDefaults
        let userDefaults = NSUserDefaults.standardUserDefaults()
        //Erstelle ein Dictionary namens itemListfromUserDefaults, die im userDefaults unter dem key 'itemList' abgespeichert wird
        //Wenn itemListfromUserDefaults nicht leer ist, dann speichere es in toDoItemsList ab.
        if let itemListFromUserDefaults = userDefaults.objectForKey("itemList") as? [AnyObject] {
            toDoItemsList = itemListFromUserDefaults
        }
        //Erstelle analog dazu die randomItemList
        if let randomItemListFromUserDefaults = userDefaults.objectForKey("randomItemList") as? [AnyObject] {
            randomItemsList = randomItemListFromUserDefaults
        }
        
        self.tableView.reloadData()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //Initialisiere den Audioplayer mit der Sounddatei
        let screamSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("scream", ofType: "mp3")!)
        audioPlayer = try! AVAudioPlayer(contentsOfURL:screamSound)
        //Befülle die randomToDoItemsListe mit einzelnen toDoItems in Form von Dictionaries
        var randomItem1 = [String: String]()
        randomItem1["itemTitle"] = "Zähne putzen"
        randomItem1["itemNote"] = "Ne, Idee wofür Zahnbürsten gut sind?"
        randomItemsList.append(randomItem1)
        var randomItem2 = [String: String]()
        randomItem2["itemTitle"] = "Mich öfter benutzen"
        randomItem2["itemNote"] = "Wenn du schon nicht auf deine Mutter hörst, dann gefälligst auf mich"
        randomItemsList.append(randomItem2)
        var randomItem3 = [String: String]()
        randomItem3["itemTitle"] = "Dusch' mal, du stinkst!"
        randomItem3["itemNote"] = "Wenn du schon nicht auf deine Mutter hörst, dann gefälligst auf mich"
        randomItemsList.append(randomItem3)
        var randomItem4 = [String: String]()
        randomItem4["itemTitle"] = "Was kannst du eigentlich?"
        randomItem4["itemNote"] = "Wenn du schon nicht auf deine Mutter hörst, dann gefälligst auf mich"
        randomItemsList.append(randomItem3)
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addItem(title: String, notes: String) {
        //speichere den eingetippten Titel und die Notizen der ToDoListe in die allgemeine toDoItemsList hinzu
        var toDoItem = [String: AnyObject]()
        toDoItem["itemTitle"] = title
        toDoItem["itemNote"] = notes
        toDoItemsList.append(toDoItem)
        //Füge wahllos, nach jedem neuen Eintrag noch zusätzlich toDoItems aus der randomToDoItemsList hinzu, die zufällig ausgewählt werden
        let listSize = UInt32 (randomItemsList.count)
        print("randomItemList.count:\(listSize)")
        if (arc4random_uniform(5) < 5 ){
            
            let randomNumber = Int(arc4random_uniform(listSize))
            
            toDoItemsList.append(randomItemsList[randomNumber])
        }
        NSUserDefaults.standardUserDefaults().setObject(toDoItemsList, forKey: "itemList")
        tableView.reloadData()
    }
    
    func deleteItem(row: Int) {
        //Spiele den Sound bei jedem gelöschten Eintrag ab
        audioPlayer.play()
        //entferne das ToDoItem aus der zuvor ausgewählten Reihe
        toDoItemsList.removeAtIndex(row)
        //aktualisiere die toDoItemsList im NSUserDefaults
        NSUserDefaults.standardUserDefaults().setObject(toDoItemsList, forKey: "itemList")
        //Füge wahllos, nach jedem gelöschten Eintrag noch zusätzlich toDoItems aus der randomToDoItemsList hinzu, die zufällig ausgewählt werden
        let listSize = UInt32 (randomItemsList.count)
        if (arc4random_uniform(5) < 5 ){
            
            let randomNumber = Int(arc4random_uniform(listSize))
            
            toDoItemsList.append(randomItemsList[randomNumber])
        }
        NSUserDefaults.standardUserDefaults().setObject(toDoItemsList, forKey: "itemList")
        tableView.reloadData()
    }
    
    func editItem(title: String, notes: String,row: Int) {
        //Dieses editItem hat mal funktioniert.. ich habe allerdings leider nicht herausfinden können warum es nicht klappt, ich befürchte dass es an meinen beiden segues liegt und dem evtl nicht korrekt aktualisierten boolean "editItem". Aus Zeitmangel, dachte ich dass diese Missfunktion meiner nervigen ToDoListenApp bloß noch mehr Charakter gibt :)
        var toDoItem = [String: AnyObject]()
        toDoItem["itemTitle"] = title
        toDoItem["itemNote"] = notes
        toDoItemsList.insert(toDoItem, atIndex: row)
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
        //Befülle die tableView Reihen mit den Itemtiteln aus der toDoItemsList
        let Item = toDoItemsList[indexPath.row]
        let itemTitle = Item["itemTitle"]
        let itemNotes = Item["itemNote"]
        cell.textLabel?.text = itemTitle as? String
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
            
            //übergebe dem segue addItem den delegate und stelle mit isEditingItem = false sicher, dass die Löschoption beim Erstellen neuer Items nicht möglich ist
            viewController.delegate = self
            viewController.isEditingItem = false

        }
        else if let viewController = segue.destinationViewController as? DetailViewController where segue.identifier == "editItem" {
            //übergebe für die Bearbeitung der toDoItems die benötigten Daten
            viewController.delegate = self
            let selectedIndexPath = tableView.indexPathForSelectedRow
            let selectedRow = selectedIndexPath!.row
            // get selected row from index path
            let selectedToDoItem = toDoItemsList[selectedRow]
            // get correct toDoItem from toDoItemsList
            // pass toDoItem to destinationViewController
            viewController.selectedToDoItem = selectedToDoItem as! [String : AnyObject]
            viewController.selectedRow = selectedRow
            viewController.isEditingItem = true
            
            
            
        }
    }
  

}
