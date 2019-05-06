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
    var loadedData :[Session]!
    var pathToSave: String!
    var loadedSesh: Session!
    var url: URL!
    var file = FileManager()
    
    var sessionToPass: String!
    var json: Data!
    
    //@IBOutlet var nameLabel: UILabel!
    //@IBOutlet var dateLabel: UILabel!
    @IBOutlet var table: UITableView!
    @IBOutlet weak var tutBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        visualStyle()
        
        let filemgr = FileManager.default
        
        url = filemgr.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).last?.appendingPathComponent("SavedSessions.json")
        
        if filemgr.fileExists(atPath: (url?.absoluteString)!) {
            do{
                let session = Session(name: "Test Session", childName: "John Smith", time: 300.0, hours: 0, mins: 5, secs: 0, date: "01-01-2000", sessionNum: 1, objsPicked: Array<Objs>(), objsNotPicked: Array<Objs>())
                listedSessions.append(session)
                filemgr.createFile(atPath: (url?.absoluteString)!, contents: try JSONEncoder().encode(listedSessions), attributes: nil)
                saveToJson()
                loadJson()
            }catch{
                print(error)
            }
           
            
        }else{
            loadJson()
        }
        
    }

    func visualStyle(){
        let nav = self.navigationController?.navigationBar
        
        // 2
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.yellow
        
        // 3
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .scaleAspectFit
        
        // 4
        let image = UIImage(named: "launchScreenFull2048.png")
        imageView.image = image
        
        // 5
        navigationItem.titleView = imageView
    }
    
    @IBAction func openTutorial(){
        if let url = URL(string: "https://www.youtube.com/watch?v=NJVIc4E0uVI&feature=youtu.be"){
            UIApplication.shared.open(url)
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            listedSessions.remove(at: indexPath.row)
            do{
                let toReplace = try JSONEncoder().encode(listedSessions)
                try toReplace.write(to: url)
                tableView.reloadData()
                
            }catch{
                print(error)
            }
            
        }
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
        cell.dateLabel.text = session.date
        cell.childNameLabel.text = session.childName
        cell.sessionNumber.text = String(session.sessionNum)
        
        return cell
    }
    
    
    @IBAction func backToWelcome(unwindSegue: UIStoryboardSegue){
        if savedSession != nil{
            savedSession.sessionNum = listedSessions.count + 1
            savedDataArray.append(savedSession)
            listedSessions.append(savedSession)
            saveToJson()
            loadJson()
            table.reloadData()
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Get Cell Label
        let indexPath = table.indexPathForSelectedRow!
        let currentCell = table.cellForRow(at: indexPath)! as! SessionTableViewCell
        
        sessionToPass = currentCell.nameLabel.text
        performSegue(withIdentifier: "viewSessionDetails", sender: self)
    }
    
    
    
    
    override func prepare (for segue: UIStoryboardSegue, sender: Any?){
        if segue.destination is UINavigationController{
            let navTarget = segue.destination as! UINavigationController
            let nsVC = navTarget.topViewController as! NewSessionViewController
            
            nsVC.savedSessions = savedDataArray
        }
        
        if segue.identifier == "viewSessionDetails" && sessionToPass != nil{
            let navTarget = segue.destination as! SessionDetailsViewController
            for sesh in listedSessions{
                if sessionToPass == sesh.name{
                    navTarget.sessionInfo = sesh
                }
            }
            
        }
    }
    
    func loadJson(){
        
        do {
            json = try Data.init(contentsOf: url) as Data
            let jsonData = try JSONDecoder().decode(Array<Session>.self, from: json)
            //print(jsonData)
            listedSessions = jsonData
        }
        catch {
            print(error)
        }
    }
    
    func saveToJson(){
        do{
            let dataToSave = try JSONEncoder().encode(listedSessions)
            //print(dataToSave.description)
            try dataToSave.write(to: url)
        }catch{
            print(error)
        }
        
    }
    
    
}
