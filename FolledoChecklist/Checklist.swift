//
//  Checklist.swift
//  FolledoChecklist
//
//  Created by Samuel Folledo on 4/14/18.
//  Copyright © 2018 Samuel Folledo. All rights reserved.
//

import UIKit

class Checklist: NSObject, NSCoding { //p.303 NSCoding was added, which requires 2 methods: init?(coder) and encode(with)
    var name = "" //p.279
    var items = [ChecklistItem]() //p.297 an empty array that can hold ChecklistItem objects
    
    init(name: String) { //p.280 lets you create a new list and immediately give it a name in one line
        self.name = name //p.280 initializer takes one parameter, name, and places it into the instance variable,which is also a name
        super.init()
    }
    
//p.303 encode(with) and init?(coder) saves and loads the Checklist's name and items r
    func encode(with aCoder: NSCoder) { //p.303 protocol method for NSCoding
        aCoder.encode(name, forKey: "Name")
        aCoder.encode(items, forKey: "Items")
    }
    required init?(coder aDecoder: NSCoder) { //p.303 protocol method for NSCoding
        name = aDecoder.decodeObject(forKey: "Name") as! String
        items = aDecoder.decodeObject(forKey: "Items") as! [ChecklistItem]
        super.init()
    }
}
