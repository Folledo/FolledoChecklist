//
//  ViewController.swift
//  FolledoChecklist
//
//  Created by Samuel Folledo on 2/20/18.
//  Copyright © 2018 Samuel Folledo. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController, ItemDetailViewControllerDelegate { //p.235 ChecklistVC now promises to do the things from ItemDetailViewControllerDelegate protocol

    //var items = [ChecklistItem]() //moved to Checklist.swift in p.298
    
    var checklist: Checklist! //p.284, an optional that must have a value //p.286 sequence of events is why checklist property is declared as Checklist!. This allows its value to be temporarily nil until viewDidLoad() happens, also you will not need if-let to unwrap it
    
/* //init?(coder) was removed at p.299
//initializer
    required init?(coder aDecoder: NSCoder) {
        checklist.items = [ChecklistItem]() //p.270 first u make sure the instance var has a proper value (a new array) //added checklist. in p.298
        super.init(coder: aDecoder) //p.270 then call super's version of init(), which is super.init(coder) to ensure the rest of teh VC is properly unfrozen from storyboard
        //loadChecklistItem() //p.270 finally call the method to do the real work for loading the plist file //removed in p.299

 
/* REPLACED ON PAGE 269
        let row0item = ChecklistItem() //create a ChecklistItem object
        row0item.text = "Brust your teeth"
        row0item.checked = false
        items.append(row0item)
        
        let row1item = ChecklistItem() //This instantiates a new ChecklistItem object, notice the ().
        row1item.text = "Do your bed"
        row1item.checked = true
        items.append(row1item) //This adds the ChecklistItem object into the items array
        
        let row2item = ChecklistItem()
        row2item.text = "Warm up"
        row2item.checked = true
        items.append(row2item)
        
        let row3item = ChecklistItem()
        row3item.text = "Eat and shower"
        row3item.checked = false
        items.append(row3item)
        
        let row4item = ChecklistItem()
        row4item.text = "Study"
        row4item.checked = false
        items.append(row4item)
        
        
        super.init(coder: aDecoder)
        
        print("Documents folder is \(documentsDirectory())") //p.257
        print("Data file path is \(dataFilePath())") //p.257
*/
    }
*/
    
//viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        title = checklist.name //p.284 changes the title of the screen. You'll give this Checklist object to the ChecklistViewController when segue is performed
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//numberOfRowsInSection that returns the number of rows in a tableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //return 5 //returns number of rows
        return checklist.items.count //p.191 returns a number of rows based on the amount of elements inside items array //checklist. is added at page 298
    }
    
//tableView's cellForRowAt. It obtains cell for the row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath) //dequeueReusableCell Returns a reusable table-view cell object for the specified reuse identifier and adds it to the table.
        //let item = items[indexPath.row] //p.190 //removed at p.298
        let item = checklist.items[indexPath.row] //p.298
        
        configureText(for: cell, with: item) //p.192 sets the checklist item's text on the cell's label
        configureCheckmark(for: cell, with: item)//p.193 instead of p.179's at: indexPath with with: item
        return cell
    }
    
//didSelectRowAt delegate for when rows are selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath){
            let item = checklist.items[indexPath.row] //p.190 //added checklist. in p.298
            item.toggleChecked()
            configureCheckmark(for: cell, with: item)
        }
        tableView.deselectRow(at: indexPath, animated: true)//deselect rows
        //saveChecklistItems() //p.261 saveChecklistItems method when we toggle checkmark on or off //removed in p.299
    }
    
//configureCheckmark
    func configureCheckmark(for cell: UITableViewCell, with item: ChecklistItem) {// p.192
        //p.242
        let label = cell.viewWithTag(1001) as! UILabel //p.242 check label's tag
        if item.checked {
            label.text = "✔️"
        } else {
            label.text = ""
        }
  
    }
  
//configureText
    func configureText(for cell: UITableViewCell, with item: ChecklistItem) {//p.192 sets the checklist item's text on the cell's label
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
//        label.text = "+++\(item.itemID): \(item.text)+++" //p.365 this shows that a new itemID is produced everytime a checklistItem is added on any checklist
    }
    
/* addItem gets removed after p.238 when we created a delegate protocol that lets us customize what we add
    @IBAction func addItem() { //p.199
        let newRowIndex = items.count //p.200 calculate what the index of the new row in your array should be. This is encessary in orde to properly update yourself
        
        let item = ChecklistItem() //creates a new checklist item and adds it to the end of the array
        item.text = "I am a new row -Kobe"
        item.checked = false
        items.append(item)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0) //p.200 you put the index for the new row in the local constant newRowForIndex which won't change. p.200 Also have to tell the table view about this new row so it can add a new cell for that row. Table views uses index-paths to indentify rows, so first you make an IndexPath object that points to the new row, using the row number from the newRowIndex var
        let indexPaths = [indexPath] //p.200 creates a new temporary array holding just one of the index-path item
        tableView.insertRows(at: indexPaths, with: .automatic) //p.201 inserRows tells table view about the new row. This metho dactually let you insert multiple rows at the same time
    }
 */

//commitEditingStyle
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) { //p.202 that enables swipe-to-delete
        checklist.items.remove(at: indexPath.row) //p.202 remove the item from the data model //added checklist. in p.298
        let indexPaths = [indexPath] //p.202 delete the corresponding row from the table view
        tableView.deleteRows(at: indexPaths, with: .automatic) //deleteRows function
        //saveChecklistItems() //p.261 saveChecklistItems method when we swipe to delete //removed in p.299
    }
    
//cancel func protocol from delegate protocol, ItemDetailViewControllerDelegate p.235
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController) {
        dismiss(animated: true, completion: nil)
    }
