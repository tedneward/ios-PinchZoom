//
//  ViewController.swift
//  PinchZoom
//
//  Created by Ted Neward on 4/20/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var label: UILabel!

  @IBOutlet weak var statusLabel: UILabel!

  var swipeRecognizer : UISwipeGestureRecognizer!
  
  var rotRecgonizer : UIRotationGestureRecognizer!
  var rotationAngleRadians = 0.0 as CGFloat
  
  var pinchRecognizer : UIPinchGestureRecognizer!
  
  var tapRecognizer : UITapGestureRecognizer!
  
  func handleTaps(sender : UITapGestureRecognizer) {
    NSLog("handleTaps: \(sender)")
    let text = "handleTaps: \(sender)"
    statusLabel.text = text
  }
  
  func handlePinches(sender: UIPinchGestureRecognizer) {
    NSLog("handlePinches: sender: \(sender.state) scale: \(sender.scale) velocity \(sender.velocity)")
    
    if sender.state == .Ended {
      if sender.velocity > 0 {
        NSLog("ZOOM ZOOM")
        let currSize = Float(label.font.pointSize)
        label.font = UIFont.systemFontOfSize(CGFloat(currSize * 2.0))
      }
      else {
        let currSize = Float(label.font.pointSize)
        label.font = UIFont.systemFontOfSize(CGFloat(currSize / 2.0))
        NSLog("OW PINCH")
      }
    }
  }
  
  func handleRotations(sender: UIRotationGestureRecognizer) {
    NSLog("handleRotations fired: \(sender)")
    
    label.transform = CGAffineTransformMakeRotation(rotationAngleRadians + sender.rotation)
    
    if sender.state == .Ended {
      rotationAngleRadians += sender.rotation
    }
  }
  
  func handleSwipes(sender: UISwipeGestureRecognizer) {
    switch sender.direction {
    case UISwipeGestureRecognizerDirection.Down:
      label.text = label.text?.lowercaseString
    case UISwipeGestureRecognizerDirection.Left:
      label.text = label.text?.lowercaseString
    case UISwipeGestureRecognizerDirection.Up:
      label.text = label.text?.lowercaseString
    case UISwipeGestureRecognizerDirection.Right:
      label.text = label.text?.lowercaseString
    default:
      label.text = "UNK"
    }
    
  }
  @IBAction func changeDirection(sender: UIButton) {
    view.removeGestureRecognizer(swipeRecognizer)
    
    switch sender.currentTitle! {
      case "Up":
        label.text = "UP"
        swipeRecognizer.direction = .Up
      case "Down":
        label.text = "DOWN"
        swipeRecognizer.direction = .Down
      case "Left":
        label.text = "LEFT"
        swipeRecognizer.direction = .Left
      case "Right":
        label.text = "RIGHT"
        swipeRecognizer.direction = .Right
      default:
        preconditionFailure("Should never happen!")
    }

    swipeRecognizer.numberOfTouchesRequired = 1
    view.addGestureRecognizer(swipeRecognizer)
 }

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    label.font = UIFont.systemFontOfSize(24)
    label.sizeToFit()
    
    statusLabel.lineBreakMode = .ByWordWrapping
    
    swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.handleSwipes(_:)))
    swipeRecognizer.direction = .Left
    swipeRecognizer.numberOfTouchesRequired = 1
    view.addGestureRecognizer(swipeRecognizer)
    
    rotRecgonizer = UIRotationGestureRecognizer(target: self, action: #selector(ViewController.handleRotations(_:)))
    view.addGestureRecognizer(rotRecgonizer)
    
    pinchRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(ViewController.handlePinches(_:)))
    view.addGestureRecognizer(pinchRecognizer)
    
    tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleTaps(_:)))
    tapRecognizer.numberOfTapsRequired = 1
    tapRecognizer.numberOfTouchesRequired = 1
    view.addGestureRecognizer(tapRecognizer)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

