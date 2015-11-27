//
//  ViewController.swift
//  UIKitDynamicsWithAutolayout
//
//  Created by Daniel Asher on 27/11/2015.
//  Copyright © 2015 StoryShare. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIDynamicAnimatorDelegate {

    @IBOutlet weak var gameView: UIView!
    var label : UILabel!
    
    lazy var animator: UIDynamicAnimator = {
        let animator = UIDynamicAnimator(referenceView: self.gameView)
        animator.delegate = self
        return animator
        }()  
   
    lazy var gravity:UIGravityBehavior = {
        return UIGravityBehavior()
        }()
    
    lazy var collider:UICollisionBehavior = {
        let collider = UICollisionBehavior()
        collider.translatesReferenceBoundsIntoBoundary = true
        return collider
        }()  
    
    lazy var dynamicItemBehavior:UIDynamicItemBehavior = {
        let behaviour = UIDynamicItemBehavior()
        behaviour.elasticity = 0.8

        // Other configurations
        // behaviour.allowsRotation
        // behaviour.density
        // behaviour.friction
        // behaviour.resistance
        
        return behaviour
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createWordLabel()
        gameView.translatesAutoresizingMaskIntoConstraints = false
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        label.alpha = 1.0
        
        animator.addBehavior(gravity)
        animator.addBehavior(collider)
        
        gravity.addItem(label)
        collider.addItem(label)
    }

    override func updateViewConstraints() {
        let xCenterConstraint = NSLayoutConstraint(item: label, attribute: .CenterX, relatedBy: .Equal, toItem: gameView, attribute: .CenterX, multiplier: 1, constant: 0)
        gameView.addConstraint(xCenterConstraint)
        super.updateViewConstraints()
        print(label.constraints)
        //label.center = gameView.convertPoint(gameView.center, fromView: gameView.superview)
    }

    func createWordLabel() {
        
        label = UILabel(frame: CGRectZero)
        label.alpha = 0.0  
        label.text = "Hello"
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false

        gameView.addSubview(label) 
    }


}