//func protocol from delegate protocol, ItemDetailViewControllerDelegate p.235
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: ChecklistItem) {
        
        let newRowIndex = checklist.items.count //p.238 end of the array //added checklist. in p.298
        checklist.items.append(item) //p.238 add it to array items //added checklist. in p.298
        
        let indexPath = IndexPath(row: newRowIndex, section: 0) //p.238
        let indexPaths = [indexPath] //p.238
        tableView.insertRows(at: indexPaths, with: .automatic) //p.238 (at: [IndexPath], with: UITableViewRowAnnimation)

        dismiss(animated: true, completion: nil) //p.235
        
        //saveChecklistItems() //p.261 saveChecklistItems method //removed in p.299
    }//let me delete the older previous addItem function
//func protocol for Editing p.250
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditing item: ChecklistItem) { //p.250
        
        if let index = checklist.items.index(of: item) {  //p.250 //added checklist. in p.298
            let indexPath = IndexPath(row: index, section: 0) //p.250
            if let cell = tableView.cellForRow(at: indexPath) { //p.250
                configureText(for: cell, with: item) //p.250
            } //p.250
        } //p.250
        dismiss(animated: true, completion: nil) //p.250
        //saveChecklistItems() //p.261 saveChecklistItems method //removed in p.299
    }
    
//prepare-for-segue p.236
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem" { //p.237 #1 There may be more than one segue per VC, so I gave this one a unique identifier and to check for that identifier first to make sure that we are handling the correct segue REMEMBER TO CHANGE THE IDENTIFIER OF THE SEGUE TO "AddItem"
            let navigationController = segue.destination as! UINavigationController //p.237 #2 new view controller can be found in segue.destination. The storyboard shoes that the segue does not go directly to ItemDetailViewController but to the navigation controller that embeds it. So first you get ahold of this UINagivationController object
            let controller = navigationController.topViewController as!  ItemDetailViewController //p.237 #3 To find the ItemDetailViewController, you can look at the navigation controller's topViewController property. This property refers to the screen that is currently active inside the navigation controller
            controller.delegate = self //p.237 #4 Once you have a reference to the ItemDetailViewController object, you set its delegate property to self and the connection is complete. This tells the ItemDetailViewController that from now on, the object known as self is its delegate, (self here is ChecklistViewController.swift)
        }
        else if segue.identifier == "EditItem" { //p.246
            let navigationController = segue.destination as! UINavigationController //p.246 same as the AddItem
            let controller = navigationController.topViewController as!  ItemDetailViewController //p.246 you get the navigation controller from the storyboard, and its embedded ItemDetailViewController using the topViewController property
            controller.delegate = self //p.246 and set the view controller's delegate property so data notified when use taps Cancel or Done
            
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) { //p.246 
                controller.itemToEdit = checklist.items[indexPath.row]//added checklist. in p.298
            }
        }
    } //end of prepare for segue
    
/* //documensDirectory(), dataFilePath(), saveChecklistItems(), and loadChecklistItems() are now moved to the object itself, not the view controller p.299
//documentsDirectory p.257
    func documentsDirectory() -> URL { //p.257 no standar method you can call to get the full path to the Documents folder
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask) //p.257
        return paths[0] //p.257
    }
//dataFilePath p.257
    func dataFilePath() -> URL { //p.257 uses documentsDirectory() to construct the full path to the file that will store the checklist items. It is named Checklists.plist which lives inside the Documents directory
        return documentsDirectory().appendingPathComponent ("Checklists.plist") //p.257
    } //p.257
    
//saveChecklistItems p.260
    func saveChecklistItems() { //p.261 this method takes the contents of the items array and in two steps converts it to a block of binary data and then writes this data to a file.
        let data = NSMutableData() //p.260 A dynamic byte buffer that bridges to Data; use NSMutableData when you need reference semantics or other Foundation-specific behavior.
        let archiver = NSKeyedArchiver(forWritingWith: data) //p.260 NSKeyedArchiver is a form of NSCoder that creates a plist files, encodes the array and all the ChecklistItems in it into some sort of binary data format that can be written to a file
        archiver.encode(checklist.items, forKey: "ChecklistItems") //p.260 Encodes the object objv and associates it with the string key. Subclasses must override this method to identify multiple encodings of objv and encode a reference to objv instead. For example, NSKeyedArchiver detects duplicate objects and encodes a reference to the original object rather than encode the same object twice. //p.263 source of error //added checklist. in p.298
        archiver.finishEncoding() //p.260 Instructs the receiver to construct the final data stream. No more values can be encoded after this method is called. You must call this method when finished.
        data.write(to: dataFilePath(), atomically: true) //p.261 The data is placed in an NSMutableData object, which will write itself to the file specified by dataFilePath() 
    }
    
    func loadChecklistItem() {
        let path = dataFilePath() //1) p.270 put the results of dataFilePath in a temporary constant named path
        if let data = try? Data(contentsOf: path) { //2) p.270 try to load the contents of Checklists.plist into a new Data object. The try? command attempts to create the Data object, but returns nil if it fails. Hence, why we used if let. It'll fail if these is no Checklists.plist then there is no ChecklistItem objects to laod, like when app is started for the very first time
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data) //3) p.270 When app does find a Checklist.plist file, you'll load the entire array and its contents from the file. Essentially the reverse of saveChecklistItems()
            checklist.items = unarchiver.decodeObject(forKey: "ChecklistItems") as! [ChecklistItem] //added checklist. in p.298
            
            unarchiver.finishDecoding() //p.270 finish decoding
        }
    }
*/

}

