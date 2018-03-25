//
//  ViewController.swift
//  FolledoChecklist
//
//  Created by Samuel Folledo on 2/20/18.
//  Copyright © 2018 Samuel Folledo. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController, AddItemViewControllerDelegate { //p.235 ChecklistVC now promises to do the things from AddItemViewControllerDelegate protocol

    
    var items = [ChecklistItem]()//this declares that items will hold an array of ChecklistItem objects but it does not actually create that array. At this point, items does not have a value yet
    //or var items: [ChecklistItem] = []
    //items = [ChecklistItem]() //Swift 3's way to instantiates --------- This instantiates (create a representation)the array. Now items contains a valid array object, but the array has no ChecklistItem objects inside it yet until you append them

//initializer
    required init?(coder aDecoder: NSCoder) { //p.187 all variables should have a value, if you can't give it a value right away when declared, then you have to give it a value inside an initializer mothod
        let row0item = ChecklistItem() //create a ChecklistItem object
        row0item.text = "Brust your teeth" //this time the text and checked variables are not separate instance variables of the view controller but properties of ChecklistItem objects
        row0item.checked = false
        items.append(row0item)
        
        let row1item = ChecklistItem() //This instantiates a new ChecklistItem object, notice the ().
        row1item.text = "Do your bed" //Give values to the data items inside the new ChecklistItem object
        row1item.checked = true
        items.append(row1item) //This adds the ChecklistItem object into the items array
        
        let row2item = ChecklistItem()
        row2item.text = "Warm up"
        row2item.checked = true
        items.append(row2item)
        
        let row3item = ChecklistItem()
        row3item.text = "Eat and shower"
        row3item.checked = false
        items.append(row3item)
        
        let row4item = ChecklistItem()
        row4item.text = "Study"
        row4item.checked = false
        items.append(row4item)
        
        
        super.init(coder: aDecoder)
    }
    
//viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
//tableView's numberOfRowsInSection that returns the number of rows in a tableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //return 5 //returns number of rows
        return items.count //p.191 returns a number of rows based on the amount of elements inside items array
    }
    
//tableView's cellForRowAt. It obtains cell for the row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath) //dequeueReusableCell Returns a reusable table-view cell object for the specified reuse identifier and adds it to the table.
        let item = items[indexPath.row] //p.190
        configureText(for: cell, with: item) //p.192 sets the checklist item's text on the cell's label
        configureCheckmark(for: cell, with: item)//p.193 instead of p.179's at: indexPath with with: item
        
/*      if indexPath.row == 0 { //p. 186
            label.text = row0item.text
        } else if indexPath.row == 1 { //modulo operator, a remainder operator, represented by %
            label.text = row1item.text
        } else if indexPath.row == 2 {
            label.text = row2item.text
        } else if indexPath.row == 3 {
            label.text = row3item.text
        } else if indexPath.row == 4 {
            label.text = row4item.text
        }
*/
        
        //configureCheckmark(for: cell, at: indexPath) //p.179 Now let us add/remove checkmark. Initially, all rows r unchecked, and tapping it checks it. Rows and cells are now always in sync
        
        return cell
    }
    
//didSelectRowAt delegate for when rows are selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath){//if let because it is possible that there is no cell at the specified index-path (if row row isnt visible). if let tells Swift to only perform the rest of the code if there really is a UITableViewCell object
            
            let item = items[indexPath.row] //p.190
            item.toggleChecked()
            
            
/*          if cell.accessoryType == .none {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            
            if indexPath.row == 0 { //p.186
                row0item.checked = !row0item.checked
            } else if indexPath.row == 1 {
                row1item.checked = !row1item.checked
            } else if indexPath.row == 2 {
                row2item.checked = !row2item.checked
            } else if indexPath.row == 3 {
                row3item.checked = !row3item.checked
            } else if indexPath.row == 4 {
                row4item.checked = !row4item.checked
            }
            //--------------------------------------
            if isChecked { //this way, the logic that sets the checkmark on the cell has moved to the bottom of the method
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            } REPLACED BY the configureCheckmark
*/
            configureCheckmark(for: cell, with: item)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)//deselect rows
        
    }
    
//configureCheckmark
    func configureCheckmark(for cell: UITableViewCell, with item: ChecklistItem) {// p.192
        
        //p.242
        let label = cell.viewWithTag(1001) as! UILabel //p.242 check label's tag
        if item.checked {
            label.text = "✔️"
        } else {
            label.text = ""
        }
        
    //func configureCheckmark(for cell: UITableViewCell, at indexPath: IndexPath) { //this method looks at the cell for a certain row, specified by indexPath, and makes the checkmark visible if the corresponding "row checked" variable is true, or hides the checkmark if the var is false
        
        //removed in page 242
        /*Does not need "let item = items[indexPath.row]" as instead of indexPath, you now directly pass it the ChecklistItem object
        if item.checked { //p/192
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }*/
        
/*      var isChecked = false
        
        if indexPath.row == 0 { //p.186
            isChecked = row0item.checked
        } else if indexPath.row == 1 {
            isChecked = row1item.checked
        } else if indexPath.row == 2 {
            isChecked = row2item.checked
        } else if indexPath.row == 3 {
            isChecked = row3item.checked
        } else if indexPath.row == 4 {
            isChecked = row4item.checked
        }
        
        if isChecked {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
*/
    }
  
