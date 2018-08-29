//
//  ChecklistItem.swift
//  FolledoChecklist
//
//  Created by Samuel Folledo on 3/11/18.
//  Copyright © 2018 Samuel Folledo. All rights reserved.
//

import Foundation
import UserNotifications

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
    
//scheduleNotification p.377
    func scheduleNotification() { //p.377
        removeNotification() //p.380
        
        if shouldRemind && dueDate > Date() { //p.377 //compares due date of the checklist item with the current date by making a new Date(). The code block only gets run when the Remind Me switch is on and the due date is in the future
            //print("We should schedule a notification")
            
    //p.378
        //1) puts the item's text into the notification message
            let content = UNMutableNotificationContent() //p.378
            content.title = "Reminder:" //p.378
            content.body = text //p.378
            content.sound = UNNotificationSound.default() //p.378
        //2) extract the month, day, hour and minute from dueDate. No need for the seconds //p.378
            let calendar = Calendar(identifier: .gregorian) //p.378
            let components = calendar.dateComponents([.month, .day, .hour, .minute], from: dueDate) //p.378
        //3) to test the local notifications u used a UNTimeIntervalNotificationTrigger, which scheduled the notification to appear after a number of seconds. Here, youre using a UNCalendarNotificationTrigger, which shows the notification at the specified date
            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false) //p.378
        //4) Create the UNNotificationRequest object. Important here is taht we convert the item's numeric ID into a String and use it to identify the notification. That is how youll be able to find this notification later in case u need to cancel it
            let request = UNNotificationRequest(identifier: "\(itemID)", content: content, trigger: trigger) //p.378
        //5) add the new notification to the UNUserNotificationCenter
            let center = UNUserNotificationCenter.current() //p.378
            center.add(request, withCompletionHandler: nil) //p.378
            
            print("Scheduled notification \(request) for itemID \(itemID)") //p.378
            
        } //p.377
    }
    
    
//removeNotification
    func removeNotification() { //p.380 called in scheduleNotification() method
        let center = UNUserNotificationCenter.current() //p.380
        center.removePendingNotificationRequests(withIdentifiers: ["\(itemID)"]) //p.380 Unschedules the specified notification requests.
    }
    
//deinit p.381 An object is notified when it is about to be deleted using the deinit message
    deinit { //p.381 this method wil be invoked when u delete an individual ChecklistItem but also when you delete a whole Checklist
        removeNotification()
    }
}
