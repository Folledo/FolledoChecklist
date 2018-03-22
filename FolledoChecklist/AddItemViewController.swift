//
//  AddItemViewController.swift
//  FolledoChecklist
//
//  Created by Samuel Folledo on 3/21/18.
//  Copyright © 2018 Samuel Folledo. All rights reserved.
//

import Foundation
import UIKit

protocol AddItemViewControllerDelegate: class { //p.231 created our own delegate protocol (contract between B and any screens who wish to use it), to transfer the message back to ChecklistViewController or ChecklistItem?
    func addItemViewControllerDidCancel(_ controller: AddItemViewController)
    func addItemViewController(_ controller: AddItemViewController, didFinishAdding item: ChecklistItem)
}

class AddItemViewController: UITableViewController, UITextFieldDelegate { //Made the AddItemViewController a delegate for the textField. Text field will send events to this delegate to let it know what is goin on. p.223... The AddItemViewController is already a delegate (and data source) for the UITableView (because it is a UITableViewController). now it is also become the delgate for the text field object, UITextField
    
    @IBOutlet weak var textField: UITextField! //p.219
    @IBOutlet weak var doneBarButton: UIBarButtonItem! //p.225
    
    weak var delegate: AddItemViewControllerDelegate? //p.232
    
    @IBAction func done() {
        //dismiss(animated: true, completion: nil) //p.210, removed on p.233
        let item = ChecklistItem() //p.233
        item.text = textField.text!
        item.checked = false
        
        delegate?.addItemViewController(self, didFinishAdding: item) //p.233
    }
    
    @IBAction func cancel() {
        delegate?.addItemViewControllerDidCancel(self) //p.233
        //dismiss(animated: true, completion: nil) //dismiss(animated: Bool, completion: (()->Void)?) p.210 dismiss function returns the screen back to the previous screen. After VC disappears from the screen, its object is destroyed and the memory it was using reclaimed it around afterwards
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? { //p.213 row turns gray because you selected it, but this delegate disable selections for this row
        
        return nil//p.214 when user taps in cell, the table view sends the delegate a "willSelectRowAt" message that says "I am about to select this particular row". But by returning nil, the delegate answers, "Sorry, but youre not allowed to"
    }
    
    override func viewWillAppear(_ animated: Bool) {//p.220 view controller receives the viewWillAppear message just before it becomes visible
        super.viewWillAppear(animated)//(animated: Bool)
        textField.becomeFirstResponder()//p.220 we make textField automatically appear once the screen opens, by sending it the becomeFirstResponser message
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let oldText = textField.text! as NSString
        let newText = oldText.replacingCharacters(in: range, with: string) as NSString
        
        doneBarButton.isEnabled = (newText.length > 0) //instead of if else, it enables the doneBarButton if the length of newText is greater than 0
        
        return true
    }
    
}
