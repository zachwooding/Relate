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
        //let session = Session(name: "TheSesh", childName: "Bob", time: TimeInterval.pi, hours: 1, mins: 2, secs: 3, date: Date(), sessionNum: 1, objsPicked: Array<Objs>(), objsNotPicked: Array<Objs>())
        //savedSession = session
        
        //listedSessions.append(session)
        
        //savedDataArray.append(load()!)
        //loadSessionToTable()
    
        // Do any additional setup after loading the view.
        
        
        //May 1st
        //url = Bundle.main.url(forResource: "SavedSession", withExtension: "json")!
        
        let filemgr = FileManager.default
        
        url = filemgr.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).last?.appendingPathComponent("SavedSessions.json")
        
        if !filemgr.fileExists(atPath: (url?.absoluteString)!) {
            filemgr.createFile(atPath: (url?.absoluteString)!, contents: nil, attributes: nil)
            
        }else{
            do{
                json = try Data.init(contentsOf: url) as Data
                loadJson()
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
        
        return cell
    }
    
    private func loadSessionToTable(){
        for session in loadedData{
            listedSessions += [session]
        }
    }
    
    @IBAction func backToWelcome(unwindSegue: UIStoryboardSegue){
        if savedSession != nil{
            savedDataArray.append(savedSession)
            listedSessions.append(savedSession)
            saveToJson()
            loadJson()
            
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
            let jsonData = try JSONDecoder().decode(Session.self, from: json)
            listedSessions.append(jsonData)
            
        }
        catch {
            print(error)
        }
    }
    
    func saveToJson(){
        do{
            let dataToSave = try JSONEncoder().encode(savedSession)
            try dataToSave.write(to: url)
        }catch{
            print(error)
        }
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
        let image = UIImage(named: "launchScreenFull Load.png")
        imageView.image = image
        
        // 5
        navigationItem.titleView = imageView
    }
    
}
    //    func load() {
//        let defaults = UserDefaults.standard
//
//        if let savedData = defaults.object(forKey: "savedDataArray") as? Data {
//            if let decodedData = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedData) as? [Session]{
//                savedDataArray = decodedData!
//            }
//        }
//
//    }
//
//    func save() {
//
////        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: savedDataArray, requiringSecureCoding: false){
////            let defaults = UserDefaults.standard
////            defaults.set(savedData, forKey: "sID")
////        }
//
//
//    }
    
//    func save() {
////        do{
////            json = try JSONEncoder().encode(savedSession)
////        }catch{
////
////        }
//
//        let file = "SavedSessions.json"
//
//        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
//
//            let fileURL = dir.appendingPathComponent(file)
//
//            do {
//                let jsonData = try JSONEncoder().encode(savedDataArray)
//                try jsonData.write(to: fileURL)
//            }
//            catch {/* error handling here */}
//        }
//
//    }
//
//    func load() -> Session? {
//        let loadedData = try? JSONDecoder().decode(Session.self, from: json)
//        return loadedData
//    }
//
//    func createFile() -> String{
//        //let data = savedSession.data(using: Session.Encoding.utf8)
//        let filemgr = FileManager.default
//        let path = filemgr.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).last?.appendingPathComponent("SavedSessions")
//        //pathToSave = path?.absoluteString
//        if !filemgr.fileExists(atPath: (path?.absoluteString)!) {
//            filemgr.createFile(atPath: (path?.absoluteString)!, contents: nil, attributes: nil)
//
//        }
//        return (path?.absoluteString)!
//    }
//
//    func loadJson(filename fileName: String) -> [Session]? {
//        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
//            do {
//                let data = try Data(contentsOf: url)
//                let decoder = JSONDecoder()
//                let jsonData = try decoder.decode(Info.self, from: data)
//                return jsonData.session
//            } catch {
//                print("error:\(error)")
//            }
//        }
//        return nil
//    }
//

