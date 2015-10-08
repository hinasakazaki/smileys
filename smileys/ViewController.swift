//
//  ViewController.swift
//  smileys
//
//  Created by Hina Sakazaki on 10/7/15.
//  Copyright © 2015 Hina Sakazaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var trayOriginalCenter : CGPoint!
    var fingerOriginalCenter : CGPoint!
    var trayCenterWhenOpen : Bool!
    var trayCenterWhenClosed : Bool!
    @IBOutlet var panGestureRecognizer: UIPanGestureRecognizer!
    @IBOutlet weak var trayView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        trayCenterWhenOpen = false
        trayCenterWhenClosed = false
        // Do any additional setup after loading the view, typically from a nib.
        trayOriginalCenter = trayView.center
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTrayGesture(sender: AnyObject) {
        // Absolute (x,y) coordinates in parent view (parentView should be
        // the parent view of the tray)
        let point = panGestureRecognizer.locationInView(self.view)
       
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
            fingerOriginalCenter = point
            print("Gesture began at: \(point)")
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            if (panGestureRecognizer.velocityInView(trayView).y > 0) {
                //move down
                UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                    self.trayView.center = CGPoint(x : self.trayOriginalCenter.x, y: UIScreen.mainScreen().bounds.height + 60) //this is bullshit
                    self.view.layoutIfNeeded()
                    }, completion: nil)
                
            } else {
                //move up
                UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                    self.trayView.center = CGPoint(x : self.trayOriginalCenter.x, y: self.trayOriginalCenter.y) //this makes sense because we are setting original center to original center
                    self.view.layoutIfNeeded()
                    }, completion: nil)
                
 
//                    let translation = CGPoint(x: point.x - fingerOriginalCenter.x, y: point.y - fingerOriginalCenter.y)
//                    trayView.center = CGPoint(x : trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
                
            }
            
            print("Gesture changed at: \(point)")
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            print("Gesture ended at: \(point)")
        }
    }

}

