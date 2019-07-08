//
//  Splash Screen View ControllerViewController.swift
//  Grade Calculator
//
//  Created by Bijoy on 7/7/19.
//  Copyright © 2019 Bijoy Shah. All rights reserved.
//

import UIKit
import AVFoundation

class Splash_Screen_View_ControllerViewController: UIViewController {
    @IBOutlet weak var throneImageView: UIImageView!
    var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let yAtLoad = throneImageView.frame.origin.y
        throneImageView.frame.origin.y = view.frame.height
        playSound(soundName: "sound", audioPlayer: &audioPlayer)
        UIView.animate(withDuration: 1.0, delay: 1.0, animations:{self.throneImageView.frame.origin.y = yAtLoad})
    }
    
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        audioPlayer.stop()
        performSegue(withIdentifier: "ShowMain", sender: nil)
    }
    
    func playSound(soundName: String, audioPlayer: inout AVAudioPlayer){
        if let sound = NSDataAsset(name: soundName){
            do{
                try audioPlayer = AVAudioPlayer(data: sound.data)
                audioPlayer.play()
            } catch{
                print("ERROR: file\(soundName) couldn't be played as a sound.")
            }
        } else {
            print("ERROR: file\(soundName) didn't load")
        }
    }
    
}

