//
//  Session+CoreDataProperties.swift
//  RPM-AR-UI
//
//  Created by Anthony Mione on 4/16/19.
//  Copyright © 2019 Zachary Wooding. All rights reserved.
//
//

import Foundation
import CoreData


extension Session {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Session> {
        return NSFetchRequest<Session>(entityName: "Session")
    }

    @NSManaged public var name: String?

}
