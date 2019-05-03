//
//  Objs.swift
//  RPM-AR-UI
//
//  Created by Zachary Wooding on 4/4/19.
//  Copyright © 2019 Zachary Wooding. All rights reserved.
//

import Foundation


struct Objs:Codable {
    let category : String
    let name : String
    let sceneName: String
    let id: String
    let icon: String
    
    enum CodingKeys: String, CodingKey {
        case category
        case name
        case sceneName
        case id
        case icon
    }
    init(category: String, name : String, sceneName: String, id: String, icon: String) {
        self.name = name
        self.category = category
        self.sceneName = sceneName
        self.id = id
        self.icon = icon
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(category, forKey: .category)
        try container.encode(name, forKey: .name)
        try container.encode(sceneName, forKey: .sceneName)
        try container.encode(id, forKey: .id)
        try container.encode(icon, forKey: .icon)
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        category = try container.decode(String.self, forKey: .category)
        name = try container.decode(String.self, forKey: .name)
        sceneName = try container.decode(String.self, forKey: .sceneName)
        id = try container.decode(String.self, forKey: .id)
        icon = try container.decode(String.self, forKey: .icon)
    }
}
