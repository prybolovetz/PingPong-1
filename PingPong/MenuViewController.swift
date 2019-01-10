//
//  MenuViewController.swift
//  PingPong
//
//  Created by Ivan on 1/11/19.
//  Copyright © 2019 Ivan. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

enum gameType {
    case easy
    case medium
    case hard
    case player2
}

class MenuViewController : UIViewController {
    
    var player:AVAudioPlayer = AVAudioPlayer()
    
    @IBOutlet   var buttons: [UIButton]!
    
    @IBAction func Player2(_ sender: UIButton) {
        moveToGame(game: .player2)
        sender.pulsate()
    }
    @IBAction func Easy(_ sender: Any) {
        moveToGame(game: .easy)
        
    }
    @IBAction func Medium(_ sender: Any) {
        moveToGame(game: .medium)
        
    }
    @IBAction func Hard(_ sender: Any) {
        moveToGame(game: .hard)
    }
    
    func moveToGame(game : gameType) {
        let gameVC = self.storyboard?.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
        
        currentGameType = game
        
        self.navigationController?.pushViewController(gameVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for button in buttons{
            button.layer.cornerRadius = 25
            button.layer.borderWidth = 6.0
            button.layer.borderColor = (UIColor(red: 235.0/255.0, green: 133.0/255.0, blue: 137.0/255.0, alpha: 1.0)).cgColor
            button.clipsToBounds = true
        }
        
        do
        {
            let audioPath = Bundle.main.path(forResource: "Background", ofType: "mp3")
            try player = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
        }
        catch
        {
            //PROCESS ERROR
        }
        
        let session = AVAudioSession.sharedInstance()
        
        do
        {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        }
        catch
        {
        }
        
        player.play()
        
    }
}

extension UIButton {
    
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.6
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 2
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        
        layer.add(pulse, forKey: "pulse")
    }
}
