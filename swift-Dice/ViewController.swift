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

    // Add rounded corners to rollButton
    rollButton.layer.cornerRadius = rollButton.frame.height / 2
    rollButton.clipsToBounds = true
  }

  //  Main Dice Animation
  func startDiceAnimation() {
    animationTimer?.invalidate() // invalidate previous timers if running

    // Start a timer that changes the dice images every 0.1 seconds
    animationTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
      self?.diceImageView1.image = self?.diceArray.randomElement()
      self?.diceImageView2.image = self?.diceArray.randomElement()
    }

    // Shake animation
    addShakeAnimation(to: diceImageView1)
    addShakeAnimation(to: diceImageView2)

    // Scale animation
    addScaleAnimation(to: diceImageView1)
    addScaleAnimation(to: diceImageView2)

    // Rotation animation
    addRotationAnimation(to: diceImageView1)
    addRotationAnimation(to: diceImageView2)
  }

  // Stop Dice Animation
  func stopDiceAnimation() {
    animationTimer?.invalidate()
    animationTimer = nil

    // Set the final dice images
    diceImageView1.image = diceArray.randomElement()
    diceImageView2.image = diceArray.randomElement()

    // Reset the scale (stop scale animation)
    stopScaleAnimation(for: diceImageView1)
    stopScaleAnimation(for: diceImageView2)

    // Stop rotation animation
    stopRotationAnimation(for: diceImageView1)
    stopRotationAnimation(for: diceImageView2)
  }

  // More animations
  func addShakeAnimation(to imageView: UIImageView) {
    let shakeAnimation = CAKeyframeAnimation(keyPath: "transform.rotation")
    shakeAnimation.values = [-0.1, 0.1, -0.1, 0.1, 0.0]
    shakeAnimation.keyTimes = [0, 0.25, 0.5, 0.75, 1]
    shakeAnimation.duration = 0.5
    imageView.layer.add(shakeAnimation, forKey: "shake")
  }

  func addScaleAnimation(to imageView: UIImageView) {
    let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
    scaleAnimation.fromValue = 1.0
    scaleAnimation.toValue = 1.1
    scaleAnimation.duration = 0.1
    scaleAnimation.autoreverses = true
    scaleAnimation.repeatCount = Float.infinity // Repeat indefinitely

    imageView.layer.add(scaleAnimation, forKey: "scaleAnimation")
  }

  func stopScaleAnimation(for imageView: UIImageView) {
    imageView.layer.removeAnimation(forKey: "scaleAnimation")
    imageView.transform = CGAffineTransform.identity // Reset scale
  }

  func addRotationAnimation(to imageView: UIImageView) {
    let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
    rotationAnimation.fromValue = 0
    rotationAnimation.toValue = CGFloat.pi * 2 // Full rotation (360 degrees)
    rotationAnimation.duration = 0.5 // Duration for one rotation
    rotationAnimation.repeatCount = Float.infinity // Repeat indefinitely
    rotationAnimation.timingFunction = CAMediaTimingFunction(name: .linear)

    imageView.layer.add(rotationAnimation, forKey: "rotationAnimation")
  }

  func stopRotationAnimation(for imageView: UIImageView) {
    imageView.layer.removeAnimation(forKey: "rotationAnimation")
    imageView.transform = CGAffineTransform.identity // Reset rotation
  }
}
