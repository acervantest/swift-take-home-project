//
//  GFFollowerItemViewController.swift
//  GitHubFollowers
//
//  Created by Alejandro Cervantes on 2024-05-06.
//

import Foundation

protocol FollowerItemDelegate: AnyObject {
    func didTapGetFollowers(for user: User)
}

class GFFollowerItemViewController: GFItemInfoViewController {
    
    weak var delegate: FollowerItemDelegate!
    
    init(user: User, delegate: FollowerItemDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
