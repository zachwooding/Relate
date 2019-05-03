//
//  Session.swift
//  RPM-AR-UI
//
//  Created by Anthony Mione on 4/16/19.
//  Copyright © 2019 Zachary Wooding. All rights reserved.
//

import Foundation

struct Session: Codable{
    let name : String
    let childName: String
    let time : TimeInterval
    var hours: Int
    var mins: Int
    var secs: Int
    let date : String
    var sessionNum : Int
    var objsPicked: Array<Objs>
    var objsNotPicked: Array<Objs>
    
    enum CodingKeys: String, CodingKey {
        case session
        case name
        case childName
        case time
        case hours
        case mins
        case secs
        case date
        case sessionNum
        case objsPicked
        case objsNotPicked
    }
    init(name : String, childName: String, time : TimeInterval, hours: Int, mins: Int, secs: Int, date : String, sessionNum : Int, objsPicked: Array<Objs>, objsNotPicked: Array<Objs>) {
        self.name = name
        self.childName = childName
        self.time = time
        self.hours = hours
        self.mins = mins
        self.secs = secs
        self.date = date
        self.sessionNum = sessionNum
        self.objsPicked = objsPicked
        self.objsNotPicked = objsNotPicked
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(childName, forKey: .childName)
        try container.encode(time, forKey: .time)
        try container.encode(hours, forKey: .hours)
        try container.encode(mins, forKey: .mins)
        try container.encode(secs, forKey: .secs)
        try container.encode(date, forKey: .date)
        try container.encode(sessionNum, forKey: .sessionNum)
        try container.encode(objsPicked, forKey: .objsPicked)
        try container.encode(objsNotPicked, forKey: .objsNotPicked)
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        childName = try container.decode(String.self, forKey: .childName)
        time = try container.decode(Double.self, forKey: .time)
        hours = try container.decode(Int.self, forKey: .hours)
        mins = try container.decode(Int.self, forKey: .mins)
        secs = try container.decode(Int.self, forKey: .secs)
        date = try container.decode(String.self, forKey: .date)
//        let format = DateFormatter()
//        format.dateFormat = "MM-dd-yyyy"
//        date = format.date(from: dString)!
        sessionNum = try container.decode(Int.self, forKey: .sessionNum)
        objsPicked = try container.decode(Array<Objs>.self, forKey: .objsPicked)
        objsNotPicked = try container.decode(Array<Objs>.self, forKey: .objsNotPicked)
    }
}
