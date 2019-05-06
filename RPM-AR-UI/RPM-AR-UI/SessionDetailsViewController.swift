//
//  SessionDetailsViewController.swift
//  RPM-AR-UI
//
//  Created by Zachary Wooding on 4/29/19.
//  Copyright © 2019 Zachary Wooding. All rights reserved.
//

import UIKit

class SessionDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    @IBOutlet weak var sessionNameLabel: UILabel!
    @IBOutlet weak var childNameLabel: UILabel!
    @IBOutlet weak var sessionNumLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var objectsNotPickedTable: UITableView!
    @IBOutlet weak var objectsPickedTable: UITableView!
    var sessionInfo:Session!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeLabel.text = String(sessionInfo.hours) + ":" + String(sessionInfo.mins) + ":" + String(sessionInfo.secs)
        dateLabel.text = sessionInfo.date
        sessionNameLabel.text = sessionInfo.name
        childNameLabel.text = sessionInfo.childName
        sessionNumLabel.text = String(sessionInfo.sessionNum)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessionInfo.objsPicked.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ObjectsPickedCell", for: indexPath) as? ObjsTableViewCell else{
            fatalError("The dequeued cell is not an instance of ObjsTableViewCell.")
        }
        
        if tableView == objectsPickedTable{
            cell.objsNameLabel.text = sessionInfo.objsPicked[indexPath.row].name
            cell.pictureLabel.text = sessionInfo.objsPicked[indexPath.row].icon
        }else if tableView == objectsNotPickedTable{
            cell.objsNameLabel.text = sessionInfo.objsNotPicked[indexPath.row].name
            cell.pictureLabel.text = sessionInfo.objsNotPicked[indexPath.row].icon
        }
        
        
        return cell
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



