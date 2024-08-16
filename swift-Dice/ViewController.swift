// ViewController.swift
// swift-Dicee

import UIKit

class ViewController: UIViewController {
  @IBOutlet var diceImageView1: UIImageView!
  @IBOutlet var diceImageView2: UIImageView!
  @IBOutlet var rollButton: UIButton!

  let diceArray = [
    #imageLiteral(resourceName: "DiceOne"),
    #imageLiteral(resourceName: "DiceTwo"),
    #imageLiteral(resourceName: "DiceThree"),
    #imageLiteral(resourceName: "DiceFour"),
    #imageLiteral(resourceName: "DiceFive"),
    #imageLiteral(resourceName: "DiceSix")
  ]

  var animationTimer: Timer?

  @IBAction func rollDice(_ sender: UIButton) {
    startDiceAnimation() // start the animation

    // Stop the animation and set the final dice images after 1 second
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
      self?.stopDiceAnimation()
    }
  }

  // Set what to do when the Main view is loaded
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  func startDiceAnimation() {
    animationTimer?.invalidate() // invalidate previous timers if running

    // Start a timer that changes the dice images every 0.1 seconds
    animationTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
      self?.diceImageView1.image = self?.diceArray.randomElement()
      self?.diceImageView2.image = self?.diceArray.randomElement()
    }
  }

  func stopDiceAnimation() {
    animationTimer?.invalidate()
    animationTimer = nil

    // Set the final dice images
    diceImageView1.image = diceArray.randomElement()
    diceImageView2.image = diceArray.randomElement()
  }
}
