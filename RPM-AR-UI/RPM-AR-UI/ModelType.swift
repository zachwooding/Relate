//
//  ModelType.swift
//  RPM-AR-Therapy
//
//  Created by Zachary Wooding on 4/1/19.
//  Copyright © 2019 Zachary Wooding. All rights reserved.
//

import Foundation

public enum ModelType:Int {
    
    case Box = 0
    case Sphere
    case Pyramid
    case Torus
    case Capsule
    case Cylinder
    case Cone
    case Tube
    
    // 2
    static func random() -> ModelType {
        let maxValue = Tube.rawValue
        let rand = arc4random_uniform(UInt32(maxValue+1))
        return ModelType(rawValue: Int(rand))!
    }
}
