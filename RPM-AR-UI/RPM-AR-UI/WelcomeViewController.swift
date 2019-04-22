//
//  WelcomeViewController.swift
//  RPM-AR-UI
//
//  Created by Zachary Wooding on 4/18/19.
//  Copyright © 2019 Zachary Wooding. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    var savedDataArray : Array<Session> = Array()
    var savedSession: Array<Session>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        load();
        
    
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backToWelcome(unwindSegue: UIStoryboardSegue){
        
        
    }
    
    
    
    override func prepare (for segue: UIStoryboardSegue, sender: Any?){
        if segue.destination is UINavigationController{
            let navTarget = segue.destination as! UINavigationController
            let nsVC = navTarget.topViewController as! NewSessionViewController
            
            nsVC.savedSessions = savedDataArray
        }
    }
    
    func load() {
        let defaults = UserDefaults.standard
    
        if let savedData = defaults.object(forKey: "savedDataArray") as? Data {
            if let decodedData = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedData) as? [Session]{
                savedDataArray = decodedData!
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
