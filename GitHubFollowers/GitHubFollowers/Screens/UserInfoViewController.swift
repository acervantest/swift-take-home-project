//
//  UserInfoViewController.swift
//  GitHubFollowers
//
//  Created by Alejandro Cervantes on 2024-05-05.
//

import UIKit

protocol UserInfoDelegate: AnyObject {
    func didRequestFollowers(for username: String)
}

class UserInfoViewController: GFDataLoadingViewController {

    let headerView = UIView()
    let itemOneView = UIView()
    let itemTwoView = UIView()
    let dateLabel = GFBodyLabel(textAlignment: .center)
    var itemViews: [UIView] = []
    
    var username: String!
   
    weak var delegate: UserInfoDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        layoutUI()
        getUserInfo()
        layoutUI()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissViewController))
        
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async { self.configureUIElements(with: user) }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func configureUIElements(with user: User) {
        
        self.add(childVC: GFUserInfoHeaderViewController(user: user), to: self.headerView)
        self.add(childVC: GFRepoItemViewController(user: user, delegate: self), to: self.itemOneView)
        self.add(childVC: GFFollowerItemViewController(user: user, delegate: self), to: self.itemTwoView)
        
        self.dateLabel.text = "Github since \(user.createdAt.convertToMonthYearFormat())"
    }
    
    func layoutUI() {
        
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        
        itemViews = [ headerView, itemOneView, itemTwoView, dateLabel]
        
        for itemView in itemViews {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 210),
            
            itemOneView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemOneView.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemTwoView.topAnchor.constraint(equalTo: itemOneView.bottomAnchor, constant: padding),
            itemTwoView.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemTwoView.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }

    @objc func dismissViewController() {
        dismiss(animated: true)
    }
}

// MARK: - User Info Delegates

extension UserInfoViewController: RepoItemDelegate {
    
    func didTapGithubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(title: "Invalid URL", message: "The url attached to this user is invalid", buttonTitle:  "Ok")
            return
        }
        
        presentSafariViewController(with: url)
    }
}

extension UserInfoViewController: FollowerItemDelegate {

    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            presentGFAlertOnMainThread(title: "No Followers", message: "This user has no followers.", buttonTitle: "Ok")
            return
        }
        
        delegate.didRequestFollowers(for: user.login)
        dismissViewController()
    }
}
