//
//  DataModel.swift
//  FolledoChecklist
//
//  Created by Samuel Folledo on 4/16/18.
//  Copyright © 2018 Samuel Folledo. All rights reserved.
//

import Foundation

class DataModel { //p.310
    var lists = [Checklist]()
    
    var indexOfSelectedChecklist: Int { //p.322 get{} set{} is an example of computed property
        get { //p.322 when app tries to read the value of indexOfSelectedChecklist, code in get{} block is performed
            return UserDefaults.standard.integer(forKey: "ChecklistIndex")
        }
        set {
            
            UserDefaults.standard.integer(forKey: "ChecklistIndex") //p.322 when app tries to put a new value into indexOfSelectedChecklist, set block is performed
            UserDefaults.standard.synchronize()
        }
    }
    
    init() { //p.311
        loadChecklist() //p.311
        registerDefaults() //p.321
        handleFirstTime() //p.326
    }
    
//sortChecklists p.333
    func sortChecklists() { //p.334
        lists.sort(by: { checklist1, checklist2 in //p.334
            return checklist1.name.localizedStandardCompare(checklist2.name) == .orderedAscending //p.334 this sort algorithm will repeatedly ask one Checklist object from the list how it compares to the other Checklist objects, and then suffles them around until the array is sorted. And allows sort() to sort the contents of the array in any order //localizedStandardCompare() compares the two name strings while ignoring lower/upper cases
        })
    }
    
//documentsDirectory //p.311
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
//dataFilePath //p.311
    func dataFilePath() -> URL { //p.311
        return documentsDirectory().appendingPathComponent ("Checklists.plist")
    }
    
//saveChecklistItems p.260 //p.311
    func saveChecklist() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        
        //archiver.encode(items, forKey: "ChecklistItems") //changed in p.302 //p.311
        archiver.encode(lists, forKey: "ChecklistItems") //p.311
        archiver.finishEncoding()
        data.write(to: dataFilePath(), atomically: true)
    }
//loadChecklistItem //p.311
    func loadChecklist() {
        let path = dataFilePath()
        if let data = try? Data(contentsOf: path) {
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
            
            //items = unarchiver.decodeObject(forKey: "ChecklistItems") as! [ChecklistItem] //modified in p.302 //p.311
            lists = unarchiver.decodeObject(forKey: "ChecklistItems") as! [Checklist] //p.302 modified and changed the as! [ChecklistItem] to as! [Checklist] //p.311
            unarchiver.finishDecoding()
            
            sortChecklists() //p.334
        }
    }
    
    func registerDefaults() { //p.321
        let dictionary: [String: Any] = ["ChecklistIndex": -1,
                                         "FirstTime": true,
                                         "ChecklistItemID": 0] //p.321 creates a new dictionary and adds a value -1 for ChecklistIndex key //p.325 modified for when user run this for the first time //p.363 added ChecklistItemID: 0, which is 0 first then increment by 1
        UserDefaults.standard.register(defaults: dictionary) //p.321 to prevent some errors, UserDefaults will use the values from this dictionary if you ask for a key but it cannot find anything under that key
    }
    
    func handleFirstTime() { //p.325
        let userDefaults = UserDefaults.standard
        let firstTime = userDefaults.bool(forKey: "FirstTime")
        
        if firstTime { //p.325 if firstTime is true then create and append a Checklist
            let checklist = Checklist(name: "List")
            lists.append(checklist)
            
            indexOfSelectedChecklist = 0
            userDefaults.set(false, forKey: "FirstTime") //p.325 then after firstTime is called, set its value to false to never call it again
            userDefaults.synchronize() //p.325
        }
    } //p.325
    
//p.364 class methods vs instance methods. A method starting with a class func allow syou to call methods on an object even when you dont have a reference to that object
    class func nextChecklistItemID() -> Int { //p.363 this method gets the current "ChecklistItemID" value from USerDegaults, adds 1 to it, and writes it back to UserDefaults. It returns the previous value to the caller
        let userDefaults = UserDefaults.standard //p.363
        let itemID = userDefaults.integer(forKey: "ChecklistItemID") //p.363
        userDefaults.set(itemID + 1, forKey: "ChecklistItemID") //p.363 this increments the ChecklistItemID's itemID by 1, which is important because u dont want two or more ChecklistItems to get the same ID
        userDefaults.synchronize() //p.363 //this method also does userDefaults.synchronize() to force UserDefaults to write these changes to disk immediately, so they wont get lost if you kill the app from Xcode before it had a chance to save
        return itemID //p.363
    }
    
}
