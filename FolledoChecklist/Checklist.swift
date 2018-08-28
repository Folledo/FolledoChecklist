//
//  Checklist.swift
//  FolledoChecklist
//
//  Created by Samuel Folledo on 4/14/18.
//  Copyright © 2018 Samuel Folledo. All rights reserved.
//

import UIKit

class Checklist: NSObject, NSCoding { //p.303 NSCoding was added, which requires 2 methods: init?(coder) and encode(with)
    
    var iconName: String //p.337
    var name = "" //p.279
    var items = [ChecklistItem]() //p.297 an empty array that can hold ChecklistItem objects
    
    init(name: String) { //p.280 lets you create a new list and immediately give it a name in one line
        self.name = name //p.280 initializer takes one parameter, name, and places it into the instance variable,which is also a name
        iconName = "No Icon"
        super.init()
    }
    
//p.327 a method that allows you to ask any Checklist object how many of its ChecklistItem objects do not have their checkmark set
    func countUncheckedItems() -> Int { //p.327
        
        var count = 0 //p.327
        for item in items where !item.checked { //p.327 if an item object has its checked property set to false, increment count. Can read it as "where not item.checked"
            count += 1 //p.327
        } //p.327
        return count //p.327 when the loop is over and youve looked at all the objects, it returns the total value of the count to the caller
        
        
//shorter version from p.332 with functional programming
//        return items.reduce(0) { count, item in count + (item.checked ? 0:1) } //p.332 reduce(0) Returns the result of combining the elements of the sequence using the given closure. 0 is the initial value of count if item.checked, add 0 to count, if not checked, then add 1
    }
    
    
//p.303 encode(with) and init?(coder) saves and loads the Checklist's name and items r
    func encode(with aCoder: NSCoder) { //p.303 protocol method for NSCoding
        aCoder.encode(name, forKey: "Name")
        aCoder.encode(items, forKey: "Items")
        aCoder.encode(iconName, forKey: "IconName")
    }
    required init?(coder aDecoder: NSCoder) { //p.303 protocol method for NSCoding
        name = aDecoder.decodeObject(forKey: "Name") as! String
        items = aDecoder.decodeObject(forKey: "Items") as! [ChecklistItem]
        
        iconName = aDecoder.decodeObject(forKey: "IconName") as! String //p.337
        super.init()
    }
}
