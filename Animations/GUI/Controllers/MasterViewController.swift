//
//  MasterViewController.swift
//  Animations
//
//  Created by Ilian Konchev on 24.11.17.
//  Copyright © 2017 Ilian Konchev. All rights reserved.
//

import UIKit

enum Example {
    case uiviewAnimation(title: String), propertyAnimation(title: String), caKeyframe(title: String), caReplication(title: String), uiDynamics(title: String), viewTransition(title: String)
}

class MasterViewController: UITableViewController {

    var objects: [Example] = [
        .uiviewAnimation(title: "UIView animation"),
        .propertyAnimation(title: "UIViewPropertyAnimator"),
        .caKeyframe(title: "CoreAnimation Keyframe"),
        .caReplication(title: "CoreAnimation ReplicationLayer"),
        .uiDynamics(title: "UIDynamics"),
        .viewTransition(title: "View Controller Transitions")
    ]

    let infinityRefresh = InfinityRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupRefreshControl()
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    func setupRefreshControl() {
        infinityRefresh.backgroundColor = .clear
        infinityRefresh.tintColor = .darkGray
        tableView.refreshControl = infinityRefresh
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        switch objects[indexPath.row] {
        case let .uiviewAnimation(title), let .propertyAnimation(title), let .caKeyframe(title), let .caReplication(title), let .uiDynamics(title), let .viewTransition(title):
            cell.textLabel!.text = title
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch objects[indexPath.row]  {
        case .uiviewAnimation(_):
            if let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UIView Animation") as? UIViewAnimationsController {
                showDetailViewController(controller, sender: self)
            }
        case .propertyAnimation(_):
            if let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UIViewPropertyAnimator") as? UIViewPropertyAnimatorController {
                showDetailViewController(controller, sender: self)
            }
        case .caKeyframe(_):
            if let controller = UIStoryboard(name: "CoreAnimation", bundle: nil).instantiateViewController(withIdentifier: "CA Keyframe") as? CoreAnimationKeyframeController {
                showDetailViewController(controller, sender: self)
            }
        case .caReplication(_):
            if let controller = UIStoryboard(name: "CoreAnimation", bundle: nil).instantiateViewController(withIdentifier: "CA ReplicationLayer") as? CoreAnimationReplicationLayerController {
                showDetailViewController(controller, sender: self)
            }
        case .uiDynamics(_):
            if let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UIDynamics") as? UIDynamicsController {
                showDetailViewController(controller, sender: self)
            }
        case .viewTransition(_):
            if let controller = UIStoryboard(name: "Transition", bundle: nil).instantiateViewController(withIdentifier: "Origin") as? TransitionOriginController {
                showDetailViewController(controller, sender: self)
            }
        }
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let refreshing = scrollView.refreshControl?.isRefreshing, refreshing == true else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: { [weak scrollView] in
            scrollView?.refreshControl?.endRefreshing()
        })
    }

}

