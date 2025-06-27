//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var progressBar: UIProgressView!
  
  var timer = Timer()
  var player = AVAudioPlayer()
  
  let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]
  //딕셔너리는 순서 보장 X
  var totalTime = 0
  var passedTime = 0
  
  @IBAction func hardnessSelected(_ sender: UIButton) {
    guard let title = sender.currentTitle else { return }
    guard let totalTime = self.eggTimes[title] else { return }
    
    self.initialize(totalTime: totalTime)
    
    self.timer = Timer.scheduledTimer(
      timeInterval: 1.0,
      target: self,
      selector: #selector(updateTimer),
      userInfo: nil, repeats: true)
  }
  
  private func initialize(totalTime: Int) {
    self.totalTime = totalTime
    self.timer.invalidate()
    self.passedTime = 0
    self.titleLabel.text = " How do you like your eggs?"
  }
  
  
  @objc private func updateTimer() {
    if self.passedTime <= self.totalTime {
      // 0 3
      // 1 3
      // 2 3
      // 3 3
      self.progressBar.progress = Float(passedTime) / Float(totalTime)
      
      if self.passedTime == self.totalTime {
        self.titleLabel.text = "Done"
      }
      
      self.passedTime += 1
    } else {
      // 4 3
      self.timer.invalidate()
      
      //사운드
      guard let url = Bundle.main.url(forResource: "alram_sound", withExtension: "mp3") else { return }
      self.player = try! AVAudioPlayer(contentsOf: url)
      self.player.play()
    }
  }
}
