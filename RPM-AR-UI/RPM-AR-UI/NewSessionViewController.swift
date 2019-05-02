//
//  MainViewController.swift
//  RPM-AR-UI
//
//  Created by Zachary Wooding on 4/2/19.
//  Copyright © 2019 Zachary Wooding. All rights reserved.
//

import UIKit
import CoreData

class NewSessionViewController: UIViewController {
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var savedSessions : Array<Session>!
    
    @IBOutlet weak var datePicker : UIDatePicker!
    @IBOutlet weak var timePicker : UIDatePicker!
    @IBOutlet weak var name : UITextField!
    @IBOutlet weak var childName: UITextField!
    
    
    //var newSession: Session = Session(name: "New Session", time: 1000.0, date: Date(), sessionNum: "1")


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func timeCon (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }

    
    override func prepare (for segue: UIStoryboardSegue, sender: Any?){
        if segue.destination is UINavigationController{
            let navTarget = segue.destination as! UINavigationController
            let (h,m,s) = timeCon(seconds: Int(timePicker.countDownDuration))
            let format = DateFormatter()
            format.dateFormat = "MM-dd-yyyy"
            let sDate = format.string(from: datePicker.date)
            let newSession = Session(name: name!.text!, childName: childName.text!, time: timePicker.countDownDuration, hours: h, mins: m, secs: s ,date: sDate, sessionNum: savedSessions.count+1, objsPicked: Array<Objs>(), objsNotPicked: Array<Objs>())
            let arVC = navTarget.topViewController as! ARViewController
            
            arVC.sessionInfo = newSession
            arVC.savedSessions = savedSessions
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
