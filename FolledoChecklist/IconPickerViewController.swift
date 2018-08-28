//
//  IconPickerViewController.swift
//  FolledoChecklist
//
//  Created by Samuel Folledo on 8/27/18.
//  Copyright © 2018 Samuel Folledo. All rights reserved.
//

import UIKit

protocol IconPickerCiewControllerDelegate: class { //p.339
    func iconPicker(_ picker: IconPickerViewController, didPick iconName: String) //p.339
}

class IconPickerViewController: UITableViewController { //p.339
    
    weak var delegate: IconPickerCiewControllerDelegate? //p.339 this defines the IconPickerViewController object, which is a table view controller, and a delegate protocol that it uses to communicate with other objects in the app
    
    let icons = ["No Icon", "Groceries", "Meetings", "Chores", "Family", "Projects", "Reminders", "Birthdays", "Folder"] //p.339 array that containts a list of icon names and their imageName
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { //p.339
        return icons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { //p.340 here we obtain a table view cell and give it text and an image with a default style
        let cell = tableView.dequeueReusableCell(withIdentifier: "IconCell", for: indexPath) //p.340
        
        let iconName = icons[indexPath.row] //p.340
        cell.textLabel!.text = iconName //p.340
        cell.imageView!.image = UIImage(named: iconName) //p.340
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { //p.344 this change the IconPickerViewController to actually call the delegate method when a row is tapped
        if let delegate = delegate { //p.344
            let iconName = icons[indexPath.row] //p.344
            delegate.iconPicker(self, didPick: iconName) //p.344
        }
    }
    
}
