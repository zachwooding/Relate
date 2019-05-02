//
//  SessionList.swift
//  RPM-AR-UI
//
//  Created by Zachary Wooding on 5/2/19.
//  Copyright © 2019 Zachary Wooding. All rights reserved.
//

import Foundation

import Foundation

struct SessionList: Codable{
    let sesh : Array<Session>
    
    
    enum CodingKeys: String, CodingKey {
        case sesh
        
    }
    init(sesh: Array<Session>) {
        self.sesh = sesh
        
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(sesh, forKey: .sesh)
        
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        sesh = try container.decode(Array<Session>.self, forKey: .sesh)
        
    }
}
