//
//  ViewController.swift
//  FolledoChecklist
//
//  Created by Samuel Folledo on 2/20/18.
//  Copyright © 2018 Samuel Folledo. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {

    
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
    //func configureCheckmark(for cell: UITableViewCell, at indexPath: IndexPath) { //this method looks at the cell for a certain row, specified by indexPath, and makes the checkmark visible if the corresponding "row checked" variable is true, or hides the checkmark if the var is false
        
        //Does not need "let item = items[indexPath.row]" as instead of indexPath, you now directly pass it the ChecklistItem object
        if item.checked { //p/192
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
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
    
}

