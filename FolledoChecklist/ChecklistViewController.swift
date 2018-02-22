//
//  ViewController.swift
//  FolledoChecklist
//
//  Created by Samuel Folledo on 2/20/18.
//  Copyright © 2018 Samuel Folledo. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
//tableView's numberOfRowsInSection
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5 //returns number of rows, which is 1 row of data in here
    }
    
    //tableView's cellForRowAt. It obtains cell for the row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath) //dequeueReusableCell Returns a reusable table-view cell object for the specified reuse identifier and adds it to the table.
        
        let label = cell.viewWithTag(1000) as! UILabel
        
        if indexPath.row == 0 {
            label.text = "Brush your teeth"
        } else if indexPath.row == 1 {
            label.text = "Get ready and gym"
        } else if indexPath.row == 2 {
            label.text = "Eat, poop and shower"
        } else if indexPath.row == 3 {
            label.text = "Study programming"
        } else if indexPath.row == 4 {
            label.text = "Sleep"
        }
        
        return cell
    }
}

