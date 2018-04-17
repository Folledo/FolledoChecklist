//
//  AllListsViewController.swift
//  FolledoChecklist
//
//  Created by Samuel Folledo on 4/14/18.
//  Copyright © 2018 Samuel Folledo. All rights reserved.
//

import UIKit

class AllListsViewController: UITableViewController, ListDetailViewControllerDelegate { //p.292 Added ListDetailVCDelegate
    var dataModel: DataModel!
    //var lists = [Checklist]() //p.279 holds Checklist objects //p.311 removed the lists and put in DataModel.swift
    
/*//init? (coder) //removed in p.311
    required init?(coder aDecoder: NSCoder) {
        lists = [Checklist]() //p.303
        super.init(coder: aDecoder) //p.303
        //loadChecklist() //p.303
/* //entire init?(coder) is modified in p. 303
        lists = [Checklist]() //1 p.280 Give the lists variable a value. Can also be written as lists = Array<Checklist>()
        super.init(coder: aDecoder) //2 p.280 Call super's version of init?(coder). Without this, the new view controller wont be properly loaded from the storyboard. But dont worry too much about forgetting to call super; if you dont, Xcode gives an error message
        
        /*
        //3 p.280 Create a new Checklist object, give it a name, and add it to the array
        var list = Checklist()
        list.name = "Birthdays"
        lists.append(list)
        */
        
        var list = Checklist(name: "Birthdays") //p.281 with the init(name:) in Checklist.swift you can immediately create a Checklist object and giving it a name
        lists.append(list)
        
        list = Checklist(name: "Groceries") //this way it also guarantees that every list will also have a name
        lists.append(list)
        
        list = Checklist(name: "Cool Apps")
        lists.append(list)
        
        list = Checklist(name: "To Do")
        lists.append(list)
        
        for list in lists { //p.300 for every Checklist object in the list array, perform the statements that are in between the curly braces
            let item = ChecklistItem()
            item.text = "Item for \(list.name)"
        }
*/
    }
*/
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { //p.274
        
        return dataModel.lists.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { //p.275
        //let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let cell = makeCell(for: tableView) //p.275
        
        //cell.textLabel!.text = "list \(indexPath.row)" //p.275
        let checklist = dataModel.lists[indexPath.row] //p.282
        cell.textLabel!.text = checklist.name //p.282
        cell.accessoryType = .detailDisclosureButton //p.282
        
        return cell
    }
//makeCell method p.275
    func makeCell(for tableView: UITableView) -> UITableViewCell {
        let cellIdentifier = "Cell"
        if let cell = tableView.dequeueReusableCell (withIdentifier: cellIdentifier) { //the call dequeueReusableCell(withIdentifier) is still there, except that previously the storyboard had a prototype cell with that identifier and now it doesnt. If the table view cannot find a cell to re-use (it wont until it has enough cells to fill the entire visible area), this method will return nil, and you have to create your own by hand,thus what happens in the else section. p.283
            return cell
        } else {
            return UITableViewCell(style: .default, reuseIdentifier: cellIdentifier) //
        }
    }
    
//didSelectRowAt p.277
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let checklist = dataModel.lists[indexPath.row] //p.284 this will be used to send along the Checklist object from the row that the user tapped on
        performSegue(withIdentifier: "ShowChecklist", sender: checklist) //p.277 sender: nil until p.284
    }
    
//prepare(for:, sender:) p.285
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { //p.285 called right before segue hapens, which lets you set properties of the new view controller before it becomes visible
        if segue.identifier == "ShowChecklist" { //p.285
            let controller = segue.destination as! ChecklistViewController //p.285 //p.287 the segue's destination is the receiving end of the segue, since Apple cant predict that we would call it ChecklistViewController, you have to cast it from its generic type (UIViewController) to the specific type used in this app (ChecklistViewController) before you can access its properties
            controller.checklist = sender as! Checklist //p.285 //p.287 type cast which changes the character of an object or tells Swift to interpret a value as having a different data type
        } else if segue.identifier == "AddChecklist" { //p.292
            let navigationController = segue.destination as! UINavigationController //p.292
            let controller = navigationController.topViewController as! ListDetailViewController //p.292
            controller.delegate = self //p.292
            controller.checklistToEdit = nil //p.292
        }
    }
    
