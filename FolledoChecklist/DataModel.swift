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
    
    init() { //p.311
        loadChecklist() //p.311
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
        }
    }
    
}
