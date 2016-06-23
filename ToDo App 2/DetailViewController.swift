//
//  DetailViewController.swift
//  ToDo App 2
//
//  Created by Mekong Lam on 04.06.16.
//  Copyright © 2016 Mekong Lam. All rights reserved.
//

import UIKit

protocol AddViewControllerDelegate {
    func addItem(title: String, notes: String)
}

class DetailViewController: UIViewController {
    
    var isEditingItem = true
    var delegate: AddViewControllerDelegate?
    
   // var toDoData = [String: AnyObject]()
    
    var selectedToDoItem = [String: AnyObject]()

    @IBOutlet weak var titleTextField: UITextField! = UITextField()
    @IBOutlet weak var notesTextView: UITextView! = UITextView()
    @IBOutlet weak var deleteBarButtonItem: UIBarButtonItem!
   
    @IBAction func deleteItem(sender: AnyObject) {
       /* let userDefaults: NSUserDefaults = NSUserDefaults()
        let itemListArray: NSMutableArray = userDefaults.objectForKey("itemList") as! NSMutableArray
        let mutableItemList: NSMutableArray = NSMutableArray()
        
        for dict: AnyObject in itemListArray{
            mutableItemList.addObject(dict as! NSDictionary)
        }
        
    mutableItemList.removeObject(toDoData)
    userDefaults.removeObjectForKey("itemList")
    userDefaults.setObject(mutableItemList, forKey: "itemList")
    */
    self.navigationController?.popToRootViewControllerAnimated(true)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.text = selectedToDoItem["itemTitle"] as? String
        notesTextView.text = selectedToDoItem["itemNote"] as? String
        navigationController?.setToolbarHidden(false, animated: false)
        if (isEditingItem) {
            deleteBarButtonItem.enabled = true
            
        } else {
            deleteBarButtonItem.enabled = false
        }
    }

    
    
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        delegate?.addItem(titleTextField.text!, notes: notesTextView.text!)
        self.navigationController?.popToRootViewControllerAnimated(true)
        return
        //let userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        //var itemList = userDefaults.objectForKey("itemList") as? [String: AnyObject]
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
