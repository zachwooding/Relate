//
//  WelcomeViewController.swift
//  RPM-AR-UI
//
//  Created by Zachary Wooding on 4/18/19.
//  Copyright © 2019 Zachary Wooding. All rights reserved.
//

import UIKit

class WelcomeViewController: UITableViewController {

    var savedDataArray : Array<Session> = Array()
    var savedSession: Session!
    var listedSessions = [Session]()
    
    //@IBOutlet var nameLabel: UILabel!
    //@IBOutlet var dateLabel: UILabel!
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let session = Session(name: "TheSesh", time: TimeInterval.pi, hours: 1, mins: 2, secs: 3, date: Date.distantPast, sessionNum: "1", objsPicked: Array<Objs>(), objsNotPicked: Array<Objs>())
        listedSessions.append(session)
        
        load()
        loadSessionToTable()
    
        // Do any additional setup after loading the view.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listedSessions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId = "SessionTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? SessionTableViewCell else{
            fatalError("The dequeued cell is not an instance of SessionTableViewCell.")
        }
        let session = listedSessions[indexPath.row]
        //let session = Session(name: "TheSesh", time: TimeInterval.pi, hours: 1, mins: 2, secs: 3, date: Date.distantPast, sessionNum: "1", objsPicked: Array<Objs>(), objsNotPicked: Array<Objs>())
        cell.nameLabel.text = session.name
        
        return cell
    }
    
    private func loadSessionToTable(){
        for session in savedDataArray{
            listedSessions += [session]
        }
    }
    
    @IBAction func backToWelcome(unwindSegue: UIStoryboardSegue){
        if savedSession != nil{
            savedDataArray.append(savedSession)
            listedSessions.append(savedSession)
            save()
            load()
            
        }
        
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
    
    func save() {
        
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: savedDataArray, requiringSecureCoding: false){
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "sID")
        }
    }

}
