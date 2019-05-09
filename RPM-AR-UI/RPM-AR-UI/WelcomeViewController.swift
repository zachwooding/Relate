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
        
        //creating visual style
        visualStyle()
        
        //create file manager for saving, loading and creating
        let filemgr = FileManager.default
        
        //setting url of save file
        url = filemgr.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).last?.appendingPathComponent("SavedSessions.json")
        
        //checking if save file exists at the url
        if filemgr.fileExists(atPath: (url?.absoluteString)!) {
            do{
                //creating a empty session to instansiate new save file
                let session = Session(name: "Test Session", childName: "John Smith", time: 300.0, hours: 0, mins: 5, secs: 0, date: "01-01-2000", sessionNum: 1, objsPicked: Array<Objs>(), objsNotPicked: Array<Objs>())
                listedSessions.append(session)
                
                //creating json at url
                filemgr.createFile(atPath: (url?.absoluteString)!, contents: try JSONEncoder().encode(listedSessions), attributes: nil)
                //writing to file for saftey
                saveToJson()
                //loading file for safety
                loadJson()
            }catch{
                print(error)
            }
           
            
        }else{
            //file already exists so lets load it
            loadJson()
        }
        
    }

    func visualStyle(){
        //finding the nav bar
        let nav = self.navigationController?.navigationBar
        
        // setting nav colors
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.yellow
        
        // setting image size for top bar
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .scaleAspectFit
        
        // setting image for top bar
        let image = UIImage(named: "launchscreenfull2048.png")
        imageView.image = image
        
        // display image
        navigationItem.titleView = imageView
    }
    
    @IBAction func openTutorial(){
        //when tutorial btn is pressed navigate to this url. If youtube app is on device it will use the youtube app
        if let url = URL(string: "https://www.youtube.com/watch?v=NJVIc4E0uVI&feature=youtu.be"){
            UIApplication.shared.open(url)
        }
    }
    
    //setting up rows so they can be deleted
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //delete session function
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //if delete swipe
        if (editingStyle == .delete) {
            //remove desired session from array
            listedSessions.remove(at: indexPath.row)
            //write changes to JSON
            do{
                //encoding JSON
                let toReplace = try JSONEncoder().encode(listedSessions)
                //writing to file
                try toReplace.write(to: url)
                //reloading the table
                tableView.reloadData()
                
            }catch{
                print(error)
            }
            
        }
    }
    
    //creating the table
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listedSessions.count
    }
    
    //setting up cells in session list
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //setting the correct prototype cell
        //see file SessionTableViewCell.swift
        let cellId = "SessionTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? SessionTableViewCell else{
            fatalError("The dequeued cell is not an instance of SessionTableViewCell.")
        }
        
        //setting up which session to display
        let session = listedSessions[indexPath.row]
        
        //setting cell labels
        cell.nameLabel.text = session.name
        cell.dateLabel.text = session.date
        cell.childNameLabel.text = session.childName
        cell.sessionNumber.text = String(session.sessionNum)
        
        return cell
    }
    
    //seguing back to welcome from ARViewController
    // See ARViewController.swift and ARViewController in Main.storyboard
    @IBAction func backToWelcome(unwindSegue: UIStoryboardSegue){
        //checking that we got a session correctly
        if savedSession != nil{
            //setting session number based on how many are in the list already
            savedSession.sessionNum = listedSessions.count + 1
            //adding session to lists
            savedDataArray.append(savedSession)
            listedSessions.append(savedSession)
            //saving updated sessions
            saveToJson()
            //loading updated sessions
            loadJson()
            //reloading data in table
            table.reloadData()
            
        }
        
    }
    
    //when a cell is tapped on, pass session info then perform segue
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Get Cell Label
        let indexPath = table.indexPathForSelectedRow!
        //go see SessionTableViewCell
        let currentCell = table.cellForRow(at: indexPath)! as! SessionTableViewCell
        
        //saving the session
        sessionToPass = currentCell.nameLabel.text
        //sending to prepare for segue
        performSegue(withIdentifier: "viewSessionDetails", sender: self)
    }
    
    
    
    //preapring sessions to be sent
    override func prepare (for segue: UIStoryboardSegue, sender: Any?){
        //sending sessions to new session page
        if segue.destination is UINavigationController{
            //setting the correct destination
            let navTarget = segue.destination as! UINavigationController
            //getting the view controller
            let nsVC = navTarget.topViewController as! NewSessionViewController
            
            nsVC.savedSessions = savedDataArray
        }
        
        //sending session (data)to session details page, // making sure the seque goes to the right page
        if segue.identifier == "viewSessionDetails" && sessionToPass != nil{ //identifing what seque we need to use
            //gettimg destination controller
            let navTarget = segue.destination as! SessionDetailsViewController
            //picking the correct session to send
            for sesh in listedSessions{
                if sessionToPass == sesh.name{ //session to move
                    //setting the session in view controller
                    navTarget.sessionInfo = sesh
                }
            }
            
        }
    }
    
    func loadJson(){
        //loading JSON file
        do {
            //getting contents of the JSON
            json = try Data.init(contentsOf: url) as Data
            //decoding the JSON
            let jsonData = try JSONDecoder().decode(Array<Session>.self, from: json)
            //setting the array so we can list the sessions
            listedSessions = jsonData
        }
        catch {
            print(error)
        }
    }
    
    func saveToJson(){
        do{
            //encoding the array
            let dataToSave = try JSONEncoder().encode(listedSessions)
            //writing to JSON file
            try dataToSave.write(to: url)
        }catch{
            print(error)
        }
        
    }
    
    
}
