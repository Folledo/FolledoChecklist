//
//  Checklist.swift
//  FolledoChecklist
//
//  Created by Samuel Folledo on 4/14/18.
//  Copyright © 2018 Samuel Folledo. All rights reserved.
//

import UIKit

class Checklist: NSObject {
    var name = "" //p.279
    
    init(name: String) { //p.280 lets you create a new list and immediately give it a name in one line
        self.name = name //p.280 initializer takes one parameter, name, and places it into the instance variable,which is also a name
        super.init()
    }
}
