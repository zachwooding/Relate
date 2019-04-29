//
//  Session.swift
//  RPM-AR-UI
//
//  Created by Anthony Mione on 4/16/19.
//  Copyright © 2019 Zachary Wooding. All rights reserved.
//

import Foundation

struct Session{
    let name : String
    let childName: String
    let time : TimeInterval
    var hours: Int
    var mins: Int
    var secs: Int
    let date : Date
    var sessionNum : Int
    var objsPicked: Array<Objs> = Array()
    var objsNotPicked: Array<Objs> = Array()
}
