//
//  ObjectList.swift
//  RPM-AR-UI
//
//  Created by Zachary Wooding on 4/23/19.
//  Copyright © 2019 Zachary Wooding. All rights reserved.
//

import Foundation

class ObjectList{
    
    
    private var objsList: Array<Objs>
        
    init(){
        self.objsList = [
            Objs(category:"Vehicle", name:"Ship", sceneName:"ship.scn", id:"ship", icon:"\u{1F6F3}"),
            Objs(category:"Vehicle", name:"Car", sceneName:"car.scn", id:"car", icon:"\u{1F698}"),
            Objs(category:"Composition", name:"Music", sceneName:"music.scn", id:"music", icon:"\u{1F3B6}"),
            Objs(category:"Geographic", name:"Mountain", sceneName:"mountain.scn", id:"mountain", icon:"\u{26F0}"),
            Objs(category:"Electronic", name:"Laptop", sceneName:"laptop.scn", id:"laptop", icon:"\u{1F4BB}"),
            Objs(category:"Movies", name:"Movie", sceneName:"MovieCamera.scn", id:"moviecamera", icon:"\u{1F3A5}"),
            Objs(category:"Animal", name:"Rabbit", sceneName:"rabbit.scn", id:"rabbit", icon:"\u{1F407}"),
            Objs(category:"Science", name:"Rocket", sceneName:"rocketship.scn", id:"rocket", icon:"\u{1F680}"),
            Objs(category: "Fruit", name: "Banana", sceneName: "banana.scn", id: "banana", icon: "\u{1F34C}")
    
            //
            //    Objs(category:"Appliances", name:"Fridge", sceneName:"ship.scn", id:"ship", icon:"\u{1F6F3}"),
            //    Objs(category:"Appliances", name:"Microwave", sceneName:"microwave.scn", id:"microwave", icon:"\u{1F698}"),
            //    Objs(category:"Fruit", name:"Apple", sceneName:"apple.scn", id:"apple", icon:"\u{1F3B6}"),
            //    Objs(category:"Dessert", name:"Cake", sceneName:"mountain.scn", id:"mountain", icon:"\u{26F0}"),
            //    Objs(category:"Kitchen", name:"Bowl", sceneName:"laptop.scn", id:"laptop", icon:"\u{1F4BB}"),
            //    Objs(category:"Silverwear", name:"Fork", sceneName:"MovieCamera.scn", id:"moviecamera", icon:"\u{1F3A5}"),
            //    Objs(category:"Animal", name:"...", sceneName:"rabbit.scn", id:"rabbit", icon:"\u{1F407}"),
            //    Objs(category:"Science", name:"Rocket", sceneName:"rocketship.scn", id:"rocket", icon:"\u{1F680}"),
            //    Objs(category: "Fruit", name: "Banana", sceneName: "bananaaa.scn", id: "banana", icon: "\u{1F34C}")
                ]
    }
    
    var getList: Array<Objs>{
        get{
            return objsList
        }
    }
    
    func get() -> Array<Objs>{
        return getList
    }

    
    
}

