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
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    

}