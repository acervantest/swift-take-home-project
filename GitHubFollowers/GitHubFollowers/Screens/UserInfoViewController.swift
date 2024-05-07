//
//  UserInfoViewController.swift
//  GitHubFollowers
//
//  Created by Alejandro Cervantes on 2024-05-05.
//

import UIKit

class UserInfoViewController: UIViewController {

    let headerView = UIView()
    let itemOneView = UIView()
    let itemTwoView = UIView()
    let dateLabel = GFBodyLabel(textAlignment: .center)
    var itemViews: [UIView] = []
    
    var username: String!
    
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
            
            switch result  {
            case .success(let user):
                DispatchQueue.main.async {
                    self.add(childVC: GFUserInfoHeaderViewController(user: user), to: self.headerView)
                    self.add(childVC: GFRepoItemViewController(user: user), to: self.itemOneView)
                    self.add(childVC: GFFollowerItemViewController(user: user), to: self.itemTwoView)
                    self.dateLabel.text = "Github since \(user.createdAt.convertToMonthYearFormat())"
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
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
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemOneView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemOneView.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemTwoView.topAnchor.constraint(equalTo: itemOneView.bottomAnchor, constant: padding),
            itemTwoView.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemTwoView.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
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
