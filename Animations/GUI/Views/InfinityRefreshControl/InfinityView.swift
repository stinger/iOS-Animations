//
//  InfinityView.swift
//  Animations
//
//  Created by Ilian Konchev on 3.12.17.
//  Copyright © 2017 Ilian Konchev. All rights reserved.
//

import UIKit

class InfinityView: UIView {

    let anim = CAAnimationGroup()
    var isAnimating = false

    override var tintColor: UIColor! {
        didSet {
            self.animatedPathLayer.strokeColor = tintColor.cgColor
        }
    }

    lazy var backgroundLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.contentsScale = UIScreen.main.scale
        layer.path = self.backgroundPath.cgPath
        layer.fillColor = UIColor.lightGray.cgColor
        return layer
    }()

    lazy var animatedPathLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.contentsScale = UIScreen.main.scale
        if let tint = self.tintColor {
            layer.strokeColor = tint.cgColor
        } else {
            layer.strokeColor = UIColor.darkGray.cgColor
        }
        layer.lineWidth = 2.0
        layer.lineCap = kCALineCapRound
        layer.fillColor = UIColor(white: 1, alpha: 0.00001).cgColor
        layer.path = self.animatedPath.cgPath
        layer.strokeStart = 0
        layer.strokeEnd = 0.11
        return layer
    }()

    lazy var animatedPath: UIBezierPath = {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 24.68, y: 13.15))
        path.addLine(to: CGPoint(x: 27.21, y: 15.66))
        path.addCurve(to: CGPoint(x: 38.63, y: 15.66), controlPoint1: CGPoint(x: 30.36, y: 18.78), controlPoint2: CGPoint(x: 35.48, y: 18.78))
        path.addCurve(to: CGPoint(x: 38.63, y: 4.34), controlPoint1: CGPoint(x: 41.79, y: 12.53), controlPoint2: CGPoint(x: 41.79, y: 7.47))
        path.addCurve(to: CGPoint(x: 27.21, y: 4.34), controlPoint1: CGPoint(x: 35.48, y: 1.22), controlPoint2: CGPoint(x: 30.36, y: 1.22))
        path.addCurve(to: CGPoint(x: 15.79, y: 15.65), controlPoint1: CGPoint(x: 24.05, y: 7.47), controlPoint2: CGPoint(x: 15.79, y: 15.65))
        path.addCurve(to: CGPoint(x: 4.37, y: 15.66), controlPoint1: CGPoint(x: 12.64, y: 18.78), controlPoint2: CGPoint(x: 7.52, y: 18.78))
        path.addCurve(to: CGPoint(x: 4.37, y: 4.34), controlPoint1: CGPoint(x: 1.21, y: 12.53), controlPoint2: CGPoint(x: 1.21, y: 7.47))
        path.addCurve(to: CGPoint(x: 15.79, y: 4.34), controlPoint1: CGPoint(x: 7.52, y: 1.22), controlPoint2: CGPoint(x: 12.64, y: 1.22))
        path.addLine(to: CGPoint(x: 18.31, y: 6.84))
        return path
    }()


    let backgroundPath: UIBezierPath = {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 26.09, y: 11.73))
        path.addLine(to: CGPoint(x: 28.62, y: 14.24))
        path.addCurve(to: CGPoint(x: 37.23, y: 14.24), controlPoint1: CGPoint(x: 30.99, y: 16.59), controlPoint2: CGPoint(x: 34.85, y: 16.59))
        path.addCurve(to: CGPoint(x: 37.23, y: 5.76), controlPoint1: CGPoint(x: 39.59, y: 11.89), controlPoint2: CGPoint(x: 39.59, y: 8.11))
        path.addCurve(to: CGPoint(x: 28.62, y: 5.76), controlPoint1: CGPoint(x: 34.85, y: 3.41), controlPoint2: CGPoint(x: 30.99, y: 3.41))
        path.addCurve(to: CGPoint(x: 23.51, y: 10.82), controlPoint1: CGPoint(x: 27.53, y: 6.84), controlPoint2: CGPoint(x: 25.76, y: 8.59))
        path.addCurve(to: CGPoint(x: 23.51, y: 10.82), controlPoint1: CGPoint(x: 23.51, y: 10.82), controlPoint2: CGPoint(x: 23.51, y: 10.82))
        path.addCurve(to: CGPoint(x: 19.17, y: 15.12), controlPoint1: CGPoint(x: 22.13, y: 12.19), controlPoint2: CGPoint(x: 20.65, y: 13.66))
        path.addCurve(to: CGPoint(x: 17.74, y: 16.54), controlPoint1: CGPoint(x: 18.34, y: 15.95), controlPoint2: CGPoint(x: 18.34, y: 15.95))
        path.addCurve(to: CGPoint(x: 17.2, y: 17.07), controlPoint1: CGPoint(x: 17.3, y: 16.98), controlPoint2: CGPoint(x: 17.3, y: 16.98))
        path.addCurve(to: CGPoint(x: 2.96, y: 17.08), controlPoint1: CGPoint(x: 13.27, y: 20.97), controlPoint2: CGPoint(x: 6.89, y: 20.97))
        path.addCurve(to: CGPoint(x: 2.96, y: 2.92), controlPoint1: CGPoint(x: -0.99, y: 13.17), controlPoint2: CGPoint(x: -0.99, y: 6.83))
        path.addCurve(to: CGPoint(x: 17.2, y: 2.92), controlPoint1: CGPoint(x: 6.89, y: -0.97), controlPoint2: CGPoint(x: 13.27, y: -0.97))
        path.addLine(to: CGPoint(x: 19.72, y: 5.42))
        path.addLine(to: CGPoint(x: 16.91, y: 8.26))
        path.addLine(to: CGPoint(x: 14.39, y: 5.76))
        path.addCurve(to: CGPoint(x: 5.77, y: 5.76), controlPoint1: CGPoint(x: 12.01, y: 3.41), controlPoint2: CGPoint(x: 8.15, y: 3.41))
        path.addCurve(to: CGPoint(x: 5.77, y: 14.24), controlPoint1: CGPoint(x: 3.41, y: 8.11), controlPoint2: CGPoint(x: 3.41, y: 11.89))
        path.addCurve(to: CGPoint(x: 14.39, y: 14.23), controlPoint1: CGPoint(x: 8.15, y: 16.59), controlPoint2: CGPoint(x: 12.01, y: 16.59))
        path.addCurve(to: CGPoint(x: 14.93, y: 13.7), controlPoint1: CGPoint(x: 14.48, y: 14.14), controlPoint2: CGPoint(x: 14.48, y: 14.14))
        path.addCurve(to: CGPoint(x: 16.36, y: 12.28), controlPoint1: CGPoint(x: 15.52, y: 13.11), controlPoint2: CGPoint(x: 15.52, y: 13.11))
        path.addCurve(to: CGPoint(x: 20.69, y: 7.98), controlPoint1: CGPoint(x: 17.84, y: 10.81), controlPoint2: CGPoint(x: 19.31, y: 9.35))
        path.addCurve(to: CGPoint(x: 20.7, y: 7.98), controlPoint1: CGPoint(x: 20.69, y: 7.98), controlPoint2: CGPoint(x: 20.69, y: 7.98))
        path.addCurve(to: CGPoint(x: 25.8, y: 2.92), controlPoint1: CGPoint(x: 22.95, y: 5.75), controlPoint2: CGPoint(x: 24.71, y: 4))
        path.addCurve(to: CGPoint(x: 40.04, y: 2.92), controlPoint1: CGPoint(x: 29.74, y: -0.97), controlPoint2: CGPoint(x: 36.11, y: -0.97))
        path.addCurve(to: CGPoint(x: 40.04, y: 17.08), controlPoint1: CGPoint(x: 43.99, y: 6.83), controlPoint2: CGPoint(x: 43.99, y: 13.17))
        path.addCurve(to: CGPoint(x: 25.8, y: 17.08), controlPoint1: CGPoint(x: 36.11, y: 20.97), controlPoint2: CGPoint(x: 29.74, y: 20.97))
        path.addLine(to: CGPoint(x: 23.27, y: 14.56))
        path.addLine(to: CGPoint(x: 26.09, y: 11.73))
        path.close()
        return path
    }()

    func forwardAnimations() -> [CABasicAnimation] {
        let start = CABasicAnimation(keyPath: "strokeStart")
        start.fromValue = 0.0
        start.toValue = 1.0
        start.beginTime = 0.1
        start.duration = 0.9

        let end = CABasicAnimation(keyPath: "strokeEnd")
        end.fromValue = 0.0
        end.toValue = 1.0
        end.beginTime = 0.0
        end.duration = 0.9

        return [start, end]
    }

    func reverseAnimations() -> [CABasicAnimation] {
        let start = CABasicAnimation(keyPath: "strokeStart")
        start.fromValue = 1.0
        start.toValue = 0.0
        start.beginTime = 0.0
        start.duration = 0.9

        let end = CABasicAnimation(keyPath: "strokeEnd")
        end.fromValue = 1.0
        end.toValue = 0.0
        end.beginTime = 0.1
        end.duration = 0.9

        return [start, end]
    }

    func setAnimations(forward: Bool = true) {
        anim.animations = forward ? forwardAnimations() : reverseAnimations()
        anim.duration = 1.0
        anim.repeatCount = Float.greatestFiniteMagnitude
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    func setup() {
        backgroundLayer.addSublayer(animatedPathLayer)
        layer.addSublayer(backgroundLayer)
    }

    func animate() {
        if isAnimating == false {
            setAnimations()

            animatedPathLayer.add(anim, forKey: "pathAnim")
            isAnimating = true
        }
    }

    func stopAnimating() {
        if isAnimating {
            if let presentation = animatedPathLayer.presentation() {
                self.animatedPathLayer.strokeStart = presentation.strokeStart
                self.animatedPathLayer.strokeEnd = presentation.strokeEnd
            }
            animatedPathLayer.removeAllAnimations()
            isAnimating = false
        }
    }
}
