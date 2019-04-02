//
//  ViewController.swift
//  Text2Speak
//
//  Created by Andrew Partridge on 4/2/19.
//  Copyright © 2019 Andrew Partridge. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    
    @IBOutlet weak var TextViewHere: UITextView!
    
    @IBOutlet weak var segmentCT: UISegmentedControl!
    
    @IBAction func SpeakButton(_ sender: UIButton) {
        var lang: String = "en-US"
        switch segmentCT.selectedSegmentIndex {
        case 0:
            lang = "en-US"
            break;
        case 1:
            lang = "fr-FR"
            break;
        case 2:
            lang = "de-DE"
            break;
        case 3:
            lang = "es-ES"
            break;
        case 4:
            lang = "it-IT"
            break;
        default:
            lang = "en-US"
        }
        
        
        
        self.readMe(myText: TextViewHere.text! , myLang: lang)
    }
        func readMe( myText:String, myLang: String){
            let utterance = AVSpeechUtterance(string: myText)
            utterance.voice = AVSpeechSynthesisVoice(language: myLang)
            utterance.rate = 0.5
            
            let synthesizer = AVSpeechSynthesizer()
            synthesizer.speak(utterance)
        }
        
        
        
        
    }

