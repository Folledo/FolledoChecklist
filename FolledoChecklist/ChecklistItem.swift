//
//  ChecklistItem.swift
//  FolledoChecklist
//
//  Created by Samuel Folledo on 3/11/18.
//  Copyright © 2018 Samuel Folledo. All rights reserved.
//

import Foundation

class ChecklistItem { //p.183
    var text = ""
    var checked = false
    
    func toggleChecked() { //p.193
        checked = !checked
    }
}
