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
    
    func toggleChecked() { //p.193
        checked = !checked
    }
    
//Encode/Save ChecklistItem
    func encode(with aCoder: NSCoder) { //p.264 for saving and encoding the saved data for ChecklistItem
        aCoder.encode(text, forKey: "Text") //p.264 a ChecklistItem should have an object "Text" that contains the value of var text, and "Checked" with check
        aCoder.encode(checked, forKey: "Checked") //p.264
    }
    
//Decode/Load ChecklistItem
    required init?(coder aDecoder: NSCoder) { //p.264 for loading and decoding the plist data
        text = aDecoder.decodeObject(forKey: "Text") as! String //p.267 reverse of encode(with), by taking the objects frm the NSCoder's decoder object and put their values inside your own properties. What you stored under the "Text" key now goes back into the text instance variable
        checked = aDecoder.decodeBool(forKey: "Checked")
        super.init()
    }
    override init() {//p.265 because you added init?(coder) you also need to add an init() method that takes no parameters to build the app
        super.init()
    }
    
}
