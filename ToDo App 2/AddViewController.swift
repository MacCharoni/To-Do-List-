//
//  AddViewController.swift
//  ToDo App 2
//
//  Created by Mekong Lam on 04.06.16.
//  Copyright © 2016 Mekong Lam. All rights reserved.
//

import UIKit

protocol OriginalAddViewControllerDelegate {
    func addItem(title: String, notes: String)
}

class AddViewController: UIViewController {

    var delegate: AddViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var titleTextField: UITextField! = UITextField()
    
    @IBOutlet weak var notesTextView: UITextView! = UITextView()
    
    @IBAction func addButtonTapped(sender: AnyObject) {
        
        delegate?.addItem(titleTextField.text!, notes: notesTextView.text!)
        self.navigationController?.popToRootViewControllerAnimated(true)
        return
        
        let userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
                var itemList = userDefaults.objectForKey("itemList") as? [String: AnyObject]
        // Erstelle eine Itemliste im userDefaults
//        var itemList = [String: AnyObject]()
        
        
        
        
        
       /* if itemList?.count != 0 { //data already available
            /*let newMutableList: NSMutableArray = NSMutableArray()
            for dict: AnyObject in itemList! {
            
                newMutableList.addObject(dict as! NSDictionary)
                userDefaults.removeObjectForKey("itemList") // warum entferne ich hier die Itemliste? aus der UserDefaults??
                //füge die eingegebene ToDo ein
                newMutableList.addObject(dataSet)
                userDefaults.setObject(newMutableList, forKey: "itemList")
            }*/
            
        
            
        }
        else { //This is the first todo item in the list
            //
            userDefaults.removeObjectForKey("itemList")
            itemList = NSMutableArray()
            itemList!.addObject(dataSet)
            userDefaults.setObject(itemList, forKey: "itemList")
            
            //let list = [[String:String]]()
            
        }
 
        self.navigationController?.popToRootViewControllerAnimated(true)*/
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
