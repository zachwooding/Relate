//
//  MainViewController.swift
//  RPM-AR-UI
//
//  Created by Zachary Wooding on 4/2/19.
//  Copyright © 2019 Zachary Wooding. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UIViewController {
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private  var allSession : Array<Session> = Array()
    
    @IBOutlet weak var datePicker : UIDatePicker!
    @IBOutlet weak var timePicker : UIDatePicker!
    @IBOutlet weak var name : UITextField!
    @IBOutlet weak var sessionNum : UITextField!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare (for seque: UIStoryboardSegue, sender: Any?){
        if seque.destination is ARViewController{
            let newSession = Session(name: name!.text!, time: timePicker.countDownDuration, date: datePicker.date, sessionNum: sessionNum.text!)
            allSession.append(newSession)
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
