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
            //Objs(category:"Vehicle", name:"Ship", sceneName:"ship.scn", id:"ship", icon:"\u{1F6F3}"),
            //Objs(category:"Vehicle", name:"Car", sceneName:"car.scn", id:"car", icon:"\u{1F698}"),
            //Objs(category:"Composition", name:"Music", sceneName:"music.scn", id:"music", icon:"\u{1F3B6}"),
            //Objs(category:"Geographic", name:"Mountain", sceneName:"mountain.scn", id:"mountain", icon:"\u{26F0}"),
            //Objs(category:"Electronic", name:"Laptop", sceneName:"laptop.scn", id:"laptop", icon:"\u{1F4BB}"),
            //Objs(category:"Movies", name:"Movie", sceneName:"MovieCamera.scn", id:"moviecamera", icon:"\u{1F3A5}"),
            //Objs(category:"Animal", name:"Rabbit", sceneName:"rabbit.scn", id:"rabbit", icon:"\u{1F407}"),
            //Objs(category:"Science", name:"Rocket", sceneName:"rocketship.scn", id:"rocket", icon:"\u{1F680}"),
            //Objs(category: "Fruit", name: "Banana", sceneName: "banana.scn", id: "banana", icon: "\u{1F34C}")
    
            //
            //Objs(category:"Appliances", name:"Fridge", sceneName:".scn", id:"ship", icon:"\u{23F2}"),
            //upside down
            Objs(category:"Appliances", name:"Microwave", sceneName:"microwave.scn", id:"microwave", icon:"\u{2668}"),
            //too big
            Objs(category:"Fruit", name:"Apple", sceneName:"apple.scn", id:"apple", icon:"\u{1F34E}"),
            
            //Objs(category:"Dessert", name:"Cake", sceneName:"mountain.scn", id:"mountain", icon:"\u{1F370}"),
            //rotate
            Objs(category:"Kitchen", name:"Oven", sceneName:"oven.scn", id:"oven", icon:"\u{1F4BB}"),
            //Objs(category:"Silverwear", name:"Fork", sceneName:"MovieCamera.scn", id:"moviecamera", icon:"\u{1F3A5}"),
            //too big
            Objs(category:"Silverwear", name:"Knife", sceneName:"knife.scn", id:"knife", icon:"\u{1F52A}"),
            //too big
            Objs(category:"Cookware", name:"Pan", sceneName:"pan.scn", id:"pan", icon:"\u{1F373}"),
            //good
            Objs(category: "Fruit", name: "Banana", sceneName: "banana.scn", id: "banana", icon: "\u{1F34C}"),
            //Too big
            Objs(category: "Jar", name: "Nutella", sceneName: "nutella.scn", id: "nutella", icon: "\u{1F330}")
            
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

