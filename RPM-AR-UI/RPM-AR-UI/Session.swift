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
    let time : TimeInterval
    let hours: Int
    let mins: Int
    let secs: Int
    let date : Date
    let sessionNum : String
    var objsPicked: Array<Objs> = Array()
    var objsNotPicked: Array<Objs> = Array()
}
