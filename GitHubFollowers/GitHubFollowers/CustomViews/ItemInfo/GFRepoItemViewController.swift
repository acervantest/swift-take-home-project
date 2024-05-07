//
//  GFRepoItemViewController.swift
//  GitHubFollowers
//
//  Created by Alejandro Cervantes on 2024-05-06.
//

import Foundation

class GFRepoItemViewController: GFItemInfoViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoViewOne.set(infoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(infoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "Github Profile")
    }
}
