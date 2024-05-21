//
//  GFRepoItemViewController.swift
//  GitHubFollowers
//
//  Created by Alejandro Cervantes on 2024-05-06.
//

import Foundation

protocol RepoItemDelegate: AnyObject {
    func didTapGithubProfile(for user: User)
}

class GFRepoItemViewController: GFItemInfoViewController {
    
    weak var delegate: RepoItemDelegate!
    
    init(user: User, delegate: RepoItemDelegate) {
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
        itemInfoViewOne.set(infoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(infoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "Github Profile")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGithubProfile(for: user)
    }
}
