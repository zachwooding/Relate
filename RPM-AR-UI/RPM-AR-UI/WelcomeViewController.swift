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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //createFile()
        //loadedData = loadJson(filename: "sessionDocs")
        let session = Session(name: "TestSesh", childName: "John Smith", time: 300.0, hours: 0, mins: 5, secs: 0, date: "05-02-2019", sessionNum: 1, objsPicked: Array<Objs>(), objsNotPicked: Array<Objs>())
        
        
        listedSessions.append(session)
        
        //savedDataArray.append(load()!)
        //loadSessionToTable()
    
        // Do any additional setup after loading the view.
        
        
        //May 1st
        //url = Bundle.main.url(forResource: "SavedSession", withExtension: "json")!
        let filemgr = FileManager.default
        
        url = filemgr.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).last?.appendingPathComponent("SavedSessions.json")
        
        if filemgr.fileExists(atPath: (url?.absoluteString)!) {
            do{
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
    
    
    @IBAction func backToWelcome(unwindSegue: UIStoryboardSegue){
        if savedSession != nil{
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
//        do {
//            let text2 = try String(contentsOf: url, encoding: .utf8)
//            print(text2)
//        }
//        catch {/* error handling here */}
    }
    
    func saveToJson(){
        do{
            let dataToSave = try JSONEncoder().encode(listedSessions)
            //print(dataToSave.description)
            try dataToSave.write(to: url)
        }catch{
            print(error)
        }
        
//        do {
//            let text2 = try String(contentsOf: url, encoding: .utf8)
//            print(text2)
//        }
//        catch {/* error handling here */}
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        // 1
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
    
}
