//
//  DetailViewController.swift
//  ToDo App 2
//
//  Created by Mekong Lam on 04.06.16.
//  Copyright © 2016 Mekong Lam. All rights reserved.
//

import UIKit

protocol DetailViewControllerDelegate {
    func addItem(title: String, notes: String)
    func deleteItem(row: Int)
    func editItem(title: String, notes: String,row: Int)
}


class DetailViewController: UIViewController {
    
    var isEditingItem = true
    var delegate: DetailViewControllerDelegate?
    var selectedRow = 0
    var selectedToDoItem = [String: AnyObject]()

    @IBOutlet weak var titleTextField: UITextField! = UITextField()
    @IBOutlet weak var notesTextView: UITextView! = UITextView()
    @IBOutlet weak var deleteBarButtonItem: UIBarButtonItem!
    
    
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

    
    @IBAction func deleteButtonTapped(sender: AnyObject) {
        delegate?.deleteItem(selectedRow)
        print(selectedRow)
        self.navigationController?.popToRootViewControllerAnimated(true)
        return
    }
 
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
        return
    }
    
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        if (!isEditingItem){
            delegate?.addItem(titleTextField.text!, notes: notesTextView.text!)
        }
        else {
            print(isEditingItem)
            delegate?.editItem(titleTextField.text!, notes: notesTextView.text!, row: selectedRow)
            
        }
        self.navigationController?.popToRootViewControllerAnimated(true)
        return
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
