//
//  LoadSave.swift
//  RPM-AR-UI
//
//  Created by Anthony Mione on 4/18/19.
//  Copyright © 2019 Zachary Wooding. All rights reserved.
//

import Foundation

func save() {
    if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: sID, requiringSecureCoding: flase){
        let defaults = UserDefaults.standard
        defaults.set(savedData, forKey: "sID")
    }
}


func load() {
    let defaults = UserDefaults.standard
    
    if let savedPeople = defaults.object(forKey: "sID") as? Data {
        if let decodedPeople = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedPeople) as? [Session]{
            sID = decodedPeople
        }
    }
}
