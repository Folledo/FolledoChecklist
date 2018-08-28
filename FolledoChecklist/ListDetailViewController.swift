//
//  ListDetailViewController.swift
//  FolledoChecklist
//
//  Created by Samuel Folledo on 4/14/18.
//  Copyright © 2018 Samuel Folledo. All rights reserved.
//

import Foundation
import UIKit

protocol ListDetailViewControllerDelegate: class {
    func listDetailViewControllerDidCancel (_ controller: ListDetailViewController)
    func listDetailViewController (_ controller: ListDetailViewController, didFinishAdding checklist: Checklist)
    func listDetailViewController (_ controller: ListDetailViewController, didFinishEditing checklist: Checklist)
}

class ListDetailViewController: UITableViewController, UITextFieldDelegate, IconPickerCiewControllerDelegate { //p.343 added IconPickerCiewControllerDelegate to assign delegate to self to conform to the delegate protocol
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var iconImageView: UIImageView! //p.340
    
    
    weak var delegate: ListDetailViewControllerDelegate?
    var checklistToEdit: Checklist?
    
    var iconName = "Folder" //p.342 u use this var to keep track of the chose icon name
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let checklist = checklistToEdit {
            title = "Edit Checklist"
            textField.text = checklist.name
            doneBarButton.isEnabled = true
            iconName = checklist.iconName //p.342
            iconImageView.image = UIImage(named: iconName) //p.342 if the checklistToEdit optional is not nil,  then u copy the Checklist object's icon name into the iconName instance variable. Then load the icon;s image file into a new UIImage and set it to iconImageView so it shows up in the Icon row
        }
    }
    
    override func viewWillAppear (_ animated: Bool){
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    @IBAction func cancel() {
        delegate?.listDetailViewControllerDidCancel(self)
    }
    
    @IBAction func done() {
        if let checklist = checklistToEdit {
            checklist.name = textField.text!
            checklist.iconName = iconName //p.344
            delegate?.listDetailViewController(self, didFinishEditing: checklist)
        } else {
            let checklist = Checklist(name: textField.text!)
            checklist.iconName = iconName //p.344
            delegate?.listDetailViewController(self, didFinishAdding: checklist)
        }
    }
    
//p.289 to make sure user cannot select table cell with the text field
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        if indexPath.section == 1 { //p.341 section 1 is the section that contains the iconImage cell. This is necessary otherwise you cannot tap the "Icon" cell to trigger the segue
            return indexPath //p.341
        } else { //p.341
            return nil //p.289
        } //p.341
    }
//p.289 text field delegate method that enables or disables the Done button depending on whether the text field is empty or not
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let oldText = textField.text! as NSString
        let newText = oldText.replacingCharacters(in: range, with: string) as NSString
        
        doneBarButton.isEnabled = (newText.length > 0)
        return true
    }
    
//prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { //p.342
        if segue.identifier == "PickIconSegue" { //p.342
            let controller = segue.destination as! IconPickerViewController //p.342
            controller.delegate = self //p.342
        }
    }
    
    func iconPicker(_ picker: IconPickerViewController, didPick iconName: String) { //p.343 this puts the name of the chosen icon into the iconName var and updates the image view with the new image
        self.iconName = iconName //p.343 //p.344 iconName can refer to two different things here: 1) the parameter from the delegate method, and 2) the instance var. To remove the ambiguity, you prefix the instance var with self. os it's clear with the compiler which iconName you intended to use
        iconImageView.image = UIImage(named: iconName) //p.343
        let _ = navigationController?.popViewController(animated: true) //p.343 you dont call dismiss() here but popViewController(animated) because the Icon Picker is on the navigation stack. When creating the segue you used the segue style "show" instead of present modally, which pushes the new view controller on the navigation stack. To return you need to pop it off again (dismiss() is for modal screens only, not for push) p.344
    }
}
