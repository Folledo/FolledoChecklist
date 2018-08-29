//
//  ChecklistItem.swift
//  FolledoChecklist
//
//  Created by Samuel Folledo on 3/11/18.
//  Copyright © 2018 Samuel Folledo. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject, NSCoding {
    //p.183 //p.251 Added NSObject basic building block of almost all objects in Objective-C //p.263 added a new protocol with encode and init method protocols, first one is for saving or encoding, and the other method for loading and decoding
    var text = ""
    var checked = false
    
    var dueDate = Date() //p.362
    var shouldRemind = false //p.362
    var itemID: Int //p.362
    
    func toggleChecked() { //p.193
        checked = !checked
    }
    
//Encode/Save ChecklistItem
    func encode(with aCoder: NSCoder) { //p.264 for saving and encoding the saved data for ChecklistItem
        aCoder.encode(text, forKey: "Text") //p.264 a ChecklistItem should have an object "Text" that contains the value of var text, and "Checked" with check
        aCoder.encode(checked, forKey: "Checked") //p.264
        
        aCoder.encode(dueDate, forKey: "DueDate") //p.362
        aCoder.encode(shouldRemind, forKey: "ShouldRemind") //p.362
        aCoder.encode(itemID, forKey: "ItemID") //p.362
    }
    
//Decode/Load ChecklistItem
    required init?(coder aDecoder: NSCoder) { //p.264 for loading and decoding the plist data
        text = aDecoder.decodeObject(forKey: "Text") as! String //p.267 reverse of encode(with), by taking the objects frm the NSCoder's decoder object and put their values inside your own properties. What you stored under the "Text" key now goes back into the text instance variable
        checked = aDecoder.decodeBool(forKey: "Checked")
        
    //p.362 have to extend init?(coder) and encode(with) in order to be able to load ans save these new properties along witht he ChecklistItem objects
        dueDate = aDecoder.decodeObject(forKey: "DueDate") as! Date //p.362 decodeObject
        shouldRemind = aDecoder.decodeBool(forKey: "ShouldRemind") //p.362
        itemID = aDecoder.decodeInteger(forKey: "ItemID") //p.362
        super.init()
    }
    override init() {//p.265 because you added init?(coder) you also need to add an init() method that takes no parameters to build the app
        
        itemID = DataModel.nextChecklistItemID() //p.363 this asks the DataModel object for a new item Id whenever the app creates a new ChecklistItem object
        super.init()
    }
    
}
