//
//  ViewController.swift
//  CatchTheTomGame
//
//  Created by A on 23.03.2023.
//

import UIKit

class ViewController: UIViewController {
    
    //Variables
    var score = 0
    var timer = Timer()
    var counter = 0
    var tomArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    //Views
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var tom1: UIImageView!
    @IBOutlet weak var tom2: UIImageView!
    @IBOutlet weak var tom3: UIImageView!
    @IBOutlet weak var tom4: UIImageView!
    @IBOutlet weak var tom5: UIImageView!
    @IBOutlet weak var tom6: UIImageView!
    @IBOutlet weak var tom7: UIImageView!
    @IBOutlet weak var tom8: UIImageView!
    @IBOutlet weak var tom9: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    scoreLabel.text = "Score: \(score)"
        
        //Highscore check
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highScore")
        
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "HighScore: \(highScore)"
        }
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "Highscore: \(highScore)"
            
        }
        
    //Images
        tom1.isUserInteractionEnabled = true
        tom2.isUserInteractionEnabled = true
        tom3.isUserInteractionEnabled = true
        tom4.isUserInteractionEnabled = true
        tom5.isUserInteractionEnabled = true
        tom6.isUserInteractionEnabled = true
        tom7.isUserInteractionEnabled = true
        tom8.isUserInteractionEnabled = true
        tom9.isUserInteractionEnabled = true

        
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        tom1.addGestureRecognizer(recognizer1)
        tom2.addGestureRecognizer(recognizer2)
        tom3.addGestureRecognizer(recognizer3)
        tom4.addGestureRecognizer(recognizer4)
        tom5.addGestureRecognizer(recognizer5)
        tom6.addGestureRecognizer(recognizer6)
        tom7.addGestureRecognizer(recognizer7)
        tom8.addGestureRecognizer(recognizer8)
        tom9.addGestureRecognizer(recognizer9)
        
        tomArray = [tom1, tom2, tom3, tom4, tom5, tom6, tom7, tom8, tom9]

        //Timers
        counter = 30
        timeLabel.text = String(counter)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideTom), userInfo: nil, repeats: true)
        
        hideTom()
    }
     
    @objc func hideTom() {
        
        for tom in tomArray {
            tom.isHidden = true
        }
        let random = Int(arc4random_uniform(UInt32(tomArray.count - 1)))
        tomArray[random].isHidden = false
        
    }
    
    
    @objc func increaseScore(){
        score += 1
        scoreLabel.text = "Score: \(score)"
        
    }
    @objc func countDown() {
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            for tom in tomArray {
                tom.isHidden = true
            }
            //HighScore
            
            if self.score > self.highScore {
                self.highScore = self.score
                highScoreLabel.text = "Highscore: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highScore")
            }
            
            
            
            //Alert
            
            let alert = UIAlertController(title: "Time's Up", message: "Do you want to again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) {
                (UIAlertAction) in
                //replay function
                self.score = 0
                self.scoreLabel.text = "Score \(self.score)"
                self.counter = 30
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideTom), userInfo: nil, repeats: true)
                
                
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion:  nil)
            
        }
        
    }
}
