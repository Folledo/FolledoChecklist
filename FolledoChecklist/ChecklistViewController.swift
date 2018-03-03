//
//  ViewController.swift
//  FolledoChecklist
//
//  Created by Samuel Folledo on 2/20/18.
//  Copyright © 2018 Samuel Folledo. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {

    var row0text = "Brust your teeth"
    var row1text = "Drink water and fix the bed"
    var row2text = "Get ready and go work out"
    var row3text = "Eat, poop and shower"
    var row4text = "Study"
    var row0checked = false
    var row1checked = false
    var row2checked = false
    var row3checked = false
    var row4checked = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
//tableView's numberOfRowsInSection that returns the number of rows in a tableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5 //returns number of rows
    }
    
//tableView's cellForRowAt. It obtains cell for the row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath) //dequeueReusableCell Returns a reusable table-view cell object for the specified reuse identifier and adds it to the table.
        
        let label = cell.viewWithTag(1000) as! UILabel
        
        if indexPath.row == 0 {
            label.text = row0text
        } else if indexPath.row == 1 { //modulo operator, a remainder operator, represented by %
            label.text = row1text
        } else if indexPath.row == 2 {
            label.text = row2text
        } else if indexPath.row == 3 {
            label.text = row3text
        } else if indexPath.row == 4 {
            label.text = row4text
        }
        
        configureCheckmark(for: cell, at: indexPath) //Now let us add/remove checkmark. Initially, all rows r unchecked, and tapping it checks it. Rows and cells are now always in sync
        
        return cell
    }
    
//didSelectRowAt delegate for when rows are selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath){//if let because it is possible that there is no cell at the specified index-path (if row row isnt visible). if let tells Swift to only perform the rest of the code if there really is a UITableViewCell object
            /*if cell.accessoryType == .none {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }*/
            var isChecked = false
            
            if indexPath.row == 0 {
                row0checked = !row0checked
                isChecked = row0checked
            } else if indexPath.row == 1 {
                row1checked = !row1checked
                isChecked = row1checked
            } else if indexPath.row == 2 {
                row2checked = !row2checked
                isChecked = row2checked
            } else if indexPath.row == 3 {
                row3checked = !row3checked
                isChecked = row3checked
            } else if indexPath.row == 4 {
                row4checked = !row4checked
                isChecked = row4checked
            }
            
            if isChecked { //this way, the logic that sets the checkmark on the cell has moved to the bottom of the method
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            
            
        }
        
        tableView.deselectRow(at: indexPath, animated: true)//deselect rows
        
    }
    
    func configureCheckmark(for cell: UITableViewCell, at indexPath: IndexPath) { //this method looks at the cell for a certain row, specified by indexPath, and makes the checkmark visible if the corresponding "row checked" variable is true, or hides the checkmark if the var is false
        var isChecked = false
        
        if indexPath.row == 0 {
            isChecked = row0checked
        } else if indexPath.row == 1 {
            isChecked = row1checked
        } else if indexPath.row == 2 {
            isChecked = row2checked
        } else if indexPath.row == 3 {
            isChecked = row3checked
        } else if indexPath.row == 4 {
            isChecked = row4checked
        }
        
        if isChecked {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }
    
}

