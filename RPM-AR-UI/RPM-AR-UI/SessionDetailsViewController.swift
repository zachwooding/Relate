//
//  SessionDetailsViewController.swift
//  RPM-AR-UI
//
//  Created by Zachary Wooding on 4/29/19.
//  Copyright © 2019 Zachary Wooding. All rights reserved.
//

import UIKit

class SessionDetailsViewController: UIViewController {

    @IBOutlet weak var sessionNameLabel: UILabel!
    @IBOutlet weak var childNameLabel: UILabel!
    @IBOutlet weak var sessionNumLabel: UILabel!
    
    @IBOutlet weak var objectsNotPickedTable: UITableView!
    @IBOutlet weak var objectsPickedTable: UITableView!
    var tablePick: UITableViewController!
    var sessionInfo:Session!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tablePick.tableView(objectsPickedTable, Sections)
        // Do any additional setup after loading the view.
//        objectsPickedTable
//        for obj in sessionInfo.objsPicked{
//            objectsPickedTable.
//        }
//
        sessionNameLabel.text = sessionInfo.name
        childNameLabel.text = sessionInfo.childName
        sessionNumLabel.text = String(sessionInfo.sessionNum)
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



