//
//  UIDynamicsController.swift
//  Animations
//
//  Created by Ilian Konchev on 24.11.17.
//  Copyright © 2017 Ilian Konchev. All rights reserved.
//

import UIKit

class UIDynamicsController: UIViewController {

    var animator: UIDynamicAnimator!
    var itemBehavior: UIDynamicItemBehavior!
    var snapBehavior: UISnapBehavior!
    var snapPosition: CGPoint!

    lazy var square: UIView = {
        let bounds = UIScreen.main.bounds
        let view = UIView(frame: CGRect(x: 0 , y: bounds.height - 200, width: bounds.width, height: bounds.height))
        let handle = UIView(frame: CGRect(x: (bounds.width - 50) / 2, y: 8, width: 50, height: 8))
        handle.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
        handle.layer.cornerRadius = 4
        view.addSubview(handle)
        view.layer.cornerRadius = 12.0
        view.backgroundColor = .white
        view.layer.shadowPath = UIBezierPath(roundedRect: view.bounds , byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 12, height: 12)).cgPath
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = 0.3
        return view
    }()

    let panGR = UIPanGestureRecognizer()
    var panPosition = CGPoint.zero
    var viewPositionOnPanStart = CGPoint.zero

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        panGR.addTarget(self, action: #selector(self.handlePan(_:)))
        square.addGestureRecognizer(panGR)
        view.addSubview(square)

        animator = UIDynamicAnimator(referenceView: view)

        itemBehavior = UIDynamicItemBehavior(items: [square])
        itemBehavior.allowsRotation = false

        snapPosition = CGPoint(x: self.view.center.x, y: 150)
        snapBehavior = UISnapBehavior(item: square, snapTo: snapPosition)
    }


    @objc func handlePan(_ sender: UIPanGestureRecognizer) {
        guard let pannedView = sender.view else { return }
        let location = sender.location(in: self.view)
        switch sender.state {
        case .began:
            animator.removeAllBehaviors()
            panPosition = location
            viewPositionOnPanStart = location
        case .changed:
            let deltaY = panPosition.y - location.y
            pannedView.frame.origin.y = max(150, pannedView.frame.origin.y - deltaY)
            panPosition = location
        case .ended:
            // get the velocity from the gesture recognizer
            var velocity = sender.velocity(in: self.view)
            velocity.x = 0
            itemBehavior.addLinearVelocity(velocity, for: pannedView)
            animator.addBehavior(itemBehavior)

            if viewPositionOnPanStart.y > location.y {
                // expand
                snapPosition.y = 150 + pannedView.bounds.height / 2
            } else {
                // collapse
                snapPosition.y = (view.bounds.height - 200) + (pannedView.bounds.height / 2)
            }
            snapBehavior.snapPoint = snapPosition

            animator.addBehavior(snapBehavior)
            animator.updateItem(usingCurrentState: pannedView)
        default:
            break
        }
    }

}
