//
//  TutorialViewController.swift
//  RPM-AR-UI
//
//  Created by Andrew Partridge on 5/2/19.
//  Copyright © 2019 Zachary Wooding. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class TutorialViewController: AVPlayerViewController {

    var url: URL!
    var file = FileManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: "https://www.youtube.com/watch?v=NJVIc4E0uVI&feature=youtu.be"){
            UIApplication.shared.open(url)
        }
    
        
        
        //let filemgr = FileManager.default
        //url = filemgr.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).last?.appendingPathComponent("tut.mp4")
       // let player = AVPlayer(url: url!)
       // let playerViewController = AVPlayerViewController()
       // playerViewController.player = player
       // self.present(playerViewController, animated: true) {
           // playerViewController.player!.play()
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


