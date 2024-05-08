//
//  GFFollowerItemViewController.swift
//  GitHubFollowers
//
//  Created by Alejandro Cervantes on 2024-05-06.
//

import Foundation

class GFFollowerItemViewController: GFItemInfoViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoViewOne.set(infoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(infoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for: user)
    }
}