//delegate methods p.293
    func listDetailViewControllerDidCancel(_ controller: ListDetailViewController) {
        dismiss(animated: true, completion: nil)
    }
    func listDetailViewController(_ controller: ListDetailViewController, didFinishAdding checklist: Checklist) {
        let newRowIndex = dataModel.lists.count
        dataModel.lists.append(checklist)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        
        dismiss(animated: true, completion: nil)
    }
    func listDetailViewController(_ controller: ListDetailViewController, didFinishEditing checklist: Checklist) {
        if let index = dataModel.lists.index(of: checklist) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.textLabel!.text = checklist.name
            }
        }
        dismiss(animated: true, completion: nil)
    }
//end of delegate method p.293
    
//p.293 swipe-to-delete method
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        dataModel.lists.remove(at: indexPath.row)
        
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
//p.294 for Edit Checklist screen without using a segue when i is tapped
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) { //p.294 create the view controller which is roughly equivalent to what a segue do behind the scenes. The view controller is embedded in a storyboard and you have to ask the storyboard object to load it. Each view controller  has a storyboard property that refers to the storyboard the view controller was loaded from. The storyboard property is optional because view controllers are not always loaded from a storyboard, but this one is, thats why upi ccan use ! to force unwrap. It's like using if-let, but since you can safely assume storyboard will not be nil, you dont have to unwrap it inside if-let
        let navigationController = storyboard!.instantiateViewController(withIdentifier: "ListDetailNavigationController") as! UINavigationController //p.294 instantiateViewController(withIdentifier) takes an identifier string. This method is how you ask the storyboard to create the new view controller. In this case, the navigation controller that contains the ListDetailNavigationController. Instantiate (represent) it to navigation controller or it wont have the title bar or Cancel and Done button. DONT FORGET TO SET THE NAVIGATION CONTROLLER'S IDENTIFIER, otherwise the storyboard cannot find it
        let controller = navigationController.topViewController as! ListDetailViewController //p.294
        controller.delegate = self //p.294
        
        let checklist = dataModel.lists[indexPath.row] //p.294
        controller.checklistToEdit = checklist //p.294
        present(navigationController, animated: true, completion: nil) //p.294
    }
    
/* //These 4 methods are now put into DataModel.swift
// p.302 documentsDirectory(), dataFilePath(), saveChecklistItems(), loadChecklistItems() were moved from ChecklistViewController.swift from previous pages. Explanation for each lines are there
//documentsDirectory //p.302
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
//dataFilePath //p.302
    func dataFilePath() -> URL { //p.302
        return documentsDirectory().appendingPathComponent ("Checklists.plist")
    }
    
//saveChecklistItems p.260 //p.302
    func saveChecklist() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        
        //archiver.encode(items, forKey: "ChecklistItems") //changed in p.302
        archiver.encode(lists, forKey: "ChecklistItems") //p.302
        archiver.finishEncoding()
        data.write(to: dataFilePath(), atomically: true)
    }
//loadChecklistItem //p.302
    func loadChecklist() {
        let path = dataFilePath()
        if let data = try? Data(contentsOf: path) {
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
            
            //items = unarchiver.decodeObject(forKey: "ChecklistItems") as! [ChecklistItem] //modified in p.302
            lists = unarchiver.decodeObject(forKey: "ChecklistItems") as! [Checklist] //p.302 modified and changed the as! [ChecklistItem] to as! [Checklist]
            unarchiver.finishDecoding()
        }
    }
*/
    
}
