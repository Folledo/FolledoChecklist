//
//  ItemDetailViewController.swift
//  FolledoChecklist
//
//  Created by Samuel Folledo on 3/21/18.
//  Copyright © 2018 Samuel Folledo. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

protocol ItemDetailViewControllerDelegate: class { //p.231 created our own delegate protocol (contract between B and any screens who wish to use it), to transfer the message back to ChecklistViewController or ChecklistItem?
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController)
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: ChecklistItem)
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditing item: ChecklistItem) //p.248 for editingCells
}

class ItemDetailViewController: UITableViewController, UITextFieldDelegate { //Made the ItemDetailViewController a delegate for the textField. Text field will send events to this delegate to let it know what is goin on. p.223... The ItemDetailViewController is already a delegate (and data source) for the UITableView (because it is a UITableViewController). now it is also become the delgate for the text field object, UITextField
    
    @IBOutlet weak var textField: UITextField! //p.219
    @IBOutlet weak var doneBarButton: UIBarButtonItem! //p.225
    @IBOutlet weak var shouldRemindSwitch: UISwitch! //p.366
    @IBOutlet weak var dueDateLabel: UILabel! //p.366
    @IBOutlet weak var datePickerCell: UITableViewCell! //p.370
    @IBOutlet weak var datePicker: UIDatePicker! //p.370
    
    
    
    weak var delegate: ItemDetailViewControllerDelegate? //p.232
    var itemToEdit:ChecklistItem? //p.244 will contain the existing ChecklistITem
    var dueDate = Date() //p.366
    var datePickerVisible = false //p.369
    
    
//viewDidLoad
    override func viewDidLoad() { //p.244 viewDidLoad is called by UIKit when the VC is loaded from the storyboard before it is shown in the screen (where to put user interface in order)
        super.viewDidLoad() //p.244
        
        if let item = itemToEdit { //p.244 unwrap the optional which checks if itemToEdit is nil or not. If it's not nil then it runs the code
            title = "Edit Item" //p.244
            textField.text = item.text //p.244
            doneBarButton.isEnabled = true //p.248
            
            shouldRemindSwitch.isOn = item.shouldRemind //p.367
            dueDate = item.dueDate //p.367
        }
        
        updateDueDateLabel()
    }
    
//showDatePicker p.369
    func showDatePicker() { //p.369
        datePickerVisible = true //p.369
        
        let indexPathDateRow = IndexPath(row: 1, section: 1) //p.375
        let indexPathDatePicker = IndexPath(row: 2, section: 1) //p.369 tells the table view to insert a new row below the Due Date cell, which will contain teh UIDatePicker
        
        if let dateCell = tableView.cellForRow(at: indexPathDateRow) { //p.375
            dateCell.detailTextLabel!.textColor = dateCell.detailTextLabel!.tintColor //p.375 this sets the textColor of the detailTextLabel to the tint color
        }
        
        tableView.beginUpdates()//p.375
        tableView.insertRows(at: [indexPathDatePicker], with: .fade) //p.369
        tableView.reloadRows(at: [indexPathDateRow], with: .none) //p.375 tells tablieView to reload the Due Date row, or it wont update properly
        tableView.endUpdates() //p.375 since ur doing 2 operations on the table view at the same time- inserting a new row and reloading another - u need to put this in between beginUpdates() and endUpdates() so that tableView can animate everything at the same time
        
        datePicker.setDate(dueDate, animated: false) //p.374 this gives the proper date to the UIdatePicker component
    }
    
//updateDueDateLabel method p.367
    func updateDueDateLabel() { //p.367
        let formatter = DateFormatter() //p.367 A formatter that converts between dates and their textual representations.
        formatter.dateStyle = .medium //p.367 Specifies a medium style, typically with abbreviated text, such as “Nov 23, 1937” or “3:30:32 PM”.
        formatter.timeStyle = .short //p.367 The time style of the receiver.
        dueDateLabel.text = formatter.string(from: dueDate) //p.367
    }
    
    
    
//done
    @IBAction func done() {
        //dismiss(animated: true, completion: nil) //p.210, removed on p.233
        if let item = itemToEdit { //p.249
            item.text = textField.text! //p.249
            item.shouldRemind = shouldRemindSwitch.isOn //p.368 //here you put the value of the switch control and the dueDate instance variable back into the ChecklistItem object when the user presses the Done button
            item.dueDate = dueDate //p.368
            
            item.scheduleNotification() //p.377
            
            delegate?.itemDetailViewController(self, didFinishEditing: item) //p.249
        } else { //p.249
            let item = ChecklistItem() //p.233
            item.text = textField.text! //p.233
            item.checked = false //p.233
            delegate?.itemDetailViewController(self, didFinishAdding: item) //p.233
        }
    }
//cancel
    @IBAction func cancel() {
        delegate?.itemDetailViewControllerDidCancel(self) //p.233
        //dismiss(animated: true, completion: nil) //dismiss(animated: Bool, completion: (()->Void)?) p.210 dismiss function returns the screen back to the previous screen. After VC disappears from the screen, its object is destroyed and the memory it was using reclaimed it around afterwards
    }
    
//willSelectRowAt
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? { //p.213 row turns gray because you selected it, but this delegate disable selections for this row
        
        if indexPath.section == 1 && indexPath.row == 1 { //p.373 //if it matches with the Due Date row
            return indexPath //p.373
        } else { //p.373
            return nil//p.214 when user taps in cell, the table view sends the delegate a "willSelectRowAt" message that says "I am about to select this particular row". But by returning nil, the delegate answers, "Sorry, but youre not allowed to"
        } //p.373
    }
    
//viewWillAppear
    override func viewWillAppear(_ animated: Bool) {//p.220 view controller receives the viewWillAppear message just before it becomes visible
        super.viewWillAppear(animated)//(animated: Bool)
        textField.becomeFirstResponder()//p.220 we make textField automatically appear once the screen opens, by sending it the becomeFirstResponser message
    }
    
//(textField:, shouldChangeCharactersIn range:, replacementString string:)
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let oldText = textField.text! as NSString
        let newText = oldText.replacingCharacters(in: range, with: string) as NSString
        doneBarButton.isEnabled = (newText.length > 0) //instead of if else, it enables the doneBarButton if the length of newText is greater than 0
        return true
    }
    
