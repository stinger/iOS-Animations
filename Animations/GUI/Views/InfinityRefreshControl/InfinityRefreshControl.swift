//
//  InfinityRefreshControl.swift
//  Animations
//
//  Created by Ilian Konchev on 3.12.17.
//  Copyright © 2017 Ilian Konchev. All rights reserved.
//

import UIKit

class InfinityRefreshControl: UIRefreshControl {

    let infinityView = InfinityView()
    let label = UILabel()

    let triggerGap:CGFloat = 110.0

    override var tintColor: UIColor! {
        didSet {
            label.textColor = tintColor
            infinityView.tintColor = tintColor
        }
    }

    override init() {
        super.init()

        clipsToBounds = true

        infinityView.backgroundColor = .groupTableViewBackground

        label.font = UIFont.systemFont(ofSize: 12.0)
        label.text = "Loading, please wait"
        label.textAlignment = .center
        label.alpha = 0.0
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        if  frame.height <= triggerGap && infinityView.isAnimating == false {
            let progress = min(triggerGap, frame.height) / triggerGap
            infinityView.animatedPathLayer.strokeStart = progress
            infinityView.animatedPathLayer.strokeEnd = progress + 0.11
        }

        if self.frame.height > triggerGap {
            beginRefreshing()
        }
    }

    override func draw(_ rect: CGRect) {
        for subview in subviews {
            subview.removeFromSuperview()
        }

        let originX = ((bounds.size.width / 2) - 21.5)

        let rect = CGRect(origin: CGPoint(x: originX, y: 8), size: CGSize(width: 43, height: 20))
        infinityView.frame = rect

        label.frame = CGRect(origin: CGPoint(x: 12, y: 36), size: CGSize(width: (bounds.size.width - 24), height: 14))

        addSubview(infinityView)
        addSubview(label)
    }

    override func beginRefreshing() {
        super.beginRefreshing()
        label.alpha = 1.0
        infinityView.animate()
    }

    override func endRefreshing() {
        super.endRefreshing()
        label.alpha = 0.0
        infinityView.stopAnimating()
    }


}