//configureText
    func configureText(for cell: UITableViewCell, with item: ChecklistItem) {//p.192 sets the checklist item's text on the cell's label
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
    }
    
/* addItem gets removed after p.238 when we created a delegate protocol that lets us customize what we add
    @IBAction func addItem() { //p.199
        let newRowIndex = items.count //p.200 calculate what the index of the new row in your array should be. This is encessary in orde to properly update yourself
        
        let item = ChecklistItem() //creates a new checklist item and adds it to the end of the array
        item.text = "I am a new row -Kobe"
        item.checked = false
        items.append(item)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0) //p.200 you put the index for the new row in the local constant newRowForIndex which won't change. p.200 Also have to tell the table view about this new row so it can add a new cell for that row. Table views uses index-paths to indentify rows, so first you make an IndexPath object that points to the new row, using the row number from the newRowIndex var
        let indexPaths = [indexPath] //p.200 creates a new temporary array holding just one of the index-path item
        tableView.insertRows(at: indexPaths, with: .automatic) //p.201 inserRows tells table view about the new row. This metho dactually let you insert multiple rows at the same time
    }
 */

//commitEditingStyle
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) { //p.202 that enables swipe-to-delete
        
        items.remove(at: indexPath.row) //p.202 remove the item from the data model
        
        let indexPaths = [indexPath] //p.202 delete the corresponding row from the table view
        tableView.deleteRows(at: indexPaths, with: .automatic) //deleteRows function
    }
    
//cancel func protocol from delegate protocol, AddItemViewControllerDelegate p.235
    func addItemViewControllerDidCancel(_ controller: AddItemViewController) {
        dismiss(animated: true, completion: nil)
    }
//func protocol from delegate protocol, AddItemViewControllerDelegate p.235
    func addItemViewController(_ controller: AddItemViewController, didFinishAdding item: ChecklistItem) {
        
        let newRowIndex = items.count //p.238 end of the array
        items.append(item) //p.238 add it to array items
        
        let indexPath = IndexPath(row: newRowIndex, section: 0) //p.238
        let indexPaths = [indexPath] //p.238
        tableView.insertRows(at: indexPaths, with: .automatic) //p.238 (at: [IndexPath], with: UITableViewRowAnnimation)
        
        dismiss(animated: true, completion: nil) //p.235
    }//let me delete the older previous addItem function
//func protocol for Editing p.250
    func addItemViewController(_ controller: AddItemViewController, didFinishEditing item: ChecklistItem) { //p.250
        
        if let index = items.index(of: item) {  //p.250
            let indexPath = IndexPath(row: index, section: 0) //p.250
            if let cell = tableView.cellForRow(at: indexPath) { //p.250
                configureText(for: cell, with: item) //p.250
            } //p.250
        } //p.250
        dismiss(animated: true, completion: nil) //p.250
    }
    
//prepare-for-segue p.236
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem" { //p.237 #1 There may be more than one segue per VC, so I gave this one a unique identifier and to check for that identifier first to make sure that we are handling the correct segue REMEMBER TO CHANGE THE IDENTIFIER OF THE SEGUE TO "AddItem"
            let navigationController = segue.destination as! UINavigationController //p.237 #2 new view controller can be found in segue.destination. The storyboard shoes that the segue does not go directly to AddItemViewController but to the navigation controller that embeds it. So first you get ahold of this UINagivationController object
            let controller = navigationController.topViewController as!  AddItemViewController //p.237 #3 To find the AddItemViewController, you can look at the navigation controller's topViewController property. This property refers to the screen that is currently active inside the navigation controller
            controller.delegate = self //p.237 #4 Once you have a reference to the AddItemViewController object, you set its delegate property to self and the connection is complete. This tells the AddItemViewController that from now on, the object known as self is its delegate, (self here is ChecklistViewController.swift)
        }
        else if segue.identifier == "EditItem" { //p.246
            let navigationController = segue.destination as! UINavigationController //p.246 same as the AddItem
            let controller = navigationController.topViewController as!  AddItemViewController //p.246 you get the navigation controller from the storyboard, and its embedded AddItemViewController using the topViewController property
            controller.delegate = self //p.246 and set the view controller's delegate property so data notified when use taps Cancel or Done
            
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) { //p.246 
                controller.itemToEdit = items[indexPath.row]
            }
        }
    }

}