//cellForRowAt for the datePickerCell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { //p.371
        
        if indexPath.section == 1 && indexPath.row == 2 { //p.371 this checks whether "cellForRowAt" is being called with the index-path for the date picker row. If so, return datePickerCell. This is safe to do because the table view from the storyboard doesnt know anything about row 2 in section 1, so youre not interefering with an existing static cell
            return datePickerCell //p.371
        } else { //p.371
            return super.tableView(tableView, cellForRowAt: indexPath) //p.371 for any index path that are not the date picker cell, this method will call through to super(which is UITableViewController), which is the trick that makes sure the other static cells still work
        }
    }
    
//numberOfRowsInSection p.372
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { //p.372 if date picker is visible, then section 1 has 3 rows. If the date picker isnt visible, you can simply pass through to the original data source
        if section == 1 && datePickerVisible { //p.372
            return 3 //p.372
        } else { //p.372
            return super.tableView(tableView, numberOfRowsInSection: section) //p.372
        } //p.372
    }
    
//heightForRowAt p.372
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { //p.372
        if indexPath.section == 1 && indexPath.row == 2 { //p.372
            return 217 //p.372
        } else { //p.372
            return super.tableView(tableView, heightForRowAt: indexPath) //p.372
        }
    }
    
//didSelectRowAt p.372
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true) //p.372
        textField.resignFirstResponder() //p.372 removes the on screen keyboard
        
        if indexPath.section == 1 && indexPath.row == 1 { //p.372 this calls the showDatePicker() when the index-path indicates that the Due Date row was tapped. It also hides the on-screen keyboard if taht was visible
            if !datePickerVisible { //p.376
                showDatePicker() //p.372
            } else { //p.376
                hideDatePicker() //p.376
            } //p.376
        }
    }
    
//indentationLevelForRowAt p.373
    override func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int { //p.373 when u override teh data source for a static table view cell, u also need to provide the delegate method tableView(indentationLevelForRowAt). The reason the app crashed on this method was that the standard data source doesnt know anything about the cell at row 2 in section 1. To fix this, u have to tric the data source into believing there really are 3 rows in that section when the date picker is visible
        var newIndexPath = indexPath //p.373
        if indexPath.section == 1 && indexPath.row == 2 { //p.373
            newIndexPath = IndexPath(row: 0, section: indexPath.section) //p.373
        } //p.373
        return super.tableView(tableView, indentationLevelForRowAt: newIndexPath) //p.373
    }
    
//dateChanged
    @IBAction func dateChanged(_ datePicker: UIDatePicker) { //p.374
        dueDate = datePicker.date //p.374
        updateDueDateLabel() //p.374
    }
    
//hideDatePicker p.376 which does the opposite of teh showDatePicker(). It deletes the date picker cell from the table view and restores the color of the date label to medium gray
    func hideDatePicker() { //p.376
        if datePickerVisible { //p.376
            datePickerVisible = false //p.376
            let indexPathDateRow = IndexPath(row: 1, section: 1) //p.376
            let indexPathDatePicker = IndexPath(row: 2, section: 1) //p.376
            
            if let cell = tableView.cellForRow(at: indexPathDateRow) { //p.376
                cell.detailTextLabel!.textColor = UIColor(white: 0, alpha: 0.5) //p.376
            }
            tableView.beginUpdates() //p.376
            tableView.reloadRows(at: [indexPathDateRow], with: .none) //p.376
            tableView.deleteRows(at: [indexPathDatePicker], with: .fade) //p.376
            tableView.endUpdates() //p.376
        }
    }
    
//textFieldDidBeginEditing() p.376
    func textFieldDidBeginEditing(_ textField: UITextField) { //p.376 to hide datePicker when textfield is tapped
        hideDatePicker() //p.376
    }
    
//shouldRemindToggled method p.379
    @IBAction func shouldRemindToggled(_ switchControl: UISwitch) { //p.379 this only prompts user to allow access to send notification when the switch is toggled, instead of everytime the app initially begins
        textField.resignFirstResponder() //p.379
        
        if switchControl.isOn { //p.379
            let center = UNUserNotificationCenter.current() //p.379
            center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in //p.379
                /* Do nothing */
            }
        }
    }
}
