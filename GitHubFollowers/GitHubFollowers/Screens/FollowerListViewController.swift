//
//  FollowerListViewController.swift
//  GitHubFollowers
//
//  Created by Alejandro Cervantes on 2024-05-01.
//

import UIKit

class FollowerListViewController: UIViewController {

    var username: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        NetworkManager.shared.getFollowers(for: username!, page: 1) { followers, errorMessage in
            
            guard let followers = followers else {
                self.presentGFAlertOnMainThread(title: "Bad stuff Happened", message: errorMessage!, buttonTitle: "Ok")
                return
            }
            
            print("followers.count = \(followers.count)")
            
            print(followers)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
